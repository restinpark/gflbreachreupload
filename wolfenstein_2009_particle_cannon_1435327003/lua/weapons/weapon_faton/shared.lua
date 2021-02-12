

if SERVER then

	AddCSLuaFile("shared.lua")
	
end

if CLIENT then

	SWEP.PrintName			= "Particle Cannon"
	SWEP.Author				= "Comrade Communist"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 10
	SWEP.ItemType = WEAPON_GUN or 6
	SWEP.WepSelectIcon		= surface.GetTextureID( "vgui/icons/faton" )
	
	killicon.Add( "weapon_faton", "vgui/icons/faton", Color( 255, 255, 255, 255 ) )
	
end
local DOOM3_STATE_RELOAD = 2
SWEP.VElements = {
	["d3ammo"] = { type = "Quad", bone = "bone001", rel = "", pos = Vector(1.5, -4.115, -.655), angle = Angle(90, 0, -33), size = .0075, draw_func = nil},
	["d3ammoclip"] = { type = "Quad", bone = "bone001", rel = "", pos = Vector(1.6, -4.27, -.31), angle = Angle(90, 0, -33), size = .015, draw_func = nil}
}

function SWEP:AmmoDisplay()
	if CLIENT then
		self.VElements["d3ammo"].draw_func = function(weapon)
			draw.DrawText(math.min(weapon:Ammo1(), 999), "doom3ammodisp", 0, 0, Color(150, 230, 255, 0), 2)
		end
		self.VElements["d3ammoclip"].draw_func = function(weapon)
			draw.DrawText(weapon:Clip1(), "doom3ammodisp", 0, 0, Color(210, 255, 255, 0), TEXT_ALIGHT_LEFT)
			draw.DrawText("88", "doom3ammodisp", 0, 0, Color(150, 200, 255, 0), TEXT_ALIGHT_LEFT)
		end
	end
end
SWEP.Primary.Spread			= 0




SWEP.RandomEffectsDelay = 0.2




function SWEP:ViewModelDrawn(vm)
        if SERVER then return end

                vm:SetSkin(0)

end

function SWEP:PostDrawViewModel(vm)
       if SERVER then return end
        if vm:GetSkin() == 1 then
                vm:SetSkin(1)
        end
	end
	
	

function SWEP:PrimarySoundStart()
	if !self.LoopSound then
		self.LoopSound = CreateSound(self.Owner, self.Primary.Sound)
	end
	if self.LoopSound and !self.LoopSound:IsPlaying() then
		self.LoopSound:Play()
	end
end

function SWEP:NPCAttack()
	if !self:CanPrimaryAttack() then return end
	if self:GetNextPrimaryFire() <= CurTime() then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

		self:ShootBullet(cvars.Number("doom3_sk_chaingun_damage"), self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)
		self:TakePrimaryAmmo(1)
	end
end

function SWEP:NioDissolve( pos )

	if ( GetConVarNumber( "sfw_allow_dissolve" ) ~= 1 ) then return end
	if ( !SERVER ) then return end
	
	timer.Create( "dissolve" .. self:EntIndex(), 0.01, 25, function() 
		for k, v in pairs ( ents.FindInSphere( pos, 100 ) ) do
			if ( v:IsRagdoll() ) && ( v:GetNWBool( "IsVaporizing" ) == false ) then --or ( v == LocalPlayer():GetRagdollEntity() )
				v:SetNWBool( "IsVaporizing", true )
				local phys = v:GetPhysicsObject()
				
				local bones = v:GetPhysicsObjectCount()
				local b = v:GetNWBool( "gravity_disabled" )

				for  i=0, bones-1 do
					local grav = v:GetPhysicsObjectNum( i )
					if ( IsValid( grav ) ) then
						grav:EnableGravity( b )
					end
				end
				
				if ( !IsValid( phys ) ) then v:Remove() return end
				phys:ApplyForceCenter( Vector( math.random( -10, 10 ), math.random( -10, 10 ), math.random( -5, 55 ) ) * 20 )
				
				local ed = EffectData()
				ed:SetOrigin( v:GetPos() )
				ed:SetEntity( v )
				util.Effect( "faton_dissolve", ed, true, true )
				
				v:DrawShadow( false )
				v:SetNoDraw( false )
				v:SetCollisionGroup( COLLISION_GROUP_DISSOLVING )
				v:Fire( "kill", "", 1.5 )
				v:EmitSound( "scifi.neutrino.dissolve" )
				v:EmitSound( "weapons/fatond_"..math.random(1,3)..".wav" )
			end
		end
		timer.Remove( "dissolve" .. self:EntIndex() )
	end )

end

