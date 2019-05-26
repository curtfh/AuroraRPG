local vip = {
    tab = {},
    radiobutton = {},
    tabpanel = {},
    label = {},
	label_new = {},
    button = {},
	button_new = {},
    window = {},
    gridlist = {},
    edit = {},
	rlabel = {},
    rwindow = {},
    rbutton = {},
}

vipFW = {
    button = {},
    window = {},
    label = {},
    radiobutton = {}
}

local selectedID = {
	one = {},
	two = {},
	three = {},
}

local enabled = false
local screenWidth, screenHeight = guiGetScreenSize()

local aObjects ={
        { "Grass Hat", 861,scale=0.5},
        { "Grass Hat 2", 862,scale=0.5 },
        { "Pizza Box", 2814 },
        { "Roulete", 1895,scale=0.3 },
        { "Car model", 2485 },
        { "Ventilator", 1661,scale=0.7 },
		{ "Green Flag", 2993 },
		{ "TV", 1518,scale=0.7},
		{ "Arrow", 1318,scale=0.5 },
	    { "Tree", 811,scale=0.3 },
		{ "Skull",1254},
		{ "Dolphin",1607,scale=0.05},
		{ "Parking Sign",1233,scale=0.3},
        { "WW2 Hat", 2053 },
		{ "Captain 3", 2054 },
		{ "Donuts",  2222},
     	{ "Hoop",  1316, scale=0.1},
		{ "Turtle",1609,scale=0.1},
		{ "SAM",3267,scale=0.2},
		{ "MG",2985,scale=0.5},
		{ "Money",1274,scale=3},
		{ "Para",3108,scale=0.1},
		{ "Torch",3461,scale=0.5},
		{ "Remove hat" },
}

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		windowWidth, windowHeight = 634, 523
		windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
		vip.window[1] = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "AuroraRPG Shop BETA 1.0", false)
        guiWindowSetSizable(vip.window[1], false)
        guiSetAlpha(vip.window[1], 1.00)
		guiSetVisible(vip.window[1], false)

        vip.label[1] = guiCreateLabel(196, 21, 251, 44, "Purchase goods, benefits and even VIP!", false, vip.window[1])
        guiSetFont(vip.label[1], "clear-normal")
        guiLabelSetColor(vip.label[1], 0, 254, 192)
        guiLabelSetHorizontalAlign(vip.label[1], "center", false)
        guiLabelSetVerticalAlign(vip.label[1], "center")
        vip.tabpanel[1] = guiCreateTabPanel(9, 57, 615, 456, false, vip.window[1])

        vip.tab[1] = guiCreateTab("APS", vip.tabpanel[1])

        vip.label[2] = guiCreateLabel(186, 5, 258, 41, "The premium panel is currently under\nmaintenence, some features are not available.", false, vip.tab[1])
        guiLabelSetColor(vip.label[2], 0, 254, 192)
        guiLabelSetHorizontalAlign(vip.label[2], "center", false)
        guiLabelSetVerticalAlign(vip.label[2], "center")
        vip.label[3] = guiCreateLabel(5, 5, 181, 15, "Your APS Points: ", false, vip.tab[1])
        guiSetFont(vip.label[3], "default-bold-small")
        guiLabelSetVerticalAlign(vip.label[3], "center")
        vip.edit[1] = guiCreateEdit(5, 79, 186, 27, "Hours (Max: 50)", false, vip.tab[1])
        vip.label[4] = guiCreateLabel(5, 60, 181, 15, "L1 VIP = 1000 APS/Hour", false, vip.tab[1])
        guiSetFont(vip.label[4], "default-bold-small")
        guiLabelSetVerticalAlign(vip.label[4], "center")
        vip.button[9] = guiCreateButton(192, 79, 106, 27, "Purchase", false, vip.tab[1])
        guiSetFont(vip.button[9], "default-bold-small")
        guiSetProperty(vip.button[9], "NormalTextColour", "FFAAAAAA")
        vip.label[5] = guiCreateLabel(5, 122, 293, 15, "L2+L3 VIP = Donate on forums, copy address below", false, vip.tab[1])
        guiSetFont(vip.label[5], "default-bold-small")
        guiLabelSetVerticalAlign(vip.label[5], "center")
        vip.edit[2] = guiCreateEdit(5, 141, 186, 27, "https://aurorarpg.com/aps/", false, vip.tab[1])
        guiEditSetReadOnly(vip.edit[2], true)
        vip.button[10] = guiCreateButton(192, 141, 106, 27, "Copy Link", false, vip.tab[1])
        guiSetFont(vip.button[10], "default-bold-small")
        guiSetProperty(vip.button[10], "NormalTextColour", "FFAAAAAA")
        vip.label[6] = guiCreateLabel(414, 46, 181, 15, "Aurora Goods", false, vip.tab[1])
        guiLabelSetColor(vip.label[6], 232, 87, 16)
        guiLabelSetHorizontalAlign(vip.label[6], "center", false)
        guiLabelSetVerticalAlign(vip.label[6], "center")
        vip.label[7] = guiCreateLabel(400, 68, 99, 27, "Price: 100 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[7], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[7], "center")
        vip.button[1] = guiCreateButton(499, 68, 106, 27, "VIP Car", false, vip.tab[1])
        guiSetFont(vip.button[1], "default-bold-small")
        guiSetProperty(vip.button[1], "NormalTextColour", "FFAAAAAA")
        vip.label[8] = guiCreateLabel(400, 99, 99, 27, "Price: 50 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[8], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[8], "center")
        vip.button[11] = guiCreateButton(499, 99, 106, 27, "Nitro x2", false, vip.tab[1])
        guiSetFont(vip.button[11], "default-bold-small")
        guiSetProperty(vip.button[11], "NormalTextColour", "FFAAAAAA")
        vip.label[9] = guiCreateLabel(400, 130, 99, 27, "Price: 150 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[9], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[9], "center")
        vip.button[15] = guiCreateButton(499, 130, 106, 27, "Music Access", false, vip.tab[1])
        guiSetFont(vip.button[15], "default-bold-small")
        guiSetProperty(vip.button[15], "NormalTextColour", "FFAAAAAA")
        vip.label[11] = guiCreateLabel(400, 162, 99, 27, "Price: 50 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[11], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[11], "center")
        vip.button[7] = guiCreateButton(499, 162, 106, 27, "Armour", false, vip.tab[1])
        guiSetFont(vip.button[7], "default-bold-small")
        guiSetProperty(vip.button[7], "NormalTextColour", "FFAAAAAA")
        vip.label[13] = guiCreateLabel(400, 193, 99, 27, "Price: 150 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[13], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[13], "center")
        vip.button[8] = guiCreateButton(499, 193, 106, 27, "Go to base", false, vip.tab[1])
        guiSetFont(vip.button[8], "default-bold-small")
        guiSetProperty(vip.button[8], "NormalTextColour", "FFAAAAAA")
        vip.label[14] = guiCreateLabel(5, 189, 181, 15, "Aurora Extras", false, vip.tab[1])
        guiLabelSetColor(vip.label[14], 232, 87, 16)
        guiLabelSetHorizontalAlign(vip.label[14], "center", false)
        guiLabelSetVerticalAlign(vip.label[14], "center")
        vip.gridlist[1] = guiCreateGridList(5, 210, 187, 212, false, vip.tab[1])
        guiGridListAddColumn(vip.gridlist[1], "VIP Hats", 0.8)
        vip.button[2] = guiCreateButton(196, 210, 106, 27, "Toggle (50 APS)", false, vip.tab[1])
        guiSetFont(vip.button[2], "default-bold-small")
        guiSetProperty(vip.button[2], "NormalTextColour", "FFAAAAAA")
        vip.button[3] = guiCreateButton(196, 241, 106, 27, "Remove", false, vip.tab[1])
        guiSetFont(vip.button[3], "default-bold-small")
        guiSetProperty(vip.button[3], "NormalTextColour", "FFAAAAAA")
        vip.label[15] = guiCreateLabel(365, 230, 181, 15, "Aurora Legitimates", false, vip.tab[1])
        guiLabelSetColor(vip.label[15], 232, 87, 16)
        guiLabelSetHorizontalAlign(vip.label[15], "center", false)
        guiLabelSetVerticalAlign(vip.label[15], "center")
        vip.radiobutton[1] = guiCreateRadioButton(318, 258, 72, 15, "Yakuza", false, vip.tab[1])
        vip.radiobutton[2] = guiCreateRadioButton(391, 258, 72, 15, "James", false, vip.tab[1])
        vip.radiobutton[3] = guiCreateRadioButton(463, 258, 57, 15, "Joker", false, vip.tab[1])
        vip.radiobutton[4] = guiCreateRadioButton(529, 258, 72, 15, "Hitman", false, vip.tab[1])
        vip.label[16] = guiCreateLabel(308, 296, 283, 15, "Each skin costs 500 APS (Free for donors)", false, vip.tab[1])
        vip.label[29] = guiCreateLabel(128, 296, 283, 15, "APS Misc", false, vip.tab[1])
        guiSetFont(vip.label[16], "default-small")
        guiSetFont(vip.label[29], "default-small")
        guiLabelSetColor(vip.label[16], 236, 79, 255)
        guiLabelSetColor(vip.label[29], 236, 79, 255)
        guiLabelSetHorizontalAlign(vip.label[16], "center", false)
        guiLabelSetHorizontalAlign(vip.label[29], "center", false)
        guiLabelSetVerticalAlign(vip.label[16], "center")
        guiLabelSetVerticalAlign(vip.label[29], "center")
        vip.button[4] = guiCreateButton(391, 321, 106, 27, "Toggle Skin", false, vip.tab[1])
        guiSetFont(vip.button[4], "default-bold-small")
        guiSetProperty(vip.button[4], "NormalTextColour", "FFAAAAAA")
        vip.button[12] = guiCreateButton(499, 321, 106, 27, "Remove Skin", false, vip.tab[1])
        guiSetFont(vip.button[12], "default-bold-small")
        guiSetProperty(vip.button[12], "NormalTextColour", "FFAAAAAA")
        vip.label[17] = guiCreateLabel(386, 364, 99, 27, "Price: 70 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[17], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[17], "center")
        vip.button[13] = guiCreateButton(499, 364, 106, 27, "Insta Fix", false, vip.tab[1])
        guiSetFont(vip.button[13], "default-bold-small")
        guiSetProperty(vip.button[13], "NormalTextColour", "FFAAAAAA")
        vip.label[18] = guiCreateLabel(386, 391, 99, 27, "Price: 300 APS", false, vip.tab[1])
        guiLabelSetColor(vip.label[18], 3, 251, 172)
        guiLabelSetVerticalAlign(vip.label[18], "center")
        vip.button[14] = guiCreateButton(499, 395, 106, 27, "Get Infernus", false, vip.tab[1])
        guiSetFont(vip.button[14], "default-bold-small")
        guiSetProperty(vip.button[14], "NormalTextColour", "FFAAAAAA")
        --vip.edit[3] = guiCreateEdit(194, 391, 186, 27, "Enter amount to purchase", false, vip.tab[1])
        vip.button[5] = guiCreateButton(196, 321, 106, 27, "Smoke", false, vip.tab[1])
        guiSetFont(vip.button[5], "default-bold-small")
        guiSetProperty(vip.button[5], "NormalTextColour", "FFAAAAAA")
        --vip.label[27] = guiCreateLabel(196, 364, 184, 22, "Purchase Rate: $10,000 per APS", false, vip.tab[1])
        --guiSetFont(vip.label[27], "default-small")
        --guiLabelSetColor(vip.label[27], 3, 251, 172)
        --guiLabelSetHorizontalAlign(vip.label[27], "center", false)
        --guiLabelSetVerticalAlign(vip.label[27], "center")
		vip.button[45] = guiCreateButton(196, 358, 106, 27, "Headless", false, vip.tab[1])
		guiSetFont(vip.button[45], "default-bold-small")
		guiSetProperty(vip.button[45], "NormalTextColour", "FFAAAAAA")
		vip.button[46] = guiCreateButton(196, 395, 106, 27, "Drink", false, vip.tab[1])
		guiSetFont(vip.button[46], "default-bold-small")
		guiSetProperty(vip.button[46], "NormalTextColour", "FFAAAAAA")
		vip.label[30] = guiCreateLabel(292, 321, 99, 27, "APS: 400", false, vip.tab[1])
		guiLabelSetColor(vip.label[30], 3, 251, 172)
		guiLabelSetHorizontalAlign(vip.label[30], "center", false)
		guiLabelSetVerticalAlign(vip.label[30], "center")
		vip.label[31] = guiCreateLabel(292, 358, 99, 27, "APS: 20", false, vip.tab[1])
		guiLabelSetColor(vip.label[31], 3, 251, 172)
		guiLabelSetHorizontalAlign(vip.label[31], "center", false)
		guiLabelSetVerticalAlign(vip.label[31], "center")
		vip.label[32] = guiCreateLabel(292, 395, 99, 27, "APS: 250", false, vip.tab[1])
		guiLabelSetColor(vip.label[32], 3, 251, 172)
		guiLabelSetHorizontalAlign(vip.label[32], "center", false)
		guiLabelSetVerticalAlign(vip.label[32], "center")
        vip.radiobutton[5] = guiCreateRadioButton(381, 277, 72, 15, "Ghost", false, vip.tab[1])
        vip.radiobutton[6] = guiCreateRadioButton(453, 277, 83, 15, "Spiderman", false, vip.tab[1])

        vip.tab[2] = guiCreateTab("Premium", vip.tabpanel[1])

        vip.label[19] = guiCreateLabel(6, 5, 181, 15, "Premium Hours: ", false, vip.tab[2])
        vip.label[28] = guiCreateLabel(6, 20, 181, 15, "Premium Level: ", false, vip.tab[2])
        guiSetFont(vip.label[19], "default-bold-small")
        guiSetFont(vip.label[28], "default-bold-small")
        guiLabelSetVerticalAlign(vip.label[19], "center")
        guiLabelSetVerticalAlign(vip.label[28], "center")
        vip.label[20] = guiCreateLabel(187, 5, 258, 41, "All features on this tab are free for L3 donators\nL2 VIP's will not get all features of this tab!", false, vip.tab[2])
        guiLabelSetColor(vip.label[20], 0, 254, 192)
        guiLabelSetHorizontalAlign(vip.label[20], "center", false)
        guiLabelSetVerticalAlign(vip.label[20], "center")
        vip.label[21] = guiCreateLabel(6, 56, 181, 15, "Aurora L1-L3 Features", false, vip.tab[2])
        guiLabelSetColor(vip.label[21], 232, 87, 16)
        guiLabelSetHorizontalAlign(vip.label[21], "center", false)
        guiLabelSetVerticalAlign(vip.label[21], "center")
        vip.button[16] = guiCreateButton(6, 81, 87, 28, "Prem Advert", false, vip.tab[2])
        guiSetFont(vip.button[16], "clear-normal")
        guiSetProperty(vip.button[16], "NormalTextColour", "FFAAAAAA")
        vip.button[17] = guiCreateButton(100, 81, 87, 28, "Toggle Chat", false, vip.tab[2])
        guiSetFont(vip.button[17], "clear-normal")
        guiSetProperty(vip.button[17], "NormalTextColour", "FFAAAAAA")
        vip.button[18] = guiCreateButton(6, 113, 87, 28, "Prem Car", false, vip.tab[2])
        guiSetFont(vip.button[18], "clear-normal")
        guiSetProperty(vip.button[18], "NormalTextColour", "FFAAAAAA")
        vip.button[19] = guiCreateButton(100, 113, 87, 28, "Prem Plane", false, vip.tab[2])
        guiSetFont(vip.button[19], "clear-normal")
        guiSetProperty(vip.button[19], "NormalTextColour", "FFAAAAAA")
        vip.button[20] = guiCreateButton(6, 145, 87, 28, "Heal (15HP)", false, vip.tab[2])
        guiSetFont(vip.button[20], "clear-normal")
        guiSetProperty(vip.button[20], "NormalTextColour", "FFAAAAAA")
        vip.button[21] = guiCreateButton(100, 145, 87, 28, "Nitro x2", false, vip.tab[2])
        guiSetFont(vip.button[21], "clear-normal")
        guiSetProperty(vip.button[21], "NormalTextColour", "FFAAAAAA")
        vip.button[22] = guiCreateButton(6, 177, 87, 28, "Armour", false, vip.tab[2])
        guiSetFont(vip.button[22], "clear-normal")
        guiSetProperty(vip.button[22], "NormalTextColour", "FFAAAAAA")
        vip.button[23] = guiCreateButton(100, 177, 87, 28, "Veh color", false, vip.tab[2])
        guiSetFont(vip.button[23], "clear-normal")
        guiSetProperty(vip.button[23], "NormalTextColour", "FFAAAAAA")
        vip.gridlist[2] = guiCreateGridList(7, 208, 180, 179, false, vip.tab[2])
        guiGridListAddColumn(vip.gridlist[2], "Premium Hats", 0.8)
        vip.button[24] = guiCreateButton(6, 394, 87, 28, "Toggle Hat", false, vip.tab[2])
        guiSetFont(vip.button[24], "clear-normal")
        guiSetProperty(vip.button[24], "NormalTextColour", "FFAAAAAA")
        vip.button[25] = guiCreateButton(100, 394, 87, 28, "Remove Hat", false, vip.tab[2])
        guiSetFont(vip.button[25], "clear-normal")
        guiSetProperty(vip.button[25], "NormalTextColour", "FFAAAAAA")
        vip.label[22] = guiCreateLabel(316, 56, 181, 15, "Aurora L3 Features", false, vip.tab[2])
        guiLabelSetColor(vip.label[22], 232, 87, 16)
        guiLabelSetHorizontalAlign(vip.label[22], "center", false)
        guiLabelSetVerticalAlign(vip.label[22], "center")
        vip.button[26] = guiCreateButton(229, 81, 87, 28, "Heal (50HP)", false, vip.tab[2])
        guiSetFont(vip.button[26], "clear-normal")
        guiSetProperty(vip.button[26], "NormalTextColour", "FFAAAAAA")
        vip.button[27] = guiCreateButton(229, 113, 87, 28, "Prem Shamal", false, vip.tab[2])
        guiSetFont(vip.button[27], "clear-normal")
        guiSetProperty(vip.button[27], "NormalTextColour", "FFAAAAAA")
        vip.button[28] = guiCreateButton(229, 145, 87, 28, "Nitro x10", false, vip.tab[2])
        guiSetFont(vip.button[28], "clear-normal")
        guiSetProperty(vip.button[28], "NormalTextColour", "FFAAAAAA")
        vip.button[29] = guiCreateButton(229, 177, 87, 28, "Play Music", false, vip.tab[2])
        vip.button[47] = guiCreateButton(229, 209, 87, 28, "Stop Music", false, vip.tab[2])
        guiSetFont(vip.button[29], "clear-normal")
        guiSetFont(vip.button[47], "clear-normal")
        guiSetProperty(vip.button[29], "NormalTextColour", "FFAAAAAA")
        guiSetProperty(vip.button[47], "NormalTextColour", "FFAAAAAA")
        vip.edit[4] = guiCreateEdit(321, 178, 267, 27, "Enter a valid link here", false, vip.tab[2])
        vip.button[30] = guiCreateButton(321, 145, 87, 28, "Toggle Pack", false, vip.tab[2])
        guiSetFont(vip.button[30], "clear-normal")
        guiSetProperty(vip.button[30], "NormalTextColour", "FFAAAAAA")
        vip.button[31] = guiCreateButton(410, 145, 87, 28, "Remove Pack", false, vip.tab[2])
        guiSetFont(vip.button[31], "clear-normal")
        guiSetProperty(vip.button[31], "NormalTextColour", "FFAAAAAA")
        vip.button[32] = guiCreateButton(501, 145, 87, 28, "Ghostmode", false, vip.tab[2])
        guiSetFont(vip.button[21], "clear-normal")
        guiSetProperty(vip.button[32], "NormalTextColour", "FFAAAAAA")
        vip.label[23] = guiCreateLabel(263, 204, 347, 18, "Play music again to stop previous music!", false, vip.tab[2])
        guiSetFont(vip.label[23], "default-small")
        guiLabelSetColor(vip.label[23], 236, 79, 255)
        guiLabelSetHorizontalAlign(vip.label[23], "center", false)
        guiLabelSetVerticalAlign(vip.label[23], "center")
        vip.button[33] = guiCreateButton(321, 81, 146, 28, "Request Direct Help", false, vip.tab[2])
        guiSetFont(vip.button[33], "clear-normal")
        guiSetProperty(vip.button[3], "NormalTextColour", "FFAAAAAA")
        vip.button[34] = guiCreateButton(321, 113, 146, 28, "Fast Travel", false, vip.tab[2])
        guiSetFont(vip.button[34], "clear-normal")
        guiSetProperty(vip.button[34], "NormalTextColour", "FFAAAAAA")
        vip.button[35] = guiCreateButton(471, 81, 117, 28, "On Death Bomb", false, vip.tab[2])
        guiSetFont(vip.button[35], "clear-normal")
        guiSetProperty(vip.button[35], "NormalTextColour", "FFAAAAAA")
        vip.button[36] = guiCreateButton(471, 113, 117, 28, "Custom Title", false, vip.tab[2])
        guiSetFont(vip.button[36], "clear-normal")
        guiSetProperty(vip.button[36], "NormalTextColour", "FFAAAAAA")
        vip.label[24] = guiCreateLabel(320, 228, 181, 15, "Aurora L2/L3 Features", false, vip.tab[2])
        guiLabelSetColor(vip.label[24], 232, 87, 16)
        guiLabelSetHorizontalAlign(vip.label[24], "center", false)
        guiLabelSetVerticalAlign(vip.label[24], "center")
        vip.radiobutton[7] = guiCreateRadioButton(253, 253, 81, 15, "Yakuza", false, vip.tab[2])
        vip.radiobutton[8] = guiCreateRadioButton(334, 253, 81, 15, "James", false, vip.tab[2])
        guiRadioButtonSetSelected(vip.radiobutton[4], true)
        vip.radiobutton[9] = guiCreateRadioButton(415, 253, 81, 15, "Joker", false, vip.tab[2])
        vip.radiobutton[10] = guiCreateRadioButton(497, 253, 81, 15, "Hitman", false, vip.tab[2])
        vip.radiobutton[11] = guiCreateRadioButton(253, 273, 81, 15, "Spiderman", false, vip.tab[2])
        vip.radiobutton[12] = guiCreateRadioButton(334, 273, 81, 15, "Ghost", false, vip.tab[2])
        vip.radiobutton[13] = guiCreateRadioButton(415, 273, 81, 15, "Robber", false, vip.tab[2])
        vip.radiobutton[14] = guiCreateRadioButton(497, 273, 81, 15, "Harley Quin", false, vip.tab[2])
        vip.button[37] = guiCreateButton(247, 298, 87, 28, "Toggle Skin", false, vip.tab[2])
        guiSetFont(vip.button[37], "clear-normal")
        guiSetProperty(vip.button[37], "NormalTextColour", "FFAAAAAA")
        vip.button[38] = guiCreateButton(340, 298, 87, 28, "Remove Skin", false, vip.tab[2])
        guiSetFont(vip.button[38], "clear-normal")
        guiSetProperty(vip.button[38], "NormalTextColour", "FFAAAAAA")
        vip.label[25] = guiCreateLabel(413, 298, 187, 24, "Select a skin of your choice!", false, vip.tab[2])
        guiSetFont(vip.label[25], "default-small")
        guiLabelSetColor(vip.label[25], 236, 79, 255)
        guiLabelSetHorizontalAlign(vip.label[25], "center", false)
        guiLabelSetVerticalAlign(vip.label[25], "center")
        vip.button[39] = guiCreateButton(432, 332, 87, 28, "Smoke", false, vip.tab[2])
        guiSetFont(vip.button[39], "clear-normal")
        guiSetProperty(vip.button[39], "NormalTextColour", "FFAAAAAA")
        vip.button[40] = guiCreateButton(523, 332, 87, 28, "Drink", false, vip.tab[2])
        guiSetFont(vip.button[40], "clear-normal")
        guiSetProperty(vip.button[40], "NormalTextColour", "FFAAAAAA")
        vip.button[41] = guiCreateButton(340, 332, 87, 28, "Headless", false, vip.tab[2])
        guiSetFont(vip.button[41], "clear-normal")
        guiSetProperty(vip.button[41], "NormalTextColour", "FFAAAAAA")
        vip.button[42] = guiCreateButton(247, 332, 87, 28, "Walk Style", false, vip.tab[2])
        guiSetFont(vip.button[42], "clear-normal")
        guiSetProperty(vip.button[42], "NormalTextColour", "FFAAAAAA")
        vip.label[26] = guiCreateLabel(263, 356, 347, 18, "Click buttons again to start/remove effect!", false, vip.tab[2])
        guiSetFont(vip.label[26], "default-small")
        guiLabelSetColor(vip.label[26], 236, 79, 255)
        guiLabelSetHorizontalAlign(vip.label[26], "center", false)
        guiLabelSetVerticalAlign(vip.label[26], "center")
        vip.button[43] = guiCreateButton(247, 384, 146, 28, "Spawn at base", false, vip.tab[2])
        guiSetFont(vip.button[43], "clear-normal")
        guiSetProperty(vip.button[43], "NormalTextColour", "FFAAAAAA")
        vip.button[44] = guiCreateButton(459, 384, 146, 28, "Toggle Lights", false, vip.tab[2])
        guiSetFont(vip.button[44], "clear-normal")
        guiSetProperty(vip.button[44], "NormalTextColour", "FFAAAAAA")

        vip.button[6] = guiCreateButton(589, 23, 35, 24, "X", false, vip.window[1])
        guiSetFont(vip.button[6], "default-bold-small")
        guiSetProperty(vip.button[6], "NormalTextColour", "FFAAAAAA")
        vip.label[12] = guiCreateLabel(154, 49, 347, 18, "Your Premium Status: L1 (50 hours remaining)", false, vip.window[1])
        guiSetFont(vip.label[12], "default-small")
        guiLabelSetColor(vip.label[12], 236, 79, 255)
        guiLabelSetHorizontalAlign(vip.label[12], "center", false)
        guiLabelSetVerticalAlign(vip.label[12], "center")    

		windowWidth_2, windowHeight_2 = 403, 124
		windowX_2, windowY_2 = (screenWidth / 2) - (windowWidth_2 / 2), (screenHeight / 2) - (windowHeight_2 / 2)
		vip.window[2] = guiCreateWindow(windowX_2, windowY_2, windowWidth_2, windowHeight_2, "Aurora Premium - Advertisements", false)
        guiWindowSetSizable(vip.window[2], false)
        guiSetAlpha(vip.window[2], 1.00)
		guiSetVisible(vip.window[2], false)

        vip.label_new[1] = guiCreateLabel(81, 23, 248, 21, "Enter an advertisement then click \"Advert\"", false, vip.window[2])
        guiLabelSetColor(vip.label_new[1], 5, 249, 228)
        guiLabelSetHorizontalAlign(vip.label_new[1], "center", false)
        vip.edit[5] = guiCreateEdit(9, 49, 384, 31, "", false, vip.window[2])
        vip.button_new[1] = guiCreateButton(10, 84, 107, 30, "Advert", false, vip.window[2])
        guiSetFont(vip.button_new[1], "default-bold-small")
        guiSetProperty(vip.button_new[1], "NormalTextColour", "FFAAAAAA")
        vip.button_new[2] = guiCreateButton(361, 23, 32, 20, "X", false, vip.window[2])
        guiSetFont(vip.button_new[2], "clear-normal")
        guiSetProperty(vip.button_new[2], "NormalTextColour", "FFAAAAAA")
        vip.label_new[2] = guiCreateLabel(127, 90, 248, 21, "You can only use this feature once every 45 mins!", false, vip.window[2])
        guiSetFont(vip.label_new[2], "default-small")
        guiLabelSetColor(vip.label_new[2], 252, 106, 243)
        guiLabelSetHorizontalAlign(vip.label_new[2], "center", false)
		
		windowWidth_3, windowHeight_3 = 417, 159
		windowX_3, windowY_3 = (screenWidth / 2) - (windowWidth_3 / 2), (screenHeight / 2) - (windowHeight_3 / 2)
		vipFW.window[1] = guiCreateWindow(windowX_3, windowY_3, windowWidth_3, windowHeight_3, "Select your warp destination", false)
        guiWindowSetSizable(vipFW.window[1], false)
        guiSetAlpha(vipFW.window[1], 1.00)
		guiSetVisible(vipFW.window[1], false)

        vipFW.radiobutton[1] = guiCreateRadioButton(9, 22, 191, 15, "Los Santos (Hospital)", false, vipFW.window[1])
        vipFW.radiobutton[2] = guiCreateRadioButton(9, 41, 191, 15, "Los Santos (Airport)", false, vipFW.window[1])
        vipFW.radiobutton[3] = guiCreateRadioButton(9, 61, 191, 15, "Los Santos (Police Station)", false, vipFW.window[1])
        vipFW.radiobutton[4] = guiCreateRadioButton(9, 80, 191, 15, "Los Santos (Bank)", false, vipFW.window[1])
        vipFW.radiobutton[5] = guiCreateRadioButton(9, 99, 191, 15, "Los Santos (Drug Shipment)", false, vipFW.window[1])
        vipFW.radiobutton[6] = guiCreateRadioButton(216, 22, 191, 15, "Las Venturas (Casino)", false, vipFW.window[1])
        vipFW.radiobutton[7] = guiCreateRadioButton(216, 41, 191, 15, "Las Venturas (Hospital)", false, vipFW.window[1])
        vipFW.radiobutton[8] = guiCreateRadioButton(216, 61, 191, 15, "Las Venturas (Airport)", false, vipFW.window[1])
        vipFW.radiobutton[9] = guiCreateRadioButton(216, 80, 191, 15, "Las Venturas (Air Strip)", false, vipFW.window[1])
        vipFW.radiobutton[10] = guiCreateRadioButton(216, 99, 191, 15, "San Fierro (Airport)", false, vipFW.window[1])
        guiRadioButtonSetSelected(vipFW.radiobutton[10], true)
        vipFW.button[1] = guiCreateButton(9, 122, 118, 30, "Warp To Location", false, vipFW.window[1])
        guiSetProperty(vipFW.button[1], "NormalTextColour", "FFAAAAAA")
        vipFW.button[2] = guiCreateButton(376, 21, 31, 16, "X", false, vipFW.window[1])
        guiSetProperty(vipFW.button[2], "NormalTextColour", "FFAAAAAA")
        vipFW.label[1] = guiCreateLabel(129, 123, 278, 19, "You may warp to any location once every 60 mins!", false, vipFW.window[1])
        guiSetFont(vipFW.label[1], "default-small")
        guiLabelSetColor(vipFW.label[1], 255, 0, 0)
        guiLabelSetHorizontalAlign(vipFW.label[1], "center", false)
        guiLabelSetVerticalAlign(vipFW.label[1], "center")
		
		--Disable Buttons For Panel (Tab 1)
		guiSetEnabled(vip.button[1], false)
		guiSetEnabled(vip.button[2], false)
		guiSetEnabled(vip.button[3], false)
		guiSetEnabled(vip.button[4], false)
		guiSetEnabled(vip.button[5], false)
		guiSetEnabled(vip.button[6], false)
		guiSetEnabled(vip.button[7], false)
		guiSetEnabled(vip.button[8], false)
		guiSetEnabled(vip.button[9], false)
		--guiSetEnabled(vip.button[10], false) Copy Link
		guiSetEnabled(vip.button[11], false)
		guiSetEnabled(vip.button[12], false)
		guiSetEnabled(vip.button[13], false)
		guiSetEnabled(vip.button[14], false)
		guiSetEnabled(vip.button[15], false)
		--Disable Buttons For Panel (Tab 1)
		guiSetEnabled(vip.button[16], false)
		guiSetEnabled(vip.button[17], false)
		guiSetEnabled(vip.button[18], false)
		guiSetEnabled(vip.button[19], false)
		guiSetEnabled(vip.button[20], false)
		guiSetEnabled(vip.button[21], false)
		guiSetEnabled(vip.button[22], false)
		guiSetEnabled(vip.button[23], false)
		guiSetEnabled(vip.button[24], false)
		guiSetEnabled(vip.button[25], false)
		guiSetEnabled(vip.button[26], false)
		guiSetEnabled(vip.button[27], false)
		guiSetEnabled(vip.button[28], false)
		guiSetEnabled(vip.button[29], false)
		guiSetEnabled(vip.button[30], false)
		guiSetEnabled(vip.button[31], false)
		guiSetEnabled(vip.button[32], false)
		guiSetEnabled(vip.button[33], false)
		guiSetEnabled(vip.button[34], false)
		guiSetEnabled(vip.button[35], false)
		guiSetEnabled(vip.button[36], false)
		guiSetEnabled(vip.button[37], false)
		guiSetEnabled(vip.button[38], false)
		guiSetEnabled(vip.button[39], false)
		guiSetEnabled(vip.button[40], false)
		guiSetEnabled(vip.button[41], false)
		guiSetEnabled(vip.button[42], false)
		guiSetEnabled(vip.button[43], false)
		guiSetEnabled(vip.button[44], false)
		guiSetEnabled(vip.button[46], false)
		guiSetEnabled(vip.button[47], false)
		guiSetEnabled(vip.button[45], false)
 
		for k, buttons in pairs(vip.button) do
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[9]) then redirectToPurchase(guiGetText(vip.edit[1])) end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[10]) then setClipboard(guiGetText(vip.edit[2])) outputChatBox("Donation link successfully copied!", 0, 255, 0) end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[1]) then handle_buttons("spawn_vip_car", "aps") elseif (source == vip.button[18]) then handle_buttons("spawn_vip_car", "vipo") elseif (source == vip.button[14]) then handle_buttons("spawn_vip_car", "aps_infernus") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[11]) then handle_buttons("init_nitro", "nitroaps") elseif (source == vip.button[21]) then handle_buttons("init_nitro", "nitrol2") elseif (source == vip.button[28]) then handle_buttons("init_nitro", "nitrol3") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[15]) then handle_buttons("music", "aps") elseif (source == vip.button[15]) then handle_buttons("music", "aps") elseif (source == vip.button[29]) then handle_buttons("music", "vip") elseif (source == vip.button[47]) then handle_buttons("music", "vipstop") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[7]) then handle_buttons("init_armour", "aps") elseif (source == vip.button[22]) then handle_buttons("init_armour", "vip") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[20]) then handle_buttons("heal_player", "vipl2") elseif (source == vip.button[26]) then handle_buttons("heal_player", "vipl3") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[19]) then handle_buttons("spawn_vip_car", "vip_plane") elseif (source == vip.button[27]) then handle_buttons("spawn_vip_car", "vip_shamal") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[30]) then handle_buttons("jetpack", "toggle") elseif (source == vip.button[31]) then handle_buttons("jetpack", "remove") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[17]) then handle_buttons("vipchat", "enable") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[2]) then handle_buttons("ahats", "toggleaps") elseif (source == vip.button[3]) then handle_buttons("ahats", "removeaps") elseif (source == vip.button[24]) then handle_buttons("ahats", "togglevip") elseif (source == vip.button[25]) then handle_buttons("ahats", "removevip") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[17]) then handle_buttons("chat", "toggle")  end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[13]) then handle_buttons("fixveh", "instafix")  end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[23]) then handle_buttons("veh", "color") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[33]) then handle_buttons("help", "request") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[44]) then handle_buttons("lights", "standard") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[36]) then handle_buttons("customtitle", "toggle") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[35]) then handle_buttons("misc", "ondeathbomb") elseif (source == vip.button[32]) then handle_buttons("misc", "ghostmode") elseif (source == vip.button[42]) then handle_buttons("misc", "walkstyle") elseif (source == vip.button[41]) then handle_buttons("misc", "headless") elseif (source == vip.button[45]) then handle_buttons("misc", "apsheadless") elseif (source == vip.button[39]) then handle_buttons("misc", "smoke") elseif (source == vip.button[40]) then handle_buttons("misc", "drink") elseif (source == vip.button[46]) then handle_buttons("misc", "apsdrink") elseif (source == vip.button[5]) then handle_buttons("misc", "apssmoke") end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[4]) then handle_buttons("skins", "apstoggle") elseif (source == vip.button[12]) then handle_buttons("skins", "apsremove") elseif (source == vip.button[37]) then handle_buttons("skins", "viptoggle") elseif (source == vip.button[38]) then handle_buttons("skins", "vipremove")  end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[8]) then handle_buttons("basespawn", "apsbasespawn") elseif (source == vip.button[43]) then handle_buttons("basespawn", "spawnatvipbase")  end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[6]) then if (guiGetVisible(vip.window[1])) then guiSetVisible(vip.window[1], false) showCursor(false) for i=1, 44 do if (guiGetEnabled(vip.button[i])) then guiSetEnabled(vip.button[i], false) end end end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[16]) then if (guiGetVisible(vip.window[1])) then guiSetInputEnabled(not guiGetInputEnabled()) guiSetVisible(vip.window[1], false) guiSetVisible(vip.window[2], true) end end end)
			addEventHandler("onClientGUIClick", buttons, function() if (source == vip.button[34]) then if (guiGetVisible(vip.window[1])) then guiSetVisible(vip.window[1], false) guiSetVisible(vipFW.window[1], true) end end end)
		end
		for index, buttonz in pairs(vip.button_new) do
			addEventHandler("onClientGUIClick", buttonz, function() if (source == vip.button_new[1]) then handle_buttons("vipadvert", guiGetText(vip.edit[5])) guiSetInputEnabled(not guiGetInputEnabled()) open_panel() end end)
			addEventHandler("onClientGUIClick", buttonz, function() if (source == vip.button_new[2]) then if (guiGetVisible(vip.window[2])) then guiSetInputEnabled(not guiGetInputEnabled()) guiSetVisible(vip.window[1], true) guiSetVisible(vip.window[2], false) end end end)
		end
		for k_, buttons_ in pairs(vipFW.button) do
			addEventHandler("onClientGUIClick", buttons_, function() if (source == vipFW.button[1]) then handle_buttons("misc", "fasttravel") open_panel() end end)
			addEventHandler("onClientGUIClick", buttons_, function() if (source == vipFW.button[2]) then open_panel() end end)
		end
		for i, m_obj in ipairs(aObjects) do
			hRow = guiGridListAddRow(vip.gridlist[1])
			hRow_2 = guiGridListAddRow(vip.gridlist[2])
			guiGridListSetItemText(vip.gridlist[1], hRow, 1, tostring(m_obj[1]), false, false)
			guiGridListSetItemText(vip.gridlist[2], hRow_2, 1, tostring(m_obj[1]), false, false)
			if m_obj[2] then
				guiGridListSetItemData(vip.gridlist[1], hRow, 1, tostring(m_obj[2]))
				guiGridListSetItemData(vip.gridlist[2], hRow_2, 1, tostring(m_obj[2]))
			end
		end
    end
)

