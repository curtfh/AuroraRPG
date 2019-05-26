local bans = {}

local teams = {
	--{"Military Forces",0,110,0},
	--{"GIGN",0,110,0},
}


function getGroups()
	local official = {}
	for k,v in ipairs(teams) do
		if v and v[1] then
			table.insert(official,v[1])
		end
	end
	return official
end


function getFirstLaw()
	return "Military Forces"
end


function getFirstLawColor()
	for k,v in ipairs(teams) do
		if v[1] == "Military Forces" then
			return v[2],v[3],v[4]
		elseif v[1] == "GIGN" then
			return v[2],v[3],v[4]
		end
	end
end

function isFirstLaw(p)
	if getPlayerTeam(p) then
		if getTeamName(getPlayerTeam(p)) == "Military Forces" then
			return true
		else
			return false
		end
	else
		return false
	end
end


-- Set player job when he made a choise
setGarageOpen(22,false)

addEventHandler("onServerPlayerLogin",root,function()
	local job = getElementData(source,"Occupation")
	if job == "Code Anonymous" or job == "The Ravage" or job == "HolyCrap" then
		local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", exports.server:getPlayerAccountID(source) )
		if ( playerData ) then
			setElementModel(source,playerData.jobskin)
		end
	end
end)

local allTeams = getElementsByType ( "team" )
	-- for every team,
	for index, theTeam in ipairs(allTeams) do
	-- if friendly fire is off,
		if ( getTeamFriendlyFire ( theTeam ) == false ) then
			-- switch it on
			if getTeamName(theTeam) ~= "Staff" then
				setTeamFriendlyFire ( theTeam, true )
			end

	end
end
addEvent( "onSetPlayerJob", true )
function onSetPlayerJob ( theTeam, theOccupation, theSkin, theWeapon, nrgb )
    local theArrests = exports.DENstats:getPlayerAccountData( source, "arrests" )
    if ( theArrests ) and ( theArrests < 240 ) and ( theOccupation == "Air Support Unit" ) then
        exports.NGCdxmsg:createNewDxMessage( source, exports.AURlanguage:getTranslate("You need 240 or more arrests for this job!", true, source), 200, 0, 0 )
    else
        local playerID = exports.server:getPlayerAccountID( source )
        local acc = exports.server:getPlayerAccountName(source)
        for k,v in pairs(bans) do
            if v[1] == acc then
                if v[2] == "LawBan" then
                    if theTeam == "Government" then
                        local mins = getTickCount()-v[3]
                        mins = v[4]-mins
                        mins=mins/1000
                        mins=mins/60
                        mins=math.floor(mins)
                        if mins == 0 then mins = "Less then 1" end
                        exports.NGCdxmsg:createNewDxMessage( source, string.format(exports.AURlanguage:getTranslate("You are currently banned from this job for %s more minutes", true, source), mins), 200, 0, 0 )
                        return
                    end
                else
                    if v[2] == theOccupation then
                        local mins = getTickCount()-v[3]
                        mins = v[4]-mins
                        mins=mins/1000
                        mins=mins/60
                        mins=math.floor(mins)
                        if mins == 0 then mins = "Less then 1" end
                        exports.NGCdxmsg:createNewDxMessage( source, string.format(exports.AURlanguage:getTranslate("You are currently banned from this job for %s more minutes", true, source), mins), 200, 0, 0 )
                        return
                    end
                end
            end
        end


        local oldOccupation = getElementData( source, "Occupation" )
        local oldTeam = getPlayerTeam( source )
        setPlayerTeam ( source, getTeamFromName( theTeam ) )
        setElementData( source, "Occupation", theOccupation, true )
        setElementData( source, "Rank", theOccupation, true )
        if (nrgb) then
            if (nrgb[1]) then
                setPlayerNametagColor(source,nrgb[1],nrgb[2],nrgb[3])
            else
                setPlayerNametagColor(source,false)
            end

        else
            setPlayerNametagColor(source,false)
        end
        local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", theSkin, playerID)
        setElementModel ( source, theSkin )
        exports.NGCdxmsg:createNewDxMessage( source, exports.AURlanguage:getTranslate("You successfully changed your job!", true, source), 200, 0, 0 )
        exports.DENvehicles:reloadFreeVehicleMarkers( source, true )
        if ( theTeam ~= getTeamName( oldTeam ) ) then
            triggerEvent( "onPlayerTeamChange", source, oldTeam, getTeamFromName( theTeam ) )
        end
        triggerClientEvent(source,"onPlayerJobChange",source,theOccupation, oldOccupation, getTeamFromName( theTeam ) )
        triggerEvent( "onPlayerJobChange", source, theOccupation, oldOccupation, getTeamFromName( theTeam ) )
		if theOccupation == "Criminal" then triggerEvent("enterCriminalJob",source) end
        if ( theWeapon ) then
            giveWeapon( source, tonumber(theWeapon), 9999, true )

            if ( theOccupation == "Traffic Officer" ) then
                giveWeapon( source, 43, 9999 )
            end
        end
		--if theOccupation == "HolyCrap" then
			--setElementModel(source, theSkin)
		--end
		if theOccupation == "Drugs farmer" then
			exports.DENcriminal:setPlayerCriminal(source,"Drugs farmer")
			local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", theSkin, playerID)
			setElementModel ( source, theSkin )
		elseif theOccupation == "Thief" then
			exports.DENcriminal:setPlayerCriminal(source,"Thief")
			local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", theSkin, playerID)
			setElementModel ( source, theSkin )
		end
		--[[if theOccupation == "The Terrorists" then
			setPlayerNametagColor(source,255,215,0)
		end]]
    end
