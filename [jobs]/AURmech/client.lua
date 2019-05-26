local mechanicFixWindow
local GUIIsShowing
local MechanicGUI = {}
local proTimer = {}

local resX, resY = guiGetScreenSize()
holyVehicle = false
theTable = {}
function getUpgradePrice(upgrade,mechanicIsLocalPlayer,vehicle,plar)

	local price
	local needsUpgrade = true
	local vehicleUpgrades
	local upgradesOwned
	if vehicle then
		vehicleUpgrades = getVehicleUpgrades(vehicle)
		upgradesOwned = {}
		for key,value in ipairs(vehicleUpgrades) do
			upgradesOwned[tonumber(value)] = true
		end
	end
	if not upgrade then return false end

	if upgrade == 1 then
		-- Nitro option
		if mechanicIsLocalPlayer then if tonumber(getElementData(plar,"nos")) and tonumber(getElementData(plar,"nos")) >= 5000 then needsUpgrade = "You have 5000 NOS" end end
		if mechanicIsLocalPlayer then price = 15000 else price = 15000 end
	elseif upgrade == 2 then
		-- Hydraulics option
		if vehicle then if upgradesOwned[1087] then needsUpgrade = "Your vehicle already has hydraulics!" end end
		if mechanicIsLocalPlayer then price = 1500 else price = 4000 end
	elseif upgrade == 3 then
		-- Fixing wheels option
		if vehicle then
			local w1,w2,w3,w4 = getVehicleWheelStates(vehicle)
			local wheels = {w1,w2,w3,w4}
			local numberOfWheelsDamaged = 0
			for i=1,#wheels do
				if wheels[i] > 0 then
					numberOfWheelsDamaged = numberOfWheelsDamaged +1
				end
			end
			if mechanicIsLocalPlayer then price = numberOfWheelsDamaged*100 else price = numberOfWheelsDamaged*200 end
			if numberOfWheelsDamaged < 1 then needsUpgrade = "Your vehicle's wheels aren't damaged!" end
		else
			if mechanicIsLocalPlayer then price = '100-400' else price = '200-800' end
		end
	elseif upgrade == 4 then
		-- Complete vehicle repair option
		if vehicle then
			local vehHealth = getElementHealth(vehicle)
			local panelsDamaged = areVehiclePanelsDamaged(vehicle)
			if vehHealth >= 1000 and panelsDamaged < 1 then needsUpgrade = "Your vehicle isn't damaged!" end
			local panelsPrice = panelsDamaged * 50
			price = panelsPrice + math.ceil((1000-math.min(vehHealth,1000))/10)*50
			if mechanicIsLocalPlayer then
				price = math.ceil((math.max(price*0.75,0))/10)*10
			end
		else
			price = '50-5200'
			if mechanicIsLocalPlayer then
				price = '40-3900'
			end
		end
	elseif upgrade == 5 then
		if vehicle then
			local fuel = getElementData(vehicle,"vehicleFuel")
			local fuelNeeded = 100 - fuel
			if fuelNeeded > 0 then
				price = fuelNeeded*10
				if mechanicIsLocalPlayer then
					price = math.ceil(fuelNeeded*7.5)
				end
			else
				needsUpgrade = "Your vehicle does not need fuel!"
			end
		else
			price = '100-1000'
			if mechanicIsLocalPlayer then
				price = '75-750'
			end
		end
	end

	return price, needsUpgrade
end

local radioButtons = { { getUpgradePrice(1,false,false), "Buy 500 NOS", nil },
	{ getUpgradePrice(2,false,false), "Buy hydraulics", nil },
	{ getUpgradePrice(3,false,false), "Fix vehicle wheels", nil },
	{ getUpgradePrice(4,false,false), "Fix entire vehicle", nil },
	{ getUpgradePrice(5,false,false), "Refuel vehicle", nil }
}

