local theTables = {
    {1571.17, -1337.09, 17.48,"arrow",2, 120, 0}, --LS get in
    {1548.63, -1364.68, 327.21,"arrow",2, 120, 0}, --LS get out
    {1554.02, -1367.24, 327.45,"cylinder",2, 0, 178}, -- LS panel
}
local theMarkers = {}

local callBack = {}

panel = {
    button = {},
    window = {},
    staticimage = {},
    label = {}
}

addEventHandler("onClientResourceStart",resourceRoot,function()
        createPanel()
        local count = 0
        for k,v in ipairs(theTables) do
            local x,y,z,markerStyle,r,g,b = v[1],v[2],v[3],v[4],v[5],v[6],v[7]
             if x and y and z and markerStyle and r and g and b then
                    count = count+1
                    local marker = createMarker(x,y,z,markerStyle,r,g,b)
                    callBack[marker] = count
                    addEventHandler("onClientMarkerHit",marker,whenPlayerHit)
                    table.insert(theMarkers,marker)
             end
        end
end)

function whenPlayerHit(player,dims)
    if dims then
        if player == localPlayer then
            if callBack[source] == 1 then
                  if isPedInVehicle(player) then return false end 
                  triggerServerEvent ("warpIn",player)
             elseif callBack[source] == 2 then     
                  if isPedInVehicle(player) then return false end 
                  triggerServerEvent ("warpOut",player)
              elseif callBack[source] == 3 then
                  if exports.server:getPlayerWantedPoints(player) >= 35 then
                          exports.NGCdxmsg:createNewDxMessage("Your wanted points are more than or equal 35, panel disabled!",255,0,0)
                          return false
                  end
                   guiSetVisible (window, true)
                  showCursor (true, true)
            end
        end
    end
end


function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end        

function createPanel()
        window = guiCreateWindow(218, 270, 608, 270, "AuroraRPG ~ Parachute", false)
        guiWindowSetSizable(window, false)
                centerWindow (window)
                guiSetVisible(window, false)

        paraImage = guiCreateStaticImage(9, 24, 589, 72, ":AURnixpara/aurora.png", false, window)
        paraLabel = guiCreateLabel(127, 106, 606, 76, "Buy a parachute and have some fun by jumping off the roof", false, window)
        guiSetFont(paraLabel, "default-bold-small")
        guiLabelSetColor(paraLabel, 226, 123, 2)
        buyPara = guiCreateButton(48, 158, 106, 45, "Buy Parachute for 8.000$", false, window)
        buyArmor = guiCreateButton(244, 158, 106, 45, "Buy Armor for 15.000$", false, window)
        cancel = guiCreateButton(442, 158, 106, 45, "Cancel", false, window)
                copyrights = guiCreateLabel(558, 246, 155, 54, "© Nixon", false, window)
        guiSetFont(copyrights, "default-small")
        guiLabelSetHorizontalAlign(copyrights, "left", true) 
        addEventHandler("onClientGUIClick",cancel,closePanel,false)
        addEventHandler("onClientGUIClick",buyPara,onPlayerBuyPara,false)
        addEventHandler("onClientGUIClick",buyArmor,onPlayerBuyArmor,false)        
end

function closePanel()
       if source == cancel then
           guiSetVisible (window, false)
             showCursor (false)
      end       
end

function onPlayerBuyPara()
     if ( source == buyPara ) then
        if getPedWeapon(localPlayer,11) == 46 or getPedWeapon(localPlayer) == 46 then
                exports.NGCdxmsg:createNewDxMessage("You already have Parachute, you can't buy another one!",255,0,0)
                return false
            end
             local cash = getPlayerMoney (localPlayer)
             if cash < 8000 then
                     exports.NGCdxmsg:createNewDxMessage("You don't have enough money to buy parachute", 255, 0, 0)
             else
                     triggerServerEvent ("buyPara", getLocalPlayer())
             end
     end
end

function onPlayerBuyArmor()
      if ( source == buyArmor ) then
          if math.floor(getPedArmor(localPlayer)) >= 99 then 
               exports.NGCdxmsg:createNewDxMessage("You already have an armor, you can't buy another one!",255,0,0)
          return false end
            local cash = getPlayerMoney (localPlayer)
             if cash < 15000 then
                  exports.NGCdxmsg:createNewDxMessage("You don't have enough money to buy an armor", 255, 0, 0)
              else
                  triggerServerEvent ("buyArm", getLocalPlayer())
              end
      end
end