function open_panel(string)
	if (guiGetVisible(vip.window[2])) then guiSetVisible(vip.window[2], false) showCursor(not isCursorShowing(), false) return end
	if (guiGetVisible(vipFW.window[1])) then guiSetVisible(vipFW.window[1], false) showCursor(not isCursorShowing(), false) return end
	if (not guiGetVisible(vip.window[1])) then
		if (string ~= true) then
			guiSetVisible(vip.window[1], true)
			showCursor(not isCursorShowing(), true)
		end
		--if (not string) then
		--triggerServerEvent("AURpremium.panel_open", localPlayer, localPlayer)
		--end
		if (getElementData(localPlayer, "isPlayerAb")) then
			for i=1, 46 do
				setTimer(function()guiSetEnabled(vip.button[i], true)end,500,1)
			end
		end
		for i=1, 15 do
			if i ~= 4 and i ~= 9 and i ~= 12 then
				guiSetEnabled(vip.button[i], true)
			end
		end
		setTimer(function()
			guiSetEnabled(vip.button[45], true)
			guiSetEnabled(vip.button[46], false)
			--guiSetEnabled(vip.button[4], false)
			--guiSetEnabled(vip.button[9], false)
			--guiSetEnabled(vip.button[12], false)
		end,200,1)
		if (exports.server:isPlayerPremium(localPlayer)) then
			if (getElementData(localPlayer, "premiumLevel") == 1) then
				for i=16, 25 do
					setTimer(function()guiSetEnabled(vip.button[i], true)end,500,1)
				end
			elseif (getElementData(localPlayer, "premiumLevel") == 2) then
				for i=16, 25 do
					setTimer(function()guiSetEnabled(vip.button[i], true)end,500,1)
				end
				for i=37, 44 do
					setTimer(function()guiSetEnabled(vip.button[i], true)end,500,1)
				end
				guiSetEnabled(vip.button[13], true)
				guiSetEnabled(vip.button[14], true)
			elseif (getElementData(localPlayer, "premiumLevel") == 3 or getElementData(localPlayer, "premiumLevel") == 4) then
				for i=16, 47 do
					setTimer(function()guiSetEnabled(vip.button[i], true)end,500,1)
				end
				guiSetEnabled(vip.button[13], true)
				guiSetEnabled(vip.button[14], true)
			end
		else
			for i=16, 47 do
				if (guiGetEnabled(vip.button[i])) then
					guiSetEnabled(vip.button[i], false)
				end
			end
		end
	else
		guiSetVisible(vip.window[1], false)
		showCursor(false)
		if (guiGetVisible(vip.window[2])) then
			guiSetVisible(vip.window[2], false)
		end
		for i=1, 47 do
			if (guiGetEnabled(vip.button[i])) then
				guiSetEnabled(vip.button[i], false)
			end
		end
	end
