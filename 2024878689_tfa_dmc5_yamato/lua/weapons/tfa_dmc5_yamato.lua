SWEP.Base = "tfa_melee_base"
SWEP.Category = "DMC5"
SWEP.PrintName = "Yamato"
SWEP.Author				= "YongLi" --Author Tooltip
SWEP.Type	= "Vergil's Katana"
SWEP.ViewModel = "models/weapons/yamato/yamato.mdl"
SWEP.WorldModel = "models/weapons/w_yamato.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 85
SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.DrawCrosshair = false
SWEP.droppable = false

SWEP.Primary.Directional = true

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.DisableIdleAnimations = true


SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 250
SWEP.Secondary.BashDelay = 0.25
SWEP.Secondary.BashLength = 16 * 4.5

SWEP.Precision = 50
SWEP.Secondary.MaxCombo = -1
SWEP.Primary.MaxCombo = -1

SWEP.Offset = {
		Pos = {
		Up = 0,
		Right = 0,
		Forward = 0,
		},
		Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
		},
		Scale = 1
}

SWEP.Primary.Attacks = {
	{
		['act'] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 24*5, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(-180,30,0), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 10, --This isn't overpowered enough, I swear!!
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.06, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['snd_delay'] = 0.035,
		["viewpunch"] = Angle(2,2,2), --viewpunch angle
		['end'] = 0.5, --time before next attack
		['hull'] = 32, --Hullsize
		['direction'] = "F", --Swing dir,
		['maxhits'] = 25
	},
	{
		['act'] = ACT_VM_MISSLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 24*5, -- Trace distance
		['dir'] = Vector(-180,0,0), -- Trace arc cast
		['dmg'] = 20, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['snd_delay'] = 1,
		["viewpunch"] = Angle(1,-5,0), --viewpunch angle
		['end'] = 0.14, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "L", --Swing dir,
	},
	{
		['act'] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 24*5, -- Trace distance
		['dir'] = Vector(180,0,0), -- Trace arc cast
		['dmg'] = 20, --Damage
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0, --Delay
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['spr'] = true, --Allow attack while sprinting?
		['snd_delay'] = 0,
		["viewpunch"] = Angle(1,5,0), --viewpunch angle
		['end'] = 0.14, --time before next attack
		['hull'] = 16, --Hullsize
		['direction'] = "R", --Swing dir
	},

}

SWEP.Secondary.Attacks =  { 

	{
		['act'] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 28*5, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(180,60,0), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 50, --Nope!! Not overpowered!!
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.06, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['snd_delay'] = 0.4,
		["viewpunch"] = Angle(3,10,0), --viewpunch angle
		['end'] = 0.9, --time before next attack
		['hull'] = 128, --Hullsize
		['direction'] = "F", --Swing dir
		['maxhits'] = 25
	},
	{
		['act'] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 28*5, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(180,60,0), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 50, --Nope!! Not overpowered!!
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.06, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['snd_delay'] = 0.4,
		["viewpunch"] = Angle(3,10,0), --viewpunch angle
		['end'] = 0.9, --time before next attack
		['hull'] = 128, --Hullsize
		['direction'] = "L", --Swing dir
		['maxhits'] = 25
	},
	{
		['act'] = ACT_VM_SECONDARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 28*5, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(180,60,0), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 50, --Nope!! Not overpowered!!
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.06, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['snd_delay'] = 0.4,
		["viewpunch"] = Angle(3,10,0), --viewpunch angle
		['end'] = 0.9, --time before next attack
		['hull'] = 128, --Hullsize
		['direction'] = "R", --Swing dir
		['maxhits'] = 25
	},
	
	{
	
		['act'] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 28*5, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dir'] = Vector(0,0,90), -- Trace dir/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 50, --Nope!! Not overpowered!!
		['dmgtype'] = DMG_SLASH, --DMG_SLASH,DMG_CRUSH, etc.
		['delay'] = 0.06, --Delay
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "TFABaseMelee.Null", -- Sound ID
		['snd_delay'] = 0.4,
		["viewpunch"] = Angle(3,10,5), --viewpunch angle
		['end'] = 1.63, --time before next attack
		['hull'] = 128, --Hullsize
		['direction'] = "B", --Swing dir
		['maxhits'] = 25
	}
	
}



if SERVER then

	function SWEP:rapidcut()
	if IsValid(self.Owner) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage(34)
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Owner)
		for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 200 ) ) do 
			if v:IsValid() and self.Owner:Alive() and  v != self.Owner then
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				v:TakeDamageInfo( dmg )
			end	
		end
	end
	end
	
	function SWEP:rapidcutf()
	if IsValid(self.Owner) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage(5)
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Owner)
		for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 220 ) ) do 
			if v:IsValid() and self.Owner:Alive() and  v != self.Owner then
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				v:TakeDamageInfo( dmg )
			end	
		end
	end
	end
	
	function SWEP:liftcut()
	if IsValid(self.Owner) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage(20)
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Owner)
		for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 150 ) ) do 
			if v:IsValid() and self.Owner:Alive() and  v != self.Owner then
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				v:TakeDamageInfo( dmg )
			end	
		end
	end
	end
	

	function SWEP:Jcn()
	if IsValid(self.Owner) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage(25)
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Owner)
			
		

		for k, v in pairs ( ents.FindInSphere( self.Owner:GetEyeTrace().HitPos, 150 ) ) do
			if v:IsValid() and v != self.Owner then
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				v:TakeDamageInfo( dmg )
			end	
		end
	end
	end
	
	function SWEP:Jc()
	if IsValid(self.Owner) then
		local k, v
		local dmg = DamageInfo()
			dmg:SetDamage(50)
			dmg:SetDamageType(DMG_SLASH)
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self.Owner)
		
		for k, v in pairs ( ents.FindInSphere( self.Owner:GetPos(), 1400 ) ) do
			if v:IsValid() and v != self.Owner then
				dmg:SetDamageForce( ( v:GetPos() - self.Owner:GetPos() ):GetNormalized() * 100 )
				v:TakeDamageInfo( dmg )
			end	
		end
	end
	end
