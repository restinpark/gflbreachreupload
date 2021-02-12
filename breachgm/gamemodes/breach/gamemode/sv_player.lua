local mply = FindMetaTable( "Player" )


// just for finding a bad spawns :p
function mply:FindClosest(tab, num)
	local allradiuses = {}
	for k,v in pairs(tab) do
		table.ForceInsert(allradiuses, {v:Distance(self:GetPos()), v})
	end
	table.sort( allradiuses, function( a, b ) return a[1] < b[1] end )
	local rtab = {}
	for i=1, num do
		if i <= #allradiuses then
			table.ForceInsert(rtab, allradiuses[i])
		end
	end
	return rtab
end

function mply:GiveRandomWep(tab)
	local mainwep = table.Random(tab)
	self:Give(mainwep)
	local getwep = self:GetWeapon(mainwep)
	if not getwep or not IsValid(getwep) then return end
	if getwep.Primary == nil then
		print("ERROR: weapon: " .. mainwep)
		print(getwep)
		return
	end
	getwep:SetClip1(getwep.Primary.ClipSize)
	self:SelectWeapon(mainwep)
	self:GiveAmmo((math.Round(getwep.Primary.ClipSize * 4.5)), getwep.Primary.Ammo, false)

end

function mply:ReduceKarma(amount)
	if KarmaEnabled() == false then return end
	self.Karma = math.Clamp((self.Karma - amount), 1, MaxKarma())
end

function mply:AddKarma(amount)
	if KarmaEnabled() == false then return end
	self.Karma = math.Clamp((self.Karma + amount), 1, MaxKarma())
end

function mply:SetKarma(amount)
	if KarmaEnabled() == false then return end
	self.Karma = math.Clamp(amount, 1, MaxKarma())
end

function mply:UpdateNKarma()
	if KarmaEnabled() == false then return end
	if self.SetNKarma != nil then
		self:SetNKarma(self.Karma)
	end
end

function mply:SaveKarma()
	if KarmaEnabled() == false then return end
	if SaveKarma() == false then return end
	self:SetPData( "breach_karma", self.Karma )
end


function mply:GiveNTFwep()
	if BR_TFA_GUNS_ENABLED then
		self:GiveRandomWep({"tfa_ins2_mp7", "tfa_ins2_sterling", "tfa_ins2_ump45", "tfa_l4d2_kf2_p90"})
	else
		self:GiveRandomWep({"tfa_csgo_p90", "tfa_csgo_ump45"})
	end
end

function mply:GiveMTFwep()
	if BR_TFA_GUNS_ENABLED then
		self:GiveRandomWep({"tfa_ins2_mp7", "tfa_ins2_sterling", "tfa_ins2_ump45", "tfa_l4d2_kf2_p90"})
	else
		self:GiveRandomWep({"tfa_csgo_p90", "tfa_csgo_ump45"})
	end
end

function mply:GiveCIwep()
	if BR_TFA_GUNS_ENABLED then
		self:GiveRandomWep({"tfa_ak74_sub", "tfa_ins2_mk18", "tfa_ins2_sai_gry", "tfa_ins2_l85a2", "tfa_blr_ar", "tfa_ins2_arx160", "tfa_ins2_sks"})
	else
		self:GiveRandomWep({"tfa_csgo_m4a1", "tfa_csgo_scar20"})
	end
end

function mply:GiveSIGwep()
	if BR_TFA_GUNS_ENABLED then
		self:GiveRandomWep({"tfa_ak74_sub", "tfa_ins2_mk18", "tfa_ins2_sai_gry", "tfa_ins2_l85a2", "tfa_blr_ar", "tfa_ins2_arx160", "tfa_ins2_sks"})
	else
		self:GiveRandomWep({"tfa_csgo_m4a1", "tfa_csgo_scar20", "tfa_csgo_p90", "tfa_csgo_ump45"})
	end
end

function mply:DeleteItems()
	for k,v in pairs(ents.FindInSphere( self:GetPos(), 150 )) do
		if v:IsWeapon() then
			if !IsValid(v.Owner) then
				v:Remove()
			end
		end
	end
end
function mply:GetSciModel(team)
	if team == TEAM_CLASSD then
		if self.brclassdmodel ~= nil and util.IsValidModel(self.brclassdmodel) then
			return self.brclassdmodel
		else
			return "models/player/kerry/class_d_"..math.random(1,7)..".mdl"
		end
	elseif team == TEAM_SCI then

		if self.brscimodel and util.IsValidModel(self.brscimodel) then
			return self.brscimodel
		else
			return "models/player/kerry/class_scientist_"..math.random(1,7)..".mdl"
		end
	end
end

function mply:ENGArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.95)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.95)
	self:SetJumpPower(self.BaseStats.jpower * 0.95)
	self:SetModel("models/materials/humans/group03m/male_08.mdl")
	self.UsingArmor = "armor_eng"
end

function mply:SRArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.95)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.95)
	self:SetJumpPower(self.BaseStats.jpower * 0.95)
	self:SetModel("models/samurai/samurai_player.mdl")
	self.UsingArmor = "armor_sr"
end

function mply:MTFArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.9)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.9)
	self:SetJumpPower(self.BaseStats.jpower * 0.9)
	self:SetModel(MTF_GUARD_MODEL)
	self.UsingArmor = "armor_mtfguard"
end

function mply:FBArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.9)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.9)
	self:SetJumpPower(self.BaseStats.jpower * 0.9)
	self:SetModel("models/player/killingfloordlc/pyro.mdl")
	self.UsingArmor = "armor_mtfguard"
end
function mply:SetSCPHealth(hp)
	if BR_ENABLE_DIFFICULTY then
		local pc = table.Count(GetActivePlayers())
		local mult = BREACH_GetSCPHPMult(pc)
		self:SetHealth(hp * mult)
		self:SetMaxHealth(hp * mult)
	else
		self:SetHealth(hp)
		self:SetMaxHealth(hp)
	end
end
hook.Add("BreachStartRound", "breachstartround_scphealth", function ()
	BroadcastGameMsg("This round's difficulty is " .. tostring(BREACH_GetSCPHPMult(table.Count(GetActivePlayers()))))
end)
function mply:MTFComArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.95)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.95)
	self:SetJumpPower(self.BaseStats.jpower * 0.95)
	self:SetModel(MTF_COMM_MODEL)
	self.UsingArmor = "armor_mtfcom"
end

function mply:NTFArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.9)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.9)
	self:SetJumpPower(self.BaseStats.jpower * 0.9)
	self:SetModel(NTF_ARMOR)
	self.UsingArmor = "armor_ntf"
end

--Best armor, so slowest
function mply:NuArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.8)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.8)
	self:SetJumpPower(self.BaseStats.jpower * 0.8)
	self:SetModel("models/scp/juggernaut_faggot_varus_asshole_penis_moron_benis_anus_dick_cock_ass.mdl")
	self.UsingArmor = "armor_nu"
end
function mply:TauArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.8)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.8)
	self:SetJumpPower(self.BaseStats.jpower * 0.8)
	self:SetModel("models/player/urban.mdl")
	self.UsingArmor = "armor_tau"
end
function mply:RRHArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.95)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.95)
	self:SetJumpPower(self.BaseStats.jpower * 0.95)
	self:SetModel("models/titanfall2_playermodel/kanepm.mdl")
	self.UsingArmor = "armor_rrh"
end
function mply:SHArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.95)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.95)
	self:SetJumpPower(self.BaseStats.jpower * 0.95)
	self:SetModel("models/player/pidorasy.mdl")
	self.UsingArmor = "armor_sh"
end
function mply:ChaosInsArmor()
	self.BaseStats = {
		wspeed = self:GetWalkSpeed(),
		rspeed = self:GetRunSpeed(),
		jpower = self:GetJumpPower(),
		 model = "models/player/guerilla.mdl"
	}
	self:SetWalkSpeed(self.BaseStats.wspeed * 0.9)
	self:SetRunSpeed(self.BaseStats.rspeed * 0.9)
	self:SetJumpPower(self.BaseStats.jpower * 0.9)
	self:SetModel(CHAOS_ARMOR)
	self.UsingArmor = "armor_chaosins"
