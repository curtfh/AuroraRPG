local policeDesc = "Here you can join the police service.\n\nPolice officer job is all about arresting wanted players. You can pick one of 8 various skins and 4 different types of police vehicles. When you get enough arrests you will be able to get promoted and become one of the special ranks in police job. Also good progress as a police officer can lead to joining one of the special government services. \n\nJob perk: To arrest players simply hit them with a nighstick. You can also use tazer to stun them. The player is wanted if he has numbers (1-6) behind his name.\n"
local medicDesc = "As a paramedic your job is to heal players with you spray can.\nYou can heal player by simply spray them, with the spray can, every time you heal somebody you earn money for it.\n\nParamedics get access to the Ambulance car. For a emergency accident you can use the medic chopper."
local mechDesc = "Here you can work as a mechanic.\n\nAs a mechanic your job is to repair vehicles owned by other players. You can pick 1 of 3 various skins and 1 of 4 vehicles for easier transportation. You are able to use a tow truck to tow other players vehicles if they run out of gas or bounce off the road.\n\nJob perk: To repair a vehicle press right mouse button near it's doors. Use num_2 and num_8 keys to adjust Towtruck's cable height."
local truckerDesc = "Take the job and spawn a truck. Go to light green marker to take a trailer then deliver it to assigned destination for your payments. Be a Trucker and deliver goods all over the country with a amazing salary. Can you truck?"
local pilotDesc = "Take the pilot job and then spawn a plane. You can find Cargo on your radar as Big red blips. Pick up the cargo by entering the red marker then deliver it its destination. Your main job is to deliver goods via air, but you can also provide service to Civilians for transport."
local fireDesc = "Take the job you will notice there is red blips on your map. Go to them and you will be encountered by a big fire! Extinguish the fire by using a fire extinguisher or you can use your fire truck. You will be paid for putting out the fires. People's lives depend on you!"
local trashDesc = "Trash collector\nSkins ID:16\nJob hint: Keep SF clean , keep moving in SF and collect the trash to get earnings."
local farmerDesc = "Start your job by buying seeds, go to the yellow area and tap the mouse2 button once to get the seed plant."
local fishDesc = "Work as a Fisherman to get fish and earn money!"
local tankerDesc = "Work as a fuel tank driver to refuel gas stations all around San Andreas."
local GIGNDesc = "GIGN Job."
local HolyDesc = "Roses are red, violets are blue... I have 5 fingers, MIDDLE ONE IS FOR YOU! .!."
local tankerDesc = "Work as a fuel tank driver to refuel gas stations all around San Andreas."
local lumberDesc = "As a lumberjack, your job is to travel around and cut down trees for production."
local rescDesc = "As rescuer Man, you have to rescue drown people in the sea, you will get paid for each person you save his life."
local pizzaDesc = "Work as a pizza boy and deliver pizzas. Spawn a pizza delivery scooter and fill up your scooter with pizzas. Then, deliver them to the specified locations within the time frame to receive your payment."
local minerjob = "miner job."
local postmanjob = "As a postman, you have to deliver letters to houses in order to win some money."
local fairyCaptain = "As a fairy captain, you have to deliver some goods using your boat to some stations, in order to gain some money, score and random items."
local drugsFD = "You are able to plant drugs seeds by using /plant drug name be sure that you are in farming area."
local clothesstore = "You'll work as clothes seller\nCustomers enter the store and ask for thier item and your job is to select it and sell it to them fast\nSo they don't get bored"
local MilitaryRules = "* Skin rules *\n 285 Skin is allowed for PVT+\n 286 Skin is allowed for LT+\n 287 Skin is allowed for 2LT+"
local diver = "Your work is to find lost/dropped items and bring them back here\nYou can collect 5 items to get earnings and 15 items max\ntake the job and dive in the water\nCheck blue ped blip on the radar\n\nYou need oxygen to stay alive, buy from RED marker and drop the found items in the orange marker :)"
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local theJobsTable = {
 

----------------------------------------------------------------------------------------------------------------

    -- Miner

    { "Miner", "Civilian Workers", -393.4, 2209.64, 45.05, 225, 225, 0, 0, {27}, 10, nil, minerjob, 14 },
----------------------------------------------------------------------------------------------------------------

	-- Postman

    { "Postman", "Civilian Workers", -1916.05, 720.26, 45.44, 225, 225, 0, 0, {255}, 10, nil, postmanjob, 360 },
----------------------------------------------------------------------------------------------------------------

	-- Pilot

    { "Pilot", "Civilian Workers", 1895.26, -2246.88, 13.54, 225, 225, 0, 0, {61}, 10, nil, pilotDesc, 211.89929199219 },
    { "Pilot", "Civilian Workers", 1712.99, 1615.86, 10.15, 225, 225, 0, 0, {61}, 10, nil, pilotDesc, 247.35270690918 },
    { "Pilot", "Civilian Workers", 414.1, 2536.36, 19.14, 225, 225, 0, 0, {61}, 10, nil, pilotDesc, 180.09314331055 },
    { "Pilot", "Civilian Workers", -1542.99, -437.79, 6, 225, 225, 0, 0, {61}, 10, nil, pilotDesc, 130.25314331055 },
	----------------------------------------------------------------------------------------------------------------

	-- Paramedic

    { "Paramedic", "Paramedics", 1178.61, -1319.42, 14.12, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 278.97186279297 },
    { "Paramedic", "Paramedics", 1253.16, 328.22, 19.75, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 335.29962158203 },
    { "Paramedic", "Paramedics", -2641.51, 636.4, 14.45, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 161.91076660156 },
    { "Paramedic", "Paramedics", -1510.04, 2520.85, 55.87, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 358.06912231445 },
    { "Paramedic", "Paramedics", 1634.0454101563,1826.0892333984,10.8203125, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 0.78829956054688 },
    { "Paramedic", "Paramedics", 2036.27, -1404.07, 17.26, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 146.98010253906 },
    { "Paramedic", "Paramedics", -2204.52, -2312.74, 30.61, 0, 225, 225, 41, {274, 275,70}, 10, nil, medicDesc, 271.76470947266 },
	------------------------------------------------------------------------------------------------------------------------------

	-- Mechanic

    { "Mechanic", "Civilian Workers", 1013.06, -1028.97, 32.1, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 186.24034118652 },
    { "Mechanic", "Civilian Workers", 2070.31, -1865.53, 13.54, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 272.57769775391 },
    { "Mechanic", "Civilian Workers", 708.79, -474.49, 16.33, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 182.90043640137 },
    { "Mechanic", "Civilian Workers", 1966.14, 2143.93, 10.82, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 95.299621582031 },
	{ "Mechanic", "Civilian Workers", -2030.3719482422,143.72422790527,28.8359375, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 271 },
	{ "Mechanic", "Civilian Workers", -2205.74,-2338.17,30.62, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 51 }, 	
	{ "Mechanic", "Civilian Workers", 2395.3,1017.13,10.82, 225, 225, 0, 0, {268, 305, 309}, 10, nil, mechDesc, 94 }, 	
	-----------------------------------------------------------------------------------------------------------------------------------------

	-- Trucker

    { "Trucker", "Civilian Workers", -1692.3480224609,-21.332460403442,3.5546875, 225, 225, 0, 0, {206, 202, 133, 15}, 10, nil, truckerDesc, 40 },
	-----------------------------------------------------------------------------------------------------------------------------------------------

	-- Trash Collector

    { "Trash Collector", "Civilian Workers", -1860.5714111328,-199.47506713867,18.3984375, 255, 255, 0, 0, {16}, 10, false, trashDesc, 177 },
	------------------------------------------------------------------------------------------------------------------------------------------

	-- Taxi Driver

	{ "Taxi Driver", "Civilian Workers",  -1772.4215087891,957.44512939453,24.65468788147 , 255, 255, 0, false, {185}, 10, false,"You will find peds in SF city, pick them up to get rewards\nPress 2 to start service for normal people", 180 },
	----------------------------------------------------------------------------------------------------------------

	-- Fisherman

	{ "Fisherman", "Civilian Workers", -2093.4694824219,1407.3297119141,7.1015625 , 255, 255, 0, 0, {35,37}, 10, nil, fishDesc, 285 },
	{ "Fisherman", "Civilian Workers", 995.13,-2120.55,13.09 , 255, 255, 0, 0, {35,37}, 10, nil, fishDesc, 85 }, 
	----------------------------------------------------------------------------------------------------------------------------------

	-- Drugs Farmer

    { "Drugs farmer", "Criminals", 1929.74, 172.34, 37.28,255,0,0,false,{1, 28, 143, 134, 195}, 900, nil, drugsFD, 344.27557373047 },

	---------------------------------------------------------------------------------------------------------------------------------

	-- Firefighter

    { "Firefighter", "Civilian Workers",  1112.5, -1201.1, 18.23, 255, 255, 0, 42, {277,278,279}, 10, nil, fireDesc, 181 },
	{ "Firefighter", "Civilian Workers",  -2025.3, 66.96, 28.46, 255, 255, 0, 42, {277,278,279}, 10, nil, fireDesc, 270 },
	-----------------------------------------------------------------------------------------------------------------------

	-- Rescuer

	{ "Rescuer Man", "Civilian Workers",  -2828.2255859375,1308.9007568359,7.1015625, 255, 255, 0, 0, {18,45}, 10, nil, rescDesc, 210 }, 
	------------------------------------------------------------------------------------------------------------------------------------

	-- Farmer

    { "Farmer","Civilian Workers", -1058.6, -1208.43, 129.21,255,255,0,false,{158,161},10,false, farmerDesc,267},
    { "Farmer","Civilian Workers",693.89,1982.41,5.23,255,255,0,false,{158,161}, 10, nil, farmerDesc, 273 },
	-------------------------------------------------------------------------------------------------------------

	-- Lumberjack

    { "Lumberjack", "Civilian Workers", -535.22, -177.42, 78.4,255,255,0,9,{27},10,nil, lumberDesc, 173 },
    { "Lumberjack", "Civilian Workers", 1547.36,37.16,24.14,255,255,0,9,{27},10,nil, lumberDesc, 285 }, 
	-------------------------------------------------------------------------------------------------------------

	-- Fairy Captain

	{ "Fairy Captain", "Civilian Workers",  2472.67, -2695.57, 13.63, 255, 255, 0, 42, {206,255,261}, 10, nil, fairyCaptain, 90 },
	-----------------------------------------------------------------------------------------------------------------------------

	-- Clothes Seller

	{ "Clothes Seller", "Civilian Workers",  -2243,148,35, 255, 255, 0, 0, {192,186}, 10, nil, clothesstore, 85.420288085938 },
	---------------------------------------------------------------------------------------------------------------------------

	-- Diver

	{ "Diver", "Civilian Workers", -1858.5499267578,-1563.2845458984,21.75, 255, 255, 0, 0, {49}, 10, nil, diver, 170.08569335938 },
	--------------------------------------------------------------------------------------------------------------------------------

	-- Pizza

	{ "Pizza Boy", "Civilian Workers", -1720.94,1355.48,7.18, 255, 255, 0, 0, {155}, 10, nil, pizzaDesc, 133 },
	-----------------------------------------------------------------------------------------------------------

	-- Thief
	 { "Thief", "Criminals", 2173,-1500.29,23.96,255,0,0,false,{68}, 900, nil, "I'm thief work with me so we can get some cash or items from houses", 2 },
	 { "Thief", "Criminals", 1686.64,1221.22,10.64,255,0,0,false,{68}, 900, nil, "I'm thief work with me so we can get some cash or items from houses", 267 },
	 { "Thief", "Criminals", 2124.04,2377.87,10.82,255,0,0,false,{68}, 900, nil, "I'm thief work with me so we can get some cash or items from houses", 181 },
	 { "Thief", "Criminals", -2159.22,657.58,52.37,255,0,0,false,{68}, 900, nil, "I'm thief work with me so we can get some cash or items from houses", 286 },
	 { "Thief", "Criminals", 1425.51,-1314.78,13.55,255,0,0,false,{68}, 900, nil, "I'm thief work with me so we can get some cash or items from houses", 89 },
	 { "Thief", "Criminals", 2528.14,-1664.08,15.16,255,0,0,false,{68}, 900, nil, "I'm thief work with me so we can get some cash or items from houses", 178 },
	 
	 -- Drug Trafficker
	 { "Drug Trafficker", "Criminals", 2421.1, -2452.13, 13.63, 255, 0, 0, false, {134, 138, 144}, 10, nil, "Test", 315}
	 ----------------------------------------------------------------------------------------------------------------------------------------------------------

}



