--[[Legacy Variables]]--

SWEP.Primary.Ammo			= ""			-- Required for GMod legacy purposes.  Don't remove unless you want to see your sword's ammo.  Wat?
SWEP.data 				= {}				--Ignore this.

--[[SWEP Info]]--

SWEP.Gun = ("") -- must be the name of your swep but NO CAPITALS!
SWEP.Category				= ""
SWEP.Base               = "tfa_gun_base"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ("Left click to slash".."\n".."Hold right mouse to put up guard.")
SWEP.PrintName				= "Snowflake Katana"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 21			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 50			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Secondary.IronFOV			= 90					-- How much you 'zoom' in. Less is more!  Don't have this be <= 0 
SWEP.WeaponLength	=	5
--[[TTT CRAP]]--

SWEP.Kind = WEAPON_EQUIP
SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.CanBuy = {ROLE_TRAITOR,ROLE_DETECTIVE,ROLE_INNOCENT} -- only traitors can buy
SWEP.LimitedStock = true -- only buyable once
SWEP.WeaponID = AMMO_SWORD
SWEP.NoSights = false

SWEP.IsSilent = true

--[[Worldmodel Variables]]--

SWEP.HoldType 				= "melee2"		-- how others view you carrying the weapon
SWEP.BlockHoldType 				= "magic"		-- how others view you carrying the weapon, while blocking
--[[
Options:
normal - Pistol Idle / Weaponless, hands at sides
melee - One Handed Melee
melee2 - Two Handed Melee
fist - Fists Raised
knife - Knife/Dagger style melee.  Kind of hunched.
smg - SMG or Rifle with grip
ar2 - Rifle
pistol - One handed pistol
rpg - Used for RPGs or sometimes snipers.  AFAIK has no reload anim.
physgun - Used for physgun.  Kind of like SLAM, but holding a grip.
grenade - Used for nades, kind of similar to melee but more of a throwing animation.
shotgun - Used for shotugns, and really that's it.
crossbow -Similar to shotgun, but aimed.  Used for crossbows.
slam - Holding an explosive or other rectangular object with two hands
passive -- SMG idle, like you can see with some HL2 citizens
magic - One hand to temple, the other reaching out.  Can be used to mimic blocking a melee, if you're OK with the temple-hand-thing.
duel- dual pistols
revolver - 2 handed pistol
--]]
SWEP.WorldModel				= ""	-- Weapon world model
SWEP.ShowWorldModel			= true --Draw the world model?
SWEP.Spawnable				= false --Can it be spawned by a user?
SWEP.AdminSpawnable			= false --Can it be spawned by an admin?

--[[Viewmodel Variables]]--

SWEP.UseHands = true --Uses c_hands?  If you port a model directly from HL2, CS:S, etc. then set to false
SWEP.ViewModelFOV			= 60 --This controls the viewmodel FOV.  The larger, the smaller it appears.  Decrease if you can see something you shouldn't.
SWEP.ViewModelFlip			= false --Flip the viewmodel?  Usually gonna be yes for CS:S ports.
SWEP.ViewModel				= ""	-- Weapon view model

--[[Shooting/Attacking Vars]]--

SWEP.Primary.Damage		= 200	-- Base damage per bullet
SWEP.Primary.RPM			= 180			-- This is in Rounds Per Minute
SWEP.Primary.KickUp				= 0.4		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false.  In the case of our sword, if you can hold and keep swinging.
SWEP.FiresUnderwater = true  --Can you swing your sword underwater?

--[[ Block Procedural Animation Variables]]--

SWEP.BlockPos = Vector(-18, -10, 3)--Blocking Position.
SWEP.BlockAng = Vector(10, -25, -15)--Blocking Angle.

--[[Begin Slashing Variables]]--

