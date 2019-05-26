

    ----- server side
    addEvent ("changeJob", true)
    function changeJob (thePlayer, occupation, team, skin, theWeapon)
            if ( thePlayer ) and ( occupation ) and ( team ) and ( skin ) then
                            local playerID = exports.server:getPlayerAccountID(thePlayer)
                            local oldTeam = getPlayerTeam(thePlayer)
                            local oldOccupation = getElementData(thePlayer, "Occupation" )
                            setPlayerTeam ( thePlayer, getTeamFromName(team) )
                            setElementModel ( thePlayer, skin )
                            setElementData( thePlayer, "Occupation", occupation, true )
                            setElementData( thePlayer, "Rank", occupation, true )
                            local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", skin, playerID)
                            exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
                            if ( team ~= getTeamName( oldTeam ) ) then
                                    triggerEvent( "onPlayerTeamChange", thePlayer, oldTeam, getTeamFromName( team ) )
                            end
                            triggerClientEvent(thePlayer,"onPlayerJobChange",thePlayer,occupation, oldOccupation, getTeamFromName( team ) )
                            triggerEvent( "onPlayerJobChange", thePlayer, occupation, oldOccupation, getTeamFromName( team ) )
                            if ( theWeapon ) then
                                    giveWeapon( thePlayer, tonumber(theWeapon), 9999, true )
                            end
                            if ( occupation == "Traffic Officer" ) then
                                    giveWeapon( thePlayer, 43, 9999 )
                            end

            end
    end
    addEventHandler ( "changeJob", root, changeJob )

    addEvent ("kickPedFromJob", true)
    function kickPedFromJob(thePlayer, occupation)
            if ( thePlayer ) and ( occupation ) then
                    local playerID = exports.server:getPlayerAccountID(thePlayer)
                    local oldTeam = getPlayerTeam(thePlayer)
                    local oldOccupation = getElementData(thePlayer, "Occupation" )
                    setPlayerTeam ( thePlayer, getTeamFromName( "Unemployed" ) )
                    setElementData( thePlayer, "Occupation", "Unemployed", true )
                    setElementData( thePlayer, "Rank", "Unemployed", true )
                    local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", skin, playerID)
                    exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
                    if ( team ~= getTeamName( oldTeam ) ) then
                            triggerEvent( "onPlayerTeamChange", source, oldTeam, getTeamFromName( "Unemployed" ) )
                    end
                    triggerClientEvent(thePlayer,"onPlayerJobChange",thePlayer,occupation, oldOccupation, getTeamFromName( "Unemployed" ) )
                    triggerEvent( "onPlayerJobChange", thePlayer, occupation, oldOccupation, getTeamFromName( "Unemployed" ) )
                    local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
                    if ( tonumber( playerData.skin ) == 0 ) then
                            exports.DENcriminal:givePlayerCJClothes( source )
                    else
                            setElementModel ( thePlayer, tonumber( playerData.skin ) )
                    end
            end
    end
    addEventHandler ( "kickPedFromJob", root,kickPedFromJob)

    addEvent ("crimchangeJob", true)
    function forceHimInCriminalJob(thePlayer)
            local playerID = exports.server:getPlayerAccountID( thePlayer )
            local oldTeam = getPlayerTeam( thePlayer )
            local oldM = getElementModel(thePlayer)
            local theOccupation = "Criminal"
            local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
            if ( playerData ) then
                    setElementData( thePlayer, "Occupation", "Criminal", true )
                    setPlayerTeam ( thePlayer, getTeamFromName ( "Criminals" ) )
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
                    if ( getTeamName( oldTeam ) ~= "Criminals" ) then
                            triggerEvent( "onPlayerTeamChange", thePlayer, oldTeam, getTeamFromName ( "Criminals" ) )
                    end
                    triggerEvent( "onPlayerJobChange", thePlayer, "Criminal", getTeamFromName ( "Criminals" ) )
                    triggerEvent( "CSGcriminalskills.changed",thePlayer)
                    exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
            end
    end
addEventHandler ( "crimchangeJob", root,forceHimInCriminalJob)