addEventHandler( "onClientResourceStart", resourceRoot,
    function ()

	    local windowHeight = 100+(#radioButtons*21)
		mechanicFixWindow = guiCreateWindow(557,364,281,windowHeight,"AUR ~ Mechanic",false)
		guiSetVisible (mechanicFixWindow, false)
		mechanicFixLabel = guiCreateLabel(8,27,266,18,"",false,mechanicFixWindow)
		guiLabelSetColor(mechanicFixLabel,0,200,0)
		guiLabelSetHorizontalAlign(mechanicFixLabel,"center",false)
		guiSetFont(mechanicFixLabel,"default-bold-small")
		for i=1,#radioButtons do
			local x,y,width,height = 11,34+(i*21),230,21
			local gui = guiCreateRadioButton(x,y,width,height, radioButtons[i][2].."( $"..radioButtons[i][1].." )", false, mechanicFixWindow)
			radioButtons[i][3] = gui
		end
		mechanicFixBuyButton = guiCreateButton(9,windowHeight-40,130,30,"Buy selected",false,mechanicFixWindow)
		mechanicFixCloseButton = guiCreateButton(143,windowHeight-40,129,30,"Cancel",false,mechanicFixWindow)
		guiSetSize(mechanicFixWindow,557,windowHeight,false)
		local screenW,screenH=guiGetScreenSize()
		local windowW,windowH=guiGetSize(mechanicFixWindow,false)
		local x,y = (screenW-windowW)/2,(screenH-windowH)/2
		guiSetPosition(mechanicFixWindow,x,y,false)

		guiWindowSetSizable (mechanicFixWindow, false)

		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local team = getTeamName ( getPlayerTeam( localPlayer ) )
				if getElementData ( localPlayer, "Occupation" ) == "Mechanic" and team == "Civilian Workers" then
					initMechanicJob()
				end
			end
		end, 2500, 1 )

    end
)

function showMechanicGUI()

	if not GUIIsShowing then

		GUIIsShowing = true
		guiSetVisible(mechanicFixWindow, true)
		showCursor(true)
		addEventHandler("onClientGUIClick", mechanicFixCloseButton, onMechanicReject, false)
		addEventHandler("onClientGUIClick", mechanicFixBuyButton, onMechanicAccept, false)

	end

end

function hideMechanicGUI()

	if GUIIsShowing then

		GUIIsShowing = false
		guiSetVisible(mechanicFixWindow, false)
		showCursor(false)
		removeEventHandler("onClientGUIClick", mechanicFixCloseButton, onMechanicReject, false)
		removeEventHandler("onClientGUIClick", mechanicFixBuyButton, onMechanicAccept, false)

	end

end

function onMechanicReject ()

	hideMechanicGUI()
	if thePlayerMechanic ~= localPlayer then
		triggerServerEvent("notifyMechanic", thePlayerMechanic, getPlayerName(localPlayer).." doesn't need your services at the moment.")
	end
end

