function doChat(msg, t)
	if (t ~= 0) then
		return false
	end
	-- Check if event got cancelled
	if (wasEventCancelled()) then
		return false
	end
	-- Otherwise, all good.
	sendMessageToDiscord("https://discordapp.com/api/webhooks/396033709502889995/29WtsXU-mCcgpg0qY3eoCrn_OFL7Sq1PyLBuZPrHF3EPRuqP8GHEoS3AlEzbAp-27i9g", "**("..exports.server:getPlayChatZone(source	)..")** "..getPlayerName(source)..": "..msg)
end
addEventHandler("onPlayerChat", root, doChat)

local options =
{
    connectionAttempts = 3,
    connectTimeout = 5000,
    formFields = {
    	content = "",
	}
}

function sendMessageToDiscord(webhook, msg)
	--options.formFields.content = msg
	--fetchRemote(webhook, options, callBack)
	return false
end

function callBack()
	-- Do NOTHING
end

function getLastMessageSent(plr)
	if (not exports.CSGstaff:isPlayerStaff(plr)) then
		return false
	end
	-- Send it
	outputChatBox(options.formFields.content)
end
addCommandHandler("discodcheck", getLastMessageSent)