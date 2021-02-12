AddCSLuaFile()

ENT.PrintName = "Memorial"
ENT.Author = "chan_man1"
ENT.Type = "anim"
ENT.Category = ""
ENT.Spawnable = true
ENT.Editable = false
ENT.AdminOnly = false
ENT.Instructions = "Press E to Use."


function ENT:Initialize()
    self:SetModel("models/props_combine/breenbust.mdl")
	self:SetSolid( SOLID_VPHYSICS )
	self:SetNoDraw(false)
	if SERVER then
        if SPAWN_GRAVE then
            self:SetPos(SPAWN_GRAVE)
        else
            self:Remove()
        end
		self:SetUseType( SIMPLE_USE )
    end
end
function ENT:Use(activator, caller)
    if SERVER and caller and IsValid(caller) and caller:IsPlayer() and caller:Team() ~= TEAM_SPEC then
	if caller.GiveAchievement then
		caller:GiveAchievement("Grave")
	end
		caller:PrintMessage(4, "In Memory of those who lived and died on this server:")
		timer.Simple(5, function() caller:PrintMessage(4, "Aurora") end)
		timer.Simple(10, function() caller:PrintMessage(4, "Duc2000") end)
		timer.Simple(15, function() caller:PrintMessage(4, "Kubnair") end)
		timer.Simple(20, function() caller:PrintMessage(4, "Kite9867") end)
		timer.Simple(25, function() caller:PrintMessage(4, "Gecko") end)
		timer.Simple(30, function() caller:PrintMessage(4, "Miles") end)
		timer.Simple(35, function() caller:PrintMessage(4, "TheEvilGoat") end)
		timer.Simple(40, function() caller:PrintMessage(4, "John Jeez Man") end)
		timer.Simple(45, function() caller:PrintMessage(4, "TeleTubbie") end)
		timer.Simple(50, function() caller:PrintMessage(4, "NotSoFluffy") end)
		timer.Simple(55, function() caller:PrintMessage(4, "Blank") end)
		timer.Simple(60, function() caller:PrintMessage(4, "Yar Har") end)
		timer.Simple(65, function() caller:PrintMessage(4, "Racist_Leprechaun") end)
		timer.Simple(70, function() caller:PrintMessage(4, "Colt") end)
		timer.Simple(75, function() caller:PrintMessage(4, "Minishogun721") end)
		timer.Simple(80, function() caller:PrintMessage(4, "Teri") end)
		timer.Simple(85, function() caller:PrintMessage(4, "Keisuke4321") end)
		timer.Simple(90, function() caller:PrintMessage(4, "Deathz") end)
		timer.Simple(95, function() caller:PrintMessage(4, "EJ") end)
		timer.Simple(100, function() caller:PrintMessage(4, "wolfblade109") end)
		timer.Simple(105, function() caller:PrintMessage(4, "DOOMSlayer") end)
		timer.Simple(110, function() caller:PrintMessage(4, "T-Bizzle") end)
		timer.Simple(115, function() caller:PrintMessage(4, "Aquaticfilly0") end)
		timer.Simple(120, function() caller:PrintMessage(4, "Gun Slinger") end)
		timer.Simple(125, function() caller:PrintMessage(4, "TheLastBee") end)
		timer.Simple(130, function() caller:PrintMessage(4, "Jat") end)
		timer.Simple(135, function() caller:PrintMessage(4, "ProfessorViper") end)
		timer.Simple(140, function() caller:PrintMessage(4, "DJTapDatZombie") end)
		timer.Simple(145, function() caller:PrintMessage(4, "Ajit Pai") end)
		timer.Simple(150, function() caller:PrintMessage(4, "Rose") end)
		timer.Simple(155, function() caller:PrintMessage(4, "atomicheadphonez") end)
		timer.Simple(160, function() caller:PrintMessage(4, "Nicole") end)
		timer.Simple(165, function() caller:PrintMessage(4, "Jroek97") end)
		timer.Simple(170, function() caller:PrintMessage(4, "Toasted_Chromosomes") end)
		timer.Simple(175, function() caller:PrintMessage(4, "SCP-049") end)
		timer.Simple(180, function() caller:PrintMessage(4, "Jaren") end)
		timer.Simple(185, function() caller:PrintMessage(4, "Marshal Twilight") end)
		timer.Simple(190, function() caller:PrintMessage(4, "Scholinger") end)
		timer.Simple(195, function() caller:PrintMessage(4, "Celltastic") end)
		timer.Simple(200, function() caller:PrintMessage(4, "Mr. AsianRice") end)
		timer.Simple(205, function() caller:PrintMessage(4, "Sofics") end)
		timer.Simple(210, function() caller:PrintMessage(4, "Lambda") end)
		timer.Simple(215, function() caller:PrintMessage(4, "Ravelord") end)
		timer.Simple(220, function() caller:PrintMessage(4, "MrNoobyNoob") end)
		timer.Simple(225, function() caller:PrintMessage(4, "MeowImCat") end)
		timer.Simple(230, function() caller:PrintMessage(4, "Aura") end)
		timer.Simple(235, function() caller:PrintMessage(4, "reme leader 049") end)
		timer.Simple(240, function() caller:PrintMessage(4, "strawberry crab") end)
		timer.Simple(245, function() caller:PrintMessage(4, "KaitoKiriyama") end)
		timer.Simple(250, function() caller:PrintMessage(4, "Doomnack") end)
		timer.Simple(255, function() caller:PrintMessage(4, "Mythrl") end)
		timer.Simple(260, function() caller:PrintMessage(4, "Lipquip") end)
		timer.Simple(265, function() caller:PrintMessage(4, "RainGamma") end) 
		timer.Simple(270, function() caller:PrintMessage(4, "DJ SaltyCBox") end)
		timer.Simple(275, function() caller:PrintMessage(4, "RaeTheGay") end)
		timer.Simple(280, function() caller:PrintMessage(4, "ShadowjabUltra") end)
		timer.Simple(285, function() caller:PrintMessage(4, "ericthe1234") end)
		timer.Simple(290, function() caller:PrintMessage(4, "The Templar") end)
		timer.Simple(295, function() caller:PrintMessage(4, "Exhaustive") end) 
		timer.Simple(300, function() caller:PrintMessage(4, "HeroBrenn") end)
		timer.Simple(305, function() caller:PrintMessage(4, "Carthing2") end)
	end
end



