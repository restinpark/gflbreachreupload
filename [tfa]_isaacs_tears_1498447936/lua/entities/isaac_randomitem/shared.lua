ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Random Item"
ENT.Category = "Isaac Tears"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.Class = ""
ENT.MyModel = "models/props_wasteland/rockgranite03c.mdl"
ENT.DrawPosition = Vector(2, 1.5, -13)
ENT.DrawAngles = Vector(90, 90, 120)

if SERVER then
	AddCSLuaFile()
end

function ENT:Initialize()
	local model = self.MyModel
	self.Class = self:GetClass()
	self:SetModel(model)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)
	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self:SetAngles(self:GetAngles()+Angle(180,0,0))
	self:SetPos(self:GetPos()-Vector(0,0,0))
	self.RandomID = table.Random(TFABOI.Items2)
	self:SetNW2Int("RandomID", self.RandomID.Num)
end

function ENT:StartTouch(activator, caller)
	if IsValid(activator) and activator:IsPlayer() and activator:GetActiveWeapon():GetClass() == "tfa_isaactears" then
		self:EmitSound(Sound("weapons/isaactears/pickup.wav"))
		net.Start("IsaacTears_Pickup_Client")
		net.WriteEntity(activator:GetActiveWeapon())
		net.WriteInt(self.RandomID.ID, 32)
		net.Send(activator)
		self:Remove()
	end
end

if CLIENT then
	function ENT:Initialize()
		self.Class = self:GetClass()
		self.MaterialSprite = Material("isaactears/vgui/items/"..(self:GetNW2Int("RandomID"))..".png" )
	end

	function ENT:Draw()
		self:DrawModel()

		local pos = self:GetPos() + (self:GetUp() * self.DrawPosition.z)
		local ang = Angle( 0, (LocalPlayer():GetPos() - self:GetPos()):Angle()[2], 0)
		
		ang:RotateAroundAxis(ang:Right(), self.DrawAngles.x)
		ang:RotateAroundAxis(ang:Up(), self.DrawAngles.y)
		ang:RotateAroundAxis(ang:Forward(), self.DrawAngles.z)

		cam.Start3D2D(pos, ang, .1)
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( self.MaterialSprite )
		surface.DrawTexturedRect( -128, -128, 256, 256 )
		cam.End3D2D()
	end
end