SWEP.Slash = 1
SWEP.Sequences={}--Swinging Sequences
--[[
SWEP.Sequences[1]={
	name="swipe_u2d",--Sequence name, can be found in HLMV
	holdtype="melee2",--Holdtype (thirdperson type of weapon, usually gonna be melee for a one handed or melee2 for a two handed)
	startt=10/60,--swing start in seconds, from the sequence start
	endt=20/60,--swing end in seconds, from the sequence start
	pitch=5, --This is a component of the slash's arc.  Pitch is added last, and changes based on the time of the trace.
	yaw=35, --This is a component of the slash's arc.  Yaw is added second, and changes based on the time of the trace.
	roll=-90,--This is a component of the slash's arc.  Roll is added first, and remains static.
	dir=1--Left to right = -1, right to left =1.  Base this off if the roll were 0.  
}
SWEP.Sequences[2]={
	name="swipe_l2r",
	holdtype="melee2",
	startt=10/60,
	endt=20/60,
	pitch=5,
	yaw=45,
	roll=10,
	dir=-1
}
SWEP.Sequences[3]={
	name="swipe_r2l",
	holdtype="melee2",
	startt=10/60,
	endt=20/60,
	pitch=5,
	yaw=45,
	roll=-5,
	dir=1
}
]]--
SWEP.SlashRandom = Angle(5,0,10) --This is a random angle for the overall slash, added onto the sequence angle
SWEP.SlashJitter = Angle(1,1,1) --This is jitter for each point of the slash
SWEP.randfac = 0 --Don't change this, it's autocalculated

SWEP.HitRange=86 -- Blade Length.  Set slightly longer to compensate for animation.
SWEP.AmmoType="TFMSwordHitGenericSlash" --Ammotype.  You can set a damage type in a custom ammo, which you can create in autorun.  Then set it to that custom ammotype here.
SWEP.SlashPrecision = 15 --The number of traces per slash
SWEP.SlashDecals = 8 --The number of decals per slash.  May slightly vary
SWEP.SlashSounds = 6 --The number of sounds per slash.  May slightly vary. 
SWEP.LastTraceTime = 0 --Don't change this, it's autocalculated

SWEP.NextPrimaryFire=0--In case SetNextPrimaryFire doesn't work.  Don't change this here.  Please.

--[[Blocking Variables]]--

SWEP.BlockSequences={}--Sequences for blocking
--[[
SWEP.BlockSequences[1]={
	name="swipe_u2d", --Sequence name, can be found in HLMV
	recoverytime=0.3, --Recovery Time (Added onto sequence time, if enabled)
	recoverysequence=false  --Automatically add recovery time based on sequence length
}
SWEP.BlockSequences[2]={
	name="swipe_l2r",
	recoverytime=0.3,
	recoverysequence=false
}
SWEP.BlockSequences[3]={
	name="swipe_r2l",
	recoverytime=0.3,
	recoverysequence=false
}
]]--

SWEP.NinjaMode=false --Can block bullets/everything
SWEP.DrawTime=0.2--Time you can't swing after drawing
SWEP.BlockAngle=135--Think of the player's view direction as being the middle of a sector, with the sector's angle being this
SWEP.PrevBlocking=false--Don't change this, just related to the block procedural animation
SWEP.BlockProceduralAnimTime=0.15--Change how slow or quickly the player moves their sword to block

--[[Sounds]]--

--These are just kinda constants you can use.  Don't change these, or do if you want to be lazy.
SWEP.SlashSound	= Sound("weapons/blades/woosh.mp3") --Weapon woosh/slash sound
SWEP.KnifeShink = Sound("weapons/blades/hitwall.mp3") --When a knife hits a wall.  Grating noise.
SWEP.KnifeSlash = Sound("weapons/blades/slash.mp3")  --Meaty slash
SWEP.KnifeStab = Sound("weapons/blades/nastystab.mp3") --Meaty stab and pull-out
SWEP.SwordChop = Sound("weapons/blades/swordchop.mp3") --Meaty impact, without the pull-out
SWEP.SwordClash = Sound("weapons/blades/clash.mp3")  --Sound played when you block something