end
function mply:UnUseArmor()
	if self.UsingArmor == nil then return end
	self:SetWalkSpeed(self.BaseStats.wspeed)
	self:SetRunSpeed(self.BaseStats.rspeed)
	self:SetJumpPower(self.BaseStats.jpower)
	self:SetModel(self.BaseStats.model)
	local item = ents.Create( self.UsingArmor )
	if IsValid( item ) then
		item:Spawn()
		item:SetPos( self:GetPos() + Vector(0,0,30) )
		self:EmitSound( Sound("npc/combine_soldier/zipline_clothing".. math.random(1, 2).. ".wav") )
	end
	self.UsingArmor = nil
end

function mply:SetSpectator()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	hook.Run("ResetPlayerBattery", self)
	self.handsmodel = nil
	self:Spectate(6)
	self:StripWeapons()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SPEC)
	self:SetNoDraw(true)
	self:SetNoCollideWithTeammates(true)
	if self.SetNClass then
		self:SetNClass(ROLE_SPEC)
	end
	self.Active = true
	print("adding " .. self:Nick() .. " to spectators")
	self.canblink = false
	self:AllowFlashlight( false )
	self:SetNoTarget( true )
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self.BaseStats = nil
	self.UsingArmor = nil
	if game.GetMap() == "br_area96" then
		self:SetPos(Vector(-3862.279785, -1940.328491, 74.657768))
	elseif game.GetMap() == "br_area02_v3" then
		self:SetPos(Vector(10098.622070, 3047.961426, -121.642540))
	end
	//self:Spectate(OBS_MODE_IN_EYE)
end

function mply:SetClassD()
if math.random(1, 15) == 1 then
		self:SetClassE()
		return
end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel(self:GetSciModel(TEAM_CLASSD))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_CLASSD)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetClassD9341()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel("models/vinrax/player/d_class_player.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_CLASSD9341)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:Give("weapon_d9341")
	self:SelectWeapon("weapon_d9341")
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetDSpecial()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(table.Random({ROLE_CLASSD9341, ROLE_SCP035, ROLE_CLASSD11424, ROLE_SCP181}))
	if self:GetNClass() == ROLE_SCP181 then
	self:SetModel(self:GetSciModel(TEAM_CLASSD))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_CLASSD11424 then
	self:SetModel(self:GetSciModel(TEAM_CLASSD))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:Give("item_medkit")
	self:Give("weapon_l4d2_crowbar")
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_CLASSD9341 then
	self:SetModel("models/vinrax/player/d_class_player.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:Give("weapon_d9341")
	self:SelectWeapon("weapon_d9341")
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_SCP035 then
	self:SetModel("models/logone/player/035_player.mdl")
	self:SetSCPHealth(250)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(220)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( false )
	self:Give("keycard_en")
	self:Give("tfa_csgo_ak47")
	local w = self:GetWeapon("tfa_csgo_ak47")
	if w and IsValid(w) and w:IsWeapon() and w.SetClip1 then
		w:SetClip1(30)
	end
	self:SelectWeapon("tfa_csgo_ak47")
	self:GiveAmmo( 150, "AR2", true )
	self:Give("item_medkit")
	self.BaseStats = nil
	self.UsingArmor = nil
	end
end

function mply:SetClassE()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSE)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel("models/player/gflbreach/class_e_default.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(table.Random({100, 150}))
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_CLASSE)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:Give("keycard_zm")
	self:Give(table.Random({"tfa_isaactears", "destiny_invective", "weapon_plasmacutter_bread", "weapon_beam"}))
	self:Give("tfa_csgo_glock18")
	self:GiveAmmo(120, "Pistol")
	--Positive Passive Class E Ability
	self:SetNWString("EClassP", table.Random({"a", "u"}))
	--Negative Passive Class E Ability
	self:SetNWString("EClassN", table.Random({"d", "c", "n", "b"}))
	self.WasTeam = TEAM_CLASSE
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	self:PrintMessage(3, "You feel strange...")
end

for k,v in pairs(player.GetAll()) do
		if v:GetNWString("EClassN", "unset") == "d" and v:Team() == TEAM_CLASSE then
			v:SetHealth(75)
			v:SetMaxHealth(75)
			v:PrintMessage(3, "Your suffering from AIDS.")
		end
	end

function mply:SetNobody()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSE)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel(table.Random({"models/player/lanoire_detective.mdl", "models/player/lanoire_gray_detective.mdl"}))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_NOBODY)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:Give("keycard_fm")
	self:Give("weapon_l4d2_crowbar")
	self:Give("item_medkit")
	self:Give("weapon_faton")
	self:Give("tfa_l4d2_rocky_m500")
	self:GiveAmmo(120, "Pistol")
	self:SelectWeapon("weapon_faton")
	self.WasTeam = TEAM_CLASSE
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetAWCY()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSE)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel("models/player/aiden_pearce.mdl")
	self:SetHealth(150)
	self:SetMaxHealth(150)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_AWCY)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:Give("keycard_fm")
	self:Give("weapon_bathwater")
	self:Give("paintball_awcy")
	self:SelectWeapon("paintball_awcy")
	self.WasTeam = TEAM_CLASSE
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP999()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCI)
	self:SetModel("models/scp-999/scp-999.mdl")
	self:SetHealth(2500)
	self:SetMaxHealth(3000)
	self:SetArmor(0)
	self:SetWalkSpeed(235)
	self:SetRunSpeed(235)
	self:SetMaxSpeed(235)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_999)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( false )
	self:Give("weapon_999")
	self:SelectWeapon("weapon_999")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP427()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetModel("models/infected/r2_grim.mdl")
	self:SetHealth(500)
	self:SetMaxHealth(500)
	self:SetArmor(0)
	self:SetWalkSpeed(190)
	self:SetRunSpeed(190)
	self:SetMaxSpeed(190)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetJumpPower(230)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP427)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_scp427")
	self:SelectWeapon("weapon_scp427")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP010()
	self:SetNClass(ROLE_SCP010)
end

