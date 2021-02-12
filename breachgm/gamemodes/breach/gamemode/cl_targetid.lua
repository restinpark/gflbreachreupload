--This file is especially messy. With the amount of times I've just needed to add a quick thing or whatever, I've just never really bothered to clean it up.

function firstToUpper1(str)
    return (str:gsub("^%l", string.upper))
end
KEYCARD_COLORS = {
  [1] = Color(255,255,255),
  [2] = Color(255,255,0),
  [3] = Color(255,165,0),
  [4] = Color(255,120,0),
  [5] = Color(255,30,0)
}
function GM:HUDDrawTargetID()
	local trace = LocalPlayer():GetEyeTrace()
	if !trace.Hit then return end
	if !trace.HitNonWorld then return end
  local x = ScrW() / 2
	local y = ScrH() / 2 + 30
	local text = "ERROR"
	local font = "TargetID"
	local ply =  trace.Entity
  if !IsValid(ply) then return end
  if ply:IsWeapon() then
    local printname = ply.PrintName or ply:GetClass()
    local access_level = false
    if ply.clevel then
      printname = "Keycard"
      access_level = ply.clevel
    end
    draw.Text( {
  		text = printname,
  		pos = { x, y },
  		font = "TargetID",
  		color = Color(255,255,255),
  		xalign = TEXT_ALIGN_CENTER,
  		yalign = TEXT_ALIGN_CENTER,
  	})
    if access_level then
    draw.Text( {
  		text = "Access Level " .. tostring(access_level),
  		pos = { x, y + 16 },
  		font = "TargetID",
  		color = KEYCARD_COLORS[access_level] or Color(0,0,0),
  		xalign = TEXT_ALIGN_CENTER,
  		yalign = TEXT_ALIGN_CENTER,
  	})
  	end

		return
	elseif ply:GetClass() == "ent_scp160" then
		local o = ply:GetOwner()
		if IsValid(o) and o:IsPlayer() then
			draw.Text({
				text = o:Nick() .. string.format(" (%d HP)", o:Health()),
				pos = {x, y},
				font = "TargetID",
				color = Color(255, 255, 255),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER
			})

			draw.Text({
				text = "SCP-160",
				pos = {x, y + 16},
				font = "TargetID",
				color = team.GetColor(TEAM_SCP),
				xalign = TEXT_ALIGN_CENTER,
				yalign = TEXT_ALIGN_CENTER
			})
		end
		return
	elseif ply:GetClass() == "prop_dynamic" and ply:GetModel() == 'models/foundation/containment/door01.mdl' then
		draw.Text( {
  		text = "Gate Door",
  		pos = { x, y },
  		font = "TargetID",
  		color = Color(255,255,255),
  		xalign = TEXT_ALIGN_CENTER,
  		yalign = TEXT_ALIGN_CENTER,
  	})
    draw.Text( {
  		text = tostring(ply:Health()) .. " HP",
  		pos = { x, y + 16 },
  		font = "TargetID",
  		color = Color(0,255,0),
  		xalign = TEXT_ALIGN_CENTER,
  		yalign = TEXT_ALIGN_CENTER,
  	})
		return
	elseif ply:GetClass() == "prop_ragdoll" and not ply.NoTarget and ply:GetNWString("player_nick", "") != "" and ply:GetNWInt("player_team", -1) != -1 then
		draw.Text( {
  		text = ply:GetNWString("player_nick", "Corpse"),
  		pos = { x, y },
  		font = "TargetID",
  		color = Color(255,255,255),
  		xalign = TEXT_ALIGN_CENTER,
  		yalign = TEXT_ALIGN_CENTER,
		})
		local col_over = nil
		if ply:GetNWInt("player_team", -1) == TEAM_CHAOS then
			col_over = Color(29, 81, 56)
		end
		local team_over = nil
		local team2 = ply:GetNWInt("player_team", TEAM_CLASSD)
		if team2 == TEAM_CLASSD then
			team_over = "Class D"
		elseif team2 == TEAM_GUARD then
			team_over = "MTF Guard"
		elseif team2 == TEAM_SCI then
			team_over = "Researcher"
		elseif team2 == TEAM_CHAOS then
			team_over = "CI"
		elseif team2 == TEAM_SCP then
			team_over = "SCP"
		elseif team2 == TEAM_CLASSE then
			team_over = "Class E"
		elseif team2 == TEAM_GOC then
			team_over = "GOC"
		else
			team_over = "Glitched"
		end
    draw.Text( {
  		text = (team_over or team.GetName(ply:GetNWInt("player_team", TEAM_CLASSD))) .. " Corpse",
  		pos = { x, y + 16 },
  		font = "TargetID",
  		color = col_over or team.GetColor(ply:GetNWInt("player_team", TEAM_CLASSD)),
  		xalign = TEXT_ALIGN_CENTER,
  		yalign = TEXT_ALIGN_CENTER,
		})
		return
  end
	if ply:IsPlayer() then
		if not ply.GetNClass then
			player_manager.RunClass( ply, "SetupDataTables" )
		end
		if not LocalPlayer().GetNClass then
			player_manager.RunClass( LocalPlayer(), "SetupDataTables" )
		end
		if ply:Alive() == false then return end
		if ply:Team() == TEAM_SPEC and not ply:GetNClass() == ROLE_GHOST then return end
		if ply:GetNClass() == ROLE_GHOST and LocalPlayer():GetNClass() != ROLE_GHOST then return end
		if ply:GetNClass() == ROLE_SCP079 then return end
		if ply:GetNClass() == ROLE_SCP160 then return end
		if ply:GetPos():Distance(LocalPlayer():GetPos()) > 1000 then return end
		text = ply:Nick()
	else
		return
	end
	local relationship = "ERROR"
	if not roundtype then
		roundtype = "Containment Breach"
	end
	//Spectators
	if LocalPlayer():Team() == TEAM_SPEC then
		relationship = firstToUpper1(ply:GetUserGroup())
	elseif ply:GetNClass() == ROLE_RES and ply:Team() == TEAM_CHAOS and LocalPlayer():Team() != TEAM_SCP then
		relationship = "Friendly"
  elseif LocalPlayer().GetNClass and LocalPlayer():GetNClass() == ROLE_2639A and ply:Team() != TEAM_SCP then
    relationship = "Friendly"
  elseif LocalPlayer():Team() != TEAM_SCP and ply.GetNClass and ply:GetNClass() == ROLE_2639A then
    relationship = "Friendly"
  //Same team
	elseif LocalPlayer():Team() == ply:Team() then
		relationship = "Friendly"
	//SCP 999 and humans
	elseif (LocalPlayer():Team() != TEAM_SCP and ply:GetNClass() == ROLE_999) or (LocalPlayer():GetNClass() == ROLE_999 and ply:Team() != TEAM_SCP) then
		relationship = "Friendly"
	//Guards and researchers
	elseif (LocalPlayer():Team() == TEAM_GUARD and ply:Team() == TEAM_SCI) or (LocalPlayer():Team() == TEAM_SCI and ply:Team() == TEAM_GUARD) then
		relationship = "Friendly"
	elseif (LocalPlayer():Team() == TEAM_CLASSD and ply:Team() == TEAM_SCI) or (LocalPlayer():Team() == TEAM_SCI and ply:Team() == TEAM_CLASSD) then
		relationship = "Neutral"
	//035 and Class d, multiplebreaches
	elseif ((LocalPlayer():Team() == TEAM_CLASSD and ply:GetNClass() == ROLE_SCP035) or (LocalPlayer():GetNClass() == ROLE_SCP035 and ply:Team() == TEAM_CLASSD)) and roundtype == "Multiple breaches" then
		relationship = "Hostile"
	//035 and class d, normal round
	elseif ((LocalPlayer():Team() == TEAM_CLASSD and ply:GetNClass() == ROLE_SCP035) or (LocalPlayer():GetNClass() == ROLE_SCP035 and ply:Team() == TEAM_CLASSD)) then
		relationship = "Friendly"
	//035 and Scientist
	elseif ((LocalPlayer():Team() == TEAM_SCI and ply:GetNClass() == ROLE_SCP035) or (LocalPlayer():GetNClass() == ROLE_SCP035 and ply:Team() == TEAM_SCI)) then
		relationship = "Neutral"
	//Chaos and Class D
