-- OnPlayerZoneChange
local x1, y1, z1 = getElementPosition( localPlayer )
local oldZone = getZoneName ( x1, y1, z1, true )
--addEventHandler( "onClientRender", root,
setTimer(function ()
	local x2, y2, z2 = getElementPosition( localPlayer )
	local newZone = getZoneName ( x2, y2, z2, true )
	if ( oldZone ~= newZone ) and ( getPlayerTeam( localPlayer ) ) then
		triggerServerEvent( "playerZoneChange", localPlayer, oldZone, newZone )
		triggerEvent( "onClientPlayerZoneChange", localPlayer, oldZone, newZone )
		x1, y1, z1 = getElementPosition( localPlayer )
		oldZone = getZoneName ( x1, y1, z1, true )
	end
end,3000,0)

local hRow = nil
local mRow = nil
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
		{ "Remove hat" }

};


theMasks = {
	{"Demon",1544,scale=1,rotx=0,roty=0,rotz=0,z=0.038,y=0.030},
	{"Demon2",1664,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.025},
	{"Ape",1543,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.025},
	{"Ape2",1546,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.025},
	{"Hockey",1551,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.040},
	{"Pig",1667,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.040},
	{"Mickey",1668,scale=0.9,rotx=0,roty=0,rotz=90,z=0.06,y=0.025},
	{"Vendetta",1669,scale=1,rotx=0,roty=270,rotz=0,z=0.06,y=0.11},
	{"Cat",1517,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=0.008},
	{"Bird",1512,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=-0.05},
	{"Fox",1510,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=0.008},
	{"Fox2",1509,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=0.008},
	{"Iron man",1455,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=-0.01},
	{"Biker helmet",1951,scale=1,rotx=0,roty=0,rotz=90,z=-0.6,y=-0.006},
	{"bunnyears",1950,scale=1,rotx=90,roty=0,rotz=0,z=0.06,y=-0.04},
	{ "Remove mask" }
}

v3 = {
    gridlist = {},
    button = {},
    label = {}
	}

