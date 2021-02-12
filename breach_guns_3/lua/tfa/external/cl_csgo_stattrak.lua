TFA.CSGO = TFA.CSGO or {}

local CSGO = TFA.CSGO

local sql_Query, sql_QueryValue = sql.Query, sql.QueryValue

sql_Query([[
	CREATE TABLE IF NOT EXISTS tfa_csgo_stattrak (
		class VARCHAR(80) NOT NULL,
		kills INT NOT NULL,
		PRIMARY KEY (class)
	)
]])

local Format, SQLStr = string.format, SQLStr

local StatTrakCache = {}

function CSGO.GetKills(class)
	assert(type(class) == "string", "Invalid class name provided!")

	if not StatTrakCache[class] then
		StatTrakCache[class] = tonumber(sql_QueryValue(Format([[SELECT kills FROM tfa_csgo_stattrak WHERE class = %s]], SQLStr(class)))) or 0
	end

	return StatTrakCache[class]
end

function CSGO.SetKills(class, kills)
	assert(type(class) == "string", "Invalid class name provided!")
	assert(type(kills) == "number", "New kill count must be a number!")

	sql_Query(Format([[REPLACE INTO tfa_csgo_stattrak (class, kills) VALUES (%s, %s)]], SQLStr(class), SQLStr(kills)))

	StatTrakCache[class] = nil

end

function CSGO.IncrementKills(class)
	assert(type(class) == "string", "Invalid class name provided!")

	CSGO.SetKills(class, CSGO.GetKills(class) + 1)
end

do -- old stattrak migration code
	local cv_migrate = CreateClientConVar("cl_tfa_csgo_stattrack_migrate", "1", true, false)

	local function MigrateKills()
		if not cv_migrate:GetBool() then return end

		local targetDir = "tfa_csgo/"

		if not file.Exists(targetDir, "DATA") then return end

		local foundFiles, _ = file.Find(targetDir .. "*_kills.txt", "DATA")

		for _, _file in ipairs(foundFiles) do
			local _, _, class = string.find(_file, "^([%w_]+)_kills%.txt")

			if class then
				local kills = tonumber(file.Read(targetDir .. _file, "DATA"))

				if kills then
					CSGO.SetKills(class, kills)

					file.Delete(targetDir .. _file, "DATA")
				end
			end
		end

		cv_migrate:SetBool(false)
	end

	hook.Add("InitPostEntity", "TFA_CSGO_StatTrak_MigrateOldKills", MigrateKills)
end