local DEFAULT_ZONE_INFO = "This zone has no information which either means it was is for sale or the owner hasn't edited the zone information yet."

function addZoneToDatabase( x, y, z, size, owner, color, id)
	local positionData = x..","..y..","..z
	local owner = owner
	local color = color
	local account =  "zone"..id
	setZoneData(account, "pos", positionData)
	setZoneData(account, "size", size)
	setZoneData(account, "owner", owner)
	setZoneData(account, "color", color)
end
addEvent( "AURrealestate.addZoneToDatabase", true)
addEventHandler( "AURrealestate.addZoneToDatabase", resourceRoot, addZoneToDatabase)

function purchaseZone(player, id, accountName)
	local account =  "zone"..id
	if (getZoneData(account, "cost")) then 
		if (tonumber(getZoneData(account, "cost")) <= getPlayerMoney(player))viewZoneNotice then 
		exports.NGCdxmsg:createNewDxMessage(player, exports.AURlanguage:getTranslate("Successfully purchased this zone!", true, client), 0, 255, 0)
		setZoneData(account, "owner", accountName)
		triggerClientEvent( root, "AURrealestate.updateZoneDataToClient", resourceRoot, "")
	end 
end
addEvent( "AURrealestate.purchaseZone", true)
addEventHandler( "AURrealestate.purchaseZone", resourceRoot, purchaseZone)


function buildZone( element)
	for name, category in pairs (builderdata) do
		if name ~= "Console" then
			if not getZoneData( name, "cost") then
				setZoneData( name, "cost", 750000)
			end
			if not getZoneData( name, "objects") then
				setZoneData( name, "objects", "")
			end
			if not getZoneData( name, "shownname") then
				setZoneData( name, "shownname", "Unowned Zone")
			elseif getZoneData( name, "shownname") == "Unowned Zone" then
				setZoneData( name, "shownname", "Un-named Zone")
			end
			if not getZoneData( name, "description") then
				setZoneData( name, "description", DEFAULT_ZONE_INFO)
			end

			local pos = getZoneData( name, "pos")
			local size = getZoneData( name, "size")
			local owner = getZoneData( name, "owner")
			local color = getZoneData( name, "color")
			local price = getZoneData( name, "cost")
			local objects = getZoneData( name, "objects")
			local description = getZoneData( name, "description")
			local zonename = getZoneData( name, "shownname")
			--local id = #category
			local id = getZoneData( name, "id")
			triggerClientEvent( element, "AURrealestate.pushZoneDataToClient", resourceRoot, pos, size, owner, color, id, price, zonename, name, description)
			if objects ~= "" then
				triggerClientEvent( element, "AURrealestate.pushObjectsToClient", resourceRoot, objects.."@"..name)
			end
		end
	end
end
addEvent( "AURrealestate.buildZone", true)
addEventHandler( "AURrealestate.buildZone", resourceRoot, buildZone)

addEventHandler( "onServerPlayerLogin", root,
	function()
		buildZone(source)
	end
)

falsePositive = {
	[false] = true,
	["false"] = true,
}

local editmode = {}

function viewZoneNotice( client, id, text, r, g, b, name)
	--local account = getPlayerAccount( client)
	local accName = exports.server:getPlayerAccountName(client)
	local zoneOwner = getZoneData( name, "owner")
	exports.NGCdxmsg:createNewDxMessage(client, exports.AURlanguage:getTranslate(text, true, client),r,g,b)
	if name and not falsePositive[zoneOwner] then
		if string.match( accName, zoneOwner) then
			if not editmode[client] then
				editmode[client] = true
				--triggerClientEvent( client, "AURrealestate.toggleEditorMode", resourceRoot, true)
				setTimer( triggerClientEvent, 100, 1, client, "AURrealestate.toggleEditorMode", client, true)
			else
				editmode[client] = false
				triggerClientEvent( client, "AURrealestate.toggleEditorMode", client, false)
			end
		end
	end
end
addEvent( "AURrealestate.viewZoneNotice", true)
addEventHandler( "AURrealestate.viewZoneNotice", root, viewZoneNotice)

function data( option, entity, datas)
	triggerClientEvent( root, "AURrealestate.data", root, option, entity, datas)
end
addEvent( "AURrealestate.data", true)
addEventHandler( "AURrealestate.data", root, data)
