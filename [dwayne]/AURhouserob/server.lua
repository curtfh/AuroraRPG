quitDetect = {}

local intids = {
-- House interoirs with locations
[1]="3|235.22|1188.84|1080.25",
[2]="2|225.13|1240.07|1082.14",
[3]="1|223.2|1288.84|1082.13",
[4]="15|328.03|1479.42|1084.43",
[5]="2|2466.27|-1698.18|1013.5",
[6]="5|227.76|1114.44|1080.99",
[7]="15|385.72|1471.91|1080.18",
[8]="7|225.83|1023.95|1084",
[9]="8|2807.61|-1172.83|1025.57",
[10]="10|2268.66|-1210.38|1047.56",
[11]="3|2495.79|-1694.12|1014.74",
[12]="10|2261.62|-1135.71|1050.63",
[13]="8|2365.2|-1133.07|1050.87",
[14]="5|2233.68|-1113.33|1050.88",
[15]="11|2283|-1138.13|1050.89",
[16]="6|2194.83|-1204.12|1049.02",
[17]="6|2308.73|-1210.88|1049.02",
[18]="1|2215.42|-1076.06|1050.48",
[19]="2|2237.74|-1078.89|1049.02",
[20]="9|2318.03|-1024.64|1050.21",
[21]="6|2333.03|-1075.38|1049.02",
[22]="5|1263.44|-785.63|1091.9",
[23]="1|245.98|305.13|999.14",
[24]="2|269.09|305.15|999.14",
[25]="12|2324.39|-1145.2|1050.71",
[26]="5|318.56|1118.2|1083.88",
[27]="1|245.78|305.12|999.14",
[28]="5|140.33|1368.78|1083.86",
[29]="6|234.21|1066.84|1084.2",
[30]="9|83.52|1324.48|1083.85",
[31]="10|24.15|1341.64|1084.37",
[32]="15|374.34|1417.51|1081.32",
[33]="1|2525.0420|-1679.1150|1015.4990",
}

