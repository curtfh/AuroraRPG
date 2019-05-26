
local deleteTable = {}
local deleteTable2 = {}
function loadMap(map,dim,player)
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
	loadMapMarker(map,player)
	triggerClientEvent(player,"loadDMMap",player,temp,map)
end

function loadMapMarker(map,player)
	local temp2 = {}
	local theMapFile = xmlLoadFile("maps/"..map..".map")
	local nodes = xmlNodeGetChildren(theMapFile)
	for i,v in ipairs(nodes) do
		local attributes = xmlNodeGetAttributes(v)
		local type = xmlNodeGetName(v)
		if type == "marker" then
			temp2[#temp2+1] = {attributes.type, attributes.posX, attributes.posY, attributes.posZ, attributes.size}
		end
	end
	xmlUnloadFile(theMapFile)
	triggerClientEvent(player,"loadDMMapMarker",player,temp2,map)
end
