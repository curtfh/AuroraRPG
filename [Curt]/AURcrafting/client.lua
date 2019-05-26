--[[
Server Name: AuroraRPG
Resource Name: AURcrafting
Version: 1.0
Developer/s: Curt
]]--

local GUIEditor = {
    label = {},
    edit = {},
    button = {},
    window = {},
    gridlist = {},
    memo = {}
}

local craftableitems = {}

function theGUI ()

	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 919) / 2, (screenH - 478) / 2, 919, 478, "AuroraRPG - Crafting", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.gridlist[1] = guiCreateGridList(9, 43, 254, 425, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Item", 0.5)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Quantity", 0.5)
	GUIEditor.label[1] = guiCreateLabel(7, 22, 246, 16, "Your Items", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
	GUIEditor.gridlist[2] = guiCreateGridList(275, 43, 253, 425, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[2], "Item", 0.9)
	GUIEditor.label[2] = guiCreateLabel(275, 22, 246, 16, "Items to craft", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
	GUIEditor.label[3] = guiCreateLabel(540, 56, 228, 15, "Item to craft:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.label[4] = guiCreateLabel(540, 78, 369, 15, "Required items:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.label[5] = guiCreateLabel(543, 227, 57, 15, "Quantity:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	GUIEditor.edit[1] = guiCreateEdit(600, 220, 62, 32, "1", false, GUIEditor.window[1])
	GUIEditor.button[1] = guiCreateButton(664, 258, 116, 40, "Craft", false, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(538, 258, 116, 40, "Close", false, GUIEditor.window[1])
	GUIEditor.memo[1] = guiCreateMemo(537, 121, 372, 89, "Select an item to craft.", false, GUIEditor.window[1])
	guiMemoSetReadOnly(GUIEditor.memo[1], true)
	GUIEditor.label[6] = guiCreateLabel(540, 99, 76, 15, "Description:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[6], "default-bold-small")   
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2], openClose, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1], itemCraft, false)
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[2], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
	  local valueR = ""
		  if row >= 0 and col >= 0 then 
			for i=1, #craftableitems do
				if (craftableitems[i][1] == guiGridListGetItemText(source, guiGridListGetSelectedItem (source), 1)) then 
					guiSetText (GUIEditor.memo[1], craftableitems[i][2])
					guiSetText (GUIEditor.label[3], "Item to craft: "..craftableitems[i][1])
					local required = fromJSON(craftableitems[i][4])
					for j=1, #required do 
						valueR = tonumber(guiGetText(GUIEditor.edit[1]))*required[j][2].."x "..required[j][1].." | "..valueR
					end 
					guiSetText (GUIEditor.label[4], "Required items: "..valueR)
					return					
				end
			end
				guiSetText (GUIEditor.label[4], "Required items:")
				guiSetText (GUIEditor.label[3], "Item to craft:")
				guiSetText (GUIEditor.memo[1], "Select an item to craft.")
			else
				guiSetText (GUIEditor.label[4], "Required items:")
				guiSetText (GUIEditor.label[3], "Item to craft:")
				guiSetText (GUIEditor.memo[1], "Select an item to craft.")
		  end 
	end, false) 

	addEventHandler ( "onClientGUIChanged", GUIEditor.edit[1], function ( ) 
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
	
	addEventHandler ( "onClientGUIChanged", GUIEditor.edit[1], function ( ) 
		local text = guiGetText (source) 
		local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[2]) 
		if row >= 0 and col >= 0 then 
		local valueR = ""
			for i=1, #craftableitems do
				if (craftableitems[i][1] == guiGridListGetItemText(GUIEditor.gridlist[2], guiGridListGetSelectedItem (GUIEditor.gridlist[2], 1))) then 
					local required = fromJSON(craftableitems[i][4])
					for j=1, #required do 
						valueR = tonumber(text)*required[j][2].."x "..required[j][1].." | "..valueR
					end 
					guiSetText (GUIEditor.label[4], "Required items: "..valueR)
					return
				end 
			end
		end 
	end, false)
end 

function itemCraft ()
	triggerServerEvent("aurcrafting.playerCraftItem", resourceRoot, getLocalPlayer(), guiGridListGetItemText(GUIEditor.gridlist[2], guiGridListGetSelectedItem(GUIEditor.gridlist[2]), 1), tonumber(guiGetText(GUIEditor.edit[1])))
end 

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
disabled = false
theKey = false
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
local lagfpscount = 0
setTimer(function()
if (not isElement(GUIEditor.window[1])) then 
	lagfpscount = 0
	return false
end 
		if stuck == true then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You are lagging due Huge Network Loss you can't open crafting interface.", 255, 0, 0)
		end
		if getPlayerPing(localPlayer) >= 600 then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You are lagging due PING you can't open crafting interface.", 255, 0, 0)
		end
		if getElementDimension(localPlayer) ~= 0 then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other dimension.", 255, 0, 0)
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			lagfpscount = lagfpscount + 1
			if (lagfpscount >= 30) then
				lagfpscount = 0
				destroyElement(GUIEditor.window[1])
				showCursor(false)
				craftableitems = {}
				exports.NGCdxmsg:createNewDxMessage("Your lagging. Unable to open crafting interface.", 255, 0, 0)
			end
		end
		if getElementInterior(localPlayer) ~= 0 then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other interior.", 255, 0, 0)
		end
		if getElementData(localPlayer,"drugsOpen") then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("Close Drugs Panel. Unable to open crafting interface.", 255, 0, 0)
		end
		if disabled then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You can't use crafting interface while bounded ("..theKey..")",255,0,0)
		end
		if isConsoleActive() then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You can't use crafting interface while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			exports.NGCdxmsg:createNewDxMessage("You can't use crafting interface while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
			msg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use crafting interface while MTA Main Menu is open",255,0,0)
		end
end, 500, 0)

function openClose ()
	if getElementDimension(localPlayer) ~= 0 then
		exports.NGCdxmsg:createNewDxMessage("You cannot use this system while your in other dimension.", 255, 0, 0)
		return
	end
		if (isElement(GUIEditor.window[1])) then 
			destroyElement(GUIEditor.window[1])
			showCursor(false)
			craftableitems = {}
		else
			theGUI ()
			showCursor(true)
			triggerServerEvent("aurcrafting.getInventoryData", resourceRoot, getLocalPlayer())
			triggerServerEvent("aurcrafting.clientGetAllCraftableItems", resourceRoot, getLocalPlayer())
		end 
end 
addCommandHandler ("craft", openClose, true)

function updateCraftableList (itemdata) 
	local itemdata = fromJSON(itemdata)
	craftableitems = itemdata
	for i=1, #itemdata do
		guiGridListAddRow(GUIEditor.gridlist[2], itemdata[i][1])
	end 
end 
addEvent("aurcrafting.updateCraftableList", true)
addEventHandler("aurcrafting.updateCraftableList", localPlayer, updateCraftableList)

function updateList (itemdata)
	local itemdata = fromJSON(itemdata)
	for i=1, #itemdata do
		guiGridListAddRow(GUIEditor.gridlist[1], itemdata[i][1], itemdata[i][2])
	end 
end 
addEvent("aurcrafting.updateList", true)
addEventHandler("aurcrafting.updateList", localPlayer, updateList)