
local screenW,screenH=guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()
local sx,sy = screenW/3,screenH/3

local sX, sY = guiGetScreenSize()
local nX, nY = 1920, 1080

houseid = nil
ready = false
marker = {}
set = false
theData = {}
isRobbed = ""
creating = false
isThisMarker = nil
theTime = "60 seconds"
robbery = 0
local SPEED = 350 		-- How fast the marker animates
local AMPLITUDE = 0.5	-- How high the marker goes
steal = {}
barlevel = 0
noise = 0
robbedItems = 0
houseid = nil
canirob = false


dealerpanel = {
    button = {},
    window = {},
    edit = {},
    label = {}
}
--addEventHandler("onClientResourceStart",resourceRoot,function()

	dealerpanel.window[1] = guiCreateWindow(304, 157, 209, 266, "Aurora ~ Thief Dealer Shop", false)
	guiWindowSetSizable(dealerpanel.window[1], false)
	guiSetAlpha(dealerpanel.window[1], 0.88)
	guiSetVisible(dealerpanel.window[1],false)
	dealerpanel.label[1] = guiCreateLabel(10, 15, 191, 98, "Exchange your points with drugs or money here\nPoints exchanges : each points $2000 cash and 10 hits of drugs types", false, dealerpanel.window[1])
	guiSetFont(dealerpanel.label[1], "default-bold-small")
	guiLabelSetColor(dealerpanel.label[1], 255, 57, 57)
	guiLabelSetHorizontalAlign(dealerpanel.label[1], "center", true)
	guiLabelSetVerticalAlign(dealerpanel.label[1], "center")
	dealerpanel.edit[1] = guiCreateEdit(9, 178, 89, 37, "1", false, dealerpanel.window[1])
	dealerpanel.button[1] = guiCreateButton(105, 182, 96, 33, "Exchange", false, dealerpanel.window[1])
	dealerpanel.button[2] = guiCreateButton(9, 222, 192, 34, "Close", false, dealerpanel.window[1])
	dealerpanel.label[2] = guiCreateLabel(9, 127, 190, 45, "Thief Dealer Shop", false, dealerpanel.window[1])
	guiSetFont(dealerpanel.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(dealerpanel.label[2], "center", false)
	guiLabelSetVerticalAlign(dealerpanel.label[2], "center")
	dealerpanel.label[3] = guiCreateLabel(9, 90, 190, 35, "Amount", false, dealerpanel.window[1])
	guiSetFont(dealerpanel.label[3], "default-bold-small")
	guiLabelSetHorizontalAlign(dealerpanel.label[3], "center", false)
	guiLabelSetVerticalAlign(dealerpanel.label[3], "center")


	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(dealerpanel.window[1],false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(dealerpanel.window[1],x,y,false)

--end)

addEventHandler("onClientGUIClick",root,function()
	if source == dealerpanel.button[2] then
		guiSetVisible(dealerpanel.window[1],false)
		showCursor(false)
	elseif source == dealerpanel.button[1] then
		local can,mssg = exports.NGCmanagement:isPlayerLagging()
		if can then
			local moneyamount = guiGetText(dealerpanel.edit[1])
			local drugamount = guiGetText(dealerpanel.edit[1])
			local money = tonumber(moneyamount) * 2000
			local drug = tonumber(drugamount) * 10
			local points = tonumber(drugamount)
			if money and drug then
				if money > 0 and drug > 0 then
					if getElementData(localPlayer,"Occupation") == "Thief" then
						triggerServerEvent("exchangeDealerPoints",localPlayer,points,money,drug)
					end
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(mssg,255,0,0)
		end
	end
end)




function removeLetters(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
	local txts = guiGetText(element)
	if ( txts ~= "" and tonumber( txts ) ) then
		guiSetText( dealerpanel.label[2], "Drugs: "..(tonumber(txts)*10).." Hits\nMoney : $"..exports.server:convertNumber(tonumber( txts ) * 200 ))
	end
	if  string.len( tostring( guiGetText(element) ) ) > 4 then
		guiSetText(element, 1)
		guiSetText( dealerpanel.label[2],"Drugs: 10 Hits\nMoney : $"..exports.server:convertNumber(200))
	end
end
addEventHandler( "onClientGUIChanged", dealerpanel.edit[1], removeLetters )


addEvent("callThiefPoint",true)
addEventHandler("callThiefPoint",root,function(gg)
	guiSetText(dealerpanel.label[3],"Your exchange points:"..gg)
end)




pedsTable = {
	{1686.72,1229.27,10.63,269}, --- LV hos
	{1631.55,1826.3,10.6,358}, --- LV hos
	{-314.9,1051.37,20.34,357}, --- - Hospital nearest MF base
	{-2678.53,634.56,14.45,177}, --- - SF hospital
	{-2194.78,-2299.76,30.62,225}, --- - SF angle pine hospital the one nearest to the mountain
	{1181.14,-1312.56,13.56,263}, --- - LS hospital
	{2018.37,-1411.13,16.99,181}, --- - LS Jeferrson hospital
	{1264.13,324.05,19.75,333}, --- - LV/LS hospital
	{-1519.56,2520.9,55.87,358}, --- - SF QueBrados hospital

}

function dealerMarker(hitElement,matchingDimension)
	if hitElement == localPlayer then
		if matchingDimension then
			if not isPedInVehicle(localPlayer) then
				local px,py,pz = getElementPosition ( localPlayer )
				local mx, my, mz = getElementPosition ( source )
				if ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
					if getElementData(localPlayer,"Occupation") == "Thief" then
						if getElementData(localPlayer,"drugsOpen") then
							forceHide()
							msg("Please close Drugs panel")
						end
						if getElementData(localPlayer,"isPlayerTrading") then
							forceHide()
							msg("Please close Dealer exchange system")
						end
						triggerServerEvent("queryThiefPoint",localPlayer)
						guiSetText(dealerpanel.label[2],"Thief Dealer Shop")
						guiSetVisible(dealerpanel.window[1],true)
						showCursor(true)
					end
				end
			end
		end
	end
end
function dealerMarkerExit(hitElement,matchingDimension)
	if hitElement == localPlayer then
		if matchingDimension then
			guiSetVisible(dealerpanel.window[1],false)
			showCursor(false)
		end
	end
end


function noiseSetup()
	for k,v in ipairs(pedsTable) do
		local thePed = createPed(68,v[1],v[2],v[3])
		local shopmarker = createMarker(v[1],v[2],v[3],"cylinder",2,230,65,65,100)
		addEventHandler("onClientMarkerHit",shopmarker,dealerMarker)
		addEventHandler("onClientMarkerLeave",shopmarker,dealerMarkerExit)
		setPedRotation(thePed,v[4])
		setElementFrozen(thePed,true)
		setElementData(thePed,"jobPed",true)
		setElementData(thePed,"jobName","Thief Dealer")
		setElementData(thePed,"jobColor",{230, 65, 65})
		setElementData(thePed, "showModelPed", true )
	end

	watchedTasks = { TASK_SIMPLE_TIRED=true, TASK_SIMPLE_IN_AIR=true, TASK_SIMPLE_PLAYER_ON_FIRE=true, TASK_SIMPLE_JUMP=true, TASK_SIMPLE_JETPACK=true, TASK_SIMPLE_HIT_FRONT=true, TASK_SIMPLE_HIT_HEAD=true, TASK_SIMPLE_HIT_LEFT=true, TASK_SIMPLE_HIT_RIGHT=true, TASK_SIMPLE_HIT_WALL=true, TASK_SIMPLE_HIT_BACK=true, TASK_SIMPLE_HIT_BEHIND=true, TASK_SIMPLE_HIT_BY_GUN_BACK=true, TASK_SIMPLE_HIT_BY_GUN_FRONT=true, TASK_SIMPLE_HIT_BY_GUN_LEFT=true, TASK_SIMPLE_HIT_BY_GUN_RIGHT=true, TASK_SIMPLE_FALL=true, TASK_SIMPLE_FIGHT=true, TASK_SIMPLE_FIGHT_CTRL=true, TASK_SIMPLE_EVASIVE_DIVE=true, TASK_SIMPLE_EVASIVE_STEP=true, TASK_SIMPLE_DROWN=true, TASK_SIMPLE_DROWN_IN_CAR=true, TASK_SIMPLE_DRIVEBY_SHOOT=true, TASK_SIMPLE_DIE=true, TASK_SIMPLE_DIE_IN_CAR=true, TASK_SIMPLE_DETONATE=true, TASK_SIMPLE_CLIMB=true, TASK_SIMPLE_CHOKING=true, TASK_SIMPLE_CAR_SLOW_BE_DRAGGED_OUT=true, TASK_SIMPLE_CAR_SLOW_DRAG_PED_OUT=true, TASK_SIMPLE_CAR_QUICK_BE_DRAGGED_OUT=true, TASK_SIMPLE_CAR_QUICK_DRAG_PED_OUT=true, TASK_SIMPLE_CAR_GET_IN=true, TASK_SIMPLE_CAR_GET_OUT=true, TASK_SIMPLE_CAR_JUMP_OUT=true, TASK_SIMPLE_CAR_DRIVE=true, TASK_SIMPLE_BIKE_JACKED=true, TASK_SIMPLE_BE_DAMAGED=true, TASK_SIMPLE_BE_HIT=true, TASK_SIMPLE_BE_HIT_WHILE_MOVING=true, TASK_SIMPLE_GOGGLES_OFF=true, TASK_SIMPLE_GOGGLES_ON=true }
	controls = { "fire", "next_weapon", "previous_weapon", "jump", "forwards","backwards","left","right","sprint","enter_exit","vehicle_fire","vehicle_secondary_fire","steer_forwards","steer_back","accelerate","brake_reverse","horn","handbrake","special_control_left","special_control_right","special_control_down","special_control_up" }
	for k,v in pairs(controls) do
		bindKey (v, "both", noisecheck )
	end
	fadesoundout = setTimer ( reducenoise, 1000, 0 )
	casualcheck = setTimer ( noisecheck, 50, 0 )
	bindKey ("forwards", "down", walksoundstart )
	bindKey ("backwards", "down", walksoundstart )
	bindKey ("left", "down", walksoundstart )
	bindKey ("right", "down", walksoundstart )
	bindKey ("forwards", "up", walksoundstop )
	bindKey ("backwards", "up", walksoundstop )
	bindKey ("left", "up", walksoundstop )
	bindKey ("right", "up", walksoundstop )
end

addEventHandler("onClientPlayerWasted",root,function()
	if source == localPlayer then
		if houseid and houseid	~= nil then
			if getElementDimension(localPlayer) == houseid then
				triggerEvent("removeTheftMarker",localPlayer)
			end
		end
	end
end)

function noisecheck ( source, key, keystate )
	if getElementData(localPlayer,"Occupation") == "Thief" then
		if getElementInterior(localPlayer) ~= 0 then
			if houseid ~= nil then
				if getElementDimension(localPlayer) == houseid then
					thisplayer = getLocalPlayer ()
					thetask = getPedSimplestTask ( thisplayer )
					if watchedTasks[thetask] then
						if noise >= 100 then --THIS CAPS THE MAX SOUND LEVEL AT 10
							noise = 100
							robbedItems = 0
							triggerEvent("removeTheftMarker",localPlayer)
							return false
						end
						noise = noise+1
					end
				end
			end
		end
	end
end

--THIS IS THE TIMER TO BRING THE noise BACK DOWN AND UPDATE THE PLAYERS NOISELEVEL
function reducenoise ( thisplayer )
	if getElementData(localPlayer,"Occupation") == "Thief" then
		if getElementInterior(localPlayer) ~= 0 then
			if houseid ~= nil then
				if getElementDimension(localPlayer) == houseid then
					thisplayer = getLocalPlayer ()
					if noise >= 100 then --THIS CAPS THE MAX SOUND LEVEL AT 10
						noise = 100
						return false
					end
					if noise > 0 then
						noise = noise-1
					end
				end
			end
		end
	end
end



function movementcheck ( source, key, keystate )
	if getElementData(localPlayer,"Occupation") == "Thief" then
		if getElementInterior(localPlayer) ~= 0 then
			if houseid ~= nil then
				if getElementDimension(localPlayer) == houseid then
					if ( isPedDucked ( getLocalPlayer () ) ) == false then
						if ( getControlState ( "sprint" ) ) then
							if noise >= 100 then --THIS CAPS THE MAX SOUND LEVEL AT 10
								noise = 100
								robbedItems = 0
								triggerEvent("removeTheftMarker",localPlayer)
								return false
							end
							noise = noise +1
						end
						if ( getControlState ( "walk" ) ) == false then
							if noise >= 100 then --THIS CAPS THE MAX SOUND LEVEL AT 10
								noise = 100
								robbedItems = 0
								triggerEvent("removeTheftMarker",localPlayer)
								return false
							end
							noise = noise +1
						end
					end
				end
			end
		end
	end
end

function walksoundstart (source, key, keystate)
	if getElementData(localPlayer,"Occupation") == "Thief" then
		if getElementInterior(localPlayer) ~= 0 then
			if houseid ~= nil then
				if getElementDimension(localPlayer) == houseid then
					if isplayermoving ~= 1 then
						movementsound = setTimer ( movementcheck, 50, 0 )
						isplayermoving = 1
					end
				end
			end
		end
	end
end

function walksoundstop ( source, key, keystate )
	if getElementData(localPlayer,"Occupation") == "Thief" then
		if getElementInterior(localPlayer) ~= 0 then
			if houseid ~= nil then
				if getElementDimension(localPlayer) == houseid then
					if isplayermoving == 1 then
						if ( getControlState ( "forwards" ) ) == false and ( getControlState ( "backwards" ) ) == false and ( getControlState ( "left" ) ) == false and ( getControlState ( "right" ) ) == false then
							killTimer ( movementsound )
							isplayermoving = 0
						end
					end
				end
			end
		end
	end
end
noiseSetup()
anti = {}
bindKey("h","down",function()
	if getLocalPlayer() then
		if getElementData(localPlayer,"Occupation") ~= "Thief" then return end
		if getElementDimension(localPlayer) == 0 then
			if ready==false then return end
			if set == false then return end

			if isPedInVehicle(localPlayer) then
				return false
			end
			if tempData then
				local d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12 = unpack(tempData)
				triggerEvent("closeAllHousing",localPlayer)
				triggerServerEvent("AURhousingThief.houseMiscPrev", localPlayer, d1)
			end
		else
			if houseid ~= nil then
				if getElementDimension(localPlayer) == houseid then
					if isTimer(anti) then return false end
					anti = setTimer(function() end,3000,1)
					if not isElement(isThisMarker) then return false end
					local distance = getDistanceBetweenElements(isThisMarker,localPlayer)
					if distance <= 1 then
						if canirob == false then return false end
						if steal[isThisMarker] == false or steal[isThisMarker] == nil then
							steal[isThisMarker] = 0
						end
						steal[isThisMarker] = steal[isThisMarker] + 10
						if steal[isThisMarker] >= 100 then
							canirob = false
							steal[isThisMarker] = 0
							for k,v in ipairs(houseObjects[localPlayer]) do
								if v == isThisMarker then
									table.remove(houseObjects[localPlayer],k)
									destroyElement(isThisMarker)
								end
							end
							triggerServerEvent("setThiefPoint",localPlayer)
							robbedItems = #houseObjects[localPlayer]
							if robbedItems <= 0 then
								triggerEvent("removeTheftMarker",localPlayer)
								exports.NGCdxmsg:createNewDxMessage("You have successfully robbed this house",0,255,0)
								exports.NGCdxmsg:createNewDxMessage("Exchange the points for drugs or money",0,255,0)
								exports.NGCdxmsg:createNewDxMessage("Exchange the points from Hospital Thief Dealer",0,255,0)
								triggerServerEvent("setThiefRobCount",localPlayer)
							end
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onClientPickupHit", root,
	function ( thePlayer, matchingDimension )
	if ( getElementModel( source ) == 1272 ) or ( getElementModel( source ) == 1273 ) then
		if ( matchingDimension ) and ( thePlayer == localPlayer ) then
			if getElementData(source,"houseid") then
				if getElementType(thePlayer) == "player" then
					if getElementData(thePlayer,"Occupation") ~= "Thief" then return false end
					if isPedInVehicle(thePlayer) then
						return false
					end
					if isCursorShowing() then
						exports.NGCdxmsg("Please close any panel before you use this system",255,0,0)
						return false
					else
						local ac = exports.server:getPlayerAccountName(thePlayer)
						local can,domsg = exports.NGCmanagement:isPlayerLagging()
						if can then
							local dat1 = getElementData(source, "houseid")
							local dat2 = getElementData(source, "ownerid")
							local dat3 = getElementData(source, "ownername")
							local dat4 = getElementData(source, "interiorid")
							local dat5 = getElementData(source, "housesale")
							local dat6 = getElementData(source, "houseprice")
							local dat7 = getElementData(source, "housename")
							local dat8 = getElementData(source, "houselocked")
							local dat9 = getElementData(source, "boughtprice")
							local dat10 = getElementData(source, "passwordlocked")
							local dat11 = getElementData(source, "housepassword")
							local dat12 = getElementData(source, "originalPrice")
							local dat13 = getElementData(source, "lastSeen")
							marker = source
							set = true
							robbery = 0
							noise = 0
							steal = {}
							isThisMarker = {}
							barlevel = 0
							robbedItems = 0
							creating = false
							triggerEvent("AURhousingThief.handlePanel", thePlayer, dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12,dat13,source)
							triggerServerEvent("getTheftTime", thePlayer, dat1)
						else
							exports.NGCdxmsg:createNewDxMessage(domsg,255,0,0)
						end
					end
				end
			end
		else
			return false
		end
	end
end)


addEventHandler("onClientPickupLeave", root,function ( thePlayer, matchingDimension )
	if ( getElementModel( source ) == 1272 ) or ( getElementModel( source ) == 1273 ) then
		if ( matchingDimension ) and ( thePlayer == localPlayer ) then
			local ac = exports.server:getPlayerAccountName(thePlayer)
			theData = {}
			set = false
			isRobbed = ""
			marker = {}
			isThisMarker = {}
			houseid = nil
			noise = 0
			triggerEvent("closeAllHousing",localPlayer)
			ready = false
			removeEventHandler("onClientRender",root,draw)
		else
			return false
		end
	end
end)

addEvent("setHouseThiefTimeLabel",true)
addEventHandler("setHouseThiefTimeLabel",root,function(t)
	theTime = t
	robbery = 1
end)

function draw()
	if ready==false then return false end
	if set == false then return false end
	if getElementData(localPlayer,"Occupation") ~= "Thief" then return false end
	if marker and isElement(marker) then
		local x, y, z = getElementPosition(marker)
		local x2, y2, z2 = getElementPosition(localPlayer)
		z = z+0.5
		local sx, sy = getScreenFromWorldPosition(x, y, z)
		if(sx) and (sy) then
			local distance = getDistanceBetweenElements(marker,localPlayer)
			if(distance <= 10) then
				local fontbig = 1.5-(distance/10)
				if robbery == 0 then
					dxDrawBorderedText("This House is available to rob",1, sx, sy, sx, sy, tocolor(255, 255, 255, 200), fontbig, "default-bold", "center")
				else
					dxDrawBorderedText(theTime.." until house robbery get ready",1, sx, sy, sx, sy, tocolor(255, 0, 0, 200), fontbig, "default-bold", "center")
				end
			end
		end
	end
	dxDrawBorderedText("Press H to rob this house.", 1.75, (screenW - 504) / 2, (screenH - 210) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,0,0, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
end


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



addEventHandler("onClientRender",getRootElement(),function ()

	if not isPlayerMapVisible() then
		if getElementData(localPlayer,"Occupation") == "Thief" then
			if getElementInterior(localPlayer) ~= 0 then
				if houseid ~= nil then
					if getElementDimension(localPlayer) == houseid then
						if isThisMarker and isElement(isThisMarker) then
							if not isElement(isThisMarker) then return false end
							local distance = getDistanceBetweenElements(isThisMarker,localPlayer)
							if distance <= 1 then
								if not steal[isThisMarker] then steal[isThisMarker] = 0 end
								dxDrawBorderedText("Robbery: "..tostring(steal[isThisMarker]).."%",1, sX - 320, sY - 77.5, sX - 12.5, sY - 63.5, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
								dxDrawBorderedText("Press H to progress your robbery",1, sX - 700.5, sY - 10, sX - 12.5, sY - 63.5, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
								dxDrawCircle(sX - 165, sY - 75, 90, 90, tocolor(255,150,0, 255), 0, steal[isThisMarker]*3.7, 3)
							end
						end
						barlevel = noise
						dxDrawBorderedText("Items to rob: "..tostring(robbedItems).."",1, sX - 117.5, sY - 227.5, sX - 12.5, sY - 63.5, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
						dxDrawBorderedText("Noise: "..tostring(barlevel).."%",1, sX - 117.5, sY - 77.5, sX - 12.5, sY - 63.5, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)

						if noise <= 30 then
							r,g,b = 255,255,255
						elseif noise > 30 and noise <= 50 then
							r,g,b = 255,255,0
						elseif noise > 50 and noise <= 70 then
							r,g,b = 255,155,0
						elseif noise > 70 and noise <= 90 then
							r,g,b = 255,0,0
							dxDrawBorderedText("Warning : Noise is about to reach 100%",1, sX - 677.5, sY - 77.5, sX - 12.5, sY - 63.5, tocolor(255, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
						elseif noise >= 100 then
							r,g,b = 0,0,0
							dxDrawBorderedText("House Robbery : Failed due too much noises you did :(",1, sX - 677.5, sY - 77.5, sX - 12.5, sY - 63.5, tocolor(255, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
						end
						dxDrawCircle(sX - 65, sY - 75, 90, 90, tocolor(r,g,b, 255), 0, barlevel*3.7, 3)
					end
				end
			end
		end
	end
	for i,mar in ipairs(getElementsByType("marker", resourceRoot, true)) do
		if getElementData(mar,"child") then
			if not getElementData(mar, "originalZ") then
				local xz,yz,zz=getElementPosition(mar)
				setElementData(mar,"originalZ",zz)
			end

			local orgZ = getElementData(mar, "originalZ")
			local tick = getTickCount()/SPEED
			local z = math.sin(tick) * AMPLITUDE
			local x,y = getElementPosition(mar)
			setElementPosition(mar, x, y, orgZ+z)
		end
	end

	for i,v in ipairs(getElementsByType("marker",resourceRoot)) do
		if getElementDimension(localPlayer) == getElementDimension(v) then
			local name = getElementData(v,"itemName")
			if getElementData(localPlayer,"Occupation") ~= "Thief" then return false end
			if ( not name ) then return end
			local x,y,z = getElementPosition(v)
			local x2,y2,z2 = getElementPosition(localPlayer)
			local cx,cy,cz = getCameraMatrix()
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 8 then
				local px,py = getScreenFromWorldPosition(x,y,z,0.06)
				if px then
					local width = dxGetTextWidth(name,1,"sans")
					local distance = getDistanceBetweenElements(v,localPlayer)
					if(distance <= 10) then
						local fontbig = 1.3-(distance/10)
						dxDrawBorderedText(name,0.9, px, py, px, py, tocolor(255, 255, 255, 255), fontbig, "sans", "center", "center", false, false)
					end
				end
			end
		end
	end
end)




function dxDrawCircle( x, y, width, height, color, angleStart, angleSweep, borderWidth )
	exports.AURcircle:dxDrawCircle( x, y, width, height, color, angleStart, angleSweep, borderWidth )
end




function getPanelDataReady(dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12,dat13,mk)
		--marker = mk
		--setPickup(dat1,true)
	if set then
		ready = true
		addEventHandler("onClientRender",root,draw)
		tempData = {dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12,dat13}
		table.insert(theData,tempData)
	end
end
addEvent("AURhousingThief.handlePanel", true)
addEventHandler("AURhousingThief.handlePanel", root, getPanelDataReady)


addEvent("NGChousing.des_house_panel", true)

addEvent("onPlayerLeaveHouse", true)

addEventHandler("onPlayerLeaveHouse",root,function(hid)
	triggerServerEvent("onThiefLeaveHouse",localPlayer,hid)
	theData = {}
	set = false
	ready = false
	marker = {}
	houseid = nil
end)



function continueDatPrev(id)
	if ready==false then return end
	ready = false
	removeEventHandler("onClientRender",root,draw)
	for k,v in ipairs(theData) do
		houseid,ownerid,ownername,interiorid,forsale,price,name,locked,boughtfor,hpassworded,hpassword,originalprice = v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8],v[9],v[10],v[11],v[12]
	end
	if houseid and interiorid then
		triggerServerEvent("sendThiefInsideHouse",localPlayer,houseid,interiorid)
	end
end
addEvent("continueThief", true)
addEventHandler("continueThief", root, continueDatPrev)

houseObjects = {}

addEvent("removeTheftMarker",true)
addEventHandler("removeTheftMarker",root,function()
	if houseObjects[localPlayer] then
		for k,v in ipairs(houseObjects[localPlayer]) do
			if v and isElement(v) then
				destroyElement(v)
			end
		end
	end
	robbedItems = 0
	creating = false
end)

addEventHandler("onClientMarkerHit",root,function(hitElement,matchingDimension)
	if getElementData(source,"itemName") then
		if matchingDimension then
			if hitElement and getElementType(hitElement) == "player" then
				if hitElement == localPlayer then
					if getElementInterior(hitElement) == getElementInterior(source) then
						if not isPedInVehicle(hitElement) then
							if getElementData(hitElement,"Occupation") == "Thief" then
								local px,py,pz = getElementPosition ( localPlayer )
								local mx, my, mz = getElementPosition ( source )
								if ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
									isThisMarker = source
									canirob = true
									--[[for k,v in ipairs(houseObjects[localPlayer]) do
										if v == source then
											table.remove(houseObjects[localPlayer],k)
											destroyElement(source)
										end
									end
									triggerServerEvent("setThiefPoint",localPlayer)
									robbedItems = #houseObjects[localPlayer]
									if robbedItems <= 0 then
										triggerEvent("removeTheftMarker",localPlayer)
										exports.NGCdxmsg:createNewDxMessage("You have successfully robbed this house",0,255,0)
										exports.NGCdxmsg:createNewDxMessage("Exchange the points for drugs or money",0,255,0)
									end]]
								end
							end
						end
					end
				end
			end
		end
	end
end)

--[[

{2175.57,-1500.29,23.96,356} - Thief job
]]
--ALTER TABLE `Aktor` ADD `thiefpoints` VARCHAR(225) NOT NULL DEFAULT '0' AFTER `walkstyle`

addEvent("createTheftMarker",true)
addEventHandler("createTheftMarker",root,function(objectTable,dim,tInt)
	if creating == true then return false end
	creating = true
	houseObjects[localPlayer] = {}
	houseid = dim
	for k,v in ipairs(objectTable) do
		--for se,v in ipairs(data) do
			--[[local object = createMarker(v[1],v[2],v[3]-1,"corona",0.8,255,0,0,120)
			setElementInterior(object,tInt)
			setElementDimension(object,dim)
			setElementData(object,"itemName",v[5])
			table.insert(houseObjects[localPlayer],object)]]

			local object2 = createMarker(v[1],v[2],v[3]+1,"arrow",0.9,255,0,0,120)
			setElementData(object2,"originalZ",v[3]+1)
			setElementData(object2,"child",true)
			setElementData(object2,"itemName",v[5])
			setElementInterior(object2,tInt)
			setElementDimension(object2,dim)
			table.insert(houseObjects[localPlayer],object2)
		---end
	end
	robbedItems = #objectTable
end)





function getDistanceBetweenElements(element1, element2)
	local x, y, z = getElementPosition(element1)
	local x1, y1, z1 = getElementPosition(element2)
	return getDistanceBetweenPoints2D(x, y, x1, y1)
end


local cmds = {
[1]="reconnect",
[2]="quit",
[3]="connect",
[4]="disconnect",
[5]="exit",
}

function unbindTheBindedKey()
	local key = getKeyBoundToCommand("reconnect")
	local key2 = getKeyBoundToCommand("quit")
	local key3 = getKeyBoundToCommand("connect")
	local key4 = getKeyBoundToCommand("disconnect")
	local key5 = getKeyBoundToCommand("exit")
--	local key6 = getKeyBoundToCommand("takehit")
	local key7 = getKeyBoundToCommand("dropkit")
	if key or key2 or key3 or key4 or key5  or key7 then
		if key then
			theKey = "Reconnect/Disconnect"
		elseif key2 then
			theKey = "Reconnect/Disconnect"
		elseif key3 then
			theKey = "Reconnect/Disconnect"
		elseif key4 then
			theKey = "Reconnect/Disconnect"
		elseif key5 then
			theKey = "Reconnect/Disconnect"
	--	elseif key6 then
	--		theKey = "takehit"
		elseif key7 then
			theKey = "dropkit"
		end
		if disabled then return end
		disabled = true
	else
		if not disabled then return end
		disabled = false
	end
end
setTimer(unbindTheBindedKey,500,0)
stuck = false
function handleInterrupt( status, ticks )
	if (status == 0) then
		if getElementData(localPlayer,"isPlayerLoss") ~= true then
			stuck = true
			setElementData(localPlayer,"isPlayerLoss",true)
		end
	elseif (status == 1) then
		triggerServerEvent("setPacketLoss",localPlayer,false)
		if getElementData(localPlayer,"isPlayerLoss") == true then
			stuck = false
			setElementData(localPlayer,"isPlayerLoss",false)
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)
lastPacketAmount = 0
setTimer(function()
	if guiGetVisible(dealerpanel.window[1]) then
		if stuck == true then
			forceHide()
			msg("You are lagging due Huge Network Loss you can't open Dealer exchange system")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			msg("You are lagging due PING you can't open Dealer exchange system")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			msg("You can't open Dealer exchange system in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			forceHide()
			msg("You are lagging due FPS you can't open Dealer exchange system")
		end
		if getElementInterior(localPlayer) ~= 0 then
			forceHide()
			msg("Please be in the real world instead of interiors and other dims")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			msg("Please close Drugs panel")
		end
		if getElementData(localPlayer,"isPlayerTrading") then
			forceHide()
			msg("Please close Dealer exchange system")
		end
		if disabled then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while bounded ("..theKey..")",255,0,0)
		end
		if isConsoleActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			msg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while MTA Main Menu is open",255,0,0)
		end
		local network = getNetworkStats(localPlayer)
		if (network["packetsReceived"] > lastPacketAmount) then
			lastPacketAmount = network["packetsReceived"]
		else --Packets are the same. Check ResendBuffer
			if (network["messagesInResendBuffer"] >= 15) then
				forceHide()
				msg("You are lagging like hell (Huge packet loss)")
			end
		end
		if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= dealerpanel.window[1] then
					if guiGetVisible(v) and guiGetVisible(dealerpanel.window[1]) then
						forceHide()
						msg("Please close any panel open!")
					end
				end
			end
		end
	end
end,50,0)

function msg(s)
	if s then
		exports.NGCdxmsg:createNewDxMessage(s,255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage("You are lagging : You can't open Dealer exchange system at the moment!",255,0,0)
	end
end

function forceHide()
	guiSetVisible(dealerpanel.window[1],false)
	showCursor(false)
end

function handleMinimize()
	if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
		forceHide()
    end
end
addEventHandler( "onClientMinimize", root, handleMinimize )

function playerPressedKey(button, press)
	if getKeyState( "latl" ) == true or getKeyState( "escape" ) == true or getKeyState( "ralt" ) == true then
		if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
			forceHide()
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

function handleRestore( didClearRenderTargets )
    if didClearRenderTargets then
		if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
			forceHide()
		end
    end
end
addEventHandler("onClientRestore",root,handleRestore)
