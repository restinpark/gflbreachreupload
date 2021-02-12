AddCSLuaFile()

if CLIENT then
	SWEP.WepSelectIcon 	= surface.GetTextureID("breach/wep_radio")
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "Kanade"
SWEP.Contact		= "Look at this gamemode in workshop and search for creators"
SWEP.Purpose		= "Communicate"
SWEP.Instructions	= "Use it to communicate. Use reload to call in reinforcments depending on who holds the radio. CAUTION: Reinforcement signal will fry the radio! (Only 1 use) "

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/mishka/models/radio.mdl"
SWEP.WorldModel		= "models/mishka/models/radio.mdl"
SWEP.PrintName		= "O5 Radio"
SWEP.Slot			= 0
SWEP.SlotPos		= 4
SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.HoldType		= "normal"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
SWEP.ItemType = WEAPON_RADIO or 7
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

SWEP.Channel = 5
SWEP.Enabled = true
SWEP.NextChange = 0
SWEP.IsPlayingFor = nil
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
	self:SetSkin(1)
	 if SERVER then
        self:SetNWInt("NextUse", CurTime() + 240)
    end
end

function SWEP:PlaySound(name, volume, looping)
	if CLIENT then
		//print("Starting playing a sound " .. name .. " with volume: " .. tostring(volume) .. " and looping is: " .. tostring(looping))
		sound.PlayFile( name, "mono noblock", function( station, errorID, errorName )
			if ( IsValid( station ) ) then
				station:SetPos( LocalPlayer():GetPos() )
				station:SetVolume( volume )
				if looping then
					station:EnableLooping( looping )
					station:SetTime( 360 )
				end
				station:Play()
				LocalPlayer().channel = station
			else
				print("station not found")
				print(errorName)
			end
		end )
	end
end

function SWEP:RemoveSounds()
	if CLIENT then
		if LocalPlayer().channel != nil then
			LocalPlayer().channel:EnableLooping( false )
			LocalPlayer().channel:Stop()
			LocalPlayer().channel = nil
		end
	end
end

function SWEP:StopSounds()
	if CLIENT then
		if LocalPlayer().channel != nil then
			//LocalPlayer().channel:EnableLooping( false )
			LocalPlayer().channel:SetVolume(0)
			//LocalPlayer().channel = nil
		end
	end
end

SWEP.LastSound = 0
function SWEP:CheckSounds()
	if CLIENT then
		local r = "sound/radio/"
		if self.Channel == 1 then
			self:PlaySound(r .. "radioalarm.ogg", 1, true)
			self.IsLooping = true
		elseif self.Channel == 2 then
			self:PlaySound(r .. "radioalarm2.ogg", 1, false)
			self.NextSoundCheck = CurTime() + 12
			self.IsLooping = false
		elseif self.Channel == 3 then
			self.LastSound = self.LastSound + 1
			if self.LastSound == 0 then
				self.NextSoundCheck = CurTime() + 24
			elseif self.LastSound == 1 then
				self.NextSoundCheck = CurTime() + 15
			elseif self.LastSound == 2 then
				self.NextSoundCheck = CurTime() + 21
			elseif self.LastSound == 3 then
				self.NextSoundCheck = CurTime() + 25
			elseif self.LastSound == 4 then
				self.NextSoundCheck = CurTime() + 28
			elseif self.LastSound == 5 then
				self.NextSoundCheck = CurTime() + 35
			elseif self.LastSound == 6 then
				self.NextSoundCheck = CurTime() + 46
			elseif self.LastSound == 7 then
				self.NextSoundCheck = CurTime() + 20
			elseif self.LastSound == 8 then
				self.NextSoundCheck = CurTime() + 24
			elseif self.LastSound == 9 then
				self.LastSound = 0
				self.NextSoundCheck = CurTime() + 24
			end
			local sound = "scpradio" .. self.LastSound
			self:PlaySound(r .. sound .. ".ogg", 1, false)
			self.IsLooping = false
		elseif self.Channel == 4 then
			if #RADIO4SOUNDS > 0 then
				if math.random(1,4) == 4 then
					local rndtbl = table.Random(RADIO4SOUNDS)
					//print("playing " .. rndtbl[1])
					self:PlaySound(r .. rndtbl[1] .. ".ogg", 1, false)
					self.NextSoundCheck = CurTime() + rndtbl[2] + 5
					self.IsLooping = false
					table.RemoveByValue(RADIO4SOUNDS, rndtbl)
				else
					//print("waiting 5 secs")
					self.NextSoundCheck = CurTime() + 5
					self.IsLooping = false
				end
			else
				self.IsLooping = true
			end
		end
	end
end

SWEP.IsLooping = false
SWEP.NextSoundCheck = 0
function SWEP:Think()
	if SERVER then return end
	if self.Enabled then
		if self.IsLooping == false then
			if self.NextSoundCheck < CurTime() then
				self:CheckSounds()
			end
		end
	end
