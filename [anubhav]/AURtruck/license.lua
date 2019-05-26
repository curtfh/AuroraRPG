local screenW, screenH = guiGetScreenSize()
local markerLocations = {
	{-1694.09, -22.85, 2.2},
}
local colToMarkerPointers = {}
local currentDisplay = {}
truckerLicense = false

function renderMarkerTitles()
	local textToDisplay = "Buy trucker license"
	local r, g, b = 255, 255, 0
	local pX, pY, pZ = getElementPosition(localPlayer)
	local x, y, z = unpack(currentDisplay)
	local sX, sY = getScreenFromWorldPosition(x, y, z+1)
	local dist = getDistanceBetweenPoints3D(x, y, z, pX, pY, pZ)
	if (sX and dist < 20) then
		if (isLineOfSightClear(pX, pY, pZ, x, y, z, true, false, false, false, false)) then
			local scale = (((50 - dist) / 50) * 1) + 0.8
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)+1, sY-1, sX+1, sY-1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)-1, sY+1, sX-1, sY+1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)+1, sY+1, sX+1, sY+1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)-1, sY, sX-1, sY, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)+1, sY, sX+1, sY, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2), sY-1, sX, sY-1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2), sY+1, sX, sY+1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
			dxDrawText(textToDisplay, sX - (dxGetTextWidth(textToDisplay, scale, "default-bold") / 2), sY, sX, sY, tocolor(r,g,b,255), scale, "default-bold", "left", "top", false, false, false, true)
		end
	end
end

function createAllMarkers()
	for i, v in ipairs(markerLocations) do
		local marker = createMarker(v[1], v[2], v[3], "cylinder", 2, 255, 255, 0, 25)
		addEventHandler("onClientMarkerHit", marker, openLicenseWindow)
		local col = createColSphere(v[1], v[2], v[3], 15)
		addEventHandler("onClientColShapeHit", col, hitColshape)
		addEventHandler("onClientColShapeLeave", col, leaveColshape)
		colToMarkerPointers[col] = marker
	end
end
addEventHandler("onClientResourceStart", resourceRoot, createAllMarkers)

function leaveColshape(el)
	if (getElementType(el) ~= "player" or el ~= localPlayer) then
		return false
	end
	currentDisplay = {}
	removeEventHandler("onClientRender", root, renderMarkerTitles)
end

function hitColshape(el, matchingDim)
	if (getElementType(el) ~= "player" or el ~= localPlayer) then
		return false
	end
	if (not matchingDim) then
		return false
	end
	local x, y, z = getElementPosition(colToMarkerPointers[source])
	currentDisplay = {x, y, z + 1}
	removeEventHandler("onClientRender", root, renderMarkerTitles)
	addEventHandler("onClientRender", root, renderMarkerTitles)
end

function openLicenseWindow(plr, matchingDim)
	if (not matchingDim) then
		return false
	end
	if (not isPedOnGround(plr) or plr ~= localPlayer) then
		return false
	end
	if (truckerLicense) then
		outputChatBox("You already have a trucker's license.", 0, 255, 0)
		return false
	end
	createLicenseWindow()
	local vis = (not guiGetVisible(licenseWindow))
	guiSetVisible(licenseWindow, vis)
	showCursor(vis)
end

function createLicenseWindow()
	if (licenseWindow) then
		return true
	end
	-- Window
	licenseWindow = guiCreateWindow((screenW - 405) / 2, (screenH - 355) / 2, 405, 355, "Buy a trucker license", false)
	guiWindowSetSizable(licenseWindow, false)
	guiSetVisible(licenseWindow, false)
	-- Labels
	truckerLicenseMainLbl = guiCreateLabel(7, 25, 388, 38, "Trucker License - $5,000,000\n", false, licenseWindow)
	guiSetFont(truckerLicenseMainLbl, "default-bold-small")
	guiLabelSetHorizontalAlign(truckerLicenseMainLbl, "center", false)
	guiLabelSetVerticalAlign(truckerLicenseMainLbl, "center")
	truckerLicenseLbl = guiCreateLabel(7, 73, 388, 176, "Trucker License gives you the benefit to:\n\n- Use your own truck\n- Cargo benefits: Earn up to 1.5X on select locations\n", false, licenseWindow)
	guiLabelSetHorizontalAlign(truckerLicenseLbl, "center", false)
	guiLabelSetVerticalAlign(truckerLicenseLbl, "center")
	-- Buttons
	truckerLicenseCloseBtn = guiCreateButton(10, 305, 385, 34, "Close", false, licenseWindow)
	guiSetProperty(truckerLicenseCloseBtn, "NormalTextColour", "FFAAAAAA")
	truckerLicenseBuyBtn = guiCreateButton(10, 259, 385, 34, "Buy ($5,000,000)", false, licenseWindow)
	guiSetProperty(truckerLicenseBuyBtn, "NormalTextColour", "FFAAAAAA")
	-- Event Handler
	addEventHandler("onClientGUIClick", truckerLicenseBuyBtn, buyLicense, false)
	addEventHandler("onClientGUIClick", truckerLicenseCloseBtn, closeLicenseWindow, false)
end

function buyLicense(btn)
	if (btn ~= "left") then
		return false
	end
	triggerServerEvent("AURtruck.buyLicense", resourceRoot)
end

function closeLicenseWindow(btn)
	if (btn ~= "left" or not licenseWindow) then
		return false
	end
	guiSetVisible(licenseWindow, false)
	showCursor(false)
end

function changeLicenseStatus(lic)
	closeLicenseWindow("left")
	truckerLicense = lic
end
addEvent("AURtruck.licenseStatus", true)
addEventHandler("AURtruck.licenseStatus", root, changeLicenseStatus)