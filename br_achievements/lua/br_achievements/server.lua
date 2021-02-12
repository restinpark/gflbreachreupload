ACHIEVEMENTS = {}
ACHIEVEMENTS.ACHIEVEMENT_LIST = include("achievements.lua")

util.AddNetworkString("SendAchievementData")
util.AddNetworkString("NotifyAchievementProgress")
util.AddNetworkString("NotifyAchievementUnlocked")
util.AddNetworkString("AnnounceAchievement")
if not file.IsDir("breach_achievements", "DATA") then
    file.CreateDir("breach_achievements")
end

hook.Add("PlayerInitialSpawn", "PlayerInitAchievements", function (ply)
    ServerLog(string.format("[Breach Achievements] Loading data for %s.\n", ply:SteamID64()))
    local f = file.Read( "breach_achievements/" .. ply:SteamID64() .. ".dat", "DATA" )
    if not f then
        ServerLog(string.format("[Breach Achievements] No data found for %s.\n", ply:SteamID64()))
        ply.achievements = {}
        f = util.Compress(util.TableToJSON(ply.achievements))
        ply:SaveAchievements()
    else
        local json = util.Decompress(f)
        if not json then
            ServerLog(string.format("[Breach Achievements] Invalid compressed data for %s.\n", ply:SteamID64()))
            ply.achievements = {}
            ply:SaveAchievements()
        else
            ply.achievements = util.JSONToTable(json)
            if not ply.achievements then
                ServerLog(string.format("[Breach Achievements] Invalid json for %s.\n", ply:SteamID64()))
                ply.achievements = {}
                ply:SaveAchievements()
            end
        end
    end
    net.Start("SendAchievementData")
    net.WriteUInt(string.len(f), 32)
    net.WriteData(f, string.len(f))
    net.Send(ply)
end)

local mply = FindMetaTable("Player")

function mply:SaveAchievements()
    if self.achievements and istable(self.achievements) then
        file.Write( "breach_achievements/" .. self:SteamID64() .. ".dat", util.Compress( util.TableToJSON(self.achievements)))
        ServerLog("[Breach Achievements] Saved achievement data for " .. self:SteamID64())
    end
end

--TODO: If delay key is set, we need to delay the announcement until the end of the round

function mply:GiveAchievement(achievement)
    if not ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement] then
        ServerLog("Could not give " .. self:Nick() .. " an achievement: No such achievement " .. achievement .. "\n")
        return
    end
    if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].name and ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].description then
        if self.achievements[achievement] and self.achievements[achievement].status and self.achievements[achievement].status == "unlocked" then
            --Already has achievement
            return
        else
            net.Start("NotifyAchievementUnlocked")
            net.WriteString(achievement)
            net.Send(self)
            if self.GiveScaledPointsBreach then
                self:GiveScaledPointsBreach(500, "Unlocked achievement " .. ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].name, true)
            end
            if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].delay then
                local ply = self
                local acv = achievement
                local key = "DelayAchievement_" .. self:SteamID64() .. ":" .. achievement .. tostring(math.random(1,10000))
                hook.Add("BreachEndRound", key, function ()
                    if ply and IsValid(ply) and ply:IsPlayer() then
                        net.Start("AnnounceAchievement")
                        net.WriteString(acv)
                        net.WriteString(ply:Nick())
                        net.Broadcast()
                    end
                    hook.Remove("BreachEndRound", key)
                end)
            else
                net.Start("AnnounceAchievement")
                net.WriteString(achievement)
                net.WriteString(self:Nick())
                net.Broadcast()
            end
            self.achievements[achievement] = self.achievements[achievement] or {}
            self.achievements[achievement].status = "unlocked"
            self:SaveAchievements()
        end
    else
        ServerLog("Could not give " .. self:Nick() .. " an achievement: Achievement " .. achievement .. " lacks a name or description.\n")
        return
    end
end


