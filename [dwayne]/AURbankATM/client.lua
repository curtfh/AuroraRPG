

local bankingSpam = {}

local bankingMarkers = {
[1]={562.79998779297, -1254.5999755859, 16.89999961853, 284},
[2]={1001.700012207, -929.40002441406, 41.799999237061, 278.74658203125},
[3]={1019.4000244141, -1030, 31.700000762939, 358.49505615234},
[4]={926.79998779297, -1359.3000488281, 13, 272.49487304688},
[5]={1193.3994140625, -916.599609375, 42.799999237061, 6.492919921875},
[6]={485.39999389648, -1733.5999755859, 10.800000190735, 172.49389648438},
[7]={812.3994140625, -1618.7998046875, 13.199999809265, 90.488891601563},
[8]={1366.6390380859, -1274.2590332031, 13.246875, 270},
[9]={1742.1999511719, -2284.3999023438, 13.199999809265, 270},
[10]={2105.5, -1804.3000488281, 13.199999809265, 270},
[11]={1760.099609375, -1940.099609375, 13.199999809265, 91.99951171875},
[12]={2404.1999511719, -1934.5999755859, 13.199999809265, 90},
[13]={1928.599609375, -1767.099609375, 13.199999809265, 91.99951171875},
[14]={2419.8999023438, -1506, 23.60000038147, 90},
[15]={2758.2998046875, -1824.3994140625, 11.5, 19.9951171875},
[16]={2404.3999023438, -1237.5, 23.5, 90},
[17]={2136.3000488281, -1154.1999511719, 23.60000038147, 152},
[18]={1212.93, -1816.11, 16.09, 84.675659179688},
[19]={2027.19921875, -1401.8994140625, 16.89999961853, 359.99450683594},
[20]={1498.4798583984, -1581.0864257813, 13.149827575684, 359.99499511719},
[21]={-2330.3000488281, -163.89999389648, 35.200000762939, 359.99450683594},
[22]={-1410.2998046875, -296.7998046875, 13.800000190735, 307.99072265625},
[23]={-2121.19921875, -451.2998046875, 35.180000305176, 279.99206542969},
[24]={-2708.5, -308.10000610352, 6.8000001907349, 225.98901367188},
[25]={-2695.5, 260.10000610352, 4.3000001907349, 179.98876953125},
[26]={-2672, 634.65002441406, 14.10000038147, 359.98352050781},
[27]={-2767.6000976563, 790.29998779297, 52.400001525879, 89.977996826172},
[28]={-2636.3000488281, 1399.1999511719, 6.6999998092651, 13.972534179688},
[29]={-2417.8999023438, 1028.8000488281, 50, 179.96911621094},
[30]={-2414.8999023438, 352.89999389648, 34.799999237061, 51.967041015625},
[31]={-1962, 123.40000152588, 27.299999237061, 269.96533203125},
[32]={-2024.7998046875, -102, 34.799999237061, 177.96203613281},
[33]={-1675.8000488281, 434, 6.8000001907349, 136},
[34]={-1967.19921875, 291.5, 34.799999237061, 269.96154785156},
[35]={-1813.8000488281, 618.40002441406, 34.799999237061, 357.99975585938},
[36]={-1911.1999511719, 824.40002441406, 34.799999237061, 87.994995117188},
[37]={-1571.0999755859, 697.29998779297, 6.8000001907349, 89.989501953125},
[38]={-1648.2998046875, 1214.19921875, 6.8000001907349, 135.98876953125},
[39]={-1872.0999755859, 1137.9000244141, 45.099998474121, 270},
[40]={-1806.19921875, 955.7998046875, 24.5, 89.989013671875},
[41]={2841.6000976563, 1270, 11, 269.75},
[42]={1437.599609375, 2647.7998046875, 11, 270},
[43]={2159.5, 939.29998779297, 10.5, 269.74731445313},
[44]={2020.1999511719, 999.20001220703, 10.5, 90},
[45]={2227.7998046875, 1402.7998046875, 10.699999809265, 90},
[46]={1590.8000488281, 703.29998779297, 10.5, 270},
[47]={1075.5999755859, 1596.6999511719, 12.199999809265, 212},
[48]={1591.6999511719, 2217.8999023438, 10.699999809265, 1},
[49]={997.8994140625, 2175.7998046875, 10.5, 87.994995117188},
[50]={1146.099609375, 2075, 10.699999809265, 0.999755859375},
[51]={1464.599609375, 2251.69921875, 10.699999809265, 178.99475097656},
[52]={1671.423828125, 1806.6412353516, 10.5203125, 268.99975585938},
[53]={1948.8000488281, 2062.1000976563, 10.699999809265, 268.99096679688},
[54]={2187.8000488281, 2464.1000976563, 10.89999961853, 88.989288330078},
[55]={2833.3000488281, 2402.8000488281, 10.699999809265, 44.9892578125},
[56]={2539.3999023438, 2080.1999511719, 10.5, 270.98901367188},
[57]={2179.5, 1702.8000488281, 10.699999809265, 272},
[58]={2102.2998046875, 2232.099609375, 10.699999809265, 90},
[59]={2638.3999023438, 1675.4000244141, 10.699999809265, 269.99951171875},
[60]={1381, 259.70001220703, 19.200000762939, 153.99450683594},
[61]={2334.2998046875, 67.69921875, 26.10000038147, 87.989501953125},
[62]={196.30000305176, -202, 1.2000000476837, 359.98986816406},
[63]={-2090, -2467.8000488281, 30.299999237061, 141.98904418945},
[64]={693.599609375, -520.3994140625, 16, 359.98901367188},
[65]={-2256.3999023438, 2376.3999023438, 4.5999999046326, 311.9873046875},
[66]={-2206.099609375, -2291.599609375, 30.299999237061, 139.98229980469},
[67]={-1511.4000244141, 2610.1999511719, 55.5, 359.98425292969},
[68]={-259.89999389648, 2605.8999023438, 62.5, 179.98352050781},
[69]={-1212.0999755859, 1833.5, 41.599998474121, 45.983520507813},
[70]={-856.29998779297, 1529, 22.200000762939, 89.983276367188},
[71]={-306.39999389648, 1054, 19.39999961853, 181.97805786133},
[72]={178.60000610352, 1173.1999511719, 14.39999961853, 323.9775390625},
[73]={-95.300003051758, 1110.6999511719, 19.39999961853, 359.97583007813},
[74]={776.8994140625, 1869.599609375, 4.5, 89.972534179688},
[75]={ -1943.1109082031, 2385.9528808594, 49.3753125, 112.00},
[76]={2090.0832519531, -2409.0424804688, 13.256875, 270.60},
[77]={2281.1843261719, -2367.7922363281, 13.146875, 400.60}
}

