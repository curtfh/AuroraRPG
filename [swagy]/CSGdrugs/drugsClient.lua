isMRT = false
local lsdhealeffecttimer
local DrugsGUI = {}
local DrugsGUIS = {}
local drugsTable
local drugNames = {}
local drugsTaken = {}
local drugsTimer = {}
local drugTime = {}
local weedTimer = {}
local madeTables = false

local theValsz
local oldDrugs = false
setTimer(function()
	local value = exports.DENsettings:getPlayerSetting("drugsystem")
	if (theValsz == value) then return false end
		theValsz = value
		if (theValsz == "Old") then 
			oldDrugs = true
		else 
			oldDrugs = false
		end 
end, 1000, 0)

resX,resY = guiGetScreenSize()
-- original: 502,275,335,276
local width,height = 335,276
local X = (resX/2) - (width/2)
local Y = (resY/2) - (height/2)
DrugsGUI[1] = guiCreateWindow(X,Y,width,height,"AuroraRPG ~ Drugs",false)
guiWindowSetMovable(DrugsGUI[1], false)
guiWindowSetSizable(DrugsGUI[1], false)
DrugsGUIS[18] = guiCreateLabel(11,28,313,19,"Drugs and narcotics:",false,DrugsGUI[1])
guiLabelSetColor(DrugsGUIS[18],238,154,0)
DrugsGUIS[3] = guiCreateCheckBox(9,52,119,25,"Ritalin (0)",false, false,DrugsGUI[1])
DrugsGUIS[4] = guiCreateCheckBox(9,78,119,25,"LSD (0)",false,false,DrugsGUI[1])
DrugsGUIS[5] = guiCreateCheckBox(9,103,119,25,"Cocaine (0)",false,false,DrugsGUI[1])
DrugsGUIS[6] = guiCreateCheckBox(9,128,119,25,"Ecstasy (0)",false,false,DrugsGUI[1])
DrugsGUIS[7] = guiCreateCheckBox(9,153,119,25,"Heroine (0)",false,false,DrugsGUI[1])
DrugsGUIS[8] = guiCreateCheckBox(9,180,119,25,"Weed (0)",false,false,DrugsGUI[1])

DrugsGUIS[23] = guiCreateRadioButton(9,52,119,25,"Ritalin (0)",false,DrugsGUI[1])
DrugsGUIS[24] = guiCreateRadioButton(9,78,119,25,"LSD (0)",false,DrugsGUI[1])
DrugsGUIS[25] = guiCreateRadioButton(9,103,119,25,"Cocaine (0)",false,DrugsGUI[1])
DrugsGUIS[26] = guiCreateRadioButton(9,128,119,25,"Ecstasy (0)",false,DrugsGUI[1])
DrugsGUIS[27] = guiCreateRadioButton(9,153,119,25,"Heroine (0)",false,DrugsGUI[1])
DrugsGUIS[28] = guiCreateRadioButton(9,180,119,25,"Weed (0)",false,DrugsGUI[1])

DrugsGUIS[11] = guiCreateButton(138, 235, 89, 31, "Stop Drugs", false, DrugsGUI[1])
DrugsGUIS[12] = guiCreateButton(233, 235, 89, 31, "Close", false, DrugsGUI[1])

guiSetFont(DrugsGUIS[11], "clear-normal")
guiSetFont(DrugsGUIS[12], "clear-normal")
guiSetProperty(DrugsGUIS[11], "NormalTextColour", "FFAAAAAA")
guiSetProperty(DrugsGUIS[12], "NormalTextColour", "FFAAAAAA")

DrugsGUI[2] = guiCreateButton(9,215,154,25,"Take a hit",false,DrugsGUI[1])
--DrugsGUI[11] = guiCreateButton(165,215,161,25,"Stop effects",false,DrugsGUI[1])
--DrugsGUI[4] = guiCreateButton(165,244,161,23,"Drop drugs",false,DrugsGUI[1])


--DrugsGUI[3] = guiCreateEdit(9,243,155,24,"",false,DrugsGUI[1])




lbl1 = guiCreateLabel(134,56,198,23,"Faster movement and weapon fire",false,DrugsGUI[1])
--lbl2 = guiCreateLabel(134,82,198,23,"Hallucinate effects everywhere",false,DrugsGUI[1])
lbl2 = guiCreateLabel(134,82,198,23,"Every 5 seconds, 3 HP added",false,DrugsGUI[1])
lbl3 = guiCreateLabel(134,109,198,23,"Ability to have the eye of eagle",false,DrugsGUI[1])
lbl4 = guiCreateLabel(134,136,198,23,"Ability to have 200 health",false,DrugsGUI[1])
lbl5 = guiCreateLabel(134,160,198,23,"Take less damage", false,DrugsGUI[1])
lbl6 = guiCreateLabel(134,186,198,23,"Less gravity, Higher Jump.",false,DrugsGUI[1])

