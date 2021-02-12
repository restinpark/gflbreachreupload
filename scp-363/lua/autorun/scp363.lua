AddCSLuaFile()
--SCP_378_MODEL = "models/tsbb/animals/giant_isopod.mdl"
SCP_378_MODEL = "models/player/kerry/class_scientist_1.mdl"
ROLE_SCP378 = ROLE_SCP378 or "SCP-378"
if SERVER then
    include('breach_components/brainworms.lua')
    AddCSLuaFile('breach_components/brainwormscl.lua')
else
    include('breach_components/brainwormscl.lua')
end
