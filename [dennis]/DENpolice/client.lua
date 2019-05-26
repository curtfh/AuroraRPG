warpx,warpy,warpz = 0,0,0

local positions = {

	-- enter marker position 1,2,3

	-- leave marker position 4,5,6

	-- where you warp inside 7,8,9

	-- rotation warp in 10

	-- where you warp outside 11,12,13

	-- rotation warp out 14

	-- shop name 15

	{x=1072.26, y=-1221.36, z=16.89,xx=1053.56, yy=-1227.68, zz=-14.5,x3=1056.26,y3=-1227.91,z3=-13.68,r1=268,x4=1068.84, y4=-1221.25, z4=16.89,r2=88,name="Electronic Shop",ints=0,de=0},

	{x=1290.73, y=-1161.22, z=23.96 ,xx=1297, yy=-1192.26, zz=-59.18,x3=1297,y3=-1189,z3=-59,r1=358,x4=1290,y4=-1156,z4=24,r2=350,name="Global Shop",ints=0,de=0},

	{x=2423.98, y=-1954.92, z=13.54,xx=-31.03, yy=-91.61, zz=1003.54,x3=-31.2,y3=-89.21,z3=1003.54,r1=357,x4=2421,y4=-1956,z4=13,r2=89,name="24/7 Tiny Store",ints=18,de=500},

	{x=2481.47, y=-1494.7, z=24,xx=418.56, yy=-84.37, zz=1001.8,x3=418.62,y3=-82.38,z3=1001.8,r1=359,x4=2481.38,y4=-1496.84,z4=24,r2=179,name="Barber",ints=3,de=500},

	{x=1072.14, y=-1354.02, z=13.55,xx=1212.16, yy=-26.07, zz=1000.95,x3=1212.25,y3=-29.17,z3=1000.95,r1=179,x4=1068,y4=-1354.02,z4=13.55,r2=90,name="Big spread ranch nighclub",ints=3,de=500},

	{x=2267.8,y=-1671.3,z=15.3,xx=285.82, yy=-86.76, zz=1001.5,x3=285.8,y3=-84.5,z3=1001.5,r1=356,x4=2267,y4=-1667.9,z4=16,r2=1,name="Grove Weapons",ints=4,de=0},

	{x=1928.5, y=-1776, z=13.54,xx=-31.03, yy=-91.61, zz=1003.54,x3=-31.2,y3=-89.21,z3=1003.54,r1=357,x4=1931,y4=-1776.27,z4=13.54,r2=268,name="Fuel Station Store",ints=18,de=501},

	{x=840.7, y=-1628.19, z=13.54,xx=858, yy=-1624.3, zz=-61.1,x3=860.8,y3=-1623,z3=-61,r1=293,x4=840,y4=-1625,z4=13.5,r2=356,name="Drug house",ints=0,de=0},
	--{x=, y=, z=,xx=, yy=, zz=,x3=,y3=,z3=,r1=,x4=,y4=,z4=,r2=,name="",ints=,de=},

}

-- Police window GUI
policeComputerWindow = guiCreateWindow(318,174,778,561,"AUR ~ Law Information",false)
policeComputerLabel1 = guiCreateLabel(16,24,305,16,"List of all wanted players in San Andreas",false,policeComputerWindow)
guiLabelSetColor(policeComputerLabel1,30,144,255)
guiSetFont(policeComputerLabel1,"default-bold-small")
policeComputerGrid = guiCreateGridList(9,43,761,334,false,policeComputerWindow)
guiGridListSetSelectionMode(policeComputerGrid,0)

local column1 = guiGridListAddColumn(policeComputerGrid,"  Playername:",0.30)
local column2 = guiGridListAddColumn(policeComputerGrid,"WL:",0.05)
local column3 = guiGridListAddColumn(policeComputerGrid,"City:",0.06)
local column4 = guiGridListAddColumn(policeComputerGrid,"Location:",0.30)
local column5 = guiGridListAddColumn(policeComputerGrid,"Transport:",0.12)
local column6 = guiGridListAddColumn(policeComputerGrid,"Wantedpoints:",0.13)