guiLabelSetColor(lbl1,0,155,255)
guiLabelSetColor(lbl2,0,155,0)
guiLabelSetColor(lbl3,255,255,0)
guiLabelSetColor(lbl4,255,0,100)
guiLabelSetColor(lbl5,255,0,0)
guiLabelSetColor(lbl6,255,100,0)

local idToElem = {
    [1] = DrugsGUIS[3],--Ritalin
	[2] = DrugsGUIS[4],--lsd
    [3] = DrugsGUIS[5],--cocaine
    [4] = DrugsGUIS[6],--Ecstasy
    [5] = DrugsGUIS[7],--heroine
    [6] = DrugsGUIS[8],--weed
}

local idToELe2 = {
	[1] = DrugsGUIS[23],--Ritalin
	[2] = DrugsGUIS[24],--lsd
    [3] = DrugsGUIS[25],--cocaine
    [4] = DrugsGUIS[26],--Ecstasy
    [5] = DrugsGUIS[27],--heroine
    [6] = DrugsGUIS[28],--weed
}

guiSetVisible(DrugsGUI[1], false)


--[[
 guiSetProperty( DrugsGUIS[3], "HoverTextColour", "F0F8FF" )
 guiSetProperty( DrugsGUIS[5], "HoverTextColour", "00BFFF" )
 guiSetProperty( DrugsGUIS[4], "HoverTextColour", "FF1493" )
 guiSetProperty( DrugsGUIS[7], "HoverTextColour", "FFD700" )
 guiSetProperty( DrugsGUIS[8], "HoverTextColour", "228B22" )
 guiSetProperty( DrugsGUIS[6], "HoverTextColour", "DC143C" )
]]
local effectHealths = {

}

local effectVars = {

}

setTimer(function()
    for k,v in pairs(effectHealths) do
        if k ~= nil then
            if v ~= nil and effectHealths[k] ~= nil and v > 0 then
                effectHealths[k]=effectHealths[k]-1
            end
            if effectHealths[k] ~= nil and effectHealths[k] == 0 then
                effectHealths[k]=nil
                effectTake(k,effectVars[k][2])
            end
        end
    end
end,1000,0)
local showingDrugs = true

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

function dxDrawDrugName()
	if exports.server:isPlayerLoggedIn(localPlayer) then
		for i,v in ipairs(getElementsByType("pickup",resourceRoot)) do
			if v and isElement(v) and (getElementData(v, "drugName")) then
				if getElementDimension(localPlayer) == getElementDimension(v) then
					local x,y,z = getElementPosition(v)
					local x2,y2,z2 = getElementPosition(localPlayer)
					local cx,cy,cz = getCameraMatrix()
					local name = getElementData(v, "drugName")
					local am = getElementData(v, "drugHits")
					if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 25 then
						local px,py = getScreenFromWorldPosition(x,y,z+1.3,0.06)
						local px2,py2 = getScreenFromWorldPosition(x,y,z+1,0.06)
						if px then
							if z2 <= z+4 then
								local width = dxGetTextWidth(name,1,"sans")
								dxDrawBorderedText("Drug Type: "..name, px, py, px, py, tocolor(255, 0, 0, 255), 1.2, "sans", "center", "center", false, false)
								dxDrawBorderedText("Drug Amount: "..am, px2, py2, px2, py2, tocolor(255, 0, 0, 255), 1.2, "sans", "center", "center", false, false)
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, dxDrawDrugName)

--addCommandHandler("showd",function() showingDrugs=true end)
local timerCheker
addEvent("onPlayerSettingChange",true)
addEventHandler("onPlayerSettingChange",localPlayer,function(s,v)
    if s == "drugtimer" and v == false then
        showingDrugs=false
        --removeEventHandler("onClientRender",root,draw)
		killTimer(timerCheker)
    elseif s == "drugtimer" and v == true then
        showingDrugs=true
        --addEventHandler("onClientRender",root,draw)
		if (isTimer(timerCheker)) then killTimer(timerCheker) end
		timerCheker = setTimer(newDraw, 500, 0)
    end
end)