end

function handle_open_new()
	if (localPlayer and exports.server:isPlayerLoggedIn(localPlayer)) then --[[not localPlayer == getPlayerFromName("Ab-47")) then 
		outputChatBox("This feature is currently unavailable, please try again later.", 255, 0, 0)
		return
		elseif (localPlayer and exports.server:isPlayerPremium(localPlayer)) then]]
		triggerServerEvent("AURpremium.panel_open", localPlayer, localPlayer)
	end
end
addCommandHandler("premium", handle_open_new)

function update_panel(plr, pts, status, hours, string)
	if (plr and pts and status and hours) then
		if (guiGetVisible(vip.window[1])) then
			--exports.NGCdxmsg:createNewDxMessage("Premium panel updating, please re-open!", 255, 255, 0)
		end
		string = string or false
		open_panel(string)
		guiSetText(vip.label[3], "Your APS Points: "..pts)
		guiSetText(vip.label[12], "Premium Status: L"..status.." ("..math.floor(hours / 60).." hours remaining)")
		guiSetText(vip.label[19], "Premium Hours: "..math.floor(hours / 60).." ("..round(hours, 2).." mins)")
		guiSetText(vip.label[28], "Premium Level: "..status)
			
			--guiSetVisible(vip.window[1], false)
			--guiSetVisible(vip.window[1], true)
		--end
	end
