AddCSLuaFile()

ENT.PrintName		= "Base Armor"
ENT.Author		    = "Kanade"
ENT.Type			= "anim"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.ArmorType = "armor_mtfguard"
ENT.Stats = 0.85
ENT.model = "models/player/swat.mdl"

function ENT:Initialize()
	self.Entity:SetModel("models/combine_vests/militaryvest.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	//self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_BBOX)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end

	//local phys = self.Entity:GetPhysicsObject()

	//if phys and phys:IsValid() then phys:Wake() end
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end

function ENT:Use(ply)
	if ply.GetNClass and ply:GetNClass() == ROLE_2639A then return end
	if ply:Team() == TEAM_SPEC or ply:Team() == TEAM_SCP or ply:Alive() == false or (ply.GetNClass and ply:GetNClass() == ROLE_999) then return end
	if ply.UsingArmor != nil then
		ply:PrintMessage(HUD_PRINTTALK, 'You already have a vest, type "dropvest" in the chat to drop it')
		return
	end
	if SERVER then
		if ply.BaseStats == nil then
			--Prevent players from storing coffeespeed
			if ply.BR_HasSpeedBoost and _scp294RemoveCoffee then
				_scp294RemoveCoffee(ply)
			end

			ply.BaseStats = {
				wspeed = ply:GetWalkSpeed(),
				rspeed = ply:GetRunSpeed(),
				jpower = ply:GetJumpPower(),
				 model = ply:GetModel()
			}
		end
		ply:SetWalkSpeed(ply.BaseStats.wspeed * self.Stats)
		ply:SetRunSpeed(ply.BaseStats.rspeed * self.Stats)
		ply:SetJumpPower(ply.BaseStats.jpower * self.Stats)
		ply:SetModel(self.model)
		ply.UsingArmor = self.ArmorType
		self:EmitSound( Sound("npc/combine_soldier/zipline_clothing".. math.random(1, 2).. ".wav") )
		self:Remove()
	end
	if CLIENT then
		chat.AddText('You are now wearing an armor, type "dropvest" in the chat to drop it')
	end
	ply.UsingArmor = self.ArmorType
end

function ENT:Draw()
	self:DrawModel()
	local ply = LocalPlayer()
	if ply:GetPos():Distance(self:GetPos()) > 180 then
		return
	end
	if IsValid(self) then
		cam.Start2D()
			if DrawInfo != nil then
				DrawInfo(self:GetPos() + Vector(0,0,15), self.PrintName, Color(255,255,255))
			end
		cam.End2D()
	end
end