elseif (LocalPlayer():Team() == TEAM_CLASSD and ply:Team() == TEAM_CHAOS) or (LocalPlayer():Team() == TEAM_CHAOS and ply:Team() == TEAM_CLASSD) then
		relationship = "Friendly"
	//Chaos and MTF
	elseif (LocalPlayer():Team() == TEAM_CHAOS and ply:Team() == TEAM_SCI) or (LocalPlayer():Team() == TEAM_CHAOS and ply:Team() == TEAM_GUARD) then
		relationship = "Hostile"
	//MTF and Chaos
	elseif (LocalPlayer():Team() == TEAM_GUARD and (ply:Team() == TEAM_CHAOS and ply:GetNClass() != ROLE_CHAOS )) then
		relationship = "Friendly"
	elseif (LocalPlayer():Team() == TEAM_SCI and (ply:Team() == TEAM_CHAOS and ply:GetNClass() != ROLE_CHAOS )) then
		relationship = "Friendly"
	elseif (LocalPlayer():Team() == TEAM_GUARD and ply:GetNClass() == ROLE_CHAOS ) then
		relationship = "Hostile"
	elseif (LocalPlayer():Team() != TEAM_SCP and ply:GetNClass() == ROLE_SCP939) then
		relationship = "Totally Friendly"
	elseif (LocalPlayer():Team() != TEAM_SCP and ply:Team() == TEAM_SCP) or (LocalPlayer():Team() == TEAM_SCP and ply:Team() != TEAM_SCP) then
		relationship = "Hostile"
	else
		relationship = "Hostile"
	end

	local relationship_color = Color(104,104,104)
	if relationship == "Hostile" or relationship == "Totally Friendly" then
		relationship_color = Color(255,0,0)
	elseif relationship == "Friendly" then
		relationship_color = Color(88,255,88)
	end


	local clr = self:GetTeamColor( ply )
	local clr2 = color_white

	if not ply.GetNClass then
		player_manager.RunClass( ply, "SetupDataTables" )
	else
		text = ply:GetNClass()
	end
	local dodraw = true
	if ply:GetNClass() == ROLE_178 then
		if ( LocalPlayer():Team() == TEAM_SCP or  LocalPlayer():Team() == TEAM_SPEC or LocalPlayer():HasWeapon("weapon_178")) then
			dodraw = true
		else
			dodraw = false
			return
		end
 	end
	if ply:GetNClass() == ROLE_SCP966 then
		if LocalPlayer():HasWeapon("weapon_nvg") then
			local nvg = LocalPlayer():GetWeapon("weapon_nvg")
			if nvg.IsOn then
				dodraw = true
			else
				dodraw = false
			end
		else
			dodraw = false
		end
	else
		dodraw = true
	end
	if ply:GetNClass() == ROLE_SCP990 then
		if LocalPlayer():HasWeapon("weapon_dream") then
			dodraw = true
		else
			dodraw = false
			return
		end
 	end
	if ply:GetNClass() == ROLE_SCP1471 then
		if LocalPlayer():Team() == TEAM_SPEC or LocalPlayer():Team() == TEAM_SCP then
			dodraw = true
		elseif not LocalPlayer():GetNWBool("MaloInfected", false) then
			dodraw = false
		end
	end
	if ply:GetNClass() == ROLE_SCP372 then
		dodraw = false
	end
	if not dodraw then return end
	if LocalPlayer():Team() == TEAM_CHAOS or LocalPlayer():Team() == TEAM_CLASSD then
		if ply:Team() == TEAM_CHAOS then
			text = "Chaos Insurgency"
			clr = Color(29, 81, 56)
		end
	end
	if ply:Team() == TEAM_CHAOS and ply:GetNClass() == ROLE_RES and LocalPlayer():Team() != TEAM_CHAOS and LocalPlayer():Team() != TEAM_CLASSD then
		clr = team.GetColor(TEAM_SCI)
		text = "Researcher"
	elseif ply:Team() == TEAM_CHAOS and ply:GetNClass() == ROLE_RES then
		text = "Chaos Insurgency"
		clr = Color(29, 81, 56)
	end
  local hp_override = false
  if ply.GetNClass and ply:GetNClass() == ROLE_SCP939 and LocalPlayer():Team() != TEAM_SCP and LocalPlayer():Team() != TEAM_SPEC and ply:HasWeapon("scp939") and ply:GetWeapon("scp939"):GetNWBool("IsDisguised", false) then
    text = "Researcher"
    clr = team.GetColor(TEAM_SCI)
    hp_override = "100%"
    relationship = "Friendly"
    relationship_color = Color(88,255,88)
  end
  if not hp_override then
	   draw.Text( {
		     text = ply:Nick() .. " (" .. ply:Health() .. "%)",
		    pos = { x, y },
		    font = "TargetID",
		    color = clr2,
		    xalign = TEXT_ALIGN_CENTER,
		    yalign = TEXT_ALIGN_CENTER,
	   })
  else
    draw.Text( {
        text = ply:Nick() .. " (" .. hp_override .. ")",
       pos = { x, y },
       font = "TargetID",
       color = clr2,
       xalign = TEXT_ALIGN_CENTER,
       yalign = TEXT_ALIGN_CENTER,
    })
  end
	draw.Text( {
		text = text,
		pos = { x, y + 16 },
		font = "TargetID",
		color = clr,
		xalign = TEXT_ALIGN_CENTER,
		yalign = TEXT_ALIGN_CENTER,
	})
		draw.Text( {
			text = relationship,
			pos = { x, y + 32 },
			font = "TargetID",
			color = relationship_color,
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
end
