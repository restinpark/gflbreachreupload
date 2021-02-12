AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

    self:SetModel( "models/props_interiors/VendingMachineSoda01a.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetTrigger(true)
    local phys = self:GetPhysicsObject()
    self:SetCollisionGroup(1)
    self:SetNoDraw(true)
    if phys:IsValid() then
        phys:Wake()
        phys:EnableMotion(false)
    end

end


function ENT:Touch( toucher )
    local chance = math.random(1, 8)
    local position = { Vector(2293.715088, 4608.422363, 539.246948), Vector(3718.465332, 4854.203125, 715.150085), Vector(2128.662354, 6080.686035, 364.773407), Vector(1755.453491, 6079.102051, 156.031250), Vector(2235.683350, 4301.388672, 27.775829), Vector(3522.806396, -221.801651, 64.599335) }
    if ( toucher:IsValid() and toucher:IsPlayer() ) and chance == 1 then
    for k,v in pairs(player.GetAll()) do
	if v:GetNClass() == ROLE_SCP106 then
		v:AddFrags(3)
		end
	end
            toucher:Kill() --it's 2020, no more touching or capital punishment will be given
    elseif ( toucher:IsValid() and toucher:IsPlayer() ) and chance >= 1 then
	if toucher.GiveAchievement then
		toucher:GiveAchievement("Escape")
        toucher:SetPos( table.Random(position) )
		end
    end
end

