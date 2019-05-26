function stop(key, keyState)
local HD = (getTeamName(getPlayerTeam(localPlayer)) == "Staff")
if ( HD ) then
local vehicle = getPedOccupiedVehicle ( getLocalPlayer () )
if ( vehicle ) then
setElementVelocity ( vehicle, 0, 0, 0)
exports.NGCdxmsg:createNewDxMessage ("Super Brake enabled", 0, 255, 0)

end
end

end
addCommandHandler("SBS",stop)
addCommandHandler("sbs",stop)