function onMechanicAccept ()
	if not isElement(theVehicle) then
		if thePlayerMechanic ~= localPlayer then
			triggerServerEvent("notifyMechanic", thePlayerMechanic, getPlayerName(localPlayer).."'s vehicle is missing, request cancelled.")
		end
		exports.NGCdxmsg:createNewDxMessage( "Your vehicle is missing!", 255, 0, 0)
		return false
	end
	local hideWindow = true
	local option = nil

	for i=1, #radioButtons do

		if guiRadioButtonGetSelected(radioButtons[i][3]) then

			option = i
			break

		end

	end
	if not option then
		hideWindow = false
		exports.NGCdxmsg:createNewDxMessage("Please select a option!", 255, 0, 0)
	end
	local price, isNeeded = getUpgradePrice(option,thePlayerMechanic == localPlayer,theVehicle,localPlayer)
	if isNeeded ~= true then
		exports.NGCdxmsg:createNewDxMessage(isNeeded, 255, 0, 0)
		hideWindow = false
	end
	local px, py, pz = getElementPosition(thePlayerMechanic)
	local vx, vy, vz = getElementPosition(theVehicle)
	local city = exports.server:getPlayChatZone(localPlayer)
	local city2 = exports.server:getPlayChatZone(thePlayerMechanic)
	local city3 = exports.server:getPlayChatZone(theVehicle)
	if getDistanceBetweenPoints2D ( px, py, vx, vy ) > 8 then
		exports.NGCdxmsg:createNewDxMessage("Your vehicle is too far away from the mechanic!", 255, 0, 0)
		isNeeded = false
	end
	if city ~= city2 then
		exports.NGCdxmsg:createNewDxMessage("You aren't in same city (The Mechanic is too far away)!", 255, 0, 0)
		isNeeded = false
	end
	if city2 ~= city3 then
		exports.NGCdxmsg:createNewDxMessage("Your vehicle is too far away from the mechanic!", 255, 0, 0)
		isNeeded = false
	end
	if option and price and isNeeded == true then
		if option == 4 then
			local t = {localPlayer,option,thePlayerMechanic,theVehicle,price}
			exports.NGCdxmsg:createNewDxMessage("Please wait until the mechanic fix the vehicle",255,255,0)
			triggerServerEvent("doVehicleLoading",thePlayerMechanic,theVehicle,t)
			local hp = getElementHealth(theVehicle)
			if hp > 900 then
				amo = 50
			elseif hp <= 900 and hp > 600 then
				amo = 75
			elseif hp <= 600 and hp > 400 then
				amo = 100
			elseif hp <= 400 and hp > 300 then
				amo = 150
			elseif hp <= 300 then
				amo = 200
			end
			if thePlayerMechanic ~= localPlayer then
				exports.CSGprogressbar:createProgressBar( getPlayerName(thePlayerMechanic).." is Fixing it...", amo, "noticePlayer",200, 0, 100 )
			end
		else
			triggerServerEvent("doVehicleRepair", localPlayer, option, thePlayerMechanic, theVehicle, price)
		end
	end
	if hideWindow then hideMechanicGUI() end
end

addEvent("repairVehicle",true)
function repairVehicle()
	local data = getElementData(localPlayer,"mechanicData")
	if data then
		vehPlayer,vehOption,vehMechanic,vehModel,vehPrice = unpack(data)
		if vehPlayer and isElement(vehPlayer) and vehModel and isElement(vehModel) and vehMechanic and isElement(vehMechanic) then
			local px,py,pz = getElementPosition(vehModel)
			local px2,py2,pz2 = getElementPosition(vehMechanic)
			if getDistanceBetweenPoints2D ( px, py, px2, py2 ) > 8 then
				exports.NGCdxmsg:createNewDxMessage("Are you kidding me ? from this distance you want to fix it!!", 255, 0, 0)
				setElementData(localPlayer,"mechanicData",false)
				triggerServerEvent("doVehicleEndEffect",localPlayer)
				if isTimer(proTimer) then killTimer(proTimer) end
				return false
			end
			if isTimer(proTimer) then killTimer(proTimer) end
			if isPedInVehicle(localPlayer) then
				if isTimer(proTimer) then killTimer(proTimer) end
				exports.CSGprogressbar:cancelProgressBar()
				setElementData(localPlayer,"mechanicData",false)
				triggerServerEvent("doVehicleEndEffect",localPlayer)
			end
			triggerServerEvent("doVehicleRepair",vehPlayer,vehOption,vehMechanic,vehModel,vehPrice)
			setElementData(localPlayer,"mechanicData",false)
			triggerServerEvent("doVehicleEndEffect",localPlayer)
		else
			setElementData(localPlayer,"mechanicData",false)
			triggerServerEvent("doVehicleEndEffect",localPlayer)
			if isTimer(proTimer) then killTimer(proTimer) end
		end
	else
		setElementData(localPlayer,"mechanicData",false)
		triggerServerEvent("doVehicleEndEffect",localPlayer)
		if isTimer(proTimer) then killTimer(proTimer) end
	end
end
addEventHandler("repairVehicle",root,repairVehicle)

addEvent("noticePlayer",true)
function noticePlayer()

end
addEventHandler("noticePlayer",root,noticePlayer)