labels = {}
buttons = {}
edits = {}


BankingPanel = {
    tab = {},
    staticimage = {},
    tabpanel = {},
    edit = {},
    gridlist = {},
    window = {},
    label = {},
    button = {}
}


BankingPIN = {
    button = {},
    window = {},
    edit = {},
    label = {}
}

function createWindow ()

BankingPanel.window[1] = guiCreateWindow(61, 90, 679, 420, "AUR ~ Banking", false)
guiSetAlpha(BankingPanel.window[1], 0.96)

BankingPanel.button[1] = guiCreateButton(509, 27, 155, 27, "Close", false, BankingPanel.window[1])
guiSetProperty(BankingPanel.button[1], "NormalTextColour", "FFAAAAAA")
BankingPanel.tabpanel[1] = guiCreateTabPanel(10, 48, 654, 356, false, BankingPanel.window[1])

BankingPanel.tab[1] = guiCreateTab("Transactions information", BankingPanel.tabpanel[1])

BankingPanel.label[1] = guiCreateLabel(19, 10, 125, 24, "Your transactions log", false, BankingPanel.tab[1])
guiSetFont(BankingPanel.label[1], "default-bold-small")
BankingPanel.gridlist[1] = guiCreateGridList(16, 39, 623, 283, false, BankingPanel.tab[1])
guiGridListAddColumn(BankingPanel.gridlist[1], "Transaction", 0.6)
guiGridListAddColumn(BankingPanel.gridlist[1], "Date", 0.3)