end
SWEP.SpecialCooldown = 240
function SWEP:Reload()
if preparing or postround then return end
if not IsFirstTimePredicted() then return end
if self:GetNWInt("NextUse", 0) > CurTime() then return end
    self:SetNWInt("NextUse",CurTime() + self.SpecialCooldown)
	if SERVER then
		if self.Owner:GetNClass() == ROLE_O51 then
		if self.Owner.GiveAchievement then
				self.Owner:GiveAchievement("Scenario")
		end
		self.Owner:EmitSound("ambient/levels/labs/electric_explosion1.wav", 35, 75)
		self.Owner:StripWeapon("item_o5radio")
		timer.Simple( 10, function() for i = 1, 5 do
                local ply = table.Random(GetNotAFKSpecs())
                if IsValid(ply) then
				if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
					ply:SetRRH()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					ply:SetTeam(TEAM_SCP)
					PrintMessage(4, "Red Right Hand has recieved the transmission!")
					else
                    ply:SetRRH()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					PrintMessage(4, "Red Right Hand has recieved the transmission!")
					end
				end
			end
		end)
		elseif self.Owner:GetNClass() == ROLE_SCP035 then
		if self.Owner.GiveAchievement then
				self.Owner:GiveAchievement("Reliable")
		end
		self.Owner:EmitSound("ambient/levels/labs/electric_explosion1.wav", 35, 75)
		self.Owner:StripWeapon("item_o5radio")
		timer.Simple( 10, function() for i = 1, 5 do
                local ply = table.Random(GetNotAFKSpecs())
                if IsValid(ply) then
				if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
					ply:SetChaosInsCom()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					ply:SetTeam(TEAM_SCI)
					PrintMessage(4, "The Chaos Insurgency has recieved the transmission!")
					else
                    ply:SetChaosInsCom()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					PrintMessage(4, "The Chaos Insurgency has recieved the transmission!")
					end
				end
			end
		end)
		elseif self.Owner:GetNClass() == ROLE_SCP378 then
		if self.Owner.GiveAchievement then
				self.Owner:GiveAchievement("Scarce")
		end
		self.Owner:EmitSound("ambient/levels/labs/electric_explosion1.wav", 35, 75)
		self.Owner:StripWeapon("item_o5radio")
		timer.Simple( 10, function() for i = 1, 5 do
                local ply = table.Random(GetNotAFKSpecs())
                if IsValid(ply) then
				if roundtype and roundtype.name and roundtype.name == "Human Zoo" then
					ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					ply:SetTeam(TEAM_GUARD)
					PrintMessage(4, "Serpents Hand has recieved the transmission!")
					else
                    ply:SetSerpentsHand()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					PrintMessage(4, "Serpents Hand has recieved the transmission!")
					end
				end
			end
		end)
		elseif self.Owner:GetNClass() == ROLE_CLASSE then
		if self.Owner.GiveAchievement then
				self.Owner:GiveAchievement("Nobody")
		end
		self.Owner:EmitSound("ambient/levels/labs/electric_explosion1.wav", 35, 75)
		self.Owner:StripWeapon("item_o5radio")
		timer.Simple( 10, function() for i = 1, 5 do
                local ply = table.Random(GetNotAFKSpecs())
                if IsValid(ply) then
                    ply:SetNobody()
                    ply:SetPos(SPAWN_OUTSIDE[i])
					PrintMessage(4, "Nobody has recieved the transmission!")
				end
			end
		end)
	end
end
end
function SWEP:PrimaryAttack()
	if self.NextChange > CurTime() then return end
	self.Channel = self.Channel + 1
	if self.Channel > 10 then
		self.Channel = 1
	end
	self.IsLooping = false
	self:RemoveSounds()
	if self.Enabled then
		self:CheckSounds()
	end
	self.NextChange = CurTime() + 0.1
end
function SWEP:OnRemove()
	if CLIENT then
		self.IsLooping = false
		self:StopSounds()
		self.Enabled = false
	end
end
function SWEP:Holster()
	//if CLIENT then
	//	self.IsLooping = false
	//	self:StopSounds()
	//	self.Enabled = false
	//end
	return true
end
function SWEP:SecondaryAttack()
	if self.NextChange > CurTime() then return end
	self.Enabled = !self.Enabled
	self.NextChange = CurTime() + 0.1
	if CLIENT then
		if self.Enabled then
			//self:CheckSounds()
			if IsValid(LocalPlayer().channel) then
				LocalPlayer().channel:SetVolume(1)
			end
		else
			self:StopSounds()
		end
	end
	//self.Owner.RadioEnabled = self.Enabled
	//print(self.NextChange)
	//print(self.Owner:Nick() .. " " .. tostring(self.Enabled))
end
function SWEP:CanPrimaryAttack()
end

local ourMat = Material( "breach/RadioHUD.png" )
function SWEP:DrawHUD()
	if disablehud == true then return end
	local rw = ScrW() / 7.6
	local rh = (rw * 2) * 1.1
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( ourMat	)
	surface.DrawTexturedRect( ScrW() - rw, ScrH() - rh, rw, rh )
	local showtext = ""
	local showcolor = Color(17, 145, 66)

	if self.Enabled then
		showtext = "Radio Channel " .. self.Channel
		showcolor = Color(0, 255, 0)
	else
		showtext = "Radio Disabled"
		showcolor = Color(255, 0, 0)
	end
	showcolor = color_white
	//local rx = ScrW() - rw
	//local ry = ScrH() - rh
	local rx = ScrW() / 2
	local ry = ScrH() / 2 + 50
	draw.Text( {
		text = showtext,
		//pos = { rx + 52, ry * 1.79 },
		pos = { rx + 2, ry + 2},
		font = "RadioFont",
		color = color_black,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	draw.Text( {
		text = showtext,
		//pos = { rx + 52, ry * 1.79 },
		pos = { rx, ry },
		font = "RadioFont",
		color = showcolor,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
	local next = math.Round(self:GetNWInt("NextUse", 0) - CurTime())
    local text2, color2
    if next > -1 then
        text2 = "Broadcast ready in " .. next .. " seconds."
        color2 = Color(255,0,0)
    else
        text2 = "Ready to send signal!"
        color2 = Color(0,255,0)
    end
    
    draw.Text( {
		text = text2,
		pos = { ScrW() / 2, ScrH() - 50 },
		font = "173font",
		color = color2,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
end