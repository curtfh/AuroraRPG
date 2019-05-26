
---- Official groups  DONT forget to update server.lua to be like this table teams = {
local teams = {
	-- Groupname, Teamname, r,g,b,side,respawnX,respawnY,respawnZ,rot		
	{"Advanced Assault Forces","Government",100,160,255,"law",  214.54, 1861,13.14, 360},
	--{"Delta Force","Government",100,160,255,"law",  2003.46, -758.2, 138.44, 110},
	--{"The Exorcist","Criminals",255,0,0,"crim",  2672.08, 540.46, 27.63, 87.146057128906},
	--{"HolyCrap","HolyCrap",255,0,0,"crim",  2817.2, 1837.9, 14.61, 0}, 
	--{"Special PoliceForce","Government",100,160,255,"law",  3084.75, -3.98, 21.53, 90},
	--{"CSI","Government",100,160,255,"law",  -3004.98,-126.68,2.74,87},
	--{"Criminal Organization","Criminals", 255,0,0,"crim",  2574.21,489.39,14.1,94},
	--{"Kilo Tray Crips","Criminals", 255, 0, 0,"crim",  1904.18, 569.8, 14.45, 270},
	--{"Pinoy Pride","Criminals", 255, 0, 0,"crim",  867.99, 2071.32, 19.25, 0},
	--{"DreamChacers","Criminals", 255, 0, 0,"crim",  1875.94, 509.53, 23.4, 360},
	{"The Terrorists","Criminals", 255, 0, 0,"crim",  2571.42, 492.7, 14.1, 360},
	{"The Cobras","Criminals", 255, 0, 0,"crim",  914.53, 1445.55, 23.2, 182},
	--{"Federal Bureau Of Investigations","Government", 0,118,240,"law",  2914.55, -278.87, 8.9, 155},
	--{"GIGN","Government",100,160,255,"law",  62.5, 333, 8.6999998092651, 150},
}


----------- You can add spawn like Suicide Squad or MF 

addEvent("setGroupSpawn",true)
addEventHandler("setGroupSpawn",root,function()
	local tm = getTeamName(getPlayerTeam(localPlayer))
	local oc = getElementData(localPlayer,"Group")
	local msg = "You have been taken to "..oc.." Base"

	if oc == "Military Forces" then
		triggerServerEvent("spawnBasePlayer",localPlayer,214.54, 1861,13.14,90,msg)
	end
	if oc == "SWAT Team" then
		triggerServerEvent("spawnBasePlayer",localPlayer,-319.28,1542.54,75.59,86,msg)
	end
	if isGroup(localPlayer,oc,"law") or isGroup(localPlayer,oc,"crim") then
		local x,y,z,rot = getGroupSpawn(oc)
		if x == nil then return false end
		triggerServerEvent("spawnBasePlayer",localPlayer,x,y,z,rot,msg)
		triggerEvent("AURpremium:no_base", localPlayer, localPlayer, "done")
	else
		triggerEvent("AURpremium:no_base", localPlayer, localPlayer, "none")
	end
end)


----------- DONT TOUCH
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

