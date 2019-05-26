--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal
All Rights Reserved 2017
________________________________________________
]]--

gui_elements = {}
admin_elements = {}
gridlist_text = {}
textAdminEl1 = "Modify Document Text"
admin = true
screenW, screenH = guiGetScreenSize()

gui_elements[1] = guiCreateButton(0.19, 0.77, 0.61, 0.03, "", true)
guiSetAlpha(gui_elements[1], 0.00)

gui_elements[2] = guiCreateGridList(0.19, 0.28, 0.20, 0.44, true)
guiGridListAddColumn(gui_elements[2], "Document Name", 0.9)

gui_elements[3] = guiCreateEdit(0.19, 0.24, 0.20, 0.03, "Search....", true)

gui_elements[4] = guiCreateMemo(0.40, 0.24, 0.40, 0.48, "Please select a document to view information!", true)
guiMemoSetReadOnly(gui_elements[4], true)  

admin_elements[1] = guiCreateButton(0.40, 0.73, 0.40, 0.03, "", true)
guiSetAlpha(admin_elements[1], 0.00)    

for i, v in ipairs(admin_elements) do
	table.insert(gui_elements, v)
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

function search_function()
	guiGridListClear(gui_elements[2])

    local text = guiGetText(source)
    for i, v in pairs(gui_elements) do 
    	if (not tonumber(i)) then
	        if (i:lower():find(text:lower())) then 
	            local row = guiGridListAddRow(gui_elements[2]) 
	            guiGridListSetItemText(gui_elements[2], row, 1, i, false, false) 
	        end 
	    end
    end 

    if (text == getElementData(source, "place_holder")) then
    	for i, v in pairs(gridlist_text) do 
    		guiGridListSetItemText(gui_elements[2], guiGridListAddRow(gui_elements[2]), 1, i, true, false)

    		for i, v in ipairs(v) do
    			guiGridListSetItemText(gui_elements[2], guiGridListAddRow(gui_elements[2]), 1, v[1], false, false)
    		end
    	end
    end
end
addEventHandler("onClientGUIChanged", gui_elements[3], search_function)

function set_placeholder(guiElement)
	addEventHandler("onClientGUIFocus", guiElement, placeholder_function, true)
	addEventHandler("onClientGUIBlur", guiElement, placeholder_function, true)
	setElementData(guiElement, "place_holder", guiGetText(guiElement))
end
set_placeholder(gui_elements[3])

function dxMenu()
	alphaDocument = 255

	if (guiGetText(gui_elements[4]) == "Please select a document to view information!\n") then
		alphaDocument = 155
	end

	dxDrawRectangle(screenW * 0.1836, screenH * 0.1847, screenW * 0.6336, screenH * 0.6306, tocolor(0, 0, 0, 175), false)
	dxDrawRectangle(screenW * 0.1836, screenH * 0.1847, screenW * 0.6336, screenH * 0.0472, tocolor(0, 0, 0, 175), false)
	dxDrawText("AuroraRPG ~ Documentations", screenW * 0.1828, screenH * 0.1847, screenW * 0.8172, screenH * 0.2319, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.1945, screenH * 0.7708, screenW * 0.6086, screenH * 0.0306, tocolor(0, 0, 0, 175), false)
	dxDrawText("Close", screenW * 0.1945, screenH * 0.7694, screenW * 0.8023, screenH * 0.8014, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
--
	if (admin) then
        dxDrawRectangle(screenW * 0.4008, screenH * 0.7264, screenW * 0.3984, screenH * 0.0250, tocolor(0, 0, 0, 175), false)
        dxDrawText(textAdminEl1, screenW * 0.3992, screenH * 0.7250, screenW * 0.7992, screenH * 0.7514, tocolor(255, 255, 255, alphaDocument), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    end
end

function setCorrectMemo()
	local r, c = guiGridListGetSelectedItem(gui_elements[2])

	if (r == -1) then
		guiSetText(gui_elements[4], "Please select a document to view information!")
		return
	end

	guiSetText(gui_elements[4], gui_elements[guiGridListGetItemText(gui_elements[2], r, 1)])
end

function toggleGui()
	local newVisibility = (not guiGetVisible(gui_elements[1]))

	if (newVisibility) then
		setCorrectMemo()
		textAdminEl1 = "Modify Document Text"
		guiMemoSetReadOnly(gui_elements[4], true)
		guiSetEnabled(gui_elements[2], true)
		addEventHandler("onClientRender", root, dxMenu)
	else
		removeEventHandler("onClientRender", root, dxMenu)
	end

	for i, v in ipairs(gui_elements) do 
		guiSetVisible(v, newVisibility)
	end

	showCursor(newVisibility)

	guiSetInputMode(newVisibility and "no_binds_when_editing" or "allow_binds")
end
toggleGui()
addEvent("AURnewRules.gui", true)
addEventHandler("AURnewRules.gui", resourceRoot, toggleGui)

function handleButtons(button)
	if (button ~= "left") then
		return false
	end

	if (source == gui_elements[1]) then 
		toggleGui()
	end

	if (source == gui_elements[2]) then
		setCorrectMemo()
	end

	if (source == admin_elements[1] and admin) then
		local r, c = guiGridListGetSelectedItem(gui_elements[2])

		if (r == -1) then
			return
		end

		local documentName = guiGridListGetItemText(gui_elements[2], r, 1)

		if (textAdminEl1 == "Modify Document Text") then 
			guiMemoSetReadOnly(gui_elements[4], false)
			guiSetEnabled(gui_elements[2], false)
			textAdminEl1 = "Save"
		else 
			triggerServerEvent("AURnewRules.changeDocument", resourceRoot, documentName, guiGetText(gui_elements[4]))
			guiMemoSetReadOnly(gui_elements[4], true)
			guiSetEnabled(gui_elements[2], true)
			textAdminEl1 = "Modify Document Text"
			toggleGui()
		end
	end
end
addEventHandler("onClientGUIClick", gui_elements[1], handleButtons, false)
addEventHandler("onClientGUIClick", gui_elements[2], handleButtons, false)
addEventHandler("onClientGUIClick", gui_elements[3], handleButtons, false)
addEventHandler("onClientGUIClick", admin_elements[1], handleButtons, false)

function addCategory(name, items, update)
	guiGridListSetItemText(gui_elements[2], guiGridListAddRow(gui_elements[2]), 1, name, true, false)
	gridlist_text[name] = {}

	for i, v in ipairs(items) do 
		guiGridListSetItemText(gui_elements[2], guiGridListAddRow(gui_elements[2]), 1, v['document'], false, false)
		gui_elements[v['document']] = v['info']
		table.insert(gridlist_text[name], {v['document'], v['info']})
	end
end

function setupOnLogin(database, update, isAdmin)
    if (not update) then
        addCommandHandler("documentation", toggleGui)
        admin = isAdmin
    end

    guiGridListClear(gui_elements[2])
    
    for i, v in pairs(database) do 
        addCategory(i, v, update)
    end 
end
addEvent("AURnewRules.login", true)
addEventHandler("AURnewRules.login", resourceRoot, setupOnLogin)

triggerServerEvent("AURnewRules.dataForkIntoClient", resourceRoot)