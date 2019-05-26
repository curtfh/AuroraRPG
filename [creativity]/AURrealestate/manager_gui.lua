local screenW, screenH = guiGetScreenSize()

GUIEditor = {
    tab = {},
    scrollpane = {},
    tabpanel = {},
    label = {},
	slabel = {},
	s1label = {},
	sbutton = {},
    button = {},
    window = {},
    gridlist = {},
    memo = {}
}

local tabs = {
	{ "General"},
	{ "Management"},
}

GUIEditor.window[1] = guiCreateWindow((screenW - 690) / 2, (screenH - 479) / 2, 690, 479, "Real Estate - Manager", false)
guiWindowSetSizable(GUIEditor.window[1], false)
guiSetVisible( GUIEditor.window[1], false)

GUIEditor.tabpanel[1] = guiCreateTabPanel(10, 25, 670, 444, false, GUIEditor.window[1])
for i, tab in ipairs (tabs) do
	GUIEditor.tab[i] = guiCreateTab( tab[1], GUIEditor.tabpanel[1])
end


GUIEditor.memo[1] = guiCreateMemo(10, 51, 650, 359, "", false, GUIEditor.tab[1])
guiMemoSetReadOnly(GUIEditor.memo[1], true)
GUIEditor.label[1] = guiCreateLabel(274, 31, 122, 20, "Zone Information", false, GUIEditor.tab[1])
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
GUIEditor.label[2] = guiCreateLabel(10, 10, 72, 15, "Zone Name:", false, GUIEditor.tab[1])
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
GUIEditor.label[3] = guiCreateLabel(10, 31, 72, 15, "Zone Cost:", false, GUIEditor.tab[1])
guiSetFont(GUIEditor.label[3], "default-bold-small")
guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
GUIEditor.label[4] = guiCreateLabel(86, 31, 99, 15, "$XX", false, GUIEditor.tab[1])
guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
GUIEditor.label[5] = guiCreateLabel(86, 10, 188, 15, "$XX", false, GUIEditor.tab[1])
guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
GUIEditor.label[6] = guiCreateLabel(284, 10, 72, 15, "Zone Owner:", false, GUIEditor.tab[1])
guiSetFont(GUIEditor.label[6], "default-bold-small")
guiLabelSetVerticalAlign(GUIEditor.label[6], "center")
GUIEditor.label[7] = guiCreateLabel(361, 10, 107, 15, "XX", false, GUIEditor.tab[1])
guiLabelSetVerticalAlign(GUIEditor.label[7], "center")
GUIEditor.button[1] = guiCreateButton(537, 15, 123, 26, "Purchase Zone", false, GUIEditor.tab[1])

GUIEditor.gridlist[1] = guiCreateGridList(10, 6, 218, 134, false, GUIEditor.tab[2])
guiGridListAddColumn(GUIEditor.gridlist[1], "Accesslist", 0.9)
GUIEditor.button[2] = guiCreateButton(10, 150, 83, 29, "Add Player", false, GUIEditor.tab[2])
GUIEditor.button[3] = guiCreateButton(103, 150, 125, 29, "Remove Selected", false, GUIEditor.tab[2])
GUIEditor.gridlist[2] = guiCreateGridList(10, 189, 218, 159, false, GUIEditor.tab[2])
guiGridListAddColumn(GUIEditor.gridlist[2], "Roles", 0.9)
--GUIEditor.button[4] = guiCreateButton(10, 358, 125, 19, "Add Player To Role", false, GUIEditor.tab[2])
--GUIEditor.button[5] = guiCreateButton(10, 387, 125, 19, "Remove Sel. Player", false, GUIEditor.tab[2])
GUIEditor.button[4] = guiCreateButton(10, 358, 218, 19, "Add Player To Role", false, GUIEditor.tab[2])
GUIEditor.button[5] = guiCreateButton(10, 387, 218, 19, "Remove Sel. Player", false, GUIEditor.tab[2])
--GUIEditor.button[6] = guiCreateButton(145, 358, 83, 19, "Add Role", false, GUIEditor.tab[2])
--GUIEditor.button[7] = guiCreateButton(145, 387, 83, 19, "Remove Role", false, GUIEditor.tab[2])
GUIEditor.scrollpane[1] = guiCreateScrollPane(246, 6, 414, 400, false, GUIEditor.tab[2])

