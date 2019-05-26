
local sX, sY = guiGetScreenSize()
local nX, nY = 1366, 768
local vehicleType = nil
local vehicleTable = {
	-- rank id, car 1 , car 2
	{1,585,596},
	{2,547,555},
	{3,549,542},
	{4,410,401},
	{5,479,467},
	{6,516,445},
	{7,466,492},
	{8,585,490},
	{9,400,579},
	{10,579,495},
	{11,400,489},
	{12,418,546},
	{13,421,566},
	{14,434,558},
	{15,535,495},
	{16,535,495},
	{17,405,561},
	{18,439,475},
	{19,426,558},
	{20,550,603},
	{21,477,415},
	{22,587,565},
	{23,402,480},
	{24,599,426},
	{25,562,494},
	{26,506,541},
	{27,451,411},
	{28,411,526},

}
--[[

]]

function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
	local posX = posX + 650
	local posY = posY + 180
	local scale = (sX/1024)*1
    return dxDrawBorderedText(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,( sWidth/resolutionX )*scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI
    )
end

function dxDrawRelativeRectangle( posX, posY, width, height,color,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
	local posX = posX + 320
	local posY = posY + 180
    return dxDrawRectangle(
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( width/resolutionX )*sWidth,
        ( height/resolutionY )*sHeight,
        color,
        postGUI
    )
end


function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

function math.round( number, decimals, method )
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if ( method == "ceil" or method == "floor" ) then return math[method]( number * factor ) / factor
    else return tonumber( ( "%."..decimals.."f" ):format( number ) ) end
end

local dimensionToName = {
	[5001] = "Shooter",
	[5002] = "Destruction Derby",
}

addEventHandler( "onClientRender", root, function()
	if getElementDimension(localPlayer) == 5002 or getElementDimension(localPlayer) == 5001 then
		if isPedInVehicle(localPlayer) then
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh and isElement(veh) and getElementModel(veh) ~= 430 then
				local xp = getElementData(localPlayer,"playerXP")
				local rank = getElementData(localPlayer,"playerLevel")
				if rank then
					for k,v in ipairs(vehicleTable) do
						if tonumber(v[1]) == tonumber(rank) then
							if xp and tonumber(xp) and tonumber(xp) <= 50 then
								vehicleType = getVehicleNameFromID(v[2])
							elseif xp and tonumber(xp) and tonumber(xp) > 50 then
								vehicleType = getVehicleNameFromID(v[3])
							end
						end
					end
					if vehicleType then
						local value = math.round( xp / 0.3 )
						dxDrawRelativeRectangle(305, 482, 191, 35, tocolor(5, 3, 0, 125), true)
						dxDrawRelativeRectangle(229, 517, 345, 35, tocolor(1, 1, 1, 125), true)
						dxDrawRelativeRectangle(231, 520, 340, 28, tocolor(0, 0, 0, 125), true)
						dxDrawRelativeRectangle(232, 521, value, 26, tocolor(250, 150, 0, 255), true)
						dxDrawRelativeText("Level: "..rank.." ("..vehicleType..")", 301, 482 + 3, 301 + 191, 482 + 3, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "top", false, false, true, true, false)
						dxDrawRelativeText("Aurora ~ "..(dimensionToName[getElementDimension(localPlayer)]), 305, 432, 495, 517, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "top", false, false, true, true, false)
						dxDrawRelativeText(xp.."/100", 301, 521, 491, 547, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "top", false, false, true, false, false)
					end
				end
			end
		end
	end
end)
