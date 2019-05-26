warehouses = {}

elementsCreated = {}

missions = {
	{"Steal cargo", "Easy", "Cargo", 0, 0, 0, 1,
		function(player)
			exports.NGCdxmsg:createNewDxMessage(player, "Mission has been started. Deliver the cargo as possible as you can.",255,255,0)
		end,
		function(business)
			local vehicle = createVehicle(411, 1796.33, -1280.8, 13.63)
			setElementData(vehicle, "AURbusiness_org.owner", business)
			elementsCreated[#elementsCreated+1] = vehicle
		end
	},
}

business_database = {
	--[[{"business name", 
		{
			{"Item Name", "drugs", 300000, "LSW1"},
			{"Item Name", "etc", 300000, "LSW1"},
			{"Item Name", "idk", 300000, "LSW1"},
		},
	}]]--
}
office_database = {
	{"ProBusiness", 255, 255, 0, 1787.28, -1310.37, 109.32, 0, 1787.65, -1309.81, 110., 1773.58, -1302.29, 109.36, 0, 0, 0, 0, 0, 0, 0, 0}
}

function refreshTables ()
	local file1 = fileOpen("warehouses.json")
	local file2 = fileOpen("business_database.json")
	--local file3 = fileOpen("office_database.json")
	warehouses = fromJSON(fileRead(file1, fileGetSize(file1)))
	business_database = fromJSON(fileRead(file2, fileGetSize(file2)))
	--office_database = fromJSON(fileRead(file2, fileGetSize(file3)))
	fileClose(file1) 
	fileClose(file2) 
	--fileClose(file3) 
end 

function onStartRs()
	refreshTables()
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStartRs)

function onStopRs()
	local file1 = fileOpen("warehouses.json")
	local file2 = fileOpen("business_database.json")
	local file3 = fileOpen("office_database.json")
	fileWrite(file1, toJSON(warehouses))
	fileWrite(file2, toJSON(business_database))
	fileWrite(file3, toJSON(office_database))
	fileClose(file1)
	fileClose(file2)
	fileClose(file3)
end 
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)

