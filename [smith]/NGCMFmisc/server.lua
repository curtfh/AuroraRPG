------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGmflift/server (server-side)
--  Mask Script
--  [CSG]Smith
------------------------------------------------------------------------------------

function isPlayerInTeam(src, TeamName)
	if src and isElement ( src ) and getElementType ( src ) == "player" then
		local team = getPlayerTeam(src)
		if team then
			if getTeamName(team) == TeamName then
				return true
			else
				return false
			end
		end
	end
end

the_ped = createPed(49,263.22, 1882.24, -29.35,-90,true)
setElementHealth ( the_ped, 5000 )


createObject ( 16778, 268.9, 1883.91, -35.1, 0, 0, 0 )
a51_lift_ = createObject ( 3095, 268.75, 1884.3095703125, 16.080598831177, 0, 0, 0 )

function a51_lift_down ( thePlayer )
	if( (getElementData(thePlayer,"Group", exports.DENjob:getFirstLaw())) or (isPlayerInTeam(thePlayer, "Staff"))) then
		moveObject ( a51_lift_, 11000, 268.75, 1883.309, -31.84375, 0, 0, 0)
	end
end
addCommandHandler( "down", a51_lift_down )


function a51_lift_up (thePlayer)
	if( (getElementData(thePlayer,"Group", exports.DENjob:getFirstLaw())) or (isPlayerInTeam(thePlayer, "Staff"))) then
		moveObject ( a51_lift_, 11000, 268.75, 1884.309, 16.080598831177, 0, 0, 0)
	end
end
addCommandHandler( "up", a51_lift_up )
