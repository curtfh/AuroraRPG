casesWindow = guiCreateWindow(0.43, 0.40, 0.15, 0.19, "AUR ~ Cases", true)
guiWindowSetSizable(casesWindow, false)
guiSetAlpha(casesWindow, 1.00)
guiSetVisible(casesWindow, false)

casesLabel = guiCreateLabel(0.00, 0.18, 1.00, 0.22, "You have 5 cases", true, casesWindow)
guiLabelSetHorizontalAlign(casesLabel, "center", false)
guiLabelSetVerticalAlign(casesLabel, "center")
close = guiCreateButton(0.05, 0.75, 0.90, 0.18, "Close", true, casesWindow)
open = guiCreateButton(0.05, 0.52, 0.90, 0.18, "Use", true, casesWindow)


function toggle(c)
    local vis = (not guiGetVisible(casesWindow))
    showCursor(vis)
    guiSetVisible(casesWindow, vis)
    -- Set the number of cases
    if (c) then
        guiSetText(casesLabel, "You have "..tostring(c).." cases")
    end
end
addEvent("AURcases.t", true)
addEventHandler('AURcases.t', root, toggle)

function buttons(b)
    if (b ~= "left") then
        return false 
    end
    if (source == close) then
        toggle()
    elseif (source == open) then
        triggerServerEvent("AURcases.openPrize", resourceRoot)
        guiSetEnabled(open, false)
        setTimer(guiSetEnabled, 1000, 1, open, true)
    end
end
addEventHandler("onClientGUIClick", close, buttons, false)
addEventHandler("onClientGUIClick", open, buttons, false)