end
addEventHandler( "onSetPlayerJob", root, onSetPlayerJob )
--[[
addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
    if ( getElementData(source,"Occupation") == "Criminal" ) then
        if getElementData(source,"Group") ~= false then
            if getElementData(source,"Group") == "The Smurfs" then
                setPlayerNametagColor(source,139, 0, 139)
end)
--]]
-- Weapon controls
function deleteWhenLeftJob ()
	if getPlayerTeam(source) then
		if (getTeamName(getPlayerTeam(source)) == "Paramedics") or getElementData(source,"skill") == "Support Unit" then

		else
			takeWeapon ( source, 41 )
		end

		local team = getPlayerTeam(source)
		if not (team) then
			return false
		end

		if exports.DENlaw:isPlayerLawEnforcer(source) then
			if getPedWeapon(source,1) ~= 3 then
				giveWeapon(source,3)
			end
		end
		if exports.DENlaw:isPlayerLawEnforcer(source) then

		else
			takeWeapon ( source, 3 )
		end

		if (exports.DENlaw:isPlayerLawEnforcer(source)) or (exports.server:getPlayerOccupation(source) == "News Reporter") then

		else
			takeWeapon(source, 43)
		end
	end
end
addEventHandler( "onPlayerWeaponSwitch", root, deleteWhenLeftJob )

-- Serverside jobmenu
addEvent( "onQuitJob", true )
function onQuitJob (oldJob)
	local theTeam = getPlayerTeam( source )
    local oldOccupation = getElementData( source, "Occupation" )
    local playerID = exports.server:getPlayerAccountID( source )
    local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
    local unemployedTeam = getTeamFromName ( "Unemployed" )

    setPlayerTeam ( source, unemployedTeam )
    setElementData ( source, "Occupation", "Unemployed" )
    triggerClientEvent( source, "updateLabel", source )
    exports.NGCdxmsg:createNewDxMessage(source, string.format(exports.AURlanguage:getTranslate("You have quit your job as %s", true, source), oldJob), 0, 200, 0)
    exports.DENvehicles:reloadFreeVehicleMarkers(source, true)

    if ( tonumber( playerData.skin ) == 0 ) then
        exports.DENcriminal:givePlayerCJClothes( source )
    else
        setElementModel ( source, tonumber( playerData.skin ) )
    end
	local r,g,b = getTeamColor(getTeamFromName("Unemployed"))
	setPlayerNametagColor(source,r,g,b)
    triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unemployedTeam )
    triggerClientEvent(source,"onPlayerJobChange",source,"Unemployed", oldOccupation, unemployedTeam )
    triggerEvent( "onPlayerTeamChange", source, theTeam, unemployedTeam )