function newDraw ()
	if showingDrugs == true then
		local display = ""
		local empty = 0
		for k,v in pairs(effectHealths) do
            local id2 = tonumber(k)
            if effectHealths[k] ~= nil and effectHealths[k] > 1 then
				display = display.."  "..k..": "..v
			else
				empty = empty + 1
            end
        end
		--if (empty >= #effectHealths) then display = "" end
		exports.AURstickynote:displayText("drugdisplay", "text", display, 0, 114, 2)
	else
		exports.AURstickynote:displayText("drugdisplay", "text", "")
	end
end 
timerCheker = setTimer(newDraw, 500, 0)
sx,sy=guiGetScreenSize()

addEventHandler("onClientElementDataChange",localPlayer,function(d)
    if d == "isPlayerInHouse" then
        if getElementData(localPlayer,"isPlayerInHouse") == true then
			guiSetVisible(DrugsGUI[1], false)
			showCursor(false)
        end
    end
end)

function draw()
    if showingDrugs == true then
        local toAdd=0

        for k,v in pairs(effectHealths) do
            local id2 = tonumber(k)
            if effectHealths[k] ~= nil and effectHealths[k] > 0 then
            local vehFuelColor = math.max((effectHealths[k] * 10) - 250, 0)/750
            local vehFuelthColorMath = -510*(vehFuelColor^2)
            local rf, gf = math.max(math.min(vehFuelthColorMath + 255*vehFuelColor + 255, 255), 0), math.max(math.min(vehFuelthColorMath + 765*vehFuelColor, 180), 0)
            dxDrawRectangle((289/1268)*sx,((592+toAdd)/768)*sy, (134/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
            dxDrawRectangle((292/1268)*sx, ((595+toAdd)/768)*sy, (130*(98/1268)*sx)/100, (17/768)*sy, tocolor(rf, gf, 0, 196), false)
            dxDrawText(""..k..": "..v.."", (296/1268)*sx, ((595+toAdd)/768)*sy, (1118/1268)*sx, (690/768)*sy, tocolor(255, 255, 255, 255), 1.1, "default-bold", "left", "top", false, false, false, false, false)
            --dxDrawImage((225/1268)*sx, (679/768)*sy, (17/1920)*sx, (17/1080)*sy, "images/fuel.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
            toAdd=toAdd+23
            end
        end
    end
end
--addEventHandler("onClientRender",root,draw)

function windowToggle()
	if (source == DrugsGUIS[12]) then
		triggerServerEvent("callbackDrugsPanel",localPlayer)
		return
	end
	triggerServerEvent("callbackDrugsPanel",localPlayer)
end
bindKey("F4", "down", windowToggle)
addCommandHandler("drugs",windowToggle)
addEventHandler("onClientGUIClick", resourceRoot, windowToggle)


addEvent("onPlayerOpenDrugs",true)
addEventHandler("onPlayerOpenDrugs",root,function()
	if getElementData(localPlayer,"isPlayerTrading") then
		exports.NGCdxmsg:createNewDxMessage("Can't open drugs panel while Trading panel opened!",255,0,0)
		return
	end
	if (getElementHealth(localPlayer) > 1) then
        if guiGetVisible(DrugsGUI[1]) == true then

            guiSetVisible(DrugsGUI[1], false)
            showCursor(false)
            setElementData(localPlayer,"drugsOpen",false)
        else
            if getElementData(localPlayer,"ho") == true then
                exports.NGCdxmsg:createNewDxMessage("Can't open drugs panel while house panel is open!",255,0,0)
                return
            end
            if isCursorShowing (localPlayer) then
                 exports.NGCdxmsg:createNewDxMessage("Can't open drugs panel while there is another panel open!",255,0,0)
                return
            end
            updateLabels()
            setElementData(localPlayer,"drugsOpen",true)
            guiSetVisible(DrugsGUI[1], true)
			guiSetVisible(DrugsGUI[2], oldDrugs)
			guiSetVisible(DrugsGUIS[23], oldDrugs)
			guiSetVisible(DrugsGUIS[24], oldDrugs)
			guiSetVisible(DrugsGUIS[25], oldDrugs)
			guiSetVisible(DrugsGUIS[26], oldDrugs)
			guiSetVisible(DrugsGUIS[27], oldDrugs)
			guiSetVisible(DrugsGUIS[28], oldDrugs)
			showCursor(true)
			if (oldDrugs == true) then 
				guiSetVisible(DrugsGUIS[3], false)
				guiSetVisible(DrugsGUIS[4], false)
				guiSetVisible(DrugsGUIS[5], false)
				guiSetVisible(DrugsGUIS[6], false)
				guiSetVisible(DrugsGUIS[7], false)
				guiSetVisible(DrugsGUIS[8], false)
			else
				guiSetVisible(DrugsGUIS[3], true)
				guiSetVisible(DrugsGUIS[4], true)
				guiSetVisible(DrugsGUIS[5], true)
				guiSetVisible(DrugsGUIS[6], true)
				guiSetVisible(DrugsGUIS[7], true)
				guiSetVisible(DrugsGUIS[8], true)
			end 
        end
    end
end)





setTimer(function()
	if getElementData(localPlayer,"drugSelling") == true then
		if guiGetVisible(DrugsGUI[1]) then
			guiSetVisible(DrugsGUI[1],false)
			setElementData(localPlayer,"drugsOpen",false)
			showCursor(false)
		end
	end
	if getElementData(localPlayer,"isPlayerCrafting") == true then
		if guiGetVisible(DrugsGUI[1]) then
			guiSetVisible(DrugsGUI[1],false)
			setElementData(localPlayer,"drugsOpen",false)
			showCursor(false)
		end
	end
	if getElementData(localPlayer,"isPlayerMakingDrugs") == true then
		if guiGetVisible(DrugsGUI[1]) then
			guiSetVisible(DrugsGUI[1],false)
			setElementData(localPlayer,"drugsOpen",false)
			showCursor(false)
		end
	end
	if getElementData(localPlayer,"isPlayerInHouse") == true then
		if guiGetVisible(DrugsGUI[1]) then
			guiSetVisible(DrugsGUI[1],false)
			setElementData(localPlayer,"drugsOpen",false)
			showCursor(false)
		end
	end
end,500,0)


local commHits = {
    [1] = "ritalin",
    [2] = "lsd",
    [3] = "cocaine",
    [4] = "ecstasy",
    [5] = "heroine",
    [6] = "weed",
}

local dimensions = {
	[5001] = true, 
	[5002] = true, 
	[5004] = true,
}

local canTake = true
addCommandHandler("takehit",function(_,name,amount)
	if (oldDrugs == false) then 
		exports.NGCdxmsg:createNewDxMessage("This current feature isn't enabled. Please go to /settings to enable.",255,255,0)
		return false 
	end 
	if dimensions[getElementDimension(localPlayer)] then return false end	
	local can,msg = exports.NGCmanagement:isPlayerLagging(localPlayer)
	if not can then
		exports.NGCdxmsg:createNewDxMessage("You can't take drug hit while you're lagging",255,0,0)
		return false
	end
        if getElementData(localPlayer,"isPlayerMakingDrugs") or getElementData(localPlayer,"isPlayerCrafting") then
		exports.NGCdxmsg:createNewDxMessage("You can't take drugs while you're crafting or making drugs!!",255,255,0)
        return
	end
	if getElementData(localPlayer,"isPlayerInHouse") then
		exports.NGCdxmsg:createNewDxMessage("You can't take drugs while you're inside the house",255,255,0)
        return
	end
    if name == nil then
        exports.NGCdxmsg:createNewDxMessage("Syntax: /takehit name amount. If no amount, then 1",255,255,0)
        return
    end
    if amount == nil then
        amount=1
    end
if not (tonumber(amount) >= 1) then
        amount = 1
    end
    if type(tonumber(amount)) ~= "number" then
        amount=1
    end
    if tonumber(amount) ~= math.floor(tonumber(amount)) then

        exports.NGCdxmsg:createNewDxMessage("Drug taking amounts can only be whole numbers only! eg. 1, 2, 3 not 0.01, 0.02, etc!",255,0,0)
        return
    end
    amount=math.floor(amount)
    for k,v in pairs(commHits) do
        if v == string.lower(name) then
            if canTake == false then return end
            canTake=false
            setTimer(function() canTake=true end,800,1)

                takeDrugStart(k,amount)

            return
        end
    end
    exports.NGCdxmsg:createNewDxMessage("There is no drug named '"..name.."'",255,255,0)
end,false)

function updateLabels()
    for a,b in pairs(drugsTable) do
        local a = tostring(a)
        local a2 = tonumber(a)
        if (drugNames[a2]) then
            local elem = idToElem[a2]
            if (isElement(elem)) then
                guiSetText(elem, drugNames[a2] .. " (" .. b .. ")")
                if (drugNames[a2] == "Cocaine") then
                    --guiSetEnabled(elem, false)
                end
            end
			
			local elem2 = idToELe2[a2]
			if (isElement(elem2)) then
                guiSetText(elem2, drugNames[a2] .. " (" .. b .. ")")
                if (drugNames[a2] == "Cocaine") then
                    --guiSetEnabled(elem, false)
                end
            end
        end
    end
    if (not madeTables) then
        for a,b in pairs(drugsTable) do
            drugsTimer[a] = {}
        end
        madeTables = true
    end
end

function getDrugsTable()
    return drugsTable,drugNames
end

function updateTable(tab, tab2)
    drugsTable = tab
    drugNames = tab2
    --guiSetText(DrugsGUI[3], "")
    updateLabels()
end
addEvent("CSGdrugs.sendDrugTable", true)
addEventHandler("CSGdrugs.sendDrugTable", localPlayer, updateTable)

function getSelectedDrug()
    local drug = 0
    if (guiRadioButtonGetSelected(DrugsGUIS[23])) then
        drug = 1
	elseif (guiRadioButtonGetSelected(DrugsGUIS[24])) then
        drug = 2
    elseif (guiRadioButtonGetSelected(DrugsGUIS[25])) then
        drug = 3
    elseif (guiRadioButtonGetSelected(DrugsGUIS[26])) then
        drug = 4
    elseif (guiRadioButtonGetSelected(DrugsGUIS[27])) then
        drug = 5
    elseif (guiRadioButtonGetSelected(DrugsGUIS[28])) then
        drug = 6
    end
    local drug = drugNames[drug]
    return drug
end

function takeDrug1()
	local can,msg = exports.NGCmanagement:isPlayerLagging(localPlayer)
	if not can then
		exports.NGCdxmsg:createNewDxMessage("You can't take drug hit while you're lagging",255,0,0)
		return false
	end
    local drug = 0
    if (guiRadioButtonGetSelected(DrugsGUIS[23])) then
        drug = 1
	elseif (guiRadioButtonGetSelected(DrugsGUIS[24])) then
        drug = 2
    elseif (guiRadioButtonGetSelected(DrugsGUIS[25])) then
        drug = 3
    elseif (guiRadioButtonGetSelected(DrugsGUIS[26])) then
        drug = 4
    elseif (guiRadioButtonGetSelected(DrugsGUIS[27])) then
        drug = 5
    elseif (guiRadioButtonGetSelected(DrugsGUIS[28])) then
        drug = 6
    end
    if (drug ~= 0) then
        takeDrugStart(drug)
    end
end
addEventHandler("onClientGUIClick", DrugsGUI[2], takeDrug1, false)

function drugEffect2(start, id, id2)
    local id = tostring(id)
    local id2 = tonumber(id)
    if (start) then
        if (not drugsTaken[id]) then
            if (drugsTable[id] > 1) then
                drugsTaken[id] = 1
                effectStart(drugNames[id2], id)
            end
        else
            if (drugNames[id2] == "Cocaine") then
                return false
            else
                drugsTaken[id] = drugsTaken[id] + 1
            end
        end
    else

        if (effectHealths[drugNames[id2]] == 1) then
            if (drugNames[id2] ~= "Cocaine") then
                outputChatBox(drugNames[id2] .. " has ended", 0, 255, 0)
            end
            drugsTaken[id] = nil
        else
            effectStart(drugNames[id2], id)
        end
    end
end

function changeOnEnter(plr, seat)
	if (eventName == "onClientVehicleEnter") then
		if (plr == localPlayer) then
			--setGravity(0.008)
			customStopDrug("vehicleCancel")
		end
	elseif (eventName == "onClientVehicleExit") then
		if (plr == localPlayer) then
			--setGravity(0.008 - 0.0038)
		end
	end
end

function effectTake(drug, id, id2)
    exports.NGCdxmsg:createNewDxMessage(""..drug.." effect has ended",0,255,0)
    --drugsTaken[id] = drugsTaken[id] - 1
    if (drug == "LSD") then
        --stopLSD()
		if (isTimer(lsdhealeffecttimer)) then
			killTimer(lsdhealeffecttimer)
		end 
    end
    if (drug == "Cocaine") then
        disablePedWall()
    end
    if (drug == "Ritalin") then
        setGameSpeed(1.1)
    end
    if (drug == "Ecstasy") then
        triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, drug)
    end
    if (drug == "Heroine") then
        triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, drug)
    end
    if (drug == "Weed") then
        setGravity(0.008)
		removeEventHandler("onClientVehicleEnter", root, changeOnEnter)
		removeEventHandler("onClientVehicleExit", root, changeOnEnter)
    end
    --drugEffect(false, id, id2)
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	setGravity(0.008)
	setGameSpeed(1.1)
end)

local drugautotimers = {}

---- 8 weed , 7 herpomn. 6 ecs 5 COC 4 LSD rit 3
function customStopDrug(string)
	if (source ~= DrugsGUIS[11]) then
		return
	end
   -- if (guiRadioButtonGetSelected(DrugsGUIS[3])) then
    if (guiCheckBoxGetSelected(DrugsGUIS[3])) then
        setGameSpeed(1.1)
		effectHealths["Ritalin"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[3], false)
		if (isTimer(drugautotimers[1])) then 
			killTimer(drugautotimers[1])
		end
    end
	if (guiCheckBoxGetSelected(DrugsGUIS[4])) then
		stopLSD()
		effectHealths["LSD"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[4], false)
		if (isTimer(drugautotimers[2])) then 
			killTimer(drugautotimers[2])
		end
   end
   if (guiCheckBoxGetSelected(DrugsGUIS[6])) then
		triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, "Ecstasy")
		effectHealths["Ecstasy"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[6], false)
		if (isTimer(drugautotimers[4])) then 
			killTimer(drugautotimers[4])
		end
	end
	if (guiCheckBoxGetSelected(DrugsGUIS[7])) then
		triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, "Heroine")
		effectHealths["Heroine"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[7], false)
		if (isTimer(drugautotimers[5])) then 
			killTimer(drugautotimers[5])
		end
    end
	if (guiCheckBoxGetSelected(DrugsGUIS[5])) then
		--setGameSpeed(1.1)
		disablePedWall()
		effectHealths["Cocaine"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[5], false)
		if (isTimer(drugautotimers[3])) then 
			killTimer(drugautotimers[3])
		end
    end
	if (string == "vehicleCancel" or guiCheckBoxGetSelected(DrugsGUIS[8])) then
		setWorldSpecialPropertyEnabled("extrajump", false)
        setGravity(0.008)
        setGameSpeed(1.1)
		effectHealths["Weed"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[8], false)
		if (isTimer(drugautotimers[6])) then 
			killTimer(drugautotimers[6])
		end
		removeEventHandler("onClientVehicleEnter", root, changeOnEnter)
		removeEventHandler("onClientVehicleExit", root, changeOnEnter)
    end