end
addEvent("AURpremium.update_panel", true)
addEventHandler("AURpremium.update_panel", root, update_panel)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function redirectToPurchase(data)
	if (localPlayer and data) then
		local plr = localPlayer
		if (plr and isElement(plr) and getElementType(plr) == "player") then
			if (data == "" or not tonumber(data)) then 
				outputChatBox("You must enter a certain amount of hours to purchase that is a number!", 255, 0, 0) 
				return false
			elseif (tonumber(data) >= 50) then
				outputChatBox("You must enter a value less than 50!", 255, 0, 0)
				return false
			end
			open_panel(true)
			triggerServerEvent("AURpremium.server_actions", plr, plr, "purchase", "vip", data)
		end
	end
end

function handle_buttons(purpose, string)
	if (localPlayer and purpose and string) then
		if (purpose == "spawn_vip_car") then
			if (string == "aps") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "vipo") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "aps_infernus") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "vip_plane") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "vip_shamal") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "init_nitro") then
			if (string == "nitroaps") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "nitrol2") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "nitrol3") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "init_armour") then
			if (string == "aps") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "vip") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "heal_player") then
			if (string == "vipl2") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "vipl3") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "jetpack") then
			if (string == "toggle") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "remove") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "ahats") then
			if (string == "toggleaps") then
				local row, col = guiGridListGetSelectedItem (vip.gridlist[1])
				if ( row and col and row ~= -1 and col ~= -1 ) then
					local model = tonumber ( guiGridListGetItemData (vip.gridlist[1], row, 1 ) )
					local scale=1
					local name = ""
					for k,v in pairs(aObjects) do
						if v[2] == model then
							name=v[1]
							if v.scale ~= nil then scale=v.scale break end
						end
					end
					--if not getElementData(localPlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage("You are not VIP",255,0,0) return end
					if model ~= nil then
						--outputChatBox("APS - You are now wearing the "..name.." hat", 0, 255, 0, true)
						--exports.NGCdxmsg:createNewDxMessage("You are now wearing the "..name.." hat",0,255,0)
					end
					triggerServerEvent("AURpremium.changeHat", localPlayer, model, scale, "toggleaps", name)
				end
			elseif (string == "removeaps") then
				--outputChatBox("You've selected to remove APS hat!")
				triggerServerEvent("AURpremium.changeHat", localPlayer, model, scale, "removeaps")
			elseif (string == "togglevip") then
				local row, col = guiGridListGetSelectedItem (vip.gridlist[2])
				if ( row and col and row ~= -1 and col ~= -1 ) then
					local model = tonumber ( guiGridListGetItemData (vip.gridlist[2], row, 1 ) )
					local scale=1
					local name = ""
					for k,v in pairs(aObjects) do
						if v[2] == model then
							name=v[1]
							if v.scale ~= nil then scale=v.scale break end
						end
					end
					--if not getElementData(localPlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage("You are not VIP",255,0,0) return end
					if model ~= nil then
						--outputChatBox("#0000ff(VIP)#00ff00 You are now wearing the "..name.." hat", 0, 255, 0, true)
						--exports.NGCdxmsg:createNewDxMessage("You are now wearing the "..name.." hat",0,255,0)
					end
					triggerServerEvent("AURpremium.changeHat", localPlayer, model, scale, "togglevip", name)
				end
			elseif (string == "removevip") then
				triggerServerEvent("AURpremium.changeHat", localPlayer, model, scale, "removevip")
			end
		elseif (purpose == "chat") then
			if (string == "toggle") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "veh") then
			if (string == "color") then
				handle_premium_colors()
			end
		elseif (purpose == "help") then
			if (string == "request") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "misc") then
			if (string == "ondeathbomb") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "fasttravel") then
				if (guiRadioButtonGetSelected(vipFW.radiobutton[1])) then
					selectedID.three[localPlayer] = {"LS-Hospital"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[2])) then
					selectedID.three[localPlayer] = {"LS-Airport"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[3])) then
					selectedID.three[localPlayer] = {"LS-PD"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[4])) then
					selectedID.three[localPlayer] = {"LS-Bank"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[5])) then
					selectedID.three[localPlayer] = {"LS-DS"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[6])) then
					selectedID.three[localPlayer] = {"LV-Casino"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[7])) then
					selectedID.three[localPlayer] = {"LV-Hospital"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[8])) then
					selectedID.three[localPlayer] = {"LV-Airport"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[9])) then
					selectedID.three[localPlayer] = {"LV-AirStrip"}
				elseif (guiRadioButtonGetSelected(vipFW.radiobutton[10])) then
					selectedID.three[localPlayer] = {"SF-Airport"}
				else
					exports.NGCdxmsg:createNewDxMessage("Sorry, an unknown error has appeared, please try again later!", 255, 0, 0)
					return 
				end
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string, selectedID.three[localPlayer][1])
			elseif (string == "ghostmode") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "walkstyle") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "headless") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "apsheadless") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, "headless", "aps")
			elseif (string == "smoke") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "apssmoke") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "drink") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "apsdrink") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "skins") then
			if (guiRadioButtonGetSelected(vip.radiobutton[1])) then
				selectedID.one[localPlayer] = {"firstaps"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[2])) then
				selectedID.one[localPlayer] = {"secondaps"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[3])) then
				selectedID.one[localPlayer] = {"thirdaps"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[4])) then
				selectedID.one[localPlayer] = {"fourthaps"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[5])) then
				selectedID.one[localPlayer] = {"fifthaps"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[6])) then
				selectedID.one[localPlayer] = {"sixthaps"}
			end
			if (guiRadioButtonGetSelected(vip.radiobutton[7])) then
				selectedID.two[localPlayer] = {"first"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[8])) then
				selectedID.two[localPlayer] = {"second"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[9])) then
				selectedID.two[localPlayer] = {"third"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[10])) then
				selectedID.two[localPlayer] = {"fourth"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[11])) then
				selectedID.two[localPlayer] = {"fifth"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[12])) then
				selectedID.two[localPlayer] = {"sixth"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[13])) then
				selectedID.two[localPlayer] = {"seventh"}
			elseif (guiRadioButtonGetSelected(vip.radiobutton[14])) then
				selectedID.two[localPlayer] = {"eight"}
			end
			if (string == "apstoggle") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string, selectedID.one[localPlayer][1])
			elseif (string == "apsremove") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "viptoggle") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string, selectedID.two[localPlayer][1])
			elseif (string == "vipremove") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "basespawn") then
			if (string == "apsbasespawn") then
				--triggerEvent("setGroupSpawn", localPlayer)
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "spawnatvipbase") then
				--triggerEvent("setGroupSpawn", localPlayer)
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "fixveh") then
			if (string == "instafix") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "lights") then
			if (string == "standard") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "vipadvert") then
			if (string ~= "") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "vipchat") then
			if (string == "enable") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "customtitle") then
			if (string == "toggle") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		elseif (purpose == "music") then
			if (string == "aps") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			elseif (string == "vip") then
				if (guiGetText(vip.edit[4]) ~= "" or guiGetText(vip.edit[4]) ~= "Enter a valid link here") then
					triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string, guiGetText(vip.edit[4]))
				else
					outputChatBox("Please enter a valid link to play!", 255, 0, 0)
				end
			elseif (string == "vipstop") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, purpose, string)
			end
		end
	end