end
addEventHandler( "onQuitJob", root, onQuitJob )

-- Serverside jobmenu
addEvent( "onKickJob", true )
function onKickJob (oldJob)
    local theTeam = getPlayerTeam( source )
    local oldOccupation = getElementData( source, "Occupation" )
    local playerID = exports.server:getPlayerAccountID( source )
    local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
    local unemployedTeam = getTeamFromName ( "Unemployed" )

    setPlayerTeam ( source, unemployedTeam )
    setElementData ( source, "Occupation", "Unemployed" )
    triggerClientEvent( source, "updateLabel", source )
    exports.DENvehicles:reloadFreeVehicleMarkers(source, true)

    if ( tonumber( playerData.skin ) == 0 ) then
        exports.DENcriminal:givePlayerCJClothes( source )
    else
        setElementModel ( source, tonumber( playerData.skin ) )
    end
	local r,g,b = getTeamColor(getTeamFromName("Unemployed"))
	setPlayerNametagColor(source,r,g,b)
    triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unemployedTeam )
    triggerClientEvent(source,"onPlayerJobChange",source,"Unemployed", oldOccupation, unemployedTeam )
    triggerEvent( "onPlayerTeamChange", source, theTeam, unemployedTeam )
end
addEventHandler( "onKickJob", root, onKickJob )


function onEndShift ()
	local theTeam = getPlayerTeam( source )
    local oldOccupation = getElementData( source, "Occupation" )
    local playerID = exports.server:getPlayerAccountID( source )
    local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
    local unoccupiedTeam = getTeamFromName ( "Unoccupied" )

    setPlayerTeam ( source, unoccupiedTeam )

    triggerClientEvent( source, "updateLabel", source )
    exports.NGCdxmsg:createNewDxMessage(source, "You have ended your shift!", 0, 200, 0)
    exports.DENvehicles:reloadFreeVehicleMarkers(source, false)

    if ( tonumber( playerData.skin ) == 0 ) then
        exports.DENcriminal:givePlayerCJClothes( source )
    else
        setElementModel ( source, tonumber( playerData.skin ) )
    end
	local r,g,b = getTeamColor(getTeamFromName("Unoccupied"))
	setPlayerNametagColor(source,r,g,b)
    triggerEvent( "onPlayerTeamChange", source, theTeam, unoccupiedTeam  )
    triggerClientEvent(source,"onPlayerJobChange",source,"Unemployed", oldOccupation, unemployedTeam )
    triggerEvent( "onPlayerJobChange", source, "Unemployed", oldOccupation, unoccupiedTeam )
end
addEvent( "onEndShift", true )
addEventHandler( "onEndShift", root, onEndShift )

