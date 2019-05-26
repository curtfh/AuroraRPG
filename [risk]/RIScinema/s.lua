local currentSavedURL
local ACCOUNTS = {["pirate10"] = true, ["paschi"] = true, ["ghost"] = true, ["samer61"] = true}

addEvent("cinema.saveURL",true)

addEventHandler("cinema.saveURL",resourceRoot,function(URL)
	currentSavedURL = URL or "http://aurorarvg.com"
	for _, p in ipairs(getElementsByType("player")) do
		--if (ACCOUNTS[exports.server:getPlayerAccountName(p)]) then
			triggerClientEvent(p,"cinema.sendUrlToPlayer",resourceRoot,currentSavedURL)
		--end
	end
end)