--[[ Edit These ]]--
SWEP.Primary.Sound = SWEP.SlashSound --Change this to your swing sound
SWEP.Primary.Sound_Impact_Flesh= SWEP.SwordChop --Change this to your flesh hit sound
SWEP.Primary.Sound_Impact_Generic = SWEP.KnifeShink --Change this to your generic hit sound
SWEP.Primary.Sound_Impact_Metal = SWEP.SwordClash --Change this to your metal hit
SWEP.Primary.Sound_Pitch_Low = 97 --Percentage of pitch out of 100, lowe end.  Up to 255.
SWEP.Primary.Sound_Pitch_High = 100 --Percentage of pitch out of 100  Up to 255.
SWEP.Primary.Sound_World_Glass_Enabled = true --Override for glass?
SWEP.Primary.Sound_Glass_Enabled = true --Override for glass?
SWEP.Primary.Sound_Glass=Sound("impacts/glass_impact.wav")

SWEP.GlassSoundPlayed=false -- DO NOT CHANGE THIS.  It's automatically set.   This way, it doesn't spam the glass sound.

SWEP.VElements = {}--View elements

SWEP.WElements = {}--World elements

SWEP.sounds = 0

--[[Stop editing here for normal users of my base.  Code starts here.]]--

function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

function SWEP:DoImpactEffect(tr, dmg)
	local impactpos, impactnormal, seq;
	seq = self.Sequences[self:GetNWInt("Slash",1)]
	impactpos=tr.HitPos
	impactnormal=tr.HitNormal
	self.sounds = self.sounds and self.sounds or 0
	if (tr.HitSky==false) then
		if (util.SharedRandom(CurTime(),1,self.SlashPrecision,"TFMSwordDecal")<self.SlashDecals) then
			local impactang,cutangle,tmpr;
			cutangle=Angle(seq.pitch,seq.yaw,seq.roll)
			util.Decal("ManhackCut", impactpos + impactnormal, impactpos - impactnormal )
		end
		if (tr.MatType==MAT_GLASS) and (self.Primary.Sound_Glass and self.Primary.Sound_Glass_Enabled==true) and (self.GlassSoundPlayed==false) then
			self.Weapon:EmitSound(self.Primary.Sound_Glass,100,math.random(self.Primary.Sound_Pitch_Low,self.Primary.Sound_Pitch_High),0.75,CHAN_WEAPON)
			self.GlassSoundPlayed=true
		end
	end
	return true
end