policeComputerRadio1 = guiCreateRadioButton(10,386,182,21,"Show all wanted players",false,policeComputerWindow)
policeComputerRadio2 = guiCreateRadioButton(10,411,182,21,"Show only players with 1 star",false,policeComputerWindow)
policeComputerRadio3 = guiCreateRadioButton(10,435,182,21,"Show only players with 2 star",false,policeComputerWindow)
policeComputerRadio4 = guiCreateRadioButton(10,460,182,21,"Show only players with 3 star",false,policeComputerWindow)
policeComputerRadio5 = guiCreateRadioButton(10,484,182,21,"Show only players with 4 star",false,policeComputerWindow)
policeComputerRadio6 = guiCreateRadioButton(10,506,182,21,"Show only players with 5 star",false,policeComputerWindow)
policeComputerRadio7 = guiCreateRadioButton(10,529,182,21,"Show only players with 6 star",false,policeComputerWindow)
guiRadioButtonSetSelected(policeComputerRadio1,true)

policeComputerCheckBox1 = guiCreateCheckBox(732,22,34,19,"LV",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox1,true)
policeComputerCheckBox2 = guiCreateCheckBox(689,22,34,19,"SF",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox2,true)
policeComputerCheckBox3 = guiCreateCheckBox(645,22,34,19,"LS",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox3,true)

policeComputerLabel2 = guiCreateLabel(207,389,141,17,"Your Government stats:",false,policeComputerWindow)
guiLabelSetColor(policeComputerLabel2,30,144,255)
guiSetFont(policeComputerLabel2,"default-bold-small")
policeComputerLabel3 = guiCreateLabel(206,412,235,17,"Arrests:",false,policeComputerWindow)
guiSetFont(policeComputerLabel3,"default-bold-small")
policeComputerLabel4 = guiCreateLabel(206,433,240,17,"Arrest points:",false,policeComputerWindow)
guiSetFont(policeComputerLabel4,"default-bold-small")
policeComputerLabel5 = guiCreateLabel(205,457,222,17,"Tazer shots fired:",false,policeComputerWindow)
guiSetFont(policeComputerLabel5,"default-bold-small")
policeComputerLabel6 = guiCreateLabel(206,481,295,17,"Government occupation:",false,policeComputerWindow)
guiSetFont(policeComputerLabel6,"default-bold-small")
-- policeComputerLabel7 = guiCreateLabel(205,505,233,17,"Total time played as police:",false,policeComputerWindow)
-- guiSetFont(policeComputerLabel7,"default-bold-small")


