
function playerData(player,key)
	local data = exports.DENstats:getPlayerAccountData(player,key)
	if data == nil or data == false then
		return 0
	else
		return tonumber(data)
	end
end

setTimer(function()
	for k,v in ipairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			if not getPlayerTeam(v) then
				setPlayerTeam(v,getTeamFromName("Unemployed"))
				setElementData(v,"Occupation","Unemployed")
			end
		end
	end
end,10000,0)

addEvent("setPlayerTeam",true)
addEventHandler("setPlayerTeam",root,function(s)
	--setPlayerTeam(source,getTeamFromName(s) or getTeamFromName("Unemployed"))
end)

addEvent("onPlayerTakeGovernmentJob",true)
addEventHandler("onPlayerTakeGovernmentJob",root,function(occupation,skin,arrest,arrestpoints,turfstaken)
	--[[local playerID = exports.server:getPlayerAccountID( source )
	local acc = exports.server:getPlayerAccountName(source)
	local team = "Government"
	local oldOccupation = getElementData( source, "Occupation" )
	local oldTeam = getPlayerTeam( source )
	setElementData( source, "Occupation", occupation, true )
	setElementData( source, "Rank", occupation, true )
	setPlayerTeam ( source, getTeamFromName( team ) )
	local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", skin, playerID)
	setElementModel ( source, skin )
	exports.NGCdxmsg:createNewDxMessage(source, source, "You successfully changed your job!", 200, 0, 0 )
	exports.DENvehicles:reloadFreeVehicleMarkers( source, true )
	if ( team ~= getTeamName( oldTeam ) ) then
		triggerEvent( "onPlayerTeamChange", source, oldTeam, getTeamFromName( team ) )
	end
	if ( occupation == "Traffic Officer" ) then
		giveWeapon( source, 43, 9999 )
	end
	giveWeapon( source, 3 )
	triggerClientEvent(source,"onPlayerJobChange",source,occupation, oldOccupation, getTeamFromName( team ) )
	triggerEvent( "onPlayerJobChange", source, occupation, oldOccupation, getTeamFromName( team ) )]]
	--for k,v in ipairs(govTable) do arrest,arrestpoints,assists,turfstaken,cnr
	if exports.CSGstaff:isPlayerStaff(source) and exports.CSGstaff:getPlayerAdminLevel(source) >=6 then
		local color = {100,160,255}
		triggerEvent( "onSetPlayerJob",source,"Government",occupation,skin,3, color )
		return false
	end
		if playerData(source,"arrests") >= tonumber(arrest) then
			if playerData(source,"arrestpoints") >= tonumber(arrestpoints) then
		--		if playerData(source,"tazerassists") >= tonumber(assists) then
					if tonumber(playerData(source,"radioTurfsTakenAsCop")) >= tonumber(turfstaken) then
		--				if playerData(source,"armoredtrucks") >= tonumber(cnr) then
							if (getElementData(source, "Group") == "Advanced Assault Forces") then
								local color = {8, 105, 0}
								local qh = exports.DENmysql:query("SELECT * FROM groups_members WHERE memberid=?", exports.server:getPlayerAccountID(source))
								if (#qh > 0) then
									rank = qh.grouprank
								else
									rank = occupation
								end
								triggerEvent( "onSetPlayerJob",source,"Advanced Assault Forces",rank,skin,3, color )
							else
								local color = {100,160,255}
								triggerEvent( "onSetPlayerJob",source,"Government",occupation,skin,3, color )
							end
			--			else
			--				exports.NGCdxmsg:createNewDxMessage(source,"you don't meet the requirements of armored truck escorts!",255,0,0)
		--				end
					else
						exports.NGCdxmsg:createNewDxMessage(source,"you don't meet the requirements of radio turfs taken as cop!",255,0,0)
					end
		--		else
		--			exports.NGCdxmsg:createNewDxMessage(source,"you don't meet the requirements of Tazer assists",255,0,0)
		--		end
			else
				exports.NGCdxmsg:createNewDxMessage(source,"you don't meet the requirements of arrest points",255,0,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"you don't meet the requirements of arrests",255,0,0)
		end
	--end
end)

--addCommandHandler("fixgov",function(p)
--	if getElementData(p,"isPlayerPrime") then
--		local color = {100,160,255}
--		for k,v in ipairs(getElementsByType("player")) do
--			if exports.DENlaw:isLaw(v) then
--				triggerEvent( "onSetPlayerJob",v,"Government","Security Guard",71,3,color )
--			end
--		end
--	end
--end)