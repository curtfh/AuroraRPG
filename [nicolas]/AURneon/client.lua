local sx, sy = guiGetScreenSize()
localPlayer = getLocalPlayer()
local visible = false
local key = "F6"

local neonname = {
[1] = "Red Neon",
[2] = "Blue Neon",
[3] = "Green Neon",
[4] = "Yellow Neon",
[5] = "Pink Neon",
[6] = "White Neon",
[7] = "Reset"
}

local idModel = {
[1] = 14399,
[2] = 14400,
[3] = 14401,
[4] = 14402,
[5] = 14403,
[6] = 14404
}

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end

function openGui()
 
     window = guiCreateWindow(453, 208, 629, 357,"Neon panel",false)
	 guiWindowSetSizable(window, false)
	centerWindow (window)
     guiSetVisible(window, false)
	 

        tabpanel1 = guiCreateTabPanel(11, 23, 608, 320, false, window)

        tab1 = guiCreateTab("Neon Panel", tabpanel1)
     Btn1 = guiCreateButton(46, 137, 110, 30,neonname[1],false, tab1)
	 guiSetFont(Btn1, "clear-normal")
        guiSetProperty(Btn1, "NormalTextColour", "FFF30000")
     Btn2 = guiCreateButton(247, 137, 110, 30,neonname[2],false, tab1)
	 guiSetFont(Btn2, "clear-normal")
         guiSetProperty(Btn2, "NormalTextColour", "FF0925D4")
     Btn3 = guiCreateButton(457, 137, 110, 30,neonname[3],false, tab1)
	 guiSetFont(Btn3, "clear-normal")
        guiSetProperty(Btn3, "NormalTextColour", "FF12CA1F")
     Btn4 = guiCreateButton(46, 204, 110, 30, neonname[4],false, tab1)
	  guiSetFont(Btn4, "clear-normal")
        guiSetProperty(Btn4, "NormalTextColour", "FFF4EB0C")
     Btn5 = guiCreateButton(247, 204, 110, 30,neonname[5],false, tab1)
	 guiSetFont(Btn5, "clear-normal")
        guiSetProperty(Btn5, "NormalTextColour", "FFE60BF4")
     Btn6 = guiCreateButton(457, 204, 110, 30,neonname[6],false, tab1)
	 guiSetFont(Btn6, "clear-normal")
        guiSetProperty(Btn6, "NormalTextColour", "FFFFFFFF")
     Btn7 = guiCreateButton(537, 10, 61, 35,neonname[7],false, tab1)
     info = guiCreateLabel(44, 257, 542, 17, "Use /neon to close Neon for 4000$, Once your car disappear you need to buy it again.", false, tab1) 
     guiSetFont(info, "clear-normal")
	 image1 = guiCreateStaticImage(156, 10, 271, 99, ":AURneon/proxys.png", false, tab1)
guiSetVisible(window, visible)
end


function start_cl_resource()
	openGui()
          if ( guiGetVisible(window) == true ) then
             showCursor(true)
          end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),start_cl_resource)

function hideGui()
  if (guiGetVisible(window) == false) then 
           guiSetVisible(window, true)
           showCursor(true)
   else
           guiSetVisible(window, false)
           showCursor(false)

  end
end
addCommandHandler ( "neon", hideGui )

function onGuiClickPanel (button, state, absoluteX, absoluteY)
  if (source == Btn1) then
       setElementData( localPlayer, "neon", idModel[1] )
       outputChatBox("#ff0000Now your neon color is #ff0000Red", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	    takePlayerMoney(4000) 
  elseif (source == Btn2) then
       setElementData( localPlayer, "neon", idModel[2] )
       outputChatBox("#ff0000Now your neon color is #0000ffBlue", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	   takePlayerMoney(4000) 
  elseif (source == Btn3) then
       setElementData( localPlayer, "neon", idModel[3] )
       outputChatBox("#ff0000Now your neon color is Green", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	   takePlayerMoney(4000) 
  elseif (source == Btn4) then
       setElementData( localPlayer, "neon", idModel[4] )
       outputChatBox("#ff0000Now your neon color is #ffcc00Yellow", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	   takePlayerMoney(4000) 
  elseif (source == Btn5) then
       setElementData( localPlayer, "neon", idModel[5] )
       outputChatBox("#ff0000Now your neon color is #f754e1Pink", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	   takePlayerMoney(4000) 
  elseif (source == Btn6) then
       setElementData( localPlayer, "neon", idModel[6] )
       outputChatBox("#ff0000Now your neon color is #ffffffWhite", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
       triggerServerEvent ("attachNeon", getLocalPlayer(), theVehicle)
	   takePlayerMoney(4000) 
  elseif (source == Btn7) then
       setElementData( localPlayer, "neon", 0 )
       outputChatBox("#ff0000Your neon successfully reseted", 255,255,255, true)
       local theVehicle = getPedOccupiedVehicle ( localPlayer )
       triggerServerEvent ("detachNeon", getLocalPlayer(), theVehicle)
  end
end
addEventHandler ("onClientGUIClick", getRootElement(), onGuiClickPanel)

function replaceTXD() 
txd = engineLoadTXD ( "models/MatTextures.txd" )
engineImportTXD ( txd, idModel[1] )
engineImportTXD ( txd, idModel[2] )
engineImportTXD ( txd, idModel[3] )
engineImportTXD ( txd, idModel[4] )
engineImportTXD ( txd, idModel[5] )
engineImportTXD ( txd, idModel[6] )

col = engineLoadCOL("models/RedNeonTube1.col")
engineReplaceCOL(col, idModel[1])
col = engineLoadCOL("models/BlueNeonTube1.col")
engineReplaceCOL(col, idModel[2])
col = engineLoadCOL("models/GreenNeonTube1.col")
engineReplaceCOL(col, idModel[3])
col = engineLoadCOL("models/YellowNeonTube1.col")
engineReplaceCOL(col, idModel[4])
col = engineLoadCOL("models/PinkNeonTube1.col")
engineReplaceCOL(col, idModel[5])
col = engineLoadCOL("models/WhiteNeonTube1.col")
engineReplaceCOL(col, idModel[6])

dff = engineLoadDFF ( "models/RedNeonTube1.dff", idModel[1] )
engineReplaceModel ( dff, idModel[1] ) 
dff = engineLoadDFF ( "models/BlueNeonTube1.dff", idModel[2] )
engineReplaceModel ( dff, idModel[2] ) 
dff = engineLoadDFF ( "models/GreenNeonTube1.dff", idModel[3] )
engineReplaceModel ( dff, idModel[3] ) 
dff = engineLoadDFF ( "models/YellowNeonTube1.dff", idModel[4] )
engineReplaceModel ( dff, idModel[4] ) 
dff = engineLoadDFF ( "models/PinkNeonTube1.dff", idModel[5] )
engineReplaceModel ( dff, idModel[5] ) 
dff = engineLoadDFF ( "models/WhiteNeonTube1.dff", idModel[6] )
engineReplaceModel ( dff, idModel[6] ) 
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceTXD)