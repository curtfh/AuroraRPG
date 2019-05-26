

local screenW, screenH = guiGetScreenSize()

local screenWidth, screenHeight = guiGetScreenSize()
local clientLosingConnection = false
function onPlayerIsLosingConnection(isLosingConnection)
	if isLosingConnection then
		if not clientLosingConnection then
			addEventHandler("onClientRender",root,playerLosingConnection)
			clientLosingConnection = true
		end
	else
		if clientLosingConnection then
			removeEventHandler("onClientRender",root,playerLosingConnection)
			clientLosingConnection = false
		end
	end
end
addEvent("onPlayerIsLosingConnection",true)
addEventHandler("onPlayerIsLosingConnection",root,onPlayerIsLosingConnection)

function playerLosingConnection()
	if clientLosingConnection then
		dxDrawText("Warning\nPacket loss", 0, 0, screenWidth, screenHeight-250, tocolor(255,0,0),1.2,"default-bold","center","center")
	end
end
sex = {}
haspermission = false
ANTI_TP_enabled = true
playerCoords = {0,0,0} -- Current player's position
playerCoordsCheck = {0,0,0} -- Previous player's position
function ANTIteleport() -- Tested and working!
	--if exports.server:getPlayerAccountName(localPlayer) == "neon.-" then
	if exports.CSGstaff:isPlayerStaff(localPlayer) then return false end
	if ANTI_TP_enabled and not isPedDead(localPlayer) then
		if getElementDimension(localPlayer) ~= 0 then return false end
		local x,y,z = getElementPosition(getLocalPlayer())
		--outputChatBox(getGroundPosition(x,y,z)..":"..z)

		playerCoords[1],playerCoords[2],playerCoords[3] = x,y,z
		if not runn_ed then -- It's to avoid detection on the first time
			playerCoordsCheck[1],playerCoordsCheck[2],playerCoordsCheck[3] = x,y,z
			runn_ed = true
		end

		coords = playerCoords[1]+playerCoords[2]+playerCoords[3]
		coords2 = playerCoordsCheck[1]+playerCoordsCheck[2]+playerCoordsCheck[3]
		if (coords+4 < coords2) or (coords > coords2+4) then
				--triggerServerEvent("bantp",getLocalPlayer())
			if getPedOccupiedVehicle(localPlayer) then

			else
				--fadeCamera(false)
				setElementPosition(localPlayer,x,y,z)
				if isTimer(sex[localPlayer]) then
				else
					sex[localPlayer] = setTimer(function()
						fadeCamera(true)
					end,4000,1)
				end
			end

			--removeEventHandler("onClientRender",getRootElement(),ANTIteleport)
		end
		playerCoordsCheck[1],playerCoordsCheck[2],playerCoordsCheck[3] = x,y,z
	end
end
addEventHandler("onClientRender",getRootElement(),ANTIteleport)
function onkilled()
	playerCoords = {0,0,0}
	playerCoordsCheck = {0,0,0}
	runn_ed = false
end
addEventHandler("onClientPlayerWasted",getLocalPlayer(),onkilled)

function initTPsys(isadmin)
	if exports.CSGstaff:isPlayerStaff(localPlayer) then
		haspermission = true
	else

	end
end
addEvent("startANTItp",true)
addEventHandler("startANTItp",getRootElement(),initTPsys)

