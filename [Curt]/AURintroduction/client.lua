local colShapes = {}

local title = ""
local description = ""
local count = 0
local current = 1
local d = 0
local timer

local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil

function loadContent ()
	for i=1, #intros do 
		local ax = intros[i]
		colShapes[ax[1]] = createColSphere(ax[2], ax[3], ax[4], ax[5])
		addEventHandler("onClientColShapeHit", colShapes[ax[1]], onCHit)
	end 
end

function onCHit(theElement)
	if (theElement == getLocalPlayer()) then 
		local dim = getElementDimension(theElement)
		if (dim == 0) then 
			for i=1, #intros do 
				if (colShapes[intros[i][1]] == source) then 
					if (exports.DENsettings:getPlayerSetting("AURIntroduction_"..intros[i][1]) ~= true) then 
						if (getPlayerWantedLevel() == 0) then 
								exports.DENsettings:setPlayerSetting("AURIntroduction_"..intros[i][1], true)
								count = #intros[i][7]+1
								if (current == 1) then 
									local theTable = intros[i][7][current]
									d = i
									local x, y, z = getElementPosition(getLocalPlayer())
									local rx, ry, rz = getElementPosition(getLocalPlayer())
									smoothMoveCamera(x, y, z, rx, ry, rz, theTable[1], theTable[2], theTable[3], theTable[4], theTable[5], theTable[6], 2000)
									cameraMode (true)
									addEventHandler ("onClientRender", root, theTable[7])
									setElementFrozen(getLocalPlayer(), true)
									current = current + 1
									start = getTickCount()
									tControls (false)
									timer = setTimer(function()
										local theTable = intros[d][7][current]
										if (count == current) then 
												local px, py, pz = getElementPosition(getLocalPlayer())
												local prx, pry, prz = getElementPosition(getLocalPlayer())
												local x, y, z, rx, ry, rz = getCameraMatrix()
												smoothMoveCamera(x, y, z, rx, ry, rz, px, py, pz, prx, pry, prz, 2000)
												triggerServerEvent("AURintroduction.resetCamera", resourceRoot, getLocalPlayer())
												cameraMode(false)
												removeEventHandler ("onClientRender", root, intros[d][7][current-1][7])
												setElementFrozen(getLocalPlayer(), false)
												tControls (true)
												count = 0
												current = 1
												d = 0
												start = nil
												unbindKey ("K", "down", triggerSkip)
												removeEventHandler ("onClientRender", root, skipRender)
										else
											local x, y, z, rx, ry, rz = getCameraMatrix()
											smoothMoveCamera(x, y, z, rx, ry, rz, theTable[1], theTable[2], theTable[3], theTable[4], theTable[5], theTable[6], 2000)
											removeEventHandler ("onClientRender", root, intros[d][7][current-1][7])
											start = getTickCount()
											addEventHandler ("onClientRender", root, theTable[7])
											current = current + 1
											bindKey("K", "down", triggerSkip)
											removeEventHandler ("onClientRender", root, skipRender)
											addEventHandler ("onClientRender", root, skipRender)
										end 
									end, intros[i][6], count)
								end 
								return true
						end
					end 
				end 
			end 
		end
	end 
end 

function triggerIntro (introno)
	local dim = getElementDimension(getLocalPlayer())
	if (dim == 0) then 
		local i = introno
		if (getPlayerWantedLevel() == 0) then 
				exports.DENsettings:setPlayerSetting("AURIntroduction_"..intros[i][1], true)
				count = #intros[i][7]+1
				if (current == 1) then 
					local theTable = intros[i][7][current]
					d = i
					local x, y, z, rx, ry, rz = getCameraMatrix()
					smoothMoveCamera(x, y, z, rx, ry, rz, theTable[1], theTable[2], theTable[3], theTable[4], theTable[5], theTable[6], 2000)
					cameraMode (true)
					addEventHandler ("onClientRender", root, theTable[7])
					setElementFrozen(getLocalPlayer(), true)
					current = current + 1
					start = getTickCount()
					tControls (false)
					timer = setTimer(function()
						local theTable = intros[d][7][current]
						if (count == current) then 
								local px, py, pz = getElementPosition(getLocalPlayer())
								local prx, pry, prz = getElementPosition(getLocalPlayer())
								local x, y, z, rx, ry, rz = getCameraMatrix()
								smoothMoveCamera(x, y, z, rx, ry, rz, px, py, pz, prx, pry, prz, 2000)
								triggerServerEvent("AURintroduction.resetCamera", resourceRoot, getLocalPlayer())
								cameraMode(false)
								removeEventHandler ("onClientRender", root, intros[d][7][current-1][7])
								setElementFrozen(getLocalPlayer(), false)
								tControls (true)
								count = 0
								current = 1
								d = 0
								start = nil
								unbindKey ("K", "down", triggerSkip)
								removeEventHandler ("onClientRender", root, skipRender)
						else
							local x, y, z, rx, ry, rz = getCameraMatrix()
							smoothMoveCamera(x, y, z, rx, ry, rz, theTable[1], theTable[2], theTable[3], theTable[4], theTable[5], theTable[6], 2000)
							removeEventHandler ("onClientRender", root, intros[d][7][current-1][7])
							start = getTickCount()
							addEventHandler ("onClientRender", root, theTable[7])
							current = current + 1
							bindKey("K", "down", triggerSkip)
							removeEventHandler ("onClientRender", root, skipRender)
							addEventHandler ("onClientRender", root, skipRender)
						end 
					end, intros[i][6], count)
				end 
				return true
		end
	end
