
local vehicleTable = {
	-- rank id, car 1 , car 2
	{1,585,596},
	{2,547,555},
	{3,549,542},
	{4,410,401},
	{5,479,467},
	{6,516,445},
	{7,466,492},
	{8,585,490},
	{9,400,579},
	{10,579,495},
	{11,400,489},
	{12,418,546},
	{13,421,566},
	{14,434,558},
	{15,535,495},
	{16,535,495},
	{17,405,561},
	{18,439,475},
	{19,426,558},
	{20,550,603},
	{21,477,415},
	{22,587,565},
	{23,402,480},
	{24,599,426},
	{25,562,494},
	{26,506,541},
	{27,451,411},
	{28,411,526},

}

addEventHandler("onResourceStart",root,function()
	for k,v in ipairs(getElementsByType("player")) do
		local mylvl = getPlayerLevel(v)
		if mylvl == 0 or mylvl == false or mylvl == nil then
			givePlayerLevel(v,1)
		end
		setPlayerLevel(v)
	end
end)


addEventHandler("onServerPlayerLogin",root,function()
	setPlayerLevel(source)
end)


function getValidVehicle(thePlayer)
	if (not thePlayer) then
		return vehicleTable[math.random(#vehicleTable)][math.random(2, 3)]
	end
	local xp = getElementData(thePlayer,"playerXP")
	local rank = getElementData(thePlayer,"playerLevel")
	if rank and tonumber(rank) and tonumber(rank) >= 1 then
		for k,v in ipairs(vehicleTable) do
			if tonumber(v[1]) == tonumber(rank) then
				if xp and tonumber(xp) and tonumber(xp) <= 50 then
					return v[2]
				elseif xp and tonumber(xp) and tonumber(xp) > 50 then
					return v[3]
				else
					outputDebugString("has nil")
					return 545
				end
			end
		end
	else
		outputDebugString("rank not 1 above")
		return 545
	end
end

function setPlayerLevel(player)
	local userid = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT * FROM levels WHERE userid=?",userid)
	if data then
		setElementData(player,"playerXP",data.xp)
		setElementData(player,"playerLevel",data.level)
		checkRankXP(player,data.xp,data.level)
	else
		setElementData(player,"playerXP",0)
		setElementData(player,"playerLevel",0)
	end
end


function checkRankXP(player,xp,lvl)
	local userid = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT * FROM levels WHERE userid=?",userid)
	if data then
		local xpData = (data.xp)
		if xpData and tonumber(xpData) and tonumber(xpData) >= 100 then
			local theRank = data.level + 1
			if theRank > 28 then return false end
			exports.DENmysql:exec("Update levels SET xp=?,level=? WHERE userid=?",0,theRank,userid)
			setPlayerLevel(player)
			exports.NGCdxmsg:createNewDxMessage(player,"You have been promoted to Level 2 +$10,000",0,255,0)
			givePlayerMoney(player,10000)
			outputDebugString(getPlayerName(player).." Promoted to L"..theRank)
			triggerEvent("setPlayerVehicleModel",player,getValidVehicle(player))
		end
	end
end



function givePlayerLevel(player,level)
	local userid = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT * FROM levels WHERE userid=?",userid)
	if data then
		if tonumber(data.level) >= 28 then return false end
		exports.DENmysql:exec("UPDATE levels SET level=? WHERE userid=?",level,userid)
		outputDebugString("Update levels SET level "..level)
		setPlayerLevel(player)
	else
		exports.DENmysql:exec("INSERT INTO levels SET level=?,xp=?,userid=?",level,0,userid)
	end
end


function getPlayerLevel(player)
	local userid = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT * FROM levels WHERE userid=?",userid)
	if data then
		return data.level or 0
	else
		return 0
	end
end

function givePlayerXP(player,xp)
	local userid = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT * FROM levels WHERE userid=?",userid)
	if data then
		local xpData = tonumber(xp)+tonumber(data.xp)
		if tonumber(data.level) >= 28 and tonumber(data.xp) >= 90 then return false end
		exports.DENmysql:exec("UPDATE levels SET xp=? WHERE userid=?",xpData,userid)
		outputDebugString("Update levels SET XP "..xp)
		setPlayerLevel(player)
	end
end


function getPlayerXP(player)
	local userid = exports.server:getPlayerAccountID(player)
	local data = exports.DENmysql:querySingle("SELECT * FROM levels WHERE userid=?",userid)
	if data then
		return data.xp or 0
	end
end