function centerWindow( center_window )
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize( center_window, false )
    local x, y = ( screenW - windowW ) /2, ( screenH - windowH ) / 2
    guiSetPosition( center_window, x, y, false )
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()

	pPanel = guiCreateWindow(6, 10, 780, 560, "Aurora ~ VIP Panel", false)
	guiWindowSetSizable(pPanel, false)
	guiSetVisible(pPanel,false)
	centerWindow(pPanel)

	iTab = guiCreateTabPanel(9, 160, 752, 390, false, pPanel)

	infTab = guiCreateTab("Information", iTab)

	name = guiCreateLabel(15, 18, 226, 24, "Your name :", false, infTab)
	guiSetFont(name, "clear-normal")
	aname = guiCreateLabel(435, 18, 307, 24, "Your account name :", false, infTab)
	guiSetFont(aname, "clear-normal")
	serial = guiCreateLabel(15, 112, 226, 24, "Your serial :", false, infTab)
	guiSetFont(serial, "clear-normal")
	email = guiCreateLabel(15, 273, 307, 22, "Your email :", false, infTab)
	guiSetFont(email, "clear-normal")
	country = guiCreateLabel(435, 110, 311, 21, "Your country :", false, infTab)
	guiSetFont(country, "clear-normal")
	location = guiCreateLabel(15, 193, 226, 24, "Your location :", false, infTab)
	guiSetFont(location, "clear-normal")
	phours = guiCreateLabel(435, 193, 226, 24, "Your VIP hours :", false, infTab)
	guiSetFont(phours, "clear-normal")

	feaTab = guiCreateTab("Features", iTab)

	scrollpane = guiCreateScrollPane(0, 0, 742, 355, false, feaTab)
	VehCheck1 = guiCreateRadioButton(266, 54, 108, 18, "Car", false, scrollpane)
	VehCheck2 = guiCreateRadioButton(356, 54, 108, 17, "Maverick", false, scrollpane)
	VehCheck3 = guiCreateRadioButton(266, 84, 102, 18, "Bike", false, scrollpane)
	VehCheck4 = guiCreateRadioButton(355, 84, 102, 15, "Boat", false, scrollpane)
	guiRadioButtonSetSelected(VehCheck1,true)
	pCar = guiCreateButton(266, 130, 199, 25, "Get VIP Vehicle", false, scrollpane)
	guiSetProperty(pCar, "NormalTextColour", "FFAAAAAA")
	jPack = guiCreateButton(266, 172, 199, 25, "Get Jet Pack", false, scrollpane)
	guiSetProperty(jPack, "NormalTextColour", "FFAAAAAA")
	pChat = guiCreateButton(266, 207, 199, 25, "Toggle VIP Chat", false, scrollpane)
	guiSetProperty(pChat, "NormalTextColour", "FFAAAAAA")
	pHats = guiCreateButton(265, 320, 199, 25, "Toggle VIP Hat", false, scrollpane)
	guiSetProperty(pHats, "NormalTextColour", "FFAAAAAA")
	hatList = guiCreateGridList(21, 283, 230, 233, false, scrollpane)
	guiGridListAddColumn(hatList, "Hats", 0.8)
	pHtoM = guiCreateLabel(470, 22, 250, 17, "Convert VIP hours to money", false, scrollpane)
	guiSetFont(pHtoM, "default-bold-small")
	guiLabelSetHorizontalAlign(pHtoM, "center", false)
	guiLabelSetVerticalAlign(pHtoM, "center")
	pHtoMI = guiCreateLabel(496, 54, 200, 18, "Each hour costs $10,000", false, scrollpane)
	guiSetFont(pHtoMI, "default-bold-small")
	guiLabelSetColor(pHtoMI, 255, 166, 0)
	guiLabelSetHorizontalAlign(pHtoMI, "center", false)
	hours = guiCreateEdit(496, 82, 199, 23, "Insert Hours", false, scrollpane)
	convert = guiCreateButton(496, 110, 199, 25, "Convert", false, scrollpane)
	guiSetProperty(convert, "NormalTextColour", "FFAAAAAA")
	pSkins = guiCreateLabel(15, 23, 220, 16, "VIP skins Cost ($5500)", false, scrollpane)
	guiSetFont(pSkins, "default-bold-small")
	guiLabelSetHorizontalAlign(pSkins, "center", false)
	Check1 = guiCreateRadioButton(21, 54, 108, 18, "Mila", false, scrollpane)
	Check2 = guiCreateRadioButton(21, 82, 108, 17, "Chloe", false, scrollpane)
	Check3 = guiCreateRadioButton(143, 54, 102, 18, "Tommy", false, scrollpane)
	Check4 = guiCreateRadioButton(143, 84, 102, 15, "Clarke", false, scrollpane)
	pSkinButton = guiCreateButton(31, 109, 199, 25, "Select VIP Skin", false, scrollpane)
	guiSetProperty(pSkinButton, "NormalTextColour", "FFAAAAAA")
	lbl = guiCreateLabel(21, 250, 230, 15, "VIP hats", false, scrollpane)
	guiSetFont(lbl, "default-bold-small")
	guiLabelSetHorizontalAlign(lbl, "center", false)
	guiLabelSetVerticalAlign(lbl, "center")
	v3.button[1] = guiCreateButton(265, 377, 199, 25, "Toggle VIP Mask", false, scrollpane)
	guiSetProperty(v3.button[1], "NormalTextColour", "FFAAAAAA")
	maskList = guiCreateGridList(480, 287, 230, 233, false, scrollpane)
	guiGridListAddColumn(maskList, "Masks", 0.9)
	v3.label[1] = guiCreateLabel(480, 245, 230, 15, "VIP masks", false, scrollpane)
	guiSetFont(v3.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(v3.label[1], "center", false)
	guiLabelSetVerticalAlign(v3.label[1], "center")
	v3.label[2] = guiCreateLabel(250, 23, 230, 15, "Extenstions", false, scrollpane)
	guiSetFont(v3.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(v3.label[2], "center", false)
	guiLabelSetVerticalAlign(v3.label[2], "center")



	wText = guiCreateLabel(164, 165, 489, 17, "Welcome to VIP panel Epozide, here you can control your VIP stuff, and features.", false, pPanel)
	guiSetFont(wText, "default-bold-small")
	guiLabelSetColor(wText, 255, 150, 0)
	image = guiCreateStaticImage(155, 54, 428, 101, ":AURvip/logo.png", false, pPanel)
	cButton = guiCreateButton(593, 123, 168, 32, "Close", false, pPanel)
	guiSetProperty(cButton, "NormalTextColour", "FFAAAAAA")
	guiScrollPaneSetVerticalScrollPosition( scrollpane, 0 )
	addEventHandler( "onClientGUIChanged", hours, removeLetters, false )


    for i,m_obj in ipairs( aObjects ) do
		hRow = guiGridListAddRow( hatList );
		guiGridListSetItemText (hatList, hRow, 1, tostring( m_obj [ 1 ] ), false, false );
		if m_obj [ 2 ] then
			guiGridListSetItemData (hatList, hRow, 1, tostring( m_obj [ 2 ] ) )
		end
	end
    for i,m_obj in ipairs( theMasks ) do
		mRow = guiGridListAddRow( maskList );
		guiGridListSetItemText (maskList, mRow, 1, tostring( m_obj [ 1 ] ), false, false );
		if m_obj [ 2 ] then
			guiGridListSetItemData (maskList, mRow, 1, tostring( m_obj [ 2 ] ) )
		end
	end
end)



addEventHandler("onClientGUIClick",root,function()
	if source == pCar then
		sec = false
		if guiRadioButtonGetSelected(VehCheck1) then
			id = 526
			sec = true
		elseif guiRadioButtonGetSelected(VehCheck2) then
			id = 487
			sec = true
		elseif guiRadioButtonGetSelected(VehCheck3) then
			id = 522
			sec = true
		elseif guiRadioButtonGetSelected(VehCheck4) then
			id = 452
			sec = true
		else
			exports.NGCdxmsg:createNewDxMessage("Please select VIP Vehicle Type",255,0,0)
			return false
		end
		if sec == true then
			if exports.NGCsafezone:isElementWithinSafeZone(localPlayer) then
				exports.NGCnote:addNote("Vip","You can't spawn VIP vehicle inside safe zone!",255,0,0,5000)
				return false
			end
			triggerServerEvent("getVIPCar",localPlayer,localPlayer,id)
			sec = false
		else
			exports.NGCdxmsg:createNewDxMessage("Please select VIP Vehicle Type",255,0,0)
		end
	elseif source == cButton then
		guiSetVisible( pPanel, false )
		showCursor( false )
	elseif source == jPack then
		triggerServerEvent("onGetJetPack",localPlayer,localPlayer)
	elseif source == convert then
		local value = guiGetText(hours)
		triggerServerEvent("convertVIPMoney",localPlayer,localPlayer,value)
	elseif source == pChat then
		triggerServerEvent("togglevchat",localPlayer,localPlayer)
	elseif source == pHats then
		local row, col = guiGridListGetSelectedItem (hatList)
		if ( row and col and row ~= -1 and col ~= -1 ) then
			local model = tonumber ( guiGridListGetItemData (hatList, row, 1 ) )
			local scale=1
			local name = ""
			for k,v in pairs(aObjects) do
				if v[2] == model then
					name=v[1]
					if v.scale ~= nil then scale=v.scale break end
				end
			end
			if not getElementData(localPlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage("You are not VIP",255,0,0) return end
			if model ~= nil then
				exports.NGCdxmsg:createNewDxMessage("You are now wearing the "..name.." hat",0,255,0)
			end
			triggerServerEvent("vipHats_changeHat",localPlayer,model,scale)
		end
	elseif source == v3.button[1] then
		local row, col = guiGridListGetSelectedItem (maskList)
		if ( row and col and row ~= -1 and col ~= -1 ) then
			local model = tonumber ( guiGridListGetItemData (maskList, row, 1 ) )
			local scale=1
			local name = ""
			for k,v in pairs(theMasks) do
				if v[2] == model then
					name=v[1]
					rotx,roty,rotz = v.rotx,v.roty,v.rotz
					z=v.z
					y=v.y
					if v.scale ~= nil then scale=v.scale break end
				end
			end
			if not getElementData(localPlayer, "isPlayerVIP") then exports.NGCdxmsg:createNewDxMessage("You are not VIP",255,0,0) return end
			if model ~= nil then
				exports.NGCdxmsg:createNewDxMessage("You are now wearing the "..name.." mask",0,255,0)
			end
			triggerServerEvent("changeMask",localPlayer,model,scale,rotx,roty,rotz,z,y)
		end
	elseif source == pSkinButton then
		setElementData(localPlayer,"skinShopTempSkin",getElementModel(localPlayer))
		if guiRadioButtonGetSelected(Check1) then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,94,5500)
		elseif guiRadioButtonGetSelected(Check2) then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,183,5500)
		elseif guiRadioButtonGetSelected(Check3) then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,52,5500)
		elseif guiRadioButtonGetSelected(Check4) then
			triggerServerEvent("buyVIPSkin",localPlayer,localPlayer,41,5500)
		else
			exports.NGCdxmsg:createNewDxMessage("Please check skin ID first",255,0,0)
			return false
		end
	end
