local bans2 = {}

addEvent ( "enterCriminalJob", true )

function setPlayerCriminal ( thePlayer,class )

	local thePlayer = thePlayer or source
	local playerID = exports.server:getPlayerAccountID( thePlayer )

	local oldTeam = getPlayerTeam( thePlayer )

	local oldM = getElementModel(thePlayer)

	local theOccupation = "Criminal"

	local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )

	local acc = exports.server:getPlayerAccountName(thePlayer)

	        for k,v in pairs(bans2) do

            if v[1] == acc then

                if v[2] == "CrimBan" then

                        local mins = getTickCount()-v[3]

                        mins = v[4]-mins

                        mins=mins/1000

                        mins=mins/60

                        mins=math.floor(mins)

                        if mins == 0 then mins = "Less then 1" end

                        exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are currently banned from this job for "..mins.." more Minutes", 200, 0, 0 )

						kickPlayerFromJob(thePlayer)

                        return false

                end

            end

        end



	if ( playerData ) then
		if class == nil then oc = "Criminal"
		else
			oc = class
		end
		setElementData( thePlayer, "Occupation", oc, true )

		setPlayerTeam ( thePlayer, getTeamFromName ( "Criminals" ) )

			local pAccountID = exports.server:getPlayerAccountID(thePlayer)

			setElementModel ( thePlayer, tonumber( playerData.skin ) )

			if ( tonumber( playerData.skin ) == 0 ) then

				local CJCLOTTable = fromJSON( tostring( playerData.cjskin ) )

				if CJCLOTTable then

					for theType, index in pairs( CJCLOTTable ) do

						local texture, model = getClothesByTypeIndex ( theType, index )

						addPedClothes ( thePlayer, texture, model, theType )
					end
				end

			end
			if class == "Thief" or getElementData(thePlayer,"Occupation") == "Thief" then
				setElementModel(thePlayer,68)
			end

			if (class == "The Terrorists") or (getElementData(thePlayer,"Group") == "The Terrorists") then
				setElementModel(thePlayer,230)
				setPlayerNametagColor(thePlayer, 255,255,0)
				rgb = {255,255,0}
			end

		local gr = getElementData(thePlayer,"Group")
		--[[if (gr == "HolyCrap") then
			setPlayerTeam( thePlayer, getTeamFromName ( "HolyCrap" ) )
		end]]--
		if ( getTeamName( oldTeam ) ~= "Criminals" ) then
			--[[if (gr == "HolyCrap") then
				triggerEvent( "onPlayerTeamChange", thePlayer, oldTeam, getTeamFromName ( "HolyCrap" ) )
			else]]--
			--end
			triggerEvent( "onPlayerTeamChange", thePlayer, oldTeam, getTeamFromName ( "Criminals" ) )
		end



		triggerEvent( "onPlayerJobChange", thePlayer, oc, getTeamFromName ( "Criminals" ), rgb or false )

		triggerEvent( "CSGcriminalskills.changed",thePlayer)

		exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )

		exports.NGCdxmsg:createNewDxMessage( thePlayer, "You are now a "..oc, 200, 0, 0 )

		return true

	else

		return false

	end

end

addEventHandler ( "enterCriminalJob", root, setPlayerCriminal )



function givePlayerCJClothes ( thePlayer )

	local playerID = exports.server:getPlayerAccountID( thePlayer )

	local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )

	if ( playerData ) then

		setElementModel ( thePlayer, 0 )



		local CJCLOTTable = fromJSON( tostring( playerData.cjskin ) )

		if CJCLOTTable then

			for theType, index in pairs( CJCLOTTable ) do

				local texture, model = getClothesByTypeIndex ( theType, index )

				addPedClothes ( thePlayer, texture, model, theType )

			end

		end

		return true

	else

		return false

	end

end



function banFromJob(acc,name,mins)

    table.insert(bans2,{acc,name,getTickCount(),mins*1000*60})

end





function kickPlayerFromJob(player)
	local playerID = exports.server:getPlayerAccountID( player )
    local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )

	setElementData(player,"Occupation","Unemployed")
	setPlayerTeam(player,getTeamFromName("Unemployed"))
	exports.DENvehicles:reloadFreeVehicleMarkers(player, true )
	if ( tonumber( playerData.skin ) == 0 ) then
        exports.DENcriminal:givePlayerCJClothes( player )
    else
        setElementModel ( player, tonumber( playerData.skin ) )
    end
end





function unbanFromJob(acc,name)

    for k,v in pairs(bans2) do

        if v[1] == acc and v[2] == name then

            table.remove(bans2,k)

            return true

        end

    end

    return false

end



setTimer(function()

    for k,v in pairs(bans2) do

        if getTickCount() - v[3] > v[4] then

            table.remove(bans2,k)

        end

    end

end,5000,0)

function beCriminal (thePlayer)
	local teamn = getTeamName(getPlayerTeam(thePlayer))
	if getElementDimension(thePlayer) ~= 0 then
		exports.NGCdxmsg:createNewDxMessage("You cannot use this command while your in other dimension.", thePlayer, 255, 0, 0)
		return
	elseif teamn == "Government" then 
		exports.NGCdxmsg:createNewDxMessage("You cannot use this command while your a cop.", thePlayer, 255, 0, 0)
		return
	end
	setPlayerCriminal(thePlayer)
end 
addCommandHandler("criminal", beCriminal)