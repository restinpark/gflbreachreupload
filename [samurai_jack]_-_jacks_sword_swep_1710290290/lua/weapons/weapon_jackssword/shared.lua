--Send file to clients
if SERVER then
	AddCSLuaFile( "shared.lua" )
end
if CLIENT then
	SWEP.Slot      = 2
end

SWEP.Author        = "Copper, BULLYHUNTER_ゴゴ"
SWEP.Purpose       = "Use to hurt SCP-2301"
SWEP.Instructions  = "Left click to slash. Right click to block."
SWEP.Spawnable     = true
SWEP.Base          = "weapon_fists"   
SWEP.Category      = "Samurai Jack"
SWEP.PrintName     = "Samurai Sword"

SWEP.SlotPos            = 2
SWEP.DrawCrosshair      = true

SWEP.WorldModel = "models/weapons/samjack/w_magikatana.mdl"
SWEP.ViewModel = "models/weapons/samjack/c_magikatana.mdl"
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.HitDistance = 48

local Deploy = Sound( "weapons/jackssword/sj_sword_draw.wav" )
local Swing = Sound( "weapons/jackssword/sj_sword_swing.wav" )
local Strike = Sound( "weapons/jackssword/sj_sword_strike.wav" )
local Block = Sound( "weapons/jackssword/sj_sword_block.wav" )
local Aku = Sound( "weapons/jackssword/aku.wav" )