local positions = {
[1] = {
		{223.42,1200.5,1080.26,86,"Radio"},
		{229.36,1201.36,1080.25,358,"TV"},
		{228.8,1187.9,1080.25,177,"Playstation"},
		{221.68,1193.68,1080.25,341,"Light lamp"},
		{243.31,1187.41,1080.26,174,"Microwave"},
	},
[2] = {
		{232.65,1248.72,1082.14,359,"Over"},
		{218.78,1239.75,1082.14,90,"Playstation"},
		{223.72,1253.45,1082.14,57,"DVD & Books"},
		{222.24,1253.29,1082.14,92,"Wooden TV"},

	},

[3] = {
		{226.06,1293.15,1082.14,283,"TV"},
		{224.86,1290.07,1082.13,87,"Table"},
		{232.98,1290,1082.14,272,"Stereo"},
		{217.41,1292.22,1082.14,88,"Clothes washer"},

	},

[4] = {
		{323.69,1478.67,1084.44,181,"Microwave"},
		{324.55,1489.29,1084.44,335,"Light lamp"},
		{328.27,1488.59,1084.43,129,"Magazines & DVD"},
		{320.39,1478.9,1084.43,137,"TV"},

	},
[5] = {
		{2455.61,-1703.61,1013.5,270,"TV"},
		{2451.75,-1705.96,1013.5,187,"Stereo"},
		{2451.95,-1691.88,1013.5,269,"1980 Beer"},
		{2452.67,-1695.51,1013.51,277,"Brother hood wall paper"},


	},

[6] = {
		{238.85,1119.79,1080.99,1,"Microwave"},
		{243.1,1106.45,1080.99,83,"Playstation"},
		{241.37,1116.91,1084.99,178,"TV"},
		{240.17,1115.31,1084.99,278,"Old Jar"},


	},

[7] = {
		{378.8,1452.69,1080.18,183,"Dishes"},
		{378.42,1456.21,1080.18,87,"Microwave"},
		{384.35,1466.37,1080.18,253,"Light lamp"},
		{384.2,1468.91,1080.18,286,"TV"},
		{371.82,1465.06,1080.18,81,"Stereo"},


	},

[8] = {
		{238.05,1024.66,1084,191,"Party Disco lamp"},
		{243.41,1018.28,1084.01,229,"TV"},
		{235.34,1027.76,1088.31,81,"Stereo"},
		{240.17,1032.98,1088.31,170,"Radio"},


	},
[9] = {
		{2811.31,-1171.41,1025.57,129,"Canon"},
		{2806.4,-1165.63,1025.57,67,"DJ Stereo"},
		{2818.96,-1166,1029.17,276,"TV"},


	},
[10] = {
		{2261.95,-1208.57,1049.03,263,"DJ Stereo"},
		{2255.4,-1212.26,1049.02,142,"TV"},
		{2258.49,-1209.11,1049.02,168,"Table"},


	},
[11] = {
		{2491.49,-1695.04,1014.74,30,"Playstation"},
		{2499.23,-1706.78,1014.74,1,"Over"},
		{2494.06,-1700.86,1018.34,359,"Nature glass saver"},


	},
[12] = {
		{2264.63,-1137.51,1050.63,236,"TV"},
		{2259.92,-1133.76,1050.64,21,"Light lamp"},


	},
[13] = {
		{2370.01,-1125.96,1050.87,85,"Stereo"},
		{2358.07,-1134.07,1050.87,92,"Bed Lamp"},
	},
[14] = {
		{2234.7,-1104.99,1050.88,262,"TV"},
		{2234.5,-1109.42,1050.88,282,"Desk Lamp"},
	},
[15] = {
		{2282.04,-1135.97,1050.89,85,"DJ Stereo"},
		{2282.36,-1137.55,1050.89,94,"TV"},
	},
[16] = {
		{2194.81,-1201.25,1049.02,313,"DJ Stereo"},
		{2192.83,-1200.78,1049.02,338,"Phone"},
		{2191.03,-1201.36,1049.02,35,"TV"},
	},
[17] = {
		{2306.64,-1207.52,1049.02,49,"DJ Stereo"},
		{2311.23,-1207.55,1049.02,317,"TV"},
	},
[18] = {
		{2204.03,-1074.27,1050.48,94,"Table"},
		{2209.14,-1077.3,1050.48,177,"TV"},
	},
[19] = {
		{2244.93,-1066.74,1049.02,357,"Light lamp"},
		{2242.79,-1067.13,1049.02,356,"TV"},
	},
[20] = {
		{2327.03,-1018.06,1050.21,358,"Super DJ"},
		{2323.45,-1018.68,1050.21,48,"Modern TV"},
		{2324.81,-1012.49,1050.21,0,"Table"},
		{2323.23,-1015.19,1054.71,126,"Computer"},
	},
[21] = {
		{2330.92,-1068.42,1049.02,183,"DJ Stereo"},
		{2334.7,-1064.73,1049.02,233,"TV"},
	},
[22] = {
		{1273.16,-785.82,1089.93,349,"DJ Stereo"},
		{1248.25,-800.3,1084,1,"Guitar"},
		{1276.4,-793.07,1084.17,174,"Playstation"},
		{1273.29,-794.16,1084.17,184,"Speaker"},
	},
[23] = {
		{248.3,301.59,999.14,185,"Radio"},
	},
[24] = {
		{272.63,305.33,999.14,190,"Chair"},
	},
[25] = {
		{2336.48,-1135.61,1054.3,359,"Bed Lamp"},
		{2324.19,-1142.5,1050.49,338,"Table"},
	},
[26] = {
		{316.12,1117.19,1083.88,152,"TV"},
		{333.79,1119.75,1083.89,268,"Clothes washer"},
	},
[27] = {
		{248.27,301.59,999.14,186,"Radio"},
	},
[28] = {
		{147.57,1373.7,1083.85,93,"Radio"},
		{152.49,1367.79,1083.85,194,"Playstation"},
		{148.38,1376.51,1088.36,357,"Stereo"},
		{140.24,1380.74,1083.86,180,"TV"},

	},
[29] = {
		{243.91,1078.76,1084.18,175,"Radio"},
		{236.34,1084.9,1084.23,308,"Playstation"},
		{231.53,1077.5,1084.24,48,"Disco lamp"},
		{236.53,1082.28,1084.24,261,"Stereo"},

	},
[30] = {
		{79.82,1337.42,1088.36,183,"Radio"},
		{88.53,1329.67,1083.85,31,"Playstation"},
		{87.89,1327.82,1083.85,22,"Disco lamp"},


	},
[31] = {
		{19.11,1347.44,1084.38,85,"Radio"},
		{33.58,1349.94,1084.37,303,"Playstation"},
		{23.43,1350.97,1088.87,6,"TV"},
	},
[32] = {
		{366.34,1425.14,1081.33,354,"Radio"},
		{362.7,1421.17,1081.33,137,"Playstation"},
		{23.43,1350.97,1088.87,6,"TV"},
	},
[33] = {
		{2532.26,-1672.58,1015.49,352,"Stereo"},
		{2535.86,-1676.29,1015.49,173,"TV"},
	},

}