function mply:SetSCP2953()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetModel("models/player_eevee.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(280)
	self:SetRunSpeed(280)
	self:SetMaxSpeed(280)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(230)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP2953)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_scp2953")
	self:SelectWeapon("weapon_scp2953")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP2953UP()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetModel("models/protogenridge/protogenridges4.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(300)
	self:SetRunSpeed(300)
	self:SetMaxSpeed(300)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(230)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP2953UP)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_scp2953_up")
	self:SelectWeapon("weapon_scp2953_up")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP2953UPPER()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetNClass(table.Random({ROLE_SCP2953D, ROLE_SCP2953C, ROLE_SCP2953L, ROLE_SCP2953M, ROLE_SCP2953G}))
	if self:GetNClass() == ROLE_SCP2953D then
	self:SetModel("models/bumpattack/arceus/arceus_pm.mdl")
	self:SetHealth(400)
	self:SetMaxHealth(400)
	self:SetArmor(0)
	self:SetWalkSpeed(210)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(210)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:Give("swep_flamethrower_d2k")
	self:SelectWeapon("swep_flamethrower_d2k")
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_SCP2953C then
	self:SetModel("models/stalkertnb/chimera2.mdl")
	self:SetHealth(200)
	self:SetMaxHealth(200)
	self:SetArmor(0)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:Give("weapon_scp_2953_c")
	self:Give("weapon_scp_2953_c")
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_SCP2953L then
	self:SetModel("models/player_leafon.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(220)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(220)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:Give("cat_grasstype")
	self:SelectWeapon("cat_grasstype")
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_SCP2953M then
	self:SetModel("models/tsbb/animals/rat.mdl")
	self:SetHealth(50)
	self:SetMaxHealth(50)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_scp_2953_m")
	self:SelectWeapon("weapon_scp_2953_m")
	self.BaseStats = nil
	self.UsingArmor = nil
	end
	if self:GetNClass() == ROLE_SCP2953G then
	self:SetModel("models/tsbb/animals/goat.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_scp_2953_g")
	self:SelectWeapon("weapon_scp_2953_g")
	self.BaseStats = nil
	self.UsingArmor = nil
	end
end

function mply:SetPlayer1()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(30)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(240)
	self:SetMaxSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_PLAYER1)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_game")
	self:Give("destiny_hardlight")
	self:GiveAmmo(128, "AR2", true)
	self:SelectWeapon("destiny_hardlight")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetPlayer2()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(240)
	self:SetMaxSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_PLAYER2)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_game")
	self:Give("item_medkit")
	self:Give("tfa_l4d2_1887")
	self:GiveAmmo(128, "buckshot", true)
	self:SelectWeapon("tfa_l4d2_1887")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetPlayer3()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(75)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(240)
	self:SetMaxSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_PLAYER3)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self:SetNoTarget( false )
	self:Give("weapon_game")
	self:Give("weapon_physcannon")
	self:Give("weapon_ar2")
	self:GiveAmmo(128, "AR2", true)
	self:Give("weapon_crowbar")
	self:SelectWeapon("weapon_crowbar")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP1315A()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP1315A)
	self:SetModel("models/player/charple.mdl")
	self:SetSCPHealth(300)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_gameover")
	self:Give("weapon_scp_1315a")
	self:SelectWeapon("weapon_scp_1315a")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP1315B()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP1315B)
	self:SetModel("models/deer/deer_player.mdl")
	self:SetSCPHealth(300)
	self:SetArmor(0)
	self:SetWalkSpeed(220)
	self:SetRunSpeed(220)
	self:SetMaxSpeed(220)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_gameover")
	self:Give("weapon_scp_1315b")
	self:SelectWeapon("weapon_scp_1315b")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP1315C()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP1315C)
	self:SetModel("models/player/police.mdl")
	self:SetSCPHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(230)
	self:SetRunSpeed(230)
	self:SetMaxSpeed(230)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_gameover")
	self:Give("weapon_stunstick")
	self:Give("weapon_pistol")
	self:GiveAmmo(128, "Pistol", true)
	self:Give("weapon_smg1")
	self:GiveAmmo(150, "SMG1", false)
	self:SelectWeapon("weapon_pistol")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetChaosScientist()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CHAOS)
	self:SetModel(self:GetSciModel(TEAM_SCI))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_RES)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( false )
	self:Give("keycard_bs")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetScientist()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCI)
	self:SetModel(self:GetSciModel(TEAM_SCI))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_RES)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( false )
	self:Give("keycard_bs")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetBright()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCI)
	self:SetModel(self:GetSciModel(TEAM_SCI))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_DRBRIGHT)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( false )
	self:Give("keycard_zm")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP160()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/yevocore/cat/cat.mdl")
	self:SetSCPHealth(2000)
	self:SetArmor(0)
	self:SetWalkSpeed(230)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(230)
	self:SetJumpPower(200)
	self:SetNoDraw(true)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP160)
	self.Active = true
	self:SetupHands()
	self:SetPos(SPAWN_160)
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self.BaseStats = nil
	self.UsingArmor = nil
	local drone = ents.Create("ent_scp160")
	if IsValid(drone) then
		drone:SetPos(SPAWN_160DRONE)
		drone:Spawn()
		drone:SetOwner(self)
	end
end
function mply:SetCommander()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/riot.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFCOM)
	self.Active = true
	self:Give("keycard_cg")
	self:Give("item_medkit")
	self:Give("weapon_stunstick")
	self:Give("tfa_csgo_mp5sd")
	self:Give("tfa_csgo_revolver")
	local w = self:GetWeapon("tfa_csgo_mp5sd")
	if w and IsValid(w) and w:IsWeapon() and w.SetClip1 then
		w:SetClip1(30)
	end
	self:SelectWeapon("tfa_csgo_mp5sd")
	self:Give("item_radio")

	self:GiveAmmo(150, "SMG1", false)
	self:GiveAmmo(128, "Pistol", true)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:MTFComArmor()
	--self:Give( "ptp_weapon_flash", false )
	--self:SetAmmo( 1, 10 )
end

function mply:SetGuard()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFGUARD)
	self.Active = true
	local cg = math.random(1, 10)
	if cg == 1 then
		self:Give("keycard_sg")
	else
		self:Give("keycard_bg")
	end

	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:GiveMTFwep()
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:MTFArmor()
end

function mply:SetGuardHeavy()
	if math.random(1, 2) == 1 then
		self:SetGuardEngineer()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFGUARDHEAVY)
	self.Active = true
	local cg = math.random(1, 10)
	if cg == 1 then
		self:Give("keycard_sg")
	else
		self:Give("keycard_bg")
	end

	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_csgo_negev")
	self:GiveAmmo(300, "AR2", true)
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:NuArmor()
end

function mply:SetGuardEngineer()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFGUARDENG)
	self.Active = true
	local cg = math.random(1, 10)
	if cg == 1 then
		self:Give("keycard_sg")
	else
		self:Give("keycard_en")
	end

	self:Give("weapon_stunstick")
	self:Give("tfa_csgo_zeus")
	self:Give("item_radio")
	self:Give("weapon_eng")
	self:GiveMTFwep()
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:ENGArmor()
end

function mply:SetGuardMedic()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFGUARDMEDIC)
	self.Active = true
	local cg = math.random(1, 10)
	if cg == 1 then
		self:Give("keycard_sg")
	else
		self:Give("keycard_bg")
	end

	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_medkit")
	self:Give("tfa_csgo_deagle")
	self:GiveAmmo(128, "Pistol", true)
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:MTFArmor()
end

function mply:SetGuard212()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	self:SetModel("models/mailer/bladewolf.mdl")
	self:SetHealth(350)
	self:SetMaxHealth(350)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_212)
	self.Active = true
	self:Give("weapon_212")
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
end

function mply:SetGuardPyro()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFGUARDPYRO)
	self.Active = true
	local cg = math.random(1, 10)
	if cg == 1 then
		self:Give("keycard_sg")
	else
		self:Give("keycard_bg")
	end

	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_kf2rr_flamethrower")
	self:GiveAmmo(400, "AR2")
	self:Give("tfa_csgo_deagle")
	self:GiveAmmo(32, "Pistol", true)
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:MTFArmor()
end
function mply:SetSPCGuard()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/guerilla.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SPCGUARD)
	self.Active = true

	self:Give("weapon_fists")
	if (self:HasWeapon("weapon_fists")) then
		local fists = self:GetWeapon("weapon_fists")
		if fists and IsValid(fists) then
			fists.droppable = false
		end
	end
	self:Give("item_radio")
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
end

hook.Add("EntityTakeDamage", "EntityTakeDamage_SPCBREACH", function (target, dmg)
	local attacker = dmg:GetAttacker()
	if attacker and IsValid(attacker) and attacker:IsPlayer() and attacker:GetNClass() == ROLE_SPCGUARD then
		dmg:ScaleDamage(2.2)
	end
end)

hook.Add("EntityTakeDamage", "SPC_FF", function( target, dmg)
		local attacker = dmg:GetAttacker()
		if attacker and IsValid(attacker) and attacker:IsPlayer() and target:IsPlayer() and target and IsValid(target) and roundtype and roundtype.name == "SPC Breach" and target:GetNClass() == attacker:GetNClass() then 
			return true
		end 
end)

function mply:SetSClass()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_CLASSD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/freeman/player/left_shark.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCLASS)
	self.Active = true

	self:Give("weapon_fists")
	if (self:HasWeapon("weapon_fists")) then
		local fists = self:GetWeapon("weapon_fists")
		if fists and IsValid(fists) then
			fists.droppable = false
		end
	end
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
end

