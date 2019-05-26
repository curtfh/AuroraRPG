
addEvent("NGCbr.gotCode", true)
addEvent("NGCbr.gotCodeOnce", true)
addEvent("NGCbr.involvedAdded", true)
addEvent("NGCbr.payed", true)
addEvent("NGCbr.moneyChanged", true)
addEvent("NGCbr.robberyFinished", true)
addEvent("NGCbr.copDoorOpen", true)
addEvent("NGCbr.warpProtect", true)

local sx, sy = guiGetScreenSize()
local moneyDisplay = {
	pos = {
		l = 0.634027*sx,
		t = 0.913333*sy,
		r = 0.984722*sx,
		b = 0.952222*sy,
	},
	prefix = "BR money: ",
	amount = 0,
	amountShown = 0,
	amountTimer = false,
	yettoshow = 0,
	shown = false,
	flashCount = 10,
	flashRate = 300,
	color = tocolor(49, 179, 3, 255),
	zeroes = "00000000"
}

function payed()
	moneyDisplay.shown = false
	removeEventHandler("onClientRender", root, drawMoneyDisplay)
	cleanUpEnvironment()
	if (progressBar) then
		local cur = guiProgressBarGetProgress(progressBar)
		if (cur >= 1) then
			guiProgressBarSetProgress(progressBar, 0)
		end
	end
end
addEventHandler("NGCbr.payed", localPlayer, payed)
addEventHandler("NGCbr.robberyFinished", localPlayer, payed)

function moneyChanged(newamount)
	if (isTimer(moneyDisplay.amountTimer)) then killTimer(moneyDisplay.amountTimer) end
	moneyDisplay.amount = newamount
	moneyDisplay.yettoshow = newamount - moneyDisplay.amountShown
	local rate = math.floor(moneyDisplay.yettoshow/60)
	moneyDisplay.amountTimer = setTimer(function() moneyUpdate(60, rate) end, 50, 1)
end
addEventHandler("NGCbr.moneyChanged", localPlayer, moneyChanged)

function moneyUpdate(countdown, amount)
	if(countdown == 1) then
		if(moneyDisplay.amountTimer) then killTimer(moneyDisplay.amountTimer) end
		moneyDisplay.amountShown = moneyDisplay.amount
		moneyZeros()
		return
	end
	moneyDisplay.amountShown = moneyDisplay.amountShown+amount
	moneyZeros()
	moneyDisplay.amountTimer = setTimer(function() moneyUpdate(countdown-1, amount) end, 50, 1)
end

function moneyZeros()
	local i = 10000000
	moneyDisplay.zeroes = ""
	while i>1 do
		if(i > moneyDisplay.amountShown) then
			moneyDisplay.zeroes = moneyDisplay.zeroes.."0"
			i = i * 0.1
		else
			break
		end
	end
end

function involvedAdded(team)
	addEventHandler("onClientRender", root, drawMoneyDisplay)
	flashAndShow(moneyDisplay.flashCount)
end
addEventHandler("NGCbr.involvedAdded", localPlayer, involvedAdded)

function flashAndShow(countdown)
	if countdown == 1 then
		moneyDisplay.shown = true
	else
		moneyDisplay.shown = not moneyDisplay.shown
		setTimer(function() flashAndShow(countdown-1) end, moneyDisplay.flashRate, 1)
	end
end

function drawMoneyDisplay()
	if not moneyDisplay.shown then return end
	dxDrawText(moneyDisplay.prefix.."$ "..moneyDisplay.zeroes..moneyDisplay.amountShown, moneyDisplay.pos.l,moneyDisplay.pos.t,moneyDisplay.pos.r,moneyDisplay.pos.b, moneyDisplay.color, 1.00, "bankgothic", "left", "top", false, false, true, false, false)
end