end 

function tControls (st)
	triggerServerEvent("AURintroduction.tControls", resourceRoot, st)
end 

function skipRender()
	local screenW, screenH = guiGetScreenSize()
	dxDrawText("Press K to skip...", screenW * 0.7635, screenH * 0.8102, screenW * 0.9057, screenH * 0.8417, tocolor(254, 254, 254, math.random(50,255)), screenH*0.002, "default-bold", "center", "top", false, true, false, false, false)
end 

function triggerSkip ()
	if (isTimer(timer)) then 
		killTimer(timer)
		unbindKey ("K", "down", triggerSkip)
		local px, py, pz = getElementPosition(getLocalPlayer())
		local prx, pry, prz = getElementPosition(getLocalPlayer())
		local x, y, z, rx, ry, rz = getCameraMatrix()
		smoothMoveCamera(x, y, z, rx, ry, rz, px, py, pz, prx, pry, prz, 2000)
		removeEventHandler ("onClientRender", root, skipRender)
		outputDebugString("D"..d)
		outputDebugString("C"..current)
		removeEventHandler ("onClientRender", root, intros[d][7][current][7])
		removeEventHandler ("onClientRender", root, intros[d][7][current-1][7])
		count = 0
		current = 1
		d = 0
		setTimer(function()
		triggerServerEvent("AURintroduction.resetCamera", resourceRoot, getLocalPlayer())
		cameraMode(false)
		setElementFrozen(getLocalPlayer(), false)
		tControls (true)
		end, 3000, 1)
	end 
end 
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	return true
end

function cameraRender ()
	local screenW, screenH = guiGetScreenSize()
	dxDrawText(title, (screenW * 0.2630) - 1, (screenH * 0.1565) - 1, (screenW * 0.7672) - 1, (screenH * 0.2556) - 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(title, (screenW * 0.2630) + 1, (screenH * 0.1565) - 1, (screenW * 0.7672) + 1, (screenH * 0.2556) - 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(title, (screenW * 0.2630) - 1, (screenH * 0.1565) + 1, (screenW * 0.7672) - 1, (screenH * 0.2556) + 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(title, (screenW * 0.2630) + 1, (screenH * 0.1565) + 1, (screenW * 0.7672) + 1, (screenH * 0.2556) + 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(title, screenW * 0.2630, screenH * 0.1565, screenW * 0.7672, screenH * 0.2556, tocolor(tr, tg, tb, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	
	
	dxDrawText(description, (screenW * 0.2630) - 1, (screenH * 0.3593) - 1, (screenW * 0.7672) - 1, (screenH * 0.6620) - 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(description, (screenW * 0.2630) + 1, (screenH * 0.3593) - 1, (screenW * 0.7672) + 1, (screenH * 0.6620) - 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(description, (screenW * 0.2630) - 1, (screenH * 0.3593) + 1, (screenW * 0.7672) - 1, (screenH * 0.6620) + 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(description, (screenW * 0.2630) + 1, (screenH * 0.3593) + 1, (screenW * 0.7672) + 1, (screenH * 0.6620) + 1, tocolor(0, 0, 0, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	dxDrawText(description, screenW * 0.2630, screenH * 0.3593, screenW * 0.7672, screenH * 0.6620, tocolor(dr, dg, db, 255), 2.00, "pricedown", "center", "center", false, true, false, false, false)
	showPlayerHudComponent ("radar", false)
end 

function cameraMode (status)
	if (status == true) then 
		showChat(false)
		showPlayerHudComponent ("area_name", false)
		showPlayerHudComponent ("radar", false)
		showPlayerHudComponent ("vehicle_name", false)
		showPlayerHudComponent ("radio", false)
		exports.DENsettings:setPlayerSetting("custom", "false")
		exports.DENsettings:setPlayerSetting("radar", "false")
	else
		showChat(true)
		showPlayerHudComponent ("area_name", true)
		showPlayerHudComponent ("radar", true)
		showPlayerHudComponent ("vehicle_name", true)
		showPlayerHudComponent ("radio", true)
		exports.DENsettings:setPlayerSetting("custom", "true")
		exports.DENsettings:setPlayerSetting("radar", "true")
	end 
end

loadContent()

