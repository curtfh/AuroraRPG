memo = {}
label = {}
button = {}
edit = {}

function openWindow()
    if (loggingWindow) then
        return true 
    end
    -- Window
    loggingWindow = guiCreateWindow(0.30, 0.25, 0.40, 0.50, "AUR - Check Logs", true)
    guiWindowSetSizable(loggingWindow, false)
    guiSetVisible(loggingWindow, false)
    -- Tab
    tabPanel = guiCreateTabPanel(0.02, 0.07, 0.96, 0.83, true, loggingWindow)
    -- Tab 1
    accountLogs = guiCreateTab("Account Logs", tabPanel)
    -- Edit
    edit[accountLogs] = guiCreateEdit(124, 13, 236, 23, "", false, accountLogs)
    -- Label
    label[accountLogs] = guiCreateLabel(0.01, 0.04, 0.22, 0.09, "Account Name", true, accountLogs)
    guiSetFont(label[accountLogs], "default-bold-small")
    guiLabelSetHorizontalAlign(label[accountLogs], "right", false)
    guiLabelSetVerticalAlign(label[accountLogs], "center")
    -- Button
    button[accountLogs] = guiCreateButton(0.74, 0.05, 0.24, 0.08, "Check", true, accountLogs)
    closeButton = guiCreateButton(0.02, 0.91, 0.96, 0.06, "Close", true, loggingWindow)
    -- Memo
    memo[accountLogs] = guiCreateMemo(0.02, 0.14, 0.96, 0.82, "Account name must be exact", true, accountLogs)
    guiMemoSetReadOnly(memo[accountLogs], true)
    -- Tab 2
    serialLogs = guiCreateTab("Serial Logs", tabPanel)
    -- Edit
    edit[serialLogs] = guiCreateEdit(124, 13, 236, 23, "", false, serialLogs)
    -- Label
    label[serialLogs] = guiCreateLabel(0.01, 0.04, 0.22, 0.09, "Serial", true, serialLogs)
    guiSetFont(label[serialLogs], "default-bold-small")
    guiLabelSetHorizontalAlign(label[serialLogs], "right", false)
    guiLabelSetVerticalAlign(label[serialLogs], "center")
    -- Button
    button[serialLogs] = guiCreateButton(0.74, 0.05, 0.24, 0.08, "Check", true, serialLogs)
    -- serialLogs
    memo[serialLogs] = guiCreateMemo(0.02, 0.14, 0.96, 0.82, "Serial must be exact", true, serialLogs)
    guiMemoSetReadOnly(memo[serialLogs], true)
    -- Tab 3
    ipLogs = guiCreateTab("IP Logs", tabPanel)
    -- Edit
    edit[ipLogs] = guiCreateEdit(124, 13, 236, 23, "", false, ipLogs)
    -- Label
    label[ipLogs] = guiCreateLabel(0.01, 0.04, 0.22, 0.09, "IP Address", true, ipLogs)
    guiSetFont(label[ipLogs], "default-bold-small")
    guiLabelSetHorizontalAlign(label[ipLogs], "right", false)
    guiLabelSetVerticalAlign(label[ipLogs], "center")
    -- Button
    button[ipLogs] = guiCreateButton(0.74, 0.05, 0.24, 0.08, "Check", true, ipLogs)
    -- Memo
    memo[ipLogs] = guiCreateMemo(0.02, 0.14, 0.96, 0.82, "IP Address name must be exact", true, ipLogs)
    guiMemoSetReadOnly(memo[ipLogs], true)
    -- Event handlers
    addEventHandler("onClientGUIClick", closeButton, closeGUI, false)
    addEventHandler("onClientGUIClick", button[accountLogs], getAccountLogs, false)
    addEventHandler("onClientGUIClick", button[serialLogs], getSerialLogs, false)
    addEventHandler("onClientGUIClick", button[ipLogs], getIPLogs, false)
end

function getAccountLogs(btn)
    if (btn ~= "left") then
        return false 
    end
    if (btn ~= "left") then
        return false 
    end
    triggerServerEvent("CSGlogging.getLogs", localPlayer, "account", guiGetText(edit[accountLogs]))
end

function getSerialLogs(btn)
    if (btn ~= "left") then
        return false 
    end
    if (btn ~= "left") then
        return false 
    end
    triggerServerEvent("CSGlogging.getLogs", localPlayer, "serial", guiGetText(edit[serialLogs]))
end

function getIPLogs(btn)
    if (btn ~= "left") then
        return false 
    end
    triggerServerEvent("CSGlogging.getLogs", localPlayer, "ip", guiGetText(edit[ipLogs]))
end

function closeGUI(btn)
    if (btn ~= "left") then
        return false 
    end
    -- Close GUI
    guiSetVisible(loggingWindow, false)
    showCursor(false)
end

function searchFunction(_, ...)
    if (not guiGetVisible(loggingWindow)) then
        return false 
    end
    local msg = table.concat({...}, " ")
    local text = split(guiGetText(memo[guiGetSelectedTab(tabPanel)]), "\n")
    local toShow = ""
    for i, v in ipairs(text) do
        if (v:find(msg)) then
            toShow = toShow..v.."\n"
        end
    end
    guiSetText(memo[guiGetSelectedTab(tabPanel)], toShow)
end
addCommandHandler("search", searchFunction)

function togGUI()
    openWindow()
    local vis = (not guiGetVisible(loggingWindow))
    guiSetVisible(loggingWindow, vis)
    showCursor(vis)
    if (vis) then
        guiSetInputMode("no_binds_when_editing")
    end
end
addEvent("CSGlogging.gui", true)
addEventHandler("CSGlogging.gui", root, togGUI)

function recieveInformation(info)
    guiSetText(memo[guiGetSelectedTab(tabPanel)], info)
end
addEvent("CSGlogging.info", true)
addEventHandler("CSGlogging.info", root, recieveInformation)
