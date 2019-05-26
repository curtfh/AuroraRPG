addEventHandler("onPlayerMute", root,
    function (state)
        if state == nil then
            return
        end

        if state then
            send("player.mute", { player = getPlayerName(source) })
        else
            send("player.unmute", { player = getPlayerName(source) })
        end
    end
)

addEventHandler("onResourceStart",root,
	function (resource)
		if getResourceInfo(resource,"type") ~= "map" then
			send("chat.message.text", { author = "Resource Status", text = getResourceName(resource).." started!" })
		end
	end
)

addEventHandler("onResourceStop",root,
	function (resource)
		if getResourceInfo(resource,"type") ~= "map" then
			send("chat.message.text", { author = "Resource Status", text = (getResourceName(resource) or "?").." stopped!" })
		end
	end
)

addEventHandler("onPlayerJoin", root,
    function ()
        send("player.join", { player = getPlayerName(source) })
    end
)

addEventHandler("onPlayerQuit", root,
    function (quitType, reason, responsible)
        local playerName = getPlayerName(source)
        
        if isElement(responsible) then
            if getElementType(responsible) == "player" then
                responsible = getPlayerName(responsible)
            else
                responsible = "Console"
            end
        else
            responsible = false
        end

        if type(reason) ~= "string" or reason == "" then
            reason = false
        end
        
        if quitType == "Kicked" and responsible then
            send("player.kick", { player = playerName, responsible = responsible, reason = reason })
        elseif quitType == "Banned" and responsible then
            send("player.ban", { player = playerName, responsible = responsible, reason = reason })
        else
            send("player.quit", { player = playerName, type = quitType, reason = reason })
        end
    end
)

addEventHandler("onPlayerChangeNick", root,
    function (previous, nick)
        send("player.nickchange", { player = nick:monochrome(), previous = previous:monochrome() })
    end
)

