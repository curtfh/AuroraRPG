olditems = ""
disabled = false
theKey = false
forcedClose = false
TheTable = {}
Trade = {
	functions = { },
	vars = { },
	gui = {
		main = { },
		pro = { }
	},
}

Panel = {
	edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}
PlayerPanel = {
    gridlist = {},
    button = {},
    label = {},
    edit = {}
}
SalesPanel = {
    gridlist = {},
    button = {},
    label = {},
}

addEventHandler("onClientResourceStart",resourceRoot,function()

	--setTimer(loop,500,0)
	createWindow()
	createPlayerWnd()
end)

addEvent("loopPlayerItems",true)
function loop()
	if guiGetVisible(Panel.window) or guiGetVisible(PlayerPanel.window) then
		local dr,dn = getMyDrug()
		triggerServerEvent("loopMyItems",localPlayer,dr,dn)
	end
end
addEventHandler("loopPlayerItems",root,loop)



addEvent("fastloopass",true)
addEventHandler("fastloopass",root,function()
	triggerServerEvent ( "TradinggetProfileItems", localPlayer )
	refreshPlayerGrid()
end)

function getMyDrug()
	local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
	if drugsTable == nil then return false end
	return drugsTable,drugNames
	--[[for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2]) then
			return drugNames[a2],tonumber(b)
		end
	end]]
end

-- gui
local sx_, sy_ = guiGetScreenSize ()
local sx, sy = sx_/1280, sy_/720

--------------------------
-- Main Gui				--
--[[
Panel = {
	edit = {},
    button = {},
    window = {},
    label = {},
    tab = {},
    tab1 = {},
    tab2 = {},
    tab3 = {},
    gridlist = {}
}Panel.tab = guiCreateTabPanel(9, 25, 457, 429, false, Panel.window)
	Panel.tab1 = guiCreateTab("Weapons", Panel.tab)
	Panel.tab2 = guiCreateTab("Drugs", Panel.tab)
	Panel.tab3 = guiCreateTab("Medickit", Panel.tab)
]]
--------------------------
function createWindow()

	Panel.window = guiCreateWindow(64, 106, 658, 464, "Aurora ~ Trade", false)
	guiWindowSetSizable(Panel.window, false)
	guiSetAlpha(Panel.window, 1.00)
	guiSetVisible(Panel.window,false )
	centerWindows(Panel.window)
	Panel.list = guiCreateGridList(9, 25, 457, 429, false, Panel.window)
	guiGridListAddColumn(Panel.list, "Item", 0.2)
	guiGridListAddColumn(Panel.list, "Single item Cost", 0.1)
	guiGridListAddColumn(Panel.list, "Amount", 0.1)
	guiGridListAddColumn(Panel.list, "Seller", 0.2)
	guiGridListAddColumn(Panel.list, "Total Cost", 0.15)
	guiGridListAddColumn(Panel.list, "Online", 0.2)
	Panel.label[1] = guiCreateLabel(472, 33, 170, 27, "Welcome to Trading System", false, Panel.window)
	guiLabelSetColor(Panel.label[1], 254, 62, 67)
	guiLabelSetHorizontalAlign(Panel.label[1], "center", false)
	Panel.label[2] = guiCreateLabel(472, 50, 170, 15, "-----------------------------------------------------------------", false, Panel.window)
	Panel.purchAmount = guiCreateEdit(472, 138, 170, 32, "1", false, Panel.window)
	Panel.label[3] = guiCreateLabel(472, 102, 170, 17, "Enter Amount Please", false, Panel.window)
	guiLabelSetColor(Panel.label[3], 254, 62, 67)
	guiLabelSetHorizontalAlign(Panel.label[3], "center", false)
	Panel.label[4] = guiCreateLabel(472, 119, 170, 15, "-----------------------------------------------------------------", false, Panel.window)
	Panel.purchase = guiCreateButton(474, 181, 168, 30, "Buy now", false, Panel.window)
	Panel.label[5] = guiCreateLabel(472, 336, 170, 17, "View Your items", false, Panel.window)
	guiLabelSetColor(Panel.label[5], 254, 62, 67)
	guiLabelSetHorizontalAlign(Panel.label[5], "center", false)
	Panel.label[6] = guiCreateLabel(472, 317, 170, 15, "-----------------------------------------------------------------", false, Panel.window)
	Panel.exit = guiCreateButton(474, 221, 168, 30, "Close", false, Panel.window)
	Panel.myitems = guiCreateButton(474, 380, 168, 30, "My Items", false, Panel.window)
	guiGridListSetSortingEnabled ( Panel.list, false )


	addEventHandler ( "onClientGUIClick", root, panelClick)
	addEventHandler ( "onClientGUIChanged", root, guiEditbox )
	refreshPanels ()


end