env = {
	dim = 15,
	int = 4,
	marker = false,
	code = false,
	hackDelay = 1500,
	warpProtectTime = 3000,
	objects = {
		bellinside = {
			create = function(self)
				local snd = playSound3D("bank_alrm.mp3", 1439.02490, -991.89587, 3153.93286, true)
				setElementDimension(snd, env.dim)
				setElementInterior(snd, env.int)
				setSoundMinDistance ( snd, 1 )
				setSoundMaxDistance ( snd, 400 )
				setSoundVolume (snd , 0.3 )
				self.el =  snd
			end,
			destroy = function(self)
				if(isElement(self.el)) then
					stopSound(self.el)
				end
				self.el = false
			end,
			el = false
		},
		belloutside = {
			create = function(self)
				local snd = playSound3D("bank_alarm.wav", 1467.43798, -1011.45056, 29.73729, true)
				setElementDimension(snd, 0)
				setElementInterior(snd, 0)
				setSoundMinDistance (snd, 10 )
				setSoundMaxDistance ( snd, 100 )
				self.el =  snd
			end,
			destroy = function(self)
				if(isElement(self.el)) then
					stopSound(self.el)
				end
				self.el = false
			end,
			el = false,
		},
		blip_front = {
			create = function(self)
				self.el = createBlip(1466.97790, -1012.0236, 25.84375, 52)
			end,
			destroy = function(self)
				if(isElement(self.el)) then
					destroyElement(self.el)
					self.el = false
				end
			end,
			el = false,
		},
		blip_cop = {
			create = function(self)
				self.el = createBlip(1426.77282, -966.98425, 36.42571)
			end,
			destroy = function(self)
				if(isElement(self.el)) then
					destroyElement(self.el)
					self.el = false
				end
			end,
			el = false,
		}
	}			
}

local state = {
	startedHacking = false,
	hacking = false
}


function initResource()
	d("Init resource")
	_defaults:hold("env", env)
	_defaults:hold("state", state)
	_defaults:hold("moneyDisplay", moneyDisplay)
	createWindows()
	cleanUpEnvironment()
end
addEventHandler("onClientResourceStart", resourceRoot, initResource)

function wProtect()
	cancelEvent()
end

function warpProtect()
	addEventHandler("onClientPlayerDamage", localPlayer, wProtect)
	setTimer(function() removeEventHandler("onClientPlayerDamage", localPlayer, wProtect) end, warpProtectTime or 3000, 1)
end
addEventHandler("NGCbr.warpProtect", localPlayer, warpProtect)

function gotCodeOnce()
	if source then 
		for _, obj in pairs(env.objects) do
			obj:create()
		end
	else
		for _,obj in pairs(env.objects) do
			obj:destroy()
		end
	end
end
addEventHandler("NGCbr.gotCodeOnce", localPlayer, gotCodeOnce)

function createWindows()
	local screenWidth, screenHeight = guiGetScreenSize() 
	windowWidth, windowHeight = 369, 175
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	window = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Bank Valve", false)
	guiSetAlpha(window, 1)
	banlLbl = guiCreateLabel(9, 22, 352, 89, "Enter the code that you were given earlier\nto crack the valve", false, window)
	guiLabelSetColor(banlLbl, 255, 0, 0)
	guiLabelSetHorizontalAlign(banlLbl, "center", false)
	guiSetFont(banlLbl, "clear-normal")
	bankEdit = guiCreateEdit(9, 78, 351, 41, "", false, window)
	hackIt = guiCreateButton(12, 125, 348, 37, "Hack It!", false, window)
	guiSetVisible(window, false)

	windowWidth, windowHeight = 314, 41
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	progressBar = guiCreateProgressBar(windowX, windowY, windowWidth, windowHeight, false)
	guiSetVisible(progressBar, false)
end

function cleanUpHackerStuff()
	if (isElement(env.marker)) then
		destroyElement(env.markerBlip)
		destroyElement(env.marker)
	end
	env.code = false
	guiProgressBarSetProgress(progressBar, 0)
	guiSetVisible(progressBar, false)
	guiSetVisible(window, false)
	showCursor(false)
	setElementFrozen(localPlayer, false)
end

