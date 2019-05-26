local congestionCount = 0
local congestionCount2 = 0
local bandwidthCount = 0
local superBandwidthCount = 0
local isCongested = false
local isCongested2 = false
local isBandwidth = false
local isSuperBandwidth = false
local disabledControls = false

setTimer(function()
	local networkStats = getNetworkStats()
	local ping = getPlayerPing(localPlayer)
	if (networkStats['packetlossLastSecond'] > 15) and (networkStats['messagesInResendBuffer'] > 0) then
		if (isCongested == false) then 
			if (congestionCount == 20) then
				exports.NGCdxmsg:createNewDxMessage("Your network is undergoing a congestion control operation, your full controls are now disabled!",255,0,0)
				exports.AURstickynote:displayText("networklag", "text", "Disabled: Controls | Advise: Try reconnect or restart your modem/internet.", 255, 0, 0)
				toggleAllControls(false)
				disabledControls = true
				isCongested = true
			else
				congestionCount = congestionCount + 1
			end
		end 
	end

	if (networkStats['packetlossLastSecond'] > 5) and (networkStats['messagesInResendBuffer'] > 0) then
		if (isCongested2 == false) then 
			if (congestionCount2 == 20) then
				exports.NGCdxmsg:createNewDxMessage("Your network is undergoing a congestion control operation, your fighting controls are now disabled!",255,0,0)
				exports.AURstickynote:displayText("networklag", "text", "Disabled: Fighting | Advise: Try reconnect or restart your modem/internet.", 255, 0, 0)
				disabledControls = true
				isCongested2 = true
				toggleControl ( "fire", false )
				toggleControl ( "aim_weapon", false )
			else
				exports.NGCdxmsg:createNewDxMessage("It appears that your network is undergoing a congestion control operation, you should take measures to reduce your lag or your gameplay may be affected!",255,255,0)
				exports.AURstickynote:displayText("networklag", "text", "Network Lag Detected. | Advise: Check your network connection.", 255, 0, 0)
				congestionCount2 = congestionCount2 + 1
			end
		end 
	end

	if (getPlayerPing(getLocalPlayer()) > 400) then
		if (isBandwidth == false) then 
			if (bandwidthCount == 20) then
				exports.NGCdxmsg:createNewDxMessage("Your network has over 400 ping. We disable fighting control.",255,0,0)
				exports.AURstickynote:displayText("networklag2", "text", "Disabled: Fighting | Advise: Try reconnect or restart your modem/internet.", 255, 0, 0)
				toggleControl ( "fire", false )
				toggleControl ( "aim_weapon", false )
				disabledControls = true
				isBandwidth = true
			else
				exports.NGCdxmsg:createNewDxMessage("It appears that your network is undergoing a congestion control operation, you should take measures to reduce your lag or your gameplay may be affected!",255,255,0)
				exports.AURstickynote:displayText("networklag2", "text", "Network Lag Detected. | Advise: Check your network connection.", 255, 0, 0)
				bandwidthCount = bandwidthCount + 1
			end
		end 
	end

	if (getPlayerPing(getLocalPlayer()) > 500) then
		if (isSuperBandwidth == false) then 
			if (superBandwidthCount == 20) then
				exports.NGCdxmsg:createNewDxMessage("Your network has over 500 ping. We disable fighting control.",255,0,0)
				exports.AURstickynote:displayText("networklag2", "text", "Disabled: Controls | Advise: Try reconnect or restart your modem/internet.", 255, 0, 0)
				toggleAllControls(false)
				disabledControls = true
				isSuperBandwidth = true
			else
				superBandwidthCount = superBandwidthCount + 1
			end
		end 
	end

	if (disabledControls) then
		if (networkStats['packetlossLastSecond'] < 15) and (isCongested) then
			exports.NGCdxmsg:createNewDxMessage("Your network issue is no longer detected. You can now move.",0,255,0)
			exports.AURstickynote:displayText("networklag", "text", "", 255, 255, 0)
			congestionCount = 0
			isCongested = false
			toggleAllControls(true)
		end
		if (networkStats['packetlossLastSecond'] < 5) and (isCongested) then
			exports.NGCdxmsg:createNewDxMessage("Your network issue is no longer detected. You can now move.",0,255,0)
			exports.AURstickynote:displayText("networklag", "text", "", 255, 255, 0)
			congestionCount2 = 0
			isCongested2 = false
			toggleControl ( "fire", true )
			toggleControl ( "aim_weapon", true )
		end
		if (getPlayerPing(getLocalPlayer()) < 400) and (isBandwidth) then
			exports.NGCdxmsg:createNewDxMessage("Your network issue is no longer detected. You can now fight.",0,255,0)
			exports.AURstickynote:displayText("networklag2", "text", "", 255, 255, 0)
			congestionCount = 0
			isBandwidth = false
			toggleControl ( "fire", true )
			toggleControl ( "aim_weapon", true )
		end
		if (getPlayerPing(getLocalPlayer()) < 500) and (isSuperBandwidth) then
			exports.NGCdxmsg:createNewDxMessage("Your network issue is no longer detected. You can now move.",0,255,0)
			exports.AURstickynote:displayText("networklag2", "text", "", 255, 255, 0)
			congestionCount = 0
			isSuperBandwidth = false
			toggleAllControls(true)
		end
		--[[if (networkStats['isLimitedByOutgoingBandwidthLimit'] == 0) and (isBandwidth) then
			exports.NGCdxmsg:createNewDxMessage("Your outgoing bandwidth limit issue is no longer detected",0,255,0)
			exports.AURstickynote:displayText("networklag", "text", "", 255, 255, 0)
			bandwidthCount = 0
		end]]--
		--[[if (networkStats['isLimitedByCongestionControl'] == 0) and (networkStats['isLimitedByOutgoingBandwidthLimit'] == 0) then
			exports.NGCdxmsg:createNewDxMessage("Your controls are now enabled, enjoy!",0,255,0)
			exports.AURstickynote:displayText("networklag", "text", "", 255, 255, 0)
			toggleAllControls(true)
			disabledControls = false
		end]]--
	end
end, 500, 0)