function closePanelWindow()
	guiSetVisible(Panel.window,false )
	showCursor( false )
	triggerServerEvent("removeMismatch",localPlayer)
	if ( isTimer ( refreshingTimers ) ) then
		killTimer ( refreshingTimers )
	end
end

 function refreshPanels()
	if guiGetVisible(Panel.window) then
		triggerServerEvent ( "TradinggetShopList", localPlayer )
		if ( isTimer ( refreshingTimers ) ) then
			killTimer ( refreshingTimers )
		end
		refreshingTimers = setTimer ( refreshPanels, 500, 0 )
	end
 end


function onClientBuyItem()
	local row, _ = guiGridListGetSelectedItem ( Panel.list )
	if ( row == -1 ) then
		return exports.NGCdxmsg:createNewDxMessage( "There is currently no item selected. Please select an item.", 255, 255, 0 )
	end

	local data = guiGridListGetItemData ( Panel.list, row, 1 )
	local TheID = guiGridListGetItemData ( Panel.list, row, 2 )
	local ammount = guiGetText ( Panel.purchAmount )
	if ( ammount == "" ) then
		return exports.NGCdxmsg:createNewDxMessage( "Please enter the amount that you would like to purchase", 255, 255, 0 )
	end

	local ammount = tonumber ( ammount )
	if ( ammount < 0 ) then
		return exports.NGCdxmsg:createNewDxMessage( "invalid amount", 255, 0, 0 )
	end

	if ( tonumber(ammount) > tonumber(data.quantity )) then
		return exports.NGCdxmsg:createNewDxMessage( "The seller only has "..tostring(data.quantity).." for sale.", 255, 255, 0 )
	end
	--outputDebugString(data.item)

	triggerServerEvent ( "TradingonClientAttemptBuyItem", localPlayer, TheID, ammount )
	loop()
end
new = {}
old = {}



local colors = {
	-- ID,Name
	{55, "Stone","Craftable",66, 244, 212},
	{56, "Iron","Craftable",66, 244, 212},
	{56, "Diamond","Craftable",66, 244, 212},
	{56, "Explosive Powder","Craftable",66, 244, 212},
	{57, "Phosphorus","Craftable",66, 244, 212},
	{58, "Weed Seed","Craftable",66, 244, 212},
	{59, "Iodine","Craftable",66, 244, 212},
	{60, "Pot","Craftable",66, 244, 212},
	
	{1,"Ritalin","Drugs",0,100,200},

	{2,"LSD","Drugs",0,150,0},

	{3,"Cocaine","Drugs",255,255,0},

	{4,"Ecstasy","Drugs",250,0,150},

	{5,"Heroine","Drugs",255,0,0},

	{6,"Weed","Drugs",255,150,0},

	{16,"Grenade","Weapons",0,255,255},
	{17,"Teargas","Weapons",0,255,255},
	{22,"Colt 45","Weapons",0,255,255},
	{23,"Silenced","Weapons",0,255,255},
	{24,"Deagle","Weapons",0,255,255},
	{25,"Shotgun","Weapons",0,255,255},
	{26,"Sawned-off","Weapons",0,255,255},
	{27,"Combat Shotgun","Weapons",0,255,255},
	{28,"Uzi","Weapons",0,255,255},
	{29,"MP5","Weapons",0,255,255},
	{30,"AK-47","Weapons",0,255,255},
	{31,"M4","Weapons",0,255,255},
	{32,"Tec-9","Weapons",0,255,255},
	{33,"Rifle","Weapons",0,255,255},
	{34,"Sniper","Weapons",0,255,255},
	{35,"Rocket Launcher","Weapons",0,255,255},
	{38,"Minigun","Weapons",0,255,255},
	{39,"Satchel","Weapons",0,255,255},
}

local dik2 = {
	-- ID,Name
	"Craftable",
	"Drugs",
	"Weapons",




}

local craftable = {
	["Stone"] = "Craftable",

	["Iron"] = "Craftable",

	["Diamond"] = "Craftable",

	["Explosive Powder"] = "Craftable",

	["Phosphorus"] = "Craftable",

	["Weed Seed"] = "Craftable",
	["Iodine"] = "Craftable",
	["Pot"] = "Craftable",
}

local drugs = {
	-- ID,Name
	["Ritalin"] = "Drugs",

	["LSD"] = "Drugs",

	["Cocaine"] = "Drugs",

	["Ecstasy"] = "Drugs",

	["Heroine"] = "Drugs",

	["Weed"] = "Drugs",


}

local wepx = {

	["Grenade"] = "Weapons",
	["Teargas"] = "Weapons",
	["Colt 45"] = "Weapons",
	["Silenced"] = "Weapons",
	["Deagle"] = "Weapons",
	["Shotgun"] = "Weapons",
	["Sawned-off"] = "Weapons",
	["Combat Shotgun"] = "Weapons",
	["Uzi"] = "Weapons",
	["MP5"] = "Weapons",
	["AK-47"] = "Weapons",
	["M4"] = "Weapons",
	["Tec-9"] = "Weapons",
	["Rifle"] = "Weapons",
	["Sniper"] = "Weapons",
	["Rocket Launcher"] = "Weapons",
	["Minigun"] = "Weapons",
	["Satchel"] = "Weapons",
}