end

function no_base(plr, string)
	if (plr ~= localPlayer) then return end
	if (string == "none") then
		outputChatBox("You do not have a group base listed!", 255, 0, 0)
	elseif (string == "apsbasespawn" or string == "spawnatvipbase") then
		local purpose = "basespawn"
		triggerEvent("setGroupSpawn", plr)
	end
end
addEvent("AURpremium:no_base", true)
addEventHandler("AURpremium:no_base", root, no_base)

function handle_premium_colors()
	exports.cpicker:openPicker("AURpremium.colorpicker",false,"AUR Premium ~ Pick a vehicle colour") 
	addEvent("onColorPickerOK",true) 
end

addEventHandler("onColorPickerOK",root,
		function (id, hex, r, g, b)
			if (id == "AURpremium.colorpicker") then
				triggerServerEvent("AURpremium.server_actions", localPlayer, localPlayer, "colorpicker", "set", r, g, b)
				--outputChatBox("You've selected cp OK! Hex: "..hex.." Red: "..r..", Green: "..g..", Blue: "..b..".."..getPlayerName(localPlayer))
			end
		end
) 

enabled = false 

function drinkEffects(plr, bool)
	if (bool) then
		local x = 50
		timer = setTimer(
			function()
				if (x < 200) then
					x = x + 3
				end
				setCameraShakeLevel(x)
				if enabled then 
					fadeCamera(true, 1.0, 0, 0, 0) 
					enabled = false 
				else 
					fadeCamera(false, 1.0, 255, 0, 0)
					enabled = true
				end 
			end, 400, 30
		)
		bool = false
	else
		if isTimer(timer) then
			killTimer(timer)
		end
		fadeCamera(true, 1.0, 0, 0, 0)
		setCameraShakeLevel(0)
		bool = false
		exports.NGCdxmsg:createNewDxMessage("You've stopped your drunk effect, you will not longer take less damage!", 255, 0, 0)
	end