policeComputerButton1 = guiCreateButton(610,472,159,22,"Requesting transport",false,policeComputerWindow)
policeComputerButton2 = guiCreateButton(610,500,159,22,"Requesting light backup",false,policeComputerWindow)
policeComputerButton3 = guiCreateButton(610,528,159,22,"Request heavy backup",false,policeComputerWindow)
policeComputerButton4 = guiCreateButton(337,528,131,22,"Toggle selected player",false,policeComputerWindow)
policeComputerButton5 = guiCreateButton(474,528,131,22,"Remove all blips",false,policeComputerWindow)
policeComputerButton6 = guiCreateButton(201,528,131,22,"Mark all players",false,policeComputerWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(policeComputerWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(policeComputerWindow,x,y,false)

guiWindowSetMovable (policeComputerWindow, true)
guiWindowSetSizable (policeComputerWindow, false)
guiSetVisible (policeComputerWindow, false)
--[[
addEventHandler("onClientGUIClick", root,
function ()
	if ( source == policeComputerCheckBox4 ) then
		exports.DENsettings:setPlayerSetting("mfRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox4 )) )
		setElementData( localPlayer, "mfRequest", guiCheckBoxGetSelected( policeComputerCheckBox4 ) )
	elseif ( source == policeComputerCheckBox5 ) then
		exports.DENsettings:setPlayerSetting("swatRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox5 )) )
		setElementData( localPlayer, "swatRequest", guiCheckBoxGetSelected( policeComputerCheckBox5 ) )
	elseif ( source == policeComputerCheckBox6 ) then
		exports.DENsettings:setPlayerSetting("GovernmentRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox6 )) )
		setElementData( localPlayer, "GovernmentRequest", guiCheckBoxGetSelected( policeComputerCheckBox6 ) )
	end
end
)
]]
local doAutoUpdateBlips = false

function showPoliceComputer ()
	local thePlayerTeam = getTeamName(getPlayerTeam(localPlayer))
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) and exports.DENlaw:isLaw(localPlayer) then
		if guiGetVisible(policeComputerWindow) then
			guiSetVisible(policeComputerWindow, false)
			showCursor(false,false)
		else
			-- exports.DENstats:forcePlayerStatsSync()
			guiSetVisible(policeComputerWindow,true)
			showCursor(true,true)
			loadWantedPlayers()
			triggerServerEvent("returnGovernmentData",localPlayer)
		end
	end
end
bindKey ( "F5", "down", showPoliceComputer )

addEvent("callBackGovernment",true)
addEventHandler("callBackGovernment",root,function(tazerassists,arrests,arrestpoints)
	guiSetText( policeComputerLabel6, "Government occupation: "..getElementData( localPlayer, "Occupation" ) )
	guiSetText( policeComputerLabel5, "Assists: "..tazerassists) --
	guiSetText( policeComputerLabel3, "Arrests: "..arrests )
	guiSetText( policeComputerLabel4, "Arrest points: "..arrestpoints )
end)

function onUserChangedMedicPanelSetting ()
	if ( source == policeComputerRadio1 ) or ( source == policeComputerRadio2 ) or ( source == policeComputerRadio3 ) or ( source == policeComputerRadio4 ) or ( source == policeComputerRadio5 ) or ( source == policeComputerRadio6 ) or ( source == policeComputerRadio7 ) then
		loadWantedPlayers()
	end

	if ( source == policeComputerCheckBox1 ) or ( source == policeComputerCheckBox2 ) or ( source == policeComputerCheckBox3 ) then
		loadWantedPlayers()
	end
end
addEventHandler ( "onClientGUIClick", root, onUserChangedMedicPanelSetting )


local blips = {}
file = {}

function loadWantedPlayers()
	local wantedSetting = 0
	if ( guiRadioButtonGetSelected( policeComputerRadio1 ) ) then wantedSetting = 0 end
	if ( guiRadioButtonGetSelected( policeComputerRadio2 ) ) then wantedSetting = 10  end
	if ( guiRadioButtonGetSelected( policeComputerRadio3 ) ) then wantedSetting = 20  end
	if ( guiRadioButtonGetSelected( policeComputerRadio4 ) ) then wantedSetting = 30  end
	if ( guiRadioButtonGetSelected( policeComputerRadio5 ) ) then wantedSetting = 40  end
	if ( guiRadioButtonGetSelected( policeComputerRadio6 ) ) then wantedSetting = 50  end
	if ( guiRadioButtonGetSelected( policeComputerRadio7 ) ) then wantedSetting = 60  end

	local playersFound = false

	guiGridListClear ( policeComputerGrid )
	for id, player in ipairs(getElementsByType("player")) do
		if not ( player == localPlayer ) then
			if ( wantedSetting == 0 ) then
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= 10 ) and not exports.DENlaw:isLaw(player) then
					if ( guiCheckBoxGetSelected( policeComputerCheckBox1 ) ) and ( exports.server:getPlayChatZone( player ) == "LV" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox2 ) ) and ( exports.server:getPlayChatZone( player ) == "SF" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox3 ) ) and ( exports.server:getPlayChatZone( player ) == "LS" ) then
						playersFound = true
						local row = guiGridListAddRow ( policeComputerGrid )
						local x, y, z = getElementPosition ( player )
						local wantedLevel = math.floor((getElementData( player, "wantedPoints" )/10))
						if ( wantedLevel ) > 6 then wantedLevel = 6 end
						if ( isPedInVehicle( player ) ) then transport = "Vehicle" else transport = "Foot" end
						local zName = getZoneName ( x, y, z )
						if getElementInterior(player) ~= 0 then
							if getElementData(player,"playerHouse") then
								local xx,yy,zz = unpack(getElementData(player,"playerHouse"))
								zName = getZoneName (xx,yy,zz)
							end
						end
						if getElementData(player,"isPlayerJailed") == true then

						else
							if getElementData(player,"isPlayerArrested") == true then zName = "Arrested" end

							if ( isPedInVehicle( player ) ) then
								transport = "Vehicle"
							else
								transport = "Foot"
							end
							guiGridListSetItemText ( policeComputerGrid, row, 1, getPlayerName ( player ), false, false )
							guiGridListSetItemText ( policeComputerGrid, row, 2, wantedLevel, false, false )
							guiGridListSetItemText ( policeComputerGrid, row, 3, "("..exports.server:getPlayChatZone( player )..")", false, false )
							guiGridListSetItemText ( policeComputerGrid, row, 4, zName, false, false )
							guiGridListSetItemText ( policeComputerGrid, row, 5, transport, false, false )
							guiGridListSetItemText ( policeComputerGrid, row, 6, math.floor((getElementData( player, "wantedPoints" ))+0.5), false, false )
							if blips[player] ~= nil and blips[player] == true then
								local r,g,b = getTeamColor(getPlayerTeam(player))
								for i=1,6 do
									guiGridListSetItemColor(policeComputerGrid,row,i,r,g,b)
								end
							end
						end
					end
				end
			else
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= wantedSetting ) then
					if ( guiCheckBoxGetSelected( policeComputerCheckBox1 ) ) and ( exports.server:getPlayChatZone( player ) == "LV" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox2 ) ) and ( exports.server:getPlayChatZone( player ) == "SF" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox3 ) ) and ( exports.server:getPlayChatZone( player ) == "LS" ) then
						playersFound = true
						local row = guiGridListAddRow ( policeComputerGrid )
						local x, y, z = getElementPosition ( player )
						if ( isPedInVehicle( player ) ) then
							transport = "Vehicle"
						else
							transport = "Foot"
						end
						local zName = getZoneName ( x, y, z )
						if getElementData(player,"isPlayerArrested") == true then
							zName = "Arrested"
						end

						guiGridListSetItemText ( policeComputerGrid, row, 1, getPlayerName ( player ), false, false )
						if wantedLevel then guiGridListSetItemText ( policeComputerGrid, row, 2, wantedLevel, false, false ) end
						guiGridListSetItemText ( policeComputerGrid, row, 3, "("..exports.server:getPlayChatZone( player )..")", false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 4, zName, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 5, transport, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 6, getElementData( player, "wantedPoints" ), false, false )
						if blips[player] ~= nil and blips[player] == true then
							local r,g,b = getTeamColor(getPlayerTeam(player))
							for i=1,6 do
								guiGridListSetItemColor(policeComputerGrid,row,i,r,g,b)
							end
						end
					end
				end
			end
		end
	end
	if not ( playersFound ) then
		local row = guiGridListAddRow ( policeComputerGrid )
		guiGridListSetItemText ( policeComputerGrid, row, 1, "No players found", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 2, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 3, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 4, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 5, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 6, "N/A", false, false )
	end