function SWEP:EpicImpact()

	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Spread = Vector( 0, 0 )
	bullet.Tracer = 1
	bullet.Force = 0.1
	bullet.HullSize = 16
	bullet.Damage = 8
	bullet.AmmoType = "CombineCannon"
	bullet.TracerName = "faton_tracer"
	bullet.Callback = function( attacker, tr, dmginfo )
		dmginfo:SetDamageType( bit.bor( DMG_RADIATION, DMG_BLAST ) )
		dmginfo:SetInflictor( self )
		
		if ( tr.HitGroup == HITGROUP_HEAD ) then
			dmginfo:SetDamage( dmginfo:GetDamage() / 2 )
		end		
		self:NioDissolve( tr.HitPos )


	end
	
	self:FireBullets( bullet, false )

end


function SWEP:PrimaryAttack()


		if (!SERVER) then return end
	if !self:GetAttack() then
		self:EmitSound(self.Primary.Special, 75, 100, 1, CHAN_ITEM)
		self:SetAttack(true)
	end

	if self:GetAttackDelay() >= self.BarrelAccelTime then
				self:EpicImpact()
						self:PrimarySoundStart()
				local owner = self.Owner
				local vm = owner:GetViewModel()
				      if vm:GetSkin() == 0 then
                vm:SetSkin(1)
        end
					self:Muzzleflash()
					
		self:TakePrimaryAmmo(1)
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self:DoomRecoil(self.Primary.Recoil)

		        if BEAM_ON == 0 then     
            self.Owner:ViewPunch(Angle( 0.3, 0, 0.3 ))				

            BEAM_ON = 1
        end
			

		end
		
end

function SWEP:DoImpactEffect( tr )
		if (tr.HitSky) then return end
				local effect = EffectData();
				effect:SetOrigin(tr.HitPos);
				effect:SetNormal( tr.HitNormal );
				util.Effect("doom3_plasma_light", effect);
util.Effect("effect_faton_prd", effect);
	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal )

		return true
end




function SWEP:ShootBullet(dmg, recoil, numbul, cone)

end

function SWEP:SpecialThink()
	if game.SinglePlayer() and CLIENT then return end
	if self.Owner:KeyReleased(IN_ATTACK) or self:Clip1() <= 0 then
	
					local owner = self.Owner
				local vm = owner:GetViewModel()
				      if vm:GetSkin() == 1 then
                vm:SetSkin(0)
        end
		if self:GetAttack() then
			self:EmitSound(self.Primary.Special1, 75, 100, 1, CHAN_ITEM)
			if self:GetAttackDelay() >= self.BarrelAccelTime then
				self:Idle(.1)
			end
		end
		if self.LoopSound then self.LoopSound:Stop() end
		self:SetAttack(nil)
	end
	
	local attdelay = self:GetAttackDelay()
	if self.Owner:KeyDown(IN_ATTACK) and self:Clip1() > 0 then

		self:SetAttackDelay(math.Clamp(attdelay^1.025, 2, self.BarrelAccelTime))

	else
		self:SetAttackDelay(math.Clamp(attdelay^.99, 2, self.BarrelAccelTime))
	end
end



function SWEP:Reload()
	if self.Owner:IsNPC() then
		self:DefaultReload(ACT_VM_RELOAD)
		self:SetClip1(self:Clip1() + self.Primary.ClipSize)
		return
	end
	if self:Ammo1() <= self.ReloadAmmo or self:Clip1() >= self.Primary.ClipSize then return end
	if self:GetState() == DOOM3_STATE_RELOAD or self:GetCannotReload() or self:GetAttack() or self:GetCannotHolster() > 0 then return end
	self:SetState(DOOM3_STATE_RELOAD)
	self:SpecialReload()
	self:DefaultReload(ACT_VM_RELOAD)
	self:Idle()
end
function SWEP:SpecialReload()
	self:SetAttackDelay(2)
end

function SWEP:SpecialHolster()
	self:OnRemove()
end


function SWEP:OnRemove()
  self:SetNWInt("fier", 0)
	BEAM_ON = 0

	if self.LoopSound then self.LoopSound:Stop() end
	self:SetAttack(nil)
	local owner = self.Owner
	if CLIENT then
		if IsValid(self) and IsValid(owner) and owner and owner:IsPlayer() then
			local vm = owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
			end
		end
	end
	
end
function SWEP:ShouldDropOnDie()
    return false
end

local lastpos = 0
local gunpos = Vector()




