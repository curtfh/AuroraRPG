local sW, sH = guiGetScreenSize()

local resX, resY = 1600, 900

function aToR( X, Y, sX, sY)
	local xd = X/resX or X
	local yd = Y/resY or Y
	local xsd = sX/resX or sX
	local ysd = sY/resY or sY
	return xd*sW, yd*sH, xsd*sW, ysd*sH
end

local keys = {
	{ 9650, "Move +X;Arrow U", "arrow_u"}, -- Up
	{ 9660, "Move -X;Arrow D", "arrow_d"}, -- Down
	{ 9664, "Move +Y;Arrow L", "arrow_l"}, -- Left
	{ 9654, "Move +Y;Arrow R", "arrow_r"}, -- Right
	{ 8657, "Rotate+;Scroll U", "mouse_wheel_up"}, -- Page Up
	{ 8659, "Rotate-;Scroll D", "mouse_wheel_down"}, -- Page Down
	{ 8679, "Faster;L Shift", "lshift"}, -- Fast Object
	{ 8984, "Slower;L Alt", "lalt"}, -- Slow Object
	{ 9003, "Delete;Delete", "delete"}, -- Delete Object
	{ 9111, "Move +Z;Page U", "pgup"}, -- Height +
	{ 9112, "Move -Z;Page D", "pgdn"}, -- Height -
}

colors = {}

local sZ = -350
local offX = 89
local offY = 81

function insertKeyGuide( theGuide)
	colors = {}
	if type( theGuide) == "table" then
		keys = theGuide
		for i, letter in ipairs (theGuide) do
			local bind = letter[3]
			colors[bind] = "127,127,127"
		end
	end
end
