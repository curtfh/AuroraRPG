--
-- Author: Ab-47; State: Complete.
-- Additional Notes; N/A; Rights: All Rights Reserved by Developers and Ab-47.
-- Project: NGCaghost/server.lua consisting of 2 files.
--

local accounts = {
	["vadimekk"] = true,
	["-deadmau5-"] = true,
	["dioxide"] = true,
	["sonny"] = true,
	["ab-47"] = true,
}

local ghostmode = {}
local timer = {
	one = {},
	two = {},
}

function setPlayerGhosted(plr, exception)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (exports.server:isPlayerLoggedIn(plr)) then
			local nam = exports.server:getPlayerAccountName(plr)
			--if accounts[nam] ~= nil then
				if (isPedOnGround(plr)) then
					if (not exception) then
						if (getPlayerMoney(plr) <= 50000) then
							exports.NGCdxmsg:createNewDxMessage("You cannot afford to purchase ghost mode!", plr, 255, 0, 0)
							return false
						end
						--outputChatBox("...", plr)
					end
					local accid = exports.server:getPlayerAccountID(plr)
					if (not ghostmode[accid]) then
						if (isTimer(timer.one[accid])) then return end
						if (isTimer(timer.two[accid])) then
							exports.NGCdxmsg:createNewDxMessage("You cannot use ghost mode within 5 minutes of first using it!", plr, 255, 0, 0)
							return false
						end
						if (not exception) then
							takePlayerMoney(plr, 50000)
						end
						ghost_mode(plr, "true")
						exports.NGCnote:addNote("Ghostmode Bought", "You have used ghost mode you'll be off the radar for 60 seconds!", plr, 0, 255, 0)
						timer.one[accid] = setTimer(
							function()
								ghost_mode(plr, "false")
							end
						,60000, 1)
						timer.two[accid] = setTimer(function() ghost_mode(plr, "false") end, 60000*5, 1)
					else
						exports.NGCdxmsg:createNewDxMessage("You've already used ghost mode please wait!", plr, 255, 0, 0)
						return false
					end
				else
					exports.NGCdxmsg:createNewDxMessage("Your can only use this feature whilst you're on the ground!", plr, 255, 0, 0)
					return false
				end
			--end
		end
	end
end

function setGhosted(plr)
	--if (plr) then outputChatBox("Due to an exploitable bug, this feature is disabled unfortunately until further notice!", plr, 255, 0, 0) return end
	setPlayerGhosted(plr, false)
end
addCommandHandler("ghostmode", setGhosted)

function ghost_mode(plr, string)
	if (plr and string) then
		local accid = exports.server:getPlayerAccountID(plr)
		if (string == "false") then
			if (ghostmode[accid]) then
				ghostmode[accid] = nil
				--triggerClientEvent(root, "NGCaghost.init_blips", root, plr, "enable")
				setElementData(plr, "NGCaghost.isPlayerInGhostMode", false)
				exports.NGCdxmsg:createNewDxMessage("Your ghost mode has worn off!", plr, 255, 0, 0)
				if (getElementAlpha(plr) ~= 255) then
					setElementAlpha(plr, 255)
					--setPlayerNametagShowing ( thePlayer, true )
				end
				if (isTimer(timer.one[accid]))then killTimer(timer.one[accid]) end
			end
		elseif (string == "true") then
			if (not ghostmode[accid]) then
				ghostmode[accid] = true
				--triggerClientEvent(root, "NGCaghost.init_blips", root, plr, "disable")
				setElementAlpha(plr, 110)
				--setPlayerNametagShowing(plr, false)
				setElementData(plr, "NGCaghost.isPlayerInGhostMode", true)
			end
		end
	end
end

function isPlayerInGhostMode(plr)
	if (plr and isElement(plr)) then
		local accid = exports.server:getPlayerAccountID(plr)
		if (ghostmode[accid]) then
			return true
		else
			return false
		end
	end
end

addEventHandler("onPlayerSpawn",root,function()
	if isPlayerInGhostMode(source) then
		ghost_mode(source, "true")
	end
end)
