TFA.CSGO = TFA.CSGO or {}

if SERVER then
	AddCSLuaFile()
	TFA.CSGO.DrawScopeReticle = function( ... ) end
	return
end

local useStencils = render.SupportsPixelShaders_1_4() and render.SupportsPixelShaders_2_0() and render.SupportsVertexShaders_2_0()

local function defineCanvas(ref)
	render.UpdateScreenEffectTexture()
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_REPLACE)
	render.SetStencilWriteMask(255)
	render.SetStencilTestMask(255)
	render.SetStencilReferenceValue(ref or 54)
end

local function drawOn()
	render.SetStencilCompareFunction(STENCIL_EQUAL)
end

local function stopCanvas()
	render.SetStencilEnable(false)
	--render.ClearDepth()
end

local reticleMat = Material("models/tfa_csgo/shared/scope_dot")

function TFA.CSGO.DrawScopeReticle(wep, p, a, s, parent)
	if wep.VMRedraw then return end
	wep.VMRedraw = true

	local model
	if isstring(parent) and wep.VElements[parent] and wep.VElements[parent].curmodel then
		model = wep.VElements[parent].curmodel
	end

	if useStencils and IsValid(model) then
		defineCanvas()

		render.SetBlend(0)
			model:DrawModel() -- we "draw" only parent model (for models without any attachments just use rtcircle model with 0 alpha as parent)
		render.SetBlend(1)

		drawOn()
	end

	render.OverrideDepthEnable(true, true)

	render.SetMaterial(reticleMat)
	a = Angle(a)
	a:RotateAroundAxis(a:Right(), 90)
	render.DrawQuadEasy(p, a:Forward(), s * 2, s * 2, color_white, a.r + 90)

	render.OverrideDepthEnable(false, false)

	if useStencils and IsValid(model) then
		stopCanvas()
	end

	wep.VMRedraw = false
end