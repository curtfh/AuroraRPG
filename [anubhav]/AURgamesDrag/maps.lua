
local deleteTable = {}
local deleteTable2 = {}
function loaDragap(map,dim,player)
	local temp = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "object" then
			temp[#temp+1] = {attributes.model, attributes.posX, attributes.posY, attributes.posZ, attributes.rotX, attributes.rotY, attributes.rotZ}
		end
	end
	xmlUnloadFile(theMapFile)
	loadVehicles(map,player)
	triggerClientEvent(player,"loadDragMap",player,temp,map)
end


function loadVehicles(map,player)
	local temp3 = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "vehicle" then
			temp3[#temp3+1] = {attributes.model, attributes.posX, attributes.posY, attributes.posZ, attributes.rotX, attributes.rotY, attributes.rotZ} ---rotX="0" rotY="0" rotZ
		end
	end
	xmlUnloadFile(theMapFile)
	triggerClientEvent(player,"loadDragMapVehicles",player,temp3,map)
end