GUIEditor.button[6] = guiCreateButton(621, 20, 59, 27, "Close", false, GUIEditor.window[1])
local cusorfixer
function openGUI()
	if guiGetVisible(GUIEditor.window[1]) == true then 
		guiSetVisible(GUIEditor.window[1], false)
		showCursor(false)
		killTimer(cursorfixer)
	else
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
		cursorfixer = setTimer(function()
			if not isCursorShowing() then 
				showCursor(true)
			end
		end, 500, 0)
	end 
end

addEventHandler ("onClientGUIClick", GUIEditor.button[6], function()
	openGUI()
end, false)

addEventHandler ("onClientGUIClick", GUIEditor.button[1], function()
	triggerServerEvent( "AURrealestate.purchaseZone", resourceRoot, localPlayer, currentZoneID, exports.server:getPlayerAccountName(localPlayer))
end, false)

local roles = {
	{ "Observers"},
	{ "Editors"},
	{ "Owner"},
}

local options = {
	{ "Zone Name", "Change the name of the zone to something other than the current."},
	{ "Manage Roles", "Modify what each role is named and can do or change within the zone."},
}

local offset = 67

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		-- Add Items To Roles Gridlist
		for i, role in ipairs (roles) do
			local name = role[1]
			local row = guiGridListAddRow( GUIEditor.gridlist[2])
			guiGridListSetItemText( GUIEditor.gridlist[2], row, 1, name, true, false)
		end
		-- Add Options
		for i,v in ipairs( options) do
			-- Buttons

			-- 24+(72*(i-1))
			--GUIEditor.sbutton[i] = guiCreateButton(3, 3+(35*(i-1)), 125, 25, v[1], false, GUIEditor.scrollpane[1])
			GUIEditor.sbutton[i] = guiCreateButton(5, 24+(i*offset), 112, 27, "Edit Option", false, GUIEditor.scrollpane[1])
			guiSetProperty(GUIEditor.button[i], "NormalTextColour", "FFAAAAAA")
			-- Labels

			-- 4+(67*(i-1))
			GUIEditor.slabel[i] = guiCreateLabel(5, 4+(i*offset), 112, 15, v[1], false, GUIEditor.scrollpane[1])
			guiSetFont(GUIEditor.slabel[i], "default-bold-small")
			guiLabelSetHorizontalAlign(GUIEditor.slabel[i], "center", false)

			GUIEditor.s1label[i] = guiCreateLabel(127, 4+(i*offset), 282, 57, v[2], false, GUIEditor.scrollpane[1])
			guiLabelSetHorizontalAlign(GUIEditor.s1label[i], "left", true)

			guiCreateLabel(5, 48+(i*offset), 404, 15, "____________________________________________________________________________________", false, GUIEditor.scrollpane[1])
		end
		-- Set All Fonts
		for i, label in ipairs ( GUIEditor.label) do
			guiSetFont( label, "default")
		end
		for i, slabel in ipairs ( GUIEditor.slabel) do
			guiSetFont( slabel, "default-bold")
		end
		for i, button in ipairs ( GUIEditor.button) do
			guiSetFont( button, "clear-normal")
		end
		for i, sbutton in ipairs ( GUIEditor.sbutton) do
			guiSetFont( sbutton, "clear-normal")
		end
		for i, s1label in ipairs ( GUIEditor.s1label) do
			guiSetFont( s1label, "clear-normal")
		end

		--Set Data
		--setObjectCount( "zone1")
	end
)

addEventHandler("onClientRender", root,
    function()
		for i, tabpanel in ipairs ( getElementsByType( "gui-tabpanel")) do
			local tab = guiGetSelectedTab( tabpanel)
			if tab == GUIEditor.tab[2] then
				local x, y = guiGetPosition( GUIEditor.window[1], false)
				dxDrawLine(x+248, y+56, x+248, y+460, tocolor(255, 255, 255, 255), 1, true)
			end
		end
    end
)
