AddCSLuaFile()

ENT.Type = "anim"
ENT.AmmoID = 0
ENT.AmmoType = "Pistol"
ENT.PName = "Pistol Ammo"
ENT.AmmoAmount = 1
ENT.MaxUses = 2
ENT.Model = Model( "models/items/boxsrounds.mdl" )

function ENT:Initialize()
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end

function ENT:Use( activator, caller )
	local Allowed = true
	if activator:Team() == TEAM_SPEC then
		Allowed = false
	elseif activator:Team() == TEAM_SCP then
		Allowed = false
	end
	if activator:GetNClass() == ROLE_SCP035 then
		Allowed = true
	end
	if activator:GetNClass() == ROLE_SCP049 then
		Allowed = true
	end
	if activator:GetNClass() == ROLE_SERPENT then
	    Allowed = true
	end
	if activator:GetNClass() == ROLE_SCP1360 then
	    Allowed = true
	end
	if activator:GetNClass() == ROLE_SCP020 then
	    Allowed = true
	end
	if Allowed then
		local gotawep = false
		for k,v in pairs(activator:GetWeapons()) do
			if v.Primary != nil then
				if string.upper(v.Primary.Ammo) == string.upper(self.AmmoType) then
					gotawep = true
				end
			end
		end
		if gotawep == false then
			activator:PrintMessage(HUD_PRINTCENTER, "What are you going to do with this ammo when you dont have a weapon?")
			return
		end
		if activator.MaxUses != nil then
			if self.AmmoID > #activator.MaxUses then
				for i=1, self.AmmoID do
					if activator.MaxUses[i] == nil then
						if i == self.AmmoID then
							table.ForceInsert(activator.MaxUses, 1)
							activator:GiveAmmo(self.AmmoAmount, self.AmmoType, false)
							self:Remove()
						else
							table.ForceInsert(activator.MaxUses, 0)
						end
					end
				end
			else
				if activator.MaxUses[self.AmmoID] >= self.MaxUses then
					activator:PrintMessage(HUD_PRINTCENTER, "You cannot pick-up more ammo")
					return
				else
					activator.MaxUses[self.AmmoID] = activator.MaxUses[self.AmmoID] + 1
					activator:GiveAmmo(self.AmmoAmount, self.AmmoType, false)
					self:Remove()
				end
			end
		else
			activator.MaxUses = {}
			if self.AmmoID != 1 then
				for i=1, self.AmmoID do
					if i == self.AmmoID then
						table.ForceInsert(activator.MaxUses, 1)
					else
						table.ForceInsert(activator.MaxUses, 0)
					end
				end
			else
				table.ForceInsert(activator.MaxUses, 1)
			end
			activator:GiveAmmo(self.AmmoAmount, self.AmmoType, false)
			self:Remove()
		end
	end
end


function ENT:Draw()
	self:DrawModel()
	local ply = LocalPlayer()
	if ply:GetPos():Distance(self:GetPos()) > 200 then
		return
	end
	if IsValid(self) then
		if DrawInfo != nil then
			cam.Start2D()
				DrawInfo(self:GetPos() + Vector(0,0,15), self.PName, Color(255,255,255))
			cam.End2D()
		end
	end
end