addEvent("barAmount",true)
addEventHandler("barAmount",root,function(myveh)
	holyVehicle = myveh
	if holyVehicle and isElement(holyVehicle) then
		outputDebugString("again handle")
		local hp = getElementHealth(holyVehicle)
		if hp > 900 then
			amo = 50
		elseif hp <= 900 and hp > 600 then
			amo = 75
		elseif hp <= 600 and hp > 400 then
			amo = 100
		elseif hp <= 400 and hp > 300 then
			amo = 150
		elseif hp <= 300 then
			amo = 200
		end
		exports.CSGprogressbar:createProgressBar( "Fixing...", amo, "repairVehicle",200, 0, 100 )
		proTimer = setTimer(checkVehicle,5000,1)
	else
		exports.NGCdxmsg:createNewDxMessage("The vehicle is missing, please try again",255,0,0)
		triggerServerEvent("doVehicleEndEffect",localPlayer)
	end
end)

function checkVehicle()
	local data = getElementData(localPlayer,"mechanicData")
	if data then
		vehPlayer,vehOption,vehMechanic,vehModel,vehPrice = unpack(data)
		if vehPlayer and isElement(vehPlayer) and vehModel and isElement(vehModel) and vehMechanic and isElement(vehMechanic) then
			local px,py,pz = getElementPosition(vehModel)
			local px2,py2,pz2 = getElementPosition(vehMechanic)
			if getDistanceBetweenPoints2D ( px, py, px2, py2 ) > 8 then
				exports.NGCdxmsg:createNewDxMessage("Are you kidding me ? from this distance you want to fix it!!", 255, 0, 0)
				setElementData(localPlayer,"mechanicData",false)
				triggerServerEvent("doVehicleEndEffect",localPlayer)
				exports.CSGprogressbar:cancelProgressBar()
				if isTimer(proTimer) then killTimer(proTimer) end
				return false
			end
		else
			if isTimer(proTimer) then killTimer(proTimer) end
			exports.CSGprogressbar:cancelProgressBar()
			setElementData(localPlayer,"mechanicData",false)
			triggerServerEvent("doVehicleEndEffect",localPlayer)
		end
	end
	proTimer = setTimer(checkVehicle,5000,1)
end
		--table.insert(theTable,{localPlayer,option,thePlayerMechanic,theVehicle,price})
--		local p,o,tpm,ve,pr = unpack(theTable)
	---	triggerServerEvent("doVehicleRepair", p,o,tpm,ve,pr)

function areVehiclePanelsDamaged(vehicle)
	local numberOfPanelsDamaged = 0
	for i=0,6 do
		if getVehiclePanelState(vehicle,i) > 0 then
			numberOfPanelsDamaged = numberOfPanelsDamaged+1
		end
	end
	return numberOfPanelsDamaged
end

function onPlayerAim(player)

	--if not jobInitialized then return false end
	--local target = getPedTarget(localPlayer)
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" and getElementData ( localPlayer, "Occupation" ) == "Mechanic" then
	if getPedWeapon(localPlayer) == 0 and not isPedInVehicle(localPlayer) then -- and isElement (target) and getElementType (target) == "vehicle" then
		--local px, py, pz = getElementPosition(localPlayer)
		--local vx, vy, vz = getElementPosition(target)
		--if getDistanceBetweenPoints2D ( px, py, vx, vy ) < 3 then
		local x,y,z = getElementPosition(localPlayer)
		for k,v in ipairs(getElementsByType("vehicle")) do
			local vX,vY,vZ = getElementPosition(v)
			if (getDistanceBetweenPoints3D(x,y,z,vX,vY,vZ) <= 2) then
				local owner = getElementData(v, "vehicleOwner")
				if not owner then
					owner = getVehicleController(v)
				end
					if owner then
						local sx, sy, sz = getElementVelocity(v)
						local speed = (sx^2 + sy^2 + sz^2)^(0.5)*100
						if speed < 12 then
							if getElementData(localPlayer,"mechanicData") then
								exports.NGCdxmsg:createNewDxMessage( "You are fixing another vehicle,please wait!!.", 0, 200, 0)
								return false
							end
							triggerServerEvent("onMechanicPickVehicle", localPlayer ,owner, v)
							exports.NGCdxmsg:createNewDxMessage( "Waiting for customer's response.", 0, 200, 0)
						end
					end
				end
			end
		end
	end
end