end
addEventHandler("onClientGUIClick",resourceRoot,customStopDrug)

function stopAllDrugs()
	stopLSD()
	setGameSpeed(1)
	triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, "Ecstasy")
	triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, "Heroine")
	setGravity(0.008)
	disablePedWall()
	effectHealths["Ritalin"]=nil
	effectHealths["Weed"]=nil
	effectHealths["Heroine"]=nil
	effectHealths["Ecstasy"]=nil
	effectHealths["LSD"]=nil
	effectHealths["Cocaine"]=nil
	removeEventHandler("onClientVehicleEnter", root, changeOnEnter)
	removeEventHandler("onClientVehicleExit", root, changeOnEnter)
	for i=1,6 do
		if (isTimer(drugautotimers[i])) then
			killTimer(drugautotimers[i])
		end
	end
end
addEvent("CSGdrugs:stopAllDrugs", true)
addEventHandler("CSGdrugs:stopAllDrugs", root, stopAllDrugs)

function effectStart(drug, id, id2)
    --local timer = setTimer(effectTake, 120000, 1, drug, id, id2)
    local moveState = getPedMoveState( getLocalPlayer() )

    --outputDebugString("EFFECT START: " .. tostring(drug) .. " - " .. tostring(id))

    --drugsTimer[id][timer] = true
    --drugTime[id] = 60
    --setTimer(timeDown, 1000, 1, id)
    if (drug == "LSD") then
        --startLSD()
		if (isTimer(lsdhealeffecttimer)) then
			killTimer(lsdhealeffecttimer)
		end 
		lsdhealeffecttimer = setTimer(function()
			setElementHealth(localPlayer, getElementHealth(localPlayer)+3)
		end, 5000, 0)
    end
    if (drug == "Ritalin") then
        setGameSpeed(1.2)
    end
    if (drug == "Ecstasy") then
        triggerServerEvent("CSGdrugs.drugEffectStart", localPlayer, drug)
    end
    if (drug == "Heroine") then
        triggerServerEvent("CSGdrugs.drugEffectStart", localPlayer, drug)
    end
    if (drug == "Weed") then
		setGravity(0.008 - 0.0038)
		removeEventHandler("onClientVehicleEnter", root, changeOnEnter)
		removeEventHandler("onClientVehicleExit", root, changeOnEnter)
		addEventHandler("onClientVehicleEnter", root, changeOnEnter)
		addEventHandler("onClientVehicleExit", root, changeOnEnter)
    end
    if (drug == "Cocaine") then
		if isMRT == false then
			if dxGetStatus().VideoCardNumRenderTargets > 1 then
				isMRT = true
			end
			enablePedWall(isMRT)
		end
	end