end
addEvent("AURpremium.drinkEffects", true)
addEventHandler("AURpremium.drinkEffects", root, drinkEffects)

function handleDamage(attacker, weapon, bodypart, loss)
	if (localPlayer and attacker) then
		health = getElementHealth(localPlayer)
		if (getPedArmor(localPlayer) > 1) then return end
		if (getElementData(localPlayer, "AURpremium.playerDrunk")) then
			setElementHealth(localPlayer, (health + (loss/1.5)))
			--Debugging: outputChatBox("health was "..health.." now health is "..(health + (loss/1.5)).." from before loss = "..loss.." to new loss ="..(loss/1.5))
		end
	end
end
addEventHandler("onClientPlayerDamage", root, handleDamage)

--[[exports.cpicker:openPicker
exports.cpicker:closePicker
exports.cpicker:openPicker("AURpremium.colorpicker",false,"AUR Premium ~ Pick a vehicle colour") 
addEvent("onColorPickerOK",true) 
addEventHandler("onColorPickerOK",root,buyLaser2) 
function buyLaser2(id,hex,r,g,b) 
 if id == "ammuLaser" then 
 end 
AmmuLaser = stringID1 
Exports.cpicker:openPicker("ammuLaser",false,"AUR ~ Pick a AB-47 Laser color") ]]

