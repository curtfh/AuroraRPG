local interiorMarkers = {}

local policeTeams = {
	["Government"] = true,
}

local crimTeams = {
	["Criminals"] = true,
}

addEvent("NGCbr.reachedValve", true)
addEvent("NGCbr.startedHacking", true)
addEvent("NGCbr.finishedHacking", true)
addEvent("NGCbank_int.onInteriorHit", true)
addEvent("NGCbank_int.onInteriorWarped", true)
addEvent("NGCbr.startedHacking")
addEvent("NGCbr.hacking")

env = {
	dim = 15,
	int = 4,
	runtime = 600000,
	runtimeTimer = false,
	startDelay = --[[300000]]10000,
	openingDelay = 1800000,
	hostage = false, 
	hostageKillPenalty = 0.3, -- percent taken from crim money if hostage killed by crims
	hostageCopKillPenalty = 0.5, -- percen taken from cops if hostage killed by cops
	hostageValues = {skin = 141, x = 1407, y = -992, z = 3154, rot = 270},
	code = false, 
	hackerMul = 0.3,
	crimEscapeMultiplier = 0.5, -- money mul by if escaped
	crimKillPay = 200,
	crimBankClearBonus = 0.1,
	maxLoot = 12000,
	minLoot = 4000,
	noCopsPenalty = 0.7,
	copKillPay = 2000,
	copBankClearBonus = 0.5,
	copGateDelay = 45000,
	copGateOpenTimer = false,
	copGateID = "object (chinaTgarageDoor) (1)",
	copGate = false,
	copGatePos = {open   = {1412.1999511719,-975.5,3142.8999023438},
				  closed = {1416.1999511719,-975.5,3142.8999023438}
	},
	safeHackedCopPenalty = 0.2 -- safe cracked penalty
}

state = {
		
		opened = false,
		started = false,
		gotCodeOnce = false,
		hacking = false,
		hacked = false,
		copDoorOpen = false,
		hostageKilled = false,
		crimEscaped = false,
		copsParticipated = false
}

entrance = {
		front = {i = {}, o = {}}, 
		cop = { i = {}, o = {}},
}

local involved = {
	teams = {
		cops = {}, 
		criminals = {}
	},
	_prot = {
		pEntry = true,
		money = 0,
		player = nil,
		team = "civilist"
	},
	_pclass = {}
}
involved._mt = {__index = involved._pclass}

function involved._pclass:setMoney(amount)
	d("_pclass:setMoney",amount)
	self.money = math.floor(amount)
	self:fire("NGCbr.moneyChanged", self.player, self.money)
end

function involved._pclass:moneyMul(mult)
	self:setMoney(self.money * mult)
end

function involved._pclass:giveMoney(amount)
	d("_pclass:giveMoney",amount,"before",self.money)
	self:setMoney(self.money + amount)
	d("after",self.money)
end

function involved._pclass:cleanMoney()
	self:setMoney(involved._prot.money)
end

function involved._pclass:payDay(reason)
	d("_pclass:payDay",reason,self.money)
	local c = colors[self.team]
	reason = "BR: "..(reason or "Pay Day")
	self:fire("NGCbr.payed", self.player)
	if(self.money > 0) then
		self:send("Your share from BR! ("..reason..") Amount: "..self.money)
	else
		self:send("Your BR balance was 0, no money given.")
	end
	givePlayerMoney(self.player, self.money)
	self:cleanMoney()
end

function involved._pclass:send(msg, c,g,b)
	c = c or colors[self.team]
	d("_pclass:send of",getPlayerName(self.player),"msg:",msg)
	o(msg, self.player, c.r or c,c.g or g, c.b or b)
end

function involved._pclass:setTeam(team)
	self.team = team
end

function involved._pclass:getTeam()
	return self.team
end

function involved._pclass:fire(event, source, ...)
	triggerClientEvent(self.player, event, source, ...)
end

