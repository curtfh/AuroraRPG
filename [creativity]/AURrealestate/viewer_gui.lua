local screenW, screenH = guiGetScreenSize()

GTmodelsviewer = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}

GTmodelsviewer.window[1] = guiCreateWindow(10, (screenH - 421) / 2, 326, 421, "Real Estate - Property Viewer", false)
guiWindowSetSizable(GTmodelsviewer.window[1], false)
guiSetVisible( GTmodelsviewer.window[1], false)
--showCursor( true)

GTmodelsviewer.gridlist[1] = guiCreateGridList(10, 28, 306, 240, false, GTmodelsviewer.window[1])
guiGridListAddColumn(GTmodelsviewer.gridlist[1], "Objects", 0.9)
GTmodelsviewer.gridlist[2] = guiCreateGridList(10, 278, 171, 115, false, GTmodelsviewer.window[1])
guiGridListAddColumn(GTmodelsviewer.gridlist[2], "Textures", 0.8)
--GTmodelsviewer.button[1] = guiCreateButton(191, 303, 125, 40, "Preview Combination", false, GTmodelsviewer.window[1])
GTmodelsviewer.button[1] = guiCreateButton(191, 303, 125, 40, "Purchase Combination", false, GTmodelsviewer.window[1])
--guiSetFont(GTmodelsviewer.button[1], "clear-normal")
GTmodelsviewer.label[1] = guiCreateLabel(191, 278, 125, 15, "Cost: $0", false, GTmodelsviewer.window[1])
--guiSetFont(GTmodelsviewer.label[2], "clear-normal")
--GTmodelsviewer.button[2] = guiCreateButton(191, 353, 125, 40, "Purchase Combination", false, GTmodelsviewer.window[1])
--guiSetFont(GTmodelsviewer.button[2], "clear-normal")
GTmodelsviewer.label[2] = guiCreateLabel(9, 399, 307, 16, "Right Click on the GUI to Close it.", false, GTmodelsviewer.window[1])

local mcost = 0
local tcost = 0
local ocost = 0

--[[Types:
	no: Materials Viewer
	o: Object Viewer
--]]

local vType = "no"

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		-- Set Fonts
		for i, label in pairs ( GTmodelsviewer.label) do
			guiSetFont( label, "clear-normal")
		end
		for i, button in pairs ( GTmodelsviewer.button) do
			guiSetFont( button, "clear-normal")
		end

		-- Load All Textures
		for i, txdName in ipairs ( alltextures) do
			local row = guiGridListAddRow( GTmodelsviewer.gridlist[2])
			guiGridListSetItemText( GTmodelsviewer.gridlist[2], row, 1, "$"..txdName[3].." - "..txdName[1], false, false)
			guiGridListSetItemData( GTmodelsviewer.gridlist[2], row, 1, txdName[2]..";"..txdName[3])
		end

		-- Load All Items
		for name, category in pairs ( objectTable) do
			local row = guiGridListAddRow( GTmodelsviewer.gridlist[1])
			if #category > 1 then
				guiGridListSetItemText( GTmodelsviewer.gridlist[1], row, 1, #category.." "..name.."s", true, false)
			else
				guiGridListSetItemText( GTmodelsviewer.gridlist[1], row, 1, #category.." "..name, true, false)
			end
			for i, object in pairs ( category) do
				local row = guiGridListAddRow( GTmodelsviewer.gridlist[1])

				local id = object[1]
				local itemName = object[2]
				local costr = object[3]
				local cost = costr

				guiGridListSetItemText( GTmodelsviewer.gridlist[1], row, 1, "$"..cost.." - "..itemName, false, false)
				guiGridListSetItemData( GTmodelsviewer.gridlist[1], row, 1, id..";"..costr)
			end
		end
	end
)

function setViewerVisible( state)
	if state then
		if not guiGetVisible( GTmodelsviewer.window[1]) then
			guiSetVisible( GTmodelsviewer.window[1], true)
			showCursor( true)
			viewing = true
		end
	else
		if guiGetVisible( GTmodelsviewer.window[1]) then
			guiSetVisible( GTmodelsviewer.window[1], false)
			showCursor( false)
			viewing = false
		end
	end
end

addEventHandler( "onClientGUIClick", root,
	function( button, state)
		if source == GTmodelsviewer.window[1] then
			if button == "right" then
				setViewerVisible( false)
			end
		elseif source == GTmodelsviewer.gridlist[1] then
			local row, col = guiGridListGetSelectedItem( source)
			if row and col then
				local text = guiGridListGetItemText( source, row, col)
				if text ~= "" then
					local mdata = split( guiGridListGetItemData( source, row, col), ";")
					local objectID = mdata[1]
					local cost = mdata[2]
					if prevID ~= objectID then
						setElementModel( prevObject, objectID)
						prevID = objectID
						mcost = cost
					end
				end
			end
			guiSetText( GTmodelsviewer.label[1], "Cost: $"..(mcost+tcost))
		elseif source == GTmodelsviewer.gridlist[2] then
			local row, col = guiGridListGetSelectedItem( source)
			if row and col then
				local text = guiGridListGetItemText( source, row, col)
				if text ~= "" then
					local tdata = split( guiGridListGetItemData( source, row, col), ";")
					local texture = tdata[1]
					local cost = tdata[2]
					if texture == "none" then
						if prevTXD ~= "none" then
							prevTXD = "none"
							removeCustomTexture( prevObject)
							tcost = cost
						end
					else
						if prevTXD ~= texture then
							applyCustomTexture( prevObject, texture)
							prevTXD = texture
							tcost = cost
						end
					end
				end
			end
			guiSetText( GTmodelsviewer.label[1], "Cost: $"..(mcost+tcost))
		end
	end
)
