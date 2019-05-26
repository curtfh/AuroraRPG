
local deleteTable = {}
local deleteTable2 = {}
function loaTrialsap(map,dim,player)
	local temp = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "object" then
			temp[#temp+1] = {attributes.model, attributes.posX, attributes.posY, attributes.posZ, attributes.rotX, attributes.rotY, attributes.rotZ, attributes.scale}
		end
	end
	xmlUnloadFile(theMapFile)
	loaTrialsapMarker(map,player)
	triggerClientEvent(player,"loadTrialsMap",player,temp,map)
end

function loaTrialsapMarker(map,player)
	local temp2 = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "corona" or type == "checkpoint" then
			temp2[#temp2+1] = {attributes.type, attributes.posX, attributes.posY, attributes.posZ, attributes.size}
		end
	end
	xmlUnloadFile(theMapFile)
	triggerClientEvent(player,"loadTrialsMapMarker",player,temp2,map)
end

function loaTrialsapVehicles(map,player)
	local temp3 = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "vehicle" then
			temp3[#temp3+1] = {attributes.model, attributes.posX, attributes.posY, attributes.posZ}
		end
	end
	xmlUnloadFile(theMapFile)
	triggerClientEvent(player,"loadTrialsMapVehicles",player,temp3,map)
end
