//easylua.StartWeapon("weapon_tackle")

//donezo 

function SWEP:Initialize()
	self:SetHoldType( "fist" )
end


zoomconvar = CreateClientConVar("tackle_zoom","1",true,false)
local zoom = 1
local inc = 0
local cinc = math.Clamp(inc, 0, 200)
	  
function SWEP:Deploy()
	if SERVER then
		self.Owner:SetMaxSpeed(5000)
	end
	return true
end
function SWEP:Think()
	if zoomconvar:GetInt()==1 then zoom = 1 else zoom = 0 end 
	if SERVER and self.Owner:IsValid() then	
		function accelerate()
				inc = inc + 1 
				cinc = math.Clamp(inc, 0, 200)	
				self.Owner:SetRunSpeed(400+cinc)	
			if zoom==1 then
				self.Owner:SetFOV(70,10)
			end
		end
		if self.Owner:KeyDown(IN_SPEED) then
			accelerate()
		else 
			self.Owner:SetFOV(0,0)
			//inc = 0
		end
		
		function tackle(ply)
			if!(ply.tackled) then
				ply.tackled = 0
			end
			if ply.tackled==0 then
				ply.tackled = 1
				inc = 0
				local sweps = ply:GetWeapons()
				ply:CrosshairDisable()		
				ply.pastsweps = {}
				local sweps = ply:GetWeapons()
				for k,v in pairs(sweps) do
					table.insert(ply.pastsweps, v:GetClass())
				end
				ply:StripWeapons()
				local ragdoll = ents.Create("prop_ragdoll")
				ragdoll:SetModel(ply:GetModel())
				ragdoll:SetPos(ply:GetPos()+Vector(0,0,0))
				ragdoll:SetAngles(ply:GetAngles())	
				ragdoll:Spawn()
				ragdoll:Activate()	
				ply:Spectate( OBS_MODE_CHASE )	
				ply:SpectateEntity( ragdoll )
				
				ragdoll:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity()*35)
				ragdoll:EmitSound(Sound( "Flesh.ImpactHard" ))
				local pain = {"vo/npc/male01/pain01.wav","vo/npc/male01/pain02.wav","vo/npc/male01/pain03.wav","vo/npc/male01/pain04.wav","vo/npc/male01/pain05.wav"}
				local random = math.random(1, #pain)
				ragdoll:EmitSound(pain[random])	
				timer.Simple(4, function()
					
					ply:Spawn()
					ply:SetPos(ragdoll:GetPos())
					ragdoll:Remove()
					for k,v in pairs(ply.pastsweps) do
						ply:Give(v)
					end
					ply:CrosshairEnable()
					ply.tackled = 0	
				end)
			end
		end
			
				
		function tacklenpc(ply)
			if!(ply.tackled) then
				ply.tackled = 0
			end
			if ply.tackled==0 then
				ply.tackled = 1
				inc = 0	
				local prevclass = ply:GetClass()
				local prevmodel = ply:GetModel()
				ply:Remove()
				local ragdoll = ents.Create("prop_ragdoll")
				ragdoll:SetModel(ply:GetModel())
				ragdoll:SetPos(ply:GetPos()+Vector(0,0,0))
				ragdoll:SetAngles(ply:GetAngles())	
				ragdoll:Spawn()
				ragdoll:Activate()	
				
				ragdoll:GetPhysicsObject():SetVelocity(self:GetOwner():GetVelocity()*35)
				ragdoll:EmitSound(Sound( "Flesh.ImpactHard" ))
				local pain = {"vo/npc/male01/pain01.wav","vo/npc/male01/pain02.wav","vo/npc/male01/pain03.wav","vo/npc/male01/pain04.wav","vo/npc/male01/pain05.wav"}
				local random = math.random(1, #pain)
				ragdoll:EmitSound(pain[random])	
				timer.Simple(4, function()
					ply = ents.Create(prevclass)
					ply:SetPos(ragdoll:GetPos())
					ply:Spawn()
					ply:SetModel(prevmodel)
					ragdoll:Remove()
					ply.tackled = 0	
				end)
			end
		end

	
	
		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_idle_0" .. math.random( 1, 2 ) ) )
		local walkspeed = self.Owner:GetWalkSpeed()
	
		local pos = self.Owner:GetPos()
		local tracedata = {}
	
		tracedata.start = pos
		tracedata.endpos = pos
		tracedata.filter = self.Owner
		tracedata.mins = self.Owner:OBBMins()*Vector(1.2,1.2,1.2)+Vector(0,0,30)
		tracedata.maxs = self.Owner:OBBMaxs()*Vector(1.2,1.2,1.2)+Vector(0,0,30)
	
		local trace = util.TraceHull( tracedata )
		if trace.Entity and trace.Entity:IsNPC() and trace.Entity:IsValid() and not trace.Entity:IsWorld() then
			
			eply = trace.Entity
			if cinc>150 then
				tacklenpc(eply)
			end
		end
		if trace.Entity and trace.Entity:IsPlayer() and trace.Entity:IsValid() and not trace.Entity:IsWorld() then
			
			eply = trace.Entity
			if cinc>150 then
				tackle(eply)
			end
		end

	end
end

function SWEP:Holster()
	
	if SERVER then
		self.Owner:SetFOV(90,0)
		self.Owner:SetRunSpeed(400)
		self.Owner:SetMaxSpeed(400)
	end
	return true
end

if ( CLIENT ) then
	
	SWEP.PrintName			= "Tackle Swep"	
	SWEP.Author				= "Simon"
	SWEP.DrawAmmo 			= false
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV			= 65 
	SWEP.ViewModelFlip		= false
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
end


SWEP.Category				= "Other"
SWEP.Base                   = "weapon_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
 

SWEP.ViewModel 				= Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel 			= ""
SWEP.UseHands = true
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.Automatic		=  false
SWEP.Primary.Ammo			=  "none"

SWEP.Secondary.Automatic	=  false
SWEP.Secondary.Ammo			=  "none"

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:CanSecondaryAttack()
	return false
end

function DoNothing() return end

SWEP.DrawHUD		= DoNothing


//easylua.EndWeapon(false, true)