for i=1,#theJobsTable do

    local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]

    if ( theJobsTable[i][2] == "Civilian Workers" ) then
		--if theJobsTable[i][1] == "Clothes Seller" then return end
	if ( theJobsTable[i]["owner"] ~= "CA") then
		local cblip = createBlip ( x, y,z, 56, 0, 0, 0, 255 )
	    	setBlipVisibleDistance(cblip, getBlipVisibleDistance(cblip) / 50)
	end

    elseif ( theJobsTable[i][1] == "Drugs farmer" ) then

      --  local dblip = createBlip ( x, y,z, 56, 0, 0, 0, 255 )
	  --  setBlipVisibleDistance(dblip, getBlipVisibleDistance(dblip) / 50)

    end

end


resetSkyGradient()
local jobMarkersTable = {}

theJobWindow = guiCreateWindow(0.39, 0.27, 0.22, 0.45, "AUR ~ Employement Office", true)
guiWindowSetSizable(theJobWindow, false)
guiSetAlpha(theJobWindow, 1.00)

theJobMemo = guiCreateMemo(0.04, 0.08, 0.93, 0.52, "", true, theJobWindow)
guiMemoSetReadOnly(theJobMemo, true)

theJobGrid = guiCreateGridList(0.04, 0.61, 0.93, 0.25, true, theJobWindow)
guiGridListAddColumn(theJobGrid, "Skin Name", 0.6)
guiGridListAddColumn(theJobGrid, "ID", 0.3)

