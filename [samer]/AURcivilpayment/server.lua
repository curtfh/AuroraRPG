local tab = {}
local idleTime = {}
local paymentTimer
local TIMER_HOUR = 3600000
local CHECK_TIMER = 5000

local jobToRanksCount = {
	[7] = {"Rescuer Man", "Pilot", "Farmer", "Trucker", "Lumberjack", "Trash Collector", "Diver", "Firefighter"},
	[8] = {"Fisherman"},
	[10] = {"Iron Miner"},
	[11] = {"Taxi Driver"}
}

local paymentTab = 
{
	[6] = {[1] = 2, [2] = 5, [3] = 10, [4] = 25, [5] = 40, [6] = 60},
	[7] = {[1] = 2, [2] = 3.5, [3] = 5, [4] = 12, [5] = 25, [6] = 35, [7] = 85},
	[8] = {[1] = 1.5, [2] = 3, [3] = 5, [4] = 10, [5] = 25, [6] = 35, [7] = 80, [8] = 100},
	[9] = {[1] = 1.5, [2] = 3, [3] = 5, [4] = 10, [5] = 25, [6] = 35, [7] = 80, [8] = 90, [9] = 100},
	[11] = {[1] = 1.5, [2] = 3, [3] = 5, [4] = 10, [5] = 25, [6] = 35, [7] = 80, [8] = 90, [9] = 100, [10] = 120, [11] = 150}
}

function format( n )
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function getJobRanksCount(job)
	for k, v in pairs(jobToRanksCount) do
		for key, value in pairs(v) do
			if (job == value) then
				return k
			end
		end
	end
	return false
end

function getRankPayment(plr)
	local occupation = getElementData(plr, "Occupation")
	if (getJobRanksCount(occupation)) then
		local rank, number = exports.CSGranks:getRank(plr, occupation)
		local ranksCount = getJobRanksCount(occupation)
		local money = paymentTab[ranksCount][number]
		return (money*1000)
	else
		return 5000
	end
end

function isPartOfPayment(plr)
	for k, v in pairs(getElementsByType("player")) do
		if (k == plr) then
			return true
		end
	end
	return false
end

function initializeValues()
	tab = {}
	idleTime = {}
	for k, v in ipairs(getElementsByType("player")) do
		if (getTeamName(getPlayerTeam(v)) == "Civilian Workers") then
			table.insert(tab, v)
			idleTime[v] = 0
			local x1, y1, z1 = getElementPosition(v)
		end
	end
	setTimer(function()
		for k, v in ipairs(tab) do
			if (getPlayerIdleTime(v) > 1250) then
				idleTime[v] = idleTime[v] + CHECK_TIMER
			end
		end
	end, CHECK_TIMER, TIMER_HOUR / CHECK_TIMER)
end

function getPlayerHourlyIdleTime(plr)
	return idleTime[plr]
end

function getHourlyPaymentDetail(plr, cmd)
	if (isTimer(paymentTimer)) then
		if (isPartOfPayment(plr)) then
			outputChatBox("Currently you've been idle for "..math.floor((idleTime[plr] / 1000) / 60).." minute(s).", plr, 0, 255, 0)
		else
			outputChatBox("You're not part of the next payment.", plr, 255, 0, 0)
		end
		local remaining, executesRemaining, totalExecutes = getTimerDetails(paymentTimer)
		outputChatBox(math.ceil((remaining / 1000) / 60).." minute(s) left for the next hourly civilian payment!", plr, 0, 255, 0)
	end
end
addCommandHandler("civpayment", getHourlyPaymentDetail)

function startPaymentTimer()
	initializeValues()
	paymentTimer = setTimer(function()
		for k, v in ipairs(tab) do
			if (idleTime[v] < 600000) then
				local money = getRankPayment(v)
				givePlayerMoney(v, money)
				outputChatBox("You have been given $"..format(money),v, 0, 255, 0)
			end
		end
		initializeValues()
	end, TIMER_HOUR, 0)
	
end

addEvent("onPlayerJobChange", true)
addEventHandler("onPlayerJobChange", root,
	function(newOcc, oldOcc, teamName)
		for k, v in ipairs(tab) do
			if (v == source) and (teamName ~= "Civilian Workers") then
				table.remove(tab, k)
				idleTime[source] = nil
			end
		end
	end
)

addEventHandler("onPlayerQuit", root,
	function()
		for k, v in ipairs(tab) do
			if (v == source) then
				table.remove(tab, k)
				idleTime[source] = nil
			end
		end
	end
)
	
addEventHandler("onResourceStart", resourceRoot,
	function()
		outputDebugString("Hourly civil payment is online")
		startPaymentTimer()
	end
)
			
			
		