function involved:bulk(team, except, func, ...)
	d("involved:bulk",team,except,func,...)
	if team then
		d("was team",team,involved.teams[team])
		if involved.teams[team] then
			d("...was team leaf",team)
			for plr,pEntry in pairs(involved.teams[team]) do
				if(not is(plr, except)) then
					if(not isElement(pEntry.player)) then
						d(2, "Player invalidated, (Quit, Timeout, etc.)")
						involved.teams[team][plr] = nil
					else
						func(pEntry, ...)
					end
				end
			end
		elseif (isElement(team) and getElementType(team) == "player") then
			d("... was a player!")
			for lkey,leaf in pairs(involved.teams) do
				if(leaf[team]) then func(leaf[team], ...) break end
			end
		elseif (type(team) == "table" and team.pEntry) then
			d("... was a player Entry!")
			if(not is(team.player, except)) then
				if(not isElement(team.player)) then
					d(2, "Player invalidated, (Quit, Timeout, etc.). CANT REMOVE!")
				else
					func(team, ...)
				end
			end
		else
			d("...but no leaf or plr")
		end
	else
		d("No team")
		for lkey,leaf in pairs(involved.teams) do
			d("bulkwork on leaf",lkey)
			for plr,pEntry in pairs(leaf) do
				if(not is(plr, except)) then
					func(pEntry, ...)
				end
			end
		end
	end
end

function involved:add(plr)
	d("involved:add",getPlayerName(plr))
	if(getElementType(plr) ~= "player") then return false end
	local pEntry = {}
	for k,v in pairs(self._prot) do
		pEntry[k] = v
	end
	setmetatable(pEntry, {__index = involved._pclass})
	pEntry.player = plr
	if not plr then d("participant returned false -> plr was no player!") return end
	if (getPlayerTeam(plr) == getTeamFromName("Criminals")--[[isPlayerCriminal(plr)]]) then
		d("crim")
		pEntry:setTeam("criminals")
		triggerClientEvent(plr, "NGCbr.warpProtect", plr)
		self.teams.criminals[plr] = pEntry
	elseif (isPlayerCop(plr)) then
		d("cop")
		pEntry:setTeam("cops")
		self.teams.cops[plr] = pEntry
		state.copsParticipated = true
	else
		d("else")
		return false
	end
	pEntry:fire("NGCbr.involvedAdded", pEntry.player, pEntry:getTeam())
	return pEntry:getTeam()
end

function involved:drop(plr, reason)
	d("involved:drop",getPlayerName(plr))
	for lkey,leaf in pairs(involved.teams) do
		if(leaf[plr]) then
			d("removing from",lkey)
			leaf[plr]:payDay(reason or "Dropped")
			leaf[plr] = nil
			triggerClientEvent(plr, "NGCbr.robberyFinished", plr)
		end
	end
end

