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
	triggerClientEvent(player,"loadShooterMap",player,temp)
end