theJobButton1 = guiCreateButton(0.04, 0.87, 0.45, 0.10, "Take Job", true, theJobWindow)
guiSetProperty(theJobButton1, "NormalTextColour", "FFAAAAAA")
theJobButton2 = guiCreateButton(0.51, 0.87, 0.45, 0.10, "Close", true, theJobWindow)    
guiSetProperty(theJobButton2, "NormalTextColour", "FFAAAAAA")

--[[
local theJobWindow = guiCreateWindow( 544,193,321,470,"AUR ~ Job",false)

local theJobGrid = guiCreateGridList( 9,288,322,133,false,theJobWindow)

local column1 = guiGridListAddColumn( theJobGrid, "  Skin Name:", 0.69 )

local column2 = guiGridListAddColumn( theJobGrid, "ID:", 0.2 )

local theJobButton1 = guiCreateButton(11,426,149,35,"Take job!",false,theJobWindow)

local theJobButton2 = guiCreateButton(163,426,149,35,"No thanks!",false,theJobWindow)

local theJobMemo = guiCreateMemo(9,44,322,217,"",false,theJobWindow)

guiMemoSetReadOnly(theJobMemo, true)

local theJobLabel1 = guiCreateLabel(14,22,257,17,"Information about this job:",false,theJobWindow)

guiSetFont(theJobLabel1,"default-bold-small")

local theJobLabel2 = guiCreateLabel(14,269,257,17,"Choose job clothes:",false,theJobWindow)

guiSetFont(theJobLabel2,"default-bold-small")

]]

