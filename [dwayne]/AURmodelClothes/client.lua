local page = 1
local columns = {}
local CJTable = {}
local access = false

local theMarkers = {
{ 1465.28,-1117.1,24.15,0,0},
{2234.98,-1682.47,15.47,0,0},
{438.81,-1508.41,18.45,0,0},
{499.06,-1380.67,16.39,0,0},
--lv
{1672.02,1725.88,10.81,0,0},
{2794.09,2454.21,11.28,0,0},
{2804.06,2443.21,11.06,0,0},
-- SF
{ 214.51, -40.93, 1002.02, 1, 1 },
{ 217.48, -98.81, 1005.25, 15, 6 },
{ 210.84, -8.74, 1005.21, 5, 10 },
{ 181.22, -88.35, 1002.03, 18, 2 }
}

Clothes = {
    gridlist = {},
    staticimage = {},
    button = {},
    label = {}
}

Clothes.staticimage[1] = guiCreateStaticImage(-9, 112, 308, 433, "background.png", false)
guiSetVisible(Clothes.staticimage[1],false)
Clothes.label[1] = guiCreateLabel(17, 31, 271, 37, "AUR ~ CJ Clothes", false, Clothes.staticimage[1])
guiSetFont(Clothes.label[1], "sa-header")
guiLabelSetHorizontalAlign(Clothes.label[1], "center", false)
Clothes.gridlist[1] = guiCreateGridList(20, 78, 268, 282, false, Clothes.staticimage[1])
Clothes.button[1] = guiCreateButton(20, 376, 110, 26, "Close", false, Clothes.staticimage[1])
guiSetProperty(Clothes.button[1], "NormalTextColour", "FFAAAAAA")
Clothes.button[2] = guiCreateButton(178, 376, 110, 26, "Update", false, Clothes.staticimage[1])
guiSetProperty(Clothes.button[2], "NormalTextColour", "FFAAAAAA")
guiSetVisible(Clothes.button[2],false)
Clothes.button[3] = guiCreateButton(178, 376, 110, 26, "Remove/View", false, Clothes.staticimage[1])
guiSetProperty(Clothes.button[3], "NormalTextColour", "FFAAAAAA")


function disableButtons()
	guiSetEnabled(Clothes.button[1],false)
	guiSetEnabled(Clothes.button[2],false)
	guiSetEnabled(Clothes.button[3],false)
	setTimer(enableButtons,1800,1)
end
function enableButtons()
	guiSetEnabled(Clothes.button[1],true)
	guiSetEnabled(Clothes.button[2],true)
	guiSetEnabled(Clothes.button[3],true)
end

function refreshColumns()
	for i=0,#columns do
		if columns[i] then
			guiGridListRemoveColumn(Clothes.gridlist[1],columns[i])
		end
	end
end

