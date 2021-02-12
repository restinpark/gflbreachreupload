local math_floor, math_pow = math.floor, math.pow
local string_TrimLeft = string.TrimLeft

-- big thanks to fingercomp for this function
local function digit(number, n)
	return math_floor((number % 10 ^ n) / 10 ^ (n - 1))
end

local cv_trimzeros = CreateClientConVar("cl_tfa_csgo_stattrack_trimzeros", 1, true, false)

local function SetStatTrakFrame(self, mat, ent)
	local kills = 0

	if IsValid(ent) and IsValid(ent:GetOwner()) and ent:GetOwner().IsTFACSGOWeapon then
		kills = TFA.CSGO.GetKills(ent:GetOwner():GetClass())
	end

	local numdigit = digit(kills, self.DisplayDigit + 1)

	if self.TrimZeros > 0 and cv_trimzeros:GetBool() and math_pow(10, self.DisplayDigit) > kills then
		mat:SetInt(self.ResultVar, 10)

		return
	end

	mat:SetInt(self.ResultVar, numdigit)
end

matproxy.Add({
	name = "TFA_CSGO_StatTrakDigit",
	init = function(self, mat, values)
		self.ResultVar = values.resultvar
		self.TrimZeros = values.trimzeros
		self.DisplayDigit = values.displaydigit
	end,
	bind = SetStatTrakFrame
})

matproxy.Add({
	name = "TFA_CSGO_StatTrakDigitBump", -- THANK YOU GMOD FOR NOT SUPPORTING TWO INSTANCES OF SAME PROXY PER MATERIAL
	init = function(self, mat, values)
		self.ResultVar = values.resultvar
		self.TrimZeros = values.trimzeros
		self.DisplayDigit = values.displaydigit
	end,
	bind = SetStatTrakFrame
})

local frames = {}
local startChar = 0x20

do
	local index = startChar

	for line = 0, 7 do
		for col = 0, 11 do
			local matrix = Matrix()
			matrix:Translate(Vector(col / 12, line / 8, 0))

			frames[string.char(index)] = matrix
			index = index + 1
		end
	end
end -- precaching all matrix objects is way less expensive than keeping TWO FONTS in memory


local function TrimAndCenterName(str)
	str = string_TrimLeft(str)

	if #str < 20 then
		str = (" "):rep(math_floor((20 - #str) / 2)) .. str
	end

	return str
end

matproxy.Add({
	name = "TFA_CSGO_WeaponLabelText",
	init = function(self, mat, values)
		self.DisplayDigit = values.displaydigit
	end,
	bind = function(self, mat, ent)
		local wepName = ""

		if IsValid(ent) and IsValid(ent:GetOwner()) and ent:GetOwner().IsTFACSGOWeapon then
			wepName = TFA.CSGO.GetNameTag(ent:GetOwner():GetClass(), ent:GetOwner():GetPrintName())
		elseif ent.TFA_CSGO_NameOverride then -- to show in preview in  name picker gui
			wepName = ent.TFA_CSGO_NameOverride
		end

		wepName = TrimAndCenterName(wepName)

		mat:SetMatrix("$basetexturetransform", frames[wepName[self.DisplayDigit + 1]] or frames[" "])
	end
})