function mply:SetChaosInsurgency(stealth)
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = {
		model = "models/weapons/c_arms_cstrike.mdl",
		body = 10000000,
		skin = 0
	}
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CHAOS)
	self:SetHealth(100)
	self:SetMaxHealth(100)
	
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	local slam = self:Give("weapon_slam")
	slam.droppable = false
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	if stealth == 1 then
		//self:SetModel("models/player/swat.mdl")
		self:MTFArmor()
		self:Give("keycard_bg")
		self:GiveMTFwep()
		self:SetNClass(ROLE_MTFGUARD)
	elseif stealth == 2 then
		//self:SetModel("models/player/urban.mdl")
		self:NTFArmor()
		self:Give("keycard_sg")
		self:GiveNTFwep()
		self:SetNClass(ROLE_MTFNTF)
	else

		self:GiveCIwep()
		self:Give(table.Random({"keycard_sg", "keycard_fm", "keycard_lt"}))
		//self:SetModel("models/mw2/skin_04/mw2_soldier_04.mdl")
		
		if stealth == 3 then
			self:SetNClass(ROLE_MTFNTF)
			self:NTFArmor()
		else
			self:SetNClass(ROLE_CHAOS)
			self:ChaosInsArmor()
		end
	end
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CHAOS
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end
function mply:SetChaosInsCom(spawn)
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = {
		model = "models/weapons/c_arms_cstrike.mdl",
		body = 10000000,
		skin = 0
	}
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	local lpos = self:GetPos()
	if spawn == true then
		self:Spawn()
		self:SetPos(lpos)
	else
		self:Spawn()
	end
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CHAOS)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNoCollideWithTeammates(true)
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(135)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	local slam = self:Give("weapon_slam")
	slam.droppable = false
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_nvg")
	self:Give("weapon_scp_500")
	self:Give("keycard_5")
	self:GiveCIwep()
	self:SetModel(CHAOS_ARMOR)
	self:SetBodyGroups( "1411" )
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CHAOS
	self:SetNClass(ROLE_CHAOSCOM)
	self:SetNoTarget( false )
end
--This is also unused, I will find/kill you if you ever use it ~ Aurora
function mply:SetSiteDirector(spawn)
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	local lpos = self:GetPos()
	if spawn == true then
		self:Spawn()
		self:SetPos(lpos)
	else
		self:Spawn()
	end
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(135)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:Give("item_radio")
	self:Give("keycard_5")
	self:Give("tfa_csgo_deagle")
	self:GiveAmmo(35, "Pistol", false)
	self:SetModel("models/player/breen.mdl")
	self:SetPlayerColor( Vector(0,0,0) )
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNClass(ROLE_SITEDIRECTOR)
	self:SetNoTarget( false )
end

function mply:SetNTF()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFNTF)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:GiveNTFwep()
	self:GiveAmmo(600, "SMG1", false)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:NTFArmor()
end

function mply:SetTau5()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(125)
	self:SetMaxHealth(125)
	self:SetArmor(25)
	self:SetWalkSpeed(265)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(265)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_TAU5)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_hr_swep_needle_rifle")
	local getwep = self:GetWeapon("tfa_hr_swep_needle_rifle")
	if getwep and IsValid(getwep) then
		getwep:SetClip1(getwep.Primary.ClipSize)
		self:SetActiveWeapon(getwep)
	end
	self:GiveAmmo(600, "SMG1", false)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:TauArmor()
end

function mply:SetNu7()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	--Haha modeler funny meme
	self:SetModel("models/scp/juggernaut_faggot_varus_asshole_penis_moron_benis_anus_dick_cock_ass.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFNU)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_csgo_negev")
	local getwep = self:GetWeapon("tfa_csgo_negev")
	if getwep and IsValid(getwep) then
		getwep:SetClip1(getwep.Primary.ClipSize)
		self:SetActiveWeapon(getwep)
	end
	self:GiveAmmo(800, "ar2")
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:NuArmor()
end

function mply:SetClef()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/player/kerry/class_scientist_2.mdl")
	self:SetHealth(150)
	self:SetMaxHealth(150)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_DRCLEF)
	self.Active = true
	self:Give("keycard_5")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_csgo_nova")
	self:SelectWeapon("tfa_csgo_nova")
	self:GiveAmmo(200, "Buckshot")
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end
function mply:SetLambda2()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFL2)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:GiveNTFwep()
	self:GiveAmmo(600, "SMG1", false)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:NTFArmor()
end

function mply:SetEp9()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFFB)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_kf2rr_flamethrower")
	self:Give("tfa_csgo_deagle")
	self:GiveAmmo(800, "AR2")
	self:GiveAmmo(220, "Pistol")
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:FBArmor()
end

function mply:SetSigma1()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/fart/ragdolls/css/counter_sas_player.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFSIG)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_nvg")
	self:Give("item_medkit")
	self:Give("weapon_acidnade")
	self:GiveNTFwep()
	self:GiveAmmo(600, "SMG1", false)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSigma2()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel(table.Random({"models/mw2/skin_04/mw2_soldier_04.mdl", "models/player/pidorasy.mdl"}))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFSIG)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_acidnade")
	self:Give("weapon_nvg")
	self:Give(table.Random({"item_snav_ultimate", "weapon_scp_500"}))
	self:GiveSIGwep()
	self:GiveAmmo(600, "AR2")
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP1959()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/dxn/cod_ghosts/odin/odin_astronaut.mdl")
	self:SetHealth(10000)
	self:SetMaxHealth(10000)
	self:SetArmor(25)
	self:SetWalkSpeed(160)
	self:SetRunSpeed(100)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(160)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP1959)
	self.Active = true
	self:Give("weapon_scp1959")
	self:SelectWeapon("weapon_scp1959")
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP2639A()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_SCI)
	self:SetModel("models/player/quakeguy.mdl")
	self:SetHealth(150)
	self:SetMaxHealth(150)
	self:SetArmor(25)
	self:SetWalkSpeed(250)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(250)
	self:SetJumpPower(220)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_2639A)
	self.Active = true
	self:Give(table.Random({"weapon_q1_shotgun", "weapon_q1_rocketlauncher", "weapon_q1_lightninggun", "weapon_q1_grenadelauncher"}))
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetRRH()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_SCP)
	else
	self:SetTeam(TEAM_GUARD)
	end
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(100)
	hook.Run("ResetPlayerBattery", self)
	self:SetMaxHealth(100)
	self:SetArmor(50)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFRRH)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_nvg")
	self:Give("weapon_scp_500")
	self:Give("aw_bal27")
	self:GiveAmmo(600, "ar2")
	self:SelectWeapon("aw_bal27")
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:RRHArmor()
end
function mply:SetSCPZoo()
if math.random(1,3) == 2 then
		self:SetNTF()
		return
	end
if math.random(1,3) == 2 then
		self:SetLambda2()
		return
	end
if math.random(1,3) == 2 then
		self:SetClef()
		return
	end
if math.random(1,3) == 2 then
		self:SetEp9()
		return
	end
if math.random(1,3) == 2 then
		self:SetNu7()
		return
	end
if math.random(1,3) == 2 then
		self:SetTau5()
		return
	end
if math.random(1,3) == 2 then
		self:SetSigma1()
		return
	end
if math.random(1,3) == 2 then
		self:SetSigma2()
		return
	end
if math.random(1,3) == 2 then
		self:SetCommander()
		return
	end
if math.random(1,3) == 2 then
		self:SetO51()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(100)
	hook.Run("ResetPlayerBattery", self)
	self:SetMaxHealth(100)
	self:SetArmor(50)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFRRH)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_nvg")
	self:Give("weapon_scp_500")
	self:Give("aw_bal27")
	self:GiveAmmo(600, "ar2")
	self:SelectWeapon("aw_bal27")
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:RRHArmor()
end
function mply:SetGuardZoo()
		self:SetSCP1360()
end

function mply:SetFriendZoo()
if math.random(1,3) == 2 then
		self:SetSCP999()
		return
	end
if math.random(1,3) == 2 then
		self:SetSCP035()
		return
	end
if math.random(1,3) == 2 then
		self:SetSCP2639A()
		return
	end
if math.random(1,3) == 2 then
		self:SetSCP939()
		return
	end
