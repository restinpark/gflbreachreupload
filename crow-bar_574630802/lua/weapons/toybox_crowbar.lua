if ( SERVER ) then
AddCSLuaFile()
end
SWEP.Author			= "Jvs.Recreated by Hds46"
SWEP.Instructions	= "Left Click - Swing. \nRight Click - Fly."
SWEP.Contact            = ""
SWEP.Spawnable			= true
SWEP.HoldType           = "melee"
SWEP.AdminSpawnable		= false
SWEP.AdminOnly          = false
SWEP.ViewModel			= "models/weapons/c_crowbar.mdl"
SWEP.WorldModel			= "models/weapons/w_crowbar.mdl"
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "None"



SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "None"
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= true
SWEP.Category           = "Toybox sweps"
SWEP.PrintName			= "Crow-Bar"			
SWEP.Slot			= 0
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {}
SWEP.VElements = {
	["crow"] = { type = "Model", model = "models/crow.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.794, 2.022, -7.900), angle = Angle(0, 0, 180), size = Vector(1.400, 1.400, 1.650), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["crow"] = { type = "Model", model = "models/crow.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.4, 2.483, -17.700), angle = Angle(6.225, 17.135, 179.833), size = Vector(1.400, 1.400, 1.400), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.CrowFitThink = 0
SWEP.CrowTired = 0

if CLIENT then
SWEP.IconLetter  = "x"
SWEP.WepSelectIcon      = Material("crowbar_img.png")
SWEP.BounceWeaponIcon   = false

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	-- Set us up the texture
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( self.WepSelectIcon )
	
	-- Lets get a sin wave to make it bounce
	local fsin = 0
	
	if ( self.BounceWeaponIcon == true ) then
		fsin = math.sin( CurTime() * 10 ) * 5
	end
	
	-- Borders
	y = y + 10
	x = x + 10
	wide = wide - 20
	
	-- Draw that mother
	surface.DrawTexturedRect( x + (fsin), y - (fsin),  wide-fsin*2 , ( wide / 2 ) + (fsin) )
	
	-- Draw weapon info box
	self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end
end

/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
end


/*---------------------------------------------------------
	Think
---------------------------------------------------------*/
function SWEP:Think()
if self.Owner:KeyReleased( IN_ATTACK2 ) then
	if ( self.Flying ) then 
	self.Flying:ChangeVolume( 0, 0.02 ) 
	self.Flying:Stop() 
	self.Flying = nil
	end
end
if self:GetNWBool("CrowCantFly") then
	if ( self.Flying ) then 
	self.Flying:ChangeVolume( 0, 0.02 ) 
	self.Flying:Stop() 
	self.Flying = nil
	self.Owner:EmitSound("npc/crow/hop2.wav")
	end
end
if self.CrowTired > 0 and ((!self:GetNWBool("CrowCantFly") and !self.Owner:KeyDown( IN_ATTACK2 )) or (self:GetNWBool("CrowCantFly"))) and self.CrowFitThink < CurTime() then
self.CrowTired = self.CrowTired - 2
self.CrowFitThink = CurTime() + 0.1
end
if self.CrowTired <= 0 then
self:SetNWBool("CrowCantFly",false)
end
end

/*---------------------------------------------------------
	Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self.Owner:GetViewModel():SetPlaybackRate(4)
    self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration()/4)
	self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration()/4)
end

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
    if !(self.Weapon:GetNextPrimaryFire() < CurTime()) then return end
    local tr = self.Owner:GetEyeTrace()
    if (tr.HitPos - self.Owner:GetShootPos()):Length()  < 80 then
	if IsValid(tr.Entity) and SERVER then
	local dmginfo = DamageInfo()
	dmginfo:SetDamageType(DMG_CLUB)
    dmginfo:SetAttacker(self.Owner)
	dmginfo:SetInflictor(self)
	dmginfo:SetDamage(30)
	if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
	dmginfo:SetDamageForce(self.Owner:GetForward()*7000)
	else
	if IsValid(tr.Entity:GetPhysicsObject()) then
	tr.Entity:GetPhysicsObject():ApplyForceCenter(self.Owner:GetForward()*8000)
	end
	end
	tr.Entity:TakeDamageInfo(dmginfo)
	end
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SetNextPrimaryFire( CurTime() + 0.4)
	if SERVER then
	self.Owner:EmitSound(Sound("Weapon_Crowbar.Melee_Hit"))
	self.Owner:EmitSound(Sound("npc/crow/pain" .. math.random(1,2) .. ".wav"))
	end
    else 
	if SERVER then
    self.Owner:EmitSound(Sound("Weapon_Crowbar.Single"))
	end
    self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER)
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:SetNextPrimaryFire( CurTime() + 0.4 )
	end
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/

function SWEP:SecondaryAttack()
    if !(self.Weapon:GetNextSecondaryFire() < CurTime()) then return end
    if self:GetNWBool("CrowCantFly") then return end
    self:SetNextSecondaryFire( CurTime() + 0.1 )
	if !self.Owner:IsOnGround() and self.Owner:WaterLevel() == 0 then
	if self.Owner:KeyDown(IN_FORWARD) then
	self.Owner:SetVelocity(self.Owner:GetAimVector()*math.Rand(12,15) + Vector(0,0,(self.Owner:KeyDown(IN_JUMP) and 59 or 50)))
	elseif self.Owner:KeyDown(IN_JUMP) then
	self.Owner:SetVelocity(Vector(0,0,70))
	else
	self.Owner:SetVelocity(Vector(0,0,50))
	end
	end
	self.CrowTired = self.CrowTired + 1
	self.CrowFitThink = CurTime() + 1
	if SERVER then 
	self.Owner:SendLua("LocalPlayer():GetActiveWeapon().CrowTired = LocalPlayer():GetActiveWeapon().CrowTired + 1")
	end
	if SERVER then
	self.Owner:SendLua("LocalPlayer():GetActiveWeapon().CrowFitThink = CurTime() + 1")
	end
	if  (self.CrowTired >= 80) then 
	self:SetNWBool("CrowCantFly",true) 
	end

	
	if !self.Flying then
    self.Flying = CreateSound(self.Owner,Sound("npc/crow/flap2.wav"))
    self.Flying:Play()
    end
end

/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/

function SWEP:Initialize()

	// other initialize code goes here
	
	self:SetWeaponHoldType(self.HoldType)
	self:SetNWBool("CrowCantFly",false)

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

function SWEP:Holster()
	if ( self.Flying ) then 
	self.Flying:ChangeVolume( 0, 0.02 ) 
	self.Flying:Stop() 
	self.Flying = nil
	end
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
   self:Holster()
   self:GetOwner().IsCrow_Bar = true
   local ply = self:GetOwner()
   timer.Simple(0.02,function() if IsValid(ply) then ply.IsCrow_Bar = false end end)
end

hook.Add("PlayerDeath","CrowEscape",function( ply, inflictor, attacker )
	if IsValid(ply) and ply.IsCrow_Bar and SERVER then
	local Ang = ply:GetAngles()
    Ang.pitch = 0
    Ang.roll = Ang.roll
    Ang.yaw = Ang.yaw
	local crow = ents.Create("npc_crow")
	crow:SetPos(ply:GetShootPos())
	crow:SetAngles(Ang)
	crow:Spawn()
	crow:Activate()
	crow:EmitSound(Sound("npc/crow/alert1.wav"))
	end
end)

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

			    local position = Vector(7.794, 2.022, -7.400)
				local position2 = Vector(7.794, 1.600, -7.900)
				if self.Owner:KeyDown(IN_ATTACK2)and self:GetNWBool("CrowCantFly") == false then
				model:SetPos(pos + ang:Forward() * position.x + ang:Right() * position.y + ang:Up() * position.z )
				else
				model:SetPos(pos + ang:Forward() * position2.x + ang:Right() * position2.y + ang:Up() * position2.z )
				end
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				if self.Owner:KeyDown(IN_ATTACK2) then
				if self:GetNWBool("CrowCantFly") == false then
				model:SetSequence(0)
				model:SetCycle(CurTime()*0.8)
				else
				model:SetSequence(7)
				model:SetCycle(CurTime()*1)
				end
				else
				model:SetSequence(1)
				model:SetCycle(CurTime()*0.2)
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				if IsValid(self.Owner) then
				if self.Owner:KeyDown(IN_ATTACK2) then
				if self:GetNWBool("CrowCantFly") == false then
				model:SetSequence(0)
				model:SetCycle(CurTime()*0.8)
				else
				model:SetSequence(7)
				model:SetCycle(CurTime()*1)
				end
				else
				model:SetSequence(1)
				model:SetCycle(CurTime()*0.2)
				end
				else
				model:SetSequence(1)
				model:SetCycle(CurTime()*0.2)
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end

