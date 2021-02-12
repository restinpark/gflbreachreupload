SWEP.PrintName = "SCP-079"
SWEP.Author = "Aurora"
SWEP.Instructions = "Primary to TELEPORT, Secondary to SET TELEPORT. Reload to GO HOME."
AddCSLuaFile()
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Secondary = SWEP.Primary
SWEP.ItemType = WEAPON_SCP or 12
SWEP.DrawCrosshair = true
--Breach stuff
SWEP.droppable = false

local TELEPORT_DELAY = 30
SWEP.NextTeleportAction = 0

--Make hold model invisible
function SWEP:DrawWorldModel() end

function SWEP:Think()
if preparing or postround then
if game.GetMap() == "br_site19" then
	self.Owner:Freeze(true)
		end
	end
end

if SERVER then
    --Make view model invisible
    function SWEP:Deploy()
        timer.Simple(0, function ()
            if self and IsValid(self) and self.Owner and IsValid(self.Owner) and self.Owner:IsPlayer() then
                self.Owner:DrawViewModel(false)
            end
        end)
		timer.Create("block1", 1, 0, function() end)
		timer.Create("block2", 1, 0, function() end)
		timer.Create("block3", 1, 0, function() end)
		timer.Create("block4", 1, 0, function() end)
		timer.Simple(150, function() timer.Remove("block1") end)
		timer.Simple(200, function() timer.Remove("block2") end)
		timer.Simple(250, function() timer.Remove("block3") end)
		timer.Simple(300, function() timer.Remove("block4") end)
    end
end

--Teleport to the set position
function SWEP:PrimaryAttack()
if preparing or postround then return end
	if not IsFirstTimePredicted() then return end
		if self.NextTeleportAction > CurTime() then return end
		self.NextTeleportAction = CurTime() + TELEPORT_DELAY
			if game.GetMap() == "br_site19" then
				if self.Owner:GetNWString("tp", "unset") == "lcz1" then
					self.Owner:SetPos(Vector(-457.250763, -827.305969, 64.370964))
				elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
					self.Owner:SetPos(Vector(1477.438477, -191.967133, 63.889481))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(4168.347656, 486.894806, 54.063988))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(4151.001465, 2368.437012, 54.364647))
				elseif self.Owner:GetNWString("tp", "unset") == "ez" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-441.045197, 3028.638672, 53.063713))
				elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
					self.Owner:SetPos(Vector(1783.017944, -769.229614, -713.454956))
				elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
					self.Owner:SetPos(Vector(4795.722168, -2503.778320, 72.029373))
				elseif self.Owner:GetNWString("tp", "unset") == "ext" then
				if timer.Exists("block4") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-2879.129639, 5302.791992, 2231.187988))
	end
end
			if game.GetMap() == "br_area02_v3" then
				if self.Owner:GetNWString("tp", "unset") == "lcz1" then
					self.Owner:SetPos(Vector(6948.534180, 2676.942871, -128.531143))
				elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
					self.Owner:SetPos(Vector(6947.544922, -1431.453125, -128.594284))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(6509.869141, 2595.629639, -1215.096680))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(4064.652588, 4542.507813, -1216.544434))
				elseif self.Owner:GetNWString("tp", "unset") == "ez" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(2936.828369, 580.669128, 55.963833))
				elseif self.Owner:GetNWString("tp", "unset") == "ext" then
				if timer.Exists("block4") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-2491.500977, -2068.145752, 256.981201))
	end
end
			if game.GetMap() == "br_area96" then
				if self.Owner:GetNWString("tp", "unset") == "lcz1" then
					self.Owner:SetPos(Vector(-4739.900391, -1100.595093, 74.860512))
				elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
					self.Owner:SetPos(Vector(-2579.787354, -1404.030640, 83.568184))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(2712.325684, -1465.754639, 71.654282))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(34.663486, -4085.189697, 73.641075))
				elseif self.Owner:GetNWString("tp", "unset") == "ez" then
					if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(4035.608887, 2046.033813, 72.144485))
				elseif self.Owner:GetNWString("tp", "unset") == "ext" then
					if timer.Exists("block4") then
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(7934.766602, 2603.580566, 1.379345))
	end
