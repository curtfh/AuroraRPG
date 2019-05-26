local a="all"
local m="men"
local f="female"
local page = "c"
local msg = ""
local missionTimer = {}
local sellingTimer = {}
local MainTable = { }
local sold = false
local mission = false
local item = ""
local progress = false
local rx, ry = guiGetScreenSize()
local nX, nY = 1366, 768
local sX, sY = guiGetScreenSize()
local count = 3*6000
local blip = exports.customblips:createCustomBlip ( -2242.83,145.71, 20, 20, "radar_tshirt.png", 100 )
exports.customblips:setCustomBlipRadarScale(blip,1.1)

local global = {
	{1,a,"images/Winter-Boots.png","Winter Boot",100},
	{2,a,"images/Watch.png","Watch",120},
	{3,a,"images/Umbrella.png","Umbrella",80},
	{4,a,"images/T-Shirt.png","T-Shirt",300},
	{5,a,"images/Trousers.png","Trousers",400},
	{6,a,"images/Sun-Glasses.png","Sun Glasses",150},
	{7,a,"images/Glasses.png","Glasses",350},
	{8,a,"images/Socks.png","Socks",50},
	{9,a,"images/Shoe-Brush.png","Shoe-Brush",50},
	{10,a,"images/Shirt.png","Shirt",300},
	{11,a,"images/Scarf.png","Scarf",150},
	{12,a,"images/Pilot-hat.png","Pilot hat",250},
	{13,a,"images/Necklace.png","Necklace",500},
	{14,a,"images/Motorbike-Helmet.png","Bike helmet",600},
	{15,a,"images/Jumper.png","Sport Shirt",900},
	{16,a,"images/Jacket.png","Jacket",1500},
	{17,a,"images/Helmet.png","Helmet",200},
	{18,a,"images/Hanger.png","Hanger",200},
	{19,a,"images/Shorts.png","Short",300},
	{20,a,"images/Coat.png","Coat",1600},
	{21,a,"images/Chef-Hat.png","Chef hat",100},
	{22,a,"images/Boots.png","Black Boot",130},
	{23,a,"images/Baseball-cap.png","Cap",100},
}

local men = {
	{1,m,"images/Trainers.png","Sport Boot",120},
	{2,m,"images/Tie.png","Tie",25},
	{3,m,"images/mShoe.png","Men Shoe",260},
	{4,m,"images/Men-Underwear.png","Underwear",100},
	{5,m,"images/Wizard.png","Wizard hat",200},
	{6,m,"images/Bowler-Hat.png","Bowler Hat",200},
	{7,m,"images/Beanie.png","Theif Hat",100},
	{8,m,"images/Kimono.png","Kung Fu suit",1000},
	{9,m,"images/Fireman-Coat.png","Fireman Coat",2000},
	{10,m,"images/Fireman-Boots.png","Fireman Boot",500},
	{11,m,"images/Bulletproof-Vest.png","Armor Vest",3000},

}

local female = {
	{1,f,"images/wShoe.png","Women Shoe",170},
	{2,f,"images/Women-Underwear.png","Underwear",300},
	{3,f,"images/Witch.png","Witch Hat",200},
	{4,f,"images/Wedding-Dress.png","Dress",1500},
	{5,f,"images/Skirt.png","Skirt",1000},
	{6,f,"images/Romper.png","Romper",800},
	{7,f,"images/Bracelet.png","Bracelet1",300},
	{8,f,"images/Bra.png","Bra",700},
	{9,f,"images/Bow-Tie.png","Bow-Tie",100},
	{10,f,"images/Fan.png","Fan",100},
	{11,f,"images/Christmas-Mitten.png","Gloves",200},
}


local greeting = {
	"Hello",
	"Greeting",
	"Hi",
	"Wow nice store, Hi..",
}

local asking = {
	"I'm looking for",
	"I was wondering do you have",
	"I wanna buy",
	"Please Gimme",
}

local waste = {
	"You wasted my time!",
	"Good bye",
	"I don't want it anymore :|",
}

local skins = {
	[1]= 190,
	[2]= 192,
	[3]= 193,
	[4]= 194,
	[5]= 195,
	[6]= 302,
	[7]= 303,
	[8]= 269,
	[9]= 305,
	[10]= 306,

}


