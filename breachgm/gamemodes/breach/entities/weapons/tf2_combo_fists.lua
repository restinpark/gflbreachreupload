if CLIENT then
    SWEP.PrintName = "SCP-3331"
    SWEP.Slot = 3
    SWEP.SlotPos = 3
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
    
    if(file.Exists("materials/vgui/killicons/cf_killicon.vmt","GAME")) then
        killicon.Add("tf2_combo_fists","VGUI/killicons/cf_killicon",Color(255,255,255));
    end
    
    surface.CreateFont("Trebuchet24Outlined",{font = "Trebuchet24", size = 24,weight = 400})
	surface.CreateFont("Trebuchet24Outlined",{font = "Trebuchet24", size = 24,weight = 400})
    
end
print("hello from shared.lua")
if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.Instructions    = "Left click for a left-hand swing \nRight click for a right-hand swing \nReload to enable a combo when the combo points change color."
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 50
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true
SWEP.droppable				= false

SWEP.ViewModel      = "models/weapons/v_models/v_fist_heavy.mdl"
SWEP.WorldModel   = ""
  
-- Primary Fire Attributes --
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 0
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0
SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic       = false    
SWEP.Primary.Ammo             = "none"
 
-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots        = 1
SWEP.Secondary.Cone            = 0
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

-- Various configs --
SWEP.SwingDelay1 = 0.35
SWEP.SwingDelay2 = 0.25
SWEP.LeftDamage = 30
SWEP.RightDamage = 30
SWEP.QuickHitTime = 0
SWEP.SwingDelayMod = 1
SWEP.CanGetComboPoints = true
SWEP.ComboDelay = 0
SWEP.ProvokeTime = 0

