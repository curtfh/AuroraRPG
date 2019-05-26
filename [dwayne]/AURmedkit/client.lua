local kit = 0
local medicmarkers={}
local obs = {}

medkitsPickups = {
	{ x = 1178.38, y=-1329.49, z=14.1 }, -- All Saints kit
    { x = 2040, y = -1425.4390869141, z = 17 }, -- Jefferson kit
    { x = -2675.2497558594, y = 631, z = 14.3 }, -- SF's kit
    { x = 1598.15, y=1825, z = 10.82 }, -- LV's kit Airport
    { x = 1259, y=327, z = 19 }, -- Redsands East kit
    { x = -325.95867, y = 1052, z = 20 },
    { x = -2200, y = -2315.38, z = 30.3 }, -- Angel Pine
}

function unpackMarkers()
    for i, w in pairs( medkitsPickups ) do
        medkits = createPickup( w.x,w.y,w.z, 3, 1240 )
		showMarker = createMarker( w.x,w.y,w.z-1,"corona",1,255,0,0,150 )
		medicmarkers = createMarker( w.x,w.y,w.z-1,"cylinder",1.5,150,0,100,0 )
		addEventHandler("onClientMarkerHit",medicmarkers,medkit)
    end
end

function medkitsOnStart()
    unpackMarkers()
end
addEventHandler("onClientResourceStart", resourceRoot, medkitsOnStart)

function onChange(d)
	if (d == "isPlayerProtected") then
		local found = false 

		for i, v in ipairs(getEventHandlers("onClientRender", root)) do
			if (v == showTextOnTop) then
				found = true
			end
		end

		if (getElementData(localPlayer, d)) then
			if (not found) then
				addEventHandler("onClientRender", root, showTextOnTop)
			end
		else
			if (found) then
				removeEventHandler("onClientRender", root, showTextOnTop)
			end
		end
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onChange)

function showTextOnTop()
    local xx, yy, zz = getElementPosition(localPlayer)
	for k,v in ipairs(medkitsPickups) do
		local mXX, mYY, mZZ = v.x,v.y,v.z
		local rr, gg, bb = 150,0,100
		local sxx, syy = getScreenFromWorldPosition(mXX, mYY, mZZ+1)
		if (sxx) and (syy) then
			local distancee = getDistanceBetweenPoints3D(xx, yy, zz, mXX, mYY, mZZ)
			if (distancee < 30) then
				dxDrawText("Medic Kits\n\n\n\n\n\n", sxx+6, syy+6, sxx, syy, tocolor(0, 0, 0, 255), 2-(distancee/30),  "sans", "center", "center")
				dxDrawText("Medic Kits\n\n\n\n\n\n", sxx+2, syy+2, sxx, syy, tocolor(255, 0, 0, 255), 2-(distancee/30), "sans", "center", "center")

				dxDrawText("\n\n Type /heal or /medkit\nTo refill your health", sxx+6, syy+6, sxx, syy, tocolor(0, 0, 0, 255), 2-(distancee/30),  "sans", "center", "center")
				dxDrawText("\n\n Type /heal or /medkit\nTo refill your health", sxx+2, syy+2, sxx, syy, tocolor(250, 0, 0, 255), 2-(distancee/30), "sans", "center", "center")
			end
		end
	end
end

function kit()
	medwin = guiCreateWindow(0.38, 0.31, 0.24, 0.38, "AUR ~ Medkits", true)
	guiWindowSetSizable(medwin, false)
	guiSetAlpha( medwin, 1.0 )
	guiSetVisible(medwin, false)

	txt = guiCreateLabel(0.03, 0.07, 0.95, 0.46, "Each medkit costs $1,500\n\n\n\nType /medkit or /heal to use medkits\n\n\n\nYou have X medkits", true, medwin)
	guiSetFont(txt, "default-bold-small")
	guiLabelSetHorizontalAlign(txt, "left", true)

	edit = guiCreateEdit(0.04, 0.65, 0.92, 0.08, "Amount", true, medwin)

	button77 = guiCreateButton(0.04, 0.88, 0.92, 0.09, "Close", true, medwin)

	button66 = guiCreateButton(0.04, 0.77, 0.92, 0.09, "Buy", true, medwin)

	txt1 = guiCreateLabel(0.03, 0.56, 0.96, 0.06, "Cost: $0", true, medwin)

	addEventHandler( "onClientGUIClick", edit,
		function()
			guiSetText( edit, "" )
		end, false
	)

	addEventHandler( "onClientGUIChanged", edit, removeLetters, false )
end
addEventHandler( "onClientResourceStart", resourceRoot, kit )