Store = {
    tab = {},
    scrollpane = {},
    tabpanel = {},
    label = {},
    button = {},
    window = {},
    staticimage = {}
}

GlobalStore = {
    label = {},
    staticimage = {}
}

MenStore = {
    label = {},
    staticimage = {}
}

FemaleStore = {
    label = {},
    staticimage = {}
}

local access = false
local col = createColCircle(207.04,-127.81,2)
local col2 = createColCircle(207.04,-127.81,2)
local marker = createMarker(206.98602294922,-127.30908203125,1001,"cylinder",1,255,255,0,100)
setElementInterior(marker,3)
setElementInterior(col,3)
setElementInterior(col2,3)


addEventHandler("onClientResourceStart",resourceRoot,function()
	Store.window[1] = guiCreateWindow(40,50, 706, 506, "Clothes Store", false)
	centerWindows(Store.window[1])
	guiWindowSetSizable(Store.window[1], false)
	guiSetVisible(Store.window[1],false)
	guiSetAlpha(Store.window[1], 1.00)
	Store.tabpanel[1] = guiCreateTabPanel(10, 26, 683, 405, false, Store.window[1])
	Store.tab[1] = guiCreateTab("General", Store.tabpanel[1])
	Store.scrollpane[1] = guiCreateScrollPane(7, 8, 666, 362, false, Store.tab[1])
	Store.tab[2] = guiCreateTab("Men Clothes", Store.tabpanel[1])
	Store.scrollpane[2] = guiCreateScrollPane(7, 8, 666, 362, false, Store.tab[2])
	Store.tab[3] = guiCreateTab("Women Clothes", Store.tabpanel[1])
	Store.scrollpane[3] = guiCreateScrollPane(7, 8, 666, 362, false, Store.tab[3])
	Store.button[1] = guiCreateButton(20, 460, 124, 28, "Close", false, Store.window[1])
	Store.button[2] = guiCreateButton(569, 459, 124, 28, "Open Store", false, Store.window[1])
end)


function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end