end

function takeDrugStart(id,am)
    local id = tostring(id)
    local id2 = tonumber(id)
    local taken = drugsTaken[id] or 0
    local taken = tonumber(taken)
    if am == nil then am=1 end
    am=tonumber(am)
    if (drugNames[id2] == "Cocaine" and taken == 1) then
        outputChatBox("You can only take one hit of Cocaine at a time", 0, 255, 0)
        return false
    end
    if (drugsTable[id] < am) then
        exports.NGCdxmsg:createNewDxMessage("You don't have "..am.." "..drugNames[id2], 255, 255, 0)
        return false
    end
    triggerServerEvent("CSGdrugs.takeDrug", localPlayer, id,am)
end

function takeDrugFinish(id,am)
    local id = tostring(id)
    local id2 = tonumber(id)
    drugsTable[id] = drugsTable[id] - am
    updateLabels()
    if effectHealths[drugNames[id2]] == nil then effectHealths[drugNames[id2]]=0 end

    for i=1,am do
    local toAdd=48
    if effectHealths[drugNames[id2]] > 60 then
        toAdd=toAdd-14
    end
    if effectHealths[drugNames[id2]] > 120 then
        toAdd=toAdd-14
    end
    if effectHealths[drugNames[id2]] > 180 then
        toAdd=toAdd-14
    end
    effectHealths[drugNames[id2]] = effectHealths[drugNames[id2]]+(math.floor(math.random(toAdd*0.8,toAdd*1.2)))
    effectVars[drugNames[id2]] = {id,id2}
    effectStart(drugNames[id2])
    end
    --drugEffect(true, id, id2)