if math.random(1,3) == 2 then
		self:SetSCP181()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP0762PB) --Kept the same to maintain compatibility with other scripts
	self:SetModel("models/arachnit/csgo/leet_new/tm_leet_variant_b_player.mdl")
	self:SetHealth(125)
	self:SetMaxHealth(125)
	self:SetArmor(0)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(255)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:GiveNTFwep()
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP017()
if math.random(1,2) == 2 then
		self:SetSCP2301()
		return
	end
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_178_1)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP017)
	self:SetModel("models/player/charple.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(750)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_017")
	self:SelectWeapon("weapon_scp_017")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP3331()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_178_1)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP3331)
	self:SetModel("models/fzone96/johncena/johncena.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(1500)
	self:SetArmor(0)
	self:SetWalkSpeed(250)
	self:SetRunSpeed(250)
	self:SetMaxSpeed(250)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("tf2_combo_fists")
	self:SelectWeapon("tf2_combo_fists")
	self:GiveAmmo(1000, "357", true)
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP038A()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetHealth(75)
	self:SetMaxHealth(75)
	self:SetArmor(0)
	self:SetWalkSpeed(220)
	self:SetRunSpeed(220)
	self:SetMaxSpeed(220)
	self:SetJumpPower(180)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP038A)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP2845()
	if math.random(1, 5) == 2 then
		self:SetSCP011()
		return
	end
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_2845)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP2845)
	self:SetModel("models/deer/deer_player.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(1500)
	self:SetArmor(0)
	self:SetWalkSpeed(165)
	self:SetRunSpeed(165)
	self:SetMaxSpeed(165)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp2845")
	self:SelectWeapon("weapon_scp2845")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP2521()
	ErrorNoHalt("Attempted to spawn removed SCP 2521.\n")
end

function mply:SetSerpentsHand()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_GUARD)
	else
	self:SetTeam(TEAM_SCP)
	end
	self:SetNClass(ROLE_SERPENT)
	self:SetModel("models/player/pidorasy.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give(table.Random({"tfa_csgo_mp5sd", "tfa_csgo_p90", "tfa_csgo_ump45"}))
	self:GiveAmmo(600, "SMG1")
	self:Give("keycard_5")
	self:SelectWeapon("keycard_5")
	self:Give("item_radio")
	self:Give("weapon_stunstick")
	self:Give("weapon_scp_500")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP1861B()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP1861B)
	self:SetModel("models/wheatleymodels/soma/simon_divingsuit.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetHealth(100)
	self:SetArmor(100)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(240)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("tfa_ins2_k98")
	self:GiveAmmo(200, "SniperPenetratedRound")
	self:Give("keycard_fm")
	self:Give("item_radio")
	self:Give("weapon_scp_500")
	self:Give("weapon_leash_rope")
	self:Give("weapon_scp_1861")
	self:SelectWeapon("tfa_ins2_k98")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP1471()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(table.Random(SPAWN_SCIENT))
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP1471)
	self:SetModel("models/burd/scp1471/scp1471.mdl")
	self:SetSCPHealth(1200)
	--b
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp1471")
	self:SelectWeapon("weapon_scp1471")
	self.BaseStats = nil
	self.UsingArmor = nil
end
--
function mply:SetSCP082()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_082)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP082)
	self:SetModel("models/obese_male.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(1450)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(200)
	self:SetJumpPower(170)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("tfa_nmrih_cleaver")
	self:SelectWeapon("tfa_nmrih_cleaver")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP372()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_372)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP372)
	self:SetModel("models/antlion.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(1000)
	self:SetArmor(0)
	self:SetWalkSpeed(185)
	self:SetRunSpeed(185)
	self:SetMaxSpeed(185)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_372")
	self:SelectWeapon("weapon_372")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetRedacted()
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_REDACTED)
	self:SetModel("models/risenshine/red_gang_beast.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetMaxHealth(20)
	self:SetHealth(20)
	self:SetArmor(0)
	self:SetWalkSpeed(270)
	self:SetRunSpeed(220)
	self:SetMaxSpeed(270)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_redacted")
	self:SelectWeapon("weapon_redacted")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetRandom()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/player/zombie_fast.mdl")
	self:SetHealth(1000)
	self:SetMaxHealth(1000)
	self:SetArmor(100)
	self:SetWalkSpeed(260)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(260)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_RANDOM)
	self.Active = true
	self:Give("weapon_random")
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP817()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_682)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/player/Group01/male_05.mdl")
	self:SetHealth(1500)
	self:SetMaxHealth(1500)
	self:SetArmor(1500)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP817)
	self.Active = true
	self:GiveAmmo(1000, "SMG1", true)
	self:GiveAmmo(1000, "AR2", true)
	self:GiveAmmo(1000, "Pistol", true)
	self:GiveAmmo(1000, "AirboatGun", true)
	self:Give("weapon_scp_817")
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP2301()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_178_1)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/players/mj_dbd_sk_realsize.mdl")
	self:SetHealth(1500)
	self:SetMaxHealth(1500)
	self:SetArmor(1500)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP2301)
	self.Active = true
	self:Give("tfa_dmc5_yamato")
	self:SelectWeapon("tfa_dmc5_yamato")
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetGuard2301()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	//self:SetModel("models/player/swat.mdl")
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFGUARD2301)
	self.Active = true
	local cg = math.random(1, 10)
	if cg == 1 then
		self:Give("keycard_sg")
	else
		self:Give("keycard_bg")
	end
	self:Give("item_radio")
	self:GiveMTFwep()
	self:Give("weapon_jackssword")
	self:SelectWeapon("weapon_jackssword")
	self:SetupHands()
	//PrintTable(debug.getinfo( self.SetupHands ))
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	self:SRArmor()
end

function mply:Set05()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCI)
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_05)
	self.Active = true
	self:Give("keycard_5")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("tfa_csgo_deagle")
	self:GiveAmmo(100, "Pistol", true)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end
function mply:SetO51()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	self:SetModel("models/player/nick/scp/site_director/sd.mdl")
	self:SetHealth(200)
	self:SetMaxHealth(200)
	self:SetArmor(100)
	self:SetWalkSpeed(240)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_O51)
	self.Active = true
	self:Give("keycard_5")
	self:Give("weapon_stunstick")
	self:Give("item_O5radio")
	self:Give("tfa_csgo_deagle")
	self:GiveAmmo(100, "Pistol", true)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
end
local hmode = CreateConVar( "br_halloween", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_SERVER_CAN_EXECUTE, FCVAR_REPLICATED}, "Enable various halloween only things (173 pumpkin model, etc)." )
function mply:SetSCP079()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_079)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP079)
	self:SetModel("models/player/kerry/class_scientist_"..math.random(1,7)..".mdl")
	self:SetSCPHealth(400)
	self:SetArmor(0)
	self:SetWalkSpeed(350)
	self:SetRunSpeed(350)
	self:SetMaxSpeed(350)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp079")
	self:SelectWeapon("weapon_scp079")
	print("Telling the client to cache the ents...")
	timer.Simple(60, function()
		if self and IsValid(self) then
			self:SendLua("TBHUD:CacheEnts()") --CBA to do this rigth tbh
		end
	end)
	if HB_SCP079 then
		local hb = ents.Create("br_scp079")
		if IsValid(hb) then
			hb:SetPos(HB_SCP079)
			hb:Spawn()
		end
	else
		ServerLog("Warning! No SCP-079 HB Entity was spawned!\n")
	end
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP173()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_173)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP173)
	if hmode:GetBool() then
		self:SetModel("models/scary173.mdl")
	else
		self:SetModel("models/jqueary/scp/unity/scp173/scp173unity.mdl")
	end
	self:SetSCPHealth(1700)
	self:SetArmor(0)
	self:SetWalkSpeed(350)
	self:SetRunSpeed(350)
	self:SetMaxSpeed(350)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_173")
	self:SelectWeapon("weapon_scp_173")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP1048()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_1048)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_1048)
	self:SetModel("models/1048/tdy/tdybrownpm.mdl")
	self:SetSCPHealth(800)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_1048")
	self:SelectWeapon("weapon_scp_1048")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP1048A()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_049)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP1048A)
	self:SetModel("models/1048/tdyear/tdybrownearpm.mdl")
	self:SetSCPHealth(300)
	self:SetArmor(0)
	self:SetWalkSpeed(155)
	self:SetRunSpeed(155)
	self:SetMaxSpeed(155)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_1048a")
	self:SelectWeapon("weapon_scp_1048a")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end