function involved:empty(party)
	d("involved:empty")
	if party then
		d("check empty party",party,#involved.teams[party])
		if next(involved.teams[party]) == nil then return true end
		return false
	else
		for lkey,leaf in pairs(involved.teams) do
			d("check empty leaf",lkey)
			if next(leaf) ~= nil then return false end
		end
		return true
	end
end
addCommandHandler("chkmpty", function() outputDebugString(tostring(involved:empty("criminals"))) end)

-- PARTY ONE OF cops, criminals
function involved:send(team, except, msg)
	d("involved:send")
	local msgTo = function(pEntry, m, c)
		local c = c or colors[pEntry.team]
		d("msgTo",m,pEntry.player)
		pEntry:send(m, c or colors.normal)
	end
	self:bulk(team, except, msgTo, msg, colors[party])
end
function involved:clear(team)
	d("involved:clear")
	if team then
		d("clear team",team)
		self:bulk(team, nil, function(pe) involved:drop(pe.player, "Clearing") end)
		self.teams[team] = {}
	else
		for lkey,leaf in pairs(self.teams) do
			d("clear leaf",lkey)
			self:bulk(lkey, nil, function(pe) involved:drop(pe.player, "Clearing") end)
			self.teams[lkey] = {}
		end
	end
end
-- fires events on players
function involved:fire(team, except, event, source, ...)
	d("involved:fire")
	function fireTo(pEntry, event, source, ...)
		pEntry:fire(event, source, ...)
	end
	self:bulk(team, except, fireTo, event, source, ...)
end

function involved:moneyMul(team, except, mult)
	d("involved:moneyMul")
	function moneyMulTo(pEntry, mult)
		pEntry:moneyMul(mult)
	end
	self:bulk(team, except, moneyMulTo, mult)
end

function involved:giveMoney(team, except, amount)
	d("involved:giveMoney")
	function giveMoneyTo(pEntry, amount)
		pEntry:giveMoney(amount)
	end
	self:bulk(team, except, giveMoneyTo, amount)
end

function involved:cleanMoney(team, except)
	d("involved:cleanMoney")
	self:bulk(team, except, function(pEntry) pEntry:cleanMoney() end)
end

function involved:payDay(team, except, reason)
	d("involved:payDay")
	function payDayTo(pEntry, reason)
		pEntry:payDay(reason)
	end
	self:bulk(team,except, payDayTo, reason)
end



function initResource(res)
	d("initResource")
	_defaults:hold("env", env)
	_defaults:hold("state", state)
	cleanUpEnvironment()
	
	local waysIn = getElementsByType("interiorEntry_", resourceRoot)
	for _,wayIn in pairs(waysIn) do
		d("wayIn",_)
		local wayID = getElementData(wayIn, "id")
		d("id is",wayID)
		if(wayID == "BANKROBBERY_FRONT") then
			entrance.front.i.el = wayIn
			entrance.front.i.marker = exports.NGCbank_int:getInteriorMarker(wayIn)
		elseif (wayID == "BANKROBBERY_COP") then
			entrance.cop.i.el = wayIn
			entrance.cop.i.marker = exports.NGCbank_int:getInteriorMarker(wayIn)
		end
	end
	
	local waysOut = getElementsByType("interiorReturn_", resourceRoot)
	for _,wayOut in pairs(waysOut) do
		d("wayOut",_)
		local wayID = getElementData(wayOut, "refid")
		d("refid was",wayID)
		if(wayID == "BANKROBBERY_FRONT") then
			d("front")
			entrance.front.o.el = wayOut
			entrance.front.o.marker = exports.NGCbank_int:getInteriorMarker(wayOut)
		elseif (wayID == "BANKROBBERY_COP") then
			d("cop")
			entrance.cop.o.el = wayOut
			entrance.cop.o.marker = exports.NGCbank_int:getInteriorMarker(wayOut)
		end
	end
	
	initVisitorAdding()
	robbTimer = setTimer(robberyOpening, env.openingDelay, 0)
	robberyOpening()
end
addEventHandler("onResourceStart", resourceRoot, initResource)

--[[function getInteriorMarker ( elementInterior )
	if not isElement ( elementInterior ) then outputDebugString("getInteriorName: Invalid variable specified as interior.  Element expected, got "..type(elementInterior)..".",0,255,128,0) return false end
	local elemType = getElementType ( elementInterior )
	if elemType == "interiorEntry_" or elemType == "interiorReturn_" then
		return interiorMarkers[elementInterior] or false
	end
	outputDebugString("getInteriorName: Bad element specified.  Interior expected, got "..elemType..".",0,255,128,0)
	return false
end]]

function handleMarkerHit(plr)
	d("handleMarkerHit",plr)
	if not is(source, entrance) then d("returning") return end
	-- ENTRY FRONT
	if is(source, "front") then
		d("front")
		if is(source, entrance.front.i) then
			if state.gotCodeOnce then
			if isPlayerCop(plr) then
				d("Cop blocked")
				local c = colors.cops
				o("Are you out of your mind? You can't run right into a bank robbery! Better use the back entrance...", plr, c.r,c.g,c.b)
				cancelEvent()
			elseif isPlayerCriminal(plr) and state.hacked then
				d("Criminal blocked")
				local c = colors.criminals
				o("Seems like they locked the door from the inside... (Safe hacked, loot shared, no way to get in)", plr, c.r,c.g,c.b)
				cancelEvent()
			elseif isPlayerCriminal(plr) then
				d("Civilist blocked")
				local c = colors.critical
				o("This bank is being robbed, better get some cover and call the police!", plr, c.r,c.g,c.b)
				cancelEvent()
			end
			elseif(state.opened and isPlayerCop(plr)) then
				local c = colors.cops
				o("There will be a bank robbery starting soon. If you want to participate, please use the back entrance!", plr, c.r,c.g,c.b)
				cancelEvent()
			end
		elseif state.started and is(plr, involved.teams) then
			involved:send(plr, nil, "Doors locked! (You can't escape through the front door, because the event started!)")
			cancelEvent()
		end
	-- ENTRY COP
	elseif (is(source, "cop")) then
		d("cop")
		if (is(source, entrance.cop.i)) then
			if not isPlayerCop(plr) then
				local c = colors.critical
				if (state.gotCodeOnce) then
					o("This door is only open to law forces, because there's a ongoing bankrob!", plr, c.r,c.g,c.b)
				else
					o("The doors are locked!", plr, c.r,c.g,c.b)
				end
				cancelEvent()
			elseif(state.opened) then
				involved:add(plr)
			end
		else
			if(is(plr, involved.teams.cops)) then
					involved:drop(plr, "Cop left the building")
			elseif(state.gotCodeOnce) then
				if(is(plr, involved.teams.criminals)) then
					crimEscaped(plr)
					if(involved:empty("criminals")) then
						robberyFinish()
					end
				end
			else
				involved:drop(plr, "Left the building")
			end
		end
	end
end
addEventHandler("NGCbank_int.onInteriorHit", getRootElement(), handleMarkerHit)

function isPlayerCop(player)
	if (player) then
		if (not isElement(player)) then return false end
		local team = getPlayerTeam(player)
		if (not team) then return false end
		if (policeTeams[getTeamName(team)]) then return true end
	end
end

function isPlayerCriminal(player)
	if (player) then
		if (not isElement(player)) then return false end
		local cteam = getPlayerTeam(player)
		if (not cteam) then return false end
		if (crimTeams[getTeamName(cteam)]) then return true end
	end
end

--[[ DEPRECATED FUNCTION
function isPlayerCriminal(player)
	if (player) then
		if (not isElement(player)) then return false end
		local job = getElementData(player, "Occupation")
		if (not job or job ~= "Criminals") then return false end
		if (crimTeams[tostring(job)]) then return true end
	end
end]]

--[[function add(plr)
	if (plr) then
		involved:add(plr)
	end
end
addCommandHandler("addme", add)]]

function handleMarkerWarp(plr)
	d("handleMarkerWarp")
	if not is(source) then return end
	
	-- ENTRY FRONT
	if is(source, "front") then
		d("front")
		if is(source, entrance.front.i) then
			d("in")
			if(not state.started) then
				addVisitor(plr)
			else
				involved:add(plr)
				if (is(source, involved.teams.criminals)) then
					triggerClientEvent(source, "NGCbr.warpProtect", source)
				end
			end
		else 
			d("else")
			removeVisitor(plr)
		end
	end
	
	-- ENTRY COP
	if is(source, "cop") then
		d("cop")
		if is(source,entrance.cop.i) then
			d("in")
			addVisitor(plr)
		else
			d("else")
			removeVisitor(plr)
		end
	end
end
addEventHandler("NGCbank_int.onInteriorWarped", getRootElement(), handleMarkerWarp)

function crimEscaped(plr)
	state.crimEscaped = true
	involved:moneyMul(1+env.crimEscapeMultiplier)
	involved:send(plr, nil, "You successfuly escaped from the bank robbery. However, you're wanted now, so better run!")
	if (not state.copsParticipated) then
		involved:moneyMul("criminals", nil, 1-env.noCopsPenalty)
		involved:send(criminals, nil, "There were no cops, your share is reduced by "..(env.noCopsPenalty*100).."%")
	end
	exports.server:givePlayerWantedPoints(plr, 100)
	involved:drop(plr, "Escaped")
end
trackBankVisitors = {}

function initVisitorAdding()
	plrs = getElementsByType("player")
	for _,p in pairs(plrs) do
		if (checkIfStillInBank(p)) then
			addVisitor(p)
		end
	end
end

function addVisitor(plr)
	d("addVisitor")
	removeVisitor(plr)
	trackBankVisitors[plr] = setTimer(function () checkIfStillInBank(plr) end, 5000, 0)
	addEventHandler("onPlayerWasted", plr, removeVisitor)
end

function removeVisitor(plr)
	d("removeVisitor")
	if not plr then plr = source end
	if(trackBankVisitors[plr]) then 
		killTimer(trackBankVisitors[plr])
		removeEventHandler("onPlayerWasted", plr, removeVisitor)
	end
	trackBankVisitors[plr] = nil
end

function checkIfStillInBank(plr,timer)
	d("checkIfStillInBank")
	if(isElement(plr)) then
		d("still in",getPlayerName(plr))
		int = getElementInterior(plr)
		dim = getElementDimension(plr)
		if int ~= env.int or dim ~= env.dim then
			d("plr not in dim",dim,"int",int)
			if isTimer(trackBankVisitors[plr]) then d("kill check timer") killTimer(trackBankVisitors[plr]) end
			trackBankVisitors[plr] = nil
			return false
		end
		return true
	elseif timer then killTimer(timer) trackBankVisitors[plr] = nil end
	return false
end

function robberyOpening()
	d("robberyOpening")
	state.opened = true
	o("Bank is less safe than thought! Bank available to be robbed in "..tostring(math.floor(env.startDelay/1000)).. " seconds!", root, 255, 255, 0)
	d(":)")
	robbStartTimer = setTimer(robberyStart, env.startDelay , 1)
end

function robberyStart()
	d("robberyStart")
	for person, _ in pairs(trackBankVisitors) do
		removeVisitor(person)
		d("is",person)
		if not involved:add(person) then
			d("not involved")
			local c = colors.critical
			o("Take a look around... this people might look suspicious (Robbery could be starting any minute, run!)", plr, c.r,c.g,c.b)
		end
	end
	if(next(involved.teams.criminals) == nil) then
		d("no crims")
		o("Los Santos is the safest city in San Andreas! Bank robbery cancelled due to no participants", root, 0, 255, 0)
		cleanUpEnvironment()
	else
		d("yes crims")
		setUpEnvironment()
		involved:send("criminals", nil, "Ok, lets get this shit started! Aim at the banker to make her tell you the safe code!")
		state.started = true
	end
end

function cleanUpEnvironment()
	d("cleanUpEnvironment")
	involved:clear()
	rmHostage()
	if(isTimer(env.runtimeTimer)) then
		killTimer(env.runtimeTimer)
	end
	state = _defaults:get("state")
	env = _defaults:get("env")
	env.copGate = getElementByID(env.copGateID)
	closeCopGate()
	initVisitorAdding()
end

function setUpEnvironment()
	d("setUpEnvironment")
	setHostage()
	env.runtimeTimer = setTimer(robberyFinish, env.runtime, 1)
end

function rmHostage()
	if(env.hostage) then
		d("had hostage")
		removeEventHandler("onPlayerTarget", root, hostageTargeted)
		removeEventHandler("onPedWasted", env.hostage, hostageKilled)
		destroyElement(env.hostage) 
	end
end

function setHostage()
	if (env.hostage) then d("kill old hostage") destroyElement(env.hostage) end
	env.hostage = createPed(env.hostageValues.skin, env.hostageValues.x, env.hostageValues.y, env.hostageValues.z, env.hostageValues.rot)
	setElementDimension(env.hostage, env.dim)
	setElementInterior(env.hostage, env.int)
	setElementFrozen(env.hostage, true)
	addEventHandler("onPlayerTarget", root, hostageTargeted)
	addEventHandler("onPedWasted", env.hostage, hostageKilled)
end

function startedHacking()
	involved:send("criminals", source, getPlayerName(source).." is hacking the valve, cover him!")
	involved:send("cops", nil, "The robbers are hacking the safe!")
end
addEventHandler("NGCbr.startedHacking", root, startedHacking)

function finishedHacking()
	d("finishedHacking")
	state.hacked = true
	local randomAmount = math.random(env.minLoot, env.maxLoot)
	involved:giveMoney("criminals", nil, randomAmount)
	involved:send("criminals", nil, "You have robbed the bank successfully and made $"..randomAmount)
	involved:send(env.gotCode, nil, "You get an extra of "..(env.hackerMul*100).."%!")
	involved:moneyMul(state.gotCode, nil, 1+env.hackerMul)
	setTimer(function() 
		if(state.hostageKilled) then
			involved:moneyMul("criminals", nil, 1-env.hostageKillPenalty)
			involved:send("criminals", nil, "Unfortunately "..getPlayerName(state.hostageKilled).." killed the hostage and your loot is reduced by "..(env.hostageKillPenalty*100).."%!")
		end
	end, 5000, 1)
	involved:send("criminals", nil, getPlayerName(source).." hacked the safe, get the hell out of there!")
	involved:moneyMul("cops", nil, 1-env.safeHackedCopPenalty)
	involved:send("cops", nil, "The robbers opened the safe, don't let them escape! (Reduced money by "..(env.safeHackedCopPenalty*100).."%!)", "cops")
	openCopGate()
end
addEventHandler("NGCbr.finishedHacking", root, finishedHacking)

function hostageTargeted(target)
	if (target == env.hostage and getControlState(source, "aim_weapon") and state.started) then
		d("hostageTargeted")
		if (not involved.teams.criminals[source]) then d("no crim") return end
		if not state.gotCodeOnce then
			d("shout breaking news")
			o("Breaking News: Bank Robbery - Personnel in fears! (The Los Santos bank is being robbed!)", root, 255, 0, 0)
			state.gotCodeOnce = true
			exports.server:givePlayerWantedPoints(source, 100)
			setPlayerWantedLevel(source, 6)
			if (env.hostage) then
				setPedAnimation(env.hostage, "ped", "handsup")
				setElementModel(env.hostage, 140, false)
			end
			triggerClientEvent("NGCbr.gotCodeOnce",root,state.gotCodeOnce)
			env.copGateOpenTimer = setTimer(openCopGate, env.copGateDelay, 1)
		end
		if (isElement(env.gotCode) and env.gotCode == source) then
			d("was the current hacker")
			local c = colors.criminals
			o("Get down to the safe and enter your code: "..env.code, source, c.r,c.g,c.b)
			return
		elseif(isElement(env.gotCode)) then
			d("already got code")
			local c = colors.criminals
			o(getPlayerName(env.gotCode).." already got the code.", source, c.r,c.g,c.b)
			return
		else
			env.gotCode = false
		end
		env.code = generateString(5)
		env.gotCode = source
		o("Go down the valve and enter this code: "..env.code.." to crack the safe", source, 0, 255, 0)
		involved:send("criminals", nil, getPlayerName(env.gotCode).." has got the code, defend them while they crack the bank safe!", "criminals", source)
		triggerClientEvent("NGCbr.gotCode",source, env.code)
	end
end

function hostageKilled(_, killer)
	state.hostageKilled = killer
	rmHostage()
	if (isElement(env.hostage)) then
		removeEventHandler("onPedWasted", env.hostage, hostageKilled)
		destroyElement(env.hostage)
	end
	env.hostage = createPed(env.hostageValues.skin, env.hostageValues.x, env.hostageValues.y, env.hostageValues.z, env.hostageValues.rot)
	setElementDimension(env.hostage, env.dim)
	setElementInterior(env.hostage, env.int)
	addEventHandler("onPlayerTarget", root, hostageTargeted)
	addEventHandler("onPedWasted", env.hostage, hostageKilled)
	env.runtimeTimer = setTimer(robberyFinish, env.runtime, 1)
	if is(killer, involved.teams.criminals) then
		sendCopMessage("The robbers killed the hostage, bring them down!", false, 255,0,0)
	elseif is(killer, involved.teams.cops) then
		involved:cleanMoney(killer, nil)
		involved:send(killer, nil, "You killed the hostage and lost everything you earned within BR so far")
		involved:moneyMul("cops", killer, 1-env.hostageCopKillPenalty)
		involved:send("cops", killer, getPlayerName(killer).." killed the hostage, your current BR payment's reduced by "..(env.hostageCopKillPenalty*100).."%!")
	end
	setHostage()
end

function _sendCopMessage(msg, team, r, g, b)
	local plrs = getPlayersInTeam(getTeamFromName(team))
	for _,p in pairs(plrs) do
		exports.NGCdxmsg:createNewDxMessage(msg, p, r or 255, g or 255, b or 0)
		--exports.DENdxmsg:createNewDxMessage(msg, p, r or 255, g or 255, b or 0)
	end
end

function sendCopMessage(msg, team, r, g, b)
	if (not team) then
		for team,_ in pairs(policeTeams) do
			_sendCopMessage(msg, team, r, g, b)
		end
	elseif (policeTeams[team]) then
		_sendCopMessage(msg, team, r, g, b)
	else
		outputDebugString("No police team: "..tostring(team))
	end
end

function openCopGate()
	d("openCopGate")
	if (env.copGateOpenTimer and isTimer(env.copGateOpenTimer)) then 
		killTimer(env.copGateOpenTimer) 
	end
	moveObject(env.copGate, 2000, env.copGatePos.open[1], env.copGatePos.open[2], env.copGatePos.open[3])
	if state.copDoorOpen then return end
	state.copDoorOpen = true
	involved:fire(nil, nil, "NGCbr.copDoorOpen",root, false, state.copDoorDown)
	d("send cop gate open msg")
	involved:send(nil, nil, "COP GATE OPENED UP!")
end

function closeCopGate()
	if (not env.copGate) then return end
	d("closeCopGate",env.copGate,getElementID(env.copGate),"pos",env.copGatePos,env.copGatePos.closed[1],env.copGatePos.closed[2],env.copGatePos.closed[3])
	state.copDoorOpen = false
	involved:fire(nil, nil, "NGCbr.copDoorOpen",root, false, state.copDoorDown)
	setElementPosition(env.copGate, env.copGatePos.closed[1], env.copGatePos.closed[2], env.copGatePos.closed[3])
end

-- STUFF FROM TRYING ON THE DOOR
--object (chinaTgarageDoor) (1)
--1416.1999511719,-975.5,3142.8999023438 x+
-- door = getElementByID("object (chinaTgarageDoor) (1)")
--[[
x,y,z= getElementPosition(door)
-- BASE POSITION
setElementPosition(door,1416.1999511719,-975.5,3142.8999023438)
outputDebugString("x:"..x..";y:"..y..";z:"..z)
-- OPEN POSITION
moveObject(door, 980, 1412.1999511719,-975.5,3142.8999023438)
--]]
--createColRectangle ( float fX, float fY, float fWidth, float fHeight)
--[[
-- PERFECT COLSHAPE
col = createColCuboid(1414.7, -977, 3141.35, 2, 2.5, 3)

-- WORKING DOORLOGIC
function enter()
moveObject(door, 50, 1412.1999511719,-975.5,3142.8999023438)
  end
addEventHandler("onColShapeHit", col, enter)

function leave()
  moveObject(door, 50, 1416.1999511719,-975.5,3142.8999023438)
 end
addEventHandler("onColShapeLeave", col, leave)
setTimer(function() destroyElement(col) end, 30000, 1)
--]]
function handleKills(ammo, killer)
	if state.copDoorOpen and killer and getElementType(killer) == "player" and is(killer, involved) and is(source, involved) then
		if (source == env.gotCode) then
			env.gotCode = false
			involved:send("criminals", nil, "The keyholder died, get the code again!")
		end
		if is(source, involved.teams.criminals) then
			local c = colors.criminals
			o("You have been killed by "..getPlayerName(killer).." and dropped out of the robbery!", source, c.r,c.g,c.b)
			if is(killer, involved.teams.cops) then
				local pay = env.copKillPay
				if is(state.hostageKilled, involved.teams.criminals) then
					pay = 2*pay
				end
				o("Well done, here's $"..pay.." for killing a robber", killer, 0, 255, 0)
				involved:giveMoney(killer, nil, env.copKillPay, "Killed Robber")
				if(involved:empty("criminals")) then
					robberyFinish()
				end
			end
			involved:drop(source, "Got killed")
		elseif is(source, involved.teams.cops) then
			local c = colors.cops
			o("You have been killed by "..getPlayerName(killer).." and failed the robbery!", source, c.r,c.g,c.b)
			involved:drop(source, "Got killed")
			if is(killer, involved.teams.criminals) then
				local c = colors.criminals
				o("$"..env.crimKillPay.." for killing a cop", killer, c.r,c.g,c.b)
				involved:giveMoney(killer, nil, env.crimKillPay, "Killed Robber")
				if(involved:empty("cops")) then
					involved:moneyMul("criminals", nil, 1+env.crimBankClearBonus)
					involved:send("criminals", nil, "You killed all cops in the bank, here's a 	bonus of "..(env.crimBankClearBonus*100).."%!")
				end
			end
		else
			involved:drop(source, "This drop shouldn't happen, please REPORT!")
		end
	elseif not killer and is(source, involved) then
		if is(source, involved.teams.criminals) then
			if(involved:empty("criminals")) then
				robberyFinish()
				outputDebugString("triggered to stop")
			end
			if (source == env.gotCode) then
				env.gotCode = false
				involved:send("criminals", nil, "The keyholder died, get the code again!")
			end
			involved:drop(source, "Died")
		elseif is(source, involved.teams.cops) then
			if(involved:empty("cops")) then
				robberyFinish()
				outputDebugString("triggered to stop")
			end
			if (source == env.gotCode) then
				env.gotCode = false
				involved:send("criminals", nil, "The keyholder died, get the code again!")
			end
			involved:drop(source, "Died")
		else
			involved:drop(source, "You shouldn't even be here!")
			if(involved:empty("cops")) then
				robberyFinish()
				outputDebugString("triggered to stop")
			end
			if(involved:empty("criminals")) then
				robberyFinish()
				outputDebugString("triggered to stop")
			end
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), handleKills)