end
addEvent("CSGdrugs.takeDrugC", true)
addEventHandler("CSGdrugs.takeDrugC", localPlayer, takeDrugFinish)

function listTime()
    for a,b in pairs(drugTime) do
        local a = tostring(a)
        local a2 = tonumber(a)
        outputDebugString(tostring(a))
        outputDebugString(tostring(b))
        outputChatBox(drugNames[a2] .. " has " .. tonumber(b) .. " seconds remaining")
    end
end
addCommandHandler("timeleft", listTime)

triggerServerEvent("CSGdrugs.clientLoaded", localPlayer)
local badChars = {
    ["-"] = true,
    ["+"] = true,
    ["*"] = true,
    ["/"] = true,
}

function dropDrugC(amount)
    local id = getSelectedDrug()
    if (id ~= 0 and id) then
        if (string.match(amount, '^%d+$')) then
            local amount = tonumber(amount)
            if (not amount or amount == "" or amount <= 0) then return false end
            triggerServerEvent("CSGdrugs.dropDrug", localPlayer, id, amount)
        end
    end
end

function dropDrugsC()
    --local amount = guiGetText(DrugsGUI[3])
    --dropDrugC(amount)
end
--addEventHandler("onClientGUIClick", DrugsGUI[4], dropDrugsC, false)

