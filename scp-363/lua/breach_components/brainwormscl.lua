
ROLE_SCP378 = ROLE_SCP378 or "SCP-378"

hook.Add("HUDDrawTargetID", "HUDDrawTargetID_Brainworms", function ()
    local trace = LocalPlayer():GetEyeTrace()
    if not trace.Hit then return end
    if not trace.HitNonWorld then return end
    local ply =  trace.Entity
    if IsValid(ply) and ply:IsPlayer() and ply:GetNClass() == ROLE_SCP378 and ply:GetNWBool("SCP363_IsDisg", false) and ply:GetPos():Distance(LocalPlayer():GetPos()) <= 1000 and ply:Alive() and LocalPlayer():Team() != TEAM_SCP and LocalPlayer():Team() != TEAM_SPEC then
        local x = ScrW() / 2
        local y = ScrH() / 2 + 30
        local font = "TargetID"

        local name = ply:GetNWString("SCP363_FakeName", ply:Nick())
        local rolename = ply:GetNWString("SCP363_FakeRole", ply:GetNClass())
        local health = ply:GetNWFloat("SCP363_FakeHealth", ply:Health())
        local teamid = ply:GetNWInt("SCP363_Team", TEAM_SCP)
        local localteam = LocalPlayer():Team()
        local clr = team.GetColor(teamid)
        local r = "Neutral"
        --Crude relationship calc
        if teamid == localteam then
            r = "Friendly"
        elseif teamid == TEAM_SCP and localteam != TEAM_SCP then
            r = "Hostile"
        elseif teamid == TEAM_GUARD and localteam == TEAM_SCI then
            r = "Friendly"
        elseif teamid == TEAM_SCI and localteam == TEAM_GUARD then
            r = "Friendly"
        elseif teamid == TEAM_CLASSD and localteam == TEAM_GUARD then
            r = "Hostile"
        elseif teamid == TEAM_GUARD and localteam == TEAM_CLASSD then
            r = "Hostile"
        end
        
        local relationship_color = Color(104,104,104)
	if r == "Hostile" or r == "Totally Friendly" then
		relationship_color = Color(255,0,0)
	elseif r == "Friendly" then
		relationship_color = Color(88,255,88)
	end
        draw.Text( {
        text = name .. " (" .. health .. ")",
       pos = { x, y },
       font = "TargetID",
       color = clr2,
       xalign = TEXT_ALIGN_CENTER,
       yalign = TEXT_ALIGN_CENTER,
    })
        draw.Text( {
		    text = rolename,
		    pos = { x, y + 16 },
		    font = "TargetID",
		    color = clr,
		    xalign = TEXT_ALIGN_CENTER,
		    yalign = TEXT_ALIGN_CENTER,
	    })
        draw.Text( {
			text = r,
			pos = { x, y + 32 },
			font = "TargetID",
			color = relationship_color,
			xalign = TEXT_ALIGN_CENTER,
			yalign = TEXT_ALIGN_CENTER,
		})
        return true
    end
end)
