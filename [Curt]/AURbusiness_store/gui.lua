
GUIEditor = {
    tab = {},
    tabpanel = {},
    label = {},
    button = {},
    window = {},
    memo = {}
}

local screenW, screenH = guiGetScreenSize()
GUIEditor.window[1] = guiCreateWindow((screenW - 660) / 2, (screenH - 389) / 2, 660, 389, "AuroraRPG - Business", false)
guiWindowSetSizable(GUIEditor.window[1], false)
guiSetProperty(GUIEditor.window[1], "CaptionColour", "FF0B84FE")

GUIEditor.label[1] = guiCreateLabel(10, 26, 639, 15, "Business Information", false, GUIEditor.window[1])
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
GUIEditor.memo[1] = guiCreateMemo(10, 45, 630, 148, "Business Name: N/A\nBusiness Type: N/A\nBusiness Owner: N/A\nEarnings per hour: N/A\n\nAbout this business:\nN/A", false, GUIEditor.window[1])
guiMemoSetReadOnly(GUIEditor.memo[1], true)
GUIEditor.tabpanel[1] = guiCreateTabPanel(12, 198, 638, 164, false, GUIEditor.window[1])

GUIEditor.tab[1] = guiCreateTab("Options", GUIEditor.tabpanel[1])

GUIEditor.button[1] = guiCreateButton(241, 46, 140, 37, "Take Ownership", false, GUIEditor.tab[1])
GUIEditor.label[2] = guiCreateLabel(4, 87, 624, 15, "Price: $-----", false, GUIEditor.tab[1])
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
GUIEditor.label[3] = guiCreateLabel(4, 102, 624, 15, "This requires that you have a business.", false, GUIEditor.tab[1])
guiSetFont(GUIEditor.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)

GUIEditor.tab[2] = guiCreateTab("Management", GUIEditor.tabpanel[1])

GUIEditor.button[2] = guiCreateButton(10, 45, 146, 33, "Sell this business", false, GUIEditor.tab[2])
GUIEditor.label[4] = guiCreateLabel(4, 88, 634, 15, "5 days without activity on this business then this business will be on sale.", false, GUIEditor.tab[2])
guiSetFont(GUIEditor.label[4], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
GUIEditor.label[5] = guiCreateLabel(4, 107, 634, 15, "Time to Restock: 0H 0M 0S", false, GUIEditor.tab[2])
guiSetFont(GUIEditor.label[5], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
GUIEditor.button[3] = guiCreateButton(10, 10, 146, 31, "Restock items", false, GUIEditor.tab[2])
GUIEditor.label[6] = guiCreateLabel(166, 20, 462, 15, "Items Required: 20x Item | 500x Item | 300x Item", false, GUIEditor.tab[2])
guiSetFont(GUIEditor.label[6], "default-bold-small")


GUIEditor.button[4] = guiCreateButton(511, 366, 129, 13, "Close", false, GUIEditor.window[1])    