function BuyItem()
	if getElementData(source,"data") then
		if progress == true then
			local element,id,name = unpack(getElementData(source,"data"))
			if item == name then
				sold = true
				exports.NGCdxmsg:createNewDxMessage("You have sold "..name.." nice work :)",0,255,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("There is no customer wants to buy anything !",255,0,0)
		end
	end
	if source == Store.button[2] then
		createMission()
	end
	if source == Store.button[1] then
		guiSetVisible(Store.window[1],false)
		showCursor(false)
		removePanel()
		toggleAllControls(true,true,true)
		--setElementPosition(localPlayer,204.47,-131.15,1003.5)
		--setPedRotation(localPlayer,181)
		page = "c"
	end
	if source == Store.tabpanel[1] then
		if (guiGetSelectedTab(Store.tabpanel[1])==Store.tab[1]) then
			createGlobal("a")
		elseif (guiGetSelectedTab(Store.tabpanel[1])==Store.tab[2]) then
			createGlobal("m")
		elseif (guiGetSelectedTab(Store.tabpanel[1])==Store.tab[3]) then
			createGlobal("f")
		end
	end
end
addEventHandler("onClientGUIClick",resourceRoot,BuyItem)
addEventHandler("onClientMouseEnter",root,function()
	if getElementData(source,"data") then
		guiSetAlpha(source,0.5)
	end
end)

addEventHandler("onClientMouseLeave",root,function()
	if getElementData(source,"data") then
		guiSetAlpha(source,1)
	end
end)

function openPanel()
	if access == true then
		guiSetVisible(Store.window[1],true)
		showCursor(true)
		guiSetSelectedTab(Store.tabpanel[1],Store.tab[1])
		createGlobal("a")
	end
end

function createGlobal(p)
	if p == "a" then
		if page == p then return false end
		page = p
		removePanel()
		for k,v in ipairs(global) do
			iter = v[1]
			local x,y = -25,14
			if iter > 0 and iter <= 8 then
				x = x+(iter*83)
				y = 14
			elseif iter > 8 and iter <= 16 then
				x = x-670+(iter*83)
				y = y+(2*55)
			elseif iter > 16 and iter <= 24 then
				x = x-1330+(iter*83)
				y = y+(2*105)
			else
				return
			end
			GlobalStore.staticimage[iter] = guiCreateStaticImage(x+8,y, 52, 42, v[3], false, Store.scrollpane[1])
			GlobalStore.label[iter] = guiCreateLabel(x,y+50, 75, 35, v[4].."\n$"..v[5], false, Store.scrollpane[1])
			guiSetFont(GlobalStore.label[iter], "default-bold-small")
			guiLabelSetHorizontalAlign(GlobalStore.label[iter], "center", false)
			setElementData(GlobalStore.staticimage[iter],"data",{GlobalStore.staticimage[iter],v[1],v[4]})
		end
	elseif p == "m" then
		if page == p then return false end
		removePanel()
		page = p
		for k,v in ipairs(men) do
			iter = v[1]
			local x,y = -25,14
			if iter > 0 and iter <= 8 then
				x = x+(iter*83)
				y = 14
			elseif iter > 8 and iter <= 16 then
				x = x-670+(iter*83)
				y = y+(2*55)
			elseif iter > 16 and iter <= 24 then
				x = x-1330+(iter*83)
				y = y+(2*105)
			else
				return
			end
			MenStore.staticimage[iter] = guiCreateStaticImage(x+8,y, 52, 42, v[3], false, Store.scrollpane[2])
			MenStore.label[iter] = guiCreateLabel(x,y+50, 75, 35, v[4].."\n$"..v[5], false, Store.scrollpane[2])
			guiSetFont(MenStore.label[iter], "default-bold-small")
			guiLabelSetHorizontalAlign(MenStore.label[iter], "center", false)
			setElementData(MenStore.staticimage[iter],"data",{MenStore.staticimage[iter],v[1],v[4]})
		end
	elseif p == "f" then
		if page == p then return false end
		removePanel()
		page = p
		for k,v in ipairs(female) do
			iter = v[1]
			local x,y = -25,14
			if iter > 0 and iter <= 8 then
				x = x+(iter*83)
				y = 14
			elseif iter > 8 and iter <= 16 then
				x = x-670+(iter*83)
				y = y+(2*55)
			elseif iter > 16 and iter <= 24 then
				x = x-1330+(iter*83)
				y = y+(2*105)
			else
				return
			end
			FemaleStore.staticimage[iter] = guiCreateStaticImage(x+8,y, 52, 42, v[3], false, Store.scrollpane[3])
			FemaleStore.label[iter] = guiCreateLabel(x,y+50, 75, 35, v[4].."\n$"..v[5], false, Store.scrollpane[3])
			guiSetFont(FemaleStore.label[iter], "default-bold-small")
			guiLabelSetHorizontalAlign(FemaleStore.label[iter], "center", false)
			setElementData(FemaleStore.staticimage[iter],"data",{FemaleStore.staticimage[iter],v[1],v[4]})
		end
	end
end

function removePanel()
	for i=1,23 do
		if isElement(GlobalStore.staticimage[i]) then
			destroyElement(GlobalStore.staticimage[i])
		end
		if isElement(GlobalStore.label[i]) then
			destroyElement(GlobalStore.label[i])
		end
	end
	for i=1,11 do
		if isElement(MenStore.staticimage[i]) then
			destroyElement(MenStore.staticimage[i])
		end
		if isElement(MenStore.label[i]) then
			destroyElement(MenStore.label[i])
		end
	end
	for i=1,11 do
		if isElement(FemaleStore.staticimage[i]) then
			destroyElement(FemaleStore.staticimage[i])
		end
		if isElement(FemaleStore.label[i]) then
			destroyElement(FemaleStore.label[i])
		end
	end
end




function isElementWithinCol( element )
	if ( not isElement( element ) ) then access = false return false end
	if getElementInterior( element ) ~= 3 then access = false return false end
	if isElementWithinColShape( element, col ) then
		return true
	end
	return false
end

addEventHandler("onClientColShapeHit",col2,function(h,d)
	if not d then return false end
	if h and getElementType(h) == "player" then
		if not isPedInVehicle(h) then
			if h == localPlayer then
				if getElementData(h,"Occupation") == "Clothes Seller" and getTeamName(getPlayerTeam(h)) == "Civilian Workers" then
					exports.NGCdxmsg:createNewDxMessage("Press Space bar to open your store inventory",255,255,0)
					access = true
				end
			end
		end
	end
end)

addEventHandler("onClientColShapeHit",col,function(h,d)
	if not d then return false end
	if h and getElementType(h) == "player" then
		if not isPedInVehicle(h) then
			if h == localPlayer then
				--toggleAllControls(false,true,true)
				--setElementPosition(h,207.09,-127.78,1003.5)
				--setPedRotation(h,181)
				if getElementData(h,"Occupation") == "Clothes Seller" and getTeamName(getPlayerTeam(h)) == "Civilian Workers" then
					exports.NGCdxmsg:createNewDxMessage("Press Space bar to open your store inventory",255,255,0)
					access = true
				end
			end
		end
	elseif getElementType(h) == "ped" then
		-- here start mission
		if progress == true then return false end
		progress = true
		MainTable = nil
		local ask = math.random(#asking)
		local msg = asking[ask]
		local g = getElementModel(h)
		if g == 190 or g == 192 or g == 193 or g == 194 or g == 195 then
			local co = math.random(0,1)
			if co == 0 then
				local sd = math.random(#global)
				item = global[sd][4]
				myMoney = global[sd][5]
			else
				local sd = math.random(#female)
				item = female[sd][4]
				myMoney = female[sd][5]
			end
		elseif g == 302 or g == 303 or g == 269 or g == 305 or g == 306 then
			local co = math.random(0,1)
			if co == 0 then
				local sd = math.random(#global)
				item = global[sd][4]
				myMoney = global[sd][5]
			else
				local sd = math.random(#men)
				item = men[sd][4]
				myMoney = men[sd][5]
			end
		end
		MainTable = { h, msg.." "..item }
		exports.NGCdxmsg:createNewDxMessage("Store customer : "..msg.." "..item,255,255,0)
		sellingTimer = setTimer(function(ped)
			if sold == true then
				MainTable = nil
				MainTable = { ped, "Thank you very much :)" }
				triggerServerEvent("setPedTask",localPlayer)
				sold = false
				item = ""
				progress = false
				mission = false
				triggerServerEvent("payPedTask",localPlayer,myMoney)
				createGame()
			else
				MainTable = nil
				addWasteMsg(ped)
				triggerServerEvent("setPedTask",localPlayer)
				item = ""
				sold = false
				progress = false
				mission = false
				createGame()
			end
		end,15000,1,h)
	end
end)

function addWasteMsg(p)
	local ask = math.random(#waste)
	local msg = waste[ask]
	MainTable  = { p, msg }
	setTimer(function()
		MainTable = nil
	end,5000,1)
end


addEventHandler("onClientColShapeLeave",col,function(h)
	if h and getElementType(h) == "player" then
		if h ~= localPlayer then return false end
		if getElementDimension(source) ~= getElementDimension(h) then
			triggerServerEvent("leaveStoreInterior",localPlayer)
			return false
		end
		if not isPedInVehicle(h) then
			endJob()
		end
	end
end)

function onCalculateBanktime(theTime)
	if (theTime >= 60000) then
		local plural = ""
		if (math.floor((theTime/1000)/60) >= 2) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if (math.floor((theTime/1000)) >= 2) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end

local afkKeys = { "mouse1", "mouse2", "mouse3", "mouse4", "mouse5", "mouse_wheel_up", "mouse_wheel_down", "arrow_l", "arrow_u",
 "arrow_r", "arrow_d", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
 "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "num_0", "num_1", "num_2", "num_3", "num_4", "num_5",
 "num_6", "num_7", "num_8", "num_9", "num_mul", "num_add", "num_sep", "num_sub", "num_div", "num_dec", "F1", "F2", "F3", "F4", "F5",
 "F6", "F7", "F8", "F9", "F10", "F11", "F12", "backspace", "tab", "lalt", "ralt", "enter", "space", "pgup", "pgdn", "end", "home",
 "insert", "delete", "lshift", "rshift", "lctrl", "rctrl", "[", "]", "pause", "capslock", "scroll", ";", ",", "-", ".", "/", "#", "\\", "="}
local afkTime = getTickCount()
local client = getLocalPlayer()
local minutes = 4
local afk = false

function resetAFkTime()
	afkTime = getTickCount()
	afk = false
end
for k, v in ipairs(afkKeys) do bindKey(v,"both",resetAFkTime) end

setTimer(
function ()
	if getTickCount()-afkTime > minutes*60000 then
		afk = true
	else
		afk = false
	end
end,minutes*60000,0)

addEventHandler("onClientRender",root,function()
	if isElementWithinCol(localPlayer) then
		if getElementData(localPlayer,"Occupation") == "Clothes Seller" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
			access = true
			if (isTimer(sellingTimer)) then
				a, b, c = getTimerDetails(sellingTimer)
				timeLeftt = a/1000
				timeLeft = math.floor(timeLeftt)
				dxDrawText( "Time Until Customer Leave:"..onCalculateBanktime(math.floor(a)), ( 695 / nX ) * sX, ( 680 / nY ) * sY, ( 647 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 255, 255, 255, 255 ), 1.5, "default-bold", "center", "center",true,true,true,true )
			end
		end
	else
		access = false
		count = 3*6000
		if progress == true then
			endJob()
		end
	end
	if isElementWithinCol(localPlayer) then
		if getElementData(localPlayer,"Occupation") == "Clothes Seller" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
			if afk == false then
				if count > 0 then
					count = count - 1
					dxDrawText( "Worker Payment: "..math.floor((count)/60).." sec|5 minutes", ( 1195 / nX ) * sX, ( 680 / nY ) * sY, ( 947 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 0, 205, 0, 255 ), 1, "default-bold", "center", "center",true,true,true,true )
				end
				if count == 0 then
					local mon = math.random(3000,6000)
					dxDrawText( "Worker Payment: $"..mon, ( 1195 / nX ) * sX, ( 680 / nY ) * sY, ( 947 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 0, 205, 0, 255 ), 1, "default-bold", "center", "center",true,true,true,true )
					triggerServerEvent("payBonusTask",localPlayer,mon)
					count = 3*6000
				end
			else
				dxDrawText( "[Store Boss]: You are AFK , I wont give you any payment!!", ( 1195 / nX ) * sX, ( 680 / nY ) * sY, ( 947 / nX ) * sX, ( 591 / nY ) * sY, tocolor( 0, 205, 0, 255 ), 1, "default-bold", "center", "center",true,true,true,true )
			end
		end
	end
end)

function createMission()
	if isElementWithinCol(localPlayer) then
		if getElementData(localPlayer,"Occupation") == "Clothes Seller" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
			if mission == true then
				exports.NGCdxmsg:createNewDxMessage("You already opened your store, please wait the customers!",255,0,0)
				return
			else
				createGame()
			end
			triggerServerEvent("setStoreDim",localPlayer)
			setElementDimension(col,exports.server:getPlayerAccountID(localPlayer))
		end
	else
		exports.NGCdxmsg:createNewDxMessage("You can't sell clothes from here!!",255,0,0)
	end
end

function createGame()
	if isTimer(missionTimer) then return false end
	exports.NGCdxmsg:createNewDxMessage("Please wait the customers :)",255,255,0)
	missionTimer = setTimer(function()
		if isElementWithinCol(localPlayer) then
			mission = true
			local skin = skins[math.random(#skins)]
			triggerServerEvent("setStorePedTask",localPlayer,skin)
		end
	end,15000,1)
end

addEvent("togglePedGreeting",true)
addEventHandler("togglePedGreeting",root,function(p)
	local greet = math.random(#greeting)
	local msg = greeting[greet]
	MainTable = { p, msg }
end)

addEventHandler ( "onClientPedDamage", root,
	function ()
		if ( getElementData( source, "showModelPed" ) ) then
			cancelEvent()
		end
	end
)


function drawText (ped, text) --- local chat for ped

	if ( isElement( ped ) ) then
		local camPosXl, camPosYl, camPosZl = getPedBonePosition (ped, 6)

		local camPosXr, camPosYr, camPosZr = getPedBonePosition (ped, 7)

		local x,y,z = (camPosXl + camPosXr) / 2, (camPosYl + camPosYr) / 2, (camPosZl + camPosZr) / 2

		local cx,cy,cz = getCameraMatrix()

		local px,py,pz = getElementPosition(ped)

		local distance = getDistanceBetweenPoints3D(cx,cy,cz,px,py,pz)

		local posx,posy = getScreenFromWorldPosition(x,y,z+0.020*distance+0.10)

		local elementtoignore1 = getPedOccupiedVehicle(localPlayer) or localPlayer

		local elementtoignore2 = getPedOccupiedVehicle(ped) or ped

		if posx and distance <= 20 then --and ( isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore1) or isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore2) ) then -- change this when multiple ignored elements can be specified

			local width = dxGetTextWidth(text,1,"default-bold")



			dxDrawRectangle(posx - (3 + (0.5 * width)),posy - (2 + (0 * 20)),width + 5,19,tocolor(0,0,0,180))

			dxDrawRectangle(posx - (6 + (0.5 * width)),posy - (2 + (0 * 20)),width + 11,19,tocolor(0,0,0,0))

			dxDrawRectangle(posx - (8 + (0.5 * width)),posy - (1 + (0 * 20)),width + 15,17,tocolor(0,0,0,180))

			dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (1 + (0 * 20)),width + 19,17,tocolor(0,0,0,0))

			dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (0 * 20) + 1,width + 19,13,tocolor(0,0,0,180))

			dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (0 * 20) + 1,width + 23,13,tocolor(0,0,0,0))

			dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (0 * 20) + 4,width + 23,7,tocolor(0,0,0,180))



			local r,g,b = 255, 255, 255



			dxDrawText(text,posx - (0.5 * width),posy - (0 * 20),posx - (0.5 * width),posy - (0 * 20),tocolor(r,g,b,255),1,"default","left","top",false,false,false)

		end

	end

end


function drawTextBubble ()
	if MainTable then
		for i=1,#MainTable do
			drawText (MainTable[1], MainTable[2] )
		end
	end
end
addEventHandler( "onClientRender", root,  drawTextBubble  )




function onElementDataChange( dataName, oldValue )
	if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Clothes Seller" then
		initJob()
	elseif dataName == "Occupation" then
		stopJob()
    end
end
addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false )

function onJobTeamChange ( oldTeam, newTeam )
if getElementData ( localPlayer, "Occupation" ) == "Clothes Seller" and source == localPlayer then
    setTimer ( function ()
        if getPlayerTeam( localPlayer ) then
            local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
                if newTeam == "Off-Duty Workers" then
                    stopJob()
                elseif getElementData ( localPlayer, "Occupation" ) == "Clothes Seller" and newTeam == "Civilian Workers" then
                    initJob()
                end
            end
        end, 200, 1 )
    end
end
addEventHandler( "onClientPlayerTeamChange", localPlayer, onJobTeamChange, false )

function onResourceStart()
	setTimer ( function ()
		if getPlayerTeam( localPlayer ) then
			local team = getTeamName ( getPlayerTeam( localPlayer ) )
			if getElementData ( localPlayer, "Occupation" ) == "Clothes Seller" and team == "Civilian Workers" then
				initJob()
			end
		end
	end, 2500, 1 )
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart )

addEvent( "onClientPlayerTeamChange" )
function initJob()
	if not job then
		job = true
		count = 3*6000
		bindKey("space","down",openPanel)
    end
end

function stopJob()
	if job then
		job = false
		MainTable = nil
		progress = false
		mission = false
		msg = ""
		item = ""
		sold = false
		access = false
		unbindKey("space","down",openPanel)
		triggerServerEvent("endStorePed",localPlayer)
		if isTimer(missionTimer) then killTimer(missionTimer) end
		if isTimer(sellingTimer) then killTimer(sellingTimer) end
		triggerServerEvent("leaveStoreInterior",localPlayer)
	end
end

function endJob()
	MainTable = nil
	progress = false
	mission = false
	msg = ""
	item = ""
	sold = false
	triggerServerEvent("endStorePed",localPlayer)
	triggerServerEvent("leaveStoreInterior",localPlayer)
	if isTimer(missionTimer) then killTimer(missionTimer) end
	if isTimer(sellingTimer) then killTimer(sellingTimer) end
end
