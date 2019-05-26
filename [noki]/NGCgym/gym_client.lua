local xr, yr = guiGetScreenSize()

local gymMarkers = {
{1954.63,2314.79,15, 0,0}, -- Gym in LV ID 1
{756.94,-47.69,999.78, 6,0}, -- Gym in SF ID 2
{2250.11,-1719.23,12, 0,0} -- Gym in LS ID 3
}

-- Creating the GUI
gymWindow = guiCreateWindow((xr / 2) - (250 / 2), (yr / 2) - (350 / 2),312,179,"AUR ~ Fighting style shop",false)
gymLabel1 = guiCreateLabel(60,27,196,18,"Welcome to the San Andreas gym!",false,gymWindow)
gymLabel2 = guiCreateLabel(55,43,227,16,"Buying new fighting style cost 1000$.",false,gymWindow)
gymRadio1 = guiCreateRadioButton(9,71,84,19,"Standard",false,gymWindow)
guiRadioButtonSetSelected(gymRadio1,true)
gymRadio2 = guiCreateRadioButton(119,71,84,19,"Boxing",false,gymWindow)
gymRadio3 = guiCreateRadioButton(220,71,83,19,"Kung Fu",false,gymWindow)
gymRadio4 = guiCreateRadioButton(9,102,84,19,"Knee Head",false,gymWindow)
gymRadio5 = guiCreateRadioButton(119,103,84,19,"Grab Kick",false,gymWindow)
gymRadio6 = guiCreateRadioButton(220,104,83,19,"Elbows",false,gymWindow)
gymButton1 = guiCreateButton(25,140,126,28,"Buy Fighting Style",false,gymWindow)
gymButton2 = guiCreateButton(161,140,126,28,"Close screen",false,gymWindow)

