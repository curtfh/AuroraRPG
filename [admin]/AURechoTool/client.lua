local elem = {}
local sw, sh = guiGetScreenSize()
local part = ""

addEventHandler("onClientResourceStart",resourceRoot,
	function()
		triggerServerEvent("eEdit.checkPermission",localPlayer)
	end
)

addEvent("eEdit.onClientVerified",true)
addEventHandler("eEdit.onClientVerified",root,
	function()
		if getElementData(localPlayer,"isPlayerPrime") then
			for k,v in pairs(elem) do
				if isElement(v) then destroyElement(v) end
			end
			elem = {}

			elem.window = guiCreateWindow(sw/2-473/2,sh/2-394/2,800,500,"Element data modifier",false)
			elem.playerlist = guiCreateComboBox(9,29,156,340,getPlayerName(getElementsByType"player"[math.random(#getElementsByType"player")]),false,elem.window)
			elem.e_key = guiCreateEdit(9,88,157,25,"",false,elem.window)
			elem.e_value = guiCreateEdit(9,148,157,25,"",false,elem.window)
			elem.e_search = guiCreateEdit(171,312,302,24,"",false,elem.window)
			elem.cbox_type = guiCreateComboBox(9,211,156,100,"string",false,elem.window)
			elem.modify = guiCreateButton(9,312,156,24,"Modify",false,elem.window)
			elem.refreshP = guiCreateButton(9,345,156,24,"Refresh players",false,elem.window)
			elem.refreshE = guiCreateButton(171,345,156,24,"Refresh element data",false,elem.window)
			elem.close = guiCreateButton(333,345,156,24,"Close",false,elem.window)
			elem.grid = guiCreateGridList(171,28,602,481,false,elem.window)
			elem.l_key = guiCreateLabel(8,67,157,19,"Key",false,elem.window)
			elem.l_value = guiCreateLabel(8,129,157,19,"Value",false,elem.window)
			elem.l_type = guiCreateLabel(8,191,157,19,"Type",false,elem.window)
			elem.c_key = guiGridListAddColumn(elem.grid,"Key",0.35)
			elem.c_value = guiGridListAddColumn(elem.grid,"Value",0.35)
			elem.c_type = guiGridListAddColumn(elem.grid,"Type",0.2)

			elem.l_debug = guiCreateLabel(0,370,473,20,"",false,elem.window)

			guiComboBoxAddItem(elem.cbox_type,"string")
			guiComboBoxAddItem(elem.cbox_type,"number")
			guiComboBoxAddItem(elem.cbox_type,"boolean")
			guiComboBoxAddItem(elem.cbox_type,"nil")

			guiSetAlpha(elem.window,1)
			guiWindowSetSizable(elem.window,false)

			guiGridListSetSelectionMode(elem.grid,0)

			guiLabelSetHorizontalAlign(elem.l_key,"center",false)
			guiLabelSetHorizontalAlign(elem.l_value,"center",false)
			guiLabelSetHorizontalAlign(elem.l_type,"center",false)
			guiLabelSetHorizontalAlign(elem.l_debug,"center",false)



			refreshPlayers()
			refreshElementData()
		end
	end
)

addCommandHandler("elemedit",
	function()
		if getElementData(localPlayer,"isPlayerPrime") then
			if isElement(elem.window) then
				local bool = not guiGetVisible(elem.window)
				guiSetVisible(elem.window,bool)
				showCursor(bool)
				setTimer(refreshElementData,2000,0)
			end
		end
	end
)

addEventHandler("onClientGUIClick",root,
	function(button)
		if button == "left" then
			if source == elem.modify then
				local player = getPlayerFromName(guiGetText(elem.playerlist))
				local key = guiGetText(elem.e_key)
				local value = guiGetText(elem.e_value)
				local type_ = guiGetText(elem.cbox_type)
				if type_ == "string" then
					value = tostring(value)
				elseif type_ == "number" then
					value = tonumber(value)
					if not value then
						guiSetText(elem.l_debug,"*ERROR: Please specify a numerical value when number type selected")
						guiLabelSetColor(elem.l_debug,255,0,0)
						return false
					end
				elseif type_ == "boolean" then
					if value == "true" then
						value = true
					elseif value == "false" then
						value = false
					else
						guiSetText(elem.l_debug,"*ERROR: Please specify 'false' or 'true' when boolean type selected")
						guiLabelSetColor(elem.l_debug,255,0,0)
						return false
					end
				elseif type_ == "nil" then
					value = nil
				end
				if player and key and type_ and setElementData(player,key,value) then
					refreshElementData()
					guiSetText(elem.l_debug,getPlayerName(player):gsub("#%x%x%x%x%x%x","").."'s element data successfully modified Key: "..tostring(key).." Value: "..tostring(value).." ["..type_.."]")
					guiLabelSetColor(elem.l_debug,0,255,0)
				else
					guiSetText(elem.l_debug,"*ERROR: Failed to modify element data!")
					guiLabelSetColor(elem.l_debug,255,0,0)
				end
			elseif source == elem.close then
				guiSetVisible(elem.window,false)
				showCursor(false)
			elseif source == elem.playerlist then
				guiSetText(source, guiComboBoxGetItemText(source,guiComboBoxGetSelected(source)))
			elseif source == elem.cbox_type then
				guiSetText(source, guiComboBoxGetItemText(source,guiComboBoxGetSelected(source)))
			elseif source == elem.grid then
				local r, c = guiGridListGetSelectedItem(source)
				if r and c and r ~= -1 and c ~= -1 then
					guiSetText(elem.e_key, guiGridListGetItemText(source,guiGridListGetSelectedItem(source),elem.c_key))
					guiSetText(elem.e_value, guiGridListGetItemText(source,guiGridListGetSelectedItem(source),elem.c_value))
					guiSetText(elem.cbox_type, guiGridListGetItemText(source,guiGridListGetSelectedItem(source),elem.c_type))
				end
			elseif source == elem.refreshP then
				refreshPlayers()
			elseif source == elem.refreshE then
				refreshElementData()
			end
		end
	end
)

function refreshPlayers()
	guiComboBoxClear(elem.playerlist)
	for i,v in ipairs(getElementsByType'player') do
		if eventName == "onClientPlayerQuit" then
			if source ~= v then
				guiComboBoxAddItem(elem.playerlist,getPlayerName(v))
			end
		else
			guiComboBoxAddItem(elem.playerlist,getPlayerName(v))
		end
	end
end

function refreshElementData()
	local player = getPlayerFromName(guiGetText(elem.playerlist))
	if player then
		triggerServerEvent("eEdit.submitPlayerElement",localPlayer,player)
	else
		guiSetText(elem.l_debug,"*ERROR: Player not found")
		guiLabelSetColor(elem.l_debug,255,0,0)
	end
end

addEvent("eEdit.receiveElementData",true)
addEventHandler("eEdit.receiveElementData",root,
	function(tab)
		if not part then part = "" end
		if tab then
			guiGridListClear(elem.grid)
			for k,v in pairs(tab) do
				local row = guiGridListAddRow(elem.grid)
				if tostring(k):lower():find(part:lower(),1,true) or tostring(v):lower():find(part:lower(),1,true) then
					guiGridListSetItemText(elem.grid,row,elem.c_key,k,false,false)
					guiGridListSetItemText(elem.grid,row,elem.c_value,tostring(v),false,false)
					guiGridListSetItemText(elem.grid,row,elem.c_type,type(v),false,false)
				end
			end
		end
	end
)

addEvent("eEdit.destroyElements",true)
addEventHandler("eEdit.destroyElements",root,
	function()
		for k,v in pairs(elem) do
			if isElement(v) then destroyElement(v) end
		end
		showCursor(false)
	end
)

addEventHandler("onClientGUIChanged",root,
	function()
		if source == elem.e_search then
			part = guiGetText(source)
			refreshElementData()
		end
	end
)

addEventHandler("onClientPlayerChangeNick",root,
	function(old,new)
		if old == guiGetText(elem.playerlist) then
			setTimer(guiSetText,300,1,elem.playerlist,new)
		end
		refreshPlayers()
	end
)

addEventHandler("onClientPlayerJoin",root,refreshPlayers)
addEventHandler("onClientPlayerQuit",root,refreshPlayers)
