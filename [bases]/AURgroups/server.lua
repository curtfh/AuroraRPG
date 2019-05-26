

---- Official groups  DONT forget to update client.lua to be like this table teams = {


local teams = {
	{"Advanced Assault Forces","Advanced Assault Forces",100,160,255,"law",  214.54, 1861,13.14},
	-- {"SWAT Team","Government",38,96,190,"law", -319.28, 1542.54,75.59},
	--{"SSG","Government",0,50,100,"law",  3147.42, -1037.18, 14.53},
	--{"SSG","Government",0,50,100,"law",  3147.42, -1037.18, 14.53},
	--{"SSG","Government",100,160,255,"law",  -381.5, 1589.52, 79.79, 134.73559570313},
	--{"Delta Force","Government",100,160,255,"law",  2003.46, -758.2, 138.44, 110},
	--{"The Exorcist","Criminals",255,0,0,"crim",  2672.08, 540.46, 27.63, 87.146057128906},
	--{"CSI","Government",128,128,128,"law",  -3004.98,-126.68,2.74,87},
	--{"HolyCrap","HolyCrap",255,0,0,"crim",  2817.2, 1837.9, 14.61, 0},
	--{"Kilo Tray Crips","Criminals", 128, 0, 128,"crim",  1903.4, 570.25, 14.45, 270},
	--{"Special PoliceForce","Government",40,0,80,"law",  3097.59, -784.99, 16.18, 0},
	--{"DreamChacers","Criminals", 255, 0, 0,"crim",  1875.94, 509.53, 23.4, 360},
	{"The Terrorists","Criminals", 255, 0, 0,"crim",  2571.42, 492.7, 14.1, 360},
	{"The Cobras","Criminals", 255, 0, 0,"crim",  914.53, 1445.55, 23.2, 182},
	--{"Federal Bureau Of Investigations","Government", 0,118,240,"law",  2914.55, -278.87, 8.9, 155},
	--{"GIGN","Government",100,160,255,"law",  62.5, 333, 8.6999998092651, 150},
}


---Respawn from client.lua

--------------- DONT TOUCH
function getGroups()
	local official = {}
	for k,v in ipairs(teams) do
		if v then
			table.insert(official,v[1])
		end
	end
	return official
end




function getGroupColor(group)
	for k,v in ipairs(teams) do
		if v[1] == group then
			return v[3],v[4],v[5]
		end
	end
end

function getGroupSpawn(group)
	for k,v in ipairs(teams) do
		if v[1] == group then
			return v[7],v[8],v[9],v[10]
		end
	end
end


function isGroup(p,group,types)
	if getPlayerTeam(p) then
		for k,v in ipairs(teams) do
			if types == "law" and v[6] == "law" and v[1] == group and getTeamName(getPlayerTeam(p)) == v[2] then
				return true
			elseif types == "crim" and v[6] == "crim" and v[1] == group and getTeamName(getPlayerTeam(p)) == v[2] then
				return true
			end
		end
	else
		return false
	end
	return false
end

