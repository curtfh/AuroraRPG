local civilGroupsWork = {}

function detectPlayerWorking ()
	local playertable = getElementsByType("player")
	for i,v in ipairs(playertable) do
		local playersGroup = getElementData(v, "Group")
			if (type(getTeamName(getPlayerTeam(v))) == ""
			if (getTeamName(getPlayerTeam(v)) == "Civilian Workers") then 
				if (type(civilGroupsWork[playersGroup]) == "number") then 
					civilGroupsWork[playersGroup] = civilGroupsWork[playersGroup]+1
					
				else
					civilGroupsWork[playersGroup] = 1
				end
			end
	end
end
detectPlayerWorking()
setTimer(detectPlayerWorking, 600000, 0)