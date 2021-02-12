AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/vinrax/props/cup_294.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetNWBool("IsFilled", false)
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
	phys:Wake()
	end
	timer.Simple(10, function()
		if IsValid(self) then
			self:Remove()
		end
	end)
end

function ENT:SetDrink(drink)
	if not DRINKINDEX[drink] then
		return
	end
	self:SetNWBool("IsFilled", true)
	self:SetNWBool("Contents", drink)
	self:SetNWVector("Color", Vector(DRINKINDEX[drink].color.r, DRINKINDEX[drink].color.g, DRINKINDEX[drink].color.b))
end

function ENT:Use( ply, caller )
	if ply:Team() ~= TEAM_SCP and ply:Team() ~= TEAM_SPEC and self:GetNWBool("IsFilled", false) then
		
		local drink = self:GetNWBool("Contents", "nothing")
		
		if drink == "nothing" then
			self:SetNWBool("IsFilled", false)
			SafeRemoveEntityDelayed(self, 0)
			return
		end

		if not DRINKINDEX[drink] then return end

		DRINKINDEX[drink].OnDrink(self, ply)

		hook.Run("SCP294_ConsumeDrink", DRINKINDEX[drink], ply)

		ply:EmitSound("scp294/slurp.ogg")
		self:SetNWBool("IsFilled", false)

		timer.Simple(1, function ()
			if self and IsValid(self) then
				SafeRemoveEntity(self)
			end
		end)

		local canidates = ents.FindInSphere(ply:GetPos(), 200)

        local scp294 = nil

        for k,v in pairs(canidates) do
            if v and IsValid(v) and v:GetClass() == "scp294" then
                scp294 = v
                break
            end
        end

        if not scp294 or not IsValid(scp294) then
            return
		end
		
		scp294.NextCupSpawn = CurTime()
		
		if SERVER and ply:GetNWString("Sign", "unset") == "5" then
					if ply:GetAmmoCount(12) > 9 then
					ply:Give(table.Random({"weapon_scp512", "scp_127", "weapon_scp_500", "svn_kar98k", "weapon_scp_1290", "weapon_scp_005", "est_fl", "toybox_crowbar"}))
					ply:PrintMessage(3, "Contract Complete!")
					ply:StripWeapon("weapon_scp_350")
					ply:SetNWString("350", "clear")
					ply:SetNWString("Sign", "clear")
					else
					ply:GiveAmmo(1, "AlyxGun", true)
				end
			end

	end
end

function ENT:Think() end

function ENT:OnRemove()end