function dropDrugCom(_, drug, amount)
    local amount = tonumber(amount)
    triggerServerEvent("CSGdrugs.dropDrug", localPlayer, drug, amount)
end
--addCommandHandler("dropdrug", dropDrugCom)

function checkForLagg()
	if exports.server:isPlayerLoggedIn(localPlayer) then
		--[[local can,msg = exports.NGCmanagement:isPlayerLagging(localPlayer)
		if can then
			return
		else
			stopAllDrugs()
			exports.NGCdxmsg:createNewDxMessage("You have high packet loss, Drugs effects ended",255,0,0)
		end]]
		if (exports.server:getPlayerFPS(localPlayer) <= 10) or (getPlayerPing(localPlayer) >= 450) then
			if (drugsTaken[5] and drugsTaken[5] > 0) then
				triggerServerEvent("CSGdrugs.drugEffectStop",localPlayer,5)
			else
				return false
			end
		end
	end
end
setTimer(checkForLagg,1000,0)

function checkboxBleepWhenClicked()
    if (source == DrugsGUIS[3]) then 
        if (guiCheckBoxGetSelected(source)) then
			if (isTimer(drugautotimers[1])) then return end
			takeDrugStart(1)
            drugautotimers[1] = setTimer(function() 
				takeDrugStart(1)
			end, 30*1000, 0)
		else
			if (isTimer(drugautotimers[1])) then 
				killTimer(drugautotimers[1])
			end
        end
	elseif (source == DrugsGUIS[4]) then 
		if (guiCheckBoxGetSelected(source)) then
			if (isTimer(drugautotimers[2])) then return end
			takeDrugStart(2)
            drugautotimers[2] = setTimer(function() 
				takeDrugStart(2)
			end, 30*1000, 0)
		else
			if (isTimer(drugautotimers[2])) then 
				killTimer(drugautotimers[2])
			end
        end
	elseif (source == DrugsGUIS[5]) then 
		if (guiCheckBoxGetSelected(source)) then
			if (isTimer(drugautotimers[3])) then return end
			takeDrugStart(3)
            drugautotimers[3] = setTimer(function() 
				takeDrugStart(3)
			end, 30*1000, 0)
		else
			if (isTimer(drugautotimers[3])) then 
				killTimer(drugautotimers[3])
			end
        end
	elseif (source == DrugsGUIS[6]) then 
		if (guiCheckBoxGetSelected(source)) then
			if (isTimer(drugautotimers[4])) then return end
			takeDrugStart(4)
            drugautotimers[4] = setTimer(function() 
				takeDrugStart(4)
			end, 30*1000, 0)
		else
			if (isTimer(drugautotimers[4])) then 
				killTimer(drugautotimers[4])
			end
        end
	elseif (source == DrugsGUIS[7]) then 
		if (guiCheckBoxGetSelected(source)) then
			if (isTimer(drugautotimers[5])) then return end
			takeDrugStart(5)
            drugautotimers[5] = setTimer(function() 
				takeDrugStart(5)
			end, 30*1000, 0)
		else
		if (isTimer(drugautotimers[5])) then 
			killTimer(drugautotimers[5])
		end
        end
	elseif (source == DrugsGUIS[8]) then 
		if (guiCheckBoxGetSelected(source)) then
			if (isTimer(drugautotimers[6])) then return end
			takeDrugStart(6)
            drugautotimers[6] = setTimer(function() 
				takeDrugStart(6)
			end, 30*1000, 0)
		else
			if (isTimer(drugautotimers[6])) then 
				killTimer(drugautotimers[6])
			end
        end
    end