function removeLetters(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
	local txts = guiGetText(element)
	if ( txts ~= "" and tonumber( txts2 ) ) then
		guiSetText( txt1, "Cost: $"..exports.server:convertNumber( txts * 1500 ) )
	end
	if  string.len( tostring( guiGetText(edit) ) ) > 4 then
		exports.NGCdxmsg:createNewDxMessage("You can't spam these useless numbers",255,0,0)
		guiSetText(edit,"")
		guiSetText(txt1,"Cost: $0")
		return false
	end
end

addEventHandler( "onClientGUIClick", root,
    function ()
        if ( source == button66 ) then
			if isTimer( antiSpamTimer ) then return false end
			player = localPlayer
			if  string.len( tostring( guiGetText(edit) ) ) > 6 then
				exports.NGCdxmsg:createNewDxMessage("You can't spam these useless numbers",255,0,0)
				guiSetText(edit,"")
				return false
			end
			local amount = guiGetText(edit)
			if amount and tonumber(amount) then
				local cost = amount * 1500
				local kitsmoney = getPlayerMoney(player)
				if ( kitsmoney >= cost ) then
					antiSpamTimer = setTimer( function() end, 1000, 1 )
					triggerServerEvent( "takeKitMoney", player, amount, cost )
				else
					exports.NGCdxmsg:createNewDxMessage( "You don't have enough money", 255, 0, 0 )
				end
			else
				exports.NGCdxmsg:createNewDxMessage( "Insert number value", 255, 0, 0 )
			end
        end
    end
)

addEvent( "NGCmedkitsbought", true )
addEventHandler( "NGCmedkitsbought", localPlayer,
	function ( amount )
		kit = kit + amount
		guiSetText( txt, "Each medkit costs $1,500\n\n\n\nType /medkit or /heal to use medkits\n\n\n\nYou have "..kit.." medkits" )
		--exports.NGCdxmsg:createNewDxMessage("You bought 1 Medic kit .Cost $900", 0, 255, 0)
	end
)

addEventHandler( "onClientGUIClick", root,
    function ()
        if ( source == button77 ) then
			guiSetVisible( medwin, false )
			showCursor ( false )
        end
	end
)

function medkit( p )
	if p ~= localPlayer then return end
	local mx ,my, mz = getElementPosition( source ) -- marker
	local hx, hy, hz = getElementPosition( p ) -- hitelement ( player/vehicle etc. )
	if ( hz < mz + 2 ) then
		guiSetVisible( medwin, true )
		showCursor( true )
		guiSetText( txt, "Each medkit costs $1,500\n\n\n\nType /medkit or /heal to use medkits\n\n\n\nYou have "..kit.." medkits" )
	end
end

function isElementMoving ( theElement )
    if isElement ( theElement ) then                     -- First check if the given argument is an element
        local x, y, z = getElementVelocity( theElement ) -- Get the velocity of the element given as argument
        return x ~= 0 or y ~= 0 or z ~= 0                -- When there is a movement on X, Y or Z return true because our element is moving
    end

    return false
end

local cd = {}
local fucking = {}
function usemed( player )
	player = getLocalPlayer()
	if getPedAnimation(player) then exports.NGCdxmsg:createNewDxMessage("This feature is disabled when doing an animations",255,0,0) return false end
	if exports.NGCduel:isPlayerDueling(localPlayer) then exports.NGCdxmsg:createNewDxMessage("You can't heal yourself while you are dueling",255,0,0) return false end
	if getElementData(player,"isPlayerArrested") == true then exports.NGCdxmsg:createNewDxMessage("This feature is disabled while you are arrested",255,0,0) return false end
	if getElementData(player,"isPlayerJailed") == true then exports.NGCdxmsg:createNewDxMessage("This feature is disabled while you are jailed",255,0,0) return false end
	if isPlayerInVehicle(player) then exports.NGCdxmsg:createNewDxMessage("You can't use medkits in vehicle" ,255,0,0) return false end
	if getElementData(player,"isPlayerProtected") == true then exports.NGCdxmsg:createNewDxMessage("You can't use medic kits in safe zone" ,255,0,0) return false end
	if (getElementDimension(player) == 2000) then exports.NGCdxmsg:createNewDxMessage("You can't use medic kits in this moment" ,255,0,0) return false end
	local moveState = getPedMoveState( player )
	if isElementMoving(localPlayer) then exports.NGCdxmsg:createNewDxMessage("You can't use medic kits while you're moving!!" ,255,0,0) return false end
	if (kit > 0) then
		if getElementHealth(player) == 100 and getPedStat(localPlayer, 24) < 900 or getElementHealth(player) == 200 and getPedStat(localPlayer, 24) > 900 then
			exports.NGCdxmsg:createNewDxMessage("You can't use this feature while have full health",255,0,0)
			return false
		end
		if isTimer(fucking[localPlayer]) then
			exports.NGCdxmsg:createNewDxMessage("You already are using medic kit wait 6 seconds.",255,0,0)
		return false end
		if (cd[localPlayer]) then
			if getTickCount() - cd[localPlayer] <= 6000 then
				exports.NGCdxmsg:createNewDxMessage("Please wait before trying to use medic kits again",255,0,0)
				return
			end
		else
			cd[localPlayer] = getTickCount()
		end
		cd[localPlayer] = getTickCount()
		fucking[localPlayer] = setTimer (function(localPlayer)
			if getElementHealth(localPlayer) >= 1 then
				if getElementAlpha(localPlayer) >= 250 then
					if not isPedDead(localPlayer) then
						if not getElementData(localPlayer,"isPlayerProtected") then
							setElementHealth(localPlayer,getElementHealth(localPlayer) + 25)
						end
					end
				end
			end
		end,6000,1,localPlayer)
		rectangleAlpha = 170
		rectangleAlpha2 = 170
		textAlpha = 255
		textAlpha2 = 255
		count = 8
		addkitText()
		kit = kit - 1
		exports.NGCdxmsg:createNewDxMessage( ""..kit.." medikits left ", 255, 100, 0)
		triggerServerEvent( "usedMK", localPlayer )
	elseif (kit == 0) then
		kit = 0
		exports.NGCdxmsg:createNewDxMessage( "You don't have more medic kits", 90, 0, 200 )
	end
end
addCommandHandler( "medkit", usemed )
addCommandHandler( "heal", usemed )
kit = 5
addEvent( "recMK", true )
addEventHandler( "recMK",localPlayer,
	function ( k )
		if k then
			kit=k
			if kit < 0 then kit = 0 end
		end
	end
)

addEvent( "recMK2", true )
addEventHandler( "recMK2", localPlayer,
	function ( k )
		if k then
			guiSetText(txt,"Each medkit costs $1,500\n\n\n\nType /medkit or /heal to use medkits\n\n\n\nYou have "..k.." medkits")
		else
			guiSetText(txt,"Each medkit costs $1,500\n\n\n\nType /medkit or /heal to use medkits\n\n\n\nYou have 0 medkits")
		end
	end
)

addEvent( "rev", true )
addEventHandler( "rev",localPlayer,
	function ( m )
		if m then
			kit= m
		end
	end
)

local screenWidth, screenHeight = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
rectangleAlpha = 170
rectangleAlpha2 = 170
textAlpha = 255
textAlpha2 = 255


function dxDrawBorderedText ( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end


function addkitText(msg)
	fadeTimer = setTimer(fadeTheText, 500, 0)
	removeEventHandler("onClientRender", root, drawkitText)
	addEventHandler("onClientRender", root, drawkitText)
end
addEvent("addkitText", true)
addEventHandler("addkitText", root, addkitText)

addEventHandler("onClientPlayerWasted",localPlayer,function()
	if source ~= localPlayer then return false end
	if isTimer(fadeTimer) then killTimer(fadeTimer) end
	if isTimer(fucking[localPlayer]) then killTimer(fucking[localPlayer]) end
	removeEventHandler("onClientRender", root, drawkitText)
end)

addEventHandler("onClientLocalPlayerDamage",localPlayer,function()
	if source ~= localPlayer then return false end
	if isTimer(fadeTimer) then killTimer(fadeTimer) end
	if isTimer(fucking[source]) then killTimer(fucking[source]) end
	removeEventHandler("onClientRender", root, drawkitText)
end)

addEventHandler ( "onClientElementDataChange",localPlayer,
function ( dataName,old )
	if source and source == localPlayer and getElementType ( source ) == "player" and dataName == "safezone" or dataName == "isPlayerProtected" then
		if old == false then
			if isTimer(fadeTimer) then killTimer(fadeTimer) end
			if isTimer(fucking[source]) then killTimer(fucking[source]) end
			removeEventHandler("onClientRender", root, drawkitText)
		end
	end
end)

setTimer(function()
	if getElementData(localPlayer,"isPlayerProtected") then
		if isTimer(fadeTimer) then killTimer(fadeTimer) end
		if isTimer(fucking[source]) then killTimer(fucking[source]) end
		removeEventHandler("onClientRender", root, drawkitText)
	end
end,1000,0)

function fadeTheText()
	if isTimer(fucking[localPlayer]) then
		local minx,maxx,left = getTimerDetails(fucking[localPlayer])
		local minx = math.floor(minx / 1000)
		if minx <= 0 then
			if isTimer(fadeTimer) then killTimer(fadeTimer) end
			removeEventHandler("onClientRender", root, drawkitText)
		end
	else
		if isTimer(fadeTimer) then killTimer(fadeTimer) end
		removeEventHandler("onClientRender", root, drawkitText)
	end
end

function drawkitText()
	if isTimer(fucking[localPlayer]) then
		local minx,maxx,left = getTimerDetails(fucking[localPlayer])
		local minx = math.floor(minx / 1000)
		if minx >= 0 and minx <= 6 then
			dxDrawBorderedText("Medic kit action in: "..minx, 1, (screenW - 504) / 2, (screenH - 350) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,150,0, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		end
	end
end



function dxDrawFramedText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top + 1, width + 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top - 1, width + 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top + 1, width - 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top - 1, width - 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
end
