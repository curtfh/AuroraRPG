--
local screenW, screenH = guiGetScreenSize()

customTitleW = guiCreateWindow(0.23, 0.21, 0.54, 0.58, "AuroraRPG ~ Custom Titles", true)
guiWindowSetSizable(customTitleW, false)
guiSetAlpha(customTitleW, 0.00)
guiSetVisible(customTitleW, false)

--[[customTitleGridlist = guiCreateGridList(0.01, 0.05, 0.97, 0.55, true, customTitleW)
guiGridListAddColumn(customTitleGridlist, "Custom Title", 0.5)
guiGridListAddColumn(customTitleGridlist, "Color", 0.4)

useCustomTitle = guiCreateButton(0.01, 0.63, 0.97, 0.06, "Disable", true, customTitleW)
buyCustomTitle = guiCreateButton(0.01, 0.71, 0.97, 0.06, "Buy a custom title", true, customTitleW)
closeBtn = guiCreateButton(0.01, 0.89, 0.97, 0.06, "Close", true, customTitleW)
--]]
--

useCustomTitle = guiCreateButton(0.29, 0.63, 0.41, 0.03, "Use", true)
buyCustomTitle = guiCreateButton(0.30, 0.68, 0.41, 0.03, "Buy", true)
closeBtn = guiCreateButton(0.30, 0.72, 0.41, 0.03, "color", true)
guiSetAlpha(closeBtn, 0.0)
guiSetAlpha(useCustomTitle, 0.0)
guiSetAlpha(buyCustomTitle, 0.0)

customTitleGridlist = guiCreateGridList(0.30, 0.28, 0.41, 0.33, true)
guiGridListAddColumn(customTitleGridlist, "Custom Title", 0.5)
guiGridListAddColumn(customTitleGridlist, "Color", 0.5)
guiSetAlpha(customTitleGridlist, 0.86)

guiSetVisible(useCustomTitle, false)
guiSetVisible(buyCustomTitle, false)
guiSetVisible(closeBtn, false)
guiSetVisible(customTitleGridlist, false)