if SERVER then

    function ExplosivePunches(ply, wep)
        wep.ExplosivePunches = true
        wep.CanGetComboPoints = false
            
        timer.Simple(5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.ExplosivePunches = false
            wep.CanGetComboPoints = true
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(1)
        umsg.End()
    end

    function DDLeft(ply, wep)
        wep.LeftDamage = wep.LeftDamage * 2
        wep.CanGetComboPoints = false
            
        timer.Simple(5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.LeftDamage = wep.LeftDamage / 2
            wep.CanGetComboPoints = true
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(2)
        umsg.End()
    end
    
    function DDRight(ply, wep)
        wep.RightDamage = wep.RightDamage * 2
        wep.CanGetComboPoints = false
            
        timer.Simple(5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.RightDamage = wep.RightDamage / 2
            wep.CanGetComboPoints = true
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(3)
        umsg.End()
    end
    
    function SwiftStrikes(ply, wep)
        wep.SwingDelayMod = 1.4
        wep.CanGetComboPoints = false
        
        timer.Simple(5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.SwingDelayMod = 1
            wep.CanGetComboPoints = true
        end)
        
        umsg.Start("CFC", ply)
            umsg.Short(4)
        umsg.End()
    end
    
    function Uppercut(ply, wep)
        wep:SetNextPrimaryFire(CurTime() + 1)
        wep:SetNextSecondaryFire(CurTime() + 1)
        wep.ComboDelay = CurTime() + 1
        if IsFirstTimePredicted() then
            wep:SendWeaponAnim(ACT_VM_SWINGHARD)
        end
    
        timer.Simple(0.1, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
			
            ply:ViewPunch(Angle(-10, 0, 0))
            local aimVec = ply:GetAimVector()
            local td = {}
            td.start = ply:GetShootPos()
            td.endpos = td.start + aimVec * 55
            td.filter = ply
            td.mins = Vector(-8, -8, -8)
            td.maxs = Vector(8, 8, 8)
                
            local trace = util.TraceHull(td)
                
            if trace.Hit then
            
                local phys = trace.Entity:GetPhysicsObject()
            
                if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
                    ply:EmitSound(table.Random(wep.HitHuman), 80, 100)
                else
                    ply:EmitSound(table.Random(wep.HitElse), 80, 100)
                        
                    if phys:IsValid() then
                        phys:AddVelocity(aimVec * 260)
                    end
                end
                
                if trace.Entity:Health() > 0 then
                    trace.Entity:TakeDamage(wep.LeftDamage * 1.5, ply, ply)
                end
            
                ply:EmitSound("physics/body/body_medium_break3.wav", 85, 100)
                ply:SetAnimation( PLAYER_ATTACK1 )
                //ParticleEffect("cf_hit", trace.HitPos, ply:EyeAngles(), nil)
            
            end
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(5)
        umsg.End()
    end
    
    function Charge(ply, wep)
        local aimVec = ply:GetAimVector()
        local vel = ply:GetVelocity()
        local runSpeed = ply:GetRunSpeed() * 5
        ply:SetLocalVelocity(Vector(aimVec.x * runSpeed, aimVec.y * runSpeed, vel.z))
        wep.CanGetComboPoints = false
        
        wep:SetNextPrimaryFire(CurTime() + 1.25)
        wep:SetNextSecondaryFire(CurTime() + 1.25)
        wep.ComboDelay = CurTime() + 1.25

        timer.Simple(0.25, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            if IsFirstTimePredicted() then
                wep:SendWeaponAnim(ACT_VM_SWINGHARD)
            end
            
            timer.Simple(0.1, function()
			
				if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
					return
				end
				
                ply:ViewPunch(Angle(-10, 0, 0))
                local aimVec = ply:GetAimVector()
                local td = {}
                td.start = ply:GetShootPos()
                td.endpos = td.start + aimVec * 55
                td.filter = ply
                td.mins = Vector(-8, -8, -8)
                td.maxs = Vector(8, 8, 8)
                    
                local trace = util.TraceHull(td)
                    
                if trace.Hit then
                
                    local phys = trace.Entity:GetPhysicsObject()
                
                    if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
                        ply:EmitSound(table.Random(wep.HitHuman), 80, 100)
                        
                        trace.Entity:SetVelocity(Vector(aimVec.x * 1500, aimVec.y * 1500, 400))
                    else
                        ply:EmitSound(table.Random(wep.HitElse), 80, 100)
                            
                        if phys:IsValid() then
                            phys:AddVelocity(aimVec * 500)
                        end
                    end
                    
                    if trace.Entity:Health() > 0 then
                        trace.Entity:TakeDamage(wep.LeftDamage * 3.5, ply, ply)
                    end
                
                    ply:EmitSound("physics/body/body_medium_break3.wav", 85, 100)
                    ply:SetAnimation( PLAYER_ATTACK1 )
                
                end
                
                wep.CanGetComboPoints = true
            end)
        end)
            

        umsg.Start("CFC", ply)
            umsg.Short(6)
        umsg.End()
    end
    
    function ThreeHander(ply, wep)
        wep.CanGetComboPoints = false
        wep:SetNextPrimaryFire(CurTime() + 0.6)
        wep:SetNextSecondaryFire(CurTime() + 0.6)
        wep.ComboDelay = CurTime() + 0.6
        wep:Swing(ACT_VM_HITLEFT, wep.LeftDamage * 1.3, nil)
        
        timer.Simple(0.15, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep:Swing(ACT_VM_HITRIGHT, wep.RightDamage * 1.3, nil)
        end)
        
        timer.Simple(0.3, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep:Swing(ACT_VM_HITLEFT, wep.LeftDamage * 1.3, nil)
        end)
        
        timer.Simple(0.5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.CanGetComboPoints = true
        end)
        
        umsg.Start("CFC", ply)
            umsg.Short(7)
        umsg.End()
    end
    
    function QDLeft(ply, wep)
        wep.LeftDamage = wep.LeftDamage * 4
        wep.CanGetComboPoints = false
            
        timer.Simple(5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.LeftDamage = wep.LeftDamage / 4
            wep.CanGetComboPoints = true
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(8)
        umsg.End()
    end
    
    function QDRight(ply, wep)
        wep.RightDamage = wep.RightDamage * 4
        wep.CanGetComboPoints = false
            
        timer.Simple(5, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            wep.RightDamage = wep.RightDamage / 4
            wep.CanGetComboPoints = true
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(9)
        umsg.End()
    end
	
    function DisintegratingPunch(ply, wep)
        wep:SetNextPrimaryFire(CurTime() + 1)
        wep:SetNextSecondaryFire(CurTime() + 1)
        wep.ComboDelay = CurTime() + 1
		
        if IsFirstTimePredicted() then
            wep:SendWeaponAnim(ACT_VM_SWINGHARD)
        end
    
        timer.Simple(0.1, function()
		
			if not IsValid(ply) or not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end
		
            ply:ViewPunch(Angle(-10, 0, 0))
            local aimVec = ply:GetAimVector()
            local td = {}
            td.start = ply:GetShootPos()
            td.endpos = td.start + aimVec * 55
            td.filter = ply
            td.mins = Vector(-8, -8, -8)
            td.maxs = Vector(8, 8, 8)
                
            local trace = util.TraceHull(td)
                
            if trace.Hit then
            
                local phys = trace.Entity:GetPhysicsObject()
            
                if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
                    ply:EmitSound(table.Random(wep.HitHuman), 80, 100)
                else
                    ply:EmitSound(table.Random(wep.HitElse), 80, 100)
                        
                    if phys:IsValid() then
                        phys:AddVelocity(aimVec * 260)
                    end
                end
                
                if trace.Entity:Health() > 0 then
					local dmginfo = DamageInfo()
					dmginfo:SetDamage(wep.LeftDamage * 6)
					dmginfo:SetDamageType(DMG_DISSOLVE)
					dmginfo:SetAttacker(ply)
                    trace.Entity:TakeDamageInfo(dmginfo)
                end
            
                ply:EmitSound("physics/body/body_medium_break3.wav", 85, 100)
                ply:SetAnimation( PLAYER_ATTACK1 )
				
				local ED = EffectData()
				ED:SetStart(trace.HitPos)
				ED:SetOrigin(trace.HitPos)
				ED:SetScale(1)
				
				util.Effect("cball_explode", ED)
            end
        end)
            
        umsg.Start("CFC", ply)
            umsg.Short(10)
        umsg.End()
    end
    
    SWEP.Combos = {
        ["DDLeft"] = {left = 3, right = 1, func = DDLeft},
        ["DDRight"] = {left = 1, right = 3, func = DDRight},
        ["ExplosivePunches"] = {left = 5, right = 5, func = ExplosivePunches},
        ["SwiftStrikes"] = {left = 2, right = 2, func = SwiftStrikes},
        ["Uppercut"] = {left = 1, right = 1, func = Uppercut},
        ["Charge"] = {left = 3, right = 3, func = Charge},
        ["ThreeHanderA"] = {left = 2, right = 1, func = ThreeHander},
        ["ThreeHanderB"] = {left = 1, right = 2, func = ThreeHander},
        ["QDLeft"] = {left = 5, right = 1, func = QDLeft},
        ["QDRight"] = {left = 1, right = 5, func = QDRight},
		["DisintegratingPunch"] = {left = 4, right = 4, func = DisintegratingPunch}
            }

end

function SWEP:DrawWorldModel()
	return false
end

function SWEP:Initialize()
    self:SetWeaponHoldType("fist")
    
    self.Weapon:SetDTInt(0, 0)
    self.Weapon:SetDTInt(1, 0)
    
    self.ComboHit = {
    Sound("player/crit_hit.wav"),
    Sound("player/crit_hit2.wav"),
    Sound("player/crit_hit3.wav"),
    Sound("player/crit_hit4.wav"),
    Sound("player/crit_hit5.wav")    }
    self.HitHuman = {
    Sound("weapons/cbar_hitbod1.wav"),
    Sound("weapons/cbar_hitbod2.wav"),
    Sound("weapons/cbar_hitbod3.wav")    }
    
    self.HitElse = {
    Sound("weapons/fist_hit_world1.wav"),
    Sound("weapons/fist_hit_world2.wav")   }
    
    self.DrawSounds = {
    Sound("weapons/metal_hit_hand1.wav"),
    Sound("weapons/metal_hit_hand2.wav"),
    Sound("weapons/metal_hit_hand3.wav")   }
    
    self.PushElse = {
    Sound("physics/body/body_medium_impact_hard1.wav"),
    Sound("physics/body/body_medium_impact_hard2.wav"),
    Sound("physics/body/body_medium_impact_hard3.wav"),
    Sound("physics/body/body_medium_impact_hard4.wav"),
    Sound("physics/body/body_medium_impact_hard5.wav"),
    Sound("physics/body/body_medium_impact_hard6.wav") }
    
    self.Provoke = {
    Sound("vo/heavy_meleedare01.wav"),
    Sound("vo/heavy_meleedare03.wav"),
    Sound("vo/heavy_meleedare04.wav"),
    Sound("vo/heavy_meleedare05.wav"),
    Sound("vo/heavy_meleedare06.wav"),
    Sound("vo/heavy_meleedare11.wav"),
    Sound("vo/heavy_domination02.wav"),        
    Sound("vo/heavy_domination13.wav"),    
    Sound("vo/heavy_revenge05.wav") }
    
    self.DrawTalk = {
    Sound("vo/heavy_meleedare01.wav"),
    Sound("vo/heavy_meleedare02.wav"),
    Sound("vo/heavy_meleedare03.wav"),
    Sound("vo/heavy_meleedare04.wav"),
    Sound("vo/heavy_meleedare05.wav"),
    Sound("vo/heavy_meleedare06.wav"),
    Sound("vo/heavy_meleedare07.wav"),
    Sound("vo/heavy_meleedare09.wav"),
    Sound("vo/heavy_meleedare10.wav"),
    Sound("vo/heavy_meleedare11.wav"),
    Sound("vo/heavy_meleedare12.wav"),
    Sound("vo/heavy_meleedare13.wav") }
end

function SWEP:Precache()
end

function SWEP:Think()
    
    if SERVER then
        if CurTime() < self.QuickHitTime then -- If we can keep up the left-right hand swinging/hitting pace, then
            self.Weapon.SwingDelay1 = 0.2 / self.Weapon.SwingDelayMod -- Let us swing abit faster!
            self.Weapon.SwingDelay2 = 0.2 / self.Weapon.SwingDelayMod -- Let us swing abit faster!
        else -- Otherwise
            self.Weapon.SwingDelay1    = 0.35 / self.Weapon.SwingDelayMod -- Make us swing with default speed
            self.Weapon.SwingDelay2    = 0.25 / self.Weapon.SwingDelayMod -- Make us swing with default speed
        end
        
        if self.Owner:KeyPressed(IN_RELOAD) then
            if CurTime() > self.Weapon.ComboDelay then
                for k, v in pairs(self.Weapon.Combos) do
                    if self.Weapon:GetDTInt(0) == v.left and self.Weapon:GetDTInt(1) == v.right then
                        v.func(self.Owner, self.Weapon)
                        self.Weapon:SetDTInt(0, 0)
                        self.Weapon:SetDTInt(1, 0)
                        break
                    end
                end
            end
        end
    end
    
end

function SWEP:Deploy()
    self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
    
	if CurTime() > self.Weapon.ProvokeTime then
		self.Weapon:EmitSound(table.Random(self.DrawTalk))
		self.Weapon.ProvokeTime = CurTime() + 3
	end
	
    self:SetNextPrimaryFire(CurTime() + 0.7)
    self:SetNextSecondaryFire(CurTime() + 0.7)
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:Reload()
    return false
end

function SWEP:PrimaryAttack()
    //if SERVER then
    
        if not IsValid(self.Weapon) or not self.Owner or not self.Owner:Alive() then
            return
        end
        
        self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.SwingDelay1)
        self.Weapon:SetNextSecondaryFire(CurTime() + self.Weapon.SwingDelay2)
        
        self.Weapon:Swing(ACT_VM_HITLEFT, self.Weapon.LeftDamage, 0)
    
    //end
end

function SWEP:SecondaryAttack()
        if not IsValid(self.Weapon) or not self.Owner or not self.Owner:Alive() then
            return
        end
        
        self.Weapon:SetNextPrimaryFire(CurTime() + self.Weapon.SwingDelay2)
        self.Weapon:SetNextSecondaryFire(CurTime() + self.Weapon.SwingDelay1)
        
        self.Weapon:Swing(ACT_VM_HITRIGHT, self.Weapon.RightDamage, 1)
    
end

function SWEP:Swing(anim, damage, dtint)
    if IsFirstTimePredicted() then
        self.Weapon:SendWeaponAnim(anim or ACT_VM_HITLEFT)
    end
    
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:ViewPunch(Angle(math.random(-1, 1), anim == ACT_VM_HITRIGHT and 2 or -2, math.random(-1, 1)))
        
    if SERVER then
    
        self.Owner:EmitSound("weapons/bat_draw_swoosh1.wav", 80, math.random(95, 105))
        self.Weapon.QuickHitTime = CurTime() + 0.3
        self.Weapon.ComboDelay = CurTime() + 0.2
    
        timer.Simple(0.1, function()
            
            if not IsValid(self.Weapon) or not self.Owner or not self.Owner:Alive() then
                return
            end
                
            local aimVec = self.Owner:GetAimVector()
        
            local td = {}
            td.start = self.Owner:GetShootPos()
            td.endpos = td.start + aimVec * 55
            td.filter = self.Owner
            td.mins = Vector(-8, -8, -8)
            td.maxs = Vector(8, 8, 8)
            
            local trace = util.TraceHull(td)
            
            if trace.Hit then
            
                local phys = trace.Entity:GetPhysicsObject()
            
                if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
                    self.Owner:EmitSound(table.Random(self.HitHuman), 80, 100)
                    if self.Weapon.CanGetComboPoints then
                        self.Weapon:SetDTInt(dtint, math.Clamp(self.Weapon:GetDTInt(dtint) + 1, 0, 5))
                    end
                else
                    self.Owner:EmitSound(table.Random(self.HitElse), 80, 100)
                    self.Weapon:SetDTInt(dtint, 0)
                        
                    if phys:IsValid() then
                        phys:AddVelocity(aimVec * 130)
                    end
                end
                
                if trace.Entity:Health() > 0 then
                    trace.Entity:TakeDamage(math.random(damage, damage + 5), self.Owner, self.Owner)
                end
                
                if self.Weapon.ExplosivePunches then
                    self.Owner:EmitSound("weapons/rocket_directhit_explode" .. math.random(1, 3) .. ".wav", 90, math.random(95, 105))
                    ParticleEffect("cstm_incendiary_hit", trace.HitPos, self.Owner:EyeAngles(), nil)
                    util.BlastDamage(self.Owner, self.Owner, trace.Entity:GetPos(), 2, damage * 3)
                    trace.Entity:Ignite(5)
                end
            
            end
        end)
    end
end
    
if CLIENT then

    local Combos = {}
    local ComboAlpha = 0
    local ComboType = 0
    local ComboAlphaTime = 0
    local ComboText = ""
    
    function RegisterCombo(left, right, color, num, text, textduration)
        table.insert(Combos, {left = left, right = right, color = color, num = num, text = text, textduration = textduration})
    end

    RegisterCombo(5, 5, Color(200, 10, 10, 255), 1, "Explosive Punches!", 5)
    RegisterCombo(3, 1, Color(255, 165, 0, 255), 2, "Double left-hand Damage!", 5)
    RegisterCombo(1, 3, Color(255, 165, 0, 255), 3, "Double right-hand Damage!", 5)
    RegisterCombo(2, 2, Color(255, 255, 0, 255), 4, "Swift Strikes!", 5)
    RegisterCombo(1, 1, Color(255, 255, 0, 255), 5, "Uppercut!", 2)
    RegisterCombo(3, 3, Color(160, 255, 0, 255), 6, "Charge!", 2)
    RegisterCombo(2, 1, Color(0, 255, 255, 255), 7, "Three-Hander!", 2)
    RegisterCombo(1, 2, Color(0, 255, 255, 255), 7, "Three-Hander!", 2)
    RegisterCombo(5, 1, Color(255, 50, 50, 255), 8, "Quad left-hand Damage!", 5)
    RegisterCombo(1, 5, Color(255, 50, 50, 255), 9, "Quad right-hand Damage!", 5)
	RegisterCombo(4, 4, Color(0, 165, 165, 255), 10, "Dis-integrating Punch!", 2)
    
    local function CF_ReceiveData(um)
        ComboType = um:ReadShort()
        
        for k, v in pairs(Combos) do
            if ComboType == v.num then
                ComboText = v.text
                ComboAlphaTime = CurTime() + v.textduration
                break
            end
        end
        
        ComboAlpha = 0
        surface.PlaySound("weapons/combofists/combo_enable1.wav")
    end
    
    usermessage.Hook("CFC", CF_ReceiveData)

    function SWEP:DrawHUD()
        local DTInt0 = self.Weapon:GetDTInt(0)
        local DTInt1 = self.Weapon:GetDTInt(1)
        local Width = ScrW()
        local Height = ScrH()
		local color = nil -- reset the color
		local text = nil -- reset the text
        
        for k, v in pairs(Combos) do
            if DTInt0 == v.left and DTInt1 == v.right then
                color = v.color
				text = v.text
                break
            end
        end

        for i = 1, DTInt0 do
            draw.RoundedBox(4, Width * 0.5 - 50, (Height * 0.5 + 30) - i * 10, 15, 6, Color(0, 0, 0, 255))
            draw.RoundedBox(2, Width * 0.5 - 49, (Height * 0.5 + 31) - i * 10, 13, 4, color or Color(255, 255, 255, 255))
        end
        
        for i = 1, DTInt1 do
            draw.RoundedBox(4, Width * 0.5 + 37, (Height * 0.5 + 30) - i * 10, 15, 6, Color(0, 0, 0, 255))
            draw.RoundedBox(2, Width * 0.5 + 38, (Height * 0.5 + 31) - i * 10, 13, 4, color or Color(255, 255, 255, 255))
        end
        
        surface.SetDrawColor(0, 0, 0, 125)
        surface.DrawRect(Width * 0.5 - 2, Height * 0.5 -  1, 6, 6)
        
        surface.SetDrawColor(255, 255, 255, 150)
        surface.DrawRect(Width * 0.5 - 1, Height * 0.5, 4, 4)
        
        if CurTime() < ComboAlphaTime then
            ComboAlpha = Lerp(0.08, ComboAlpha, 255)
        else
            ComboAlpha = Lerp(0.3, ComboAlpha, 0)
        end
        
        if ComboAlpha > 0 then
            draw.SimpleText(ComboText, "Trebuchet24Outlined", Width * 0.5 + math.random(-3, 3), Height * 0.5 + 100 + math.random(-3, 3), Color(255, 255, 255, ComboAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            
            for i = 1, 3 do
                draw.SimpleText(ComboText, "Trebuchet24Outlined", Width * 0.5 + math.random(-3, 3), Height * 0.5 + 100 + math.random(-3, 3), Color(255, 255, 255, ComboAlpha * 0.4), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
		
		if text then
			draw.SimpleText(text, "ChatFont", Width * 0.5, Height * 0.5 + 65, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
        
        return true
    end
    
end
