
local deleteTable = {}
local deleteTable2 = {}
function loadMap(map,dim,player)
	local temp = {}
	--[[for k, v in ipairs(mapObjects[map]["Objects"]) do
		table.insert(temp,v) --temp = {v[1],v[2],v[3],v[4],v[5],v[6],v[7]}
	end]]--
	
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
	
	triggerClientEvent(player,"loadDDMap",player,temp)
end