function mply:SetSCP1048B()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_049)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP1048B)
	self:SetModel("models/1048/tdy/tdybrownpm.mdl")
	self:SetSCPHealth(250)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_1048b")
	self:SelectWeapon("weapon_1048b")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP1048BR()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_049)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP1048BR)
	self:SetModel("models/1048/tdyfetus/1048b.mdl")
	self:SetSCPHealth(350)
	self:SetArmor(0)
	self:SetWalkSpeed(260)
	self:SetRunSpeed(260)
	self:SetMaxSpeed(260)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_1048br")
	self:SelectWeapon("weapon_1048br")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP1048C()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_049)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP1048C)
	self:SetModel("models/1048/tdyfetus/1048b.mdl")
	self:SetSCPHealth(250)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_1048c")
	self:SelectWeapon("weapon_1048c")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP020()
    self:SetBleeding(false)
	self:SetDecomposing(false)
    self.handsmodel = nil
    self:UnSpectate()
    self:GodDisable()
    hook.Run("ResetPlayerBattery", self)
    self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
    self:SetNClass(ROLE_SCP020)
    self:SetModel("models/konnie/kidjason/kidjason.mdl")
    self:SetHealth(100)
    self:SetMaxHealth(100)
    self:SetArmor(0)
    self:SetWalkSpeed(240)
    self:SetRunSpeed(120)
    self:SetMaxSpeed(240)
    self:SetJumpPower(200)
    self:SetNoDraw(false)
    self:SetNoCollideWithTeammates(true)
    self.Active = true
    self:SetupHands()
    self.canblink = false
    self:AllowFlashlight( false )
    self.WasTeam = TEAM_SCP
    self:SetNoTarget( true )
    self.BaseStats = nil
    self.UsingArmor = nil
    net.Start("RolesSelected")
    net.Send(self)
end

function mply:SetSCP178()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_178_1)
	self:StripWeapons()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_178)
	self:SetModel("models/scp178entity/scp178_entity.mdl")
	self:SetSCPHealth(150)
	self:SetArmor(0)
	self:SetWalkSpeed(150)
	self:SetRunSpeed(150)
	self:SetMaxSpeed(150)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_178-1")
	self:SelectWeapon("weapon_178-1")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP0762()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetPos(SPAWN_0762)
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP0762)
	self:SetModel("models/abel/abel.mdl")
	self:SetSCPHealth(1000)
	self:SetArmor(100)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(255)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_0762")
	self:SelectWeapon("weapon_scp_0762")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP0762PB()
	self:SetSCP073()
end

function mply:SetSCP073()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP0762PB) --Kept the same to maintain compatibility with other scripts
	self:SetModel("models/arachnit/csgo/leet_new/tm_leet_variant_b_player.mdl")
	self:SetHealth(125)
	self:SetMaxHealth(125)
	self:SetArmor(0)
	self:SetWalkSpeed(255)
	self:SetRunSpeed(255)
	self:SetMaxSpeed(255)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:GiveNTFwep()
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP1360()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_966)
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP1360)
	self:SetModel("models/child.mdl")
	self:SetHealth(300)
	self:SetMaxHealth(300)
	self:SetArmor(300)
	self:SetWalkSpeed(220)
	self:SetRunSpeed(220)
	self:SetMaxSpeed(220)
	self:SetJumpPower(300)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_1360")
	self:GiveAmmo(100, "SMG1")
	self:GiveAmmo(100, "AR2")
	self:GiveAmmo(30, "Pistol")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP939()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_939)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP939)
	self:SetModel("models/scp/939/unity/unity_scp_939.mdl")
	self:SetSCPHealth(1350)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("scp939")
	self:SelectWeapon("scp939")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP011()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:Spawn()
	self:SetPos(SPAWN_2845)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP011)
	self:SetModel("models/player/dod_american.mdl")
	self:SetSCPHealth(550)
	self:SetArmor(0)
	self:SetWalkSpeed(215)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(215)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("tfa_sim")
	self:SelectWeapon("tfa_sim")
	self:GiveAmmo(1000, "AirboatGun", true)
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCPWW()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_WW)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCPWW)
	self:SetModel("models/sligwolf/rustyrobot/rustyer.mdl")
	self:SetSCPHealth(1730)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_ww")
	self:SelectWeapon("weapon_scp_ww")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetUni()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_2845)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_UNI)
	self:SetModel("models/player/dod_american.mdl")
	self:SetHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(215)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(215)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( true )
	self:Give("tfa_musk")
	self:SelectWeapon("tfa_musk")
	self:GiveAmmo(1000, "AirboatGun", true)
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetConf()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_2845)
	self:SetNClass(ROLE_CONF)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel("models/player/dod_german.mdl")
	self:SetHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(215)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(215)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:SetNoTarget( true )
	self:Give("tfa_musk")
	self:SelectWeapon("tfa_musk")
	self:GiveAmmo(1000, "AirboatGun", true)
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP378()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_966)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP378)
	self:SetModel(SCP_378_MODEL)
	self:SetSCPHealth(600)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetHull(Vector(-16, -16, 0), Vector(16, 16, 72))
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp363")
	self:SelectWeapon("weapon_scp363")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP106()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_106)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP106)
	self:SetModel("models/scp/106/unity/unity_scp_106_player.mdl")
	self:SetSCPHealth(1600)
	self:SetArmor(0)
	self:SetWalkSpeed(165)
	self:SetRunSpeed(165)
	self:SetMaxSpeed(165)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_106")
	self:SelectWeapon("weapon_scp_106")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP966()
	if math.random(1,2) == 2 then
		self:SetSCP378()
		return
	end
	if math.random(1,2) == 2 then
		self:SetSCP1360()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_966)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP966)
	self:SetModel("models/player/mishka/966_new.mdl")
	self:SetSCPHealth(1000)
	self:SetArmor(0)
	self:SetWalkSpeed(165)
	self:SetRunSpeed(165)
	self:SetMaxSpeed(165)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp966")
	self:SelectWeapon("weapon_scp966")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP049()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_049)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP049)
	self:SetModel("models/vinrax/player/scp049_player.mdl")
	self:SetSCPHealth(1400)
	self:SetArmor(0)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetWalkSpeed(160)
	self:SetRunSpeed(160)
	self:SetMaxSpeed(160)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_049")
	self:SelectWeapon("weapon_scp_049")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP3199()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_096)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP3199)
	self:SetModel("models/player/alski/scp3199/scp3199.mdl")
	self:SetSCPHealth(1200)
	self:SetArmor(0)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetWalkSpeed(240)
	self:SetRunSpeed(240)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp3199")
	self:SelectWeapon("weapon_scp3199")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP3199b()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP3199B)
	self:SetModel("models/player/alski/scp3199/scp3199.mdl")
	self:SetSCPHealth(700)
	self:SetArmor(0)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetWalkSpeed(240)
	self:SetRunSpeed(240)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp3199b")
	self:SelectWeapon("weapon_scp3199b")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end