local screenW,screenH=guiGetScreenSize()

local windowW,windowH=guiGetSize(theJobWindow,false)

local x,y = (screenW-windowW)/2,(screenH-windowH)/2

guiSetPosition(theJobWindow,x,y,false)



guiWindowSetMovable (theJobWindow, true)

guiWindowSetSizable (theJobWindow, false)

guiSetVisible (theJobWindow, false)



timer=false

local theHitMarker = nil


setTime(9,0)
setWeather(0)


function onClientJobMarkerHit( hitElement, matchingDimension )
	if not matchingDimension then return false end
    local px,py,pz = getElementPosition ( hitElement )

    local mx, my, mz = getElementPosition ( source )

    local markerNumber = getElementData( source, "jobMarkerNumber" )

    if ( hitElement == localPlayer ) and ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then

        if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") or ( isElementInGroup ( localPlayer, markerNumber ) ) then

            if not ( getPedOccupiedVehicle (localPlayer) ) then

                local pts = theJobsTable[markerNumber][11]

                if pts >=10 then pts=math.floor(pts/10) end

                if getPlayerWantedLevel() >= pts then

                    exports.NGCdxmsg:createNewDxMessage( "Your wantedlevel is to high to take this job!", 225, 0, 0 )

                else

                    theHitMarker = source

                    setElementData ( localPlayer, "skinBeforeEnter", getElementModel ( localPlayer ), false )

                    guiSetText ( theJobWindow, "AUR ~ Employ as a "..theJobsTable[markerNumber][1] )

                    guiSetText ( theJobMemo, theJobsTable[markerNumber][13] )
					if theJobsTable[markerNumber][1] == "Military Forces" then
						guiSetText(theJobMemo, guiGetText(theJobMemo).."\n\n"..MilitaryRules)
					end

                    loadSkinsIntoGrid( markerNumber )

                    guiSetVisible( theJobWindow, true )

                    showCursor( true )

                    setElementFrozen(localPlayer,true)

                    timer =  setTimer(function() check() end,500,0)

                end

            end

        end

    end

end



function check()

    if guiGetVisible(theJobWindow) then

        showCursor(true)

    else

        if isTimer(timer) then killTimer(timer) setElementFrozen(localPlayer,false) end

    end