function dxCustomTitle()
	dxDrawRectangle(screenW * 0.2906, screenH * 0.2333, screenW * 0.4188, screenH * 0.5347, tocolor(0, 0, 0, 179), false)
	dxDrawRectangle(screenW * 0.2906, screenH * 0.2347, screenW * 0.4188, screenH * 0.0361, tocolor(0, 0, 0, 179), false)
	dxDrawText("AuroraRPG ~ Customtitles", screenW * 0.2883, screenH * 0.2319, screenW * 0.7094, screenH * 0.2708, tocolor(255, 255, 255, 255), 1.40, "default-bold", "center", "center", false, false, false, false, false)
	if (guiGetEnabled(useCustomTitle)) then
		dxDrawRectangle(screenW * 0.2961, screenH * 0.6278, screenW * 0.4055, screenH * 0.0278, tocolor(0, 0, 0, 179), false)
		dxDrawText(guiGetText(useCustomTitle), screenW * 0.2953, screenH * 0.6292, screenW * 0.7016, screenH * 0.6556, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	end
	dxDrawRectangle(screenW * 0.2961, screenH * 0.6750, screenW * 0.4055, screenH * 0.0278, tocolor(0, 0, 0, 179), false)
	dxDrawRectangle(screenW * 0.2953, screenH * 0.7167, screenW * 0.4055, screenH * 0.0278, tocolor(0, 0, 0, 179), false)
	dxDrawText("Buy a custom title", screenW * 0.2953, screenH * 0.6750, screenW * 0.7016, screenH * 0.7014, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Close", screenW * 0.2953, screenH * 0.7181, screenW * 0.7016, screenH * 0.7444, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	guiBringToFront(customTitleGridlist)
	guiBringToFront(useCustomTitle)
	guiBringToFront(closeBtn)
	guiBringToFront(buyCustomTitle)
end
 
local checkbox = {}

buyCustomTitleW = guiCreateWindow(0.34, 0.22, 0.33, 0.55, "Buy custom title", true)
guiWindowSetSizable(buyCustomTitleW, false)
guiSetAlpha(buyCustomTitleW, 0.00)
guiSetVisible(buyCustomTitleW, false)

--backToMainW = guiCreateButton(0.02, 0.89, 0.95, 0.08, "Back", true, buyCustomTitleW)
--finalizeCustomTitle = guiCreateButton(0.02, 0.79, 0.95, 0.08, "Buy", true, buyCustomTitleW)
--openPicker = guiCreateButton(0.02, 0.51, 0.95, 0.06, "Open colorpicker", true, buyCustomTitleW)

--checkbox[1] = guiCreateCheckBox(0.02, 0.12, 0.95, 0.04, "Personal custom title ($5,000,000)", false, true, buyCustomTitleW)
--checkbox[2] = guiCreateCheckBox(0.02, 0.18, 0.95, 0.04, "Group custom title ($10,000,000)", false, true, buyCustomTitleW)

--labelType = guiCreateLabel(0.02, 0.06, 0.95, 0.05, "Choose the type of custom title you will buy:", true, buyCustomTitleW)
--labelTitle = guiCreateLabel(0.02, 0.26, 0.95, 0.05, "Choose the title name (hexes are allowed):", true, buyCustomTitleW)
--labelColor = guiCreateLabel(0.02, 0.44, 0.95, 0.05, "Choose the color:", true, buyCustomTitleW)

--titleBox = guiCreateEdit(0.02, 0.33, 0.94, 0.06, "Choose your title", true, buyCustomTitleW)
--redBox = guiCreateEdit(0.02, 0.58, 0.22, 0.06, "R", true, buyCustomTitleW)
--greenBox = guiCreateEdit(0.27, 0.58, 0.22, 0.06, "G", true, buyCustomTitleW)
--blueBox = guiCreateEdit(0.53, 0.58, 0.22, 0.06, "B", true, buyCustomTitleW)

openPicker = guiCreateButton(0.39, 0.57, 0.29, 0.02, "color picker", true)
guiSetAlpha(openPicker, 0.00)
finalizeCustomTitle = guiCreateButton(0.38, 0.74, 0.31, 0.02, "buy", true)
guiSetAlpha(finalizeCustomTitle, 0.00)
backToMainW = guiCreateButton(0.38, 0.78, 0.31, 0.02, "back", true)
guiSetAlpha(backToMainW, 0.00)

checkbox[1] = guiCreateCheckBox(0.39, 0.38, 0.28, 0.02, "Personal custom title ($5,000,000)", false, true)
checkbox[2] = guiCreateCheckBox(0.39, 0.41, 0.28, 0.02, "Group custom title ($10,000,000)", false, true)

titleBox = guiCreateEdit(0.39, 0.49, 0.28, 0.03, "Choose your title", true)
redBox = guiCreateEdit(0.39, 0.60, 0.03, 0.04, "R", true)
greenBox = guiCreateEdit(0.42, 0.60, 0.03, 0.04, "G", true)
blueBox = guiCreateEdit(0.45, 0.60, 0.03, 0.04, "B", true)

elementsGUITwo = {openPicker, finalizeCustomTitle, backToMainW, checkbox[1], checkbox[2], titleBox, redBox, greenBox, blueBox}

for i, v in ipairs(elementsGUITwo) do
	guiSetVisible(v, false)
end

function dxWindowsecond()
	dxDrawRectangle(screenW * 0.3820, screenH * 0.2819, screenW * 0.3039, screenH * 0.5542, tocolor(0, 0, 0, 179), false)
	dxDrawRectangle(screenW * 0.3820, screenH * 0.2819, screenW * 0.3039, screenH * 0.0472, tocolor(0, 0, 0, 179), false)
	dxDrawText("Buy custom title", screenW * 0.3812, screenH * 0.2847, screenW * 0.6859, screenH * 0.3292, tocolor(255, 255, 255, 255), 1.40, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawText("Choose the type of custom title you will buy:", screenW * 0.3891, screenH * 0.3431, screenW * 0.6703, screenH * 0.3722, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Choose the title name (hexes are allowed):", screenW * 0.3883, screenH * 0.4528, screenW * 0.6695, screenH * 0.4819, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawText("Choose the color:", screenW * 0.3898, screenH * 0.5403, screenW * 0.6711, screenH * 0.5694, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3883, screenH * 0.5750, screenW * 0.2828, screenH * 0.0208, tocolor(0, 0, 0, 179), false)
	dxDrawText("Open color picker", screenW * 0.3891, screenH * 0.5750, screenW * 0.6711, screenH * 0.5958, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3836, screenH * 0.7792, screenW * 0.3023, screenH * 0.0222, tocolor(0, 0, 0, 179), false)
	if (guiGetEnabled(finalizeCustomTitle)) then
		dxDrawRectangle(screenW * 0.3836, screenH * 0.7431, screenW * 0.3023, screenH * 0.0222, tocolor(0, 0, 0, 179), false)	
		dxDrawText("Buy", screenW * 0.3820, screenH * 0.7417, screenW * 0.6859, screenH * 0.7653, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
	end
	dxDrawText("Back", screenW * 0.3820, screenH * 0.7792, screenW * 0.6859, screenH * 0.8028, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

addEventHandler("onClientGUIClick", buyCustomTitleW,
	function()
		guiMoveToBack(source)
	end
)
_guiSetVisible = guiSetVisible 

function guiSetVisible(window, b)
	if (window == customTitleW) then
		if (b) then
			addEventHandler("onClientRender", root, dxCustomTitle)
		else
			removeEventHandler("onClientRender", root, dxCustomTitle)
		end
		guiSetVisible(useCustomTitle, b)
		guiSetVisible(buyCustomTitle, b)
		guiSetVisible(closeBtn, b)
		guiSetVisible(customTitleGridlist, b)
	elseif (window == buyCustomTitleW) then
		if (b) then
			addEventHandler("onClientRender", root, dxWindowsecond)
		else
			removeEventHandler("onClientRender", root, dxWindowsecond)
		end
		for i,v in ipairs(elementsGUITwo) do
			guiSetVisible(v, b)
		end
	end
	return _guiSetVisible(window, b)
end

--
local filterWords = {
	['saur']="****",
	['cit']="***",
	['c*t']="***",
	['saes']="****",
	['fuck']="love",
	['cunt']="****",
	['asshole']="*******",
	['aura']="****",
	['nsc']="***",
	['dick']="papa",
	['porn']="banana",
	['bitch']="spicy potato",
	['xxx']="***",
	['mute']="pepsi",
	['jail']="coke",
	['ban']="luf",
	['cocksuckers']="i love you papa",
	['amk']="love",
	['kos']="apple",
	['sharmota']="pear",
	['miboun']="pepes",
}

function filter_text(text)
	--for i, v in pairs(filterWords) do
	--	if (string.match(text:lower(), i)) then
	--		text = string.gsub(text:lower(), i, v)
--		end
--	end
	return text
end

function number_mode_function(elementChanged)
	local newText = guiGetText(elementChanged)
	if (newText == getElementData(source, "place_holder")) then
		return false 
	end
	if (not tonumber(newText)) then
		guiSetText(elementChanged, "")
		return false 
	end
	if (tonumber(newText) > 255) then
		guiSetText(elementChanged, "255")
		return true
	elseif (tonumber(newText) < 0) then
		guiSetText(elementChanged, "0")
		return true
	end
	guiSetText(elementChanged, newText)
	return true 
end

function set_number_mode(guiElement, text)
	addEventHandler("onClientGUIChanged", guiElement, number_mode_function)
end

function placeholder_function()
	if (eventName == "onClientGUIFocus") then
		local newText = guiGetText(source)
		if (newText == getElementData(source, "place_holder")) then
			guiSetText(source, "")
		end
	else
		if (guiGetText(source) == "") then
			guiSetText(source, getElementData(source, "place_holder"))
		end
	end
end

function set_placeholder(guiElement)
	addEventHandler("onClientGUIFocus", guiElement, placeholder_function, true)
	addEventHandler("onClientGUIBlur", guiElement, placeholder_function, true)
	setElementData(guiElement, "place_holder", guiGetText(guiElement))
end

function misc_checkbox(guiElement)
	for i, v in ipairs(checkbox) do
		if (v == guiElement) then
			return i
		end
	end
end

function checkbox_function()
	if (misc_checkbox(source)) then 
		local number = misc_checkbox(source)
		if (number == 1) then
			guiCheckBoxSetSelected(checkbox[2], false)
			guiCheckBoxSetSelected(checkbox[1], true)
		else
			guiCheckBoxSetSelected(checkbox[1], false)
			guiCheckBoxSetSelected(checkbox[2], true)
		end
	end
end
addEventHandler("onClientGUIClick", checkbox[1], checkbox_function, false)
addEventHandler("onClientGUIClick", checkbox[2], checkbox_function, false)
--
set_placeholder(redBox)
set_placeholder(greenBox)
set_placeholder(titleBox)
set_placeholder(blueBox)
set_number_mode(redBox)
set_number_mode(greenBox)
set_number_mode(blueBox)
--

function main_window_toggle(data, data2, data3, money)
	local visibility = not guiGetVisible(customTitleW)
	showCursor(visibility)
	guiSetVisible(customTitleW, visibility)

	if (data) then
		guiGridListClear(customTitleGridlist)
		local row = guiGridListAddRow(customTitleGridlist)
		guiGridListSetItemText(customTitleGridlist, row, 1, "Personal Custom Titles", true, true)

		for i, v in ipairs(data) do
			if (v.cTType == "personal") then
				local row = guiGridListAddRow(customTitleGridlist)
				guiGridListSetItemText(customTitleGridlist, row, 1, v.cTName, false, true)
				guiGridListSetItemText(customTitleGridlist, row, 2, v.cTr..","..v.cTg..","..v.cTb, false, true)
				guiGridListSetItemColor(customTitleGridlist, row, 2, v.cTr, v.cTg, v.cTb)
			end
		end
		local row = guiGridListAddRow(customTitleGridlist)
		guiGridListSetItemText(customTitleGridlist, row, 1, "Group Custom Titles", true, true)
		for i, v in ipairs(data2) do
			if (v.cTType == "group") then
				local row = guiGridListAddRow(customTitleGridlist)
				guiGridListSetItemText(customTitleGridlist, row, 1, v.cTName, false, true)
				guiGridListSetItemText(customTitleGridlist, row, 2, v.cTr..","..v.cTg..","..v.cTb, false, true)
				guiGridListSetItemColor(customTitleGridlist, row, 2, v.cTr, v.cTg, v.cTb)
			end
		end
		local row = guiGridListAddRow(customTitleGridlist)
		guiGridListSetItemText(customTitleGridlist, row, 1, "Job Custom Titles", true, true)
		for i, v in ipairs(data3) do
			local row = guiGridListAddRow(customTitleGridlist)
			guiGridListSetItemText(customTitleGridlist, row, 1, v.cTName, false, true)
			guiGridListSetItemText(customTitleGridlist, row, 2, v.cTr..","..v.cTg..","..v.cTb, false, true)
			guiGridListSetItemColor(customTitleGridlist, row, 2, v.cTr, v.cTg, v.cTb)
		end
	end
	if (tonumber(money)) then
		guiSetText(titleBox, "Choose your title")
		guiSetText(redBox, "R")
		guiSetText(greenBox, "G")
		guiSetText(blueBox, "B")
		guiSetEnabled(finalizeCustomTitle, true)
		guiSetEnabled(checkbox[1], true)
		guiSetEnabled(checkbox[2], true)
		if (money < 5000000) then
			guiSetEnabled(checkbox[1], false)
			guiSetEnabled(checkbox[2], false)
			guiSetEnabled(finalizeCustomTitle, false)
		end
		if (money < 10000000) then
			guiSetEnabled(checkbox[2], false)
		end
	end

	if (getElementData(localPlayer, "ctData")) then
		guiSetText(useCustomTitle, "Disable")
		guiSetEnabled(useCustomTitle, true)
	else
		guiSetText(useCustomTitle, "Use")
		guiSetEnabled(useCustomTitle, false)
	end
end
addEvent("AURnewCustomTitle.gui", true)
addEventHandler("AURnewCustomTitle.gui", root, main_window_toggle)

function secondary_window_toggle()
	main_window_toggle()

	local visibility = not guiGetVisible(buyCustomTitleW)
	showCursor(visibility)
	guiSetVisible(buyCustomTitleW, visibility)
	if (visibility) then
		guiSetInputMode("no_binds_when_editing")
	else
		guiSetInputMode("allow_binds")
	end
end

function secondary_window_toggle2()
	local visibility = not guiGetVisible(buyCustomTitleW)
	showCursor(visibility)
	guiSetVisible(buyCustomTitleW, visibility)
	if (visibility) then
		guiSetInputMode("no_binds_when_editing")
	else
		guiSetInputMode("allow_binds")
	end
end
addEvent("AURnewCustomTitle.gui2", true)
addEventHandler("AURnewCustomTitle.gui2", root, secondary_window_toggle2)


function checkbox_selected()
	local personal = guiCheckBoxGetSelected(checkbox[1])
	local group = guiCheckBoxGetSelected(checkbox[2])
	if (personal) then
		return "personal"
	end
	if (group) then
		return "group"
	end
	return false
end

function handle_buttons(button)
	if (button ~= "left") then
		return false 
	end

	if (source == closeBtn) then
		main_window_toggle()
		return true
	end

	if (source == buyCustomTitle) then
		secondary_window_toggle()
		return true
	end

	if (source == backToMainW) then
		secondary_window_toggle()
		guiSetVisible(customTitleW, true)
		showCursor(true)
		return true 
	end

	if (source == openPicker) then
		exports.cpicker:openPicker(source, "#FF0000", "Choose a color for you custom title!")
		return true
	end

	if (source == finalizeCustomTitle) then
		local r, g, b = guiGetText(redBox), guiGetText(greenBox), guiGetText(blueBox)
		local title = guiGetText(titleBox)
		local choice = checkbox_selected()

		if (not choice) then
			outputChatBox("You must select a box!", 255, 25, 25)
			return false 
		end

		if (title:gsub("%s+", "") == "") then
			outputChatBox("You cannot leave title box empty!", 255, 25, 25)
			return false 
		end
			
		if (string.len(title) > 45) then
			outputChatBox("You can't buy a custom title with more than 45 chars.", 255, 0, 0)
			return false 
		end
		if (not tonumber(r) or not tonumber(g) or not tonumber(b)) then
			outputChatBox("You cannot leave title R/G/B box empty!", 255, 25, 25)
			return false 
		end
		if (antiSpam and getTickCount() - antiSpam <= 1000) then return false end
		triggerServerEvent("AURnewCustomTitle.recieveCT", resourceRoot, title, r, g, b, choice)
		antiSpam = getTickCount()
		return true 
	end

	if (source == customTitleGridlist) then
		local row = guiGridListGetSelectedItem(customTitleGridlist)
		if (row == -1) then
			if (getElementData(localPlayer, "ctData")) then
				guiSetText(useCustomTitle, "Disable")
				guiSetEnabled(useCustomTitle, true)
			else
				guiSetText(useCustomTitle, "Use")
				guiSetEnabled(useCustomTitle, false)
			end
		else
			guiSetText(useCustomTitle, "Use")
			guiSetEnabled(useCustomTitle, true)			
		end
	end

	if (source == useCustomTitle) then
		if (guiGetText(source) == "Disable") then
			setElementData(localPlayer, "ctData", false)
			main_window_toggle()
		end
		local row = guiGridListGetSelectedItem(customTitleGridlist)
		if (row == -1) then
			if (getElementData(localPlayer, "ctData")) then
				guiSetText(useCustomTitle, "Disable")
				guiSetEnabled(useCustomTitle, true)
			else
				guiSetText(useCustomTitle, "Use")
				guiSetEnabled(useCustomTitle, false)
			end
		else
			if (guiGetText(source) == "Use") then
				local text = guiGridListGetItemText(customTitleGridlist, row, 1)
				local rgb = split(guiGridListGetItemText(customTitleGridlist, row, 2), ",")
				setElementData(localPlayer, "ctData", {filter_text(text), rgb})
				main_window_toggle()
			end
		end
	end
end
addEventHandler("onClientGUIClick", guiRoot, handle_buttons)

addEventHandler("onColorPickerOK", root, 
	function(element, hex, r, g, b)
		if (element ~= openPicker) then
			return false 
		end
		guiSetText(redBox, r)
		guiSetText(greenBox, g)
		guiSetText(blueBox, b)
	end
)

function render_custom_titles()
	for i, v in ipairs(getElementsByType("player")) do
		if (getElementData(v, "ctData")) then
			local textToDisplay = getElementData(v, "ctData")[1]
			local r, g, b = getElementData(v, "ctData")[2][1], getElementData(v, "ctData")[2][2], getElementData(v, "ctData")[2][3]
			local pX, pY, pZ = getElementPosition(localPlayer)
			local x, y, z = getPedBonePosition(v, 6)
			local sX, sY = getScreenFromWorldPosition(x, y, z + 0.3)
			local dist = getDistanceBetweenPoints3D(x, y, z, pX, pY, pZ)
			if (sX and dist < 50) then
				if (isLineOfSightClear(pX, pY, pZ, x, y, z, true, false, false, false, false)) then
					local sX = sX - 1
					local scale = (((50 - dist) / 50) * 1) + 0.8
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)-1, sY-1, sX-1, sY-1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)+1, sY-1, sX+1, sY-1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)-1, sY+1, sX-1, sY+1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)+1, sY+1, sX+1, sY+1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)-1, sY, sX-1, sY, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2)+1, sY, sX+1, sY, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2), sY-1, sX, sY-1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay:gsub("#%x%x%x%x%x%x", ""), sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2), sY+1, sX, sY+1, tocolor(0,0,0,255), scale, "default-bold", "left", "top", false, false, false, false)
					dxDrawText(textToDisplay, sX-(dxGetTextWidth(textToDisplay, scale, "default-bold") / 2), sY, sX, sY, tocolor(r,g,b,255), scale, "default-bold", "left", "top", false, false, false, true)
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, render_custom_titles)