end
				if game.GetMap() == "br_site05_v2" then
				if self.Owner:GetNWString("tp", "unset") == "lcz1" then
					self.Owner:SetPos(Vector(794.808716, 13348.831055, -1882.973022))
				elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
					self.Owner:SetPos(Vector(-3679.005859, 12790.000977, -1884.371704))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-1299.933838, 3861.567627, -2698.471924))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-3783.805664, 3861.864014, -2700.158203))
				elseif self.Owner:GetNWString("tp", "unset") == "ez" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-1998.464478, -3054.843506, -1910.908691))
				elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-3541.021240, 4507.503418, -3083.836182))
				elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-309.777802, 2181.257813, -3083.190186))
				elseif self.Owner:GetNWString("tp", "unset") == "ext" then
				if timer.Exists("block4") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-7281.271973, -6667.636230, -1561.314819))
		end
	end
				if game.GetMap() == "br_site65" then
				if self.Owner:GetNWString("tp", "unset") == "lcz1" then
					self.Owner:SetPos(Vector(9982.274414, -2552.354736, -10999.630859))
				elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
					self.Owner:SetPos(Vector(6765.747559, -777.037964, -11008.239258))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(2498.926270, -4096.096191, -10997.969727))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(2561.308350, 321.855042, -10998.942383))
				elseif self.Owner:GetNWString("tp", "unset") == "ez1" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-2584.804688, -801.723755, -11008.918945))
				elseif self.Owner:GetNWString("tp", "unset") == "ez2" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-3635.370361, 2994.190918, -11008.163086))
				elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(14206.699219, 3945.080322, -11898.813477))
				elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(10346.149414, 4270.383301, -12161.502930))
				elseif self.Owner:GetNWString("tp", "unset") == "ext" then
				if timer.Exists("block4") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-2716.279297, 5646.738770, -5393.958496))
		end
	end
				if game.GetMap() == "br_site61_v2" then
				if self.Owner:GetNWString("tp", "unset") == "lcz1" then
					self.Owner:SetPos(Vector(-1337.579956, 441.889343, -8127.068848))
				elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
					self.Owner:SetPos(Vector(1240.486938, 1092.416992, -8128.283203))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-678.352356, 2210.701172, -7114.968750))
				elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-700.781311, 5392.696289, -7103.837891))
				elseif self.Owner:GetNWString("tp", "unset") == "ez1" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(918.312500, 2307.689453, -6077.146973))
				elseif self.Owner:GetNWString("tp", "unset") == "ez2" then
				if timer.Exists("block3") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(-932.350830, 1750.993408, -6076.969727))
				elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
				if timer.Exists("block1") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(6499.735840, -884.650269, -11497.549805))
				elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
				if timer.Exists("block2") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(4169.172852, -6661.839844, -8542.025391))
				elseif self.Owner:GetNWString("tp", "unset") == "ext" then
				if timer.Exists("block4") then 
					self.Owner:PrintMessage(3, "Hacking in Progress...") return end
					self.Owner:SetPos(Vector(1014.156189, -1749.493530, 311.666687))
		end
	end
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
		if game.GetMap() == "br_site19" then
		if self.Owner:GetNWString("tp", "unset") == "lcz1" then
			self.Owner:SetNWString("tp", "lcz2")
			self.Owner:PrintMessage(3, "Set to LCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
			self.Owner:SetNWString("tp", "hcz1")
			self.Owner:PrintMessage(3, "Set to HCZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
			self.Owner:SetNWString("tp", "hcz2")
			self.Owner:PrintMessage(3, "Set to HCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
			self.Owner:SetNWString("tp", "tun1")
			self.Owner:PrintMessage(3, "Set to TUN1")
		elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
			self.Owner:SetNWString("tp", "tun2")
			self.Owner:PrintMessage(3, "Set to TUN2")
		elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
			self.Owner:SetNWString("tp", "ez")
			self.Owner:PrintMessage(3, "Set to EZ")
		elseif self.Owner:GetNWString("tp", "unset") == "ez" then
			self.Owner:SetNWString("tp", "ext")
			self.Owner:PrintMessage(3, "Set to EXT")
		else
			self.Owner:SetNWString("tp", "lcz1")
			self.Owner:PrintMessage(3, "Set to LCZ1")
		end
	end
		if game.GetMap() == "br_area02_v3" then
		if self.Owner:GetNWString("tp", "unset") == "lcz1" then
			self.Owner:SetNWString("tp", "lcz2")
			self.Owner:PrintMessage(3, "Set to LCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
			self.Owner:SetNWString("tp", "hcz1")
			self.Owner:PrintMessage(3, "Set to HCZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
			self.Owner:SetNWString("tp", "hcz2")
			self.Owner:PrintMessage(3, "Set to HCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
			self.Owner:SetNWString("tp", "ez")
			self.Owner:PrintMessage(3, "Set to EZ")
		elseif self.Owner:GetNWString("tp", "unset") == "ez" then
			self.Owner:SetNWString("tp", "ext")
			self.Owner:PrintMessage(3, "Set to EXT")
		else
			self.Owner:SetNWString("tp", "lcz1")
			self.Owner:PrintMessage(3, "Set to LCZ1")
		end
	end
		if game.GetMap() == "br_area96" then
		if self.Owner:GetNWString("tp", "unset") == "lcz1" then
			self.Owner:SetNWString("tp", "lcz2")
			self.Owner:PrintMessage(3, "Set to LCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
			self.Owner:SetNWString("tp", "hcz1")
			self.Owner:PrintMessage(3, "Set to HCZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
			self.Owner:SetNWString("tp", "hcz2")
			self.Owner:PrintMessage(3, "Set to HCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
			self.Owner:SetNWString("tp", "ez")
			self.Owner:PrintMessage(3, "Set to EZ")
		elseif self.Owner:GetNWString("tp", "unset") == "ez" then
			self.Owner:SetNWString("tp", "ext")
			self.Owner:PrintMessage(3, "Set to EXT")
		else
			self.Owner:SetNWString("tp", "lcz1")
			self.Owner:PrintMessage(3, "Set to LCZ1")
		end
	end
		if game.GetMap() == "br_site05_v2" then
		if self.Owner:GetNWString("tp", "unset") == "lcz1" then
			self.Owner:SetNWString("tp", "lcz2")
			self.Owner:PrintMessage(3, "Set to LCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
			self.Owner:SetNWString("tp", "hcz1")
			self.Owner:PrintMessage(3, "Set to HCZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
			self.Owner:SetNWString("tp", "hcz2")
			self.Owner:PrintMessage(3, "Set to HCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
			self.Owner:SetNWString("tp", "tun1")
			self.Owner:PrintMessage(3, "Set to TUN1")
		elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
			self.Owner:SetNWString("tp", "tun2")
			self.Owner:PrintMessage(3, "Set to TUN2")
		elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
			self.Owner:SetNWString("tp", "ez")
			self.Owner:PrintMessage(3, "Set to EZ")
		elseif self.Owner:GetNWString("tp", "unset") == "ez" then
			self.Owner:SetNWString("tp", "ext")
			self.Owner:PrintMessage(3, "Set to EXT")
		else
			self.Owner:SetNWString("tp", "lcz1")
			self.Owner:PrintMessage(3, "Set to LCZ1")
		end
	end
		if game.GetMap() == "br_site65" then
		if self.Owner:GetNWString("tp", "unset") == "lcz1" then
			self.Owner:SetNWString("tp", "lcz2")
			self.Owner:PrintMessage(3, "Set to LCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
			self.Owner:SetNWString("tp", "hcz1")
			self.Owner:PrintMessage(3, "Set to HCZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
			self.Owner:SetNWString("tp", "hcz2")
			self.Owner:PrintMessage(3, "Set to HCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
			self.Owner:SetNWString("tp", "tun1")
			self.Owner:PrintMessage(3, "Set to TUN1")
		elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
			self.Owner:SetNWString("tp", "tun2")
			self.Owner:PrintMessage(3, "Set to TUN2")
		elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
			self.Owner:SetNWString("tp", "ez1")
			self.Owner:PrintMessage(3, "Set to EZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "ez1" then
			self.Owner:SetNWString("tp", "ez2")
			self.Owner:PrintMessage(3, "Set to EZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "ez2" then
			self.Owner:SetNWString("tp", "ext")
			self.Owner:PrintMessage(3, "Set to EXT")
		else
			self.Owner:SetNWString("tp", "lcz1")
			self.Owner:PrintMessage(3, "Set to LCZ1")
		end
	end
		if game.GetMap() == "br_site61_v2" then
		if self.Owner:GetNWString("tp", "unset") == "lcz1" then
			self.Owner:SetNWString("tp", "lcz2")
			self.Owner:PrintMessage(3, "Set to LCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "lcz2" then
			self.Owner:SetNWString("tp", "hcz1")
			self.Owner:PrintMessage(3, "Set to HCZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz1" then
			self.Owner:SetNWString("tp", "hcz2")
			self.Owner:PrintMessage(3, "Set to HCZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "hcz2" then
			self.Owner:SetNWString("tp", "tun1")
			self.Owner:PrintMessage(3, "Set to TUN1")
		elseif self.Owner:GetNWString("tp", "unset") == "tun1" then
			self.Owner:SetNWString("tp", "tun2")
			self.Owner:PrintMessage(3, "Set to TUN2")
		elseif self.Owner:GetNWString("tp", "unset") == "tun2" then
			self.Owner:SetNWString("tp", "ez1")
			self.Owner:PrintMessage(3, "Set to EZ1")
		elseif self.Owner:GetNWString("tp", "unset") == "ez1" then
			self.Owner:SetNWString("tp", "ez2")
			self.Owner:PrintMessage(3, "Set to EZ2")
		elseif self.Owner:GetNWString("tp", "unset") == "ez2" then
			self.Owner:SetNWString("tp", "ext")
			self.Owner:PrintMessage(3, "Set to EXT")
		else
			self.Owner:SetNWString("tp", "lcz1")
			self.Owner:PrintMessage(3, "Set to LCZ1")
		end
	end
end

--Teleport back to the panic position
function SWEP:Reload()
    if not IsFirstTimePredicted() then return end
    if self.NextTeleportAction > CurTime() then return end
    self.NextTeleportAction = CurTime() + TELEPORT_DELAY

    if SERVER then
		if game.GetMap() == "br_site19" then
        self.Owner:SetPos(MAP_SCP079PANICPOS or Vector(3863.032959, -514.497375, -129.448746))
		end
		if game.GetMap() == "br_area02_v3" then
        self.Owner:SetPos(MAP_SCP079PANICPOS or Vector(7810.489258, 4304.533691, -1216.759644))
		end
		if game.GetMap() == "br_area96" then
        self.Owner:SetPos(MAP_SCP079PANICPOS or Vector(-4060.152100, 1203.518188, 84.143105))
		end
		if game.GetMap() == "br_site05_v2" then
		self.Owner:SetPos(MAP_SCP079PANICPOS or Vector(-2648.006592, 6266.826172, -2699.676025))
		end
		if game.GetMap() == "br_site65" then
		self.Owner:SetPos(MAP_SCP079PANICPOS or Vector(1640.451050, -1554.287354, -11180.968750))
		end
		if game.GetMap() == "br_site61_v2" then
		self.Owner:SetPos(MAP_SCP079PANICPOS or Vector(-3835.452393, 4743.732422, -7246.974121))
		end
    end
end

if CLIENT then
    --Draw cooldown information on the bottom of the screen
    function SWEP:DrawHUD()
        if disablehud then return end
        local t = "Teleport ready!"
        local c = Color(0, 255, 0)

        if self.NextTeleportAction > CurTime() then
            t = string.format("Next teleport in %d.", math.Round(self.NextTeleportAction - CurTime()))
            c = Color(255, 0, 0)
        end

        draw.Text( {
            text = t,
            pos = { ScrW() / 2, ScrH() - 50 },
            font = "173font",
            color = c,
            xalign = TEXT_ALIGN_CENTER,
            yalign = TEXT_ALIGN_CENTER
        })
    end
end