local Misc = {

	["Medickits"] = "Misc",

}

 addEvent ( "TradingonClientReciveList", true )
 addEventHandler ( "TradingonClientReciveList", root, function ( list )
	local r, _ = guiGridListGetSelectedItem ( Panel.list )
	if ( r ~= -1 ) then
		selectedId = guiGridListGetItemData ( Panel.list, r, 2 )--.this_id
	end
	new = toJSON(list)
	if new ~= old then
		old = new
	else
		return false
	end
	notwep = false
	notdrug = false
	notMisc = false
	guiGridListClear ( Panel.list )
	if list == nil or list == {} then
		guiGridListSetItemText ( Panel.list, guiGridListAddRow ( Panel.list ), 1, "No items in database", true, true )
		return false
	end
	if ( type ( list ) == "table" and table.len ( list ) > 0 ) then
		---for pussy,dick in pairs ( dik2 ) do
			--if dik[dick.item] then
			--local row = guiGridListAddRow ( Panel.list )
			--guiGridListSetItemText ( Panel.list, row, 1, dick, true, false )
			for i, v in pairs ( list ) do
				if tonumber(v.quantity) and tonumber(v.quantity) > 0 then
					if Misc[v.item] then
						if notMisc == false then
							notMisc = true
							local row = guiGridListAddRow ( Panel.list )
							guiGridListSetItemText ( Panel.list, row, 1, "Misc", true, false )
							guiGridListSetItemColor ( Panel.list, row,1,255,225,0)
						end
						local r = guiGridListAddRow ( Panel.list )
						guiGridListSetItemText ( Panel.list, r, 1, v.item, false, false )
						guiGridListSetItemText ( Panel.list, r, 2, "$"..v.amountperone, false, false )
						guiGridListSetItemText ( Panel.list, r, 3, v.quantity, false, false )
						guiGridListSetItemText ( Panel.list, r, 4, v.seller, false, false )
						guiGridListSetItemText ( Panel.list, r, 5, (v.amountperone * v.quantity), false, false )
						guiGridListSetItemText ( Panel.list, r, 6, "Offline", false, false )
						guiGridListSetItemColor ( Panel.list, r,6,250,0,0)
						--[[for k4,v4 in ipairs(colors) do
							if v4[2] == v.item then
								for i=1,5 do
									guiGridListSetItemColor ( Panel.list, r,i,v4[4],v4[5],v4[6])
								end
							end
						end]]
						for k5,v5 in ipairs(getElementsByType("player")) do
							if tostring(exports.server:getPlayerAccountName(v5)) == tostring(v.seller) then
								guiGridListSetItemText ( Panel.list, r, 6, getPlayerName(v5), false, false )
								guiGridListSetItemColor ( Panel.list, r,6,0,220,0)
							end
						end
						guiGridListSetItemData ( Panel.list, r, 1, v )
						guiGridListSetItemData ( Panel.list, r, 2, i )
					end
				end
			end
			for i, v in pairs ( list ) do
				if tonumber(v.quantity) and tonumber(v.quantity) > 0 then
					if craftable[v.item] then
						if notwep == false then
							notwep = true
							local row = guiGridListAddRow ( Panel.list )
							guiGridListSetItemText ( Panel.list, row, 1, "Craftable", true, false )
							guiGridListSetItemColor ( Panel.list, row,1,66, 244, 212)
						end
						local r = guiGridListAddRow ( Panel.list )
						guiGridListSetItemText ( Panel.list, r, 1, v.item, false, false )
						guiGridListSetItemText ( Panel.list, r, 2, "$"..v.amountperone, false, false )
						guiGridListSetItemText ( Panel.list, r, 3, v.quantity, false, false )
						guiGridListSetItemText ( Panel.list, r, 4, v.seller, false, false )
						guiGridListSetItemText ( Panel.list, r, 5, (v.amountperone * v.quantity), false, false )
						guiGridListSetItemText ( Panel.list, r, 6, "Offline", false, false )
						guiGridListSetItemColor ( Panel.list, r,6,250,0,0)
						--[[for k4,v4 in ipairs(colors) do
							if v4[2] == v.item then
								for i=1,5 do
									guiGridListSetItemColor ( Panel.list, r,i,v4[4],v4[5],v4[6])
								end
							end
						end]]
						for k5,v5 in ipairs(getElementsByType("player")) do
							if tostring(exports.server:getPlayerAccountName(v5)) == tostring(v.seller) then
								guiGridListSetItemText ( Panel.list, r, 6, getPlayerName(v5), false, false )
								guiGridListSetItemColor ( Panel.list, r,6,0,220,0)
							end
						end
						guiGridListSetItemData ( Panel.list, r, 1, v )
						guiGridListSetItemData ( Panel.list, r, 2, i )
					end
				end
			end
			for i, v in pairs ( list ) do
				if tonumber(v.quantity) and tonumber(v.quantity) > 0 then
					if drugs[v.item] then
						if notdrug == false then
							notdrug = true
							local row = guiGridListAddRow ( Panel.list )
							guiGridListSetItemText ( Panel.list, row, 1, "Drugs", true, false )
							guiGridListSetItemColor ( Panel.list, row,1,0,225,0)
						end
						local r = guiGridListAddRow ( Panel.list )
						guiGridListSetItemText ( Panel.list, r, 1, v.item, false, false )
						guiGridListSetItemText ( Panel.list, r, 2, "$"..v.amountperone, false, false )
						guiGridListSetItemText ( Panel.list, r, 3, v.quantity, false, false )
						guiGridListSetItemText ( Panel.list, r, 4, v.seller, false, false )
						guiGridListSetItemText ( Panel.list, r, 5, (v.amountperone * v.quantity), false, false )
						guiGridListSetItemText ( Panel.list, r, 6, "Offline", false, false )
						guiGridListSetItemColor ( Panel.list, r,6,250,0,0)
						--[[for k4,v4 in ipairs(colors) do
							if v4[2] == v.item then
								for i=1,5 do
									guiGridListSetItemColor ( Panel.list, r,i,v4[4],v4[5],v4[6])
								end
							end
						end]]
						for k5,v5 in ipairs(getElementsByType("player")) do
							if tostring(exports.server:getPlayerAccountName(v5)) == tostring(v.seller) then
								guiGridListSetItemText ( Panel.list, r, 6, getPlayerName(v5), false, false )
								guiGridListSetItemColor ( Panel.list, r,6,0,220,0)
							end
						end
						guiGridListSetItemData ( Panel.list, r, 1, v )
						guiGridListSetItemData ( Panel.list, r, 2, i )
					end
				end
			end
			for i, v in pairs ( list ) do
				if tonumber(v.quantity) and tonumber(v.quantity) > 0 then
					if wepx[v.item] then
						if notwep == false then
							notwep = true
							local row = guiGridListAddRow ( Panel.list )
							guiGridListSetItemText ( Panel.list, row, 1, "Weapons", true, false )
							guiGridListSetItemColor ( Panel.list, row,1,255,155,0)
						end
						local r = guiGridListAddRow ( Panel.list )
						guiGridListSetItemText ( Panel.list, r, 1, v.item, false, false )
						guiGridListSetItemText ( Panel.list, r, 2, "$"..v.amountperone, false, false )
						guiGridListSetItemText ( Panel.list, r, 3, v.quantity, false, false )
						guiGridListSetItemText ( Panel.list, r, 4, v.seller, false, false )
						guiGridListSetItemText ( Panel.list, r, 5, (v.amountperone * v.quantity), false, false )
						guiGridListSetItemText ( Panel.list, r, 6, "Offline", false, false )
						guiGridListSetItemColor ( Panel.list, r,6,250,0,0)
						--[[for k4,v4 in ipairs(colors) do
							if v4[2] == v.item then
								for i=1,5 do
									guiGridListSetItemColor ( Panel.list, r,i,v4[4],v4[5],v4[6])
								end
							end
						end]]
						for k5,v5 in ipairs(getElementsByType("player")) do
							if tostring(exports.server:getPlayerAccountName(v5)) == tostring(v.seller) then
								guiGridListSetItemText ( Panel.list, r, 6, getPlayerName(v5), false, false )
								guiGridListSetItemColor ( Panel.list, r,6,0,220,0)
							end
						end
						guiGridListSetItemData ( Panel.list, r, 1, v )
						guiGridListSetItemData ( Panel.list, r, 2, i )
					end
				end
			end
		--end
		if ( selectedId ) then
			for i=0, guiGridListGetRowCount ( Panel.list )-1 do
				local id = guiGridListGetItemData ( Panel.list, i, 2 )--.this_id
				if ( id == selectedId ) then
					guiGridListSetSelectedItem ( Panel.list, i, 1 )
					break
				end
			end
		end
		selectedId = nil
	else
		guiGridListSetItemText ( Panel.list, guiGridListAddRow ( Panel.list ), 1, "No items in database", true, true )
	end
 end )



