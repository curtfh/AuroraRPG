local missionState = {}

function startMission(player, name)
	for i=1, #missions do 
		if (missions[i][1] == name) then 
			if (missionState[getElementData(player, "Business")] == true) then 
				exports.NGCdxmsg:createNewDxMessage(player, "You cannot start a business mission while currently in a business mission.",255,0,0)
				return false
			end 
			if (missions[i][7] <= getMembersOnline(getElementData(player, "Business"))) then 
				triggerFunctionsToAllMembers(getElementData(player, "Business"),i)
				missions[i][9](getElementData(player, "Business"))
			else 
				exports.NGCdxmsg:createNewDxMessage(player, "Not enough players to start a business mission.",255,0,0)
			end 
		end
	end 
end 

function getMembersOnline (name)
	local count = 0
	for index, player in pairs(getElementsByType("player")) do
		if (getElementData(player, "Business") == name) then 
			count = count + 1
		end 
	end 
	return count
end

function triggerFunctionsToAllMembers (name, tableid)
	for index, player in pairs(getElementsByType("player")) do
		if (getElementData(player, "Business") == name) then 
			missions[tableid][8](player)
		end 
	end 
	return true
end 

function getItemsFromBusiness(business) 
	for i=1, #business_database do 
		if (business_database[i][1] == business) then 
			return business_database[i][2]
		end 
	end 
	return false
end 


function addItemToBusinessWarehouse(business, warehouse, item, ttype, originalprice)
	for j=1, #warehouses do 
		if (warehouse == warehouse[j][1]) then 
			for i=1, #business_database do 
				if (business_database[i][1] == business) then 
					business_database[i][2][#business_database[i][2]+1] = {business, {
						{item, ttype, math.floor(originalprice), warehouse},
					}}
					return true
				else	
					business_database[#business_database+1] = {business, {
						{item, ttype, math.floor(originalprice), warehouse},
					}}
					return true
				end 
			end 
			return false 
		end 
	end 
end 

function removeItemFromBusinessWarehouse(business, warehouse, item, ttype)
	for j=1, #warehouses do 
		if (warehouse == warehouse[j][1]) then 
			for i=1, #business_database do 
				if (business_database[i][1] == business) then 
					for z=1, #business_database[i][2] do 
						if (business_database[i][2][j][1] == item) then 
							if (business_database[i][2][j][2] == ttype) then 
								table.remove(business_database[i][2], j)
								return true
							end 
						end 
						return false
					end 
				else	
					return false
				end 
			end 
			return false 
		end 
	end 
end 

function missionAccomplish(player, ttype)
	exports.NGCdxmsg:createNewDxMessage(player, "Mission Accomplished. You successfully finished the mission the "..ttype..".",0,255,0)
end


function missionFailed(player, ttype)
	exports.NGCdxmsg:createNewDxMessage(player, "Mission Failed. You did not successfully finished the mission the "..ttype..".",255,0,0)
end

function destroyElementsInBusinessMission(businessname)
	if (missionState[getElementData(source, "Business")] == true) then 	
		for j=1, #elementsCreated do 
			if (getElementData(elementsCreated[j][1], "AURbusiness_org.owner") == businessname) then 
				destroyElement(elementsCreated[j][1])
			end
		end
	end 
end 

function quitPlayer (quitType)
	if (missionState[getElementData(source, "Business")] == true) then 
		if (getElementData(source,"Business rank") == "President") then 
			for i=1, #missionState do 
				if (missionState[i] == getElementData(source, "Business")) then 
					table.remove(missionState, i)
					destroyElementsInBusinessMission(getElementData(source, "Business"))
				end 
			end 
			exports.NGCdxmsg:createNewDxMessage(source, "Mission Failed. The CEO has left the game.",255,0,0)
		end 
	end 
end
addEventHandler ("onPlayerQuit", getRootElement(), quitPlayer)

function loggedPlayer ()
	if (missionState[getElementData(source, "Business")] == true) then 
		exports.NGCdxmsg:createNewDxMessage(source, "There is on going business mission. You can participate in your business.",255,255,0)
	end 
end 
addEventHandler("onPlayerLogin", getRootElement(), loggedPlayer)