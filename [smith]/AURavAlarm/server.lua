------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithAlertToMF/server (server-side)
--  Notify MF Soldiers and SWAT Members that there someone has enter to Seasparrow, Rustler, Hunter, Hydra, Rhino or S.W.A.T
--  [CSG]Smith
------------------------------------------------------------------------------------

Enemy_Blips = {}
Restricted_Vehicles = { [447]=true, [476]=true, [425]=true, [520]=true, [432]=true, [601]=true, [464]=true}

function isPlayerInTeam(src, TeamName)
        if src and isElement ( src ) and getElementType ( src ) == "player" then
                local team = getPlayerTeam(src)
                if team then
                        if getTeamName(team) == TeamName then
                                return true
                        else
                                return false
                        end
                end
        end
end

function addAlerOnVehiceEnter ( vehicle, seat, jacked )
	if getElementDimension ( source ) == 0 then
        if (( Restricted_Vehicles[getElementModel( vehicle )] ) and seat == 0) then
                if (isPlayerInTeam(source, "Staff") or isPlayerInTeam(source, "Government")) then return end
                        for k,v in ipairs(getElementsByType("player")) do
                                if isPlayerInTeam(v, "Government")then
                                        exports.killmessages:outputMessage("ATTENTION: "..getPlayerName(source).." entered an unathorized vehicle ("..getVehicleName(vehicle)..")", v, 250, 0, 0,"default-bold")
                                end
                        end
        end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), addAlerOnVehiceEnter )

function on_wasted ( ammo, attacker, weapon, bodypart )
	if Enemy_Blips[source] then
        if isElement(Enemy_Blips[source]) then
            destroyElement(Enemy_Blips[source])
        end
    end
end
addEventHandler ( "onPlayerWasted", getRootElement(), on_wasted )

function OnExit ( vehicle, seat, jacked )
        if Enemy_Blips[source] then
                if isElement(Enemy_Blips[source]) then
                        destroyElement(Enemy_Blips[source])
                end
        end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), OnExit )
