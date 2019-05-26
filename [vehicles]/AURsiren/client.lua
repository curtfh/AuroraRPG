local attachedSound = {}
local vehicleList = {
[541]=true,
[402]=true,
[560]=true,
[426]=true,
[421]=true,
[415]=true,
[579]=true,[528]=true,[405]=true,
[559]=true,
[490]=true,
[551]=true,
[526]=true,
}
--[[
outputChatBox(getVehicleNameFromID(541))
outputChatBox(getVehicleNameFromID(402))
outputChatBox(getVehicleNameFromID(560))
outputChatBox(getVehicleNameFromID(426))
outputChatBox(getVehicleNameFromID(421))
outputChatBox(getVehicleNameFromID(415))
outputChatBox(getVehicleNameFromID(579))
outputChatBox(getVehicleNameFromID(405))
outputChatBox(getVehicleNameFromID(559))
outputChatBox(getVehicleNameFromID(490))
outputChatBox(getVehicleNameFromID(551))
]]

addEventHandler("onClientResourceStart",resourceRoot,
function ()
	local txd = engineLoadTXD("PoliceLight1.txd")
	engineImportTXD(txd, 1672)
	local dff = engineLoadDFF("PoliceLight1.dff", 0)
	engineReplaceModel(dff, 1672)
	col = engineLoadCOL( "PoliceLight1.col" )
	engineReplaceCOL( col, 1672 )
end)

local object = createObject(1672,2046.73,1518.54,10.67)

bindKey("g","down",function()
	if isPedInVehicle(localPlayer) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if vehicle then
			if getVehicleController(vehicle) == localPlayer then
				if exports.DENlaw:isLaw(localPlayer) then
					local access = vehicleList[getElementModel(vehicle)]
					if access then
						triggerServerEvent("setCustomSiren",localPlayer,vehicle,getElementModel(vehicle))
					end
				end
				if getElementModel(vehicle) == 526 and getElementData(localPlayer,"isPlayerPrime") then
					triggerServerEvent("setCustomSiren",localPlayer,vehicle,getElementModel(vehicle))
				end
			end
		end
	end
end)






