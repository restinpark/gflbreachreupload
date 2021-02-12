player_manager.AddValidModel( "Arceus", "models/bumpattack/arceus/arceus_pm.mdl" );
list.Set( "PlayerOptionsModel", "Arceus", "models/bumpattack/arceus/arceus_pm.mdl" );
player_manager.AddValidHands( "Arceus", "models/bumpattack/arceus/arceusarms.mdl", 0, "00000000" )

local settings = {
	["name"] = "Arceus",
	["model"] = "models/bumpattack/arceus/arceus_pm.mdl",
	["scale"] = 1,
	["developermode"] = false,
	["viewoffset"] = 128,
	["duckviewoffset"] = 28,
	["hullminimum"] = Vector(-16, -16, 0),
	["hullmaximum"] = Vector(16, 16, 132),
	["duckhullminimum"] = Vector(-16, -16, 0),
	["duckhullmaximum"] = Vector(16, 16, 36),
	["stepsize"] = 36,
	["slowwalkspeed"] = 100,
	["walkspeed"] = 400,
	["runspeed"] = 600,
	["jumppower"] = 250,
	["seatoffset"] = 0
}

local mEnt = FindMetaTable("Entity")

mEnt.NewSetModel = mEnt.NewSetModel || mEnt.SetModel

function mEnt:SetModel(model)

	self.NewSetModel(self, model)

	if(self:IsPlayer()) then

		hook.Run("SPM_ModelChange", self)

	end

end

if(SERVER) then

	util.AddNetworkString(settings["name"].."ResetModel")
	util.AddNetworkString(settings["name"].."RescaleModel")

else

	net.Receive(settings["name"].."ResetModel", function()

		local ply = LocalPlayer()

		if(IsValid(ply)) then

			ply:SetModelScale(1)
			ply:ResetHull()
			ply:SetViewOffset(Vector(0, 0, 64))
			ply:SetViewOffsetDucked(Vector(0, 0, 28))
			ply:SetStepSize(18)
			ply:SetSlowWalkSpeed(100)
			ply:SetWalkSpeed(200)
			ply:SetRunSpeed(400)
			ply:SetJumpPower(200)

		end

	end)

	net.Receive(settings["name"].."RescaleModel", function()

		local ply = LocalPlayer()

		if(IsValid(ply)) then

			ply:SetModelScale(settings["scale"])

			ply:SetHull(settings["hullminimum"], settings["hullmaximum"])
			ply:SetHullDuck(settings["duckhullminimum"], settings["duckhullmaximum"])

			ply:SetViewOffset(Vector(0, 0, settings["viewoffset"]))
			ply:SetViewOffsetDucked(Vector(0, 0, settings["duckviewoffset"]))
			
			ply:SetStepSize(settings["stepsize"])
			ply:SetSlowWalkSpeed(settings["slowwalkspeed"])
			ply:SetWalkSpeed(settings["walkspeed"])
			ply:SetRunSpeed(settings["runspeed"])
			ply:SetJumpPower(settings["jumppower"])

		end

	end)

end

hook.Add("SPM_ModelChange", settings["name"].."SpawningFunction", function(ply)

	timer.Simple(0, function()

		if(SPM_Pool[ply:GetModel()] == nil) then

			ply:SetModelScale(1)
			ply:ResetHull()
			ply:SetViewOffset(Vector(0, 0, 64))
			ply:SetViewOffsetDucked(Vector(0, 0, 28))
			ply:SetStepSize(18)
			ply:SetSlowWalkSpeed(100)
			ply:SetWalkSpeed(200)
			ply:SetRunSpeed(400)
			ply:SetJumpPower(200)

			net.Start(settings["name"].."ResetModel")
			net.Send(ply)

		end

	end)

	timer.Simple(FrameTime(), function()

		if(SPM_Pool[ply:GetModel()] != nil) then

			local tab = SPM_Pool[ply:GetModel()]

			ply:SetModelScale(tab["scale"])

			ply:SetHull(tab["hullminimum"], tab["hullmaximum"])
			ply:SetHullDuck(tab["duckhullminimum"], tab["duckhullmaximum"])

			ply:SetViewOffset(Vector(0, 0, tab["viewoffset"]))
			ply:SetViewOffsetDucked(Vector(0, 0, tab["duckviewoffset"]))
			
			ply:SetStepSize(tab["stepsize"])
			ply:SetSlowWalkSpeed(tab["slowwalkspeed"])
			ply:SetWalkSpeed(tab["walkspeed"])
			ply:SetRunSpeed(tab["runspeed"])
			ply:SetJumpPower(tab["jumppower"])

			net.Start(tab["name"].."RescaleModel")
			net.Send(ply)

		end

	end)

end)


hook.Add("PlayerEnteredVehicle", settings["name"].."VehicleOffset", function(ply, veh)

	if(ply:InVehicle()) then

		if(ply:GetModel() == settings["model"]) then

			ply:SetPos(Vector(0, 0, settings["seatoffset"]))

		end

	end

end)

hook.Add("PostDrawTranslucentRenderables", settings["name"].."DeveloperMode", function()

	local ply = LocalPlayer()

	if(settings["developermode"] == true) then

		if(ply:GetModel() == settings["model"]) then

			local min = settings["hullminimum"]
			local max = settings["hullmaximum"]
			local ePos = ply:EyePos()
			local eOffset = (ePos - ply:GetPos()).Z

			if(eOffset == settings["duckviewoffset"]) then

				min = settings["duckhullminimum"]
				max = settings["duckhullmaximum"]

			end

			render.SetColorMaterial()
			render.DrawBox(ply:GetPos() , Angle(0, 0, 0), min, max, Color(255, 0, 0, 150))
			render.DrawBox(ply:EyePos(), Angle(0, 0, 0), Vector(min.X, min.Y, -1), Vector(max.X, max.Y, 1), Color(255, 255, 0, 100))

		end

	end

end)

hook.Add("Initialize", settings["name"].."SetPool", function()

	SPM_Pool = {}

	timer.Simple(FrameTime(), function()

		SPM_Pool[settings["model"]] = settings

	end)

end)