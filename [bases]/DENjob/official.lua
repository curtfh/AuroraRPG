

local teams = {
	--{"Military Forces",0,110,0},
	--{"GIGN",0,0,100},
}


function getGroups()
	local official = {}
	for k,v in ipairs(teams) do
		if v then
			table.insert(official,v[1])
		end
	end
	return official
end



function getFirstLaw()
	return "Military Forces" or "GIGN"
end



function getFirstLawColor()
	for k,v in ipairs(teams) do
		if v[1] == "Military Forces" then
			return v[2],v[3],v[4]
		elseif v[1] == "GIGN" then
			return v[2],v[3],v[4]
		end
	end
end


function isFirstLaw(p)
	if getPlayerTeam(p) then
		if getTeamName(getPlayerTeam(p)) == "Military Forces" then
			return true
		else
			return false
		end
	else
		return false
	end
end