function cleanUpEnvironment()
	cleanUpHackerStuff()
	for _,obj in pairs(env.objects) do
		obj:destroy()
	end
	env = _defaults:get("env")
	state = _defaults:get("state")
	moneyDisplay = _defaults:get("moneyDisplay")
end
addEventHandler("NGCbr.robberyFinished", getRootElement(), cleanUpEnvironment)

function hackValve()
	local code = guiGetText(bankEdit)
	local c = colors.criminals
	if (code ~= env.code) then
		o("The code you entered is wrong, your code is: "..env.code, c.r, c.g, c.b)
		return
	else 
		o("Stay in the marker till the safe is cracked!", c.r,c.g,c.b)
	end
	state.hackingStarted = true
	triggerServerEvent("NGCbr.startedHacking", localPlayer)
	showCursor(false)
	guiSetVisible(window, false)
	guiSetInputMode ( "allow_binds")
	state.hacking = true
	beginSafeHack()
end


function updateProgress()
	local cur = guiProgressBarGetProgress(progressBar)
	local n = cur + 1
	guiProgressBarSetProgress(progressBar, n)
	if (cur >= 100) then
		if (isTimer(env.timer)) then killTimer(env.timer) end
		cleanUpHackerStuff()
		triggerServerEvent("NGCbr.finishedHacking", localPlayer)
	end
end

function beginSafeHack()
	guiSetVisible(progressBar, true)
	env.timer = setTimer(updateProgress, env.hackDelay, 0)
end

function markValve(code)
	env.code = code
	env.marker = createMarker(1395, -980, 3135, "cylinder", 3, 255, 255, 0)
	env.markerBlip = createBlipAttachedTo(env.marker, 0, 1, 0, 255, 0, 255, 0, 65535, localPlayer)
	setElementDimension(env.marker, 15)
	setElementInterior(env.marker, 4)
	addEventHandler("onClientMarkerHit", env.marker, enteredMarker)
	addEventHandler("onClientMarkerLeave", env.marker, leftMarker)
	addEventHandler("onClientGUIClick", hackIt, hackValve, false)
end
addEventHandler("NGCbr.gotCode", localPlayer, markValve)

function enteredMarker(plr)
	if (plr ~= localPlayer) then return end
	if (not state.hackingStarted) then
		guiSetVisible(window, true)
		guiSetInputMode ( "no_binds_when_editing")
		exports.NGCdxmsg:createNewDxMessage("Write the code in the field to begin to crack the safe ("..env.code ..")", 0, 255, 0)
		triggerServerEvent("NGCbr.reachedValve", localPlayer)
		showCursor(true)
	elseif (not state.hacking) then
		state.hacking = true
		beginSafeHack()
	end
end

function leftMarker(plr)
	if(plr ~= localPlayer) then return end
	if (guiGetVisible(window)) then
		guiSetVisible(window, false)
	end
	if (state.hackingStarted == true) then	
		state.hacking = false
		guiSetInputMode ( "allow_binds")
		if (isTimer(env.timer)) then killTimer(env.timer) end
		guiSetVisible(progressBar, false)
		guiProgressBarSetProgress(progressBar, 0)
		showCursor(false)
		local c = colors.criminals
		outputDebugString("triggered to stop by leaving marker")
		o("You left the marker, hacking paused!", c.r,c.g,c.b)
	end
end

function leftMarkerDied(plr)
	if(plr ~= localPlayer) then return end
	if (guiGetVisible(window)) then
		guiSetVisible(window, false)
	end
	if (state.hackingStarted == true) then	
		state.hacking = false
		guiSetInputMode ( "allow_binds")
		if (isTimer(env.timer)) then killTimer(env.timer) end
		guiSetVisible(progressBar, false)
		guiProgressBarSetProgress(progressBar, 0)
		showCursor(false)
		local c = colors.criminals
		outputDebugString("triggered to stop by dieing")
		o("You have died, therefore get nothing, better luck next time!", c.r,c.g,c.b)
	end
end
addEventHandler("onClientPlayerWasted", localPlayer, leftMarkerDied)