BankingPanel.tab[2] = guiCreateTab("Transactions", BankingPanel.tabpanel[1])

BankingPanel.label[2] = guiCreateLabel(22, 16, 232, 25, "Current balance:", false, BankingPanel.tab[2])
guiSetFont(BankingPanel.label[2], "default-bold-small")
BankingPanel.edit[1] = guiCreateEdit(22, 84, 232, 26, "", false, BankingPanel.tab[2])
BankingPanel.label[3] = guiCreateLabel(8, 120, 411, 15, "--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, BankingPanel.tab[2])
BankingPanel.label[4] = guiCreateLabel(22, 51, 232, 25, "$ 0", false, BankingPanel.tab[2])
guiSetFont(BankingPanel.label[4], "default-bold-small")
guiLabelSetColor(BankingPanel.label[4], 43, 244, 10)
BankingPanel.button[2] = guiCreateButton(264, 84, 155, 27, "Deposit", false, BankingPanel.tab[2])
guiSetProperty(BankingPanel.button[2], "NormalTextColour", "FFAAAAAA")
BankingPanel.button[3] = guiCreateButton(264, 14, 155, 27, "Withdraw", false, BankingPanel.tab[2])
guiSetProperty(BankingPanel.button[3], "NormalTextColour", "FFAAAAAA")
BankingPanel.label[8] = guiCreateLabel(433, 14, 15, 313,"|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, BankingPanel.tab[2])
BankingPanel.staticimage[1] = guiCreateStaticImage(479, 14, 147, 116, "bankMoney.png", false, BankingPanel.tab[2])
BankingPanel.label[9] = guiCreateLabel(479, 145, 147, 85, "If you want more money to your account, don't hesitate to purchase at shop.aurorarvg.com", false, BankingPanel.tab[2])
guiSetFont(BankingPanel.label[9], "default-bold-small")
guiLabelSetHorizontalAlign(BankingPanel.label[9], "center", true)
guiLabelSetHorizontalAlign(BankingPanel.label[2], "center", true)
guiLabelSetHorizontalAlign(BankingPanel.label[4], "center", true)



guiLabelSetHorizontalAlign(BankingPanel.label[8], "center", true)

BankingPanel.tab[3] = guiCreateTab("Options", BankingPanel.tabpanel[1])

BankingPanel.label[10] = guiCreateLabel(139, 135, 328, 21, "To be secured add PIN code", false, BankingPanel.tab[3])
BankingPanel.label[11] = guiCreateLabel(139, 155, 328, 21, "Your Pin code : ", false, BankingPanel.tab[3])
guiSetFont(BankingPanel.label[10], "default-bold-small")
guiSetFont(BankingPanel.label[11], "default-bold-small")
guiLabelSetColor(BankingPanel.label[10], 243, 169, 10)
guiLabelSetColor(BankingPanel.label[11], 243, 169, 10)
guiLabelSetHorizontalAlign(BankingPanel.label[10], "center", true)
guiLabelSetHorizontalAlign(BankingPanel.label[11], "center", true)
BankingPanel.edit[4] = guiCreateEdit(207, 236, 200, 27, "", false, BankingPanel.tab[3])
BankingPanel.button[6] = guiCreateButton(209, 283, 198, 25, "Set PIN", false, BankingPanel.tab[3])
guiSetProperty(BankingPanel.button[6], "NormalTextColour", "FFAAAAAA")


BankingPIN.window[1] = guiCreateWindow(225, 220, 350, 180, "AUR ~ Password Required", false)
guiSetAlpha(BankingPIN.window[1], 0.94)
BankingPIN.label[1] = guiCreateLabel(50, 29, 278, 20, "This account is secured with PIN code (Default:0)", false, BankingPIN.window[1])
guiSetFont(BankingPIN.label[1], "default-bold-small")
guiLabelSetColor(BankingPIN.label[1], 254, 155, 0)
BankingPIN.edit[1] = guiCreateEdit(50, 54, 258, 36, "0", false, BankingPIN.window[1])
BankingPIN.button[1] = guiCreateButton(50, 104, 122, 36, "Enter", false, BankingPIN.window[1])
guiSetProperty(BankingPIN.button[1], "NormalTextColour", "FFAAAAAA")
BankingPIN.button[2] = guiCreateButton(178, 104, 130, 36, "Cancel", false, BankingPIN.window[1])
BankingPIN.button[3] = guiCreateButton(50, 144, 260, 20, "Hack", false, BankingPIN.window[1])
guiSetProperty(BankingPIN.button[2], "NormalTextColour", "FFAAAAAA")
guiSetProperty(BankingPIN.button[3], "NormalTextColour", "FFAAAAAA")
BankingPIN.label[2] = guiCreateLabel(87, 149, 171, 21, "", false, BankingPIN.window[1])
guiLabelSetHorizontalAlign(BankingPIN.label[1], "center", true)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(BankingPanel.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(BankingPanel.window[1],x,y,false)

guiWindowSetMovable (BankingPanel.window[1], true)
guiWindowSetSizable (BankingPanel.window[1], false)
guiSetVisible (BankingPanel.window[1], false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(BankingPIN.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(BankingPIN.window[1],x,y,false)

guiWindowSetMovable (BankingPIN.window[1], false)
guiWindowSetSizable (BankingPIN.window[1], false)
guiSetVisible (BankingPIN.window[1], false)

addEventHandler ( "onClientGUIChanged", BankingPanel.edit[1], removeLetters2, false )
--addEventHandler ( "onClientGUIChanged", BankingPanel.edit[3], removeLetters2, false )
addEventHandler ( "onClientGUIChanged", BankingPanel.edit[4], removeLetters2, false )
addEventHandler ( "onClientGUIChanged", BankingPIN.edit[1], removeLetters2, false )
addEventHandler ( "onClientGUIClick", BankingPIN.button[1], enterPIN,false)
addEventHandler ( "onClientGUIClick", BankingPIN.button[2],function() guiSetVisible(BankingPIN.window[1], false) setElementData(localPlayer,"isATMOpened",false) showCursor(false,false) end, false) --
addEventHandler ( "onClientGUIClick", BankingPIN.button[3],function() 
	triggerServerEvent("AURcheckhack.server", localPlayer)	
end, false) --
addEventHandler ( "onClientGUIClick", BankingPanel.button[1], function() guiSetVisible(BankingPanel.window[1], false) setElementData(localPlayer,"isATMOpened",false) showCursor(false,false) guiGridListClear(BankingPanel.gridlist[1]) setElementData(localPlayer,"doesPedIntoATM",false) end, false)
addEventHandler ( "onClientGUIClick", BankingPanel.button[3], withdrawMoney, false )
addEventHandler ( "onClientGUIClick", BankingPanel.button[2], depositMoney, false )
---addEventHandler ( "onClientGUIClick", BankingPanel.button[4], sendPlayerMoney, false )
addEventHandler ( "onClientGUIClick", BankingPanel.button[6], setPINcode, false )
end

addEvent("AURcheckhack", true)
addEventHandler("AURcheckhack", root,
	function()
		if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
			guiSetVisible(BankingPIN.window[1], false) 
			openGUI() 
		else 
			exports.NGCdxmsg:createNewDxMessage("You must be a criminal to rob this ATM.",255,0,0)
		end
	end 
)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		createWindow()
	end
)

function setPINcode()
	local pass = guiGetText(BankingPanel.edit[4])
	if ( string.match(pass,'^%d+$') ) then
		if tonumber(pass) >= 1000 and tonumber(pass) <= 9999 then
			if ( string.len( tostring( pass ) ) ) <= 4 then
				triggerServerEvent("updateATMPIN",localPlayer,pass)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Please insert valid PIN (4 digits)",255,0,0)
		end
	end
end

function enterPIN()
	local pass = guiGetText(BankingPIN.edit[1])
	triggerServerEvent("checkPINcode",localPlayer,pass)
end
--- for password
function removeLetters2(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end

addEvent ("insertTransactions", true)
function insertTransactions (datum, transaction)
	local row = guiGridListAddRow( BankingPanel.gridlist[1] )
	guiGridListSetItemText( BankingPanel.gridlist[1], row, 2, datum, false, false )
	guiGridListSetItemText( BankingPanel.gridlist[1], row, 1, transaction, false, false )
end
addEventHandler ("insertTransactions", root, insertTransactions)

addEvent ("showBankingGui", true)
function showBankingGui (balance,myPin)
	local vehicle = getPedOccupiedVehicle (localPlayer)
	local creditcard = getElementData( localPlayer, "creditcard" )
    if not ( vehicle ) then
		guiSetVisible(BankingPanel.window[1],true)
		showCursor(true,true)
		guiSetText(BankingPanel.label[4], "$ "..balance)
		guiSetText(BankingPanel.label[11], "Your Pin Code: "..myPin)
		guiSetInputMode("no_binds_when_editing")
		setElementData(localPlayer,"doesPedIntoATM",true)
	end
	guiGridListClear(BankingPanel.gridlist[1])
	triggerServerEvent("requestTransactions", localPlayer)
end
addEventHandler ("showBankingGui", root, showBankingGui)

addEvent ("updateBalanceLabel", true)
function updateBalanceLabel (newBalance)
	local convertedBalance = exports.server:convertNumber( tonumber(newBalance) )
	guiSetText(BankingPanel.label[4], "$ "..convertedBalance)
	playerBalance = newBalance
end
addEventHandler ("updateBalanceLabel", root, updateBalanceLabel)

addEvent("HideBankingGui",true)
addEventHandler("HideBankingGui",localPlayer,function()
	setElementData(localPlayer,"isATMOpened",false)
	guiSetVisible(BankingPanel.window[1],false)
	showCursor(false)
end)

addEvent("updatePIN",true)
addEventHandler("updatePIN",localPlayer,function(pin)
	guiSetText(BankingPanel.label[11],"Your pin: "..pin)
end)

function openATMPin()
	guiSetVisible (BankingPIN.window[1], true)
	setElementData(localPlayer,"isATMOpened",true)
	showCursor(true)
	exports.NGCdxmsg:createNewDxMessage("This account protected with PIN code, please enter the pin code",255,255,0)
end
addEvent("openATMPIN",true)
addEventHandler("openATMPIN",localPlayer,openATMPin)

addEvent("hideATMPIN",true)
addEventHandler("hideATMPIN",localPlayer,function()
	guiSetVisible (BankingPIN.window[1], false)
	showCursor(false)
	setElementData(localPlayer,"doesPedIntoATM",false)
end)
--[[
setTimer(function()
	if guiGetVisible(BankingPanel.window[1]) then
		if getElementData(localPlayer,"Loader") or getElementData(localPlayer,"isPlayerModer") then
			guiSetVisible (BankingPanel.window[1], false)
			showCursor(false)
		end
	end
end,5000,0)]]

function sendPlayerMoney ()
	if not ( onSpamProtection () ) then
		exports.NGCdxmsg:createNewDxMessage("To prevent spamming the bank system, you can't transfer money for 30 seconds.", 200, 0, 0)
		guiSetText ( BankingPanel.edit[2], "Username or Nickname if online" ) guiSetText ( BankingPanel.edit[3], "Money to Transfer" )
	elseif string.match(guiGetText(BankingPanel.edit[3]),'^%d+$') then
		if  string.len( tostring( guiGetText(BankingPanel.edit[3] ) ) ) > 8 then
			exports.NGCdxmsg:createNewDxMessage("You can't spam these useless numbers",255,0,0)
			return false
		end
		local reciever = guiGetText (BankingPanel.edit[2])
		local money = guiGetText ( BankingPanel.edit[3] )
		if tonumber(money) < 1 then
			exports.NGCdxmsg:createNewDxMessage("The minimum transfer amount is $1",200,0,0)
			guiSetText ( BankingPanel.edit[2], "Username or Nickname if online" ) guiSetText ( BankingPanel.edit[3], "Money to Transfer" )
		return
		end
		if reciever == "" then
			exports.NGCdxmsg:createNewDxMessage("Enter the account you want to send money to.",200,0,0)
			guiSetText ( BankingPanel.edit[2], "Username or Nickname if online" ) guiSetText ( BankingPanel.edit[3], "Money to Transfer" )
		elseif reciever == exports.server:getPlayerAccountName(localPlayer) then
			exports.NGCdxmsg:createNewDxMessage("Why do you want to send money to yourself?...", 200,0,0)
			guiSetText ( BankingPanel.edit[2], "Username or Nickname if online" ) guiSetText ( BankingPanel.edit[3], "Money to Transfer" )
		elseif tonumber(money) > tonumber(playerBalance) or tonumber(playerBalance) == 0 then
			exports.NGCdxmsg:createNewDxMessage("You dont have enough money on your bank account!", 200,0,0)
			guiSetText ( BankingPanel.edit[2], "Username or Nickname if online" ) guiSetText ( BankingPanel.edit[3], "Money to Transfer" )
		else
			local localPlayerMoney = playerBalance
			local recieverElement=false
			recieverElement = exports.server:getPlayerFromAccountname(reciever)
			if isElement(recieverElement) then else recieverElement = exports.server:getPlayerFromNamePart(reciever) end
			triggerServerEvent("sendViaATM", localPlayer, localPlayer,reciever, money, localPlayerMoney, recieverElement)
			guiSetText ( BankingPanel.edit[2], "Username or Nickname if online" ) guiSetText ( BankingPanel.edit[3], "Money to Transfer" )
		end
	else
		exports.NGCdxmsg:createNewDxMessage("Bad money input! Please enter only valid numbers",200,0,0)
	end
end

function withdrawMoney ()
	if not ( onSpamProtection () ) then
		exports.NGCdxmsg:createNewDxMessage("To prevent spamming the bank system, you can't transfer money for 30 seconds.", 200, 0, 0)
		guiSetText ( BankingPanel.edit[1], "" )
	elseif string.match(guiGetText(BankingPanel.edit[1]),'^%d+$') then
		if  string.len( tostring( guiGetText(BankingPanel.edit[1] ) ) ) > 8 then
			exports.NGCdxmsg:createNewDxMessage("You can't spam these useless numbers",255,0,0)
			return false
		end
		local value = guiGetText ( BankingPanel.edit[1] )
		if tonumber(value) > tonumber(playerBalance) or tonumber(playerBalance) == 0 then
			exports.NGCdxmsg:createNewDxMessage("You dont have enough money on your bank account!", 200,0,0)
		else
			triggerServerEvent("withdrawMoney", localPlayer, value)
			guiSetText ( BankingPanel.edit[1], "" )
		end
	end
end

function depositMoney ()
	if not ( onSpamProtection () ) then
		exports.NGCdxmsg:createNewDxMessage("To prevent spamming the bank system, you can't transfer money for 30 seconds.", 200, 0, 0)
		guiSetText ( BankingPanel.edit[1], "" )
	elseif string.match(guiGetText(BankingPanel.edit[1]),'^%d+$') then
		if string.len( tostring( guiGetText(BankingPanel.edit[1] ) ) ) > 8 then
			exports.NGCdxmsg:createNewDxMessage("You can't spam these useless numbers",255,0,0)
			return false
		end
		local value = guiGetText ( BankingPanel.edit[1] )
		local playerMoney = getPlayerMoney ( localPlayer )
		if tonumber(value) > tonumber(playerMoney) or playerMoney == 0 then
			exports.NGCdxmsg:createNewDxMessage("You can't deposit this much money, because you dont have it!", 200,0,0)
		elseif tonumber(guiGetText ( BankingPanel.edit[1] )) < 749 then
			exports.NGCdxmsg:createNewDxMessage("The minimum deposit is $750!", 200,0,0)
			guiSetText ( BankingPanel.edit[1], "" )
		else
			triggerServerEvent("depositMoney", localPlayer, value)
			guiSetText ( BankingPanel.edit[1], "" )
		end
	end
end

local theSpam = {}

function onSpamProtection ()
	if not ( theSpam[localPlayer] ) then
		theSpam[localPlayer] = 1
		return true
	elseif ( theSpam[localPlayer] >= 4 ) then
		return false
	else
		theSpam[localPlayer] = theSpam[localPlayer] +1
		if ( theSpam[localPlayer] >= 4 ) and not ( isTimer( clearTimer ) ) then clearTimer = setTimer( clearSpamProtection, 40000, 1 ) end
		return true
	end
end

function clearSpamProtection ()
	if ( theSpam[localPlayer] ) then
		theSpam[localPlayer] = 0
	end
end

function bankMarkerHit( hitElement, matchingDimension )
	if (isPlayerNearAtmFromAir()) then
		if not isPedInVehicle(hitElement) then
			triggerServerEvent("checkMyAccount", hitElement)
		end
	end
end

for ID in pairs(bankingMarkers) do
	local x, y, z = bankingMarkers[ID][1], bankingMarkers[ID][2], bankingMarkers[ID][3]
	local rotation = bankingMarkers[ID][4]

	local bankMarker = createMarker(x,y,z -1,"cylinder",1,0, 104, 0 ,170)
	--outputDebugString(getZoneName(x,y,z))
	local createATM = createObject ( 2942, x, y, z, 0, 0, rotation )
	setObjectBreakable( createATM, false )
	setElementFrozen( createATM, true )

	addEventHandler("onClientMarkerHit", bankMarker, bankMarkerHit)
end

function isPlayerNearAtmFromAir ()
	local x, y, z = getElementPosition( localPlayer )
	for ID in pairs(bankingMarkers) do
		if ( getDistanceBetweenPoints3D ( x, y,z, bankingMarkers[ID][1], bankingMarkers[ID][2], bankingMarkers[ID][3] ) < 2 ) then
			return true
		end
	end
	return false
end

function isPlayerNearATM ()
	local x, y, z = getElementPosition( localPlayer )
	for ID in pairs(bankingMarkers) do
		if ( getDistanceBetweenPoints2D ( x, y, bankingMarkers[ID][1], bankingMarkers[ID][2] ) < 1 ) then
			return true
		end
	end
	return false
end

addEvent("hackingATM",true)
addEventHandler("hackingATM",localPlayer,function()
	triggerServerEvent( "onPlayerHackedATM", localPlayer)
	showCursor(false)
end)

function onPlayerHackATM ()
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
		exports.CSGprogressbar:createProgressBar( "Adding Virus..", 500, "hackingATM" )
		guiSetVisible (BankingPanel.window[1], false)
	else
		exports.NGCdxmsg:createNewDxMessage("You can't hack this ATM , please take criminal job first",255,0,0)
	end
end

local blips = {}

function hudswitch(t)
	if t == true then
		for k,v in ipairs(blips) do
			if v then
				table.remove(blips,k)
				exports.customblips:destroyCustomBlip(v)
			end
		end
		blips = {}
		for ID in ipairs(bankingMarkers) do
			local x3, y3, z3 = getElementPosition( localPlayer )
			local x2, y2, z2 = bankingMarkers[ID][1], bankingMarkers[ID][2], bankingMarkers[ID][3]
			if ( getDistanceBetweenPoints2D ( x3, y3, bankingMarkers[ID][1], bankingMarkers[ID][2] ) < 200 ) then
				bp = exports.customblips:createCustomBlip(bankingMarkers[ID][1], bankingMarkers[ID][2],14,14,"blip.png",200)
				exports.customblips:setCustomBlipRadarScale(bp,0.8)
				table.insert(blips,bp)
			end
		end
	else
		for k,v in ipairs(blips) do
			if v then
				table.remove(blips,k)
				exports.customblips:destroyCustomBlip(v)
			end
		end
		blips = {}
	end
end


addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, hudstate )
		if setting == "ATM" then
			hudswitch( hudstate )
		end
	end
)


function checkSettinghud()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "ATM" )
		hudswitch( setting )
	else
		setTimer( checkSettinghud,10000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettinghud )
setTimer( checkSettinghud,10000, 0 )