function loadGridList(id,nam)
	refreshColumns()
	guiGridListClear(Clothes.gridlist[1])
	refreshColumns()
	if id == 1 then
		refreshColumns()
		local column = guiGridListAddColumn(Clothes.gridlist[1], "Categories", 0.9)
		table.insert(columns,column)
		for i, category in ipairs (types) do
			if category.id ~= nil then
				local typeRow = guiGridListAddRow( Clothes.gridlist[1])
				guiGridListSetItemText( Clothes.gridlist[1], typeRow, 1, category.name, false, false)
				guiGridListSetItemData( Clothes.gridlist[1], typeRow, 1, category.id)
			end
		end
	elseif id == 2 then
		refreshColumns()
		topID = nil
		local column1 = guiGridListAddColumn(Clothes.gridlist[1], "Item Name", 0.4)
		table.insert(columns,column1)
		local column2 = guiGridListAddColumn(Clothes.gridlist[1], "Item Price", 0.2)
		table.insert(columns,column2)
		local column3 = guiGridListAddColumn(Clothes.gridlist[1], "Item Model", 0.3)
		table.insert(columns,column3)
		local column4 = guiGridListAddColumn(Clothes.gridlist[1], "Item Texture", 0.3)
		table.insert(columns,column4)
		for k,v in ipairs(types) do
			if nam == v.name then
				topID = v.id
			end
		end
		if topID ~= nil then
			for i,v in ipairs ( clothes ) do
				if v.id == topID then
					local money = math.random(300,700)
					local aRow = guiGridListAddRow(Clothes.gridlist[1])
					guiGridListSetItemText(Clothes.gridlist[1], aRow, 1, v.name, false, false)
					guiGridListSetItemText(Clothes.gridlist[1], aRow, 2, "$"..v.price+money, false, false)
					guiGridListSetItemText(Clothes.gridlist[1], aRow, 3, v.texture, false, false)
					guiGridListSetItemText(Clothes.gridlist[1], aRow, 4, v.model, false, false)
					guiGridListSetItemData(Clothes.gridlist[1], aRow, 4, v.model)
					guiGridListSetItemData(Clothes.gridlist[1], aRow, 3, v.texture)
					guiGridListSetItemData(Clothes.gridlist[1], aRow, 2, v.price+money)
					guiGridListSetItemData(Clothes.gridlist[1], aRow, 1, v.id)
					if v.modded == true then
						guiGridListSetItemColor(Clothes.gridlist[1], aRow,1,255,160,0)
						guiGridListSetItemColor(Clothes.gridlist[1], aRow,2,255,160,0)
						guiGridListSetItemColor(Clothes.gridlist[1], aRow,3,255,160,0)
						guiGridListSetItemColor(Clothes.gridlist[1], aRow,4,255,160,0)
					end
				end
			end
		end
	elseif id == 3 then
		refreshColumns()
		local column = guiGridListAddColumn(Clothes.gridlist[1], "Categories", 0.9)
		table.insert(columns,column)
		for i=0,17 do
			for k,v in ipairs(types) do
				if v.id == i then
					local row = guiGridListAddRow ( Clothes.gridlist[1] )
					guiGridListSetItemText ( Clothes.gridlist[1], row,1,v.name, true, false )
				end
			end
			local texture, model = getPedClothes ( localPlayer, i )
			if ( texture ~= false ) then
				local aRow = guiGridListAddRow(Clothes.gridlist[1])
				guiGridListSetItemText(Clothes.gridlist[1], aRow, 1, model, false, false)
				guiGridListSetItemData(Clothes.gridlist[1], aRow, 1, i)
				guiGridListSetItemData(Clothes.gridlist[1], aRow, 2, texture)
				guiGridListSetItemData(Clothes.gridlist[1], aRow, 3, model)
			end
		end
	end
end

function setupClothesStore()
	setElementInterior(localPlayer,3)
	setElementPosition(localPlayer,199.64,-127.57,1003.5)
	setPedRotation(localPlayer,177)
	setElementDimension(localPlayer,math.random(6000,9000))
	setElementFrozen(localPlayer,true)
	upgradeCamera()
	createDefaultTable()
end

function removeCJfromStore()
	local tbl = getElementData(localPlayer,"CJstore")
	if tbl then
		access = true
		local x,y,z,dim,int = unpack(tbl)
		setElementInterior(localPlayer,int)
		setElementDimension(localPlayer,dim)
		setElementPosition(localPlayer,x,y,z+1)
		setElementData(localPlayer,"CJstore",false)
		setElementFrozen(localPlayer,false)
		stopCamera()
		toggleAllControls ( true,true,true )
		setTimer(function()
			access = false
		end,5000,1)
	end
end

addEventHandler("onClientResourceStop",root,function()
	local tbl = getElementData(localPlayer,"CJstore")
	if tbl then
		removeCJfromStore()
	end
end)
addEventHandler("onClientPlayerWasted",root,function()
	if source == localPlayer then
		local tbl = getElementData(localPlayer,"CJstore")
		if tbl then
			access = false
			returnClothesFromTable()
			guiSetVisible(Clothes.staticimage[1],false)
			showCursor(false)
		end
	end
end)