function mply:AddAchievementProgress(achievement, progress)
    if not ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement] then
        ServerLog("Could not give " .. self:Nick() .. " achievement progress: No such achievement " .. achievement .. "\n")
        return
    end
    if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].name and ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].description then
        if self.achievements[achievement] and self.achievements[achievement].status and self.achievements[achievement].status == "unlocked" then
            --Already has achievement
            return
        else
            if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].hasProg then
                local y = progress
                if self.achievements[achievement] and self.achievements[achievement].progress then
                    local x = tonumber(self.achievements[achievement].progress)
                    y = x + progress
                    if x + progress >= ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].goal then
                        y = ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].goal
                    end
                end
                self.achievements[achievement] = self.achievements[achievement] or {}
                self.achievements[achievement].progress = tostring(y)
                if y == ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].goal then
                    self.achievements[achievement].status = "unlocked"
                    net.Start("NotifyAchievementUnlocked")
                    net.WriteString(achievement)
                    net.Send(self)
                     if self.GiveScaledPointsBreach then
                        self:GiveScaledPointsBreach(500, "Unlocked achievement " .. ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].name, true)
                    end
                    if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].delay then
                        local ply = self
                        local acv = achievement
                        local key = "DelayAchievement_" .. self:SteamID64() .. ":" .. achievement .. tostring(math.random(1,10000))
                        hook.Add("BreachEndRound", key, function ()
                            if ply and IsValid(ply) and ply:IsPlayer() then
                                net.Start("AnnounceAchievement")
                                net.WriteString(acv)
                                net.WriteString(ply:Nick())
                                net.Broadcast()
                            end
                            hook.Remove("BreachEndRound", key)
                        end)
                    else
                        net.Start("AnnounceAchievement")
                        net.WriteString(achievement)
                        net.WriteString(self:Nick())
                        net.Broadcast()
                    end
                else
                    net.Start("NotifyAchievementProgress")
                    net.WriteString(achievement)
                    net.WriteUInt(ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].goal, 32)
                    net.WriteUInt(y, 32)
                    net.Send(self)
                end
                self:SaveAchievements()
            else
                ServerLog("Could not give " .. self:Nick() .. " achievement progress: Achievement " .. achievement .. " does not use progress.\n")
                return
            end
        end
    else
        ServerLog("Could not give " .. self:Nick() .. " achievement progress: Achievement " .. achievement .. " lacks a name or description.\n")
        return
    end
end

--This is for persistent storage more advanced than what progress would provide
--CAN ONLY STORE THINGS AS STRINGS, KEYS MUST ALSO BE STRINGS
function mply:AddAchievementMetadata(achievement, key, value)
    if not ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement] then
        ServerLog("Could not set metadata: No such achievement " .. achievement .. "\n")
        return
    end
    if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].name and ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].description then
        if self.achievements[achievement] and self.achievements[achievement].status and self.achievements[achievement].status == "unlocked" then
            --Already has achievement
            return
        else
            self.achievements[achievement] = self.achievements[achievement] or {}
            self.achievements[achievement].metadata = self.achievements[achievement].metadata or {}
            self.achievements[achievement].metadata[tostring(key)] = tostring(value)
            self:SaveAchievements()
        end
    else
        ServerLog("Could not set metadata: Achievement " .. achievement .. " lacks a name or description.\n")
        return
    end
end

function mply:GetAchievementMetadata(achievement, key, fallback)
    if not ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement] then
        ServerLog("Could not get metadata: No such achievement " .. achievement .. "\n")
        return fallback, false
    end
    if ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].name and ACHIEVEMENTS.ACHIEVEMENT_LIST[achievement].description then
        if not self.achievements[achievement] then
            self.achievements[achievement] = {}
        end
        if self.achievements[achievement].metadata and self.achievements[achievement].metadata[tostring(key)] then
            return self.achievements[achievement].metadata[tostring(key)], true
        end
    else
        ServerLog("Could not set metadata: Achievement " .. achievement .. " lacks a name or description.\n")
        return fallback, false
    end
    return fallback, true
end

--This is what actually determines when achievements are rewarded, progress is granted.
include("sv_achievementlogic.lua")