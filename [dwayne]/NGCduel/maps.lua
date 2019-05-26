mapObjects = {
	["Duel"] = {
		["Objects"] = {
				{ 8957, 2539.6001, 2823, 12.7 },
				{ 8957, 2616.3, 2830.8999, 12.7 },

		},
	},
}
 --




function loadMap(map, dimension)
	if (mapObjects[map]) then
		unloadMap()
		for k, v in ipairs(mapObjects[map]["Objects"]) do
			local obj = createObject(v[1], v[2], v[3], v[4], v[5] or 0, v[6] or 0, v[7] or 0)
			local obj2 = createObject(v[1], v[2], v[3], v[4]+5, v[5] or 0, v[6] or 0, v[7] or 0)
			setElementInterior(obj,0)
			setElementInterior(obj2,0)
			setElementDimension(obj, dimension)
			setElementDimension(obj2, dimension)
		end
	else
		outputChatBox("invalid map contact a developer")
	end
end


function unloadMap()
	for k, v in ipairs(getElementsByType("object", resourceRoot)) do
		if isElement(v) then destroyElement(v) end
	end
end
