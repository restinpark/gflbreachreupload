if SERVER then AddCSLuaFile() end
	
local function MakeStats(ent, item,enabled)
	ent.Isaac.Equipped[item] = enabled
	if TFABOI.Items2[item].Stats then
		for Stat, Value in pairs(TFABOI.Items2[item].Stats) do
			ent.Isaac.Stats[Stat] = ( enabled and ent.Isaac.Stats[Stat] + Value) or ent.Isaac.Stats[Stat] - Value
		end
	end
	if TFABOI.Items2[item].Tear then
		for Stat, Value in pairs(TFABOI.Items2[item].Tear) do
			ent.Isaac.Tear[Stat] = ( enabled and (ent.Isaac.Tear[Stat] or 0) + 1) or (ent.Isaac.Tear[Stat] or 0) - 1
		end
	end
	if TFABOI.Items2[item].Player then
		for Stat, Value in pairs(TFABOI.Items2[item].Player) do
			ent.Isaac.Player[Stat] = ( enabled and (ent.Isaac.Player[Stat] or 0) + 1) or (ent.Isaac.Player[Stat] or 0) - 1
		end
	end
	if TFABOI.Items2[item].Color then
		for Stat, Value in pairs(TFABOI.Items2[item].Color) do
			ent.Isaac.Tear.Color[Stat] = ( enabled and Color(Value[1],Value[2],Value[3])) or nil
		end
	end
	if TFABOI.Items2[item].Laser then
		for Stat, Value in pairs(TFABOI.Items2[item].Laser) do
			ent.Isaac.Tear.Laser[Stat] = ( enabled and (ent.Isaac.Tear.Laser[Stat] or 0) + Value) or (ent.Isaac.Tear.Laser[Stat] or 0) - Value
		end
	end
	if TFABOI.Items2[item].Ent then
		for Stat, Value in pairs(TFABOI.Items2[item].Ent) do
			ent.Isaac.Tear.Ent[Stat] = ( enabled and Value) or nil
		end
	end
	ent:ClearStatCache()
	ent:IsaacStats()
end

local function EquipItem(ent, item, forceon)
	if ent:IsValid() and TFABOI.Items2[item] and ent.Isaac then
		if forceon then
			if !(ent.Isaac.Equipped[item] == true) then
				MakeStats(ent, item, true)
			end
		else
			if ent.Isaac.Equipped[item] == true then
				MakeStats(ent, item, false)
			else
				MakeStats(ent, item, true)
			end
		end
	end
end

local function PickupVGUI(ID)
	local ItemBG =  vgui.Create("DImageButton")
		ItemBG:SetSize(ScrW()/1.25, ScrH()/4)
		ItemBG:Center()
		ItemBG.Y = ScrH()/9
		ItemBG:SetOnViewMaterial( "isaactears/vgui/itembg.png" )
		ItemBG.Paint = function( panel, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 50, 50, 50, 0) )
		end

	local ItemLabel = vgui.Create("DLabel", ItemBG)
		ItemLabel:SetText(TFABOI.Items[ID].Name)
		ItemLabel:SetFont("TFA_INSPECTION_TITLE")
		ItemLabel:SizeToContents()
		ItemLabel:Center()
		ItemLabel.Y =  ItemBG:GetTall()-(ItemBG:GetTall()/1.12)
		ItemLabel:SetColor(Color(255,255,255))

	local ItemDesc = vgui.Create("DLabel", ItemBG)
		ItemDesc:SetText(TFABOI.Items[ID].Pickup)
		ItemDesc:SetFont("TFASleek")
		ItemDesc:SizeToContents()
		ItemDesc:Center()
		ItemDesc:SetColor(Color(255,255,255))
		ItemDesc.Y = (ItemBG:GetTall()/2.8)

	ItemBG.X = -ScrW()
	ItemBG.Think = function()
		ItemBG.X = Lerp(FrameTime()*20, ItemBG.X, (ScrW()/2)-ItemBG:GetWide()/2)
	end
	timer.Simple(1.5, function()
		if ItemBG:IsValid() then
			ItemBG.Think = function()
				ItemBG.X = Lerp(FrameTime()*20, ItemBG.X, ScrW())
			end
		end
	end)
	timer.Simple(1.8, function()
		if ItemBG:IsValid() then
			ItemBG:Remove()
		end
	end)
end

-- Toggle Net
	if SERVER then
		net.Receive("IsaacTears_Toggle_Server", function(length, client)
			local ent = net.ReadEntity()
			local item = net.ReadInt( 32 )
			local bool = net.ReadBool()
			EquipItem(ent, item, false)
			net.Start("IsaacTears_Toggle_Client")
			net.WriteEntity(ent)
			net.WriteInt(item, 32)
			net.Send(ent.Owner)
		end)
	end

	if CLIENT then
		net.Receive("IsaacTears_Toggle_Client", function(length, client)
			local ent = net.ReadEntity()
			local item = net.ReadInt( 32 )
			local bool = net.ReadBool()
			EquipItem(ent, item, false)
		end)
	end

-- Pickup Net
	if SERVER then
		net.Receive("IsaacTears_Pickup_Server", function(length, client)
			local ent = net.ReadEntity()
			local item = net.ReadInt( 32 )
			EquipItem(ent, item, true)
		end)
	end

	if CLIENT then
		net.Receive("IsaacTears_Pickup_Client", function(length, client)
			local ent = net.ReadEntity()
			local item = net.ReadInt( 32 )
			PickupVGUI( item )
			EquipItem(ent, item, true)

			net.Start("IsaacTears_Pickup_Server")
			net.WriteEntity(ent)
			net.WriteInt(item, 32)
			net.SendToServer()
		end)
	end
