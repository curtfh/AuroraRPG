dont = {}
O2panel = {
    button = {},
    window = {},
    label = {}
}
O2panel.window[1] = guiCreateWindow(152, 178, 391, 159, "Aur ~ Diver Oxygen", false)
guiWindowSetSizable(O2panel.window[1], false)
guiSetVisible(O2panel.window[1],false)
O2panel.label[1] = guiCreateLabel(104, 31, 187, 40, "To be able to dive for long time\nYou need to refill your oxygen tank", false, O2panel.window[1])
guiSetFont(O2panel.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(O2panel.label[1], "center", true)
O2panel.button[1] = guiCreateButton(10, 115, 107, 31, "Buy", false, O2panel.window[1])
guiSetProperty(O2panel.button[1], "NormalTextColour", "FF21EC12")
O2panel.button[2] = guiCreateButton(268, 115, 107, 31, "Close", false, O2panel.window[1])
guiSetProperty(O2panel.button[2], "NormalTextColour", "FFFE0000")
O2panel.label[2] = guiCreateLabel(129, 77, 129, 28, "Current oxygen : 0", false, O2panel.window[1])
guiSetFont(O2panel.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(O2panel.label[2], "center", false)
O2panel.label[3] = guiCreateLabel(129, 115, 129, 28, "Price : $100/100%", false, O2panel.window[1])
guiSetFont(O2panel.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(O2panel.label[3], "center", false)
local screenWidth, screenHeight = guiGetScreenSize()
local screenW,screenH=guiGetScreenSize()
function centerWindow(center_window)
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end
centerWindow(O2panel.window[1])

ItemTableSF = {
	[1] = { -1881.8984375,-1499.01953125,-4.80637550354,114.84628295898 },
	[2] = { -1798.7244873047,-1490.8205566406,-9.1741561889648,86.9541015625 },
	[3] = { -1795.9580078125,-1558.3984375,-6.0034980773926,138.97027587891 },
	[4] = { -1713.7575683594,-1549.7318115234,-8.2588787078857,79.127075195313 },
	[5] = { -1720.7738037109,-1625.9915771484,-12.963962554932,173.1240234375 },
	[6] = { -1616.1763916016,-1600.6987304688,-4.8243217468262,311.30670166016 },
	[7] = { -1716.5250244141,-1624.1151123047,-12.075777053833,248.64215087891 },
	[8] = { -1957.3673095703,-1357.462890625,-11.962432861328,306.28967285156 },
	[9] = { -1940.0678710938,-1448.4343261719,-6.3991851806641,161.84588623047 },
}
local clues = {349, 350, 325, 335, 337, 347, 358, 2263, 2703, 2837, 928, 3082, 1946, 1025, 2647, 2702, 2769}

Item = {}
startFinishMarkerSF = nil
ItemSpawned = false
render = false
cleaningPointsData = 0

-- EventHandlers for showMarker

local gasmarker = createMarker(-1832.99,-1562,21,"cylinder",2,225,0,0)
dont[gasmarker] = true

addEventHandler("onClientMarkerHit",gasmarker,function(hitElement,dm)
	if source == gasmarker then
		if dm then
			if hitElement == localPlayer then
				if not isPedInVehicle(localPlayer) then
					if ( getPlayerTeam(localPlayer) ) and (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
						guiSetVisible(O2panel.window[1],true)
						showCursor(true)
						local o222 = getElementData(localPlayer,"diveOxygen")
						if not o222 then o222 = 0 end
						guiSetText(O2panel.label[2],"Current Oxygen:"..o222)
					end
				end
			end
		end
	end
end)
synceTimer = {}
theOxygen = getElementData(localPlayer,"diveOxygen") or 0
function proSys()
	if ( getPlayerTeam(localPlayer) ) and (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		if isPlayerInWater(localPlayer) then
			local x,y,z = getElementPosition(localPlayer)
			if z <= -0.90 then
				local o22 = getElementData(localPlayer,"diveOxygen")
				if o22 == nil or o22 == false then o22 = 0 end
				if o22 >= 1 then
					--setElementData(localPlayer,"diveOxygen",o22-1)
					--setElementData(localPlayer,"diveOxygen",theOxygen)
					theOxygen = theOxygen - 1
					setPedOxygenLevel(localPlayer,(o22*10)-1)
				end
			end
		end
	end
end

addEvent("recO2",true)
addEventHandler("recO2",root,function(sd)
	theOxygen = sd
end)

setTimer(function()
	if ( getPlayerTeam(localPlayer) ) and (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		setElementData(localPlayer,"diveOxygen",theOxygen)
		triggerServerEvent("setAccountData",localPlayer)
	end
end,5000,0)

addEventHandler("onClientGUIClick",root,function()
	if source == O2panel.button[1] then
		triggerServerEvent("DiverbuyO2",localPlayer)
	elseif source == O2panel.button[2] then
		guiSetVisible(O2panel.window[1],false)
		showCursor(false)
	end
end)

function onElementDataChange( dataName, oldValue )

	if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Diver" then

		initDiverJob()

	elseif dataName == "Occupation" then

		stopDiverJob()

	end

end

addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false )

function onDiverTeamChange ( oldTeam, newTeam )

	if getElementData ( localPlayer, "Occupation" ) == "Diver" and source == localPlayer then

		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )

				---if newTeam == "Unoccupied" or newTeam == "Unemployed" or newTeam == "Staff" then



				if getElementData ( localPlayer, "Occupation" ) == "Diver" and newTeam == "Civilian Workers" then
					initDiverJob()
				else
					stopDiverJob()

				end
				if newTeam ~= "Civilian Workers" then
					stopDiverJob()
				end

			end

		end, 200, 1 )

	end

end

addEventHandler( "onClientPlayerTeamChange", localPlayer, onDiverTeamChange, false )


addEvent( "onClientPlayerTeamChange" )
function initDiverJob()

	if not isDiver then
		showMarker ()
		theOxygen = getElementData(localPlayer,"diveOxygen") or 0
		isDiver = true
	end

end
ho = {}
--https://www.mediafire.com/?8658nf63j34i8zp
function stopDiverJob ()

	if isDiver then

		if isElement(startFinishMarkerSF) then
			destroyElement ( startFinishMarkerSF )
		end
		startFinishMarkerSF = nil

		--setElementData(localPlayer, "diveP", 0)
		setElementData(localPlayer, "DiverMarkers", false)
		destroyItemMarkers ()
		if ( theItemBlip ) or ( theItemCol ) or ( theItemObject ) or theItemMarker then
			destroyItemMarkers (theItemCol)
		end
		if isTimer(ho) then killTimer(ho) end
		setElementData (localPlayer, "DiverObjects", false)
		setElementData(localPlayer, "diveP", 0)
		cleaningPointsData = 0

		ItemSpawned = false
		isDiver = false
		exports.CSGranks:closePanel()
		guiSetVisible(O2panel.window[1],false)
		showCursor(false)
		triggerServerEvent("setAccountData",localPlayer)
		if isTimer(synceTimer) then killTimer(synceTimer) end
		for k,v in ipairs(getElementsByType("blip",resourceRoot)) do
			if isElement(v) then destroyElement(v) end
		end
		for k,v in ipairs(getElementsByType("colshape",resourceRoot)) do
			if isElement(v) then destroyElement(v) end
		end
		for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
			if isElement(v) then
				if dont[v] ~= true then
					destroyElement(v)
				end
			end
		end
		for k,v in ipairs(getElementsByType("object",resourceRoot)) do
			if isElement(v) then
				if dont[v] ~= true then
					destroyElement(v)
				end
			end
		end
	end

end


function togglePilotPanel()
	if getElementData(localPlayer,"Occupation") == "Diver" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5","down",togglePilotPanel)


--https://www.mediafire.com/?muvm8amagwsl61p
-- create/destroy markers where you get orders/payout and destroy other elements on change
function showMarker ()
local cleaningPoints = getElementData(localPlayer, "diveP")
	if ( getPlayerTeam(localPlayer) ) and (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		--outputDebugString("[] Founded "..getPlayerName(localPlayer).." as Diver, continuing..")
		if not ( startFinishMarkerSF ) then
			startFinishMarkerSF = createMarker (-1820.06,-1569.52,21.5,"cylinder", 3, 255, 165, 0, 200)
			addEventHandler("onClientMarkerHit", startFinishMarkerSF, onStartFinishItemJob )
			setElementData(localPlayer, "diveP", 0)
			setElementData(localPlayer, "DiverMarkers", true)
			createItem ()
		end
		if isTimer(synceTimer) then killTimer(synceTimer) end
		synceTimer = setTimer(proSys,1000,0)
		theOxygen = getElementData(localPlayer,"diveOxygen") or 0
	else --because hes not on the job no more
		if isElement(startFinishMarkerSF) then
			destroyElement ( startFinishMarkerSF )
		end
		--setElementData(localPlayer, "diveP", 0)
		setElementData(localPlayer, "DiverMarkers", false)
		if ( theItemBlip ) or ( theItemCol ) or ( theItemObject ) or theItemMarker then
			destroyItemMarkers (theItemCol)
		end
	end
end
--addEventHandler ( "onClientPlayerLogin", getLocalPlayer(), showMarker)
addEventHandler( "onClientResourceStart", resourceRoot, showMarker)

addEventHandler("onClientPlayerQuit",root,function()
	if source == localPlayer then
		triggerServerEvent("setAccountData",localPlayer)
	end
end)

-- start and finish of the job
function onStartFinishItemJob ( hitElement, matchingDimension )
	if ( hitElement == localPlayer ) and ( matchingDimension ) then
		if (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
			if not isPedInVehicle(localPlayer) then
				local cleaningPoints = getElementData(localPlayer, "diveP")
				outputDebugString(cleaningPoints)
				if ( cleaningPoints >= 5 ) then
					local amount = tonumber((getElementData(localPlayer, "diveP"))*800)
					local amount2 = tonumber(getElementData(localPlayer, "diveP"))
					outputDebugString(amount)
					outputDebugString(amount2)
					triggerServerEvent("DiverPayout", localPlayer, amount, amount2)
					setElementData(localPlayer, "diveP", 0)
					cleaningPointsData = 0
					destroyItemMarkers ()
				elseif ( cleaningPoints == 0 ) then
					createItem ()
				else
					exports.NGCdxmsg:createNewDxMessage("You'll have to come with more before we pay you!", 0, 220, 0)
				end
			end
		end
	end
end

-- when someone hits the Item object  remove it and pick a new one/tell the person to go back.
function onItemHit ( hitElement, matchingDimension )
local cleaningPoints = getElementData(localPlayer, "diveP")
	if not (hitElement == localPlayer) then return end
	if (theItemCol) then
		if ( source == theItemCol ) and ( matchingDimension ) then
			if ( hitElement == localPlayer ) then
				if (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
					if not isPedInVehicle(localPlayer) then
						destroyItemMarkers (theItemCol)
						ItemSpawned = false
						local points = (getElementData(localPlayer, "diveP"))
						setElementData(localPlayer, "diveP", points+1)
						cleaningPointsData = cleaningPointsData + 1
						local newCleaningPoints = getElementData(localPlayer, "diveP")
						if ( newCleaningPoints == 20 ) then
							exports.NGCdxmsg:createNewDxMessage("You have collected too much drop the items in drop zone!", 0, 220, 0)
							return false
						end
						if ( newCleaningPoints < 20 ) then
							createItem ()
						end
					end
				end
			end
		end
	end
end

-- when player dies inside the sweeper
addEventHandler("onClientPlayerWasted", root,
function ()
	if source == localPlayer then
		if (startFinishMarkerSF) then
			local cleaningPoints = getElementData(localPlayer, "diveP")
			if (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
				setElementData(localPlayer, "diveP", 0)
				destroyItemMarkers ()
				setElementData (localPlayer, "DiverObjects", false)
			end
		end
	end
end)

function destroyItemMarkers (col)
	if not col then --if its a manual remove
		for k,v in ipairs(Item) do
			destroyElement(Item[v][1])
			destroyElement(Item[v][2])
			destroyElement(Item[v][3])
			destroyElement(Item[v][4])
		end
	else --if it is
		if (isElement(Item[col][1]) and isElement(Item[col][2]) and isElement(Item[col][3])) then
			destroyElement(Item[col][1])
			destroyElement(Item[col][2])
			destroyElement(Item[col][3])
			destroyElement(Item[col][4])
		end
	end
end

function createItem ()
	if (startFinishMarkerSF) then
		local cleaningPoints = getElementData(localPlayer, "diveP")
		if ((exports.server:getPlayChatZone(localPlayer)) == "SF" ) then
			if ItemSpawned ~= true then
				outputDebugString("Loop found")
				loop()
			end
		end
	end
end

function loop()
	if ItemSpawned ~= true then
		local x,y,z = unpack ( ItemTableSF [ math.random ( #ItemTableSF ) ] )
		local px, py, pz = getElementPosition(localPlayer)
		local distance = getDistanceBetweenPoints2D ( px, py, x,y )
		if math.floor(distance) >= 10 then
			makeZone(x,y,z)
		else
			if isTimer(ho) then return end
			ho = setTimer(loop,5000,0)
		end
		outputDebugString(distance)
	end
end

function makeZone(x,y,z)
	if ( getPlayerTeam(localPlayer) ) and (getElementData(localPlayer, "Occupation") == "Diver") and (getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers") then
		if ((exports.server:getPlayChatZone(localPlayer)) == "SF" ) then
			if ( ItemTableSF ) then
				if ItemSpawned ~= true then
					local cleaningPoints = getElementData(localPlayer, "diveP")
					theItemCol = createColSphere (x,y,z, 3)
					if theItemCol then
						ItemSpawned = true
						theItemObject = createObject (clues[math.random(#clues)], x,y,z)
						theItemMarker = createMarker (x,y,z,"corona",0.5,225,0,0,150)
						theItemBlip = createBlip (x,y,z, 58, 3, 0, 255, 0, 255, 99999, localplayer)
						exports.NGCdxmsg:createNewDxMessage("Restore the items from the sea look at blue ped blip on the map!", 0, 220, 0)
						Item[theItemCol] = {theItemCol,theItemObject,theItemBlip,theItemMarker}
						setElementData (localPlayer, "DiverObjects", true)
						addEventHandler( "onClientColShapeHit", theItemCol, onItemHit )
						if ( cleaningPoints >= 5 ) then
							exports.NGCdxmsg:createNewDxMessage("Restore the items from the sea or return to drop the collected items!", 0, 220, 0)
						elseif ( cleaningPoints < 5 ) then
							exports.NGCdxmsg:createNewDxMessage("Restore the items from the sea!", 0, 220, 0)
						end
					else
						loop()
					end
				end
			end
		end
	end
end


function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawBorderedText(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,
		scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
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

local screenWidth, screenHeight = guiGetScreenSize()
function createText()
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" and getElementData(localPlayer,"Occupation") == "Diver" then
		if exports.server:getPlayChatZone(localPlayer) ~= "SF" then return false end
		if ItemSpawned ~= true then
			dxDrawRelativeText( "[Diver]: Stand by (searching...)", 300,730,1256.0,274.0,tocolor(255,255,255,255),1.0,"default-bold","center","top",false,false,false )
		end
		screenWidth,screenHeight = guiGetScreenSize()
	--outputDebugString("Rendering GUI...")
		hexcode = nil
		if (cleaningPointsData < 5) then --below
			hexcode = "#FFFFFF"
		elseif (cleaningPointsData > 4 and cleaningPointsData < 20) then
			hexcode = "#00DC00"
		elseif (cleaningPointsData == 20) then --max
			hexcode = "#DC0000"
		else
			hexcode = "#FF0000"
		end
		local o2 = getElementData(localPlayer,"diveOxygen")
		if o2 == nil or o2 == false then o2 = 0 end
		local x,y,z = getElementPosition(localPlayer)
		if isPlayerInWater(localPlayer) then
			if z > -0.90 then
				if o2 == 0 then
					setPedOxygenLevel(localPlayer,5)
				else
					setPedOxygenLevel(localPlayer,(o2*10))
				end
			end
		else
			if o2 == 0 then
				setPedOxygenLevel(localPlayer,5)
			else
				setPedOxygenLevel(localPlayer,(o2*10))
			end
		end
		exports.CSGpriyenmisc:dxDrawColorText ( "#FF0000Collected Items: "..tostring(hexcode)..""..cleaningPointsData.."", screenWidth*0.10, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
		exports.CSGpriyenmisc:dxDrawColorText ( "Oxygen: "..theOxygen, screenWidth*0.20, screenHeight*0.90, screenWidth, screenHeight, tocolor ( 0, 250, 250, 255 ), 1.02, "pricedown" )
	end
end
addEventHandler("onClientRender",root,createText)

function cr()
map = {
createObject(1244,-1832.99,-1562,21.5,0,0,130),
createObject(3399,-1829.6000000,-1547.4000000,17.5000000,0.0000000,0.0000000,229.9990000), --object(cxrf_a51_stairs), (1),
createObject(3399,-1823.8000000,-1540.5000000,13.2000000,0.0000000,0.0000000,229.9990000), --object(cxrf_a51_stairs), (2),
createObject(3399,-1816.9000000,-1532.3000000,8.8000000,0.0000000,0.0000000,229.9990000), --object(cxrf_a51_stairs), (4),
createObject(8613,-1809.0000000,-1527.6000000,3.1000000,0.0000000,0.0000000,137.9990000), --object(vgssstairs03_lvs), (1),
createObject(3361,-1802.1000000,-1543.2000000,1.9000000,0.0000000,0.0000000,51.9980000), --object(cxref_woodstair), (5),
createObject(9958,-1803.5000000,-1501.1000000,4.3000000,0.0000000,0.0000000,62.9980000), --object(submarr_sfe), (1),
createObject(1637,-1847.7998000,-1559.7002000,22.0000000,0.0000000,0.0000000,0.0000000), --object(od_pat_hutb), (1),
createObject(1607,-1860.1000000,-1559.2000000,26.0000000,0.0000000,0.0000000,86.0000000), --object(dolphin), (1),
createObject(1461,-1851.3000000,-1559.8000000,21.6000000,0.0000000,0.0000000,0.0000000), --object(dyn_life_p), (1),
createObject(354,-1818.4004000,-1573.2998000,36.5000000,0.0000000,0.0000000,0.0000000), --object(1),
createObject(3399,-1831.4000000,-1549.5000000,16.2000000,0.0000000,338.0000000,229.9990000), --object(cxrf_a51_stairs), (1),
createObject(3399,-1817.6000000,-1531.7000000,8.8000000,0.0000000,0.0000000,229.9990000), --object(cxrf_a51_stairs), (4),
createObject(3399,-1824.4000000,-1539.9000000,13.2000000,0.0000000,0.0000000,229.9990000), --object(cxrf_a51_stairs), (2),
createObject(3399,-1830.3000000,-1546.9000000,17.5000000,0.0000000,0.0000000,229.9990000), --object(cxrf_a51_stairs), (1),
createObject(3399,-1832.0000000,-1548.9000000,16.2000000,0.0000000,338.0000000,229.9990000), --object(cxrf_a51_stairs), (1),
createObject(3361,-1806.5000000,-1548.9000000,5.9000000,0.0000000,0.0000000,51.9980000), --object(cxref_woodstair), (5),
createObject(3361,-1810.8000000,-1554.3000000,9.1000000,0.0000000,0.0000000,51.9980000), --object(cxref_woodstair), (5),
createObject(3361,-1815.0000000,-1559.7000000,13.1000000,0.0000000,0.0000000,51.9980000), --object(cxref_woodstair), (5),
createObject(3361,-1817.9000000,-1563.4000000,16.2000000,0.0000000,0.0000000,51.9980000), --object(cxref_woodstair), (5),
createObject(3361,-1797.4000000,-1537.2000000,-2.0000000,0.0000000,0.0000000,51.9980000), --object(cxref_woodstair), (5),
createObject(3399,-1816.6000000,-1561.8000000,15.4000000,0.0000000,330.0000000,230.7490000), --object(cxrf_a51_stairs), (1),
createObject(3115,-1840.4000000,-1556.2000000,9.8000000,0.0000000,90.0000000,318.2500000), --object(carrier_lift1_sfse), (2),
createObject(3115,-1837.7000000,-1558.6000000,9.8000000,0.0000000,90.0000000,138.4960000), --object(carrier_lift1_sfse), (3),
createObject(3115,-1838.2000000,-1553.7000000,9.8000000,0.0000000,90.0000000,318.2460000), --object(carrier_lift1_sfse), (4),
createObject(3115,-1835.8000000,-1556.5000000,9.8000000,0.0000000,90.0000000,138.4940000), --object(carrier_lift1_sfse), (5),
createObject(3115,-1818.0000000,-1565.5000000,9.8000000,0.0000000,90.0000000,140.2440000), --object(carrier_lift1_sfse), (6),
createObject(3115,-1819.9000000,-1563.4000000,9.8000000,0.0000000,90.0000000,320.4940000), --object(carrier_lift1_sfse), (7),
createObject(9237,-1818.2998000,-1573.5996000,28.9000000,0.0000000,0.0000000,294.0000000), --object(lighhouse_sfn), (1),
createObject(354,-1814.9000000,-1562.0000000,18.3000000,0.0000000,0.0000000,0.0000000), --object(1),
createObject(354,-1817.1000000,-1560.3000000,18.3000000,0.0000000,0.0000000,0.0000000), --object(1),
createObject(354,-1833.7000000,-1551.4000000,18.3000000,0.0000000,0.0000000,0.0000000), --object(1)

}

for k,v in ipairs(map) do
	dont[v] = true
	setObjectBreakable(v, false)
end
end
cr()

