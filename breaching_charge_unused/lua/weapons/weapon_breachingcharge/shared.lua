////////////////////////////////////////////////////////////////
//  Breaching Charge, Weapon
//  Programmed by Sevan Buechele
//  @   Copyright 2018 © Sevan Buechele
//  @   All Rights Reserved.
/////////////////////////////////////////////////////////////

/*|Prevent Item Stack|*/
hook.Add("PlayerCanPickupWeapon","PreventItemStack",function(ply,wep)
	if string.StartWith(wep:GetClass(),"weapon_breachingcharge") then
		if ply:HasWeapon(wep:GetClass()) then
			return false
		end
	end
end)

/*|Weapon Configuration|*/
SWEP.Category		= "Sevan's Weapons"
SWEP.PrintName		= "Breaching Charge"
SWEP.Author			= "Sevan Buechele"
SWEP.Contact		= "STEAM_0:1:65313765"
SWEP.Spawnable		= true
SWEP.AdminOnly		= false
SWEP.WorldModel		= "models/minic23/csgo/breach_charge_detonator.mdl"
SWEP.ViewModelFOV	= 60
SWEP.UseHands		= true
AddCSLuaFile()
SWEP.droppable = false
/*Weapon Initialization|*/
function SWEP:Initialize()
	self.Instructions			=	"Primary fire to detonate. Secondary fire to plant."
	self.AutoSwitchFrom			=	false
	self.Primary.ClipSize		=	-1
	self.Primary.DefaultClip	=	-1
	self.Primary.Automatic		=	false
	self.Primary.Ammo			=	"none"
	self.Secondary.ClipSize		=	-1
	self.Secondary.DefaultClip	=	-1
	self.Secondary.Automatic	=	false
	self.Secondary.Ammo			=	"none"
	self.DrawAmmo				=	false
	self.DrawCrosshair			=	false
	self.Weight					=	300
	self.SwayScale				=	1
	self.BobScale				=	1.2
	self.offset_roll			=	0
	self.offset_pitch			=	0
	self.bombs					=	{}
	self.firstgiven				=	false
	self.reloadclock			=	CurTime()
	self:SetHoldType("slam")
	if CLIENT then
		self.wmodel				=	ClientsideModel("models/minic23/csgo/breach_charge.mdl")
		self.wmodel:SetNoDraw(true)
		self.wmodel2			=	ClientsideModel("models/minic23/csgo/breach_charge_detonator.mdl")
		self.wmodel2:SetNoDraw(true)
		self.wmodel2:SetBodygroup(0,1)
		self.vmodel				=	ClientsideModel("models/minic23/csgo/breach_charge.mdl",RENDERGROUP_VIEWMODEL)
		self.vmodel:SetNoDraw(true)
		self.vmodel2			=	ClientsideModel("models/minic23/csgo/breach_charge_detonator.mdl",RENDERGROUP_VIEWMODEL)
		self.vmodel2:SetNoDraw(true)
		self.vmodel2:SetBodygroup(0,1)
		util.PrecacheModel("models/minic23/csgo/breach_charge.mdl")
	end
	local vmfix = GetConVar("sv_breachingcharge_debughands"):GetInt()
	if vmfix == 1 then
		self.ValveBiped = ""
		self.ViewModel = "models/weapons/v_slam.mdl"
	else
		self.ValveBiped = "ValveBiped."
		self.ViewModel = "models/weapons/c_slam.mdl"
	end
end

/*|Equip|*/
function SWEP:Equip(ply)
	if self.firstgiven == false then
		local ammo = 3
		local cvar = GetConVar("sv_breachingcharge_startingammo")
		if cvar then
			ammo = cvar:GetInt()
		end
		ply:GiveAmmo(ammo,"ammo_breachingcharge")
		self.firstgiven = true
	end
	self.Owner = ply
	self.LOwner = self.Owner
	self:CreatePreview("models/minic23/csgo/breach_charge.mdl",Vector(0,0,0),Angle(0,0,0))
end

/*|Deploy|*/
function SWEP:Deploy()
end