function SWEP:HitThing(ent, posv, normalv, damage, tr)
	local ply
	ply=self.Owner
	if IsValid(ply) then
		ply:LagCompensation(true)
		local tr,tres;
		tr={}
		tr.start=posv
		tr.endpos=posv+normalv*self.HitRange
		tr.filter=ply 
		tr.mask=2147483647--MASK_SOLID && MASK_SHOT && MASK_VISIBLE_AND_NPCS--MASK_SHOT
		tres=util.TraceLine(tr)
		ply:LagCompensation(false)
		if tres.Hit and tres.Fraction<1 and !tres.HitSky then
			local bullet = {}

			bullet.Num 	= num_bullets
			bullet.Src 	= posv-- Source
			bullet.Dir 	= normalv -- Dir of bullet
			
			bullet.Spread 	= vector_origin	 -- Aim Cone
			bullet.Tracer	= 1000 -- Show a tracer on every x bullets 
			bullet.Force	= damage/64 -- Amount of force to give to phys objects
			bullet.Damage	= damage
			
			bullet.AmmoType = self.AmmoType
			
			if CLIENT and SERVER then
				if self.Owner!=LocalPlayer() then
					self.Owner:FireBullets( bullet )
				end
			else
				self.Owner:FireBullets( bullet )
			end
			if (self.sounds<self.SlashSounds) then
				local hitmat=tres.MatType
				if (hitmat==MAT_METAL or hitmat==MAT_GRATE or hitmat==MAT_VENT or hitmat==MAT_COMPUTER) then
					--Emit metal sound
					self.Weapon:EmitSound(self.Primary.Sound_Impact_Metal,100,math.random(self.Primary.Sound_Pitch_Low,self.Primary.Sound_Pitch_High),0.75,CHAN_AUTO)
					self.sounds = self.sounds + 1
				elseif (hitmat==MAT_FLESH or hitmat==MAT_BLOODYFLESH or hitmat==MAT_ALIENFLESH ) then
					--Emit flesh sound
					self.Weapon:EmitSound(self.Primary.Sound_Impact_Flesh,100,math.random(self.Primary.Sound_Pitch_Low,self.Primary.Sound_Pitch_High),0.75,CHAN_AUTO)
					self.sounds = self.sounds + 1
				else
					--Emit generic sound.
					self.Weapon:EmitSound(self.Primary.Sound_Impact_Generic,100,math.random(self.Primary.Sound_Pitch_Low,self.Primary.Sound_Pitch_High),0.75,CHAN_AUTO)
					self.sounds = self.sounds + 1
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	
	if CurTime()<self:GetNextPrimaryFire() then return end
	
	if ( self:GetHolstering() ) then
		if (self.ShootWhileHolster==false) then
			return
		else
			self:SetHolsteringEnd(CurTime()-0.1)
			self:SetHolstering(false)
		end
	end
	
	if self:IsSafety() then return end
	
	if self:GetIronSightsRatio()>0.25 then return end
	
	if self:GetRunSightsRatio()>0.25 then return end
	
	if (self:GetChangingSilence()) then return end
	
	if (self:GetNearWallRatio()>0.05) then
		return
	end
	
	if !self:OwnerIsValid() then return end
	
	self:SetShooting(true)
	
	self.sounds = 0
	
	local success, tanim = self:ChooseShootAnim( ) -- View model animation
	local vm = self.Owner:GetViewModel()
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	self.Owner:SetNWFloat("TFM_SwingStart",CurTime())
	self:SetShootingEnd(CurTime()+self.Sequences[self:GetNWInt("Slash",1)].endt)
	
	self.LastTraceTime = CurTime() + self.Sequences[self:GetNWInt("Slash",1)].startt
	
	self:SetSpreadRatio(math.Clamp(self:GetSpreadRatio() + self.Primary.SpreadIncrement, 1, self.Primary.SpreadMultiplierMax))
	if ( CLIENT or game.SinglePlayer() ) and ( IsFirstTimePredicted() ) then
		self.CLSpreadRatio = math.Clamp(self.CLSpreadRatio + self.Primary.SpreadIncrement, 1, self.Primary.SpreadMultiplierMax)
	end
	self:SetBursting(true)
	
	self:SetNextBurst(CurTime()+1/(self.Primary.RPM/60))
	self:SetBurstCount(self:GetBurstCount()+1)
			
	self:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
	
	if SERVER then
		timer.Simple(self.Sequences[self:GetNWInt("Slash",1)].startt, function()
			if IsValid(self) then
				if self.Primary.Sound then
					self:EmitSound(self.Primary.Sound)
				end
			end
		end)
	end
end

function SWEP:Think()
	if !self:OwnerIsValid() then return end
	
	if self:GetShooting() then
		self:SetIronSights(false)
	end
	
	local ply;
	ply = self.Owner
	if self:GetShooting() then
		local ts,seq,ct,ft,len,strikepercent,swingprogress,sws,swe;
		seq = self.Sequences[self:GetNWInt("Slash",1)]
		ts=GetConVarNumber("host_timescale",1)
		ct=CurTime()
		ft=CurTime()-self.LastTraceTime
		len=seq.endt-seq.startt
		strikepercent=ft/len
		sws=ply:GetNWFloat("TFM_SwingStart",CurTime())+seq.startt
		swe=ply:GetNWFloat("TFM_SwingStart",CurTime())+seq.endt
		swingprogress=(CurTime()-sws)/len
		if (CurTime()>sws) then
			if ft>len/self.SlashPrecision then
				if (strikepercent>0) then
					local aimoff,cutangle,fac2,jitfac;
					aimoff=ply:GetAimVector():Angle()
					cutangle=Angle(seq.pitch*(swingprogress-0.5)*seq.dir,seq.yaw*(swingprogress-0.5)*seq.dir,seq.roll)
					jitfac = 0.5-util.SharedRandom("TFMSwordJitter",0,1,CurTime())
					
					aimoff:RotateAroundAxis(aimoff:Forward(),cutangle.r  + self.SlashRandom.r*self.randfac  + self.SlashJitter.r*jitfac)--Roll is static
					aimoff:RotateAroundAxis(aimoff:Up(),cutangle.y + self.SlashRandom.y*self.randfac  + self.SlashJitter.y*jitfac)
					aimoff:RotateAroundAxis(aimoff:Right(),cutangle.p + self.SlashRandom.p*self.randfac  + self.SlashJitter.p*jitfac)
					
					self:HitThing(ply,ply:GetShootPos(),aimoff:Forward(),self.Primary.Damage*strikepercent)
					self.LastTraceTime=CurTime()
				end
			end
		end
		if (CurTime()>swe) then
			self:SetShooting(false)
		end
	end
	
