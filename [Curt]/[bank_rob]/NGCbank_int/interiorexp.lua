local interiors_ = {}
local interiorMarkers = {}
local resourceFromInterior = {}
--format interior = { [resource_] = { [id] = { return= { [element],[element] }, entry=[element] } }

addEvent ( "NGCbank_int.doTriggerServerEvents", true )
addEvent ( "NGCbank_int.onPlayerInteriorHit" )
addEvent ( "NGCbank_int.onPlayerInteriorWarped", true )
addEvent ( "NGCbank_int.onInteriorHit" )
addEvent ( "NGCbank_int.onInteriorWarped", true )

addEventHandler ( "onResourceStart", getRootElement(),
function ( resource_ )
	interiorLoadElements ( getResourceRootElement(resource_), resource_ )
	interiorCreateMarkers ( resource_ )
end ) 

addEventHandler ( "onResourceStop", getRootElement(),
function ( resource_ )
	if not interiors_[resource_] then return end
	for id,interiorTable in pairs(interiors_[resource_]) do
		local interior1 = interiorTable["entry"]
		local interior2 = interiorTable["return"]
		destroyElement ( interiorMarkers[interior1] )
		destroyElement ( interiorMarkers[interior2] )
	end
	interiors_[resource_] = nil
end )

function interiorLoadElements ( rootElement, resource_ )
	---Load the exterior markers
	local entryinteriors_ = getElementsByType ( "interiorEntry_", rootElement )
	for key, interior in pairs (entryinteriors_) do
		local id = getElementData ( interior, "id" )
		if not interiors_[resource_] then interiors_[resource_] = {} end
		if not id then outputDebugString ( "interiors_: Error, no ID specified on entryInterior.  Trying to load anyway.", 2 )
		end
		interiors_[resource_][id] = {}
		interiors_[resource_][id]["entry"] = interior
		resourceFromInterior[interior] = resource_
	end
	--Load the interior markers
	local returninteriors_ = getElementsByType ( "interiorReturn_", rootElement )
	for key, interior in pairs (returninteriors_) do
		local id = getElementData ( interior, "refid" )
		if not interiors_[resource_][id] then outputDebugString ( "interiors_: Error, no refid specified to returnInterior.", 1 )
			return
		else
				interiors_[resource_][id]["return"] = interior
				resourceFromInterior[interior] = resource_
		end
	end
end

function interiorCreateMarkers ( resource_ )
	if not interiors_[resource_] then return end
	for interiorID, interiorTypeTable in pairs(interiors_[resource_]) do
		local entryInterior = interiorTypeTable["entry"]
		local entX,entY,entZ = getElementData ( entryInterior, "posX" ),getElementData ( entryInterior, "posY" ),getElementData ( entryInterior, "posZ" )
		entX,entY,entZ = tonumber(entX),tonumber(entY),tonumber(entZ)
		--
		local marker = createMarker ( entX, entY, entZ + 2.2, "arrow", 2, 255, 255, 0, 200 )
		setElementParent ( marker, entryInterior )
		interiorMarkers[entryInterior] = marker
		--
		local dimension = tonumber(getElementData ( entryInterior, "dimension" ))
		local interior = tonumber(getElementData ( entryInterior, "interior" ))
		if not dimension then dimension = 0 end
		if not interior then interior = 0 end
		--
		setElementInterior ( marker, interior )
		setElementDimension ( marker, dimension )
		---create return markers
		local returnInterior = interiorTypeTable["return"]
		local retX,retY,retZ = getElementData ( returnInterior, "posX" ),getElementData ( returnInterior, "posY" ),getElementData ( returnInterior, "posZ" )
		retX,retY,retZ = tonumber(retX),tonumber(retY),tonumber(retZ)		
		--
		local oneway = getElementData ( entryInterior, "oneway" )
		if oneway == "true" then return end
		local marker1 = createMarker ( retX, retY, retZ + 2.2, "arrow", 2, 255, 255, 0, 200 )
		interiorMarkers[returnInterior] = marker1
		setElementParent ( marker1, returnInterior )
		--
		local dimension1 = tonumber(getElementData ( returnInterior, "dimension" ))
		local interior1 = tonumber(getElementData ( returnInterior, "interior" ))
		if not dimension1 then dimension1 = 0 end
		if not interior1 then interior1 = 0 end
		--
		setElementInterior ( marker1, interior1 )
		setElementDimension ( marker1, dimension1 )
	end
end

function getInteriorMarker ( elementInterior_ )
	if not isElement ( elementInterior_ ) then outputDebugString("getInteriorName: Invalid variable specified as interior.  Element expected, got "..type(elementInterior_)..".",0,255,128,0) return false end
	local elemType = getElementType ( elementInterior_ )
	if elemType == "interiorEntry_" or elemType == "interiorReturn_" then
		return interiorMarkers[elementInterior_] or false
	end
	outputDebugString("getInteriorName: Bad element specified.  Interior expected, got "..elemType..".",0,255,128,0)
	return false
end

local opposite = { ["interiorReturn_"] = "entry",["interiorEntry_"] = "return" }
local idLoc = { ["interiorReturn_"] = "refid",["interiorEntry_"] = "id" }
addEventHandler ( "NGCbank_int.doTriggerServerEvents",getRootElement(),
	function( interior, resource_, id )
		local eventCanceled1,eventCanceled2 = false,false
		eventCanceled1 = triggerEvent ( "NGCbank_int.onPlayerInteriorHit", source, interior, resource_, id )
		eventCanceled2 = triggerEvent ( "NGCbank_int.onInteriorHit", interior, source )
		if ( eventCanceled2 ) and ( eventCanceled1 ) then
			triggerClientEvent ( source, "NGCbank_int.doWarpPlayerToInterior", source, interior, resource_, id )
			setTimer ( setPlayerInsideInterior, 1000, 1, source, interior, resource_, id )
		end
	end
)

local opposite = { ["interiorReturn_"] = "entry",["interiorEntry_"] = "return" }
function setPlayerInsideInterior ( player, interior, resource_, id )
	local oppositeType = opposite[getElementType(interior)]
	local targetInterior = interiors_[getResourceFromName(resource_) or getThisresource()][id][oppositeType]
	local dim = getElementData ( targetInterior, "dimension" )
	local int = getElementData ( targetInterior, "interior" )
	if (isElement(player)) then
		setElementInterior ( player, int )
		setElementDimension ( player, dim )
	end
end

function getInteriorName ( interior )
	if not isElement ( interior ) then outputDebugString("getInteriorName: Invalid variable specified as interior.  Element expected, got "..type(interior)..".",0,255,128,0) return false end
	local elemType = getElementType ( interior )
	if elemType == "interiorEntry_" then
		return getElementData ( interior, "id" )
	elseif elemType == "interiorReturn_" then
		return getElementData ( interior, "refid" )
	else
		outputDebugString("getInteriorName: Bad element specified.  Interior expected, got "..elemType..".",0,255,128,0)
		return false
	end
end



