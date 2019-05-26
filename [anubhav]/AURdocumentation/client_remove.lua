--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal
All Rights Reserved 2017
________________________________________________
]]--

admin_elements_remove = {}

category_remove_box = guiCreateComboBox(0.356, 0.37, 0.14, 0.03, "", true)
document_remove_box = guiCreateComboBox(0.505, 0.37, 0.14, 0.03, "", true)
closeADP = guiCreateButton(0.35, 0.70, 0.30, 0.03, "", true)
guiSetAlpha(closeADP, 0.00)   
deleteCategory = guiCreateButton(0.35, 0.63, 0.15, 0.03, "", true)
guiSetAlpha(deleteCategory, 0.00)
deleteDocument = guiCreateButton(0.50, 0.63, 0.15, 0.03, "", true)
guiSetAlpha(deleteDocument, 0.00)   

admin_elements_remove = {category_remove_box, document_remove_box, closeADP, deleteDocument, deleteCategory}

function dxRemove()
    dxDrawRectangle(screenW * 0.3508, screenH * 0.2722, screenW * 0.2984, screenH * 0.4569, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.3508, screenH * 0.2722, screenW * 0.2984, screenH * 0.0375, tocolor(0, 0, 0, 175), false)
    dxDrawText("Staff Utilities - F1", screenW * 0.3500, screenH * 0.2722, screenW * 0.6492, screenH * 0.3097, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Remove Category", screenW * 0.3508, screenH * 0.3097, screenW * 0.4977, screenH * 0.3486, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawText("Remove Document", screenW * 0.5023, screenH * 0.3097, screenW * 0.6492, screenH * 0.3486, tocolor(255, 255, 255, 255), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
    dxDrawLine(screenW * 0.5000, screenH * 0.3097, screenW * 0.5000, screenH * 0.6958, tocolor(255, 255, 255, 255), 1, false)
    dxDrawLine(screenW * 0.3500, screenH * 0.3486, screenW * 0.6477, screenH * 0.3486, tocolor(255, 255, 255, 255), 1, false)
    dxDrawRectangle(screenW * 0.3508, screenH * 0.6986, screenW * 0.2984, screenH * 0.0319, tocolor(0, 0, 0, 175), false)
    dxDrawText("Close", screenW * 0.3492, screenH * 0.6986, screenW * 0.6492, screenH * 0.7292, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawRectangle(screenW * 0.3508, screenH * 0.6333, screenW * 0.1492, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
    dxDrawRectangle(screenW * 0.5000, screenH * 0.6333, screenW * 0.1492, screenH * 0.0292, tocolor(0, 0, 0, 175), false)
    dxDrawText("Delete", screenW * 0.3508, screenH * 0.6333, screenW * 0.5000, screenH * 0.6625, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText("Delete", screenW * 0.5000, screenH * 0.6333, screenW * 0.6492, screenH * 0.6625, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function toggleAdminRemove(d)
    local newVisibility = (not guiGetVisible(category_remove_box))

    if (newVisibility) then
        addEventHandler("onClientRender", root, dxRemove)
    else
        removeEventHandler("onClientRender", root, dxRemove)
    end

    for i, v in ipairs(admin_elements_remove) do 
        guiSetVisible(v, newVisibility)
    end

    showCursor(newVisibility)

    guiSetInputMode(newVisibility and "no_binds_when_editing" or "allow_binds") 

    if (d) then 
        guiComboBoxClear(admin_elements_remove[1])
        guiComboBoxClear(admin_elements_remove[2])

        itemCount = 0
        itemCount2 = 0
        for i, v in pairs(d) do
            guiComboBoxAddItem(category_remove_box, i)
            itemCount = itemCount + 1
            itemCount2 = itemCount2 + #v

            for i, v in ipairs(v) do 
                guiComboBoxAddItem(document_remove_box, v['document'])    
            end
        end
        guiComboBoxSetSelected(category_remove_box, 0)
        guiComboBoxSetSelected(document_remove_box, 0)
        guiComboBoxAdjustHeight(category_remove_box, itemCount)
        guiComboBoxAdjustHeight(document_remove_box, itemCount2)
    end
end
toggleAdminRemove()
addEvent("AURnewRules.openDeletePanel", true)
addEventHandler("AURnewRules.openDeletePanel", resourceRoot, toggleAdminRemove)

function handleRemoveButtons(btn)
    if (btn ~= "left") then
        return false 
    end

    if (source == closeADP) then
        toggleAdminRemove()
    end

    if (source == deleteDocument) then
        toggleAdminRemove()
        triggerServerEvent("AURnewRules.adminDeleteDocument", resourceRoot, guiComboBoxGetItemText(document_remove_box, guiComboBoxGetSelected(document_remove_box)))
    end

    if (source == deleteCategory) then
        toggleAdminRemove()
        triggerServerEvent("AURnewRules.adminDeleteCategory", resourceRoot, guiComboBoxGetItemText(category_remove_box, guiComboBoxGetSelected(category_remove_box)))
    end
end
addEventHandler("onClientGUIClick", closeADP, handleRemoveButtons)
addEventHandler("onClientGUIClick", deleteDocument, handleRemoveButtons)
addEventHandler("onClientGUIClick", deleteCategory, handleRemoveButtons)