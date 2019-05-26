local objects = {}

local vehicleList = {
[541]={-0.4,0,0.65},
[402]={-0.4,-0.4,0.8},
[560]={-0.4,0,0.85},
[426]={-0.4,0,0.88},
[421]={-0.4,0,0.74},
[415]={-0.4,-0.2,0.64},
[579]={-0.55,0,1.25},
[528]={-0.65,0,1.1},
[470]={-0.65,0,1.15},
[405]={-0.4,0,0.76},
[559]={-0.4,-0.2,0.76},
[490]={-0.55,0.5,1.12},
[551]={-0.4,-0.1,0.90},
[526]={-0.4,-0.1,0.76},
}

addEvent("setCustomSiren",true)
addEventHandler("setCustomSiren",root,function(vehicle,id)
	if vehicle and isElement(vehicle) then
		if objects[vehicle] and isElement(objects[vehicle]) then
			if isElement(objects[vehicle]) then destroyElement(objects[vehicle]) end
			objects[vehicle] = nil
			removeVehicleSirens(vehicle)
			return false
		end
		local x,y,z = getElementPosition(vehicle)
		objects[vehicle] = createObject(1672,x,y,z-10)
		attachElements(objects[vehicle], vehicle, unpack(vehicleList[id]))
		addVehicleSirens(vehicle,1,3)
		setVehicleSirensOn(vehicle, true)
	end
end)


function deleteFreeVehicleWhenExploded()
	if source and isElement(source) then
		if objects[source] then
			if objects[source] then
				if isElement(objects[source]) then destroyElement(objects[source]) end
			end
			objects[source] = nil
		end
	end
end
addEventHandler("onVehicleExplode", getRootElement(), deleteFreeVehicleWhenExploded)

addEventHandler("onElementDestroy", getRootElement(), function ()
	if source and isElement(source) and getElementType(source) == "vehicle" then
		if objects[source] then
			if objects[source] then
				if isElement(objects[source]) then destroyElement(objects[source]) end
			end
			objects[source] = nil
		end
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if objects[source] then
		if isElement(objects[source]) then destroyElement(objects[source]) end
	end
	objects[source] = nil
end)

addEventHandler("onPlayerJailed",root,function()
	if objects[source] then
		if isElement(objects[source]) then destroyElement(objects[source]) end
	end
	objects[source] = nil
end)

addEventHandler("onPlayerQuit",root,function()
	if objects[source] then
		if isElement(objects[source]) then destroyElement(objects[source]) end
	end
	objects[source] = nil
end)
