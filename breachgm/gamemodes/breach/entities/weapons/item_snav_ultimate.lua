AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_snav_ult")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Find a way to go, scan for players and items"
SWEP.Instructions	= "Passive use item, simply having it will enable its effects."

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/mishka/models/snav.mdl"
SWEP.WorldModel		= "models/mishka/models/snav.mdl"
SWEP.PrintName		= "S-Nav Ultimate"
SWEP.Slot			= 0
SWEP.SlotPos		= 3
SWEP.ItemType = WEAPON_SNAV or 4
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
SWEP.IsSNAV = true

SWEP.droppable				= true
SWEP.teams					= {2,3,5,6}

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo			=  "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo			=  "none"
SWEP.Secondary.Automatic	=  false

SWEP.Enabled = false
SWEP.NextChange = 0
function SWEP:Deploy()
	self.Owner:DrawViewModel( false )
end
function SWEP:DrawWorldModel()
	if !IsValid(self.Owner) then
		self:DrawModel()
	end
end
function SWEP:Initialize()
	self:SetHoldType("normal")
end
function SWEP:CalcView( ply, pos, ang, fov )
	if self.Enabled then
		ang = Vector(90,0,0)
		pos = pos + Vector(0,0,900)
		fov = 90
	end
	return pos, ang, fov
end

SWEP.warnings = {}
SWEP.toshow = {}
SWEP.ScanDelay = 0
function SWEP:Think()
	if CLIENT then
		if self.Enabled then
			for k,v in pairs(player.GetAll()) do
				v:SetNoDraw( true )
			end
		else
			for k,v in pairs(player.GetAll()) do
				v:SetNoDraw( false )
			end
		end
		if self.ScanDelay > CurTime() then return end
		self.ScanDelay = CurTime() + 1
		self.warnings = {}
		self.toshow = {}
		local lp = LocalPlayer()
		for k,v in pairs(ents.FindInSphere( lp:GetPos(), 1000 )) do
			if v:IsPlayer() then
				if v == lp then continue end
				if v:Team() != TEAM_SPEC then
					if v:Team() == TEAM_GUARD then
						table.ForceInsert(self.warnings, "MTF Guard detected")
						continue
					elseif v:Team() == TEAM_CHAOS then
						if lp:Team() == TEAM_CHAOS then
							table.ForceInsert(self.warnings, "Chaos Insurgency Member detected")
							continue
						else
							table.ForceInsert(self.warnings, "MTF Guard detected")
							continue
						end
					elseif v:Team() == TEAM_SCI then
						table.ForceInsert(self.warnings, "Researcher detected")
						continue
					elseif v:Team() == TEAM_CLASSD then
						table.ForceInsert(self.warnings, "Class D detected")
						continue
					elseif v:Team() == TEAM_SCP then
						if not v.GetNClass then
							player_manager.RunClass( v, "SetupDataTables" )
						end
						table.ForceInsert(self.warnings, v:GetNClass() .. " detected")
					else
						table.ForceInsert(self.warnings, "Humanoid form detected")
					end
				end
			elseif v:IsWeapon() then
				local found = false
				if IsValid(v.Owner) then
					found = true
				end
				if v.ISSCP != nil then
					if v.ISSCP == true then
						found = true
					end
				end
				if !found then
					table.ForceInsert(self.toshow, v)
					table.ForceInsert(self.warnings, language.GetPhrase( v:GetPrintName() ) .. " detected")
				end
			end
		end
	end
end
function SWEP:Reload()
end
function SWEP:PrimaryAttack()
end
function SWEP:OnRemove()
	if CLIENT then
		for k,v in pairs(player.GetAll()) do
			v:SetNoDraw( false )
		end
	end
end
function SWEP:Holster()
	if CLIENT then
		for k,v in pairs(player.GetAll()) do
			v:SetNoDraw( false )
		end
	end
	return true
end
function SWEP:SecondaryAttack()
	if SERVER then return end
	if self.NextChange > CurTime() then return end
	self.Enabled = !self.Enabled
	self.NextChange = CurTime() + 0.25
end
function SWEP:CanPrimaryAttack()
end

function SWEP:DrawHUD()
	if self.Enabled then
		/*
		if BUTTONS != nil then
			for k,v in pairs(BUTTONS) do
				DrawInfo(v.pos, v.name, Color(0,255,50))
			end
			for k,v in pairs(SPAWN_KEYCARD2) do
				DrawInfo(v, "Keycard2", Color(255,255,0))
			end
			for k,v in pairs(SPAWN_KEYCARD3) do
				DrawInfo(v, "Keycard3", Color(255,120,0))
			end
			for k,v in pairs(SPAWN_KEYCARD4) do
				DrawInfo(v, "Keycard4", Color(255,0,0))
			end
			for k,v in pairs(SPAWN_ITEMS) do
				DrawInfo(v, "Item", Color(255,255,255))
			end
		end
		*/
		for k,v in pairs(self.toshow) do
			if IsValid(v) then
				if v:GetPos():Distance(LocalPlayer():GetPos()) < 425 then
					DrawInfo(v:GetPos(), v:GetPrintName(), Color(255,255,255))
				end
			end
		end
		for i,v in ipairs(self.warnings) do
			draw.Text( {
				text = v,
				pos = { ScrW() / 2, ScrH() / 2 - ((i * -25) - 125) },
				font = "173font",
				color = Color(255,0,0),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER,
			})
		end
	end
end