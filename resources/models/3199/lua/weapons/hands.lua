SWEP.ViewModel = "models/weapons/alski/scp3199arms.mdl"
SWEP.Category = "Alski"
SWEP.UseHands = false
SWEP.Spawnable = true
SWEP.SetHoldType = "MELEE"
function SWEP:Initialize()
self:SetWeaponHoldType ( "MELEE" )
end

function SWEP:PrimaryAttack()
   local vm = self:GetOwner():GetViewModel()
local seq, time = vm:SelectWeightedSequence( ACT_VM_PRIMARYATTACK )
if seq > -1 then
     print( seq, time )
     vm:SendViewModelMatchingSequence( seq )
else
     print( "Niepoprawna animacja!" )
end
end

function SWEP:SecondaryAttack()
   local vm = self:GetOwner():GetViewModel()
local seq, time = vm:LookupSequence( "armsattacksecondary" )
if seq > -1 then
     print( seq, time )
     vm:SendViewModelMatchingSequence( seq )
else
     print( "Niepoprawna animacja!" )
end
end