cooldown = {}
local currentThief = {}
local tbl = {}

houseTable = {}

function houseMiscPrev(houseid)
	if (not houseid) then outputDebugString("House id not found Thief") return end
	if currentThief[houseid] and isElement(currentThief[houseid]) and getElementType(currentThief[houseid]) == "player" and currentThief[houseid] ~= source then
		exports.NGCdxmsg:createNewDxMessage(source,"This house is being robbed by another thief.", 255,0,0)
	else
		if isTimer(cooldown[houseid]) then
			exports.NGCdxmsg:createNewDxMessage(source,"This house already robbed!! find another one.", 255,0,0)
			return false
		end
		currentThief[houseid] = source
		triggerClientEvent(source, "continueThief", source, houseid)
	end
end
addEvent("AURhousingThief.houseMiscPrev", true)
addEventHandler("AURhousingThief.houseMiscPrev", root, houseMiscPrev)

drugsTable = {"Ritalin","Weed","Ecstasy","Heroine","Cocaine","LSD"}

local antiSpam = {}
addEvent("exchangeDealerPoints",true)
addEventHandler("exchangeDealerPoints",root,function(pts,pm,pd)
	local poin = tonumber(pts)
	local mo = tonumber(pm)
	local dr = tonumber(pd)
	local can,mssg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		if isTimer(antiSpam[source]) then
			exports.NGCdxmsg:createNewDxMessage(source,"Please wait before you exchange points 5 seconds",255,0,0)
			return false
		end
		antiSpam[source] = setTimer(function() end,5000,1)
		local num = exports.DENstats:getPlayerAccountData(source,"thiefpoints")
		if not num or num == false or num == nil then num = 0 end
		local num = tonumber(num)
		if num > 0 then
			if poin > 0 then
				if num < poin then
					exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough points to exchange this number",255,0,0)
					return false
				end
				if num >= poin then
					if num-poin >= 0 then
						if quitDetect[source] == true then
							return false
						end

						exports.DENstats:setPlayerAccountData(source,"thiefpoints",num-poin)
						exports.AURpayments:addMoney(source,mo,"Custom","Robber",0,"AURhouserob")
						for k,v in ipairs(drugsTable) do
							exports.CSGdrugs:giveDrug(source,v,dr)
							exports.NGCdxmsg:createNewDxMessage(source,"You have exchanged "..poin.." points for "..dr.." hits of all drugs kinds & $"..mo.." cash",0,255,0)
						end
						triggerEvent("queryThiefPoint",source)
					else
						exports.NGCdxmsg:createNewDxMessage(source,"Your points are negative or not enough , please get more points",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough points to exchange this number",255,0,0)
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You dont have any points to exchange",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage(source,mssg,255,0,0)
	end
end)

function convertTime(ms)
    local min = math.floor ( ms/60000 )
    local sec = math.floor( (ms/1000)%60 )
    return min, sec
end

addEvent("getTheftTime",true)
addEventHandler("getTheftTime",root,function(houseid)
	if isTimer(cooldown[houseid]) then
		local remaining = getTimerDetails(cooldown[houseid])
		local minutes, seconds = convertTime(remaining)
		local theTime = (math.floor(minutes)).." minutes "..(math.floor(seconds)).." seconds"
		triggerClientEvent(source,"setHouseThiefTimeLabel",source,theTime)
	end
end)



addEvent("onThiefLeaveHouse",true)
addEventHandler("onThiefLeaveHouse",root,function(houseid)
	if currentThief[houseid] and isElement(currentThief[houseid]) and getElementType(currentThief[houseid]) == "player" and currentThief[houseid] == source then
		currentThief[houseid] = false
		delete(source)
	end
end)
--[[
Connect it with point system and exchange with drugs,money
Each item stolen 20 WP
Add pick lock system to thief if house is locked

]]



addEvent("sendThiefInsideHouse",true)
addEventHandler("sendThiefInsideHouse",root,function(dim,int)
	for k,v in ipairs(getElementsByType("player")) do
		if getElementDimension(v) == dim and getElementInterior(v) == int then
			exports.NGCdxmsg:createNewDxMessage(source,"The owner inside his house, run stupid run",255,0,0)
			return false
		end
	end
	--if houseTable[source] then
		--for k,v in ipairs(houseTable[source]) do
			--if isTimer(cooldown[v[2]]) then
				--killTimer(cooldown[v[2]])
			--end
			--table.remove(houseTable[source],k)
		--end
	--end
	houseTable[source] = {}
	triggerClientEvent(source,"removeTheftMarker",source)
	local x,y,z = getElementPosition(source)
	setElementData(source,"playerHouse",{x,y,z})
	local tableString = intids[tonumber(int)]
	local tInt = gettok ( tableString, 1, string.byte('|') )
	local tX = gettok ( tableString, 2, string.byte('|') )
	local tY = gettok ( tableString, 3, string.byte('|') )
	local tZ = gettok ( tableString, 4, string.byte('|') )
	setElementDimension(source,dim)
	setElementInterior(source, tInt, tX, tY, tZ)
	setElementPosition(source, tX,tY,tZ)
	table.insert(houseTable[source],{source,dim})
	local objectTable = positions[tonumber(int)]
	triggerClientEvent(source,"createTheftMarker",source,objectTable,dim,tInt)
	exports.NGCdxmsg:createNewDxMessage(source,"You are attempt to rob",255,0,0)
end)


function delete(p)
	if houseTable[p] then
		for k,v in ipairs(houseTable[p]) do
			if isTimer(cooldown[v[2]]) then return end
			cooldown[v[2]] = setTimer(function() end,7400000,1)
		end
	end
	triggerClientEvent(p,"removeTheftMarker",p)
end


addEventHandler("onPlayerWasted",root,function()
	delete(source)
end)

addEventHandler("onPlayerArrest",root,function()
	delete(source)
end)

addEventHandler("onPlayerJailed",root,function()
	delete(source)
end)

addEventHandler("onPlayerQuit",root,function()
	delete(source)
end)

addCommandHandler("ok",function(p,cmd,i)
	if getElementData(p,"isPlayerPrime") then
		if i then
		local i = tonumber(i)

		if intids[i] then
			local tableString = intids[tonumber(i)]
			local tInt = gettok ( tableString, 1, string.byte('|') )
			local tX = gettok ( tableString, 2, string.byte('|') )
			local tY = gettok ( tableString, 3, string.byte('|') )
			local tZ = gettok ( tableString, 4, string.byte('|') )
			setElementInterior(p, tInt, tX, tY, tZ)
			setElementPosition(p, tX,tY,tZ)
			outputChatBox("House interior "..tInt.." with ID "..i,p,255,150,0)
		end
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"Occupation") == "Thief" then
			setElementModel(v,68)
		end
	end
end)
skintimer = {}
addEventHandler("onPlayerLogin",root,function()
	if isTimer(skintimer[source]) then return false end
	skintimer[source] = setTimer(function(p)
		if getElementData(p,"Occupation") == "Thief" then
			setElementModel(p,68)
		end
	end,8000,1,source)
end)
gay = {}
addEvent("setThiefPoint",true)
addEventHandler("setThiefPoint",root,function()
	if isTimer(gay[source]) then return false end
	gay[source] = setTimer(function() end,10000,1)
	if quitDetect[source] == true then
		return false
	end

	local num = exports.DENstats:getPlayerAccountData(source,"thiefpoints")
	if not num or num == false or num == nil then num = 0 end
	exports.DENstats:setPlayerAccountData(source,"thiefpoints",num+1)
	exports.server:givePlayerWantedPoints(source,15)
	exports.NGCdxmsg:createNewDxMessage(source,"House robbery: You have earned 1 point & 15 wanted points from robbing this item",0,255,0)
end)
fucker = {}
addEvent("setThiefRobCount",true)
addEventHandler("setThiefRobCount",root,function()
	if isTimer(fucker[source]) then return false end
	fucker[source] = setTimer(function() end,10000,1)
	if quitDetect[source] == true then
		return false
	end
	local num = exports.DENstats:getPlayerAccountData(source,"thief")
	if not num or num == false or num == nil then num = 0 end
	exports.DENstats:setPlayerAccountData(source,"thief",num+1)
end)


addEvent("queryThiefPoint",true)
addEventHandler("queryThiefPoint",root,function()
	if quitDetect[source] == true then
		return false
	end

	local num = exports.DENstats:getPlayerAccountData(source,"thiefpoints")
	if not num or num == false or num == nil then num = 0 end
	triggerClientEvent(source,"callThiefPoint",source,num)
end)


---blugrad32