function onMechanicShowGUI (theMechanic, vehicle)

	guiSetText(mechanicFixLabel,getPlayerName(theMechanic) .. " wants to fix your vehicle.")

	for i=1, #radioButtons do

		local price, isNeeded = getUpgradePrice(i,theMechanic == localPlayer, vehicle,localPlayer)
		if isNeeded == true then
			guiSetText(radioButtons[i][3], radioButtons[i][2].."( $"..price.." )")
			guiSetEnabled(radioButtons[i][3],true)
		else
			guiSetText(radioButtons[i][3], radioButtons[i][2].."( $"..radioButtons[i][1].." )")
			guiRadioButtonSetSelected(radioButtons[i][3],false)
			guiSetEnabled(radioButtons[i][3],false)
		end

	end

	showMechanicGUI()
	guiBringToFront( mechanicFixWindow )
	thePlayerMechanic = theMechanic
	theVehicle = vehicle

end
addEvent("onMechanicShowGUI", true)
addEventHandler("onMechanicShowGUI", getRootElement(), onMechanicShowGUI)

addEventHandler("onClientVehicleEnter",root,
	function (player)
		if player == localPlayer then
			hideMechanicGUI()
		end
	end
)

---------------------
local jobInitialized

addEvent('onPlayerJobCall', true )
function onPlayerCall()
	if jobInitialized then
		local zone = "near "..getZoneName(x,y,z)
		if getZoneName(x,y,z) == "Unknown" then
			zone = "in "..getZoneName(x,y,z,true)
		end
		exports.NGCdxmsg:createNewDxMessage(getPlayerName(source).." has requested a mechanic "..zone..".", 0, 255, 0 )
	end
end

function onElementDataChange( dataName, oldValue )
	if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Mechanic" then
		initMechanicJob()
	elseif dataName == "Occupation" then
		stopMechanicJob()
	end
end

addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false )

addEvent( "onClientPlayerTeamChange" )
function onMechanicTeamChange ( oldTeam, newTeam )
	if getElementData ( localPlayer, "Occupation" ) == "Mechanic" and source == localPlayer then
		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
				if newTeam == "Unoccupied" then
					stopMechanicJob()
				elseif getElementData ( localPlayer, "Occupation" ) == "Mechanic" and newTeam == "Civilian Workers" then
					initMechanicJob()
				end
			end
		end, 200, 1 )
	end
end

addEventHandler( "onClientPlayerTeamChange", localPlayer, onMechanicTeamChange, false )
function initMechanicJob()
	if not jobInitialized then
		jobInitialized = true
		bindKey( 'aim_weapon', 'down', onPlayerAim )
		bindKey ( "F5", "down", showMechPanel )
		addEventHandler("onPlayerJobCall", root,onPlayerCall)
	end
end

function stopMechanicJob()
	if jobInitialized then
		onRemoveAllBlips ()
		hideMechanicGUI()
		jobInitialized = false
		unbindKey( 'aim_weapon', 'down', onPlayerAim )
		unbindKey ( "F5", "down", showMechPanel )
		removeEventHandler("onPlayerJobCall", root,onPlayerCall)
		exports.CSGprogressbar:cancelProgressBar()
		setElementData(localPlayer,"mechanicData",false)
		holyVehicle = false
		if isTimer(proTimer) then killTimer(proTimer) end
		triggerServerEvent("doVehicleEndEffect",localPlayer)
	end
end

local updateBlipsTimer