addEventHandler("onClientGUIClick", gymButton2, function() guiSetVisible(gymWindow, false) showCursor(false) end, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(gymWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(gymWindow,x,y,false)

guiWindowSetMovable (gymWindow, true)
guiWindowSetSizable (gymWindow, false)
guiSetVisible (gymWindow, false)

-- Show the gui when player hit the marker
function gymMarkerHit (hitElement, matchingdimension)
	local x, y, z = getElementPosition(hitElement)
	local ax, ay, az = getElementPosition(source)
	if ( z-3 < az ) and ( z+3 > az ) then
		if matchingdimension then
			if hitElement == localPlayer then
				if getElementInterior(source) == getElementInterior(hitElement) then
					guiSetVisible(gymWindow,true)
					showCursor(true,true)
				end
			end
		end
	end
end

for i=1,#gymMarkers do

local x, y, z = gymMarkers[i][1], gymMarkers[i][2], gymMarkers[i][3]
local interior, dimension = gymMarkers[i][4], gymMarkers[i][5]
local gymShopMarkers = createMarker(x,y,z,"cylinder",2,255,0,0,100)
setElementInterior(gymShopMarkers, interior)
setElementDimension(gymShopMarkers, dimension)

addEventHandler("onClientMarkerHit", gymShopMarkers, gymMarkerHit)

end

-- Check what style is selected and set style serverside
function setStyle()
	local localPlayer = getLocalPlayer ( )
	if (guiRadioButtonGetSelected(gymRadio1)) then
		style = 4
	elseif (guiRadioButtonGetSelected(gymRadio2)) then
		style = 5
	elseif (guiRadioButtonGetSelected(gymRadio3)) then
		style = 6
	elseif (guiRadioButtonGetSelected(gymRadio4)) then
		style = 7
	elseif (guiRadioButtonGetSelected(gymRadio5)) then
		style = 15
	elseif (guiRadioButtonGetSelected(gymRadio6)) then
		style = 16
	end
	guiSetVisible(gymWindow, false)
	showCursor(false)
	triggerServerEvent("buyFightingStyle", localPlayer, style)
end
addEventHandler("onClientGUIClick", gymButton1, setStyle, false)


local styles = {
{"Normal",0},
{"Fat Man",55},
{"Fat Man 2",124},
{"Old and Fat Man",123},
{"Old Man",120},
{"Cool Man ",56,true},
{"Ugly Man",63},
{"Fat Boss",64},
{"Boss",65},
{"Sneak",69},
--{"Player with Jetpack",70,true},
{"Funny Man Walk",118},
{"Shuffling Player",119},
{"Gang Walk 1",121},
{"Gang Walk 2",122},
{"Jogger",125},
{"Drunk Man",126},
{"Blind Man",127},
{"AUR Law Walk",128},
{"Woman Walk",129},
{"Girl Walk",130},
{"Busy Woman",131},
{"Sexy Woman",132},



{"MOVE_PRO",133},
{"MOVE_OLDWOMAN",134},
{"MOVE_FATWOMAN",135},
{"MOVE_JOGWOMAN",136},
{"MOVE_OLDFATWOMAN",137},
--{"MOVE_SKATE",138 },
}


local mystyle=0
window = guiCreateWindow((xr / 2) - (200 / 2), (yr / 2) - (350 / 2), 216, 350, "AUR ~ Walk Style", false)
guiWindowSetSizable(window, false)

list = guiCreateGridList(9, 26, 198, 283, false, window)
guiGridListAddColumn(list, "Style", 0.9)
btnBuy = guiCreateButton(10, 315, 90, 26, "Buy ($500)", false, window)
btnExit = guiCreateButton(116, 315, 90, 26, "Exit", false, window)
guiSetVisible(window,false)
addEventHandler("onClientGUIClick",root,function()
	if source == btnBuy then
		local row = guiGridListGetSelectedItem(list)
		if row ~= nil and row ~= false and row ~= -1 then
			if getPlayerMoney() < 500 then
				exports.NGCdxmsg:createNewDxMessage("You can't afford to change your walking style!",255,255,0)
			else
				local id = guiGridListGetItemData(list,row,1)
				if id == 128 and exports.DENlaw:isLaw(localPlayer) then
					exports.NGCdxmsg:createNewDxMessage("Only Law Enforcement can use this style!",255,255,0)
					return
				end
				--[[if id == 69 and not exports.server:isPlayerPremium( localPlayer ) then
					exports.NGCdxmsg:createNewDxMessage("This skin is reserved for premium members",255,255,0)
					return
				end]]
				--[[for k,v in pairs(styles) do
					if v[2] == id then
						if (v[3]) then
							exports.NGCdxmsg:createNewDxMessage("Note: This walking style has weapons disabled (only melee and colt pistol work)",255,255,0)
						end
						break
					end
				end]]
				triggerServerEvent("NGCwalk.buy",localPlayer,id)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("You didn't select a walking style!",255,255,0)
		end
	elseif source == btnExit then
		hide()
	end

end)


local pos = {
	{2244.39,-1719.32,13.7,int=0,dim=0},
	{1965.4,2315.66,16.45,int=0,dim=0},
}



function hit(p,di)
	local x, y, z = getElementPosition(p)
	local ax, ay, az = getElementPosition(source)
	if ( z-3 < az ) and ( z+3 > az ) then
		if di == false then return end
		if p ~= localPlayer then return end
		if getElementData(localPlayer,"inGYM") == true then return false end
		show()
	end
end

for k,v in pairs(pos) do
	local m = createMarker(v[1],v[2],v[3]-1,"cylinder",2,0,255,0,100)
	setElementDimension(m,v.dim)
	setElementInterior(m,v.int)
	addEventHandler("onClientMarkerHit",m,hit)
end

function refresh()
guiGridListClear(list)

for k,v in pairs(styles) do
	local row = guiGridListAddRow(list)
	guiGridListSetItemText(list,row,1,v[1],false,false)
	guiGridListSetItemData(list,row,1,v[2])
	if mystyle == v[2] then
		guiGridListSetItemColor(list,row,1,0,255,0)
	end
end
end
refresh()
addEvent("NGCwalk.rec",true)
addEventHandler("NGCwalk.rec",localPlayer,function(e,style)
	if e and isElement(e) then
		setPedWalkingStyle(e,style)
	end
end)

function badStyle()
	for k,v in pairs(styles) do
		if v[2] == mystyle then
			if (v[3]) then return true else return false end
		end
	end
end
--[[
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,function(prev,curr)
	if badStyle() == false then return end
	if curr ~= 0 and curr ~= 1 and curr ~= 2 then
		exports.NGCdxmsg:createNewDxMessage("This weapon is disabled in your walk style. Only melee and pistol allowed",255,0,0)
		setPedWeaponSlot(localPlayer,0)
	else
		if curr == 2 then
			if getPedWeapon(localPlayer,curr) ~= 22 then
				exports.NGCdxmsg:createNewDxMessage("This weapon is disabled in your walk style. Only melee and pistol allowed",255,0,0)
				setPedWeaponSlot(localPlayer,0)
			end
		end
	end
end)--]]

addEvent("NGCwalk.recTable",true)
addEventHandler("NGCwalk.recTable",localPlayer,function(t)
	for k,v in pairs(t) do
		setPedWalkingStyle(localPlayer,v)
	end
end)


addEvent("NGCwalk.bought",true)
addEventHandler("NGCwalk.bought",localPlayer,function(id)
	mystyle=id
	refresh()
	for k,v in pairs(styles) do
		if v[2] == id then
			setPedWalkingStyle(localPlayer,v[2])
			exports.NGCdxmsg:createNewDxMessage("Bought walking style "..v[1].." for $500",0,255,0)
			return
		end
	end
end)

function show()
	guiSetVisible(window,true)
	showCursor(true)
end

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end
addEventHandler("onClientPlayerWasted",localPlayer,hide)


function setElementSpeed(element, unit, speed) -- only work if element is moving!
    if (unit == nil) then unit = 0 end
    if (speed == nil) then speed = 0 end
    speed = tonumber(speed)
    local acSpeed = getElementSpeed(element, unit)
    if (acSpeed~=false) then -- if true - element is valid, no need to check again
        local diff = speed/acSpeed
        local x,y,z = getElementVelocity(element)
        setElementVelocity(element,x*diff,y*diff,z*diff)
        return true
    end

    return false
end

function getElementSpeed(element,unit)
    if (unit == nil) then unit = 0 end
    if (isElement(element)) then
        local x,y,z = getElementVelocity(element)
        if (unit=="mph" or unit==1 or unit =='1') then
            return (x^2 + y^2 + z^2) ^ 0.5 * 100
        else
            return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
        end
    else
        outputDebugString("Not an element. Can't get speed")
        return false
    end
end

--------


cur = 0


customMuscles = guiCreateWindow((xr / 2) - (300 / 2), (yr / 2) - (350 / 2), 351, 326, "AUR ~ Muscle Builder", false)
guiWindowSetSizable(customMuscles, false)
guiSetAlpha(customMuscles, 0.88)
muscbut_set = guiCreateButton(110, 140, 131, 30, "Start Training", false, customMuscles)
muscbut_set2 = guiCreateButton(110, 195, 131, 30, "Reset Muscle", false, customMuscles)
muscbut_remove = guiCreateButton(110, 250, 133, 29, "Close", false, customMuscles)
guiSetProperty(muscbut_set2, "NormalTextColour", "FFAAAAAA")
guiSetProperty(muscbut_set, "NormalTextColour", "FFAAAAAA")
guiSetProperty(muscbut_remove, "NormalTextColour", "FFAAAAAA")
label2 = guiCreateLabel(50, 90, 268, 46, "You must have CJ skin to start this training.\n Training Cost : 2000$", false, customMuscles)
guiSetFont(label2, "default-bold-small")
guiLabelSetColor(label2, 31, 222, 54)
guiLabelSetHorizontalAlign(label2, "center", true)

guiSetVisible(customMuscles, false)


function openmusc(player)
local x, y, z = getElementPosition(player)
	local ax, ay, az = getElementPosition(source)
	if ( z-3 < az ) and ( z+3 > az ) then
if player ~= localPlayer then return false end
	guiSetVisible(customMuscles, true)
    showCursor(true)
	setElementData(localPlayer,"inGYM",true)
	end
end

function closePanel()
if source == muscbut_remove then
    guiSetVisible(customMuscles, false)
    showCursor(false)
	setElementData(localPlayer,"inGYM",false)
end
end
addEventHandler("onClientGUIClick",root,closePanel)
function startTraining()
if source == muscbut_set then
localPlayer = getLocalPlayer()
	local model = getElementModel (localPlayer)
		if model == 0 then
			if getPlayerMoney(localPlayer) < 2000 then
				exports.NGCdxmsg:createNewDxMessage("You don't have enough money",255,0,0)
					else
					--dim = math.random(0,9999)
					--setElementDimension(localPlayer,dim)
						triggerServerEvent("takeMoneystat",localPlayer)
							guiSetVisible(customMuscles, false)
        						showCursor(false)
            						setElementPosition (localPlayer, 2235.63,-1720.2,13.79)
                						setElementRotation (localPlayer, 0, 0, 87)
	                				toggleAllControls(false,true,true)
                                        setPedAnimation(localPlayer, "GYMNASIUM", "gym_tread_geton", 2000)
                                    setTimer(setElementFrozen, 500, 1, localPlayer, true)
                                muscTimer = setTimer(setPedAnimation, 1000, 0, localPlayer, "GYMNASIUM", "gym_tread_sprint")
                            cur = 1
                        if cur == 1 then
                            timerToKill = setTimer(triggerServerEvent, 10000, 0 ,"setstat", localPlayer)
                        end
                    bindKey("space", "down", stopanimation)
					return false
                end
			else
		outputChatBox("You don't have the CJ skin.", 255, 0, 0)
        end
    end
end
addEventHandler("onClientGUIClick",root, startTraining)

addEventHandler("onClientGUIClick", root, function()
if source == muscbut_set2 then
triggerServerEvent("resetstat",localPlayer)
end
end)

function stopanimation ()
setElementFrozen(localPlayer, false)
setPedAnimation (localPlayer, false)
if isTimer( timerToKill) then
killTimer (timerToKill)
if isTimer(muscTimer) then killTimer(muscTimer) end
cur = 0
toggleAllControls(true,true,true)
setElementData(localPlayer,"inGYM",false)
setElementDimension(localPlayer,0)
end
end

for k,v in pairs(pos) do
    marker = createMarker(2238.45,-1720.16,12, "cylinder", 2, 255, 255, 0, 100)
	setElementDimension(marker,v.dim)
	setElementInterior(marker,v.int)
	addEventHandler("onClientMarkerHit",marker,openmusc)
end