/*|Trigger|*/
function SWEP:PrimaryAttack()
	local didGoBoom = false
	if IsFirstTimePredicted() then
		if SERVER and self.bombs then
			for k,v in pairs(self.bombs) do
				if v:IsValid() then
					v:Explode()
					didGoBoom = true
				end
			end
		end
		self.bombs = {}
		if self.Owner:IsValid() then
			if self.Owner:GetAmmoCount("ammo_breachingcharge") <= 0 then
				self:EmitSound("weapons/pistol/pistol_empty.wav")
			end
		end
		timer.Simple(0, function ()
			if didGoBoom and SERVER and self and IsValid(self) and self.Owner and IsValid(self.Owner) then
				self.Owner:StripWeapon(self:GetClass())
			end
		end)
		self:SetNextPrimaryFire(CurTime()+0.5)
	end
end
function SWEP:SecondaryAttack()
	if IsFirstTimePredicted() then
		local pos,ang = self:GetSelection()
		if pos ~= Vector(0,0,0) and self.Owner:GetAmmoCount("ammo_breachingcharge") > 0 then
			self:EmitSound("npc/combine_soldier/gear5.wav")
			if SERVER then
				local ent = ents.Create("sent_breachingcharge")
				ent:SetPos(pos)
				ent:SetAngles(ang)
				ent:SetModel("models/minic23/csgo/breach_charge.mdl")
				ent:Spawn()
				table.insert(self.bombs,ent)
				if self.doorparent then
					ent:SetParent(self.doorparent)
				elseif self.otherparent then
					ent:SetParent(self.otherparent)
				end
			end
			self.Owner:SetAmmo(math.Clamp(self.Owner:GetAmmoCount("ammo_breachingcharge")-1,0,10),"ammo_breachingcharge")
		end
		self:SetNextSecondaryFire(CurTime()+0.5)
	end
end

/*|Reload|*/
function SWEP:Reload()
	if game.SinglePlayer() == false then
		if IsFirstTimePredicted() then
			self.LOwner = self.Owner
			if SERVER then
				self.Owner:DropWeapon(self)
			end
			self:Holster()
		end
	else
		if self.reloadclock < CurTime() then
			self.Owner:ChatPrint("You cannot drop this in single player.")
			self.reloadclock = CurTime()+1
			if self.Owner:GetAmmoCount("ammo_breachingcharge") < 1 then
				self:Remove()
			end
		end
	end
end

/*|Selection Result|*/
function SWEP:GetSelection()
	local cvar = GetConVar("sv_breachingcharge_canplace"):GetInt()
	local pos,ang = Vector(0,0,0),Angle(0,0,0)
	local trace = self.Owner:GetEyeTrace()
	local ondoor
	if trace.Entity:IsValid() then
		ondoor = (trace.Entity:GetClass() == "func_door" || trace.Entity:GetClass() == "prop_door_rotating" || trace.Entity:GetClass() == "func_door_rotating")
	end
	if ondoor then
		self.doorparent = trace.Entity
	elseif trace.Entity:IsValid() and trace.HitWorld == false then
		self.otherparent = trace.Entity
	end
	if cvar == 1 then
		if !trace.Entity:IsPlayer() then
			if (trace.HitWorld || ondoor || self.otherparent) and trace.HitPos:DistToSqr(self.Owner:GetPos()) <= 10000 then
				pos = trace.HitPos
				ang = trace.HitNormal:Angle()
				ang:RotateAroundAxis(trace.HitNormal:Angle():Forward(),-180)
				ang:RotateAroundAxis(trace.HitNormal:Angle():Right(),90)
			end
		end
	elseif cvar == 2 then
		if (trace.HitWorld || ondoor) and trace.HitPos:DistToSqr(self.Owner:GetPos()) <= 10000 then
			pos = trace.HitPos
			ang = trace.HitNormal:Angle()
			ang:RotateAroundAxis(trace.HitNormal:Angle():Forward(),-180)
			ang:RotateAroundAxis(trace.HitNormal:Angle():Right(),90)
		end
	elseif cvar == 3 then
		if ondoor and trace.HitPos:DistToSqr(self.Owner:GetPos()) <= 10000 then
			pos = trace.HitPos
			ang = trace.HitNormal:Angle()
			ang:RotateAroundAxis(trace.HitNormal:Angle():Forward(),-180)
			ang:RotateAroundAxis(trace.HitNormal:Angle():Right(),90)
		end
	else
		if (trace.HitWorld || ondoor || self.otherparent) and trace.HitPos:DistToSqr(self.Owner:GetPos()) <= 10000 then
			pos = trace.HitPos
			ang = trace.HitNormal:Angle()
			ang:RotateAroundAxis(trace.HitNormal:Angle():Forward(),-180)
			ang:RotateAroundAxis(trace.HitNormal:Angle():Right(),90)
		end
	end
	return pos,ang