end



function onMarkAllPlayers ()
	local wantedSetting = 0
	if ( guiRadioButtonGetSelected( policeComputerRadio1 ) ) then wantedSetting = 0 end
	if ( guiRadioButtonGetSelected( policeComputerRadio2 ) ) then wantedSetting = 10  end
	if ( guiRadioButtonGetSelected( policeComputerRadio3 ) ) then wantedSetting = 20  end
	if ( guiRadioButtonGetSelected( policeComputerRadio4 ) ) then wantedSetting = 30  end
	if ( guiRadioButtonGetSelected( policeComputerRadio5 ) ) then wantedSetting = 40  end
	if ( guiRadioButtonGetSelected( policeComputerRadio6 ) ) then wantedSetting = 50  end
	if ( guiRadioButtonGetSelected( policeComputerRadio7 ) ) then wantedSetting = 60  end

	for id, player in ipairs(getElementsByType("player")) do
		if ( player ~= localPlayer ) and (blips[player] == nil or blips[player] == false) then
			--if exports.DENlaw:isLaw(player) then return false end
			if getElementData(player,"isPlayerJailed") == false then
			if ( wantedSetting == 0 ) then
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= 10 ) then
					--local theBlip = createBlipAttachedTo ( player, 41 )
					local x,y,z = getElementPosition(player)
					if getElementInterior(player) ~= 0 then
						if getElementData(player,"isPlayerInHouse") then
						if getElementData(player,"playerHouse") then
							x,y,z = unpack(getElementData(player,"playerHouse"))
						end
						end
					end
					if getElementData(player,"shopName") then
						for k,v in ipairs(positions) do
							local snam = getElementData(player,"shopName")
							if snam == v.name then
								x,y,z = v.x,v.y,v.z
							end
						end
					end
					if getElementData(player,"isPlayerArrested") then
						file[player] = "arrested.png"
					else
						file[player] = "wanted.png"
					end
					local theBlip = exports.customblips:createCustomBlip(x,y, 20, 20, file[player], 5000)
					blips[player]=theBlip
					doAutoUpdateBlips = true
					if isTimer(autoTimer) then killTimer(autoTimer) end

                autoTimer = setTimer(function()
					for k,v in pairs(blips) do
						if v then
							--destroyElement(v)
							exports.customblips:destroyCustomBlip(v)
							blips[k]=false
						end
					end
					for id, player in ipairs(getElementsByType("player")) do
					if ( player ~= localPlayer ) and (blips[player] == nil or blips[player] == false) then
			        if getElementData(player,"isPlayerJailed") == false then
					if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= 10 ) then
					--local theBlip = createBlipAttachedTo ( player, 41 )
					local x,y,z = getElementPosition(player)
					if getElementInterior(player) ~= 0 then
						if getElementData(player,"isPlayerInHouse") then
						if getElementData(player,"playerHouse") then
							x,y,z = unpack(getElementData(player,"playerHouse"))
						end
						end
					end
					if getElementData(player,"shopName") then
						for k,v in ipairs(positions) do
							local snam = getElementData(player,"shopName")
							if snam == v.name then
								x,y,z = v.x,v.y,v.z
							end
						end
					end
					if getElementData(player,"isPlayerArrested") then
						file[player] = "arrested.png"
					else
						file[player] = "wanted.png"
					end
					local theBlip = exports.customblips:createCustomBlip(x,y, 20, 20, file[player], 5000)
					blips[player]=theBlip
					loadWantedPlayers()
					doAutoUpdateBlips = true
					end
					end
					end
					end
   				end,10000,0,localPlayer)
				end
			else
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= wantedSetting ) then
					--local theBlip = createBlipAttachedTo ( player, 41 )
					local x,y,z = getElementPosition(player)
					if getElementInterior(player) ~= 0 then
						if getElementData(player,"isPlayerInHouse") then
						if getElementData(player,"playerHouse") then
							x,y,z = unpack(getElementData(player,"playerHouse"))
						end
						end
					end
					if getElementData(player,"shopName") then
						for k,v in ipairs(positions) do
							local snam = getElementData(player,"shopName")
							if snam == v.name then
								x,y,z = v.x,v.y,v.z
							end
						end
					end
					if getElementData(player,"isPlayerArrested") then
						file[player] = "arrested.png"
					else
						file[player] = "wanted.png"
					end
					local theBlip = exports.customblips:createCustomBlip(x,y, 20, 20, file[player], 5000)
					blips[player]=theBlip
					doAutoUpdateBlips = true
					if isTimer(autoTimer) then killTimer(autoTimer) end
				end
			end

			end
		end
	end
	loadWantedPlayers()
