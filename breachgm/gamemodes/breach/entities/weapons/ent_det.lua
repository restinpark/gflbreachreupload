SWEP.PrintName = "Nuke Detonator"
SWEP.Author = "Aurora"
SWEP.Instructions = "Use primary attack to open up the menu."

function SWEP:Reload() end

function SWEP:SecondaryAttack() end

function SWEP:DrawWorldModel() end

function SWEP:Deploy()
    local o = self.Owner
    timer.Simple(0.1, function ()
        if o and IsValid(o) and SERVER then
            o:DrawViewModel(false)
        end
    end)
end