function mply:SetSCP689()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_066)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP689)
	self:SetModel("models/dwdarksouls/models/darkwraith.mdl")
	self:SetSCPHealth(1100)
	self:SetArmor(0)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetWalkSpeed(140)
	self:SetRunSpeed(140)
	self:SetMaxSpeed(140)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp689")
	self:SelectWeapon("weapon_scp689")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP610()

	if math.random(1, 2) == 1 then
		self:SetSCP607()
		return
	end

	self:SetBleeding(false)
	self:SetDecomposing(false)
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_035)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP610)
	self:SetModel("models/player/zombie_fast.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(2500)
	self:SetArmor(0)
	self:SetWalkSpeed(130)
	self:SetRunSpeed(130)
	self:SetMaxSpeed(130)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp610")
	self:SelectWeapon("weapon_scp610")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP610B()
	if self:Team() == TEAM_SPEC or self:Team() == TEAM_SCP then return end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	hook.Run("ResetPlayerBattery", self)
	self:Flashlight( false )
	self.handsmodel = nil
	self:GodDisable()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP610B)
	self:SetModel("models/player/zombie_fast.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(1000)
	self:SetArmor(0)
	self:SetWalkSpeed(130)
	self:SetRunSpeed(130)
	self:SetMaxSpeed(130)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp610b")
	self:SelectWeapon("weapon_scp610b")
	self.BaseStats = nil
	self.UsingArmor = nil
	self.is_reinforcement = true
	self.WINS_WITH = self.WINS_WITH or {}
	self.WINS_WITH[TEAM_SCP] = true
	net.Start("RolesSelected")
	net.Send(self)
	local tid = self:SteamID64() .. "_SCP610Death_" .. tostring(math.random(1, 100000))
	local e = self
	timer.Create(tid, math.random(180, 300), 1, function ()
		if e and IsValid(e) and e:IsPlayer() and e:GetNClass() == ROLE_SCP610B then
			e:SetModel(Model("models/nest/nest.mdl"))
			local e2 = ents.Create("ent_scp_610_infection")
			e2:SetPos(e:GetPos())
			e2:Spawn()
			e2:SetState(true)
			e:Kill()
		end
		hook.Remove("PlayerDeath", tid .. "Remove610Death")
		hook.Remove("BreachEndRound", tid .. "Remove610DeathER")
	end)
	hook.Add("PlayerDeath", tid .. "Remove610Death", function (ply)
		if e and IsValid(e) and e:SteamID() == ply:SteamID() then
			timer.Remove(tid)
		end
	end)
	hook.Add("BreachEndRound", tid .. "Remove610DeathER", function ()
		timer.Remove(tid)
	end)
end
function mply:SetSCP035()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(table.Random(SPAWN_CLASSD))
	self:StripWeapons()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSD)
	self:SetNClass(ROLE_SCP035)
	self:SetModel("models/logone/player/035_player.mdl")
	self:SetSCPHealth(250)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(220)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( false )
	self:Give("keycard_en")
	self:Give("tfa_csgo_ak47")
	local w = self:GetWeapon("tfa_csgo_ak47")
	if w and IsValid(w) and w:IsWeapon() and w.SetClip1 then
		w:SetClip1(30)
	end
	self:SelectWeapon("tfa_csgo_ak47")
	self:GiveAmmo( 250, "AR2", true )
	self:Give("item_medkit")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP181()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	hook.Run("ResetPlayerBattery", self)
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_CLASSD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetModel(self:GetSciModel(TEAM_CLASSD))
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(0)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP181)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_CLASSD
	self:SetNoTarget( false )
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP682()
if math.random(1, 5) == 2 then
		self:SetSCP817()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_682)
	self:StripWeapons()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP682)
	self:SetModel("models/scp_682/scp_682.mdl")
	self:SetSCPHealth(2100)
	self:SetArmor(0)
	self:SetWalkSpeed(100)
	self:SetRunSpeed(100)
	self:SetMaxSpeed(100)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_682")
	self:SelectWeapon("weapon_scp_682")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP4715()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_682)
	self:StripWeapons()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP4715)
	self:SetModel("models/player/pizzaroll/baronofhell.mdl")
	self:SetSCPHealth(2000)
	self:SetArmor(300)
	self:SetWalkSpeed(100)
	self:SetRunSpeed(100)
	self:SetMaxSpeed(100)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp4715")
	self:SelectWeapon("weapon_scp4715")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP066()
if math.random(1, 5) == 2 then
		self:SetSCP011()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetPos(SPAWN_066)
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP066)
	self:SetModel("models/xy/scp/vj_scp066.mdl")
	self:SetSCPHealth(1000)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp066")
	self:SelectWeapon("weapon_scp066")
	self.BaseStats = nil
	self.UsingArmor = nil
end
function mply:SetSCP096()
	if math.random(1, 2) == 2 then
		self:SetSCP3199()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_096)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP096)
	self:SetModel("models/player/scp096.mdl")
	self:SetSCPHealth(800)
	self:SetArmor(0)
	self:SetWalkSpeed(100)
	self:SetRunSpeed(100)
	self:SetMaxSpeed(100)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp096")
	self:SelectWeapon("weapon_scp096")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP096T()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_096)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP096)
	self:SetModel("models/player/scp096.mdl")
	self:SetSCPHealth(5000)
	self:SetArmor(5000)
	self:SetWalkSpeed(100)
	self:SetRunSpeed(100)
	self:SetMaxSpeed(100)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp096t")
	self:SelectWeapon("weapon_scp096t")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP173T()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_096)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_GUARD)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP173)
	if hmode:GetBool() then
		self:SetModel("models/scary173.mdl")
	else
		self:SetModel("models/jqueary/scp/unity/scp173/scp173unity.mdl")
	end
	self:SetSCPHealth(1000)
	self:SetArmor(0)
	self:SetWalkSpeed(350)
	self:SetRunSpeed(350)
	self:SetMaxSpeed(350)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_173t")
	self:SelectWeapon("weapon_scp_173t")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetNu7T()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	hook.Run("ResetPlayerBattery", self)
	self:SetTeam(TEAM_GUARD)
	--Haha modeler funny meme
	self:SetModel("models/player/urban.mdl")
	self:SetHealth(100)
	self:SetMaxHealth(100)
	self:SetArmor(25)
	self:SetWalkSpeed(240)
	self:SetRunSpeed(120)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(240)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_MTFNU)
	self.Active = true
	self:Give("keycard_sg")
	self:Give("weapon_stunstick")
	self:Give("item_radio")
	self:Give("weapon_acid")
	self:Give("item_medkit")
	self:GiveCIwep()
	self:GiveAmmo(600, "AR2", false)
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_GUARD
	self:SetNoTarget( false )
	net.Start("RolesSelected")
	net.Send(self)
	self:NTFArmor()
end

function mply:SetSCP323()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_096)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP323)
	self:SetModel("models/bala/monsterboys.mdl")
	self:SetSCPHealth(1200)
	self:SetArmor(0)
	self:SetWalkSpeed(200)
	self:SetRunSpeed(200)
	self:SetMaxSpeed(200)

	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp323")
	self:SelectWeapon("weapon_scp323")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP457()
	if math.random(1, 2) == 2 and self.SetSCP334 then
		self:SetSCP334()
		return
	end
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_457)
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP457)
	self:SetModel("models/player/corpse1.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(1350)
	self:SetArmor(0)
	self:SetWalkSpeed(175)
	self:SetRunSpeed(175)
	self:SetMaxSpeed(175)
	self:SetJumpPower(250)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp_457")
	self:SelectWeapon("weapon_scp_457")
	self.BaseStats = nil
	self.UsingArmor = nil
end


function mply:SetSCP607()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_035)
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP607)
	self:SetModel("models/yevocore/cat/cat.mdl")
	self:SetSCPHealth(450)
	self:SetArmor(0)
	self:SetWalkSpeed(230)
	self:SetRunSpeed(120)
	self:SetMaxSpeed(230)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp607")
	self:SelectWeapon("weapon_scp607")
	self.BaseStats = nil
	self.UsingArmor = nil
end


function mply:SetSCP334()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:SetPos(SPAWN_457)
	hook.Run("ResetPlayerBattery", self)
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetTeam(TEAM_SCP)
	self:SetNClass(ROLE_SCP334)
	self:SetModel("models/player_flareon.mdl")
	//self:SetMaterial( "models/flesh", false )
	self:SetSCPHealth(800)
	self:SetArmor(0)
	self:SetWalkSpeed(165)
	self:SetRunSpeed(165)
	self:SetMaxSpeed(165)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_scp334")
	self:SelectWeapon("weapon_scp334")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:DropWep(class, clip)
	local wep = ents.Create( class )
	if IsValid( wep ) then
		wep:SetPos( self:GetPos() )
		wep:Spawn()
		if isnumber(clip) then
			wep:SetClip1(clip)
		end
	end
end