end
addEventHandler("onClientGUIClick", policeComputerButton6, onMarkAllPlayers, false)

function onRemoveAllBlips ()
	for k,v in pairs(blips) do
		if v then
			--destroyElement(v)
			exports.customblips:destroyCustomBlip(v)
			blips[k]=false
		end
	end
	loadWantedPlayers()
	doAutoUpdateBlips = false
	if isTimer(autoTimer) then killTimer(autoTimer) end
end
addEventHandler("onClientGUIClick", policeComputerButton5, onRemoveAllBlips, false)



setTimer(function()
	if doAutoUpdateBlips == true then
		if exports.DENlaw:isLaw(localPlayer) then
			for k,v in pairs(blips) do
				for index,player in ipairs(getElementsByType("player")) do
					if player == k then
						local x,y,z = getElementPosition(player)
						if blips[player] then
							if getElementDimension(player) ~= 0 or getElementInterior(player) ~= 0 then
								if getElementData(player,"interiorZone") then
									x,y,z = unpack(getElementData(player,"interiorZone"))
								end
							end
						end
						if getElementInterior(player) ~= 0 then
							if getElementData(player,"isPlayerInHouse") then
							if getElementData(player,"playerHouse") then
								x,y,z = unpack(getElementData(player,"playerHouse"))
							end
							end
						end
						if getElementData(player,"shopName") then
							for k2,v2 in ipairs(positions) do
								local snam = getElementData(player,"shopName")
								if snam == v2.name then
									x,y,z = v2.x,v2.y,v2.z
								end
							end
						end

						if getElementData(player,"isPlayerArrested") then
							if file[player] ~= "arrested.png" then
								file[player] = "arrested.png"
								exports.customblips:destroyCustomBlip(blips[player])
								blips[player]=false
								return
							end
						else
							if file[player] ~= "wanted.png" then
								file[player] = "wanted.png"
								exports.customblips:destroyCustomBlip(blips[player])
								blips[player]=false
								return
							end
						end
						exports.customblips:setCustomBlipPosition(v,x,y)
					end
				end
			end
		else
			doAutoUpdateBlips = false
			if isTimer(autoTimer) then killTimer(autoTimer) end
			for k,v in ipairs(getElementsByType("player")) do
				if blips[v] then
					exports.customblips:destroyCustomBlip(blips[v])
					blips[v]=false
				end
			end
		end
	end
end,100,0)

