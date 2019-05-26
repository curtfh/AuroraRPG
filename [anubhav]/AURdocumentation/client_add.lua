--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal
All Rights Reserved 2017
________________________________________________
]]--

admin_elements_add = {}

categoryMemo = guiCreateMemo(0.343, 0.44, 0.15, 0.21, "Info", true)
documentMemo = guiCreateMemo(0.503, 0.44, 0.15, 0.21, "Info", true)
categoryNameAdd = guiCreateEdit(0.343, 0.34, 0.15, 0.03, "Category name", true)
nameDocumentC = guiCreateEdit(0.343, 0.39, 0.15, 0.03, "Document name", true)
nameDocumentD = guiCreateEdit(0.503, 0.39, 0.15, 0.03, "Document name", true)
comboCategory = guiCreateComboBox(0.503, 0.34, 0.15, 0.66, "", true)
closeARP = guiCreateButton(0.34, 0.71, 0.32, 0.03, "", true)
guiSetAlpha(closeARP, 0.00)   
addCategoryB = guiCreateButton(0.34, 0.67, 0.16, 0.03, "", true)
guiSetAlpha(addCategoryB, 0.00)   
addDocumentB = guiCreateButton(0.49, 0.67, 0.16, 0.03, "", true)
guiSetAlpha(addDocumentB, 0.00)

set_placeholder(categoryNameAdd)
set_placeholder(nameDocumentD)
set_placeholder(nameDocumentC)
set_placeholder(categoryMemo)
set_placeholder(documentMemo)

admin_elements_add = {categoryMemo, documentMemo, categoryNameAdd, nameDocumentD, nameDocumentC, comboCategory, closeARP, addCategoryB, addDocumentB}

function dxAddition()
    dxDrawRectangle(screenW * 0.3406, screenH * 0.2556, screenW * 0.3187, screenH * 0.4889, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.3406, screenH * 0.2556, screenW * 0.3187, screenH * 0.0347, tocolor(0, 0, 0, 175), false)
    dxDrawText("Staff Utilities - F1", screenW * 0.3398, screenH * 0.2542, screenW * 0.6594, screenH * 0.2903, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.4961, screenH * 0.2903, screenW * 0.4961, screenH * 0.7153, tocolor(255, 255, 255, 255), 1, false)
    dxDrawText("Add a category", screenW * 0.3398, screenH * 0.2903, screenW * 0.4961, screenH * 0.3208, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawText("Add a document", screenW * 0.4961, screenH * 0.2903, screenW * 0.6594, screenH * 0.3208, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.3398, screenH * 0.3208, screenW * 0.6578, screenH * 0.3208, tocolor(255, 255, 255, 255), 1, false)
    dxDrawRectangle(screenW * 0.3406, screenH * 0.7153, screenW * 0.3195, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
    dxDrawText("Close", screenW * 0.3398, screenH * 0.7153, screenW * 0.6594, screenH * 0.7444, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3406, screenH * 0.6722, screenW * 0.1555, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
    dxDrawText("Add", screenW * 0.3406, screenH * 0.6708, screenW * 0.4961, screenH * 0.7014, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.4961, screenH * 0.6722, screenW * 0.1633, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
    dxDrawText("Add", screenW * 0.4961, screenH * 0.6722, screenW * 0.6594, screenH * 0.7014, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function guiComboBoxAdjustHeight(combobox, itemcount)
    if getElementType(combobox) ~= "gui-combobox" or type(itemcount) ~= "number" then error("Invalid arguments @ 'guiComboBoxAdjustHeight'", 2) end
    local width = guiGetSize(combobox, true)
    return guiSetSize(combobox, width, (itemcount * 0.05) + 0.05, true)
end

function toggleAdminAdd(d)
    local newVisibility = (not guiGetVisible(admin_elements_add[1]))

    if (newVisibility) then
        addEventHandler("onClientRender", root, dxAddition)
    else
        removeEventHandler("onClientRender", root, dxAddition)
    end

    for i, v in ipairs(admin_elements_add) do 
        guiSetVisible(v, newVisibility)
    end

    showCursor(newVisibility)

    guiSetInputMode(newVisibility and "no_binds_when_editing" or "allow_binds") 

    if (d) then 
        guiComboBoxClear(comboCategory)

        itemCount = 0

        for i, v in pairs(d) do
            guiComboBoxAddItem(comboCategory, i)
            itemCount = itemCount + 1
        end

        guiComboBoxSetSelected(comboCategory, 0)

        guiComboBoxAdjustHeight(comboCategory, itemCount)
    end
end
toggleAdminAdd()
addEvent("AURnewRules.openAddPanel", true)
addEventHandler("AURnewRules.openAddPanel", resourceRoot, toggleAdminAdd)

function handleARPButtons(btn)
    if (btn ~= "left") then
        return false 
    end

    if (source == closeARP) then
        toggleAdminAdd(false)
    end    

    if (source == addCategoryB) then
        if (guiGetText(categoryNameAdd) == getElementData(categoryNameAdd, "place_holder")) then
            return outputChatBox("Please enter the category name")
        end
        if (guiGetText(nameDocumentC) == getElementData(nameDocumentC, "place_holder")) then
            return outputChatBox("Please enter the document name")
        end
        if (guiGetText(categoryMemo) == getElementData(categoryMemo, "place_holder")) then
            return outputChatBox("Please enter information for the document")
        end
        toggleAdminAdd(false)
        triggerServerEvent("AURnewRules.adminAddCategory", resourceRoot, guiGetText(categoryNameAdd), guiGetText(nameDocumentC), guiGetText(categoryMemo))
    end

    if (source == addDocumentB) then
        if (guiGetText(nameDocumentD) == getElementData(nameDocumentD, "place_holder")) then
            return outputChatBox("Please enter the document name")
        end
        if (guiGetText(documentMemo) == getElementData(documentMemo, "place_holder")) then
            return outputChatBox("Please enter information for the document")
        end
        toggleAdminAdd(false)
        triggerServerEvent("AURnewRules.adminAddCategory", resourceRoot, guiComboBoxGetItemText(comboCategory, guiComboBoxGetSelected(comboCategory)), guiGetText(nameDocumentD), guiGetText(documentMemo))

    end
end
addEventHandler("onClientGUIClick", closeARP, handleARPButtons, false)
addEventHandler("onClientGUIClick", addCategoryB, handleARPButtons, false)
addEventHandler("onClientGUIClick", addDocumentB, handleARPButtons, false)