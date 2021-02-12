AddCSLuaFile()
resource.AddFile("sound/weapons/plasma/end.wav")
resource.AddFile("sound/weapons/plasma/fire.wav") 


if CLIENT then
   SWEP.PrintName          = "Disintegrator"
   SWEP.Slot               = 2

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
	self:SetHoldType( "ar2" )
	// other initialize code goes here

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
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	if self:IsValid() then self.spin = 0 end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

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

function SWEP:CanPrimaryAttack()

	if ( self.Weapon:Clip1() <= 0 ) then
	
		--self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
		
	end

	return true

end



SWEP.Base               = "weapon_base"



SWEP.VElements = {
	["P1"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 2.885), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["P1++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 4.26), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["T1"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(1.577, -5.117, 6.006), angle = Angle(90, 0, 0), size = Vector(0.03, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T8"] = { type = "Model", model = "models/props_combine/suit_charger001.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.816, -4.867, 5.864), angle = Angle(0, 180, 0), size = Vector(0.104, 0.149, 0.472), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T2"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.457, -5.797, 3.941), angle = Angle(180, 0, 0), size = Vector(0.054, 0.014, 0.074), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T4"] = { type = "Model", model = "models/props_combine/combine_teleportplatform.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.005, -6.567, 1.891), angle = Angle(0, 0, 0), size = Vector(0.014, 0.014, 0.046), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T3"] = { type = "Model", model = "models/props_combine/masterinterface.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(-0.071, -5.773, -0.773), angle = Angle(120, -90, 0), size = Vector(0.023, 0.017, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["P1++++++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 6.591), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["bb"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.045, -4.087, -12.82), angle = Angle(0, 0, 90), size = Vector(0.192, 0.451, 0.192), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["P1+"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 3.446), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["P1++++++++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 7.335), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["P1+++++++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 7.31), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["b2"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.p90_Parent", rel = "bb", pos = Vector(-1.208, -1.634, 0), angle = Angle(0, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["b2+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.p90_Parent", rel = "bb", pos = Vector(1.21, -1.634, 0), angle = Angle(180, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["P1+++++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 5.703), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["T6"] = { type = "Model", model = "models/props_combine/combine_tptimer.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.212, -5.499, 9.67), angle = Angle(-90, 0, -90), size = Vector(0.025, 0.014, 0.014), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["b2++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.p90_Parent", rel = "bb", pos = Vector(0, -0.76, -1.211), angle = Angle(90, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["P1++++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 5.061), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["T7"] = { type = "Model", model = "models/props_combine/combine_lock01.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.573, -5.896, 1.815), angle = Angle(0, 0, 90), size = Vector(0.175, 0.189, 0.092), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T5"] = { type = "Model", model = "models/props_combine/weaponstripper.mdl", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.689, -6.582, 8.557), angle = Angle(90, 0, 0), size = Vector(0.1, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["P1+++"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0, -6.677, 4.824), size = { x = 2.219, y = 1.023 }, color = Color(0, 152, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["b2+++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "v_weapon.p90_Parent", rel = "bb", pos = Vector(0, -0.76, 1.21), angle = Angle(-90, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["flash"] = { type = "Sprite", sprite = "sprites/plasmaember", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.72, -3.264, -22.202), size = { x = 1, y = 1 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["flash+"] = { type = "Sprite", sprite = "sprites/plasmaember", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.72, -3.264, -22.202), size = { x = 1, y = 1 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["flash++"] = { type = "Sprite", sprite = "sprites/plasmaember", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.72, -3.264, -22.202), size = { x = 1, y = 1 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["screen"] = { type = "Quad", bone = "v_weapon.p90_Parent", rel = "", pos = Vector(0.127, -6.822, 10.965), angle = Angle(0, 0, -22.542), size = 0.035, draw_func = nil}

	}

SWEP.WElements = {
	["b2++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bb", pos = Vector(0, -0.76, -1.211), angle = Angle(90, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["b2+++"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bb", pos = Vector(0, -0.76, 1.21), angle = Angle(-90, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["bb"] = { type = "Model", model = "models/props_lab/labpart.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.219, 1.804, -6.922), angle = Angle(0, 90, 8.576), size = Vector(0.192, 0.451, 0.192), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T8"] = { type = "Model", model = "models/props_combine/suit_charger001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.399, 2.13, -4.969), angle = Angle(0, -90, -99.293), size = Vector(0.104, 0.149, 0.472), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T2"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.726, -0.56, -5.864), angle = Angle(-97.789, 0, 0), size = Vector(0.097, 0.097, 0.097), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["T1"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.426, 1.037, -3.878), angle = Angle(171.91, 0, 0), size = Vector(0.03, 0.025, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["b2"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bb", pos = Vector(-1.208, -1.634, 0), angle = Angle(0, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["b2+"] = { type = "Model", model = "models/props_combine/combine_binocular01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "bb", pos = Vector(1.21, -1.634, 0), angle = Angle(180, 0, -90), size = Vector(0.111, 0.111, 0.338), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}




SWEP.Spawnable			= true

SWEP.Author			= "Seris"
SWEP.Contact		= "AJ10017@hotmail.com"
SWEP.Purpose		= "Beam Weapon, unlimited ammo"
SWEP.Instructions	= "Aim and shoot"
SWEP.Weight = 3
SWEP.Category = "Seris"
SWEP.Slot = 2

SWEP.Primary.Damage      = 4
SWEP.Primary.Delay       = 0.001
SWEP.Primary.Cone        = 0.0075
SWEP.Primary.ClipSize    = 100
SWEP.Primary.ClipMax     = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "plasma"
SWEP.Primary.Recoil      = 0.2
SWEP.AmmoDevision = 7
SWEP.Inc = 1
SWEP.spin = 0
local cspin = 0

SWEP.CanBuy = {ROLE_DETECTIVE} -- only detectives can buy
SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 68
SWEP.ViewModel  = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"

SWEP.IronSightsPos = Vector(-6.421, -4.528, 3.3)
SWEP.IronSightsAng = Vector(-1, 0, 0)
SWEP.End = 0

SWEP.CanFire = true
SWEP.A = 0

function SWEP:SetupDataTables() 
	self:NetworkVar("Float", 0, "Spin") 
	self:NetworkVar("Float", 0, "A") 
end




function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

function SWEP:PrimaryAttack()

	if(!self:CanPrimaryAttack()) then
		return	
	end
	local tr = util.GetPlayerTrace( self.Owner )
	tr.mask = bit.bor( CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX )
	local trace = util.TraceLine( tr )
	
	
	
	local ang = Angle( math.Rand(-0.27,-0.27) * self.Primary.Recoil, math.Rand(-0.2,0.2) *self.Primary.Recoil, math.Rand(-0.2,0.2) )
	


		local bullet = {}
		bullet.Num = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()+Vector(0,0,(self.Owner:GetViewPunchAngles().pitch*-1)/50)
		bullet.Spread = Vector( self.Primary.Cone*(41-(self.spin*4)), self.Primary.Cone*(41-(self.spin*4)), 0 )
		bullet.Tracer = 1
		bullet.TracerName = "beam"
		bullet.Damage = 3
		bullet.Force = 1
		bullet.AmmoType = "Pistol"
		bullet.Callback = function(ply, tr, dmg) 
			dmg:SetDamageType(DMG_DISSOLVE)
			if tr.HitPos:Distance(self.Owner:GetPos())>4000 then dmg:ScaleDamage(0.5) end

		end
		self.Owner:FireBullets( bullet ) 
		//self:ShootEffects()
		self.Owner:ViewPunch( ang * (math.Rand(15,17)-self.spin*1.5) )
		self.Inc = self.Inc + 1
		if self.Inc > self.AmmoDevision then
			self.Inc = 1
			self:TakePrimaryAmmo(3)
		end
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self.Owner:MuzzleFlash()
	if self.spin < 10 then self.spin = self.spin + 0.2 end
	if self.CanFire == true and self:IsValid() then
		self.FSound = CreateSound(self.Owner,"weapons/plasma/beam2.wav")
		self.FSound:PlayEx(1,(self.spin*5))
		self.FSound:SetSoundLevel(80)
		self.CanFire = false
	end
	local End = function()
		if self:IsValid() then
			self.CanFire = true
			self.FSound:Stop()
			self.ESound = CreateSound(self.Owner,"weapons/plasma/beamend.wav")
			self.ESound:PlayEx(1,self.End)
			self.ESound:SetSoundLevel(80)
		end
	end
	if self.FSound:IsPlaying() and self:IsValid() then 
		self.FSound:ChangePitch((self.spin*9)+60,0)
		self.End = (self.spin*9)+60
	end

	local Reg = function()
		if self:IsValid() then 
			if self:Clip1() < 100 then self:SetClip1(self:Clip1()+1) end
		end
	end
	local SReg = function()
		if self:IsValid() then
			timer.Create("res"..self.Owner:EntIndex(),0.02,200,Reg)
		end
	end
	if self:IsValid() then
		timer.Destroy("stop"..self.Owner:EntIndex())
		timer.Destroy("regen"..self.Owner:EntIndex())
		timer.Destroy("res"..self.Owner:EntIndex())
		timer.Create("Stop"..self.Owner:EntIndex(),0.1,1,End)
		timer.Create("regen"..self.Owner:EntIndex(),0.7,1,SReg)
	end
	
	self.A = 255
end

function SWEP:SecondaryAttack() return end

function SWEP:Think()
	
	if !self:IsValid() and (self.FSound:IsPlaying() or self.ESound:IsPlaying())  then 
		if timer.Exists("stop") then timer.Destroy("stop") end
		if timer.Exists("regen") then timer.Destroy("regen") end
		if timer.Exists("res") then timer.Destroy("res") end
		self.ESound:Stop()
		self.FSound:Stop()
		self.CanFire=true
	end
	cspin = self.spin
	if self.spin > 0.5 then self.spin = self.spin - 0.05 end
	if SERVER then 
		self:SetNetworkedFloat("Spin",self.spin)
		self:SetNetworkedFloat("A",self.A)
	end
	if CLIENT then
	local spin = self:GetNetworkedFloat("Spin",0)
	local A = self:GetNetworkedFloat("A",0)
	--print(spin)
	self.VElements["bb"].angle = self.VElements["bb"].angle - Angle(0,spin*2.5,0)
	self.VElements["bb"].color = Color(0+(spin*20),0+(spin*20),0+(spin*20),255)
	
	self.VElements["b2"].angle = Angle(0, spin*-3, -90)
	self.VElements["b2+"].angle = Angle(180, spin*3, -90)
	self.VElements["b2++"].angle = Angle(90, 0, -90)
	self.VElements["b2+++"].angle = Angle(-90, 0, -90)
	
	self.VElements["P1"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1+"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1+++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1++++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1+++++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1++++++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1+++++++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	self.VElements["P1++++++++"].color = Color(0,155,255,math.Rand(0,60)+(spin*10))
	
	self.VElements["flash"].size.x = spin*math.Rand(5,14)
	self.VElements["flash+"].size.x = spin*math.Rand(5,14)
	self.VElements["flash++"].size.x = spin*math.Rand(5,14)
	
	self.VElements["flash"].size.y = spin*math.Rand(0.2,3)
	self.VElements["flash+"].size.y = spin*math.Rand(0.2,3)
	self.VElements["flash++"].size.y = spin*math.Rand(0.2,3)
	
	self.VElements["flash"].color = Color(150,150,255,A)
	self.VElements["flash+"].color = Color(150,150,255,A)
	self.VElements["flash++"].color = Color(150,150,255,A)
	end
	
	if self.A > 0 then self.A = self.A - 5 end
	
	
	self.VElements["screen"].draw_func = function( weapon )
			draw.RoundedBox(0,-38,-14,75,15,Color(100,100,255,50))
			draw.SimpleText("CHARGE: "..self:Clip1(), "default", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

	
	end
	self:NextThink( CurTime() + 0.056 )
	return true
end

function SWEP:DoImpactEffect(tr,DMG_DISSOLVE)
	return true;
end

function SWEP:OnRemove()
	if self.FSound != nil then
		self.FSound:Stop()
	end
end

