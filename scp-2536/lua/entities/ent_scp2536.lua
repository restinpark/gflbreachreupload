AddCSLuaFile()

ENT.PrintName = "SCP-2536"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Press E to Use."


function ENT:Initialize()
	self:SetModel("models/props_foliage/tree_springers_01a.mdl")
	timer.Simple(5, function()
    self:SetModel("models/props_junk/cardboard_box003a.mdl")
	self:SetMaterial("models/props_c17/FurnitureFabric003a")
	self:SetSolid( SOLID_VPHYSICS )
end)
	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end
end

function ENT:Use(activator, caller)
    if SERVER and caller and IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SPEC then
		if caller:Health() < caller:GetMaxHealth() and caller:Team() != TEAM_SCP then
			caller:Give("weapon_scp_500")
			SafeRemoveEntity(self)
		elseif caller:GetNClass() == ROLE_SERPENT then
			caller:Give("weapon_scp512")
			SafeRemoveEntity(self)
		elseif caller:Health() < caller:GetMaxHealth() and caller:Team() == TEAM_SCP then
			caller:SetHealth(caller:Health() + 500)
			SafeRemoveEntity(self)
		elseif caller:Health() == 100 and math.random(1, 15) == 7 then
			caller:Give("weapon_flesh")
			SafeRemoveEntity(self)
		elseif caller:Health() == 100 and math.random(1, 3) == 2 then
			caller:Give(table.Random({"weapon_cartridge_freeman", "weapon_cartridge_hunter", "weapon_cartridge_shadow"}))
			SafeRemoveEntity(self)
		elseif caller:Team() == TEAM_CLASSD and caller:Health() == 100 then
			caller:Give("keycard_fm")
			SafeRemoveEntity(self)
		elseif caller:Team() == TEAM_CLASSE and caller:Health() == 100 then
			caller:Give("item_o5radio")
			SafeRemoveEntity(self)
		elseif caller:Team() == TEAM_SCI and caller:Health() == 100 then
			caller:Give("item_snav_ultimate")
			SafeRemoveEntity(self)
		elseif caller:Team() == TEAM_GUARD and caller:Health() == 100 then
			caller:Give("item_scp330_blue")
			caller:Give("item_scp330_red")
			caller:Give("item_scp330_yellow")
			SafeRemoveEntity(self)
		elseif caller:Team() == TEAM_CHAOS and caller:Health() == 100 then
			caller:Give("item_scp330_blue")
			caller:Give("item_scp330_red")
			caller:Give("item_scp330_yellow")
			SafeRemoveEntity(self)
		end
	end
end


