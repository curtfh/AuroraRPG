REPAIR_KIT_W = guiCreateWindow(0.34, 0.23, 0.33, 0.54, "AuroraRPG ~ Buy repair kits", true)
guiWindowSetSizable(REPAIR_KIT_W, false)
guiSetAlpha(REPAIR_KIT_W, 1.00)
guiSetVisible(REPAIR_KIT_W, false)
REPAIR_KIT_C = guiCreateButton(0.02, 0.85, 0.95, 0.07, "Close", true, REPAIR_KIT_W)
REPAIR_KIT_B = guiCreateButton(0.02, 0.74, 0.95, 0.07, "Buy", true, REPAIR_KIT_W)
REPAIR_KIT_L = guiCreateLabel(0.02, 0.07, 0.95, 0.50, "You can buy a repair kit here.\n\nTo use them, use /repairkit and click on a vehicle. It will show any error \n if found, and  if no error was found, it will start repairing.\n\nYou can see your current amount of repair kits by /rp\n\nEach repair kit costs 1,500$", true, REPAIR_KIT_W)
guiLabelSetHorizontalAlign(REPAIR_KIT_L, "left", true)
REPAIR_KIT_E = guiCreateEdit(0.02, 0.64, 0.95, 0.07, "Enter amount of repair kits you want to buy", true, REPAIR_KIT_W)
MARKERS = {
	{-1912.08, 276.95, 41.04},
	{2073.78, -1825.06, 13.54},
	{1030.42, -1031.32, 31.98},
	{1966.87, 2151.89, 10.82},
	{-2419.52, 1029.88, 50.2},
	{-1256.6, -45.48, 13.8},
	{-92.42, 1109.62, 19.74},
	{-1426.85, 2594.38, 55.83},
	{371.65, 2537.59, 16.6},
	{1582.33, 1453.53, 10.83},
	{723.9, -464.41, 16.03},
	{1871.5, -2382.77, 13.55},
	{482.75, -1732.48, 11.02}
}

function render_marker_titles()
	for i, v in ipairs(MARKERS) do
		local textToDisplay = "Buy repair kits"
		local r, g, b = 255, 255, 0
		local pX, pY, pZ = getElementPosition(localPlayer)
		local x, y, z = unpack(v)
		local sX, sY = getScreenFromWorldPosition(x, y, z+1)
		if (sX and getDistanceBetweenPoints3D(x, y, z, pX, pY, pZ) < 20) then
			if (isLineOfSightClear(pX, pY, pZ, x, y, z, true, false, false, false, false)) then
				local sX = sX - 100
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX+1, sY-1, sX+1, sY-1, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-1, sY+1, sX-1, sY+1, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX+1, sY+1, sX+1, sY+1, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-1, sY, sX-1, sY, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX+1, sY, sX+1, sY, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX, sY-1, sX, sY-1, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX, sY+1, sX, sY+1, tocolor(0,0,0,255), 1.0, "bankgothic", "left", "top", false, false, false, false)
				dxDrawText(textToDisplay, sX, sY, sX, sY, tocolor(r,g,b,255), 1.0, "bankgothic", "left", "top", false, false, false, true)
			end
		end
	end
end
addEventHandler("onClientRender", root, render_marker_titles)

function number_mode_function(ELEMENT_CHANGED)
	local TEXT = guiGetText(ELEMENT_CHANGED)
	if (TEXT == getElementData(source, "place_holder")) then
		return false 
	end
	if (not tonumber(TEXT)) then
		guiSetText(ELEMENT_CHANGED, "")
		return false 
	end
	if (tonumber(TEXT) < 0) then
		guiSetText(ELEMENT_CHANGED, "0")
		return true
	end
	guiSetText(ELEMENT_CHANGED, TEXT)
	return true 
end

function set_number_mode(GUI_ELEMENT, TEXT)
	addEventHandler("onClientGUIChanged", GUI_ELEMENT, number_mode_function)
end

function placeholder_function()
	if (eventName == "onClientGUIFocus") then
		local T = guiGetText(source)
		if (T == getElementData(source, "place_holder")) then
			guiSetText(source, "")
		end
	else
		if (guiGetText(source) == "") then
			guiSetText(source, getElementData(source, "place_holder"))
		end
	end
end

function button_f()
	local T = guiGetText(source)
	local B = getElementData(source, "UPDATE_A_C_T")

	if (tonumber(T) and tonumber(T) > 0) then
		guiSetText(B, "Buy ($"..tostring(T*1500)..")")
	end
end

function set_button_f(EL, EL2)
	setElementData(EL2, "UPDATE_A_C_T",EL)
	addEventHandler("onClientGUIChanged", EL2, button_f )
end

function set_placeholder(GUI_ELEMENT)
	addEventHandler("onClientGUIFocus", GUI_ELEMENT, placeholder_function, true)
	addEventHandler("onClientGUIBlur", GUI_ELEMENT, placeholder_function, true)
	setElementData(GUI_ELEMENT, "place_holder", guiGetText(GUI_ELEMENT))
end
set_placeholder(REPAIR_KIT_E)
set_number_mode(REPAIR_KIT_E)
set_button_f(REPAIR_KIT_B, REPAIR_KIT_E)

function repair_kit_t()
	local VISIBILITY = (not guiGetVisible(REPAIR_KIT_W))
	showCursor(VISIBILITY)
	guiSetVisible(REPAIR_KIT_W, VISIBILITY)
	guiSetInputMode((VISIBILITY and "no_binds_when_editing" or "allow_binds"))
end
addEvent("AURrepair_kits:t", true)
addEventHandler("AURrepair_kits:t", resourceRoot, repair_kit_t)

function handle_b(btn, state)
	if (btn ~= "left") then
		return false 
	end

	if (source == REPAIR_KIT_C) then
		repair_kit_t()
		return true
	end

	if (source == REPAIR_KIT_B) then
		local E = guiGetText(REPAIR_KIT_E)
		if (tonumber(E) and tonumber(E) > 0) then
			triggerServerEvent("AURrepair_kits:b", resourceRoot, tonumber(E))
			guiSetEnabled(source, false)
			setTimer(guiSetEnabled, 1000, 1, source, true)
		else
			outputChatBox("Invalid number", 255, 0, 0)
			return false 
		end
	end
end
addEventHandler("onClientGUIClick", REPAIR_KIT_B, handle_b, false)
addEventHandler("onClientGUIClick", REPAIR_KIT_C, handle_b, false)