end

function SWEP:ChooseShootAnim()
	if !self:OwnerIsValid() then return end
	local ply = self.Owner
	vm = ply:GetViewModel()
	local relativedir = WorldToLocal(ply:GetVelocity(),Angle(0,0,0),vector_origin,ply:EyeAngles())
	
	local fwd = relativedir.x
	
	local hor = relativedir.y
	
	local selection = {}
	if hor<-ply:GetWalkSpeed()/2 then
		for k,v in pairs(self.Sequences) do
			if v.right then
				table.insert(selection,#selection+1,k)
			end
		end
	elseif hor>ply:GetWalkSpeed()/2 then
		for k,v in pairs(self.Sequences) do
			if v.left then
				table.insert(selection,#selection+1,k)
			end
		end
	elseif math.abs(fwd)>ply:GetWalkSpeed()/2 then
		for k,v in pairs(self.Sequences) do
			if (v.up or v.down) then
				table.insert(selection,#selection+1,k)
			end
		end
	end
	
	if #selection<=0 and math.abs(hor)<ply:GetWalkSpeed()/2 and math.abs(fwd)<ply:GetWalkSpeed()/2 then
		for k,v in pairs(self.Sequences) do
			if v.standing then
				table.insert(selection,#selection+1,k)		
			end
		end
	end
	
	if #selection<=0 then
		if math.random(1,2)==1 then
			self:SetNWInt("Slash",math.random(1,#self.Sequences))
		else
			self:SetNWInt("Slash",self:GetNWInt("Slash",1) + 1)
			if self:GetNWInt("Slash",1) > #self.Sequences then
				self:SetNWInt("Slash",1)
			end
		end
	else
		self:SetNWInt("Slash",selection[math.random(1,#selection)])
	end
	
	local seq
	seq = self.Sequences[self:GetNWInt("Slash",1)]
	vm:SendViewModelMatchingSequence(vm:LookupSequence(seq.name))
	return true, ACT_VM_DRAW
end

function SWEP:BlockAnim()
	if (self.BlockSequences) then
		if (#self.BlockSequences>0) then
			local blockseqn=math.random(1,#self.BlockSequences)
			local seq=self.BlockSequences[blockseqn]
			local ply=self.Owner
			if IsValid(ply) then
				local vm=ply:GetViewModel()
				if IsValid(vm) then
					self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
					vm:SendViewModelMatchingSequence(vm:LookupSequence(seq.name))		
					if seq.recoverysequence and seq.recoverysequence==true then
						if seq.recoverytime then
							self.NextPrimaryFire=CurTime()+vm:SequenceDuration()+seq.recoverytime
							self.Weapon:SetNextPrimaryFire(CurTime()+vm:SequenceDuration()+seq.recoverytime)
						else
							self.NextPrimaryFire=CurTime()+vm:SequenceDuration()
							self.Weapon:SetNextPrimaryFire(CurTime()+vm:SequenceDuration())
						end
					else
						self.NextPrimaryFire=CurTime()+seq.recoverytime
						if seq.recoverytime then
							self.NextPrimaryFire=CurTime()+seq.recoverytime
							self.Weapon:SetNextPrimaryFire(CurTime()+seq.recoverytime)
						else
							self.NextPrimaryFire=CurTime()
							self.Weapon:SetNextPrimaryFire(CurTime())
						end
					end
				end
			end
		end
	end
end