function createMechPanel()
	mechPanelWindow = guiCreateWindow(409,182,441,459,"NGC ~ Mechanic Panel",false)
	mechPanelGrid = guiCreateGridList(9,23,423,249,false,mechPanelWindow)
	guiGridListSetSelectionMode(mechPanelGrid,0)

	local column1 = guiGridListAddColumn(mechPanelGrid,"Vehicle name and owner:",0.47)
	local column2 = guiGridListAddColumn(mechPanelGrid,"Health:",0.10)
	local column3 = guiGridListAddColumn(mechPanelGrid,"Location:",0.38)

	mechPanelButton1 = guiCreateButton(10,277,134,33,"Mark vehicle",false,mechPanelWindow)
	mechPanelButton2 = guiCreateButton(148,277,137,33,"Mark all vehicles",false,mechPanelWindow)
	mechPanelButton3 = guiCreateButton(290,277,141,33,"Delete blips",false,mechPanelWindow)
	mechPanelButton4 = guiCreateButton(290,320,141,33,"Ranks",false,mechPanelWindow)
	--guiSetEnabled(mechPanelButton4,false)
	mechPanelRadio1 = guiCreateRadioButton(14,320,300,22,"Show all damaged vehicles",false,mechPanelWindow)
	mechPanelRadio2 = guiCreateRadioButton(14,346,300,22,"Show only vehicles with less than 80% health",false,mechPanelWindow)
	mechPanelRadio3 = guiCreateRadioButton(14,372,300,22,"Show only vehicles with less than 60% health",false,mechPanelWindow)
	mechPanelRadio4 = guiCreateRadioButton(14,398,300,22,"Show only vehicles with less than 40% health",false,mechPanelWindow)
	mechPanelRadio5 = guiCreateRadioButton(14,424,300,22,"Show only vehicles with less than 20% health",false,mechPanelWindow)

	guiRadioButtonSetSelected(mechPanelRadio1,true)

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(mechPanelWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(mechPanelWindow,x,y,false)

	guiWindowSetSizable (mechPanelWindow, false)
end

function showMechPanel ()
	local showPanel = true
	if guiGetVisible(MechanicGUI.window) then exports.NGCdxmsg:createNewDxMessage("Please close Ranks panel first",255,0,0) return false end
	if not isElement(mechPanelWindow) then
		createMechPanel()
	else
		if guiGetVisible(mechPanelWindow) then
			showPanel = false
			guiSetVisible(mechPanelWindow, false)
		else
			guiSetVisible(mechPanelWindow,true)
		end
	end
	if showPanel then
		showCursor(true)
		loadInjuredVehicles()
		removeEventHandler("onClientGUIClick", mechPanelButton1, onMarkSelectedVehicle, false)
		removeEventHandler("onClientGUIClick", root, onUserChangedMechPanelSetting )
		removeEventHandler("onClientGUIClick", mechPanelButton2, onMarkAllVehicles, false)
		removeEventHandler("onClientGUIClick", mechPanelButton3, onRemoveAllBlipsButton, false)
		removeEventHandler("onClientGUIClick", mechPanelButton4, toggleMechanicPanel, false)
		addEventHandler("onClientGUIClick", mechPanelButton1, onMarkSelectedVehicle, false)
		addEventHandler ( "onClientGUIClick", root, onUserChangedMechPanelSetting )
		addEventHandler("onClientGUIClick", mechPanelButton2, onMarkAllVehicles, false)
		addEventHandler("onClientGUIClick", mechPanelButton3, onRemoveAllBlipsButton, false)
		addEventHandler("onClientGUIClick", mechPanelButton4, toggleMechanicPanel, false)
	else
		showCursor(false)
		removeEventHandler("onClientGUIClick", mechPanelButton1, onMarkSelectedVehicle, false)
		removeEventHandler("onClientGUIClick", root, onUserChangedMechPanelSetting )
		removeEventHandler("onClientGUIClick", mechPanelButton2, onMarkAllVehicles, false)
		removeEventHandler("onClientGUIClick", mechPanelButton3, onRemoveAllBlipsButton, false)
		removeEventHandler("onClientGUIClick", mechPanelButton4, toggleMechanicPanel, false)
	end
end

function onRemoveAllBlipsButton()

	if isTimer(updateBlipsTimer) then killTimer(updateBlipsTimer) end
	onRemoveAllBlips()

end

function onUserChangedMechPanelSetting ()
	if ( source == mechPanelRadio1 ) or ( source == mechPanelRadio2 ) or ( source == mechPanelRadio3 ) or ( source == mechPanelRadio4 ) or ( source == mechPanelRadio5 ) then
		loadInjuredVehicles()
	end
end

local doAutoUpdateBlips = false

function onMarkSelectedVehicle ()
	local theVehicle = guiGridListGetItemData(mechPanelGrid, guiGridListGetSelectedItem ( mechPanelGrid ), 1)
	if not ( isElement( theVehicle ) ) then
		exports.NGCdxmsg:createNewDxMessage("You didn't select a player!", 225 ,0 ,0)
	else
		if ( isElement( theVehicle ) ) then
			local attachedElements = getAttachedElements ( theVehicle )
			if ( attachedElements ) then
				for ElementKey, ElementValue in ipairs ( attachedElements ) do
					if ( getElementType ( ElementValue ) == "blip" ) and getBlipIcon ( ElementValue ) == 22 then
						return
					end
				end
			end
			local theBlip = createBlipAttachedTo ( theVehicle, 22 )
		end
	end
end

function onMarkAllVehicles ()
	local healthSetting = 100
	if ( guiRadioButtonGetSelected( mechPanelRadio1 ) ) then healthSetting = 100 end
	if ( guiRadioButtonGetSelected( mechPanelRadio2 ) ) then healthSetting = 80  end
	if ( guiRadioButtonGetSelected( mechPanelRadio3 ) ) then healthSetting = 60  end
	if ( guiRadioButtonGetSelected( mechPanelRadio4 ) ) then healthSetting = 40  end
	if ( guiRadioButtonGetSelected( mechPanelRadio5 ) ) then healthSetting = 20  end

	onRemoveAllBlips()

	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		if ( math.floor(getElementHealth( vehicle ) / 10 ) < math.floor(tonumber(healthSetting) )) then
			if getElementData(vehicle, "vehicleOwner") or getVehicleController(vehicle) then
				local theBlip = createBlipAttachedTo ( vehicle, 22 )
				doAutoUpdateBlips = true
				if not isTimer(updateBlipsTimer) then updateBlipsTimer = setTimer ( onMarkAllVehicles, 10000, 0) end
			end
		end
	end
end

function onRemoveAllBlips ()
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		local attachedElements = getAttachedElements ( vehicle )
		if ( attachedElements ) then
			for ElementKey, ElementValue in ipairs ( attachedElements ) do
				if ( getElementType ( ElementValue ) == "blip" ) then
					if ( getBlipIcon ( ElementValue ) == 22 ) then
						destroyElement( ElementValue )
						doAutoUpdateBlips = false
					end
				end
			end
		end
	end
end

function loadInjuredVehicles()
	local healthSetting = 100
	if ( guiRadioButtonGetSelected( mechPanelRadio1 ) ) then healthSetting = 100
	elseif ( guiRadioButtonGetSelected( mechPanelRadio2 ) ) then healthSetting = 80
	elseif ( guiRadioButtonGetSelected( mechPanelRadio3 ) ) then healthSetting = 60
	elseif ( guiRadioButtonGetSelected( mechPanelRadio4 ) ) then healthSetting = 40
	elseif ( guiRadioButtonGetSelected( mechPanelRadio5 ) ) then healthSetting = 20  end

	local vehicleFound = false

	guiGridListClear ( mechPanelGrid )
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		if ( math.floor(getElementHealth( vehicle ) / 10) < tonumber(healthSetting) ) then
			if getElementData(vehicle, "vehicleOwner") or getVehicleController(vehicle) then
 				vehicleFound = true
				local vehicleOwner = getElementData(vehicle, "vehicleOwner") or getVehicleController(vehicle)
				if vehicleOwner and isElement(vehicleOwner) and getElementType(vehicleOwner) == "player" then
					local x, y, z = getElementPosition ( vehicle )
					local row = guiGridListAddRow ( mechPanelGrid )
					guiGridListSetItemText ( mechPanelGrid, row, 1, getVehicleName ( vehicle ).." / "..getPlayerName(vehicleOwner), false, false )
					guiGridListSetItemText ( mechPanelGrid, row, 2, math.floor(getElementHealth ( vehicle )  / 10).."%", false, false )
					guiGridListSetItemText ( mechPanelGrid, row, 3, getZoneName ( x, y, z ).." ("..calculateVehicleZone( x, y, z )..")", false, false )
					guiGridListSetItemData ( mechPanelGrid, row, 1, vehicle)

					if ( math.floor(getElementHealth ( vehicle ) / 10 ) < 30 ) then
						guiGridListSetItemColor ( mechPanelGrid, row, 2, 225, 0, 0 )
					elseif ( math.floor(getElementHealth ( vehicle ) / 10 ) > 290 ) and  ( math.floor(getElementHealth ( vehicle ) / 10 ) < 70 ) then
						guiGridListSetItemColor ( mechPanelGrid, row, 2, 225, 165, 0 )
					else
						guiGridListSetItemColor ( mechPanelGrid, row, 2, 0, 225, 0 )
					end
				end
			end
		end
	end

	if not ( vehicleFound ) then
		local row = guiGridListAddRow ( mechPanelGrid )
		guiGridListSetItemText ( mechPanelGrid, row, 1, "No vehicles found", false, false )
		guiGridListSetItemText ( mechPanelGrid, row, 2, "  N/A", false, false )
		guiGridListSetItemText ( mechPanelGrid, row, 3, "  N/A", false, false )
	end
end

function calculateVehicleZone( x, y, z )
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
	end
end



---------------

-- panel

local x, y = guiGetScreenSize()

MechanicGUI.window = guiCreateWindow(( x / 2 ) - ( 450 / 2 ), ( y / 2 ) - ( 250 / 2 ), 461, 314, "Mechanic panel", false)
guiWindowSetSizable(MechanicGUI.window, false)
guiSetVisible(MechanicGUI.window, false)
MechanicGUI.close = guiCreateButton(324, 270, 127, 34, "Close", false, MechanicGUI.window)
MechanicGUI.points = guiCreateLabel(15, 32, 421, 31, "points:N.A", false, MechanicGUI.window)
guiLabelSetVerticalAlign(MechanicGUI.points,"center")
guiLabelSetHorizontalAlign(MechanicGUI.points,"left")
MechanicGUI.rank = guiCreateLabel(15, 77, 421, 31, "rank:N.A", false, MechanicGUI.window)
guiLabelSetVerticalAlign(MechanicGUI.rank,"center")
guiLabelSetHorizontalAlign(MechanicGUI.rank,"left")
MechanicGUI.nextRank = guiCreateLabel(15, 126, 421, 31, "next rank with points:N.A", false, MechanicGUI.window)
guiLabelSetVerticalAlign(MechanicGUI.nextRank,"center")
guiLabelSetHorizontalAlign(MechanicGUI.nextRank,"left")
MechanicGUI.bonus = guiCreateLabel(15, 172, 421, 31, "bonus:N.A", false, MechanicGUI.window)
guiLabelSetVerticalAlign(MechanicGUI.bonus,"center")
guiLabelSetHorizontalAlign(MechanicGUI.bonus,"left")

addEventHandler("onClientGUIClick",MechanicGUI.close,function()
guiSetVisible(MechanicGUI.window, false)
showCursor(false)
showPanel = false
end,false)

function toggleMechanicPanel()
	if getPlayerTeam(localPlayer) then
		if getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
			outputDebugString("team check mech")
			if getElementData(localPlayer,"Occupation") == "Mechanic" then
				outputDebugString("job check mech")
				guiSetVisible(mechPanelWindow, false)
				guiSetVisible(MechanicGUI.window, true)
				updateMechanicPanel()
				showCursor(true)
			end
		end
	end
end

function getBonusMultiplier(rankNumber)
	rankNumber = rankNumber -1 -- first rank has no bonus
	return 1+(math.floor(rankNumber*4)/100)
end

function updateMechanicPanel()
	local theRank,stat,rankN, nextRank, nextRankPoints = exports.csgranks:getPlayerRankInfo()
	if theRank and stat and rankN then
		guiSetText(MechanicGUI.points,"Mechanic points: "..stat..".")
		guiSetText(MechanicGUI.rank,"Mechanic rank: "..theRank..".")
		if nextRank and nextRankPoints then
			guiSetText(MechanicGUI.nextRank,"Next Mechanic rank: "..nextRank.." with "..nextRankPoints.." points earning a "..math.floor((getBonusMultiplier(rankN+1)-1)*100).."% bonus reward.")
		else
			guiSetText(MechanicGUI.nextRank,"Next Mechanic rank: maximum rank! Good job.")
		end
		guiSetText(MechanicGUI.bonus,"Current bonus: "..math.floor((getBonusMultiplier(rankN)-1)*100).."%.")
	end
end