function robberyFinish()
	if(not state.crimEscaped) then
		involved:moneyMul("cops", nil, 1+env.copBankClearBonus)
		involved:send("cops", nil, "You successfuly cleared the bank, all robbers are dead! (Payment added "..(env.copBankClearBonus*100).."%)")
	end
	involved:send(nil, nil, "The robbery is over now, thanks for participating!")
	cleanUpEnvironment()
	local timeLeft = getTimerDetails(robbTimer)
	o("The robbery is over, next robbery in "..tostring(math.floor(timeLeft/60000)).. " minutes!", root, 0, 255, 0)
	triggerClientEvent("NGCbr.robberyFinished", getRootElement())
end


letters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
numbers = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}

function generateLetter(upper)
	if (upper) then return letters[math.random(#letters)]:upper() end
	return letters[math.random(#letters)]:upper()
end

function generateNumber()
	return numbers[math.random(#numbers)]
end

function generateString(length)
	if (not length or not tonumber(length)) then length = 12 end
	local result = ""
	for index = 1, math.floor(length) do
		local upper
		if (math.random(2)) == 1 then
			upper = true
		else
			upper = false
		end
		
		if (math.random(2)) == 1 then
			result = result..generateLetter(upper)
		else
			result = result..generateNumber()
		end
	end
	
	return result
end

function bankTimeLeft(plr)
	if (not isTimer(robbTimer)) then return end
	local chkTimer = robbTimer
	if (isTimer(robbStartTimer)) then
		chkTimer = robbStartTimer
	end
	local milliseconds = math.floor(getTimerDetails(chkTimer))
	local minutes = milliseconds / 60000
	local seconds = minutes * 60
	local txt = "Los Santos Bank Robbery gets opened in "
	if(state.opened) then
		txt = "Los Santos Bank Robbery is starting in "
		
	end
	o(txt..math.ceil(minutes).." minutes ("..math.ceil(seconds).." seconds)", plr, 255, 255, 0)
end
addCommandHandler("brtime", bankTimeLeft)

function isInvolved(plr)
	return is(plr, involved.teams)
end