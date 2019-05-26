local allowedAccs =  {
	
	["blid1"] = true,
	["joseph"] = true,
	["badboy1"] = true,
}

local boolToText = {
	
	["false"] = "Off",
	["true"] = "On",
}

function toggleAimbot (plr, cmd)

	local accName = exports.server:getPlayerAccountName(plr)
	if (allowedAccs[accName]) then
		setElementData(plr, "aimbot_on", not getElementData(plr, "aimbot_on"))
		exports.NGCdxmsg:createNewDxMessage(plr,"Aimbot is now: "..boolToText[tostring(getElementData(plr, "aimbot_on"))],255,255,255)

	end
end
addCommandHandler("aim", toggleAimbot)