function SWEP:UpdateBonePositions(vm)
	if self:GetState() == 1 or self:GetCannotReload() then
		self:ResetBonePositions(vm)
		return
	end
	local barrels = vm:LookupBone("bone007")
	local gun = vm:LookupBone("bone001")
	if !barrels or !gun then return end
	local speed = 7
	local attack = lastpos+self:GetAttackDelay()-2
	lastpos = Lerp(FrameTime()*40, lastpos, attack)
	local rotate = (attack*speed) %360
	vm:ManipulateBoneAngles(barrels, Angle(0,0,rotate))
	
	if self:GetAttackDelay() >= self.BarrelAccelTime then
		local r = math.sin(CurTime() *60)
		gunpos = Vector(-.25 * r,-.25 * r,0)
		vm:ManipulateBonePosition(gun, gunpos)
	else
		gunpos = LerpVector(FrameTime()*20, gunpos, Vector(0,0,0))
		vm:ManipulateBonePosition(gun, gunpos)
	end
end

function SWEP:DryFire()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_EMPTY)

	self:Idle()
end
if SERVER then

	function SWEP:NPCShoot_Primary(ShootPos, ShootDir)
		local owner = self:GetOwner()
		if !IsValid(owner) then return end
		timer.Create("D3chaingunNPCattack"..owner:EntIndex(), self.Primary.Delay, 4, function()
			if !owner or !IsValid(owner) then return end
			self:NPCAttack()
		end)
	end
end
if(CLIENT)then

function SWEP:Initialize()
    if self.on == nil then self.on = 0 end
    self:SetWeaponHoldType( "physgun" )
    Beamz = CreateMaterial( "xeno/beamz2", "UnlitGeneric", {
        [ "$basetexture" ]    = "sprites/physbeam3",
        [ "$additive" ]        = "1",
        [ "$vertexcolor" ]    = "1",
        [ "$vertexalpha" ]    = "1",
    } )
    Beamtwo = CreateMaterial( "xeno/beam22", "UnlitGeneric", {
        [ "$basetexture" ]    = "sprites/laserbeam2",
        [ "$additive" ]        = "1",
        [ "$vertexcolor" ]    = "1",
        [ "$vertexalpha" ]    = "1",
    } )
end

function SWEP:DrawHUD()
end

function SWEP:Think()

    self.on = self:GetNWInt("fier")
	
end

function SWEP:ViewModelDrawn()

    self:Drawspiral()
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


function SWEP:DrawWorldModel()
    self:Drawspiral()
    self.Weapon:DrawModel()
end


