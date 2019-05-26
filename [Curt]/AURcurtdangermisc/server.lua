	function respond (thePlayer, theCommand, theSecondMessage)
local accounthasaccess = "AdminXCurt"
local account = getPlayerAccount(thePlayer)
if (not account or isGuestAccount(account)) then return end
local accountName = getAccountName(account)

	if accountName == accounthasaccess then
		if theSecondMessage == "update" then
			outputChatBox ("#CD96CDConsole: AuroraRPG Server will restarting within 20 seconds.", root, 255, 255, 255, true)
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: AuroraRPG Server will restarting within 10 seconds", root, 255, 255, 255, true)
			end, 10000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: AuroraRPG Server will restarting within 5 seconds", root, 255, 255, 255, true)
			end, 15000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: Restarting in 4", root, 255, 255, 255, true)
			end, 16000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: Restarting in 3", root, 255, 255, 255, true)
			end, 17000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: Restarting in 2", root, 255, 255, 255, true)
			end, 18000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: Restarting 1", root, 255, 255, 255, true)
			end, 19000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: Forcing resource save state.", root, 255, 255, 255, true)
			end, 21000, 1 )
			setTimer ( function()
				outputChatBox ("#CD96CDConsole: Kicking all players", root, 255, 255, 255, true)
				local getPlayers = getElementsByType('player')
				for i, players in ipairs(getPlayers) do
					redirectPlayer(players, "78.108.216.208", 22006)
				end
			end, 22000, 1 )
			setTimer ( function()
			local allResources = getResources()
				for i, resource in ipairs(allResources) do
					if ( getResourceState(resource) == "running" ) and ( resource ~= getThisResource() ) then
						stopResource(resource)
					end
				end
			end, 25000, 1 )
			setTimer ( function()
			shutdown ( "Server Restart, please connect again within 30 seconds." )
			end, 30000, 1 )
		end
	end
end

addCommandHandler ( "restartserver", respond )