function onMarkSelectedPlayer ()
	local thePlayer = guiGridListGetItemText ( policeComputerGrid, guiGridListGetSelectedItem ( policeComputerGrid ), 1 )
	if thePlayer == "" or thePlayer == " " then
		exports.NGCdxmsg:createNewDxMessage("You didn't select a player!", 225 ,0 ,0)
	else
		thePlayer=getPlayerFromName(thePlayer)
		if isElement(thePlayer)==true then
			if blips[thePlayer]==nil or blips[thePlayer]==false then
				if getElementData(thePlayer,"isPlayerJailed") == true then
					exports.NGCdxmsg:createNewDxMessage("You can't mark a player that is in jail",255,255,0)
					return
				end
				--theBlip = createBlipAttachedTo ( thePlayer, 30 )
				local x,y,z = getElementPosition(thePlayer)
				if blips[thePlayer] then
					if getElementDimension(thePlayer) ~= 0 or getElementInterior(thePlayer) ~= 0 then
						if getElementData(thePlayer,"interiorZone") then
							x,y,z = unpack(getElementData(thePlayer,"interiorZone"))
						end
					end
				end
				if getElementInterior(thePlayer) ~= 0 then
					if getElementData(thePlayer,"isPlayerInHouse") then
					if getElementData(thePlayer,"playerHouse") then
						x,y,z = unpack(getElementData(thePlayer,"playerHouse"))
					end
					end
				end
				if getElementData(thePlayer,"shopName") then
					for k,v in ipairs(positions) do
						local snam = getElementData(thePlayer,"shopName")
						if snam == v.name then
							x,y,z = v.x,v.y,v.z
						end
					end
				end
				if getElementData(thePlayer,"isPlayerArrested") then
					file[thePlayer] = "arrested.png"
				else
					file[thePlayer] = "wanted.png"
				end
				local theBlip = exports.customblips:createCustomBlip(x,y, 20, 20, file[thePlayer], 5000)
				blips[thePlayer]=theBlip
				doAutoUpdateBlips = true
			else
				if blips[thePlayer] then
					--destroyElement(blips[thePlayer])
					exports.customblips:destroyCustomBlip(blips[thePlayer])
					blips[thePlayer]=false
					if not isTimer(autoTimer) then
						doAutoUpdateBlips = false
					end
				end
			end
		end
	end
	loadWantedPlayers()
