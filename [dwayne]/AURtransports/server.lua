local positions = {
{-1974,118,27,358,302,"San fierro"},
{1734,-1946,13,180,302,"Los Santos"},
{1438,2615,11,177,302,"Las Venturas"},
}

local peds = {}
local markers = {}


function hitMarker(hitElement,dim)
	if hitElement and getElementType(hitElement) == "player" then
		if dim then
			if getElementData(hitElement,"wantedPoints") < 10 then
				local where = getElementData(source,"from?")
				triggerClientEvent(hitElement,"toggleTrainPanel",hitElement,where)
			else
				exports.NGCdxmsg:createNewDxMessage(hitElement,"We're so sorry , we cant take you with us because you're wanted!!",255,0,0)
			end
		end
	end
end

for k,v in ipairs(positions) do
	peds[k] = createPed(v[5],v[1],v[2],v[3])
	setPedRotation(peds[k],v[4])
	setElementFrozen(peds[k],true)
	setElementData(peds[k],"DM",true)
	local marker = createMarker(v[1],v[2],v[3]-0.5,"cylinder",2,255,150,0,100)
	setElementData(marker,"from?",v[6])
	addEventHandler("onMarkerHit",marker,hitMarker)
	table.insert(markers,marker)

end

addEvent("setPositionTrain",true)
addEventHandler("setPositionTrain",root,function(x,y,z,rot)
	setElementPosition(source,x,y,z)
	setPedRotation(source,rot)
	setElementAlpha(source,255)
	exports.NGCdxmsg:createNewDxMessage(source,"You have reached the train station",255,255,0)
end)

addEvent("TrainAccepted",true)
addEventHandler("TrainAccepted",root,function(to)
	takePlayerMoney(source,5000)
	setElementAlpha(source,50)
	if to == "San fierro" then
		triggerClientEvent(source,"TrainLoaded",source,to)
	elseif to == "Las Venturas" then
		triggerClientEvent(source,"TrainLoaded",source,to)
	elseif to == "Los Santos" then
		triggerClientEvent(source,"TrainLoaded",source,to)
	end
end)
