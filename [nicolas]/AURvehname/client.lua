g_Root = getRootElement()
g_thisRes = getThisResource()

changeTable = {}
changeTable[429] = "Dodge Viper"
changeTable[520] = "F-16"
changeTable[491] = "2012 Aston Martin Vanquish"
changeTable[541] = "Ferrari Italia"

function setup( theRes )
	if theRes == g_thisRes then
		setPlayerHudComponentVisible( "vehicle_name", false)
		screenWidth, screenHeight = guiGetScreenSize ( )
	end
end
addEventHandler( "onClientResourceStart", g_Root, setup )

function finishup( theRes )
	if theRes == g_thisRes then
		setPlayerHudComponentVisible( "vehicle_name", true)
	end
end
addEventHandler( "onClientResourceStop", g_Root, finishup )

function textShow()
	local posX = screenWidth/2
	local posY = screenHeight*(2/3)
	for P=-5,5 do
	    for Q=-5,5 do
		dxDrawText(theVehName, posX+P, posY+Q, posX+P, posY+Q, tocolor(00,00,00,theAlpha), 3, "pricedown", "center")
	    end
	end
	dxDrawText(theVehName, posX, posY, posX, posY, tocolor(54,104,44,theAlpha), 3, "pricedown", "center")
end

function textFade()
	theAlpha=theAlpha-10
	if theAlpha<0 then
                theAlpha=255
		removeEventHandler( "onClientRender", g_Root, textShow )
	end
end

function startTextFade()
    setTimer( textFade, 50, 26)
end

function nameToggle()
    local theVeh   = getPedOccupiedVehicle(localPlayer)
    local theVehID = getElementModel(theVeh)
    theVehName = changeTable[theVehID]
    if not theVehName then theVehName = getVehicleName(theVeh) end
    theAlpha = 255
    removeEventHandler( "onClientRender", g_Root, textShow )
    addEventHandler( "onClientRender", g_Root, textShow )
    setTimer( startTextFade, 1000, 1)
end
addCommandHandler("vehname",nameToggle)

function textStart(thePlayer)
    if thePlayer==localPlayer then
        local theVehID = getElementModel(source)
        theVehName = changeTable[theVehID]
        if not theVehName then theVehName = getVehicleName(source) end
        theAlpha = 255
        removeEventHandler( "onClientRender", g_Root, textShow )
        addEventHandler ( "onClientRender", g_Root, textShow )
        setTimer( startTextFade, 1000, 1)
    end
end
addEventHandler("onClientVehicleEnter", getRootElement(),textStart)

if (fileExists("client.lua")) then
	fileDelete("client.lua")
end