------------------------------
--
------------------------------
function createPlayerWnd()

	PlayerPanel.window = guiCreateWindow(140, 85, 538, 456, "Aurora ~ Player Trading Items", false)
	guiWindowSetSizable(PlayerPanel.window, false)
	guiSetAlpha(PlayerPanel.window, 0.87)
	guiSetVisible(PlayerPanel.window,false)
	PlayerPanel.add_items = guiCreateGridList(10, 87, 333, 359, false, PlayerPanel.window)
	guiGridListAddColumn(PlayerPanel.add_items, "Item", 0.5)
	guiGridListAddColumn(PlayerPanel.add_items, "Amount", 0.5)
	PlayerPanel.label[1] = guiCreateLabel(62, 25, 232, 35, "Available items to sell", false, PlayerPanel.window)
	guiSetFont(PlayerPanel.label[1], "sa-header")
	guiLabelSetColor(PlayerPanel.label[1], 255, 59, 59)
	PlayerPanel.label[2] = guiCreateLabel(343, 25, 175, 37, "Options", false, PlayerPanel.window)
	guiSetFont(PlayerPanel.label[2], "sa-header")
	guiLabelSetColor(PlayerPanel.label[2], 255, 59, 59)
	guiLabelSetHorizontalAlign(PlayerPanel.label[2], "center", false)
	PlayerPanel.add_add = guiCreateButton(353, 241, 165, 32, "Add to sales", false, PlayerPanel.window)
	PlayerPanel.label[3] = guiCreateLabel(62, 65, 232, 12, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, PlayerPanel.window)
	PlayerPanel.label[4] = guiCreateLabel(343, 69, 175, 18, "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, PlayerPanel.window)
	PlayerPanel.add_quan = guiCreateEdit(353, 121, 164, 31, "", false, PlayerPanel.window)
	PlayerPanel.label[5] = guiCreateLabel(352, 93, 165, 23, "Insert Item Amount ", false, PlayerPanel.window)
	guiSetFont(PlayerPanel.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(PlayerPanel.label[5], "center", false)
	PlayerPanel.label[6] = guiCreateLabel(353, 166, 165, 23, "Price for 1 (Item Amount)", false, PlayerPanel.window)
	guiSetFont(PlayerPanel.label[6], "default-bold-small")
	guiLabelSetHorizontalAlign(PlayerPanel.label[6], "center", false)
	PlayerPanel.add_price = guiCreateEdit(354, 195, 164, 31, "", false, PlayerPanel.window)
	PlayerPanel.sales = guiCreateButton(353, 283, 165, 32, "My Sales", false, PlayerPanel.window)
	PlayerPanel.exit = guiCreateButton(353, 325, 165, 32, "Close", false, PlayerPanel.window)
	centerWindows(PlayerPanel.window)


	SalesPanel.window = guiCreateWindow(121, 130, 579, 393, "Aurora ~ Sales Panel", false)
	guiSetVisible(SalesPanel.window,false)
	guiWindowSetSizable(SalesPanel.window, false)
	guiSetAlpha(SalesPanel.window, 0.97)
	centerWindows(SalesPanel.window)

	SalesPanel.label[1] = guiCreateLabel(10, 28, 399, 39, "Items Sales", false, SalesPanel.window)
	guiSetFont(SalesPanel.label[1], "sa-header")
	guiLabelSetColor(SalesPanel.label[1], 255, 67, 67)
	guiLabelSetHorizontalAlign(SalesPanel.label[1], "center", false)
	SalesPanel.my_grid = guiCreateGridList(10, 102, 559, 281, false, SalesPanel.window)
	guiGridListAddColumn(SalesPanel.my_grid, "Item", 0.3)
	guiGridListAddColumn(SalesPanel.my_grid, "Amount", 0.3)
	guiGridListAddColumn(SalesPanel.my_grid, "Cost", 0.3)
	SalesPanel.button[1] = guiCreateButton(419, 61, 150, 35, "Return", false, SalesPanel.window)
	SalesPanel.label[2] = guiCreateLabel(11, 67, 398, 29, "Buy the item again from Trade panel to return it", false, SalesPanel.window)
	guiSetFont(SalesPanel.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(SalesPanel.label[2], "center", false)
	guiLabelSetVerticalAlign(SalesPanel.label[2], "center")

	guiGridListSetSortingEnabled ( PlayerPanel.add_items, false )
	guiGridListSetSortingEnabled ( SalesPanel.my_grid, false )

	refreshPlayerGrid()
	local items = getElementData ( localPlayer, "TradeItems" ) or { }
	if ( not items or type ( items ) ~= "table" or table.len ( items ) <= 0 ) then
		return guiGridListSetItemText ( PlayerPanel.add_items, guiGridListAddRow ( PlayerPanel.add_items ), 1, "No items", true, true )
	else
		for i, v in pairs ( items ) do
			if v ~= 0 then
				local r = guiGridListAddRow ( PlayerPanel.add_items )
				guiGridListSetItemText ( PlayerPanel.add_items, r, 1, i, false ,false )
				guiGridListSetItemText ( PlayerPanel.add_items, r, 2, v, false ,false )
				guiGridListSetItemData ( PlayerPanel.add_items, r, 1, { item=i, quantity=v } )
			end
		end
	end
end

function closeItemsPanel()
	guiSetVisible(PlayerPanel.window,false)
	if ( isTimer ( refreshingTimer ) ) then
		killTimer ( refreshingTimer )
	end
end
function closeSalesPanel()
	guiSetVisible(SalesPanel.window,false)
end



function refreshPlayerGrid()
	triggerServerEvent ( "TradinggetProfileItems", localPlayer )
end

function playerW()
	local weaponsT={}
	for slot = 0, 12 do
		local weapon = getPedWeapon( localPlayer, slot )
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo( localPlayer, slot )
			if ( ammo > 0 ) then
				weaponsT[weapon] = ammo
			end
		end
	end
	local str=toJSON(weaponsT)
	return str
end
function sellItem()
	local r, c = guiGridListGetSelectedItem ( PlayerPanel.add_items )
	if ( r == -1 )  then
		return exports.NGCdxmsg:createNewDxMessage( "There is no item selected", 255, 255, 0 )
	end

	local price = guiGetText ( PlayerPanel.add_price )
	if ( price == "" ) then return exports.NGCdxmsg:createNewDxMessage( "Enter a price", 255, 255, 0 ) end
	local price = tonumber ( price )

	local quan = guiGetText ( PlayerPanel.add_quan )
	if ( quan == "" ) then return exports.NGCdxmsg:createNewDxMessage( "Enter an amount (quantity)", 255, 255, 0 ) end
	local quan = tonumber ( quan )

	local data = guiGridListGetItemData ( PlayerPanel.add_items, r, 1 )
	local item = data.item
	local quantity = data.quantity
	if ( price > itemPrices[item].max or price < ( itemPrices[item].min or 0 ) ) then
		return exports.NGCdxmsg:createNewDxMessage( "The max price for this item is $"..tostring(itemPrices[item].max).." and the minimum price is $"..tostring(itemPrices[item].min), 255, 255, 0 )
	elseif ( quan > amountLimit[item].max or quan < ( amountLimit[item].min or 0 ) ) then
		return exports.NGCdxmsg:createNewDxMessage( "The max amount for this item is "..tostring(amountLimit[item].max).." and the minimum amount is "..tostring(amountLimit[item].min), 255, 255, 0 )
	elseif ( quan == 0 ) then
		return exports.NGCdxmsg:createNewDxMessage( "Invalid quantity", 255, 0, 0 )
	elseif ( quan > quantity ) then
		return exports.NGCdxmsg:createNewDxMessage( "You don't have that much of this item.", 255, 255, 0 )
	end
	
	local st = playerW()
	triggerServerEvent ( "TradingaddItemToShop", localPlayer, item, quan, price,st )
	loop()
	
end

addEvent ( "TradingsendClientItems", true )
addEventHandler ( "TradingsendClientItems", root, function ( list )
	-- top grid
	local r, c = guiGridListGetSelectedItem ( PlayerPanel.add_items )
	local items = getElementData ( localPlayer, "TradeItems" ) or { }
	guiGridListClear ( PlayerPanel.add_items )
	if ( not items or type ( items ) ~= "table" or table.len ( items ) <= 0 ) then
		return guiGridListSetItemText ( PlayerPanel.add_items, guiGridListAddRow ( PlayerPanel.add_items ), 1, "No items", true, true )
	else
		for i, v in pairs ( items ) do
			if v ~= 0 then
				local r = guiGridListAddRow ( PlayerPanel.add_items )
				guiGridListSetItemText ( PlayerPanel.add_items, r, 1, i, false ,false )
				guiGridListSetItemText ( PlayerPanel.add_items, r, 2, v, false ,false )
				guiGridListSetItemData ( PlayerPanel.add_items, r, 1, { item=i, quantity=v } )
			end
		end
	end

	guiGridListSetSelectedItem ( PlayerPanel.add_items, r, c )

	local sRow, sCol = guiGridListGetSelectedItem ( SalesPanel.my_grid )
	guiGridListClear ( SalesPanel.my_grid )
	if ( table.len ( list ) == 0 ) then
		guiGridListSetItemText ( SalesPanel.my_grid, guiGridListAddRow ( SalesPanel.my_grid ), 1, "You don't have any items in the shop", true, true )
		return
	end
	for i, v in pairs ( list ) do
		local r = guiGridListAddRow ( SalesPanel.my_grid )
		guiGridListSetItemText ( SalesPanel.my_grid, r, 1, tostring ( v.item ) .. "(s)", false, false )
		guiGridListSetItemText ( SalesPanel.my_grid, r, 2, tostring( v.quantity ), false, false )
		guiGridListSetItemText ( SalesPanel.my_grid, r, 3, "$"..tostring ( v.amountperone ).."/Unit", false, false )
		guiGridListSetItemData ( SalesPanel.my_grid, r, 1, v )
	end

	if ( r ~= -1 ) then
		guiGridListSetSelectedItem ( SalesPanel.my_grid, sRow, sCol )
	end
end )


addEvent("onServerPlayerTrade",true)
addEventHandler("onServerPlayerTrade",root,function()
	closePanelWindow()
	closeSalesPanel()
	guiSetVisible(PlayerPanel.window,true)
	showCursor(true)
	loop()
end)
------------------------------
-- Event Functions			--
------------------------------
antispam = {}
function panelClick()
	if ( not source or not isElement ( source ) ) then return false end
	if ( source == Panel.exit ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		closePanelWindow()
		closeSalesPanel()
		closeItemsPanel()
		triggerServerEvent("addCloseTimer",localPlayer)
		setElementData(localPlayer,"isPlayerTrading",false)
	elseif ( source == Panel.purchase ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		if forcedClose == true then return false end
		onClientBuyItem ()
		refreshPanels ()
	elseif ( source == Panel.myitems ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		if forcedClose == true then return false end
		triggerServerEvent("onPlayerTradePanel",localPlayer)

		if ( isTimer ( refreshingTimers ) ) then
			killTimer ( refreshingTimers )
		end
		--refreshingTimer = setTimer (  refreshPlayerGrid, 1500, 0 )
	elseif ( source == PlayerPanel.exit ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		if forcedClose == true then return false end
		closeItemsPanel()
		closeSalesPanel()
		guiSetVisible(Panel.window,true)
		showCursor(true)
		refreshPanels()
	elseif ( source == PlayerPanel.add_add ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		if forcedClose == true then return false end
		sellItem()
	elseif ( source == SalesPanel.button[1] ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		if forcedClose == true then return false end
		closeSalesPanel()
		guiSetVisible(PlayerPanel.window,true)
		showCursor(true)
		loop()
		if ( isTimer ( refreshingTimers ) ) then
			killTimer ( refreshingTimers )
		end
	elseif ( source == PlayerPanel.sales ) then
		if antispam[source] and isTimer(antispam[source]) then
			exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam the buttons",255,0,0)
			return false
		end
		antispam[source] = setTimer(function() end,2000,1)
		if forcedClose == true then return false end
		guiSetVisible(SalesPanel.window,true)
		guiSetVisible(PlayerPanel.window,false)
		showCursor(true)
		loop()
		if ( isTimer ( refreshingTimers ) ) then
			killTimer ( refreshingTimers )
		end
	end
end

function guiEditbox()
	if ( not source or not isElement ( source ))  then return end
	if ( source == Panel.purchAmount or source == PlayerPanel.add_price or source == PlayerPanel.add_quan ) then
		guiSetText ( source, guiGetText(source):gsub ( "%p", "" ) )
		guiSetText ( source, guiGetText(source):gsub ( "%s", "" ) )
		guiSetText ( source, guiGetText(source):gsub ( "%a", "" ) )
	end
 end



function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/1.5
	guiSetPosition(theWindow,x,y,false)
end


addEvent("onClientOpenTrade",true)
addEventHandler("onClientOpenTrade",root,function()
	if not guiGetVisible(Panel.window) and not guiGetVisible(PlayerPanel.window) and not guiGetVisible(SalesPanel.window) then
		forcedClose = false
		guiSetVisible(Panel.window,true)
		showCursor(true)
		setElementData(localPlayer,"isPlayerTrading",true)
		refreshPanels()
		loop()
	end
end)

addEventHandler("onClientPlayerQuit",localPlayer,function()
	triggerServerEvent("setPlayerQuit",localPlayer)
end)


local cmds = {
[1]="reconnect",
[2]="quit",
[3]="connect",
[4]="disconnect",
[5]="exit",
}

function unbindTheBindedKey()
	local key = getKeyBoundToCommand("reconnect")
	local key2 = getKeyBoundToCommand("quit")
	local key3 = getKeyBoundToCommand("connect")
	local key4 = getKeyBoundToCommand("disconnect")
	local key5 = getKeyBoundToCommand("exit")
--	local key6 = getKeyBoundToCommand("takehit")
	local key7 = getKeyBoundToCommand("dropkit")
	if key or key2 or key3 or key4 or key5  or key7 then
		if key then
			theKey = "Reconnect/Disconnect"
		elseif key2 then
			theKey = "Reconnect/Disconnect"
		elseif key3 then
			theKey = "Reconnect/Disconnect"
		elseif key4 then
			theKey = "Reconnect/Disconnect"
		elseif key5 then
			theKey = "Reconnect/Disconnect"
	--	elseif key6 then
	--		theKey = "takehit"
		elseif key7 then
			theKey = "dropkit"
		end
		if disabled then return end
		disabled = true
	else
		if not disabled then return end
		disabled = false
	end
end
setTimer(unbindTheBindedKey,500,0)
stuck = false
function handleInterrupt( status, ticks )
	if (status == 0) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago" )
		if getElementData(localPlayer,"isPlayerLoss") ~= true then
			stuck = true
			setElementData(localPlayer,"isPlayerLoss",true)
		end
	elseif (status == 1) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago and has just ended" )
		triggerServerEvent("setPacketLoss",localPlayer,false)
		if getElementData(localPlayer,"isPlayerLoss") == true then
			stuck = false
			setElementData(localPlayer,"isPlayerLoss",false)
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)
lastPacketAmount = 0
local lagfpscount = 0
setTimer(function()
	if not guiGetVisible(Panel.window) and not guiGetVisible(PlayerPanel.window) and not guiGetVisible(SalesPanel.window) then
		lagfpscount = 0
		if ( isTimer ( refreshingTimers ) ) then
			killTimer ( refreshingTimers )
		end
	end
	if getElementData(localPlayer,"isPlayerPrime") then
		return false
	end
	if guiGetVisible(Panel.window) or guiGetVisible(PlayerPanel.window) or guiGetVisible(SalesPanel.window) then
		setPedWeaponSlot(localPlayer,0)
		if stuck == true then
			forceHide()
			msg("You are lagging due Huge Network Loss you can't open trade panel")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			msg("You are lagging due PING you can't open trade panel")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			msg("You can't open trade panel in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			lagfpscount = lagfpscount + 1
			if (lagfpscount >= 30) then
				lagfpscount = 0
				forceHide()
				msg("You are lagging due FPS you can't open trade panel")
			end
		end
		if getElementInterior(localPlayer) ~= 0 then
			forceHide()
			msg("Please be in the real world instead of interiors and other dims")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			msg("Please close Drugs panel")
		end
		if disabled then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Trade system while bounded ("..theKey..")",255,0,0)
		end
		if isConsoleActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Trade system while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Trade system while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			msg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use Trade system while MTA Main Menu is open",255,0,0)
		end
		--[[local network = getNetworkStats(localPlayer)
		if (network["packetsReceived"] > lastPacketAmount) then
			lastPacketAmount = network["packetsReceived"]
		else --Packets are the same. Check ResendBuffer
			if (network["messagesInResendBuffer"] >= 15) then
				forceHide()
				msg("You are lagging like hell (Huge packet loss)")
			end
		end]]
		if Panel.window and guiGetVisible(Panel.window) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= Panel.window then
					if guiGetVisible(v) and guiGetVisible(Panel.window) then
						forceHide()
						msg("Please close any panel open!")
					end
				end
			end
		end
		if PlayerPanel.window and guiGetVisible(PlayerPanel.window) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= PlayerPanel.window then
					if guiGetVisible(v) and guiGetVisible(PlayerPanel.window) then
						forceHide()
						msg("Please close any panel open!")
					end
				end
			end
		end
		if SalesPanel.window and guiGetVisible(SalesPanel.window) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= SalesPanel.window then
					if guiGetVisible(v) and guiGetVisible(SalesPanel.window) then
						forceHide()
						msg("Please close any panel open!")
					end
				end
			end
		end
	end
end,50,0)

addEventHandler("onClientRender",root,function()
	if localPlayer then
		if getElementData(localPlayer,"fire") then
			setPedWeaponSlot(localPlayer,0)
		end
	end
end)


function onClientPlayerWeaponFireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	if localPlayer == source then
		if getElementData(localPlayer,"fire") then
			loop()
			triggerServerEvent("mismatchBreak",source)
		end
		if Panel.window and guiGetVisible(Panel.window) or PlayerPanel.window and guiGetVisible(PlayerPanel.window) then
			forceHide()
			msg("Trading system closed because you are firing by your weapon")
		end
    end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), onClientPlayerWeaponFireFunc )


function msg(s)
	if s then
		exports.NGCdxmsg:createNewDxMessage(s,255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage("You are lagging : You can't open trade panel at the moment!",255,0,0)
	end
end

function forceHide()
	forcedClose = true
	closePanelWindow()
	closeSalesPanel()
	closeItemsPanel()
	showCursor(false)
	triggerServerEvent("addCloseTimer",localPlayer)
	setElementData(localPlayer,"isPlayerTrading",false)
end

function handleMinimize()
	if Panel.window and guiGetVisible(Panel.window) or PlayerPanel.window and guiGetVisible(PlayerPanel.window) then
		forceHide()
    end
end
addEventHandler( "onClientMinimize", root, handleMinimize )

function playerPressedKey(button, press)
	if getKeyState( "latl" ) == true or getKeyState( "escape" ) == true or getKeyState( "ralt" ) == true then
		if Panel.window and guiGetVisible(Panel.window) or PlayerPanel.window and guiGetVisible(PlayerPanel.window) then
			forceHide()
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

function handleRestore( didClearRenderTargets )
    if didClearRenderTargets then
		if Panel.window and guiGetVisible(Panel.window) or PlayerPanel.window and guiGetVisible(PlayerPanel.window) then
			forceHide()
		end
    end
end
addEventHandler("onClientRestore",root,handleRestore)