function SWEP:Drawspiral()
    Beamz = CreateMaterial( "xeno/beamz2", "UnlitGeneric", {
        [ "$basetexture" ]    = "sprites/physbeam3",
        [ "$additive" ]        = "1",
        [ "$vertexcolor" ]    = "1",
        [ "$vertexalpha" ]    = "1",
    } )
    Beamtwo = CreateMaterial( "xeno/beam22", "UnlitGeneric", {
        [ "$basetexture" ]    = "sprites/laserbeam2",
        [ "$additive" ]        = "1",
        [ "$vertexcolor" ]    = "1",
        [ "$vertexalpha" ]    = "1",
    } )

    
    if self.on == 1 then
    local tr = self.Weapon.Owner:GetEyeTraceNoCursor()

    if tr.Hit then


    self.StartPos = self:GetMuzzlePos( self, 1 )
    self.EndPos = tr.HitPos


    if not self.StartPos then return end
    if not self.EndPos then return end

    self.Weapon:SetRenderBoundsWS( self.StartPos, self.EndPos )

    local sinq = 3
    render.SetMaterial( Beamz )
    Rotator = Rotator or 0
    Rotator = Rotator - 310
    local Times = 50 --12
    render.StartBeam( 2 + Times );
    // add start
    self.Dir = (self.EndPos - self.StartPos):GetNormal()
    self.Inc = (self.EndPos - self.StartPos):Length() / Times
    local RAng = self.Dir:Angle()
    RAng:RotateAroundAxis(RAng:Right(),math.random(-10,0))
    RAng:RotateAroundAxis(RAng:Up(),math.random(-180,50))
    render.AddBeam(
        self.StartPos,                // Start position
        20,                    // Width
        CurTime(),                // Texture coordinate
        Color( 150, 255, 150, 100 )        // Color --Color( 64, 255, 64, 200 )
    )

    for i = 0, Times do
        // get point
        RAng:RotateAroundAxis(RAng:Right(),math.random(-10,0)/(Times/sinq))
        local point = ( self.StartPos + self.Dir * ( i * self.Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*10
        render.AddBeam(
            point,
            20,
            CurTime() + ( 1 / Times ) * i,
            Color( 200, 255, 150, 255 )
        )
    end
    render.AddBeam(
        self.EndPos,
        20,
        CurTime() + 1,
        Color( 0, 255, 200, 100 )
    )
    render.EndBeam()
    
    --2 beam
    
    
    render.StartBeam( 2 + Times );
    // add start
    self.Dir = (self.EndPos - self.StartPos):GetNormal()
    self.Inc = (self.EndPos - self.StartPos):Length() / Times
    local RAng = self.Dir:Angle()
    RAng:RotateAroundAxis(RAng:Right(),math.random(-10,0))
    RAng:RotateAroundAxis(RAng:Up(),math.random(-180,50))
    render.AddBeam(
        self.StartPos,                
        20,                    
        CurTime(),                
        Color( 0, 255, 150, 100 )        
    )

    for i = 0, Times do
        // get point
		RAng:RotateAroundAxis(RAng:Right(),math.random(10,0))
        RAng:RotateAroundAxis(RAng:Up(),math.random(180,-50)/(Times/sinq))
        local point = ( self.StartPos + self.Dir * ( i * self.Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*3
        render.AddBeam(
            point,
            20,
            CurTime() + ( 1 / Times ) * i,
            Color( 150, 255, 150, 255 )
        )
    end
    render.AddBeam(
        self.EndPos,
        20,
        CurTime() + 1,
        Color( 0, 255, 200, 100 )
    )
    render.EndBeam()
    
    -- 3 beam
    
    
    render.StartBeam( 2 + Times );
    // add start
    self.Dir = (self.EndPos - self.StartPos):GetNormal()
    self.Inc = (self.EndPos - self.StartPos):Length() / Times
    local RAng = self.Dir:Angle()
    RAng:RotateAroundAxis(RAng:Right(),math.random(-10,0))
	RAng:RotateAroundAxis(RAng:Up(),math.random(-180,50))
    render.AddBeam(
        self.StartPos,                
        20,                    
        CurTime(),                
        Color( 0, 255, 200, 255 )        
    )

    for i = 0, Times do
        // get point
        local point = ( self.StartPos + self.Dir * ( i * self.Inc ) ) + RAng:Forward() * (math.sin((i/Times)*math.pi))*10 --+ VectorRand()*math.random(1,10)
        render.AddBeam(
            point,
            20,
            CurTime() + ( 1 / Times ) * i,
            Color( 150, 255, 150, 255 )
        )
    end
    render.AddBeam(
        self.EndPos,
        20,
        CurTime() + 1,
        Color( 150, 255, 150, 255 )
    )
    render.EndBeam()
    end
    end


end
function SWEP:GetMuzzlePos( weapon, attachment )

    if(!IsValid(weapon)) then return end

    local origin = weapon:GetPos()
    local angle = weapon:GetAngles()
    if weapon:IsWeapon() and weapon:IsCarriedByLocalPlayer() then
        if( IsValid( weapon:GetOwner() ) && GetViewEntity() == weapon:GetOwner() ) then
            local viewmodel = weapon:GetOwner():GetViewModel()
            if( IsValid( viewmodel ) ) then
                weapon = viewmodel
            end
        end
    end
    local attachment = weapon:GetAttachment( attachment or 1 )
    if( !attachment ) then
        return origin, angle
    end
    return attachment.Pos, attachment.Ang

end

end





SWEP.HoldType			= "ar2"
SWEP.Base				= "weapon_faton_base"
SWEP.Category			= "Wolfenstein 2009"
SWEP.Spawnable			= true

SWEP.ViewModel			= "models/weapons/wolf/faton.mdl"
SWEP.WorldModel			= "models/weapons/wolf/w_faton.mdl"

SWEP.Primary.Sound			= Sound("weapons/wolf2009/faton/chaingun_shot_1.mp3")
SWEP.Primary.Special		= Sound("weapons/wolf2009/faton/cg_windup_mix_01.wav")
SWEP.Primary.Special1		= Sound("weapons/wolf2009/faton/cg_winddown_mix_01.wav")
SWEP.Primary.Damage			= 10
SWEP.Primary.Recoil			= .2
SWEP.Primary.Cone			= .08
SWEP.Primary.ClipSize		= 900
SWEP.Primary.Delay			= .09
SWEP.Primary.DefaultClip	= 900
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.BarrelAccelTime		= 4

SWEP.DeploySound			= Sound("weapons/wolf2009/faton/cg_use_01.wav")
SWEP.ReloadSound			= Sound("weapons/wolf2009/faton/cg_reload_twist_01.wav")

SWEP.LightRight				= 2
SWEP.LightUp				= -15
SWEP.MuzzleName				= "doom3_plasma_muzzle"

SWEP.SmokeForward			= 42
SWEP.SmokeUp 				= -21
SWEP.SmokeSize				= 5