addEventHandler("onClientGUIClick",root,function()
	if source == Clothes.button[1] then
		if page == 1 then
			guiSetVisible(Clothes.staticimage[1],false)
			showCursor(false)
			returnClothesFromTable()
			removeCJfromStore()
		elseif page == 2 then
			page = 1
			CamPos = "Body"
			upgradeCamera()
			guiSetText(Clothes.button[1],"Close")
			loadGridList(1,nil)
			guiSetVisible(Clothes.button[2],false)
			guiSetVisible(Clothes.button[3],true)
			returnClothesFromTable()
			disableButtons()
		elseif page == 3 then
			page = 1
			CamPos = "Body"
			upgradeCamera()
			guiSetText(Clothes.button[1],"Close")
			guiSetText(Clothes.button[3],"View")
			loadGridList(1,nil)
			guiSetVisible(Clothes.button[2],false)
			guiSetVisible(Clothes.button[3],true)
			returnClothesFromTable()
			disableButtons()
		end
	elseif source == Clothes.button[2] then
		if page == 2 then
			local row, col = guiGridListGetSelectedItem(Clothes.gridlist[1])
			if row then
				local id = tonumber(guiGridListGetItemData(Clothes.gridlist[1], row, 1))
				local txd = tostring(guiGridListGetItemData(Clothes.gridlist[1], row, 3))
				local dff = tostring(guiGridListGetItemData(Clothes.gridlist[1], row, 4))
				local price = tonumber(guiGridListGetItemData(Clothes.gridlist[1], row, 2))
				if id then
					if getPlayerMoney(localPlayer) >= price then
						triggerServerEvent("onPayClothesCJ",localPlayer,id,txd,dff,price,createClothesJSONString ( "JSON" ))
						setPedAnimation(localPlayer,"CLOTHES","CLO_Buy",-1,false,false,false,false)
						updateDefaultTable()
						disableButtons()
					else
						exports.NGCdxmsg:createNewDxMessage("You don't have enough money!",255,0,0)
					end
				else
					exports.NGCdxmsg:createNewDxMessage("Please choose an item from the list",255,0,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("Please choose an item from the list",255,0,0)
			end
		end
	elseif source == Clothes.button[3] then
		if page == 1 then
			page = 3
			loadGridList(3,nil)
			guiSetText(Clothes.button[3],"Take off")
			guiSetText(Clothes.button[1],"Back")
			exports.NGCdxmsg:createNewDxMessage("Remove any item you are wearing",255,0,0)
		elseif page == 3 then
			local row, col = guiGridListGetSelectedItem(Clothes.gridlist[1])
			if row then
				local id = tonumber(guiGridListGetItemData(Clothes.gridlist[1], row, 1))
				local txd = tostring(guiGridListGetItemData(Clothes.gridlist[1], row, 2))
				local dff = tostring(guiGridListGetItemData(Clothes.gridlist[1], row, 3))
				if id then
					removePedClothes( localPlayer,id,txd,dff)
					loadGridList(3,nil)
					setPedAnimation(localPlayer,"CLOTHES","CLO_Buy",-1,false,false,false,false)
					updateDefaultTable()
					disableButtons()
					outputDebugString("Removed cloth")
				else
					exports.NGCdxmsg:createNewDxMessage("Please choose an item from the list",255,0,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("Please choose which of the clothes you want to remove",255,0,0)
			end
		end
	elseif source == Clothes.gridlist[1] then
		if page == 1 then
			local row, col = guiGridListGetSelectedItem ( Clothes.gridlist[1] )
			if ( row ~= -1 and col ~= 0 ) then
				local name = guiGridListGetItemText(Clothes.gridlist[1], guiGridListGetSelectedItem(Clothes.gridlist[1]), 1)
				if name then
					CamPos = name
					upgradeCamera()
					page = 2
					loadGridList(2,name)
					guiSetText(Clothes.button[1],"Go Back")
					guiSetVisible(Clothes.button[2],true)
					guiSetVisible(Clothes.button[3],false)
				end
			end
		elseif page == 2 then
			local row, col = guiGridListGetSelectedItem(Clothes.gridlist[1])
			if row then
				local tempID = tonumber(guiGridListGetItemData(Clothes.gridlist[1], row, 1))
				local txd = tostring(guiGridListGetItemData(Clothes.gridlist[1], row, 3))
				local dff = tostring(guiGridListGetItemData(Clothes.gridlist[1], row, 4))
				if tempID then
					if tempID == 0 or tempID == 17 or tempID == 13 then
						setPedAnimation(localPlayer,"CLOTHES","CLO_Pose_Torso",-1,false,false,false,false)
						setPedRotation(localPlayer,177)
					elseif tempID == 3 then
						setPedAnimation(localPlayer,"CLOTHES","CLO_Pose_Shoes",-1,false,false,false,false)
						setPedRotation(localPlayer,177)
					elseif tempID == 14 then
						setPedAnimation(localPlayer,"CLOTHES","CLO_Pose_Watch",-1,false,false,false,false)
						setPedRotation(localPlayer,177)
					elseif tempID == 2 then
						setPedAnimation(localPlayer,"CLOTHES","CLO_Pose_Legs",-1,false,false,false,false)
						setPedRotation(localPlayer,177)
					elseif tempID == 16 or tempID == 1 or tempID == 15 then
						setPedAnimation(localPlayer,"CLOTHES","CLO_Pose_Hat",-1,false,false,false,false)
						setPedRotation(localPlayer,177)
					end
					local texture, model = getPedClothes ( localPlayer, tempID )
					if texture == txd then
						return false
					else
						addPedClothes( localPlayer, txd, dff, tempID)
						return false
					end
				end
			end
		end
	end
end)


function createClothesJSONString ( returnType )
	local clothesTable = {}
	local smtn = false
	for i=0,17 do
		local texture, model = getPedClothes ( localPlayer, i )
		if ( texture ) then
			local theType, theIndex = getTypeIndexFromClothes ( texture, model )
			clothesTable[theType] = theIndex
			smtn = true
		end
	end
	if ( smtn ) then
		if ( returnType == "JSON" ) then
			return "" .. toJSON( clothesTable ):gsub( " ", "" ) .. ""
		else
			return clothesTable
		end
	else
		return "NULL"
	end
end

function createDefaultTable()
	CJTable = {}
	for i=0,17 do
		local texture, model = getPedClothes ( localPlayer, i )
		if ( texture ~= false ) then
			table.insert(CJTable,{id=i,txd=texture,dff=model})
		else
			table.insert(CJTable,{id=i,txd="",dff=""})
		end
	end
end

function updateTable()
	CJTable = {}
	for i=0,17 do
		local texture, model = getPedClothes ( localPlayer, i )
		if ( texture ~= false ) then
			table.insert(CJTable,{id=i,txd=texture,dff=model})
		else
			table.insert(CJTable,{id=i,txd="",dff=""})
		end
	end
end

function updateDefaultTable()
	updateTable()
	updateServer()
end

function returnClothesFromTable()
	for i=0,17 do
		removePedClothes(localPlayer,i)
	end
	for int, index in ipairs(CJTable) do
		if (index.txd ~= "") then
			local texture, model = getClothesByTypeIndex ( index.txd, index.dff )
			if ( texture ) then
				addPedClothes ( localPlayer, index.txd, index.dff, index.id )
			end
		end
	end
	updateServer()
	--outputDebugString("Return table of CJ")
end


function stopCamera()
	fadeCamera(false,0, 0, 0, 0)
	setCameraTarget(localPlayer)
	setTimer(fadeCamera,2000,1,true,0.5)
	setTimer(setCameraTarget,2001,1,localPlayer)
end


function upgradeCamera()
	if roxTable then
		CamPos = CamPos or 'Body'
		if not outPos then
			outPos = CamPos
		end
		if not x1 then
			x1,y1,z1,x2,y2,z2,rot = roxTable[CamPos][1],roxTable[CamPos][2],roxTable[CamPos][3],roxTable[CamPos][4],roxTable[CamPos][5],roxTable[CamPos][6],roxTable[CamPos][7]
		end
		if ratio and ratio >= 1 then
			x1,y1,z1,x2,y2,z2,rot = roxTable[outPos][1],roxTable[outPos][2],roxTable[outPos][3],roxTable[outPos][4],roxTable[outPos][5],roxTable[outPos][6],roxTable[outPos][7]
			nx1,ny1,nz1 = roxTable[CamPos][1],roxTable[CamPos][2],roxTable[CamPos][3]
			nx2,ny2,nz2,rot = roxTable[CamPos][4],roxTable[CamPos][5],roxTable[CamPos][6],roxTable[CamPos][7]
			ratio = 0.0
		else
			x1,y1,z1 = getCameraMatrix()
			nx1,ny1,nz1 = roxTable[CamPos][1],roxTable[CamPos][2],roxTable[CamPos][3]
			nx2,ny2,nz2,rot = roxTable[CamPos][4],roxTable[CamPos][5],roxTable[CamPos][6],roxTable[CamPos][7]
			ratio = 0.0
		end
		x1,y1,z1,x2,y2,z2,rot = roxTable[CamPos][1],roxTable[CamPos][2],roxTable[CamPos][3],roxTable[CamPos][4],roxTable[CamPos][5],roxTable[CamPos][6],roxTable[CamPos][7]
		setCameraMatrix( x1,y1,z1,x2,y2,z2,rot or 0  )
	end
end


function onClientCJMarkerHit ( hitElement, matchingDimension )
	if ( matchingDimension ) then
		if ( hitElement == localPlayer ) then
			if (isPedInVehicle(localPlayer)) then return end
			if (not isPedOnGround(localPlayer)) then return end
			local x, y, z = getElementPosition(source)
			local x2, y2, z2 = getElementPosition(localPlayer)
			if (z2 > z+2) then --[[outputDebugString("returned end due to height z2 localplayer: "..z2..", z marker: "..z)]] return end
			if access == true then return false end
			if ( getElementModel ( localPlayer ) == 0 ) then
				if ( getElementData( localPlayer, "wantedPoints" ) < 10 ) then
					fadeCamera( false )
					setTimer(function()
						fadeCamera( true )
						page = 1
						guiSetVisible(Clothes.staticimage[1],true)
						guiSetVisible(Clothes.button[2],false)
						guiSetVisible(Clothes.button[3],true)
						showCursor(true)
						guiSetText(Clothes.button[1],"Close")
						loadGridList(1,nil)
						if not getElementData(localPlayer,"CJstore") then
							local x,y,z = getElementPosition(localPlayer)
							local dim = getElementDimension(localPlayer)
							local int = getElementInterior(localPlayer)
							setElementData(localPlayer,"CJstore",{x,y,z,dim,int})
						end
						setupClothesStore()
					end,1500,1)
					toggleAllControls ( false, true, false )
				else
					exports.NGCdxmsg:createNewDxMessage( "Due absue you can only set CJ clothes when you're not wanted!", 225, 0, 0 )
				end
			else
				exports.NGCdxmsg:createNewDxMessage( "You need the CJ skin before you can set clothes", 225, 0, 0 )
			end
		end
	end
end

function updateServer()
	updateTable()
	setTimer(function()
		triggerServerEvent("onChangeClothesCJ",localPlayer,createClothesJSONString ( "JSON" ),CJTable)
	end,1500,1)
end

for i=1,#theMarkers do
	local x, y, z, int, dim = theMarkers[i][1], theMarkers[i][2], theMarkers[i][3], theMarkers[i][4], theMarkers[i][5]
	local CJMarker = createMarker( x, y, z -1, "cylinder", 2.0, 225, 0, 0, 150)
	setElementInterior( CJMarker, int )
	setElementDimension( CJMarker, dim )
	addEventHandler( "onClientMarkerHit", CJMarker, onClientCJMarkerHit )
end

