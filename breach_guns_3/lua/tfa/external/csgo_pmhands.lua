TFA.CSGO = TFA.CSGO or {}

if not CLIENT then return end

if IsValid(TFA.CSGO.HandsEnt) then
	TFA.CSGO.HandsEnt:Remove()
	TFA.CSGO.HandsEnt = nil
end

local rigmdl = "models/weapons/tfa_csgo/c_hands_translator.mdl"

function TFA.CSGO.ParentHands(hands, vm, ply, wep) -- hey look no more drawmodel
	if not IsValid(hands) or not IsValid(vm) or not IsValid(wep) then return end

	if not wep.IsTFAWeapon or not wep.IsTFACSGOWeapon then return end

	if not IsValid(TFA.CSGO.HandsEnt) then
		TFA.CSGO.HandsEnt = ClientsideModel(rigmdl)
	end

	if not vm:LookupBone("ValveBiped.Bip01_R_Hand") then
		local newhands = TFA.CSGO.HandsEnt

		newhands:SetParent(vm)
		newhands:SetPos(vm:GetPos())
		newhands:SetAngles(vm:GetAngles())
		newhands:AddEffects(EF_BONEMERGE)
		newhands:AddEffects(EF_BONEMERGE_FASTCULL)

		hands:SetParent(newhands)
		hands:AddEffects(EF_BONEMERGE)
		hands:AddEffects(EF_BONEMERGE_FASTCULL)
	end
end

hook.Add("PreDrawPlayerHands", "TFA_CSGO_PreDrawPlayerHands", TFA.CSGO.ParentHands)