local ActIndex = {
	[ "pistol" ]		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ]			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ]		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ]			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ]		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]			= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ]		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ]		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ]			= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ]			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "duel" ]			= ACT_HL2MP_IDLE_DUEL,
	[ "camera" ]		= ACT_HL2MP_IDLE_CAMERA,
	[ "magic" ]			= ACT_HL2MP_IDLE_MAGIC,
	[ "revolver" ]		= ACT_HL2MP_IDLE_REVOLVER,
	[ "sword" ]			= ACT_HL2MP_IDLE_MELEE2
	
}
function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "BlockTimer")
end
function SWEP:SetWeaponHoldType( t )
	
	t = string.lower( t )
	local index = ActIndex[ t ]
	
	if ( index == nil ) then
		Msg( "SWEP:SetWeaponHoldType - ActIndex[ \"" .. t .. "\" ] isn't set! (defaulting to normal)\n" )
		t = "normal"
		index = ActIndex[ t ]
	end
	if ( t == "sword" ) then
		self.ActivityTranslate = {}
		self.ActivityTranslate[ ACT_MP_STAND_IDLE ]					= index
		self.ActivityTranslate[ ACT_MP_WALK ]						= ACT_HL2MP_IDLE_KNIFE + 1
		self.ActivityTranslate[ ACT_MP_RUN ]						= ACT_HL2MP_RUN_CHARGING
		self.ActivityTranslate[ ACT_MP_CROUCH_IDLE ]				= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("pose_ducking_01"))
		self.ActivityTranslate[ ACT_MP_CROUCHWALK ]					= index + 4
		self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]	= index + 5
		self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	= index + 5
		self.ActivityTranslate[ ACT_MP_RELOAD_STAND ]				= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("range_fists_r"))
		self.ActivityTranslate[ ACT_MP_RELOAD_CROUCH ]				= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("range_fists_r"))
		self.ActivityTranslate[ ACT_MP_JUMP ]						= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("jump_knife"))
		self.ActivityTranslate[ ACT_RANGE_ATTACK1 ]					= index + 8
		self.ActivityTranslate[ ACT_MP_SWIM ]						= index + 9
		else
		self.ActivityTranslate = {}
		self.ActivityTranslate[ ACT_MP_STAND_IDLE ]					= index
		self.ActivityTranslate[ ACT_MP_WALK ]						= index + 1
		self.ActivityTranslate[ ACT_MP_RUN ]						= index + 2
		self.ActivityTranslate[ ACT_MP_CROUCH_IDLE ]				= index + 3
		self.ActivityTranslate[ ACT_MP_CROUCHWALK ]					= index + 4
		self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]	= index + 5
		self.ActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	= index + 5
		self.ActivityTranslate[ ACT_MP_RELOAD_STAND ]				= index + 6
		self.ActivityTranslate[ ACT_MP_RELOAD_CROUCH ]				= index + 6
		self.ActivityTranslate[ ACT_MP_JUMP ]						= index + 7
		self.ActivityTranslate[ ACT_RANGE_ATTACK1 ]					= index + 8
		self.ActivityTranslate[ ACT_MP_SWIM ]						= index + 9
	end
	-- "normal" jump animation doesn't exist
	if ( t == "normal" ) then
		self.ActivityTranslate[ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_SLAM
	end
	
	
end

function SWEP:Initialize()
	--Set the third person hold type to fists    
end


--Third Person View
if CLIENT then
	hook.Add( "CalcView", "jacksswordthirdperson", 
		function( ply, pos, ang )
			if ( !IsValid( ply ) or !ply:Alive() or ply:GetViewEntity() != ply ) then return end
			if ( !LocalPlayer().GetActiveWeapon or !IsValid( LocalPlayer():GetActiveWeapon() ) or LocalPlayer():GetActiveWeapon():GetClass() != "gstands_anubis" ) then return end
			
			local convar = GetConVar("gstands_thirdperson_offset"):GetString()
			local strtab = string.Split(convar, ",")
			local offset = Vector(strtab[1], strtab[2], strtab[3])
			local fp = !(GetConVar("gstands_firstperson"):GetBool()) or false
			offset:Rotate(ang)
			
			if !fp and !LocalPlayer():KeyDown(IN_WALK) then 
				return {
					origin = pos,
					angles = ang,
					drawviewer = fp
				}
				elseif LocalPlayer():KeyDown(IN_WALK) then
				fp = true
			end
			
			local trace = util.TraceHull( {
				start = pos,
				endpos = pos - ang:Forward() * 100,
				filter = { ply:GetActiveWeapon(), ply, ply:GetVehicle() },
				mins = Vector( -4, -4, -4 ),
				maxs = Vector( 4, 4, 4 ),
			} )
			
			if (EyePos()):DistToSqr(LocalPlayer():EyePos()) < 25 then
				fp = true
			end
			
			if ( trace.Hit ) then pos = trace.HitPos else pos = trace.HitPos end
			return {
				origin = pos + offset,
				angles = ang,
				drawviewer = fp,
			}
		end )
end
--Deploy starts up the stand
function SWEP:Deploy()
	self:SetHoldType( "sword" )
	if SERVER then
		self.Owner:EmitSound(Deploy)
		hook.Add("EntityTakeDamage", "JackSword"..self.Owner:GetName(), function(target, dmginfo)
			if IsValid(target) and IsValid(self.Owner) and target == self.Owner and dmginfo:GetAttacker() != self.Owner then
				if self.InBlock then
					dmginfo:SetDamage(dmginfo:GetDamage()/3)
					self:SetBlockTimer(CurTime() + 0.3)
					self.ActivityTranslate[ ACT_MP_RELOAD_STAND ]	= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("range_fists_r"))
					self.ActivityTranslate[ ACT_MP_RELOAD_CROUCH ]	= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("range_fists_r"))
					
					timer.Simple(0.05, function()
						self.Owner:SetAnimation(PLAYER_RELOAD)
					end)
					self.Owner:EmitSound(Block, 75, math.random(90,110))
					self.StartBlock = self.StartBlock or CurTime()
					if CurTime() - self.StartBlock  <= 1 then
						return true
					end
				end
			end
		end)
		hook.Add("GetFallDamage", "JackSwordJumpGood"..self.Owner:GetName(), function(ply, speed)
			if( GetConVarNumber( "mp_falldamage" ) > 0 ) then -- realistic fall damage is on
				return ( speed - 826.5 ) * ( 100 / 896 ) -- the Source SDK value
			end
			
			return 0
		end)
	end
	if SERVER then
		self:SetPhysAttributes()
	end
	
	self:SendWeaponAnim(ACT_VM_DRAW)
	timer.Simple(self:SequenceDuration(), function() if self then 	self:SendWeaponAnim(ACT_VM_IDLE) end 
	end )
end

function SWEP:Reload()

end
	
