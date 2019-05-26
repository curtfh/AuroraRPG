local tablex = {}
local coupons = {}
local items = {}
local theMarkers = {}

local couponCodeValid = false
local couponCodeDiscount = 0

local GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

function updateTables (theTable, theCoupons, theItems)
	tablex = theTable
	coupons = theCoupons
	items = theItems
	
	spawnMarkers()
end 
addEvent("aurconvstore.updateTables", true)
addEventHandler("aurconvstore.updateTables", localPlayer, updateTables)

function spawnMarkers ()
	for i=1,  #tablex do
		if (isElement(theMarkers[i])) then 
			destroyElement(theMarkers[i]) 
		end 
		local theMarker = createMarker(tablex[i][1], tablex[i][2], tablex[i][3]-1, "cylinder", 1.5, 235, 244, 66)
		table.insert(theMarkers, theMarker)
		addEventHandler("onClientMarkerHit", theMarker, openGui)
	end 
end 

function openGui(hitPlayer, matchingDimension)
	if (not exports.server:isPlayerLoggedIn(getLocalPlayer())) then return false end
	if (not isPedOnGround(getLocalPlayer())) then return false end
	if (getLocalPlayer() == hitPlayer) then 
		showCursor(true)
		theGui()
	end
end 

function closeGui()
	if (not exports.server:isPlayerLoggedIn(getLocalPlayer())) then return false end
	destroyElement(GUIEditor.window[1])
	showCursor(false)
	couponCodeValid = false
	couponCodeDiscount = 0
end 

function theGui()
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 612) / 2, (screenH - 437) / 2, 612, 437, "AuroraRP ~ Convenience Store", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.gridlist[1] = guiCreateGridList(10, 56, 267, 371, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "#", 0.1)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Items", 0.6)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.3)
	GUIEditor.label[1] = guiCreateLabel(7, 29, 270, 17, "Available Items", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
	GUIEditor.label[2] = guiCreateLabel(287, 61, 315, 242, "Item Name:\n\nPrice:\n\nDescription:", false, GUIEditor.window[1])
	guiLabelSetHorizontalAlign ( GUIEditor.label[2], "left", true )
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.button[1] = guiCreateButton(297, 341, 120, 39, "Buy", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(297, 389, 120, 38, "Close", false, GUIEditor.window[1])
	GUIEditor.label[3] = guiCreateLabel(427, 341, 175, 29, "Do you have any coupon code?\nEnter it here:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.edit[1] = guiCreateEdit(427, 374, 175, 29, "", false, GUIEditor.window[1])
	guiEditSetMaxLength(GUIEditor.edit[1], 20)
	GUIEditor.label[4] = guiCreateLabel(288, 313, 59, 15, "Quantity:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.edit[2] = guiCreateEdit(347, 306, 70, 29, "1", false, GUIEditor.window[1])
	guiEditSetMaxLength(GUIEditor.edit[2], 20)    
	guiSetInputMode("no_binds_when_editing")
	for i=1, #items do
		guiGridListAddRow(GUIEditor.gridlist[1], i, items[i][1], "$"..items[i][2])
	end 
	guiGridListSetSortingEnabled ( GUIEditor.gridlist[1], false )
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2], closeGui)
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
		local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1]) 
		if row >= 0 and col >= 0 then 
			for i=1, #items do
				if (i == row+1) then
					if (couponCodeValid == true) then 
						triggerServerEvent("aurconvstore.playerBuyItem", resourceRoot, getLocalPlayer(), i, math.floor(guiGetText(GUIEditor.edit[2])), math.floor(couponCodeDiscount))
						return 
					end 
					triggerServerEvent("aurconvstore.playerBuyItem", resourceRoot, getLocalPlayer(), i, math.floor(guiGetText(GUIEditor.edit[2])), 0)
					return 
				end 
			end
		  end 
	end)
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
			for i=1, #items do
				if (i == row+1) then
					guiSetText (GUIEditor.label[2], "Item Name: "..items[i][1].."\n\nPrice: $"..items[i][2]*math.floor(guiGetText(GUIEditor.edit[2])).."\n\nDescription: "..items[i][3].."\n")
					return 
				end 
			end
				guiSetText (GUIEditor.label[2], "Item Name:\n\nPrice:\n\nDescription:\n")
			else
				guiSetText (GUIEditor.label[2], "Item Name:\n\nPrice:\n\nDescription:\n")
		  end 
	end, false) 
	
	
	
	addEventHandler ( "onClientGUIChanged", GUIEditor.edit[2], function ( ) 
		local text = guiGetText (source) 
		if (text == "") then 
			curText = "1" 
			guiSetText (source, "1") 
			return 
		end 
  
		if (not tonumber (text)) then 
			guiSetText (source, "1") 
		else 
			if (tonumber(text) <= 0) then 
				curText = "1" 
				guiSetText (source, "1") 
			return
			end
			curText = text 
		end 
	end, false)
	
	addEventHandler ( "onClientGUIChanged", GUIEditor.edit[2], function ( ) 
		local text = guiGetText (source) 
		local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1]) 
		if row >= 0 and col >= 0 then 
			for i=1, #items do
				if (i == row+1) then
					guiSetText (GUIEditor.label[2], "Item Name: "..items[i][1].."\n\nPrice: $"..items[i][2]*math.floor(guiGetText(GUIEditor.edit[2])).."\n\nDescription: "..items[i][3].."\n")
					return 
				end 
				guiSetText (GUIEditor.label[2], "Item Name:\n\nPrice:\n\nDescription:\n")
			end
		end 
	end, false)
	
	
	addEventHandler ( "onClientGUIChanged", GUIEditor.edit[1], function ( ) 
		local text = guiGetText (source) 
		local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1]) 
		if row >= 0 and col >= 0 then 
			for i=1, #items do
				if (i == row+1) then
					for z=1, #coupons do
						if (coupons[z][1] == guiGetText(GUIEditor.edit[1])) then 
							guiSetText (GUIEditor.label[2], "Item Name: "..items[i][1].."\n\nPrice: $"..(coupons[z][2]/100)*(items[i][2]*math.floor(guiGetText(GUIEditor.edit[2]))).." (Based Price: $"..items[i][2]*math.floor(guiGetText(GUIEditor.edit[2]))..")\n\nCoupon Code Applied: "..coupons[z][1].."\n\nDescription: "..items[i][3].."\n")
							guiSetText(GUIEditor.label[3], "Coupon Code Valid.\nEnter it here:")
							guiLabelSetColor(GUIEditor.label[3], 0, 255, 0)
							couponCodeValid = true
							couponCodeDiscount = coupons[z][2]
							return 
						end 
						guiSetText (GUIEditor.label[2], "Item Name: "..items[i][1].."\n\nPrice: $"..items[i][2]*math.floor(guiGetText(GUIEditor.edit[2])).."\n\nDescription: "..items[i][3].."\n")
						guiSetText(GUIEditor.label[3], "Invalid Coupon Code.\nEnter it here:")
						guiLabelSetColor(GUIEditor.label[3], 255, 0, 0)
						couponCodeDiscount = 0
						couponCodeValid = false
						return
					end 
				end 
				guiSetText (GUIEditor.label[2], "Item Name:\n\nPrice:\n\nDescription:\n")
			end
		end 
	end, false)
	
end 