end

function SWEP:Deploy()
	self.sm = 0
end
SWEP.SlashTime 		= CurTime()
SWEP.st = 0
SWEP.dodgetime = 0
SWEP.sm = 0
function SWEP:Reload()
	
end


SWEP.CanBlock = true
SWEP.BlockAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_DEPLOY, --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_IDLE_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["hit"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--when you get hit and block it
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_UNDEPLOY, --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}
SWEP.BlockCone = 100 --Think of the player's view direction as being the middle of a sector, with the sector's angle being this
SWEP.BlockDamageMaximum = 0.0 --Multiply damage by this for a maximumly effective block
SWEP.BlockDamageMinimum = 0.2 --Multiply damage by this for a minimumly effective block
SWEP.BlockTimeWindow = 0.5 --Time to absorb maximum damage
SWEP.BlockTimeFade = 0.7 --Time for blocking to do minimum damage.  Does not include block window
SWEP.BlockSound = "yamato_block"
SWEP.BlockDamageCap = 80
SWEP.BlockDamageTypes = {
	DMG_SLASH,DMG_CLUB
}

SWEP.InspectionActions = {ACT_VM_RECOIL1}

DEFINE_BASECLASS(SWEP.Base)

if CLIENT then
	
end


function SWEP:Think()
		if self.Owner:KeyReleased(IN_RELOAD) and self.sm == 1 then
		self.Owner:ViewPunch(Angle(5, 0, 0))	util.ScreenShake( self.Owner:GetPos(), 3, 3, 0.2, 300 ) self.Owner:DoAnimationEvent( ACT_LAND ) self.Owner:SetPos(self.Owner:GetEyeTrace().HitPos) 	self.Weapon:EmitSound("yamato_tele", 100, 100)	self.SlashTime = CurTime() + 1.7 		
		self.sm = 0
		end
		if not self.Owner:Alive()  then 
		self.Owner:Freeze( false )
		end
		if self.Owner:KeyDown(IN_FORWARD) and SERVER and self.Owner:IsOnGround() and self.Owner:KeyDown(IN_USE) and self.Owner:KeyDown(IN_ATTACK) and CurTime() > self.st then
		local aimvec = self.Owner:GetAimVector()
		self.Owner:SetVelocity(Vector(aimvec.x*100,aimvec.y*100,aimvec.z*0.5)*1024)
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
		self.st = CurTime() + 1 
		self.Owner:ViewPunch(Angle(4, 0, 0))
		if self.Owner:Alive() then
		self.Owner:GodEnable()
		timer.Simple(0.05, function()	if self.Owner:Alive() then self.Owner:SetAnimation( PLAYER_ATTACK1 ) self:rapidcut() self.Weapon:SendWeaponAnim(ACT_VM_MISSLEFT) end	end)
		timer.Simple(0.07, function()	if self.Owner:Alive() then self:rapidcut() end end) 
		timer.Simple(0.09, function()	if self.Owner:Alive() then self:rapidcut() end end)
		timer.Simple(0.11, function()	if self.Owner:Alive() then self:rapidcut() self.Weapon:SendWeaponAnim(ACT_VM_MISSRIGHT) end	end)
		timer.Simple(0.13, function()	if self.Owner:Alive() then self.Owner:SetAnimation( PLAYER_ATTACK1 ) self:rapidcut() end end)
		timer.Simple(0.14, function()	if self.Owner:Alive() then self:rapidcut() self.Weapon:SendWeaponAnim(ACT_VM_MISSLEFT)	 end end)
		timer.Simple(0.15, function()	if self.Owner:Alive() then self:rapidcut() self.Owner:SetVelocity(Vector(aimvec.x*100,aimvec.y*100,aimvec.z*0.5)*1024) end end)
		timer.Simple(0.24, function()	
		
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK) self.Owner:ViewPunch(Angle(0, -260, 3))
		self.Weapon:SetNextPrimaryFire(CurTime() + 1)
		if self.Owner:Alive() then
		self:rapidcutf()
		end 
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:GodDisable()
			
		end)
		end
		end
		if self.Owner:KeyDown(IN_BACK) and 	SERVER and self.Owner:IsOnGround() and self.Owner:KeyDown(IN_USE) and self.Owner:KeyDown(IN_ATTACK) and CurTime() > self.st then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.85)
		if self.Owner:Alive() then
		self.Owner:GodEnable()
		self:liftcut()
		end
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		timer.Simple(0.2, function()
		if self.Owner:KeyDown(IN_ATTACK) then	
		self.Owner:SetVelocity(Vector(0,0,500))	
		if self.Owner:Alive() then
		self:rapidcut()
		self.Owner:GodDisable()
		end
		end
		end)
		self.st = CurTime() + 1.7
		self.Owner:ViewPunch(Angle(-30, -6, -4))
		self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
		end

end