end

/*|Viewmodel Reset|*/
function SWEP:Holster()
	if self.Owner:IsValid() and self:IsValid() then
		local vm = self.Owner:GetViewModel()
		if !(vm:IsValid()) then return end
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale(i,Vector(1,1,1))
			vm:ManipulateBoneAngles(i,Angle(0,0,0))
			vm:ManipulateBonePosition(i,Vector(0,0,0))
		end
	end
	self:DeletePreview()
	return true
end
function SWEP:OnRemove()
	if CLIENT then
		self.wmodel:Remove()
		self.wmodel2:Remove()
		self.vmodel:Remove()
	end
	self:PrimaryAttack()
	self:Holster()
end
function SWEP:OwnerChanged()
	if self.LOwner and self:IsValid() then
		local vm = self.LOwner:GetViewModel()
		if !(vm:IsValid()) then return end
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale(i,Vector(1,1,1))
			vm:ManipulateBoneAngles(i,Angle(0,0,0))
			vm:ManipulateBonePosition(i,Vector(0,0,0))
		end
	end
end

/*|Viewmodel Overide|*/
function SWEP:ViewModelDrawn()
	local vm = self.Owner:GetViewModel()
	local righthand = vm:LookupBone(self.ValveBiped.."Bip01_R_Clavicle")
	local lefthand = vm:LookupBone(self.ValveBiped.."Bip01_L_Clavicle")
	local base = vm:LookupBone("Slam_base")
	local deto = vm:LookupBone("Detonator")
	local bonematrix = vm:GetBoneMatrix(vm:LookupBone(self.ValveBiped.."Bip01_R_Hand"))
	vm:ManipulateBonePosition(base,Vector(0,-100,0))
	vm:ManipulateBonePosition(deto,Vector(0,-100,0))
	vm:ManipulateBonePosition(lefthand,Vector(0,-100,0))
	if self.Owner:GetAmmoCount("ammo_breachingcharge") > 0 and bonematrix then
		local offset = self.vmoffset or Vector(6,-1,0)
		local angle = self.vmangle or Angle(120,190,-50)
		local posm,angm = LocalToWorld(offset,angle,bonematrix:GetTranslation(),bonematrix:GetAngles())
		self.vmodel:SetPos(posm)
		self.vmodel:SetAngles(angm)
		self.vmodel:SetModelScale(1.3,0)
		self.vmodel:SetupBones()
		self.vmodel:DrawModel()
	elseif self.Owner:GetAmmoCount("ammo_breachingcharge") <= 0 and bonematrix then
		local offset = self.vmoffset or Vector(3,-2,0)
		local angle = self.vmangle or Angle(180,230,0)
		local posm,angm = LocalToWorld(offset,angle,bonematrix:GetTranslation(),bonematrix:GetAngles())
		self.vmodel2:SetPos(posm)
		self.vmodel2:SetAngles(angm)
		self.vmodel2:SetModelScale(1.6,0)
		self.vmodel2:SetupBones()
		self.vmodel2:DrawModel()
	end
end
function SWEP:GetViewModelPosition(pos,ang)
	if !self.Owner:IsValid() then return end
	if self.Owner:KeyDown(IN_MOVELEFT) then
		self.offset_roll = Lerp(2*RealFrameTime(),self.offset_roll,-12)
	elseif self.Owner:KeyDown(IN_MOVERIGHT) then
		self.offset_roll = Lerp(2*RealFrameTime(),self.offset_roll,6)
	else
		self.offset_roll = Lerp(2*RealFrameTime(),self.offset_roll,0)
	end
	if math.abs(self.offset_roll) < 0.1 then
		self.offset_roll = 0
	end
	if self.Owner:KeyDown(IN_FORWARD) then
		if self.Owner:KeyDown(IN_SPEED) then
			self.offset_pitch = Lerp(2*RealFrameTime(),self.offset_pitch,2)
		else
			self.offset_pitch = Lerp(2*RealFrameTime(),self.offset_pitch,1)
		end
	else
		self.offset_pitch = Lerp(2*0.01,self.offset_pitch,0)
	end
	ang = ang+Angle(self.offset_pitch,0,self.offset_roll)
	if self.Owner:GetAmmoCount("ammo_breachingcharge") <= 0 then
		local vm = self.Owner:GetViewModel()
		local bone = vm:LookupBone(self.ValveBiped.."Bip01_R_Clavicle")
		vm:ManipulateBonePosition(bone,Vector(-1,0,-7))
	else
		ang:RotateAroundAxis(ang:Right(),6)
		local vm = self.Owner:GetViewModel()
		local bone = vm:LookupBone(self.ValveBiped.."Bip01_R_Clavicle")
		vm:ManipulateBonePosition(bone,Vector(-3,0,-6))
	end
	return pos,ang
