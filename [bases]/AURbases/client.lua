local tables = {						-- r, g, b, text, x, y, shadow
---------Groups
	{170, 140, 100, "Advanced Assault Forces", 208.22, 1911.04, 0},
	{255,255,0, "The Terrorists", 2571.32, 529.25, 0},
	{0,90,0, "The Cobras", 901.52, 1484.32, 0}, 
	{105,106,109, "FBI", 2887.23, -315.12, 0},  

---------Misc
	{255,0,0,"DM Area",1628.95, 1931.7,0},
	{0,205,255,"LAW Training Zone",1059.56,-321.52,0},
	{250,0,0,"Drug Farm",1937.60913, 188.48071,0},
	{0,0,0,"SW.RT",1102.3444824219,777.12707519531,0,100},
	{0,0,0,"SE.RT",2753.7126464844,945.28137207031,0,100},
	{0,0,0,"NE.RT",2755.4145507813,2597.25390625,0,100},
	{0,0,0,"NW.RT",1402.9519042969,2822.0588378906,0,100},
	{0, 0, 255, "Police", 1533.22583, -1632.06982, 0},
	{0, 0, 255, "Police",  -210.85,978.8, 0}, 
	{0, 0, 255, "Police",  2349.73,2456.11, 0}, 
	{0, 0, 255, "Police",  -1398.67,2643.94, 0},
	{0, 0, 255, "Police",  635.86,-579.12, 0}, 
	{0, 0, 255, "Police",  -2165.79,-2390.59, 0},
	{0, 0, 255, "Police",  -1610.21,717.19, 0}, 
	{60, 255, 205, "Paramedic", 1190.13770, -1327.36743, 0},	
	{60, 255, 205, "Paramedic", 1627.15,1828.75, 0},
	{60, 255, 205, "Paramedic", -2641.07,630.98, 0},
	{60, 255, 205, "Paramedic", -2198.24,-2308.09, 0},	
	{60, 255, 205, "Paramedic", -1509.38,2526.54, 0},
	{60, 255, 205, "Paramedic", 1255.04,331.564, 0},	
	{255, 225, 40, "Mechanic",  1039.69263, -1035.85840, 0}, 
	{255, 225, 40, "Mechanic",  1966.69,2153.68, 0}, 
	{255, 225, 40, "Mechanic",  706.07,-476.74, 0}, 
	{255, 225, 40, "Mechanic",  2074.41,-1872.08, 0}, 
	{255, 225, 40, "Mechanic",  -2029.06,159.8, 0},
	{255, 225, 40, "Mechanic",  -2257.52,-2388.54, 0},
	{255, 225, 40, "Mechanic", 2395,1017, 0},
	{255, 225, 40, "Pilot", 1896.89,-2250.22, 0},
	{255, 225, 40, "Pilot", 403.57,2529.3, 0},	
	{255, 225, 40, "Pilot", 1708.13,1617.19, 0},
	{255, 225, 40, "Pilot", -1544.14,-442.98, 0},
	{220, 45, 40, "Firefighter", 1100.71,-1207.1, 0}, 
	{220, 45, 40, "Firefighter", -2019.73,63.96, 0}, 
	{255, 225, 40, "Fairy Captain",  2510.13,-2696.77, 0}, 
	{255, 225, 40, "Lumberjack",  -523.18,-176.67, 0}, 
	{255, 225, 40, "Lumberjack",  1553.11,56.87, 0}, 
	{255, 225, 40, "Miner",  -389.72,2217.83, 0}, 
	{255, 225, 40, "Farmer",  -1057.74,-1207.93, 0}, 
	{255, 225, 40, "Farmer",  688.37,1940.53, 0}, 
	{255, 225, 40, "Diver",  -1849.87,-1564.56, 0}, 
	{255, 225, 40, "Taxi",  -1757.2,949.18, 0}, 
	{255, 225, 40, "Pizza Boy",  -1724.47,1351.96, 0}, 
	{255, 225, 40, "Fisherman",  -2092.35,1411.26, 0},
	{255, 225, 40, "Fisherman",  993,-2116.26, 0},	
	{255, 225, 40, "Fisherman",  1623,580, 0},	
	{255, 225, 40, "Rescuer Man",  -2827.12,1305.67, 0},
	{255, 225, 40, "Postman",  -1918.13,723.91, 0}, 
	{255, 225, 40, "Trucker",  -1695.07,-17, 0}, 
	{255, 225, 40, "Trash Collector",  -1863.76,-203.43, 0}, 
	{255, 225, 40, "Clothes Seller",  -2271.13,182.81, 0}, 
	{255, 0, 0, "Thief",  1689.5,1222.54, 0}, 
	}


function dxDrawBorderedText( alpha,shadow,text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if shadow == 0 then
		shadowR = 0
		shadowG = 0
		shadowB = 0
	else
		shadowR = 255
		shadowG = 255
		shadowB = 255
	end
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( shadowR,shadowG,shadowB, alpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

-- Settings variables
local textFont       = "default-bold"			-- The font of the tag text
local textScale      = 0.85						-- The scale of the tag text
local heightPadding  = 5						-- The amount of pixels the tag should be extended on either side of the vertical axis
local widthPadding   = 2						-- The amount of pixels the tag should be extended on either side of the horizontal axis
local xOffset        = 8						-- Distance between the player blip and the tag
local minAlpha       = 10						-- If blip alpha falls below this, the tag won't the shown
local textAlpha      = 255
local rectangleColor = tocolor(0,0,0,0)
local w,h = guiGetScreenSize()
local red,green,blue = 255,0,0


-- RT1
local floors = math.floor


function getBasesTable()
	return tables
end

function drawMapStuff2()
	if isPlayerMapVisible() then
		for k,v in ipairs(tables) do
			local sx,sy,ex,ey = getPlayerMapBoundingBox()							-- Map positions
			local mw,mh = ex-sx,sy-ey											-- Map width/height
			local cx,cy = (sx+ex)/2,(sy+ey)/2									-- Center position of the map
			local ppuX,ppuY = mw/6000,mh/6000										-- Pixels per unit
			local fontHeight = dxGetFontHeight(textScale,textFont)					-- Height of the specified font
			local yOffset = fontHeight/2										-- How much pixels the tag should be offsetted at
			local px,py = v[5],v[6]
			local x = floors(cx+px*ppuX+xOffset)						-- X for the nametag
			local y = floors(cy+py*ppuY-yOffset)						-- Y for the nametag
			local pname = v[4]
			local nameLength = dxGetTextWidth(pname,textScale,textFont)			-- Width of the playername
			local r,g,b = v[1],v[2],v[3]
			local alpha = 200
			local alpha2 = 180
			if r == 0 and g == 0 and b == 0 then
				r,g,b = red,green,blue
				alpha = 200
				alpha2 = 50
			end
			dxDrawBorderedText(alpha2,v[7],pname,x,y,x-nameLength+50,y+fontHeight, tocolor(r,g,b,alpha), textScale, "default-bold", "center", "center", false, false)
		end
	end
end
addEventHandler("onClientRender",getRootElement(),drawMapStuff2)
