function getPlayers()
	local players = {}
	for k, v in ipairs(getElementsByType("player")) do
		local r,g,b = getPlayerNametagColor(v)
		local country = getElementData(v,"Loc")
		if country then
			country = country:sub(16):lower():gsub(".png","")
		end
		table.insert(players,{getPlayerName(v),getElementData(v,"Rank"),getElementData(v,"sbPS"),getElementData(v,"WL"),getElementData(v,"Money"),getElementData(v,"Play Time"),getElementData(v,"Group"),getElementData(v,"VIP"),getElementData(v,"City"),getElementData(v,"FPS"),getPlayerPing(v),country,r,g,b,exports.server:getPlayerAccountName(v)})
	end
	return players
end

function getPlayersCount()
	local count = getPlayerCount()
	local maxs = getMaxPlayers()
	return count.."/"..maxs
end 

function getServerNamezz()
	return getServerName()
end 

function getPlayerPeak ()
	return exports.CSGpeak:peakFile("load")
end 

SERVER_IP = "127.0.0.1"

function getServerIp()
    return "mtasa://"..SERVER_IP..":"..getServerPort()
end

fetchRemote("http://checkip.dyndns.com/",
    function (response)
        if response ~= "ERROR" then
            SERVER_IP = response:match("<body>Current IP Address: (.-)</body>") or "127.0.0.1"
        end
    end
)