end
addEventHandler("onClientGUIClick", policeComputerButton4, onMarkSelectedPlayer, false)

function onPressRequestButton ()
	local x, y, z = getElementPosition(localPlayer)
	local locationString = getZoneName ( x, y, z ).." (" .. exports.server:getPlayChatZone() .. ")"
	if ( source == policeComputerButton1 ) then
		--triggerServerEvent( "onSendRequestMessage", localPlayer, getTeamName(getPlayerTeam(localPlayer)), getPlayerName(localPlayer).." is requesting transport near "..locationString )
	elseif ( source == policeComputerButton2 ) then
		---triggerServerEvent( "onSendRequestMessage", localPlayer, getTeamName(getPlayerTeam(localPlayer)), getPlayerName(localPlayer).." is requesting backup near "..locationString )
	elseif ( source == policeComputerButton3 ) then
		---triggerServerEvent( "onSendRequestMessage", localPlayer, getTeamName(getPlayerTeam(localPlayer)), getPlayerName(localPlayer).." is requesting heavy backup near "..locationString )
	end
end
addEventHandler("onClientGUIClick", policeComputerButton1, onPressRequestButton, false)
addEventHandler("onClientGUIClick", policeComputerButton2, onPressRequestButton, false)
addEventHandler("onClientGUIClick", policeComputerButton3, onPressRequestButton, false)


addEvent( "onClientPlayerTeamChange" )
addEventHandler ( "onClientPlayerTeamChange", root,
function ()
	if ( source == localPlayer ) then
		onRemoveAllBlips ()
	end
end
)

addEvent("policeUnblip",true)
addEventHandler("policeUnblip",localPlayer,function(p)
	if blips[p] ~= nil then
		if blips[p] then
			exports.customblips:destroyCustomBlip(blips[p])
		end
	end
end)

addEventHandler("onClientPlayerQuit",localPlayer,function()
	if blips[source] then
		exports.customblips:destroyCustomBlip(blips[source])
		blips[source]=false
	end
end)
--[[
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),function()

	local settingTable = { "GovernmentRequest","mfRequest","swatRequest" }
	local checkboxTable = { policeComputerCheckBox5, policeComputerCheckBox4, policeComputerCheckBox6 }

	for i=1,#settingTable do
		exports.DENsettings:addPlayerSetting(settingTable[i], "true")
		local state = exports.DENsettings:getPlayerSetting(settingTable[i])
		setElementData( localPlayer, settingTable[i], state )
		if checkboxTable[i] then
			guiCheckBoxSetSelected( checkboxTable[i], state )
		end
	end
end)
]]


local fineSpam = {}

addCommandHandler ("payfine",
function ()
	local wantedPoints = exports.server:getPlayerWantedPoints( localPlayer )
   	local playerMoney = wantedPoints*350
	if ( fineSpam[localPlayer] ) and ( getTickCount()-fineSpam[localPlayer] < 300000 ) then

	elseif ( wantedPoints > 15 ) then
		exports.NGCdxmsg:createNewDxMessage( "You can only pay a fine with 15 or less wanted points Current ("..getElementData(localPlayer,"wantedPoints")..") WP!", 255, 0, 0 )
	elseif ( getPlayerMoney ( localPlayer ) < playerMoney ) then
		exports.NGCdxmsg:createNewDxMessage( "You don't have enough money to pay a fine!", 255, 0, 0 )
	elseif ( getElementData ( localPlayer, "isPlayerArrested" ) ) or ( getElementData ( localPlayer, "isPlayerJailed" ) ) then
		exports.NGCdxmsg:createNewDxMessage( "You can't pay a fine while arrested or jailed!", 255, 0, 0 )
	else
		triggerServerEvent ( "onPlayerPayfine", localPlayer, playerMoney )
		fineSpam[localPlayer] = getTickCount()
	end
end
)
