local original_ip = {}

local servers = {
	["UK"] = "45.77.90.182",
	["DE"] = "78.108.216.208",
}

local redirectTo = {
	["GB"] = servers["UK"],
}

local networks = {
	["45.77.90.182"] = {true, "UK", "United Kingdom - London", 10},
	["78.108.216.208"] = {false, "DE", "Germany", 0},
}

function onPlayerConnects (playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
	local serial = playerSerial
	local player = getPlayerFromName(playerNick)
	local country = exports.country:getIpCountry(playerIP)
	if (networks[playerIP] and networks[playerIP][1] == true) then 
		if (type(original_ip[serial]) == "string") then 
			setElementData(player, "original_ip", original_ip[serial])
		end 
		return 
	end
	
	if (type(redirectTo[country]) == "string") then 
		redirectPlayer(player, redirectTo[country], 22003)
		original_ip[serial] = playerIP
	end 
end 

addEventHandler ("onPlayerConnect", getRootElement(), onPlayerConnects)

addEventHandler("onServerPlayerLogin", root, function()
	if (networks[getPlayerIP(source)] and networks[getPlayerIP(source)][1] == true) then 
		outputChatBox("Your currently connected at our "..networks[getPlayerIP(source)][3].." ("..networks[getPlayerIP(source)][2]..") Server.", source, 255, 255, 255)
		local serial = getPlayerSerial(source)
		local country = exports.country:getIpCountry(original_ip[serial])
		setElementData(source, "original_ip", original_ip[serial])
		setElementData(source, "serverlocation", networks[getPlayerIP(source)][2])
		setElementData(source, "Country", country)
		setElementData(source, "country", country)
		setElementData(source, "serverlocationdifference", networks[getPlayerIP(source)][4])
		setElementData(source, "Loc", ":country/flags/"..string.lower(country)..".png")
	else
		outputChatBox("Your currently connected at our Germany (DE) Server.", source, 255, 255, 255)
	end
end)