AddCSLuaFile()
ENT.Type = "anim"
ENT.Category = "Breach"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.Contact = "Aurora"

ENT.HitPos = Vector(0,0,0)

function ENT:Initialize()
    self.HitPos = self:GetPos()
    self:SetColor(Color(255,255,255,0))
    self:DrawShadow(false)
end

--Regular hexagon with a radius of 125 units, origin is Vector(0,0,0)


ENT.cverts = {}

ENT.color = Color(0,128,0, 50)


function ENT:BeginActivation()
    if SERVER then
        timer.Create("ent.strange.", 0.1, 1, function ()
            plys = ents.FindInSphere(self.HitPos, 250)
            for k,v in pairs(plys) do
		if v and IsValid(v) and v:IsPlayer() and v:Team() != TEAM_SPEC and v:Team() != TEAM_SCP then
                local p = v:GetPos()
                local d = DamageInfo()
                d:SetDamage(30)
                d:SetDamageType(DMG_BUCKSHOT)
                if not self.Owner or not IsValid(self.Owner) then
                    self.Owner = v
                end
                d:SetAttacker(self.Owner)
                v:TakeDamageInfo(d)
				v:SetNWString("409", "infect")
				v:PrintMessage(3, "Shards of crystal enter your body!")
		local e2 = self

            end
	end
	self:Remove()
        end)
    else
        local ent = self

    end
end


if SERVER then

    function ENT:SSetMiddleAndStart(v)
        self.HitPos = v
        self:BeginActivation()
    end
end

function ENT:Draw()
local defverts = {
    [1] = {s = Vector(62, -108, 0), e = Vector(-63, -108, 0)},
    [2] = {s = Vector(-63, -108, 0), e = Vector(-125, 0, 0)},
    [3] = {s = Vector(-125, 0, 0), e = Vector(-62, 108, 0)},
    [4] = {s = Vector(-62, 108, 0), e = Vector(62, 108, 0)},
    [5] = {s = Vector(62, 108, 0), e = Vector(125, 0, 0)},
    [6] = {s = Vector(125, 0, 0), e = Vector(62, -108, 0)}
}
    local verts = {}
    for k, vert in pairs(defverts) do
	verts[k] = {}
        verts[k].s = vert.s + self:GetPos()
	verts[k].e = vert.e + self:GetPos()
    end
    for k,v in pairs(verts) do
        cam.Start3D()
        cam.End3D()
    end
end

