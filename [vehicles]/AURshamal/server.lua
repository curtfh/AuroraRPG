local seatPassenger = {}
local seatCount = {}
local isValid = {}
addEvent("onPlayerEnterShamal",true)
addEventHandler("onPlayerEnterShamal",root,function(p,v)
	if v and isElement(v) and p and isElement(p) and source and isElement(source) then
		if getElementData(source,"isPlayerInShamal") then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't enter this plane anytime soon",255,0,0)
			return false
		end
		if getElementData(source,"wantedPoints") >= 10 then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't enter this plane you are wanted",255,0,0)
		return false end
		if getElementDimension(source) ~= 0 then return false end
		local id = exports.server:getPlayerAccountID(p)
		if seatCount[id] == nil or seatCount[id] == false then
			seatCount[id] = 0
		end
		if seatCount[id] >= 6 then
			exports.NGCdxmsg:createNewDxMessage(source,"You can't enter this plane no empty seat",255,0,0)
			return false
		end
		if not isValid[v] then
			isValid[v] = true
		end
		onPlayerEnterPlane(source,p,v)
	end
end)

function onPlayerEnterPlane(player,driver,vehicle)
	if vehicle and isElement(vehicle) then
		if getElementData(player,"isPlayerInShamal") then return false end
		setElementData(player,"isPlayerInShamal",true)
		setElementData(player,"shamalDriver",driver)
		local id = exports.server:getPlayerAccountID(driver)
		--local tbl = seatPassenger[vehicle]
		table.insert(seatPassenger,{vehicle,player,driver})
		seatCount[id] = seatCount[id] + 1
		setElementInterior (player, 1, 3.5,23.07,1199.6 )
		setElementDimension(player,id)
		triggerClientEvent(player, "setSpawnRotation", player,90)
		exports.NGCnote:addNote("Seat",getPlayerName(player).." has entered your plane",driver,255,0,0,3000)
	else
		exports.NGCdxmsg:createNewDxMessage(player,"There is no plane near you!",255,0,0)
	end
end

function EjectPassngerOut()
	if isValid[source] then
		local x,y,z = getElementPosition(source)
		for k,v in ipairs(seatPassenger) do
			if v[1] == source then
				setElementInterior(v[2],0)
				setElementDimension(v[2],0)
				setElementPosition(v[2],x,y,z)
				table.remove(seatPassenger,k)
				setElementData(v[2],"isPlayerInShamal",false)
				setElementData(v[2],"shamalDriver",false)
			end
		end
		isValid[source] = false
	end
end
function EjectPassngerOut2(veh)
	if isValid[veh] then
		local x,y,z = getElementPosition(veh)
		for k,v in ipairs(seatPassenger) do
			if v[1] == veh then
				setElementInterior(v[2],0)
				setElementDimension(v[2],0)
				setElementPosition(v[2],x,y,z)
				table.remove(seatPassenger,k)
				setElementData(v[2],"isPlayerInShamal",false)
				setElementData(v[2],"shamalDriver",false)
			end
		end
		isValid[veh] = false
	end
end
addEventHandler( "onVehicleExplode",getRootElement(),EjectPassngerOut )
addEventHandler ( "onVehicleExit",getRootElement(), EjectPassngerOut )
addEventHandler ( "onVehicleStartExit",getRootElement(), EjectPassngerOut )
addEventHandler ( "onPlayerVehicleExit",getRootElement(), EjectPassngerOut2 )

addEventHandler("onElementDestroy",getRootElement(),function()
	if getElementType(source) == "vehicle" then
		if isValid[source] then
			local x,y,z = getElementPosition(source)
			for k,v in ipairs(seatPassenger) do
				if v[1] == source then
					setElementInterior(v[2],0)
					setElementDimension(v[2],0)
					setElementPosition(v[2],x,y,z)
					setElementData(v[2],"isPlayerInShamal",false)
					setElementData(v[2],"shamalDriver",false)
					table.remove(seatPassenger,k)
				end
			end
			isValid[source] = false
		end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if getElementData(source,"isPlayerInShamal") then
		local x,y,z = getElementPosition(source)
		local driver = getElementData(source,"shamalDriver")
		if driver and isElement(driver) then
			x,y,z = getElementPosition(driver)
		else
			for k,v in ipairs(seatPassenger) do
				if v[1] and isElement(v[1]) and v[2] == source then
					x,y,z = getElementPosition(v[1])
				end
			end
		end
		setElementInterior(source,0)
		setElementDimension(source,0)
		setElementPosition(source,x,y,z)
		for k,v in ipairs(seatPassenger) do
			if v[2] == source then
				table.remove(seatPassenger,k)
			end
		end
	end
end)