end
function SWEP:DrawWorldModel()
	if self.Owner:IsValid() then
		local wm = self.Owner
		local bone = wm:LookupBone(self.ValveBiped.."Bip01_R_Hand")
		local bonematrix = wm:GetBoneMatrix(bone)
		if bonematrix then
			local mdl
			local offset
			local angle
			local pos,ang
			if self.Owner:GetAmmoCount("ammo_breachingcharge") <= 0 then
				mdl = self.wmodel2
				offset = self.wmoffset or Vector(2,-2,0)
				angle = self.wmangle or Angle(200,200,-4)
				pos,ang = LocalToWorld(offset,angle,bonematrix:GetTranslation(),bonematrix:GetAngles())
				mdl:SetModelScale(1.6,0)
			else
				mdl = self.wmodel
				offset = self.wmoffset or Vector(6,-5,0)
				angle = self.wmangle or Angle(110,200,-4)
				pos,ang = LocalToWorld(offset,angle,bonematrix:GetTranslation(),bonematrix:GetAngles())
				mdl:SetModelScale(2,0)
			end
			mdl:SetPos(pos)
			mdl:SetAngles(ang)
			mdl:SetupBones()
			mdl:DrawModel()
		end
	else
		if self then
			self:DrawModel()
		end
	end
end

/*|Display Overide|*/
if CLIENT then
	function SWEP:CustomAmmoDisplay()
		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = false
		return self.AmmoDisplay
	end
end

/*|Selection Preview|*/
function SWEP:CreatePreview(mdl,pos,ang)
	util.PrecacheModel(mdl)
	if SERVER and game.SinglePlayer() == false then return end
	if self.PreviewLastDelete and self.PreviewLastDelete + 0.4 > CurTime() then return end
	self:DeletePreview()
	if util.IsValidProp(mdl) then
		if CLIENT then
			self.PreviewEnt = ents.CreateClientProp(mdl)
		else
			self.PreviewEnt = ents.Create("prop_physics")
		end
		if self.PreviewEnt:IsValid() == false then
			self.PreviewEnt = nil
			print("Failed to create preview.")
		end
		self.PreviewEnt:SetModel(mdl)
		self.PreviewEnt:SetModelScale(1.4,0)
		self.PreviewEnt:SetPos(pos)
		self.PreviewEnt:SetAngles(ang)
		self.PreviewEnt:PhysicsInit(SOLID_VPHYSICS)
		self.PreviewEnt:SetNotSolid(true)
		self.PreviewEnt:SetRenderMode(RENDERMODE_TRANSALPHA)
		self.PreviewEnt:SetMoveType(MOVETYPE_NONE)
		self.PreviewEnt:Spawn()
		self.PreviewEnt:SetColor(Color(140,200,255))
		self.PreviewEnt:SetMaterial("models/wireframe")
		self.PreviewEnt:SetNoDraw(true)
	end
end
function SWEP:DeletePreview()
	if self.PreviewEnt then
		if self.PreviewEnt:IsValid() == false then
			self.PreviewEnt = nil
			print("Could not find preview to delete.")
		else
			self.PreviewLastDelete = CurTime()
			self.PreviewEnt:Remove()
			self.PreviewEnt = nil
		end
	end
end
function SWEP:UpdatePreview(ent,ply)
	if ent == nil then return end
	if ent:IsValid() then
		pos,ang = self:GetSelection()
		ent:SetPos(pos)
		ent:SetAngles(ang)
		ent:SetNoDraw(false)
	end
	if self.Owner:GetAmmoCount("ammo_breachingcharge") > 0 then
		return
	else
		ent:SetNoDraw(true)
	end
end
function SWEP:Think()
	if CLIENT then
		if !IsValid(self.PreviewEnt) or self.PreviewEnt:GetModel()!=self.pview then
			self.pview = "models/minic23/csgo/breach_charge.mdl"
			self:CreatePreview(self.pview,Vector(0,0,0),Angle(0,0,0))
		end
		self:UpdatePreview(self.PreviewEnt,self.Owner)
	end
end