end
addEventHandler("onClientGUIClick", DrugsGUIS[3], checkboxBleepWhenClicked, false)
addEventHandler("onClientGUIClick", DrugsGUIS[4], checkboxBleepWhenClicked, false)
addEventHandler("onClientGUIClick", DrugsGUIS[5], checkboxBleepWhenClicked, false)
addEventHandler("onClientGUIClick", DrugsGUIS[6], checkboxBleepWhenClicked, false)
addEventHandler("onClientGUIClick", DrugsGUIS[7], checkboxBleepWhenClicked, false)
addEventHandler("onClientGUIClick", DrugsGUIS[8], checkboxBleepWhenClicked, false)

function onEnter (plr, seat)
	if (plr ~= localPlayer) then return end
	if (isTimer(drugautotimers[6])) then 
		local timeleft = effectHealths["Weed"]
		weedTimer[plr] = timeleft
		setWorldSpecialPropertyEnabled("extrajump", false)
        setGravity(0.008)
        setGameSpeed(1.1)
		effectHealths["Weed"]=nil
		guiCheckBoxSetSelected(DrugsGUIS[8], false)
		killTimer(drugautotimers[6])
		customStopDrug("vehicleCancel")
		if (timeleft <= 46) then
			drugsToGive = 1
		else
			drugsToGive = math.floor(timeleft/46)
		end
		triggerServerEvent("CSGdrugs:giveDrug", resourceRoot, localPlayer, "Weed", drugsToGive)
		exports.NGCdxmsg:createNewDxMessage("You have been given "..drugsToGive.." as a refund for stopping Weed effect.",255,255,0)
	end
end
addEventHandler("onClientVehicleEnter", root, onEnter)

function onExit(plr, seat)
	if (plr ~= localPlayer) then return end
	if (weedTimer[plr]) then
		takeDrugStart(6)
		weedTimer[plr] = nil
		guiCheckBoxSetSelected(DrugsGUIS[8], true)
		effectTake("Weed")
        drugautotimers[6] = setTimer(function() 
			takeDrugStart(6)
		end, 30*1000, 0)
	end
end
addEventHandler("onClientVehicleExit", root, onExit)