addCommandHandler("getout",function(player)
	if getElementData(player,"isPlayerInShamal") then
		local driver = getElementData(player,"shamalDriver")
		local x,y,z = getElementPosition(driver)
		setElementInterior(player,0)
		setElementDimension(player,0)
		setElementPosition(player,x,y,z)
		setElementData(player,"isPlayerInShamal",false)
		setElementData(player,"shamalDriver",false)
		for k,v in ipairs(seatPassenger) do
			if v[2] == player then
				table.remove(seatPassenger,k)
			end
		end
	end
end)

addEventHandler("onPlayerWasted",root,function()
	if getElementData(source,"isPlayerInShamal") then
		setElementData(source,"isPlayerInShamal",false)
		setElementData(source,"shamalDriver",false)
		for k,v in ipairs(seatPassenger) do
			if v[2] == source then
				table.remove(seatPassenger,k)
			end
		end
	end
end)



local logData = true

local carChatSpam = {}


function removeHEX( message )

	return string.gsub(message,"#%x%x%x%x%x%x", "")

end

function onPlayerMessageCarChat(player,_,...)

	if ( exports.server:getPlayerAccountName ( player ) ) then

		if not getElementData(player,"isPlayerInShamal") then

			--exports.NGCdxmsg:createNewDxMessage(player, "You're not inside shamal room!", 255, 0, 0)

		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then

			exports.NGCdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)

		elseif ( carChatSpam[player] ) and ( getTickCount()-carChatSpam[player] < 1000 ) then

			exports.NGCdxmsg:createNewDxMessage(player, "You type as fast as an Infernus! Please slow down.", 200, 0, 0)

		else

			carChatSpam[player] = getTickCount()

			local message = table.concat({...}, " ")

			if (triggerEvent("onServerPlayerChat", player, message) == false) then

				return false

			end

			if #message < 1 then

				exports.NGCdxmsg:createNewDxMessage(player, "Enter a message.", 200, 0, 0)

			else

				local nick = getPlayerName(player)

				local driver = getElementData(player,"shamalDriver")

				exports.NGCmusic:captureCommunication("#FF4500(Shamal room) "..(nick)..": #FFFFFF"..( message ).." ",255,69,0)

				for k,v in ipairs(seatPassenger) do
					if v[2] == player then
						outputChatBox("#FF4500(Shamal room) "..(nick)..": #FFFFFF"..(removeHEX( message ) ).." ", v[2], 255,69,0, true)
					end
				end
				outputChatBox("#FF4500(Shamal room) "..(nick)..": #FFFFFF"..(removeHEX( message ) ).." ", driver, 255,69,0, true)

				if logData == true then

					exports.CSGlogging:createLogRow( player, "carchat", message )

				end

			end

		end

    end

end
addCommandHandler( "cc", onPlayerMessageCarChat )

function onPlayerMessageCarChat2(player,_,...)

	if ( exports.server:getPlayerAccountName ( player ) ) then

		if not isPedInVehicle(player) then

			--exports.NGCdxmsg:createNewDxMessage(player, "You're not inside shamal room!", 255, 0, 0)

		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then

			exports.NGCdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)

		elseif ( carChatSpam[player] ) and ( getTickCount()-carChatSpam[player] < 1000 ) then

			exports.NGCdxmsg:createNewDxMessage(player, "You type as fast as an Infernus! Please slow down.", 200, 0, 0)

		else
			if getElementModel(getPedOccupiedVehicle(player)) == 519 then
				carChatSpam[player] = getTickCount()

				local message = table.concat({...}, " ")

				if (triggerEvent("onServerPlayerChat", player, message) == false) then

					return false

				end

				if #message < 1 then

					exports.NGCdxmsg:createNewDxMessage(player, "Enter a message.", 200, 0, 0)

				else
					for k,v in ipairs(seatPassenger) do
						if v[3] == player then
							local nick = getPlayerName(player)
							outputChatBox("#FF4500(Shamal room) "..(nick)..": #FFFFFF"..(removeHEX( message ) ).." ", v[2], 255,69,0, true)
						end

					end
					local nick = getPlayerName(player)

					outputChatBox("#FF4500(Shamal room) "..(nick)..": #FFFFFF"..(removeHEX( message ) ).." ", player, 255,69,0, true)
					exports.NGCmusic:captureCommunication("#FF4500(Shamal room) "..(nick)..": #FFFFFF"..( message ).." ",255,69,0)


					if logData == true then

						exports.CSGlogging:createLogRow( player, "carchat", message )

					end

				end
			end

		end

    end

end
addCommandHandler( "cc", onPlayerMessageCarChat2 )