function SWEP:Think()
	
	local curtime = CurTime()
	if self.Owner:KeyDown(IN_WALK) then
		self.Menacing = self.Menacing or CurTime()
		if CurTime() > self.Menacing then
			self.Menacing = CurTime() + 0.5
			local effectdata = EffectData()
			effectdata:SetStart(self.Owner:GetPos())
			effectdata:SetOrigin(self.Owner:GetPos())
			util.Effect("menacing", effectdata)
		end
	end
	
	if self.Owner:KeyDown(IN_FORWARD) then
		self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = self.Owner:GetSequenceActivity(self.Owner:LookupSequence("range_knife"))
		elseif CurTime() >= self:GetBlockTimer() then
		self.ActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = ACT_HL2MP_IDLE_MELEE2 + 5
	end
	if self.InBlock and CurTime() >= self:GetNextPrimaryFire() then
		if CurTime() >= self:GetBlockTimer() then
			self.ActivityTranslate[ ACT_MP_RELOAD_STAND ] = self.Owner:GetSequenceActivity(self.Owner:LookupSequence("fist_block"))
			self.ActivityTranslate[ ACT_MP_RELOAD_CROUCH ]	= self.Owner:GetSequenceActivity(self.Owner:LookupSequence("fist_block"))
			self.Owner:SetAnimation( PLAYER_RELOAD )
		end
	end
	self:NextThink(CurTime())
	return true
end


function SWEP:PrimaryAttack()
		self.InBlock = false
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		timer.Simple(self:SequenceDuration(), function() if self then 	self:SendWeaponAnim(ACT_VM_IDLE) end 
		end )
		if SERVER then
			tr = util.TraceHull( {
				start = self.Owner:EyePos(),
				endpos = self.Owner:EyePos() + self.Owner:GetAimVector() * self.HitDistance,
				filter = {self.Owner},
				mins = Vector( -15, -15, -8 ), 
				maxs = Vector( 15, 15, 8 ),
				ignoreworld = false,
				mask = MASK_SHOT_HULL
				
			} )
			self.Owner:EmitSound(Swing, 75, math.random(95, 105))
			if SERVER and tr.Entity:IsValid() and !tr.Entity:IsNPC() and tr.Entity:GetKeyValues()["health"] > 0 then tr.Entity:SetKeyValue("explosion", "2") tr.Entity:SetKeyValue("gibdir", tostring(self.Owner:GetAngles())) tr.Entity:Fire("Break") end
			
			if tr.Entity:IsValid() then
				local dmginfo = DamageInfo()
				
				local attacker = self.Owner
				dmginfo:SetAttacker( attacker )
				
				dmginfo:SetInflictor( self )
				dmginfo:SetDamage( 35  )
				tr.Entity:TakeDamageInfo( dmginfo )
				
			end
			
			if tr.Hit then
				self.Owner:EmitSound(Strike, 75, math.random(95, 105))
			end
		end
		self:SetNextPrimaryFire( CurTime() + 0.45 )
		self:SetNextSecondaryFire( CurTime())
end
function SWEP:SecondaryAttack()
	
	self.InBlock = !self.InBlock
	self.Owner:EmitSound(Swing, 75, math.random(75, 85))
	if !self.InBlock then
		self:SendWeaponAnim(ACT_VM_IDLE)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD)
		self.StartBlock = CurTime()
	end
	self:SetNextSecondaryFire( CurTime() + 1 )
end


function SWEP:OnDrop()
	if SERVER then
		hook.Remove("EntityTakeDamage", "JackSword"..self.Owner:GetName())
		hook.Remove("GetFallDamage", "JackSwordJumpGood"..self.Owner:GetName())
		self:ResetPhysAttributes()
	end
	return true
end

function SWEP:OnRemove()
	if SERVER then
		hook.Remove("EntityTakeDamage", "JackSword"..self.Owner:GetName())
		hook.Remove("GetFallDamage", "JackSwordJumpGood"..self.Owner:GetName())
		self:ResetPhysAttributes()
		
	end
	return true
end

function SWEP:Holster()	
	if SERVER then
		hook.Remove("EntityTakeDamage", "JackSword"..self.Owner:GetName())
		hook.Remove("GetFallDamage", "JackSwordJumpGood"..self.Owner:GetName())
		self:ResetPhysAttributes()
		
	end
	return true
end