--[[function replace_models()
	txd1 = engineLoadTXD("skins/joker.txd")
	engineImportTXD(txd1, 234)
	dff1 = engineLoadDFF("skins/joker.dff")
	engineReplaceModel(dff1, 234)
	
	txd2 = engineLoadTXD("skins/harley.txd")
	engineImportTXD(txd2, 199)
	dff2 = engineLoadDFF("skins/harley.dff")
	engineReplaceModel(dff2, 199)
	
	txd3 = engineLoadTXD("skins/robber.txd")
	engineImportTXD(txd3, 297)
	dff3 = engineLoadDFF("skins/robber.dff")
	engineReplaceModel(dff3, 297)
	
	txd4 = engineLoadTXD("skins/spiderman.txd")
	engineImportTXD(txd4, 211)
	dff4 = engineLoadDFF("skins/spiderman.dff")
	engineReplaceModel(dff4, 211)
	
	txd5 = engineLoadTXD("skins/james.txd")
	engineImportTXD(txd5, 303)
	dff5 = engineLoadDFF("skins/james.dff")
	engineReplaceModel(dff5, 303)
	
	txd6 = engineLoadTXD("skins/yakuza.txd")
	engineImportTXD(txd6, 292)
	dff6 = engineLoadDFF("skins/yakuza.dff")
	engineReplaceModel(dff6, 292)
	
	txd7 = engineLoadTXD("skins/ghost.txd")
	engineImportTXD(txd5, 290)
	dff7 = engineLoadDFF("skins/ghost.dff")
	engineReplaceModel(dff7, 290)
	
	txd8 = engineLoadTXD("skins/greenarrow.txd")
	engineImportTXD(txd8, 291)
	dff8 = engineLoadDFF("skins/greenarrow.dff")
	engineReplaceModel(dff8, 291)
end
addEventHandler("onClientResourceStart", resourceRoot, replace_models)

 TESTING PURPOSES BELOW]]



addCommandHandler("effect", 
	function(cmd, name)
		local x, y, z = getElementPosition(localPlayer)
		effect=createEffect(name, x, y, z)
			outputChatBox("Effect created!")
			sigarette = createObject ( 1485, 0, 0, 0 )
			if sigarette then
				--attachElements ( effect, sigarette, 0.05, 0, 0.7, 0, 45, 118 ) 
				attachElements ( sigarette, localPlayer, 0.05, 0, 0.7, 0, 45, 118 ) 
			end
	end
)