end



function loadSkinsIntoGrid( markerNumber )

    local theTable = theJobsTable[markerNumber][10]

    guiGridListClear( theJobGrid )

    for k, v in ipairs ( theTable ) do

        local row = guiGridListAddRow ( theJobGrid )

        guiGridListSetItemText ( theJobGrid, row, 1, theJobsTable[markerNumber][1].." "..k, false, true )

        guiGridListSetItemText ( theJobGrid, row, 2, v, false, false )

    end

end



function isElementInGroup ( thePlayer, markerNumber )

    if ( theJobsTable[markerNumber][12] ) then

        if ( getElementData( thePlayer, "Group" ) == theJobsTable[markerNumber][12] ) then

            return true

        else

            exports.NGCdxmsg:createNewDxMessage( "You can't take this job!", 225, 0, 0 )

            return false

        end

    else

        return true

    end

end



for i=1,#theJobsTable do

    local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]

    local r, g, b = theJobsTable[i][6], theJobsTable[i][7], theJobsTable[i][8]

    jobMarkersTable[i] = createMarker( x, y, z -1, "cylinder", 2.0, r, g, b, 5)

    setElementData( jobMarkersTable[i], "jobMarkerNumber", i )

    local theSkin = theJobsTable[i][10][math.random(1,#theJobsTable[i][10])]

    local thePed = createPed ( theSkin, x, y, z )
	setElementData(thePed,"jobPed",true)
	setElementData(thePed,"jobName",theJobsTable[i][1])
	setElementData(thePed,"jobColor",{r, g, b})

    setElementFrozen ( thePed, true )

    setPedRotation ( thePed, theJobsTable[i][14] )

    setElementData( thePed, "showModelPed", true )

    addEventHandler( "onClientMarkerHit", jobMarkersTable[i], onClientJobMarkerHit )

end



function onJobSelectSkin ()

    local theSkin = guiGridListGetItemText ( theJobGrid, guiGridListGetSelectedItem ( theJobGrid ), 2, 1 )

    if ( theSkin == nil ) or ( theSkin == "" ) then

        setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ) )

    else

        setElementModel ( localPlayer, theSkin )

    end

end

addEventHandler ( "onClientGUIClick", theJobGrid, onJobSelectSkin )



function onJobWindowClose ()

    guiSetVisible( theJobWindow, false )

    showCursor( false )

    setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ), true )

end

addEventHandler("onClientGUIClick", theJobButton2, onJobWindowClose, false )

function onPlayerTakeJob ()

    if ( theHitMarker ) then

        local theSkin = guiGridListGetItemText ( theJobGrid, guiGridListGetSelectedItem ( theJobGrid ), 2, 1 )

        if ( theSkin == nil ) or ( theSkin == "" ) then

            exports.NGCdxmsg:createNewDxMessage( "Please select a skin before taking the job!", 225, 0, 0 )

        else

            guiSetVisible( theJobWindow, false ) showCursor( false )

            local markerNumber = getElementData( theHitMarker, "jobMarkerNumber" )

            local theTeam, theOccupation, theWeapon = theJobsTable[markerNumber][2], theJobsTable[markerNumber][1], theJobsTable[markerNumber][9]

            if (theJobsTable[markerNumber].inDev) then

                exports.NGCdxmsg:createNewDxMessage("This job is in development and only staff can take it",255,0,0)

                if getTeamName(getPlayerTeam(localPlayer)) ~= "Staff" then
					 setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ) )
                    return

                end

            end

            setElementModel ( localPlayer, tonumber( getElementData( localPlayer, "skinBeforeEnter" ) ) )

            triggerServerEvent( "onSetPlayerJob", localPlayer, theTeam, theOccupation, tonumber(theSkin), theWeapon,theJobsTable[markerNumber]["nrgb"] or false )

			

            if ( theTeam ~= getTeamName( getPlayerTeam( localPlayer ) ) ) then

                triggerEvent( "onClientPlayerTeamChange", localPlayer, getPlayerTeam( localPlayer ), getTeamFromName( theTeam ) )

            end

            triggerEvent( "onClientPlayerJobChange", localPlayer, theOccupation, theTeam )
			
			if (theJobsTable[markerNumber][1] == "HolyCrap") then
				setElementModel(localPlayer, tonumber(theSkin))
			end
			
        end

    end

end

addEventHandler("onClientGUIClick", theJobButton1, onPlayerTakeJob, false )


if (fileExists("client.lua")) then

	fileDelete("client.lua")

end
