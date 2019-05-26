-- Create teams and set time
addEventHandler ( "onResourceStart", resourceRoot,
	function ()
		setGameType( "CnR/RP/DM" )
		setMapName ( "San Andreas" )
		setOcclusionsEnabled( false )
		local query = exports.DENmysql:query("SELECT * FROM teams ORDER BY list ASC")
		createTeam("Staff",255,255,255)
		for k,v in ipairs(query) do
			if v["name"] ~= "Staff" then
				createTeam(v["name"],v["cR"],v["cG"],v["cB"])
			end
		end

		local realtime = getRealTime()
		setTime( realtime.hour, realtime.minute )
		setMinuteDuration( 60000 )
		setGameSpeed(1.1)
		setWaterColor(25,120,200)
		setSkyGradient( 60, 100, 196, 136, 170, 212 )
		setMoonSize( 0 )
		setServerPassword("") --set the password to nothing if any password is set.
	end
)

addEventHandler("onResourceStop",resourceRoot,
function()
	setServerPassword("proaurora") --set a password so that no one can connect back on while the kicking process continues.
	for k,v in ipairs(getElementsByType("player")) do
		kickPlayer(v,"Source","Source Stopping / Restarting...")
	end
end)

function getCSGServerVersion()
	query = exports.DENmysql:querySingle("SELECT value FROM settings WHERE settingName=?","serverVersion")
	if (query) then
		return query["value"]
	else
		return "2.3.1"
	end
end

addEvent("updatePlayerFPS",true)
addEventHandler("updatePlayerFPS",root,
function(fps)
	if (isElement(source)) and fps then
		setElementData(source,"FPS",fps)
	end
end)

--[[function updatePlayerTeamToElementData()
	for k,v in ipairs(getElementsByType("player")) do
		team = getPlayerTeam(v)
		if (team ~= nil) then
			setElementData(v,"playerTeam",team)
			outputDebugString(getTeamFromName(team))
		end
	end
end
setTimer(updatePlayerTeamToElementData,2000,0)]]--