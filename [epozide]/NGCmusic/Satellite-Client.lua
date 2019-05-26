function beginTracking()
	if isElement(source) then
		tracking = source
		originalDimension = getElementDimension(localPlayer)
		addEventHandler("onClientRender",root,trackPlayer)
		showPlayerHudComponent("all",false)
		bindKey("num_mul","down",toggleVision)
		zoom = 100
	end
end
addEvent("satelliteTrack",true)
addEventHandler("satelliteTrack",root,beginTracking)

function toggleVision()
	if getCameraGoggleEffect() == "normal" then
		setCameraGoggleEffect("thermalvision")
	else
		setCameraGoggleEffect("normal")
	end
end

function stopTracking()
	if tracking then
		removeEventHandler("onClientRender",root,trackPlayer)
		showPlayerHudComponent("all",true)
		unbindKey("num_mul","down",toggleVision)
		setElementDimension(originalDimension)
		zoom = nil
		originalDimension = nil
		setCameraGoggleEffect("normal")
		setCameraInterior(getElementInterior(localPlayer))
		setCameraTarget(localPlayer)
	end
end
addCommandHandler("stoptracking",stopTracking)

function trackPlayer()
	if not isElement(tracking) then
		return stopTracking()
	end
	if getKeyState("num_add") then
		zoom = math.max(3,zoom-1)
	elseif getKeyState("num_sub") then
		zoom = math.min(125,zoom+1)
	end
	local interior = getElementInterior(tracking)
	if inteiror ~= getCameraInterior() then
		setCameraInterior(interior)
	end
	local dimension = getElementDimension(tracking)
	if dimension ~= getElementDimension(localPlayer) then
		setElementDimension(dimension)
	end
	local x,y,z = getElementPosition(tracking)
	setCameraMatrix(x,y,z+zoom,x,y,z)
end