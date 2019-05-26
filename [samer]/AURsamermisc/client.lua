local usingAimbot = false

local allowedSerials = 
{
	["336AB4A37F6DA3985F8925EFED850042"] = true,
	["DF16708E5F7E9EF540631519482026E2"] = true,
	["98AE73F5BE5332F43E0E9ED40D64AD62"] = true

}

function getNearestPlayer(player,distance)
	local tempTable = {}
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local px,py,pz = getElementPosition(player)
	for _,v in pairs(getElementsByType("player")) do
		local vx,vy,vz = getElementPosition(v)
		local dis = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
		if dis < distance and (v ~= player) then
			if dis < lastMinDis  and getElementHealth(v) > 0 then 
				if not ((exports.DENlaw:isLaw(v)) and (exports.DENlaw:isLaw(player))) then
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end

addCommandHandler("aimbot", function()
	if (allowedSerials[getPlayerSerial(localPlayer)]) then 
		if (usingAimbot) then
			usingAimbot = false
			outputChatBox("Aimbot is curerntly off", 0, 255, 0)
		else
			usingAimbot = true
			outputChatBox("Aimbot is curerntly on", 0, 255, 0)
		end
	end
end)

addEventHandler("onClientPreRender", root, function()
	if usingAimbot then
		if (getControlState(localPlayer, "aim_weapon")) then
			local px,py,pz = getElementPosition(localPlayer)
			local plr = getNearestPlayer(localPlayer, 100)
			if (plr and isElementStreamedIn(plr)) then
				local x,y, _ = getElementPosition(plr)
				if (getPedWeapon(localPlayer) == 33) or (getPedWeapon(localPlayer) == 34) then
					local rot = (540 - math.deg ( math.atan2 ( ( px - x ), ( py - y ) ) ) % 360) -- sniper
					setPedCameraRotation(localPlayer, rot)
				else
					local rot = (546 - math.deg ( math.atan2 ( ( px - x ), ( py - y ) ) ) % 360) -- normal
					setPedCameraRotation(localPlayer, rot)
				end
				--local rot = -math.deg (math.atan2(x - px, y - py))
				--setPedCameraRotation(localPlayer, rot)
			end
		end
	end
end)

txd = engineLoadTXD ( "fortune.txd" )
engineImportTXD ( txd, 526 )
dff = engineLoadDFF ( "fortune.dff" )
engineReplaceModel ( dff, 526 )

local positions = 
{
[1] = {231.35,994.76,3072.7,250},
[2] = {99.04,876.21,3066.65,257},
[3] = {-90.72,970.36,3069.22,54},
[4] = {-141.77,1397.49,3065.09,277},
[5] = {201.12,1184.48,3058.53,137},
[6] = {135.81,934.8,3059.51,127},
[7] = {-267.11,950.67,3055.67,47},
[8] = {-39.45,1184.43,3150.34,243},
[9] = {-180.71,1482.79,3052.19,192},
[10] = {391.57,1420.12,3077.86,4},
[11] = {638.52,1533.68,3065.01,80},
[12] = {238.55,1568.14,3076.68,118},
[13] = {-85.38,1755.97,3112.26,9},
[14] = {-226.89,1246.36,3085.29,128},
[15] = {99.13,864.63,3066.94,79},
[16] = {52,1378.9,3052.26,23},
[17] = {-99.46,1444.62,3068.01,137},
[18] = {-112.71,1272.86,3078.97,155},
[19] = {69.85,1081.63,3134.8,18},
[20] = {-57.45,1194.17,3159.3,8},
}

addCommandHandler("getground", function()
	for k, v in ipairs(positions) do
		outputChatBox("["..k.."] = {"..v[1]..", "..v[2]..", "..getGroundPosition(v[1], v[2], v[3])..", "..v[4].."},")
	end
end)

if (fileExists("client.lua")) then
	fileDelete("client.lua")
end