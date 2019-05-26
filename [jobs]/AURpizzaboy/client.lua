markersPosition = {
{-1917.07,1254.67,19.5,132},
{-1783,1140.75,37.64,12},
{-1499.09,915.33,7.18,4},
{-1617.18,1083.54,7.18,191},
{-2014.51,894.1,45.44,250},
{-2071.49,976.41,62.92,352},
{-2107.88,900.59,76.71,35},
{-2064.17,798.1,63.92,183},
{-1993.13,772.41,45.44,172},
{-2015.18,754.82,45.44,149},
{-2097.18,707.12,69.56,107},
{-2096.57,624.42,52.35,179},
{-2221.71,742.05,49.44,15},
{-2620.07,792.51,48.56,284},
{-2692.34,803.84,49.97,351},
{-2879.87,723.94,29.2,262},
{-1940.39,559.64,35.17,358},
{-2175.61,-88.15,35.32,261},
{-1721.42,-130.45,3.54,129},
{-2539.28,-201.46,16.76,182},
}

local ms = {}

local tick
local totalTime
local remainingTime
local locTimer=false
local pizzas = 0
local resourcesMarker = createMarker(-1720.81,1364.53,6.18, "cylinder", 1.5, 255, 150, 0)

function convertTime (ms)
	local min = tostring(math.floor(ms/60000))
	local sec = tostring(math.floor((ms/1000)%60))
	if (#sec == 1) then
		sec = "0"..sec
	end
	return min, sec
end

function getNewLocation()
	if (isElement(marker) or isElement(blip) or isElement(rblip)) then return end
	exports.NGCdxmsg:createNewDxMessage("A new location has been marked in your map! Deliver the pizza on time.", 0, 255, 0)
	local num = math.random(#markersPosition)
	local px, py, pz = getElementPosition(localPlayer)
	distance = math.floor(getDistanceBetweenPoints3D(markersPosition[num][1], markersPosition[num][2], markersPosition[num][3], px, py, pz))
	if (distance < 30) then
		getNewLocation()
		return
	end
	marker = createMarker(markersPosition[num][1], markersPosition[num][2], markersPosition[num][3]-1, "cylinder", 2, 255, 100, 0)
	thePed = createPed (math.random(1,220), markersPosition[num][1], markersPosition[num][2], markersPosition[num][3],  markersPosition[num][4])
	blip = createBlipAttachedTo(marker, 31)
	tick = getTickCount()
	table.insert(ms,{marker,blip})
	totalTime = (( distance / 10) * 1000)
	--addEventHandler("onClientRender", root, drawCountdown)
	addEventHandler("onClientMarkerHit", marker, getPositionsOnMarkerHit)
end

function getPositionsOnVehicleJobTake(veh)
	if (pizzas == 0) then
		pizzas = 5
	end
	if (isElement(veh)) then
		local id = getElementModel(veh)
		if (id == 448) then
			setTimer(getNewLocation, 1000, 1)
		end
	end
end
addEvent("onClientJobVehicleGet", true)
addEventHandler("onClientJobVehicleGet", root, getPositionsOnVehicleJobTake)

function getPositionsOnVehicleEnter(player)
	if (player == localPlayer and pizzas == 0 and getElementModel(source) == 448) then
		if (not isElement(rblip)) then
			exports.NGCdxmsg:createNewDxMessage("Go The Well Stacked Pizza Co. to restock.", 255, 255, 0)
			rblip = createBlipAttachedTo(resourcesMarker, 48)
		end
	end
end
addEventHandler("onClientVehicleEnter", root, getPositionsOnVehicleEnter)

local anticheat2
function getPositionsOnMarkerHit(hitElement)
	if (hitElement and getElementType(hitElement) == "player" and hitElement == localPlayer) then
		local vehicle = getPedOccupiedVehicle(hitElement)
		if (not isElement(vehicle)) then
			return
		end
		local id = getElementModel(vehicle)
		if (id == 448) then
			if (isTimer(anticheat2)) then 
				exports.NGCdxmsg:createNewDxMessage("The system has detected that you've been cheating. Please wait 15 seconds then re-enter to the marker.", 255, 0, 0)
				return false
			end
			if (pizzas > 0) then
				anticheat2 = setTimer(function() killTimer(anticheat2) end, 15000, 1)
				local finishTick = getTickCount()
				local remainingTime = (totalTime - (finishTick - tick))
				local bonusTime = (20 * 1000)
				pizzas = pizzas - 1
				for k,v in pairs(ms) do
					if v[1] == marker then
						table.remove(ms,k)
						break
					end
				end
				setElementVelocity(vehicle, 0, 0, 0)
				triggerServerEvent("AURpizza.pay", localPlayer, distance, remainingTime >= bonusTime)
				removeEventHandler("onClientRender", root, drawCountdown)
				destroyElement(marker)
				destroyElement(blip)
				destroyElement(thePed)
				if (pizzas == 0) then
					exports.NGCdxmsg:createNewDxMessage("You don't have anymore pizza to deliver, go back to The Well Stacked Pizza Co. to get more.", 0, 255, 0)
					rblip = createBlipAttachedTo(resourcesMarker, 48)
				else
					if (isElement(marker) and isElement(blip) and isElement(rblip)) then return end
					setTimer(getNewLocation, 1500, 1, localPlayer)
				end
			end
		end
	end
end

function FailedDelivery()
	exports.NGCdxmsg:createNewDxMessage("Your time is over, you haven't delivered the pizza on time", 0, 255, 0)
	destroyElement(marker)
	destroyElement(blip)
	destroyElement(thePed)
	setTimer(getNewLocation, 1500, 1, localPlayer)
end

function drawCountdown()
	local endTick = getTickCount ( )
	if ( endTick - tick <= totalTime ) then
		local mins, secs = convertTime ( totalTime - endTick + tick )
	else
		removeEventHandler("onClientRender", root, drawCountdown)
		--setTimer(FailedDelivery, 100, 1)
	end
end

local cr=false
--setElementAlpha(resourcesMarker,0)

local anticheat1
function refitPizzas(hitElement)
	if cr==false then return end
 	if (isElement(marker) and isElement(blip)) then return end
	if (isElement(rblip)) then
		if (isElement(hitElement) and hitElement == localPlayer) then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			if (not vehicle) then exports.NGCdxmsg:createNewDxMessage("You must be in a The Well Stacked Pizza Co. Bike to deliver these pizza.",255,0,0) return end
			local id = getElementModel(vehicle)
			if (id == 448) then
				if (isTimer(anticheat1)) then 
					exports.NGCdxmsg:createNewDxMessage("The system has detected that you've been cheating. Please wait 15 seconds then re-enter to the marker.", 255, 0, 0)
					return false
				end
				anticheat1 = setTimer(function() killTimer(anticheat1) end, 15000, 1)
				pizzas = 5
				destroyElement(rblip)
				locTimer = setTimer(getNewLocation, 2000, 1, localPlayer)
			end
		end
	end
end
addEventHandler("onClientMarkerHit", resourcesMarker, refitPizzas)


addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Pizza Boy" then
		setElementAlpha(resourcesMarker,0)
		if isElement(rblip) then destroyElement(rblip) end
		if isTimer(locTimer) then killTimer(locTimer) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(marker) then destroyElement(marker) end
		if isElement(thePed) then destroyElement(thePed) end
		for k,v in pairs(ms) do
			if isElement(v[1]) then destroyElement(v[1]) end
			if isElement(v[2]) then destroyElement(v[2]) end
		end
		pizzas=0
		cr=false
		removeEventHandler("onClientRender",root,drawText)
	elseif nJob == "Pizza Boy" then
		cr=true
		setElementAlpha(resourcesMarker,100)
		addEventHandler("onClientRender",root,drawText)
	end
end
addEventHandler("onPlayerJobChange",localPlayer,jobChange)

addEvent("AURpizzalogin",true)
addEventHandler("AURpizzalogin",localPlayer,function()
	if getElementData(localPlayer,"Occupation") == "Pizza Boy" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		cr=true
		setElementAlpha(resourcesMarker,100)
	end
end)

function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str then
    cap = str:sub(last)
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
  end
end

addEventHandler("onClientPlayerWasted",localPlayer,function()
	if isTimer(locTimer) then killTimer(locTimer) end
	if isElement(blip) then destroyElement(blip) end
	if isElement(marker) then destroyElement(marker) end
	if isElement(thePed) then destroyElement(thePed) end
	for k,v in pairs(ms) do
			if isElement(v[1]) then destroyElement(v[1]) end
			if isElement(v[2]) then destroyElement(v[2]) end
		end
		pizzas=0
end)
screenWidth,screenHeight = guiGetScreenSize()
function drawText()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (vehicle) then
		if getElementModel(vehicle) == 448 then
			else
			return
		end
	else
		return
	end

	dxDrawColorText( "#00CC99Pizza's Left: #33FF33"..pizzas.."", screenWidth*0.08, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )

end

function togglePizzaBoy()
	if getElementData(localPlayer,"Occupation") == "Pizza Boy" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5","down",togglePizzaBoy)