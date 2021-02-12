TFA.CSGO = TFA.CSGO or {}

local CSGO = TFA.CSGO

local sql_Query, sql_QueryValue = sql.Query, sql.QueryValue

sql_Query([[
	CREATE TABLE IF NOT EXISTS tfa_csgo_nametags (
		class VARCHAR(80) NOT NULL,
		name VARCHAR(20) NOT NULL,
		PRIMARY KEY (class)
	)
]])

local Format, SQLStr = string.format, SQLStr
local NameTagCache = {}

function CSGO.GetNameTag(class, fallback)
	assert(type(class) == "string", "Invalid class name provided!")

	if not NameTagCache[class] then
		NameTagCache[class] = sql_QueryValue(Format([[SELECT name FROM tfa_csgo_nametags WHERE class = %s]], SQLStr(class))) or fallback
	end

	return NameTagCache[class]
end

function CSGO.SetNameTag(class, newname)
	assert(type(class) == "string", "Invalid class name provided!")
	assert(type(newname) == "string", "Invalid replacement name provided!")

	sql_Query(Format([[REPLACE INTO tfa_csgo_nametags (class, name) VALUES (%s, %s)]], SQLStr(class), SQLStr(newname)))

	NameTagCache[class] = nil
end

function CSGO.ResetNameTag(class)
	assert(type(class) == "string", "Invalid class name provided!")

	sql_Query(Format([[DELETE FROM tfa_csgo_nametags WHERE class = %s]], SQLStr(class)))

	NameTagCache[class] = nil
end

function CSGO.ResetNameTags()
	for _, wep in ipairs(weapons.GetList()) do
		if weapons.IsBasedOn(wep.ClassName, "tfa_csgo_base") then
			CSGO.ResetNameTag(wep.ClassName)
		end
	end
end