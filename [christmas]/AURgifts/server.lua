local picked = {}
local tbl = {}

local pos = {
	{-2085.02,305.82,41.28,176},
	{-2521.85,311.26,35.11,347},
	{-2727.21,376.74,4.37,164},
	{-2752.58,-252.12,7.18,269},
	{-2412.48,-293.82,57.68,290},
	{-2148.06,-416.3,35.33,328},
	{-1953.87,-734.73,35.89,0},
	{-1524.24,-405.85,7.07,304},
	{-1269.74,48.27,14.14,317},
	{-1413,289.63,1.17,80},
	{-1250.9,501.97,18.23,0},
	{-1680.75,705.25,30.6,0},
	{-1983.35,1118.39,53.12,0},
	{-2157.55,1397.84,5.47,46},
	{-2650.25,1372.1,20.72,80},
	{-2908.99,1241.82,9.64,13},
	{-2803.09,1006.87,48.11,292},
	{-2443.01,748.73,35.17,355},
	{-2441.45,522.87,29.9,77},
	{2093.63,2415.07,74.57,88},
	{1418.11,2773.57,14.81,88},
	{1411.34,2173.28,12.01,176},
	{2597.34,1893.2,11.03,1},
	{2825.21,1708.38,10.82,0},
	{2828.21,1241.07,10.77,179},
	{2323.71,1283.26,97.61,175},
	{2326.66,1387.41,42.82,0},
	{1980.63,2263.19,27.19,0},
	{2414.78,91.8,26.47,269},
	{2152.15,-89.32,2.71,0},
	{1035.35,1539.52,12.6,0},
	{1519.93,13.21,24.14,101},
	{1069.24,2192.04,16.71,0},
	{1336.44,2212.22,12.01,86},
	{1630.77,2226.02,10.82,0},
	{2024.18,2341.93,10.82,0},
	{2473.49,2346.08,10.82,244},
	{2609.02,2398.49,17.82,308},
	{2843.9,2412,11.06,214},
	{2825.32,1690.41,10.82,0},
	{2481.53,1503.8,18.94,0},
	{2323.85,1283.07,97.46,39},
	{2289.55,1122.6,10.82,0},
	{2257.37,727.18,11.1,101},
	{1912.43,704.43,16.14,0},
	{-1234.16,45.39,14.13,232},
	{-1485.94,-368.39,15.31,0},
	{-1859.17,-159.89,21.65,0},
	{-1673.03,419.12,12.43,0},
	{-1425.61,966.48,7.18,23},
	{-1631.73,1340.52,7.77,159},
	{-2453.34,1151.29,55.52,0},
	{-2891.46,793.94,34.89,0},
	{-2706.23,354.2,4.41,0},
	{86.04,-164.61,2.59,267},
	{160.53,-5.76,1.57,263},
	{738.94,-486.97,17.33,271},
	{1074.22,-289.71,73.98,181},
}

function addGifts()
	for k,v in ipairs(pos) do
		local x,y,z = v[1],v[2],v[3]
		local col = createMarker (x, y, z,"cylinder",1.5,255,0,0,0)
		local obj = createPickup(x, y, z,3,2034,0)
		--createBlipAttachedTo(obj,20)
		tbl[col] = obj
		addEventHandler("onMarkerHit", col, gift)
	end
end


function gift(hitElement,dim)
	if dim then
		if (isElement(hitElement) and getElementType(hitElement) == "player" and not isPedInVehicle(hitElement)) then
			if getElementDimension(hitElement) == 0 then
				--if getElementData(hitElement,"isPlayerPrime") ~= true then return false end
				if picked[exports.server:getPlayerAccountName(hitElement)] and picked[exports.server:getPlayerAccountName(hitElement)] >= 3 then outputChatBox("You can take only 3 gifts each today",hitElement,255,0,0) return false end
				if not picked[exports.server:getPlayerAccountName(hitElement)] then picked[exports.server:getPlayerAccountName(hitElement)] = 0 end
				picked[exports.server:getPlayerAccountName(hitElement)] = picked[exports.server:getPlayerAccountName(hitElement)] + 1
				local objx = tbl[source]
				if isElement(source) then destroyElement(source) end
				if isElement(objx) then destroyElement(objx) end
				tbl[source] = nil
				givePlayerMoney(hitElement,100000)
				exports.CSGscore:givePlayerScore(hitElement,10)
				exports.AURvip:givePlayerVIP(hitElement,30)
				outputChatBox("You found a gift!", hitElement, 0, 144, 0)
				outputChatBox("[AUR GIFT] #FFFFFFHere's 30 minutes of VIP, $100,000 & 10 scores", hitElement, 255, 0, 0,true)
				outputChatBox("[AUR GIFT] #FFFFFF"..getPlayerName(hitElement).." found a gift ("..(picked[exports.server:getPlayerAccountName(hitElement)]).."/3)", root, 255,0,0,true)
			end
		end
	end
end

function getGiftsLeft()
	local i = 0
	for col, obj in pairs(tbl) do
		i = i + 1
	end
	return i
end
addGifts()
