local officeObjectsCreated = {}

function createBusinessOfffice(businessname, r, g, b, outsidex, outsidey, outsidez, spawnx, spawny, spawnz, spawnrot, namex, namey, namez, computerx, computery, computerz, helix, heliy, heliz, helirot, landvehx, landvehy, landvehz, landvehrot)
	for i=1, #office_database do 
		if (office_database[i][1] == businessname) then 
			return false
		else
			office_database[#office_database+1] = {businessname, r, g, b, aassitx, aassity, aassitz, aassitrot, namex, namey, namez, computerx, computery, computerz, helix, heliy, heliz, helirot, landvehx, landvehy, landvehz, landvehrot}
		end 
	end 
end 

function getBuissinessOfficeData (businessname)
	for i=1, #office_database do 
		if (office_database[i][1] == businessname) then 
			return office_database[i]
		else
			return false
		end 
	end 
end 

function isBusinessHasOffice (businessname)
	for i=1, #office_database do 
		if (office_database[i][1] == businessname) then 
			return true
		else 
			return false
		end
	end 
end 

function getDataPermission ()
	setElementData(source, "AURbusiness_org.perms", exports.AURbusiness:aclAllowed(getElementData(source, "Business"), getElementData(source, "Business rank"), "accesspanel"))
end 
addEvent("AURbusiness_org.getDataPermission", true)
addEventHandler("AURbusiness_org.getDataPermission", root, getDataPermission)

function tocolor( r, g, b, a )
   a = tonumber( a ) or 255
	return tonumber( string.format( "0x%X%X%X%X", a, r, g, b ) )
end

function loadOffices ()
	for i=1, #office_database do 
		local assistant_ped = createPed(219, office_database[i][5], office_database[i][6], office_database[i][7], office_database[i][8], false)
		local missionMarker = createMarker (office_database[i][12], office_database[i][13], office_database[i][14]-1, "cylinder", 2, office_database[i][2], office_database[i][3], office_database[i][4], 255)
		setElementData(missionMarker, "AURbusiness_org.type", "mission")
		setElementData(assistant_ped, "AURbusiness_org.type", "ped")
		setElementData(missionMarker, "AURbusiness_org.ownerbusiness", office_database[i][1])
		setElementData(assistant_ped, "AURbusiness_org.ownerbusiness", office_database[i][1])
		setElementFrozen(assistant_ped, true)
		officeObjectsCreated[#officeObjectsCreated+1] = assistant_ped
		officeObjectsCreated[#officeObjectsCreated+1] = missionMarker
		officeObjectsCreated[#officeObjectsCreated+1] = assisMarker
		create3DTextLabel(office_database[i][1], tocolor(office_database[i][2], office_database[i][3], office_database[i][4]), office_database[i][9], office_database[i][10], office_database[i][11], 10, 0, "pricedown", 5, root) 
	end
end 
loadOffices()