end)


function toggleVIPWindow()
	if not (exports.server:isPlayerLoggedIn(localPlayer)) then return end
	if getElementData(localPlayer,"isATMOpened",true) then return end
	if getElementData(localPlayer,"isPlayerVIP") == true then
	if ( guiGetVisible( pPanel ) ) then
		guiSetVisible( pPanel, false )
		showCursor( false )
	else
		guiSetVisible( pPanel, true )
		showCursor(true)
		centerWindow( pPanel )
		updatePanel()
		end
	end
end
addEvent( "openVIP", true )
addEventHandler( "openVIP", localPlayer, toggleVIPWindow )






function updatePanel()
	guiSetText(wText,"Welcome to VIP panel "..getPlayerName(localPlayer)..", here you can control your VIP stuff.")
	guiSetText(name,"Your Name:"..getPlayerName(localPlayer))
	local serials = getPlayerSerial(localPlayer)
	guiSetText(serial,"Your serial:"..serials)
	local accn = exports.server:getPlayerAccountName(localPlayer)
	guiSetText(aname,"Your account:"..accn)
	local emails = exports.server:getPlayerAccountEmail(localPlayer)
	guiSetText(email,"Your Email:"..emails)
	local x,y,z = getElementPosition(localPlayer)
	local zone = getZoneName(x,y,z)
	guiSetText(location,"Your zone:"..zone)
	if (getElementData(localPlayer, "Country")) then
		countryx = getElementData(localPlayer, "Country")
		guiSetText(country,"Your country:"..countryx)
	else
		countryx = "Country is not found"
		guiSetText(country,"Your Country:"..countryx)
	end
	triggerServerEvent("VIP",localPlayer,localPlayer)