function onStartShift ( theOccupation )
	local theTeam = getPlayerTeam( source )
    local setTeam = nil
    local playerID = exports.server:getPlayerAccountID( source )
    local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
	local data = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?", playerID )
	if data then
		local theRank = data.lawRank
		if not theRank then theRank = theOccupation end
		if theRank then
			if ( theOccupation == "Paramedic" ) then
				setTeam = getTeamFromName ( "Paramedics" )
				giveWeapon ( source, 41,9000 )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Pilot" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Mechanic" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Trucker" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Bus Driver" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Firefighter" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "News Reporter" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Taxi Driver" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Farmer" ) then
				setTeam = getTeamFromName ( "Civilian Workers" )
				setPlayerTeam ( source, setTeam )
			elseif ( theOccupation == "Lumberjack" ) then
				setTeam = getTeamFromName( "Civilian Workers" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Diver" ) then
				setTeam = getTeamFromName( "Civilian Workers" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Rescuer Man" ) then
				setTeam = getTeamFromName( "Civilian Workers" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Trash Collector" ) then
				setTeam = getTeamFromName( "Civilian Workers" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Miner" ) then
				setTeam = getTeamFromName( "Civilian Workers" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Junior Officer" ) then
				setTeam = getTeamFromName( "Government" )
				setPlayerTeam( source, setTeam )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
			elseif ( theOccupation == "Government" ) then
				setTeam = getTeamFromName( "Government" )
				setPlayerTeam( source, setTeam )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setElementData( source, "skill", theRank)
			elseif ( theOccupation == "Traffic Officer" ) then
				setTeam = getTeamFromName( "Government" )
				setPlayerTeam( source, setTeam )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
			elseif ( theOccupation == "County Chief" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Police Officer" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Police Detective" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "NSA Agent" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "FBI Agent" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "National Task Force" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Military Forces" ) then
				setTeam = getTeamFromName( "Military Forces" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "GIGN" ) then
				setTeam = getTeamFromName( "GIGN" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "SSG" ) then
				setTeam = getTeamFromName( "Government" )
				giveWeapon ( source, 3 )
				setElementData( source, "skill", theRank)
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Administrator" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Executive Staff" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Trusted Staff" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Experienced Staff" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "New Staff" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Probationary Staff" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Community Owner" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			elseif ( theOccupation == "Head Staff" ) then
				setTeam = getTeamFromName( "Staff" )
				setPlayerTeam( source, setTeam )
			else
				setTeam = getTeamFromName ( "Unemployed" )
				setPlayerTeam ( source, setTeam )
			end
			if setTeam then
				local r,g,b = getTeamColor(setTeam)
				setPlayerNametagColor(source,r,g,b)
			end
		end
	end
	triggerClientEvent( source, "updateLabel", source )
	exports.NGCnote:addNote("backshift", "You are back on shift as ".. theOccupation,source, 0, 200, 0)
    exports.DENvehicles:reloadFreeVehicleMarkers(source, false)
    if playerData ~= nil then
        setElementModel( source, tonumber( playerData.jobskin ) )
    end
    triggerEvent( "onPlayerTeamChange", source, theTeam, setTeam )
end
addEvent( "onStartShift", true )
addEventHandler( "onStartShift", root, onStartShift )

function banFromJob(acc,name,mins)
    table.insert(bans,{acc,name,getTickCount(),mins*1000*60})
end

function unbanFromJob(acc,name)
    for k,v in pairs(bans) do
        if v[1] == acc and v[2] == name then
            table.remove(bans,k)
            return true
        end
    end
    return false
end

setTimer(function()
    for k,v in pairs(bans) do
        if getTickCount() - v[3] > v[4] then
            table.remove(bans,k)
        end
    end
end,10000,0)


function wantedCriminals ( ammo, attacker, weapon, bodypart )
	if (not attacker) then
		return false
	end
	if (attacker == source) then return end
	if (exports.server:getPlayChatZone(attacker) == "LV") then return false end
	if getPlayerTeam(source) then
		if (getTeamName(getPlayerTeam(source)) ~= "Criminals") and (getTeamName(getPlayerTeam(source)) ~= "HolyCrap") then return false end
		if (not attacker and isElement(attacker) == false and getElementType(attacker) ~= "player") then return false end
		if (getTeamName(getPlayerTeam(attacker)) == "Criminals") or (getTeamName(getPlayerTeam(attacker)) == "HolyCrap") then
			exports.server:givePlayerWantedPoints(attacker, 60)
			exports.NGCdxmsg:createNewDxMessage(attacker, "You committed murder.",255,0,0)
		end
	end
end
addEventHandler ("onPlayerWasted", getRootElement(), wantedCriminals)
