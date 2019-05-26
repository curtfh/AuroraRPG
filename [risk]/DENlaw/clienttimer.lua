local jailPoints = {
{1535.93, -1670.89, 13, "LS1"},
{638.95, -571.69, 15.81, "LS2"},
{-2166.05, -2390.38, 30.04, "LS3"},
{-1606.34, 724.44, 11.53, "SF1"},
{-1402.04, 2637.7, 55.25, "SF2"},
{2290.46, 2416.55, 10.3, "LV1"},
{-208.63, 978.9, 18.73, "LV2"}
}
local timing = {}
local prisoners = {}
local count = 0
local counter = 0

addEvent("onClientMissionTimerElapsed",true)
addEvent("onPlayerGetArrestTime", true)
function onPlayerSetArrested (kid)
	local prisoner = kid
	if timing[prisoner] then
		return false
	end
	counter = counter+1
	table.insert(prisoners,counter)
	if counter == 1 then count = 30
	elseif counter == 2 then count = 90
	elseif counter == 3 then count = 120
	end
	local x,y,z,distance = getNearestPoliceStation(source)
	--[[if distance < 50 then timer = 80000
	elseif distance > 50 and distance < 100 then timer = 180000/2
	elseif distance > 100 and distance < 300 then timer = 220000/2
	elseif distance > 300 and distance < 600 then timer = 290000/2
	elseif distance >= 600 then timer = 350000/2 end]]
	timer = distance * 200 + 10000
	timing[prisoner] = exports.missiontimer:createMissionTimer ( timer,true, getPlayerName(prisoner)..": %m:%s", 0.5,460+count, bg, font, 1, 0, 100, 200 )
	cop = source
	addEventHandler("onClientMissionTimerElapsed",root,function()
		if source == timing[prisoner] then
			triggerEvent( "onClientElementDestroy", timing[prisoner])
			triggerServerEvent("getArrested",localPlayer,prisoner)
			for i,timer in ipairs(getElementsByType("missiontimer",source)) do
				if timer == timing[prisoner] then destroyElement(timer) end
			end
			timing[prisoner] = nil
			counter = counter - 1
			triggerEvent("releaseFrom",prisoner)
		end
	end)
end
addEventHandler("onPlayerGetArrestTime", root, onPlayerSetArrested)


addEvent("releaseFromTheClient", true)
function releaseFromTheClient (gay)
	local prisoner = gay
	if prisoner and isElement(prisoner) then
		if timing[prisoner] and isElement(timing[prisoner]) then
			triggerEvent( "onClientElementDestroy", timing[prisoner])
		end
		for i,timer in ipairs(getElementsByType("missiontimer",source)) do
			if timer == timing[prisoner] then destroyElement(timer) end
		end
		timing[prisoner] = nil
		counter = counter - 1
		triggerEvent("releaseFrom",prisoner)
		triggerServerEvent("setControlStateForPrisoner",prisoner)
	end
end
addEventHandler("releaseFromTheClient", root, releaseFromTheClient)

addEvent("releaseFrom",true)
addEventHandler("releaseFrom",root,function()

end)

function getNearestPoliceStation(player)
	if (not player or not isElement(player)) then return end
	local x,y,z = getElementPosition(player)
	local closestPD
	local closestMtrs = 65535
	for i,v in ipairs(jailPoints) do
		local zone = getZoneName(x,y,z,true)
		if (v[4][zone]) then
			return v[1], v[2], v[3]
		end
		local dist = getDistanceBetweenPoints2D(x, y, v[1], v[2])
		if (closestMtrs > dist) then
			closestMtrs = dist
			closestPD = i
		end
	end
	return jailPoints[closestPD][1], jailPoints[closestPD][2], jailPoints[closestPD][3],closestMtrs
end