end


addEvent("updatesPremHours",true)
addEventHandler("updatesPremHours",root,function(hours,typeofprem)
	if hours and typeofprem then
		guiSetText(phours,"Your VIP hours:"..hours.." "..typeofprem)
	end
end)




function removeLetters(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end


masks = {
	{"mask1Demon",1544},
	{"mask2Ape",1543},
	{"mask3Ape2",1546},
	{"mask4Hockey",1551},
	{"mask5Demon2",1664},
	{"mask6Pig",1667},
	{"mask7Mickey",1668},
	{"mask8Vendetta",1669},
	{"mask9bunnyears",1950},
	{"mask10cat",1517},
	{"mask11bo",1512},
	{"mask12fox",1510},
	{"mask13id",1509},
	{"mask14biker",1951},
	{"mask15Iron",1455},
	{"Chloe",183},
	{"Mila",94},
	{"tommy",52},
	{"Clarke",41},
	{"pCar",526},
}
--- not used and able 1951,1455,1484,1486,1487
local mods = {}
local txdFile = {}
local dffFile = {}

function onThisResourceStart ( )
	for k,v in ipairs(masks) do
		downloadFile ( "models/"..v[1]..".dff" )
	end
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )


function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
			for k,v in ipairs(masks) do
				if file == "models/"..v[1]..".dff" then
					if fileExists(":AURvip/models/"..v[1]..".dff") then
						loadMyMods(v[1],":AURvip/models/"..v[1]..".dff",":AURvip/models/"..v[1]..".txd",v[2],v[1],"models")
					end
				elseif file == "models/"..v[1]..".txd" then
					loadSkins(v[1],v[2],"models")
				end
            end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )

function loadMyMods(name,dff,txd,id,wh,p)
	downloadFile ( p.."/"..name..".txd" )
end

function loadSkins(name,id,ty)
	mods[name] = {
		{name,id}
	}
	replaceMods(name,ty)
end

function replaceMods(name,ty)
	if ty == "models" then
		for k,v in ipairs(mods[name]) do
			if fileExists(":AURvip/models/"..v[1]..".txd") then
				txd = engineLoadTXD(":AURvip/models/"..v[1]..".txd")
				if txd and txd ~= false then
					engineImportTXD(txd,v[2])
				end
			end
			if fileExists(":AURvip/models/"..v[1]..".dff") and fileExists(":AURvip/models/"..v[1]..".txd") then
				if fileExists(":AURvip/models/"..v[1]..".dff") then
					dff = engineLoadDFF(":AURvip/models/"..v[1]..".dff",v[2])
					if txd and txd ~= false then
						if dff and dff ~= false then
							if v[2] then
								engineReplaceModel(dff,v[2])
								--outputChatBox("Downloading:"..v[1].."("..v[2]..")")
							end
						end
					end
				end
			end
		end
	end
end


function hudswitch(t)
	if t == true then
		if fileExists(":AURvip/models/pCar.txd") then
			txd = engineLoadTXD(":AURvip/models/pCar.txd")
			if txd and txd ~= false then
				engineImportTXD(txd,526)
				if fileExists(":AURvip/models/pCar.dff") and fileExists(":AURvip/models/pCar.txd") then
					dff = engineLoadDFF(":AURvip/models/pCar.dff",526)
					engineReplaceModel(dff,526)
				end
			end
		end
	else
		engineRestoreModel(526)
	end
end


addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, hudstate )
		if setting == "VIPCar" then
			if getElementDimension(localPlayer) == 0 then
				hudswitch( hudstate )
			end
		end
	end
)


function checkSettinghud()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "VIPCar" )
		hudswitch( setting )
	else
		setTimer( checkSettinghud, 10000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettinghud )

