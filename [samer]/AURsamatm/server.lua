function startDatabase()
	if (not getResourceFromName("DENmysql")) or (getResourceState(getResourceFromName("DENmysql")) == "loaded") then
		cancelEvent()
		outputChatBox(""..getResourceName(getThisResource()).." failed to start due to some MySQL resource failure.", root, 255, 0, 0)
	end
end
addEventHandler("onResourceStart", resourceRoot, startDatabase)

local bankingMarkers = {
	[1]={562.79998779297, -1254.5999755859, 16.89999961853, 284},
	[2]={1001.700012207, -929.40002441406, 41.799999237061, 278.74658203125},
	[3]={1019.4000244141, -1030, 31.700000762939, 358.49505615234},
	[4]={926.79998779297, -1359.3000488281, 13, 272.49487304688},
	[5]={1193.3994140625, -916.599609375, 42.799999237061, 6.492919921875},
	[6]={485.39999389648, -1733.5999755859, 10.800000190735, 172.49389648438},
	[7]={812.3994140625, -1618.7998046875, 13.199999809265, 90.488891601563},
	[8]={1366.6390380859, -1274.2590332031, 13.246875, 270},
	[9]={1742.1999511719, -2284.3999023438, 13.199999809265, 270},
	[10]={2105.5, -1804.3000488281, 13.199999809265, 270},
	[11]={1760.099609375, -1940.099609375, 13.199999809265, 91.99951171875},
	[12]={2404.1999511719, -1934.5999755859, 13.199999809265, 90},
	[13]={1928.599609375, -1767.099609375, 13.199999809265, 91.99951171875},
	[14]={2419.8999023438, -1506, 23.60000038147, 90},
	[15]={2758.2998046875, -1824.3994140625, 11.5, 19.9951171875},
	[16]={2404.3999023438, -1237.5, 23.5, 90},
	[17]={2136.3000488281, -1154.1999511719, 23.60000038147, 152},
	[18]={1212.93, -1816.11, 16.09, 84.675659179688},
	[19]={2027.19921875, -1401.8994140625, 16.89999961853, 359.99450683594},
	[20]={1498.4798583984, -1581.0864257813, 13.149827575684, 359.99499511719},
	[21]={-2330.3000488281, -163.89999389648, 35.200000762939, 359.99450683594},
	[22]={-1410.2998046875, -296.7998046875, 13.800000190735, 307.99072265625},
	[23]={-2121.19921875, -451.2998046875, 35.180000305176, 279.99206542969},
	[24]={-2708.5, -308.10000610352, 6.8000001907349, 225.98901367188},
	[25]={-2695.5, 260.10000610352, 4.3000001907349, 179.98876953125},
	[26]={-2672, 634.65002441406, 14.10000038147, 359.98352050781},
	[27]={-2767.6000976563, 790.29998779297, 52.400001525879, 89.977996826172},
	[28]={-2636.3000488281, 1399.1999511719, 6.6999998092651, 13.972534179688},
	[29]={-2417.8999023438, 1028.8000488281, 50, 179.96911621094},
	[30]={-2414.8999023438, 352.89999389648, 34.799999237061, 51.967041015625},
	[31]={-1962, 123.40000152588, 27.299999237061, 269.96533203125},
	[32]={-2024.7998046875, -102, 34.799999237061, 177.96203613281},
	[33]={-1675.8000488281, 434, 6.8000001907349, 136},
	[34]={-1967.19921875, 291.5, 34.799999237061, 269.96154785156},
	[35]={-1813.8000488281, 618.40002441406, 34.799999237061, 357.99975585938},
	[36]={-1911.1999511719, 824.40002441406, 34.799999237061, 87.994995117188},
	[37]={-1571.0999755859, 697.29998779297, 6.8000001907349, 89.989501953125},
	[38]={-1648.2998046875, 1214.19921875, 6.8000001907349, 135.98876953125},
	[39]={-1872.0999755859, 1137.9000244141, 45.099998474121, 270},
	[40]={-1806.19921875, 955.7998046875, 24.5, 89.989013671875},
	[41]={2841.6000976563, 1270, 11, 269.75},
	[42]={1437.599609375, 2647.7998046875, 11, 270},
	[43]={2159.5, 939.29998779297, 10.5, 269.74731445313},
	[44]={2020.1999511719, 999.20001220703, 10.5, 90},
	[45]={2227.7998046875, 1402.7998046875, 10.699999809265, 90},
	[46]={1590.8000488281, 703.29998779297, 10.5, 270},
	[47]={1075.5999755859, 1596.6999511719, 12.199999809265, 212},
	[48]={1591.6999511719, 2217.8999023438, 10.699999809265, 1},
	[49]={997.8994140625, 2175.7998046875, 10.5, 87.994995117188},
	[50]={1146.099609375, 2075, 10.699999809265, 0.999755859375},
	[51]={1464.599609375, 2251.69921875, 10.699999809265, 178.99475097656},
	[52]={1671.423828125, 1806.6412353516, 10.5203125, 268.99975585938},
	[53]={1948.8000488281, 2062.1000976563, 10.699999809265, 268.99096679688},
	[54]={2187.8000488281, 2464.1000976563, 10.89999961853, 88.989288330078},
	[55]={2833.3000488281, 2402.8000488281, 10.699999809265, 44.9892578125},
	[56]={2539.3999023438, 2080.1999511719, 10.5, 270.98901367188},
	[57]={2179.5, 1702.8000488281, 10.699999809265, 272},
	[58]={2102.2998046875, 2232.099609375, 10.699999809265, 90},
	[59]={2638.3999023438, 1675.4000244141, 10.699999809265, 269.99951171875},
	[60]={1381, 259.70001220703, 19.200000762939, 153.99450683594},
	[61]={2334.2998046875, 67.69921875, 26.10000038147, 87.989501953125},
	[62]={196.30000305176, -202, 1.2000000476837, 359.98986816406},
	[63]={-2090, -2467.8000488281, 30.299999237061, 141.98904418945},
	[64]={693.599609375, -520.3994140625, 16, 359.98901367188},
	[65]={-2256.3999023438, 2376.3999023438, 4.5999999046326, 311.9873046875},
	[66]={-2206.099609375, -2291.599609375, 30.299999237061, 139.98229980469},
	[67]={-1511.4000244141, 2610.1999511719, 55.5, 359.98425292969},
	[68]={-259.89999389648, 2605.8999023438, 62.5, 179.98352050781},
	[69]={-1212.0999755859, 1833.5, 41.599998474121, 45.983520507813},
	[70]={-856.29998779297, 1529, 22.200000762939, 89.983276367188},
	[71]={-306.39999389648, 1054, 19.39999961853, 181.97805786133},
	[72]={178.60000610352, 1173.1999511719, 14.39999961853, 323.9775390625},
	[73]={-95.300003051758, 1110.6999511719, 19.39999961853, 359.97583007813},
	[74]={776.8994140625, 1869.599609375, 4.5, 89.972534179688},
	[75]={ -1943.1109082031, 2385.9528808594, 49.3753125, 112.00},
	[76]={2090.0832519531, -2409.0424804688, 13.256875, 270.60},
	[77]={2281.1843261719, -2367.7922363281, 13.146875, 400.60}
}

function getPlayerBankBalance(plr)
	local res = exports.DENmysql:query("SELECT * FROM banking WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID(plr))
	if (#res > 0) then
		return tonumber(res[1]["balance"])
	else
		return false
	end
end

for ID in pairs(bankingMarkers) do 
	local x, y, z = bankingMarkers[ID][1], bankingMarkers[ID][2], bankingMarkers[ID][3]
	local rotation = bankingMarkers[ID][4]
	local bankMarker = createMarker(x,y,z-1,"cylinder",1.7, 0, 170 ,0)
	local createATM = createObject ( 2942, x, y, z, 0, 0, rotation )
	--local blip = createBlipAttachedTo(bankMarker, 52)
	--setBlipVisibleDistance(blip, 100)
	--setObjectBreakable( createATM, false )
	setElementFrozen( createATM, true )
	addEventHandler ( "onMarkerHit", bankMarker, function ( hitPlayer, matchingDimension ) 
		if not (getPedOccupiedVehicle(hitPlayer)) and (exports.server:isPlayerLoggedIn(hitPlayer)) then
			local res = exports.DENmysql:query("SELECT * FROM banking WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID(hitPlayer))
			if (#res == 0) then
				exports.DENmysql:exec("INSERT INTO banking (userid, balance, creditcard, PIN) VALUES(?,?,?,?)", exports.server:getPlayerAccountID(hitPlayer), 0, 0, 0)
				exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", exports.server:getPlayerAccountID(hitPlayer), ""..getPlayerName(hitPlayer).." has created his bank account!")
			end
			local transactions = exports.DENmysql:query("SELECT * FROM banking_transactions WHERE userid=? ORDER BY datum DESC", exports.server:getPlayerAccountID(hitPlayer))
			triggerClientEvent(hitPlayer, "AURbanking.drawPinWnd", hitPlayer, res[1]["PIN"] or 0000, transactions, res[1]["balance"] or 0)
			end 
		end
	)
end

addCommandHandler("atm", function(plr)
	local res = exports.DENmysql:query("SELECT * FROM banking WHERE userid=? LIMIT 1", exports.server:getPlayerAccountID(plr))
	if (#res == 0) then
		exports.DENmysql:exec("INSERT INTO banking (userid, balance, creditcard, PIN) VALUES(?,?,?,?)", exports.server:getPlayerAccountID(plr), 0, 0, 0)
		exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", exports.server:getPlayerAccountID(plr), ""..getPlayerName(plr).." has created his bank account!")
	end
	local transactions = exports.DENmysql:query("SELECT * FROM banking_transactions WHERE userid=? ORDER BY datum DESC", exports.server:getPlayerAccountID(plr))
	triggerClientEvent(plr, "AURbanking.drawPinWnd", plr, res[1]["PIN"] or 0000, transactions, res[1]["balance"] or 0)
end 
)


function depositMoney(plr, amount)
	local money = getPlayerMoney(plr)
	if (money < amount) then 
		--Amount
	return false end
	takePlayerMoney(plr, amount)
	local newAmount = getPlayerBankBalance(plr) + amount
	exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", newAmount, exports.server:getPlayerAccountID(plr))
	exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", exports.server:getPlayerAccountID(plr), ""..getPlayerName(plr).." has deposited $"..exports.server:convertNumber(amount).."")
	triggerClientEvent(plr, "AURbanking.changeClientBalance", plr, newAmount, ""..getPlayerName(plr).." has deposited $"..exports.server:convertNumber(amount).."")
end
addEvent("AURbanking.depositMoney", true)
addEventHandler("AURbanking.depositMoney", root, depositMoney)

function withdrawMoney(plr, amount)
	local balance = getPlayerBankBalance(plr)
	if (balance < amount) then return false end
	givePlayerMoney(plr, amount)
	local newAmount = balance - amount
	exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", newAmount, exports.server:getPlayerAccountID(plr))
	exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", exports.server:getPlayerAccountID(plr), ""..getPlayerName(plr).." has withdrew $"..exports.server:convertNumber(amount).."")
	triggerClientEvent(plr, "AURbanking.changeClientBalance", plr, newAmount, ""..getPlayerName(plr).." has withdrew $"..exports.server:convertNumber(amount).."")
end
addEvent("AURbanking.withdrawMoney", true)
addEventHandler("AURbanking.withdrawMoney", root, withdrawMoney)

function sendToOfflineAcc(plr, otherAcc, amount)
	if (string.lower(exports.server:getPlayerAccountName(plr)) == string.lower(otherAcc)) then return false end
	local otherid = exports.DENmysql:query("SELECT id FROM accounts WHERE username=? LIMIT 1", string.lower(otherAcc))
	if (#otherid == 0) then return false end
	local accountid = otherid[1]["id"]
	local res = exports.DENmysql:query("SELECT * FROM banking WHERE userid=? LIMIT 1", accountid)
	if (#res == 0) then return false end
	local balance = getPlayerBankBalance(plr)
	if (balance < amount) then return false end
	local otherBalance = res[1]["balance"]
	local newBalance = otherBalance + amount
	local newAmount = balance - amount
	exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", newBalance, accountid)
	exports.DENmysql:exec("UPDATE banking SET balance=? WHERE userid=?", newAmount, exports.server:getPlayerAccountID(plr))
	exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", exports.server:getPlayerAccountID(plr), ""..getPlayerName(plr).." has sent $"..exports.server:convertNumber(amount).." to "..otherAcc..".")
	exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", accountid, ""..getPlayerName(plr).." has sent you $"..exports.server:convertNumber(amount)..".")
	triggerClientEvent(plr, "AURbanking.changeClientBalance", plr, newAmount, ""..getPlayerName(plr).." has sent $"..exports.server:convertNumber(amount).." to "..otherAcc..".")
end
addEvent("AURbanking.sendToOfflineAcc", true)
addEventHandler("AURbanking.sendToOfflineAcc", root, sendToOfflineAcc)

function updateAccountPIN(plr, newPin)
	exports.DENmysql:exec("UPDATE banking SET PIN=? WHERE userid=?", newPin, exports.server:getPlayerAccountID(plr))
	exports.DENmysql:exec("INSERT INTO banking_transactions (userid, transaction) VALUES(?,?)", exports.server:getPlayerAccountID(plr), ""..getPlayerName(plr).." has changed the bank account's PIN to "..newPin)
end
addEvent("AURbanking.updateAccountPIN", true)
addEventHandler("AURbanking.updateAccountPIN", root, updateAccountPIN)