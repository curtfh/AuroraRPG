--
-- Author: Ab-47; State: Complete.
-- Additional Notes; N/A; Rights: All Rights Reserved by Developers and Ab-47.
-- Project: NGCaghost/client.lua consisting of 2 files.
--

function init_blips(plr, string)
	if (plr) then
		if (string == "enable") then
			exports.DENblips:readdPlayerBlip(plr)
		elseif (string == "disable") then
			exports.DENblips:removePlayerBlip(plr)
		end
	end
end
addEvent("NGCaghost.init_blips", true)
addEventHandler("NGCaghost.init_blips", root, init_blips)

function isPlayerInGhostMode(plr)
	if (plr and isElement(plr)) then
		if (getElementData(plr, "NGCaghost.isPlayerInGhostMode")) then
			return true
		else
			return false
		end
	end
end