function mply:SetSCP0082()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:Spawn()
	self:StripWeapons()
	self:RemoveAllAmmo()
	if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
	self:SetTeam(TEAM_GUARD)
	else
	self:SetTeam(TEAM_SCP)
	end
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetNClass(ROLE_SCP0082)
	self:SetModel("models/scp049/player/049zombie.mdl")
	self:SetSCPHealth(500)
	self:SetArmor(0)
	self:SetWalkSpeed(160)
	self:SetRunSpeed(160)
	self:SetMaxSpeed(160)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	self:Give("weapon_br_zombie_infect")
	self:SelectWeapon("weapon_br_zombie_infect")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP0492()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	hook.Run("ResetPlayerBattery", self)
	self:UnSpectate()
	self:GodDisable()
	self:SetTeam(TEAM_SCP)
	self:SetModel("models/player/zombie_classic.mdl")
	self:SetHealth(500)
	self:SetMaxHealth(500)
	self:SetArmor(0)
	self:SetWalkSpeed(160)
	self:SetRunSpeed(160)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:SetMaxSpeed(160)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self:SetNClass(ROLE_SCP0492)
	self.is_reinforcement = true
	self.WINS_WITH = self.WINS_WITH or {}
	self.WINS_WITH[TEAM_SCP] = true
	self.Active = true
	print("adding " .. self:Nick() .. " to zombies")
	self:SetupHands()
	WinCheck()
	self.canblink = false
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCP
	self:SetNoTarget( true )
	net.Start("RolesSelected")
	net.Send(self)
	if #self:GetWeapons() > 0 then
		local pos = self:GetPos()
		for k,v in pairs(self:GetWeapons()) do
			local wep = ents.Create( v:GetClass() )
			if IsValid( wep ) then
				wep:SetPos( pos )
				wep:Spawn()
				wep:SetClip1(v:Clip1())
			end
			self:StripWeapon(v:GetClass())
		end
	end
	self:Give("weapon_br_zombie")
	self:SelectWeapon("weapon_br_zombie")
	self.BaseStats = nil
	self.UsingArmor = nil
end

function mply:SetSCP990()
	self:SetBleeding(false)
	self:SetDecomposing(false)
	self.handsmodel = nil
	self:UnSpectate()
	self:GodDisable()
	hook.Run("ResetPlayerBattery", self)
	self:Spawn()
	self:SetPos(SPAWN_096)
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self:StripWeapons()
	self:RemoveAllAmmo()
	self:SetTeam(TEAM_SCI)
	self:SetNClass(ROLE_SCP990)
	self:SetModel("models/sirgibs/ragdolls/detective_magnusson_player.mdl")
	self:SetSCPHealth(9999)
	self:SetArmor(0)
	self:SetWalkSpeed(280)
	self:SetRunSpeed(280)
	self:SetMaxSpeed(280)
	self:SetJumpPower(200)
	self:SetNoDraw(false)
	self:SetNoCollideWithTeammates(true)
	self.Active = true
	self:SetupHands()
	self.canblink = true
	self:AllowFlashlight( true )
	self.WasTeam = TEAM_SCI
	self:SetNoTarget( true )
	self:Give("weapon_scp_990")
	self:SelectWeapon("weapon_scp_990")
	self.BaseStats = nil
	self.UsingArmor = nil
	net.Start("RolesSelected")
	net.Send(self)
end


function mply:IsActivePlayer()
	return self.Active
end

hook.Add( "KeyPress", "keypress_spectating", function( ply, key )
	if not ply.GetNClass then
		player_manager.RunClass(ply, "SetupDataTables")
	end
	if ply:Team() != TEAM_SPEC or ply:GetNClass() == ROLE_GHOST then return end
	if ( key == IN_ATTACK ) then
		ply:SpectatePlayerLeft()
	elseif ( key == IN_ATTACK2 ) then
		ply:SpectatePlayerRight()
	elseif ( key == IN_RELOAD ) then
		ply:ChangeSpecMode()
	end
end )

function mply:SpectatePlayerRight()
	if !self:Alive() then return end
	if self:GetObserverMode() != OBS_MODE_IN_EYE and
	   self:GetObserverMode() != OBS_MODE_CHASE
	then return end
	self:SetNoDraw(true)
	local allply = GetAlivePlayers()
	if #allply == 1 then return end
	if not self.SpecPly then
		self.SpecPly = 0
	end
	self.SpecPly = self.SpecPly - 1
	if self.SpecPly < 1 then
		self.SpecPly = #allply
	end
	for k,v in pairs(allply) do
		if k == self.SpecPly then
			self:SpectateEntity( v )
			self.CurSpec = v:SteamID()
		end
	end
end

function mply:SpectatePlayerLeft()
	if !self:Alive() then return end
	if self:GetObserverMode() != OBS_MODE_IN_EYE and
	   self:GetObserverMode() != OBS_MODE_CHASE
	then return end
	self:SetNoDraw(true)
	local allply = GetAlivePlayers()
	if #allply == 1 then return end
	if not self.SpecPly then
		self.SpecPly = 0
	end
	self.SpecPly = self.SpecPly + 1
	if self.SpecPly > #allply then
		self.SpecPly = 1
	end
	for k,v in pairs(allply) do
		if k == self.SpecPly then
			self:SpectateEntity( v )
		end
	end
end

--Spectator hack to draw the hands on viewmodels
local oldSpectateEntity = mply.SpectateEntity
function mply:SpectateEntity(ent)
   oldSpectateEntity(self, ent)

   if IsValid(ent) and ent:IsPlayer() then
      self:SetupHands(ent)
   end
end
function mply:ChangeSpecMode()
	if !self:Alive() then return end
	if !(self:Team() == TEAM_SPEC) then return end
	self:SetNoDraw(true)
	local m = self:GetObserverMode()
	local allply = #GetAlivePlayers()
	if allply < 2 then
		self:Spectate(OBS_MODE_ROAMING)
		return
	end
	if m == OBS_MODE_IN_EYE then
		self:Spectate(OBS_MODE_CHASE)
		self:SpectatePlayerLeft()
	elseif m == OBS_MODE_CHASE then
		self:Spectate(OBS_MODE_ROAMING)
	elseif m == OBS_MODE_ROAMING then
		self:Spectate(OBS_MODE_IN_EYE)
		self:SpectatePlayerLeft()
	else
		self:Spectate(OBS_MODE_ROAMING)
	end

end

function mply:SetBleeding(b_isbleeding)
	if self:Team() == TEAM_SCP or (self.GetNClass and self:GetNClass() == ROLE_999) then
		self:SetNWBool( "is_bleeding", false )
	end
	self:SetNWBool( "is_bleeding", b_isbleeding == true )

	if b_isbleeding == true then
		self:PrintMessage(4, "You are bleeding! You will die soon unless you find a medkit!")
	end
end
function mply:SetDecomposing(b_isdecomposing)
	if self:Team() == TEAM_SCP or (self.GetNClass and self:GetNClass() == ROLE_999) then
		self:SetNWBool( "is_decomposing", false )
	end
	self:SetNWBool( "is_decomposing", b_isdecomposing == true )

	if b_isdecomposing == true then
		self:PrintMessage(4, "Your skin feels like its melting! You will die quickly unless you find a medkit!")
	end
end
--Damage is not affected by armor or any other modifiers
function mply:TakeBleedDamage(amount)
	self:SetHealth(self:Health() - amount)
	if self:Health() <= 0 then
		hook.Run("Breach_DeathByBleeding", self)
		self:Kill()
		self:SetBleeding(false)
	elseif self:Health() <= 30 then
		if math.random(1, 100) < 15 then
			self:PrintMessage(4, "The bleeding has stopped")
			self:SetBleeding(false)
		end
		net.Start("BREACH_294_DRUNK")
		net.WriteInt(1, 8)
		net.Send(self)
	end
end
function mply:TakeDecompDamage(amount)
	self:SetHealth(self:Health() - amount)
	if self:Health() <= 0 then
		hook.Run("Breach_DeathByDecomp", self)
		self:Kill()
		self:SetDecomposing(false)
	elseif self:Health() <= 25 then
		if math.random(1, 100) < 15 then
			self:PrintMessage(4, "The feeling has stopped")
			self:SetDecomposing(false)
		end
		net.Start("BREACH_294_DRUNK")
		net.WriteInt(1, 8)
		net.Send(self)
	end
end
function mply:IsAFK()
	return self:GetInfoNum( "br_spectator", 0 ) == 1 --Let's the user decide whether they're afk or nah
end

function mply:SetAFK(b_afk)
	net.Start("BR_SPECTATOR_UPDATER")
	net.WriteBool(b_afk)
	net.Send(self)
end
