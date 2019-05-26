------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppFish_c.luac (server-side)
--  Fisherman Job
--  Priyen Patel
------------------------------------------------------------------------------------


	local gui = {}
	gui._placeHolders = {}

	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 539, 355
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	windowFishInv = guiCreateWindow(left, top, windowWidth, windowHeight, "AuroraRPG ~ Fishing", false)
	guiWindowSetSizable(windowFishInv, false)

	gui["btnCloseInv"] = guiCreateButton(10, 322, 521, 23, "Close", false, windowFishInv)

	gui["tabWidget"] = guiCreateTabPanel(10, 25, 521, 291, false, windowFishInv)

	gui["tab"] = guiCreateTab("Inventory", gui["tabWidget"])

	gui["listFishInv"] = guiCreateGridList(10, 10, 491, 227, false, gui["tab"])
	guiGridListSetSortingEnabled(gui["listFishInv"], false)
	gui["listFishInv_col0"] = guiGridListAddColumn(gui["listFishInv"], "Fish", 0.2503666)
	gui["listFishInv_col1"] = guiGridListAddColumn(gui["listFishInv"], "Weight (Kg)", 0.223666)
	gui["listFishInv_col2"] = guiGridListAddColumn(gui["listFishInv"], "AUR Record (Kg)", 0.243666)
	gui["listFishInv_col3"] = guiGridListAddColumn(gui["listFishInv"], "Value ($)", 0.203666)
	guiGridListSetSelectionMode(gui["listFishInv"],0)
	local listFishInv_row = nil

	gui["btnSell"] = guiCreateButton(10, 240, 101, 23, "Sell", false, gui["tab"])

	gui["btnSellAll"] = guiCreateButton(140, 240, 101, 23, "Sell All", false, gui["tab"])

	gui["btnEat"] = guiCreateButton(270, 240, 101, 23, "Eat", false, gui["tab"])

	gui["btnRelease"] = guiCreateButton(400, 240, 101, 23, "Release", false, gui["tab"])

	gui["tab_2"] = guiCreateTab("Records", gui["tabWidget"])

	gui["listRecords"] = guiCreateGridList(10, 10, 491, 241, false, gui["tab_2"])
	guiGridListSetSortingEnabled(gui["listRecords"], false)
	gui["listRecords_col0"] = guiGridListAddColumn(gui["listRecords"], "Fish", 0.303666)
	gui["listRecords_col1"] = guiGridListAddColumn(gui["listRecords"], "Record", 0.303666)
	gui["listRecords_col2"] = guiGridListAddColumn(gui["listRecords"], "Holder", 0.303666)

	local listRecords_row = nil

	gui["tab_3"] = guiCreateTab("Stats", gui["tabWidget"])

	gui["listStats"] = guiCreateGridList(10, 10, 491, 221, false, gui["tab_3"])
	guiGridListSetSortingEnabled(gui["listStats"], false)
	gui["listStats_col0"] = guiGridListAddColumn(gui["listStats"], "Stat", 0.5503666)
	gui["listStats_col1"] = guiGridListAddColumn(gui["listStats"], "Value", 0.1503666)
	gui["listStats_col2"] = guiGridListAddColumn(gui["listStats"], "Rank Value / point", 0.103666)
	gui["listStats_col3"] = guiGridListAddColumn(gui["listStats"], "Total Rank Value", 0.103666)

	local listStats_row = nil

	gui["lblTotalPoints"] = guiCreateLabel(10, 240, 200, 16, "Total Points:", false, gui["tab_3"])
	guiLabelSetHorizontalAlign(gui["lblTotalPoints"], "left", false)
	guiLabelSetVerticalAlign(gui["lblTotalPoints"], "center")

	gui["lblTotalRankPoints"] = guiCreateLabel(360, 240, 200, 20, "Total Rank Points:", false, gui["tab_3"])
	guiLabelSetHorizontalAlign(gui["lblTotalRankPoints"], "left", false)
	guiLabelSetVerticalAlign(gui["lblTotalRankPoints"], "center")

	gui["tab_5"] = guiCreateTab("Ranks", gui["tabWidget"])

	gui["listRanks"] = guiCreateGridList(10, 10, 491, 221, false, gui["tab_5"])
	guiGridListSetSortingEnabled(gui["listRanks"], false)
	gui["listRanks_col0"] = guiGridListAddColumn(gui["listRanks"], "Rank", 0.403666)
	gui["listRanks_col1"] = guiGridListAddColumn(gui["listRanks"], "Points Needed", 0.133666)
	gui["listRanks_col2"] = guiGridListAddColumn(gui["listRanks"], "Net Value", 0.103666)
	gui["listRanks_col3"] = guiGridListAddColumn(gui["listRanks"], "Benifits", 0.303666)

	local listRanks_row = nil

	listRanks_row = guiGridListAddRow(gui["listRanks"])
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col0"], "Bus Driver in Training", false, false )
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col1"], "0", false, true )
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col2"], "0", false, true )
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col3"], "Base Salary", false, false )

	listRanks_row = guiGridListAddRow(gui["listRanks"])
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col0"], "", false, false )

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	gui["lblCurrentRank"] = guiCreateLabel(10, 240, 231, 16, "Current Rank:", false, gui["tab_5"])
	guiLabelSetHorizontalAlign(gui["lblCurrentRank"], "left", false)
	guiLabelSetVerticalAlign(gui["lblCurrentRank"], "center")

	gui["tab_4"] = guiCreateTab("Documentation", gui["tabWidget"])

	gui["memoDoc"] = guiCreateMemo(10, 10, 501, 251, "Fishing Information Memo\n\nYour Task: Fish and sell for profit\n\nHow: 1st Get the Fisherman Job at the local harbor. Benifits of the Fisherman Job include Ranks and  free permit for as long as your a Fisherman. After your done that, you need a fishing boat. Boats that will work for fishing include:\n	- Reefer\nOnce you have one of these boats, get in the driver seat and Press 1 to toggle fishing on and off, and Press 2 to \"fish\" when you are notified to. Use your panel to eat,sell,drop,release fish.\n\nTo sell fish, go to the Fisherman harbor OR any local 24/7 shop. Once you near a Fisherman hut, OR, inside a shop, simply open your panel and select a fish, and press sell.\n\nRecords: Each fish has specific records (its size). If you beat it, you will get a small reward for doing so. Records reset after an X amount of that fish has been caught.\n\nYou can ONLY carry 12 fish at a time, so choose which ones you want to keep wisely.\nYou can be eaten by jaws, attacked by sea monsters, find out.\nThere are tons of fish and other things to catch!\n        \nRanks: In your panel you have available to you a stats list. Each stat point has a rank value and your total rank\n            Value will determine your rank. Refer to rank menu to find the list of ranks and benifits.\n            * Ranks will only work IF you have the Fisherman job.\n* ONLY fish that you caught while under Fisherman job will be applied rank bonus! ", false, gui["tab_4"])
	guiMemoSetReadOnly(gui["memoDoc"],true)
	guiSetVisible(windowFishInv,false)
	--guiSetEnabled(gui["btnDrop"],false)
local cd = 0
local regenTimer = ""

fishsellshopx = {
    button = {},
    window = {},
    memo = {}
}
fishsellshopx.window[1] = guiCreateWindow(236, 150, 321, 283, "Fishshop", false)
guiWindowSetSizable(fishsellshopx.window[1], false)

fishsellshopx.memo[1] = guiCreateMemo(9, 24, 302, 193, "                -----------Selling Fish---------\n                Welcome to the AUR Fish Shop! \nTo sell your fish do these steps\n1. Press F5 or type /fish\n2. Select your fish.\n3. Press Sell while you're standing here\n4. You could get a bonus.\nif you have a fisherman rank!", false, fishsellshopx.window[1])
fishsellshopx.button[1] = guiCreateButton(93, 228, 130, 40, "Close", false, fishsellshopx.window[1])
guiSetProperty(fishsellshopx.button[1], "NormalTextColour", "FFAAAAAA")
guiSetVisible(fishsellshopx.window[1],false)

local shopPos = {
	{997.95,-2115.89,13.6}, 
	{1623.0528,578.610,0.707},
	--{-2419.3049,2327.0178,4.507}
	{-2069.03,1430.71,6},
	{-2076.34,1430.45,6},
}
local shopMarkers = {}
local rankI = {}
local ranks = {
	{"New Fisherman",0,0,"Base Salary"},
	{"Regular Fisherman",15,0,"Base Salary"},
	{"Experienced Fisherman",200,0,"Base Salary"},
	{"Seasonal Fisherman",1000,0,"Base Salary + 2% More"},
	{"Lead Fisherman",1500,0,"Base Salary + 5% More"},
	{"Head Fisherman",2000,0,"Base Salary + 10% More"},
	--{"Commander of the FFS",3000,0,"Base Salary + 15% More"},
	--{"Commander of the FFS II",5000,0,"Base Salary + 20% More"},
	{"SA Fishing CEO",6500,0,"Base Salary + 30% More"},
	{"King of the Ocean",11000,0,"Base Salary + 40% More"}
}
fishingMode = "Off"
sizes = {
	["Very Small"] = {0.1,9.9},
	["Small"] = {10,24.9},
	["Medium"] = {25,99.9},
	["Large"] = {100,249.9},
	["Huge"] = {250,749.9},
	["Massive"] = {750,999.9},
	["Colossal"] = {1000,9999}
}
common = {
	["Amberjack"] = {pricePerKg = 65.44,size={"Medium","Large"}},
	["Grouper"] = {pricePerKg = 101.97,size={"Small","Medium"}},
	["Red Snapper"] = {pricePerKg = 136.11,size={"Small","Medium"}},
	["Trout"] = {pricePerKg = 16.50,size={"Very Small","Small"}},
	["Sea Bass"] = {pricePerKg = 508.56,size={"Very Small","Small"}},
	["Pike"] = {pricePerKg = 118.46,size={"Small","Medium"}},
	["Sail Fish"] = {pricePerKg = 36.41,size={"Small","Medium"}},
	["Tuna"] = {pricePerKg = 372.60,size={"Very Small","Small"}},
	["Eel"] = {pricePerKg = 341.84,size={"Very Small","Small"}},
	["Barracuda"] = {pricePerKg = 494.51,size={"Very Small","Small"}},
}
rare = {
	["Mackeral"] = {pricePerKg = 164.11,size={"Small","Medium"}},
	["Dolphin"] = {pricePerKg = 131.24,size={"Large","Very Large"}},
	["Turtle"] = {pricePerKg = 169.59,size={"Medium","Large"}},
	["Catfish"] = {pricePerKg = 656.21,size={"Very Small","Small"}},
	["Swordfish"] = {pricePerKg = 16.22,size={"Large","Huge"}},
	["Squid"] = {pricePerKg = 29.10,size={"Small","Colossal"}},
	["Pirahna"] = {pricePerKg = 1026.20,size={"Very Small","Small"}}
}
veryrare = {
	["Blue Marlin"] = {pricePerKg = 23.62,size={"Large","Colossal"}},
	["Shark"] = {pricePerKg = 27.68,size={"Huge","Colossal"}},
	["Lobster"] = {pricePerKg = 771.51,size={"Very Small","Medium"}}
}
othergood = {
	"Money Suitcase",
	"Weapon Suitcase",
	"Drug Suitcase",
	"Body Armor",
	"Clam Chowder",
	"Treasure Chest"
}
otherbad = {
	"Car Tire",
	"Seaweed",
	"Toilet Seat",
	"Dead Body",
	"Jelly Fish",
	"Crab",
	"Sunfish",
	"Mermaid",
	"10 Ton Whale",
	"Sea Monster",
	"Jaws",
	"Waste Metal"
}
records = {

}

myFish = {}

function regenHealth()
	local h = getElementHealth(localPlayer)
	if h < 100 then
		setElementHealth(localPlayer,h+1)
	else
		if isTimer(regenTimer) then killTimer(regenTimer) return end
	end
end

function updateInv(bool)
	guiGridListClear(gui["listFishInv"])
	--[[if permits then
		guiSetText(windowFishInv,"AuroraRPG ~ Fishing :: Permit - "..permits.."")
		else]]
		guiSetText(windowFishInv,"AuroraRPG ~ Fishing")
	--end
	for k,v in pairs(myFish) do

		local sizeName = ""
		local recordSizeName = ""
		local weight = v[2]
		if records[v[1]] == nil then records[v[1]] = {"No one",0} end
		for k2,v2 in pairs(sizes) do
			if records[v[1]][2] >= v2[1] and records[v[1]][2] <= v2[2] then
				recordSizeName = tostring(k2)
			end
		end
		for k2,v2 in pairs(sizes) do
			if weight >= v2[1] and weight <= v2[2] then
				sizeName = tostring(k2)
			end
		end
		if weight > records[v[1]][2] then
		triggerServerEvent("CSGfishNewRecord",localPlayer,v[1],weight)
		records[v[1]][2] = weight
		end
		local row = guiGridListAddRow(gui["listFishInv"])
		guiGridListSetItemText ( gui["listFishInv"], row, 1, v[1], false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 2, v[2].." Kg  ("..sizeName..")", false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 3, "   "..records[v[1]][2].." Kg ("..recordSizeName..")", false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 4, "     "..v[3], false, false )
	end
	triggerServerEvent("CSGfishRecMyFishUpdate",localPlayer,myFish)---,permits)
	updateRecords()
	updateStatsMenu()
	updateRanksMenu()
end

function isFisherman()
	local te = getPlayerTeam(localPlayer)
	if te == false then return false end
	if getTeamName(te) == "Civilian Workers" then
		if exports.server:getPlayerOccupation() == "Fisherman" or getElementData(localPlayer,"Occupation") == "Fisherman" then
			return true
		end
	end
	return false
end

function updateRecords()
	guiGridListClear(gui["listRecords"])
	local myName = getPlayerName(localPlayer)
	local recordSize = ""
	for k,v in pairs(records) do
		for k2,v2 in pairs(sizes) do
			if v[2] >= v2[1] and v[2] <= v2[2] then
				recordSize = tostring(k2)
			end
		end
		local row = guiGridListAddRow(gui["listRecords"])
		guiGridListSetItemText ( gui["listRecords"], row,1,k,false,false)
		guiGridListSetItemText ( gui["listRecords"], row,2,v[2].." Kg ("..recordSize..")",false,false)
		guiGridListSetItemText ( gui["listRecords"], row,3,v[1],false,false)
		if myName == v[1] then
			for i=1,3 do
				guiGridListSetItemColor(gui["listRecords"],row,i,0,255,0)
			end
		end
	end
end

showWarn = false
function fish0()
	if fishingMode == "Off" then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh == false then return end
	if isInValidBoat(veh) == true then
		if showWarn == false and reelingIn == false then
			local num0 = math.random(1,100)
			if num0 < 50 then return end
			local num = math.random(1,100)
			if num > 80 then --8% chance for it to come while driving
				showWarn = true
				setTimer(function() showWarn=false end,5000,1)
			end
		end
		--if guiGetVisible(warnImage) == true then
		--	--guiSetVisible(warnImage,false)
		--else
			if showWarn == true then
				 exports.NGCdxmsg:createNewDxMessage("Press 2 to Pull in Now!",255,255,0)
				--guiSetVisible(warnImage,true)
			end
		--	end
		--end
	end
end


addEventHandler("onClientPlayerWasted",localPlayer,function() onExit(localPlayer)  end)

function doPermit()
	if isFisherman() == false then
		--if permits > 0 then
		--	permits=permits-1
			updateInv()
		--else
		--	triggerServerEvent("CSGfishWanted",localPlayer)
		--end
	end
end

reelingIn = false
function fish()
	if showWarn == false then return end
	if getElementData(localPlayer,"Occupation") ~= "Fisherman" then return false end
	if reelingIn == true then return end
	--[[speedx, speedy, speedz = getElementVelocity (getPedOccupiedVehicle(localPlayer))
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	kmh = actualspeed * 180
	if kmh < 25 then
		 exports.NGCdxmsg:createNewDxMessage("Your going too slow to reel in!",255,255,0)
		return
	end--]]
	local t = {}
	local num = math.random(1,100)
	reelingIn = true
	local tim = math.random(2000,4000)
	exports.CSGprogressbar:createProgressBar("Reeling In...",50, "CSGfish.barFinish") -- 5 secs to finish
	if num < 10 then
		setTimer(function() exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
	else

	end

	if num >= 10 then -- a catch
		if num <= 90 then	-- common catches
			catch0(common,10)
			doPermit()
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"common")
			addStat("# of Fish Caught In Life Time",1)
			addStat("# of Common Fish Caught",1)
		elseif num > 90 and num <= 93 then -- rare
			catch0(rare,7)
			doPermit()
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"rare")
			addStat("# of Rare or Very Rare Fish Caught",1)
			addStat("# of Fish Caught In Life Time",1)
		elseif num > 94 and num <= 95 then -- very rare
			catch0(veryrare,3)
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"veryrare")
			doPermit()
			addStat("# of Rare or Very Rare Fish Caught",1)
			addStat("# of Fish Caught In Life Time",1)
		elseif num > 95 and num <= 97 then -- other good
			otherCatch(othergood)
			addStat("# of Other Good Caught",1)
			setTimer(function() exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
			return
		elseif num > 87 then --other bad
			otherCatch(otherbad)
			addStat("# of Other Bad Caught",1)
			setTimer(function() exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
			return
		end
	else -- nothing
		addStat("# of times nothing Caught",1)
		setTimer(function ()  exports.NGCdxmsg:createNewDxMessage("Caught nothing",255,255,0) end,tim,1)
	end
end


function catch0(t,size)
	tableToUse=t
	sizeToUse=size
end

function catch()
	reelingIn = false
	local t = tableToUse
	local size = sizeToUse
	local i = math.random(1,size)
	local count = 1
	k = ""
	for k0,v in pairs(t) do
		if count == i then k=k0 break end
			count = count + 1
	end
		local weightMin = math.random(sizes[t[k]["size"][1]][1],sizes[t[k]["size"][1]][2])
		local weightMax = math.random(sizes[t[k]["size"][2]][1],sizes[t[k]["size"][2]][2])
		if weightMax == nil then WeightMax = weightMin+1 end
		local weight = math.random(weightMin,weightMax)
		weight=weight*0.453592
		weight=math.floor(weight+0.5)
		local value = weight*(t[k].pricePerKg)
		value=value/5
		value=value*0.7
		value=math.floor(value+0.5)*1.3
		addStat("$ Fish value caught",value)
		addStat("# of Kilograms of fish caught",weight)
		local fisher = isFisherman()
		triggerServerEvent("CSGfishRecMyFishUpdate",localPlayer,myFish)
		 exports.NGCdxmsg:createNewDxMessage("Caught a "..weight.." Kg "..k.."!",0,255,0)
		if #myFish > 12 then
			 exports.NGCdxmsg:createNewDxMessage("But you threw it back because you can't carry anymore fish!",0,255,0)
			updateInv()
			return
		end
		table.insert(myFish,{k,weight,value,fisher})

		updateInv()
end
addEvent("CSGfish.barFinish",true)
addEventHandler("CSGfish.barFinish",root,catch)

addEventHandler("onClientPlayerQuit",root,function()
	if source == localPlayer then
		if isFisherman() then
			triggerServerEvent("CSGfishRecMyFishUpdate",localPlayer,myFish)
		end
	end
end)

function otherCatch(t)
	local i = math.random(1,#t)
	if t == otherbad then
		if i == 1 then --car tire
			 exports.NGCdxmsg:createNewDxMessage("Caught a car tire and threw it back into the water",255,255,0)
		elseif i == 2 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught some seaweed and threw it back into the water",255,255,0)
		elseif i == 3 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught a old toilet seat and threw it back into the water",255,255,0)
		elseif i == 4 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught a dead body. You forgot if the law ask.",255,255,0)
		elseif i == 5 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught a jelly fish and got attacked!",255,0,0)
			local h = getElementHealth(localPlayer)
			addStat("# of times attacked by things you caught",1)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 6 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught a crab and got attacked!",255,0,0)
			addStat("# of times attacked by things you caught",1)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 7 then --
			 exports.NGCdxmsg:createNewDxMessage("You caught something, but throw it back",255,255,0)
		elseif i == 8 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught a mermaid! A bad one! You got attacked!",255,0,0)
			addStat("# of times attacked by things you caught",1)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 9 then --
			 exports.NGCdxmsg:createNewDxMessage("Caught a whale and its weight sank the boat!",255,255,0)
			addStat("# of times attacked by things you caught",1)
			sinkBoat()
		elseif i == 10 then --
			seaMonster()
		elseif i == 11 then --
			jaws()
		elseif i == 12 then
			 exports.NGCdxmsg:createNewDxMessage("Caught Waste Metal, No Luck",255,255,0)
		end
	elseif t == othergood then
		if i == 1 or i == 2 or i == 3 or i == 6 then
			triggerServerEvent("CSGfishGoodCatch",localPlayer,i)
		elseif i == 4 then -- to do body armor
			 exports.NGCdxmsg:createNewDxMessage("Found a weapon suitcase!",255,255,0)
			 exports.NGCdxmsg:createNewDxMessage("But you dont want it so you threw it back!",255,255,0)
		elseif i == 5 then
			 exports.NGCdxmsg:createNewDxMessage("Caught some clam chowder and ate it for some nice refreshing health",0,255,0)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,100)
		end
	end
end

function jaws()
	 exports.NGCdxmsg:createNewDxMessage("You got eaten by jaws and lost some of your fish!",255,0,0)
	setElementHealth(localPlayer,0)
	addStat("# of times eaten by jaws",1)
	--to do
end

function seaMonster()

end

function sinkBoat()
	local veh = getPedOccupiedVehicle(localPlayer)
	local rx,ry,rz = getElementRotation(veh)
	setElementFrozen(veh,true)
	ry=45
	setElementRotation(veh,rx,ry,rz)
	setTimer(function()
		local x,y,z = getElementPosition(veh) setElementPosition(veh,x,y,z-0.5)
	end,1000,10)
	setTimer(function() destroyElement(veh) end,10000,1)
end

function click()
	if source == gui["btnSell"] then
		if isInValidShop() == true then
			local row = guiGridListGetSelectedItem(gui["listFishInv"])
			if row == false or row == -1 then
				 exports.NGCdxmsg:createNewDxMessage("You need to select a fish to sell",255,255,0)
			else
				row=row+1
				local fishName = myFish[row][1]
				local weight = myFish[row][2]
				local value = myFish[row][3]
				local fisher = myFish[row][4]
				table.remove(myFish,row)
				updateInv()
				triggerServerEvent("CSGfishSoldFish",localPlayer,fishName,weight,value,fisher,rankI)
			end
		else
			 exports.NGCdxmsg:createNewDxMessage("You can only sell fish at the Fisherman job Hut OR a 24/7 Shop",255,255,0)
		end
	elseif source == gui["btnSellAll"] then
		if isInValidShop() == true then
		for k,v in pairs(myFish) do
				local fishName = v[1]
				local weight = v[2]
				local value = v[3]
				local fisher = v[4]
				table.remove(myFish,k)
				updateInv()
				triggerServerEvent("CSGfishSoldFish",localPlayer,fishName,weight,value,fisher,rankI)
		end
		else
			 exports.NGCdxmsg:createNewDxMessage("You can only sell fish at the Fisherman job Hut OR a 24/7 Shop",255,255,0)
		end
	elseif source == gui["btnEat"] then
		local row = guiGridListGetSelectedItem(gui["listFishInv"])
		if row == false or row == -1 then
			 exports.NGCdxmsg:createNewDxMessage("You need to select a fish to eat",255,255,0)
		else
			row=row+1
			local name = myFish[row][1]
			local weight = myFish[row][2]
			 exports.NGCdxmsg:createNewDxMessage("Ate a "..weight.." Kg "..name.." for some health",255,255,0)
			addStat("# of times eaten a fish",1)
			if weight > 5 then
				local num = math.random(1,100)
				local h = getElementHealth(localPlayer)
				if h > 75 then
					if isTimer(regenTimer) then killTimer(regenTimer) end
					regenTimer=setTimer(regenHealth,500,math.random(10,25))
					 exports.NGCdxmsg:createNewDxMessage("You got full and threw the rest of it away",255,255,0)
				elseif h >= 99 then
					 exports.NGCdxmsg:createNewDxMessage("You ate too much and got sick!",255,0,0)
					--make puke anim here
					setElementHealth(localPlayer,math.random(50,75))
				elseif h <= 75 then
					if isTimer(regenTimer) then killTimer(regenTimer) end
					regenTimer=setTimer(regenHealth,500,math.random(10,50))
				end
			end
			table.remove(myFish,row)
			updateInv()
		end
	elseif source == gui["btnCloseInv"] then
		hide()
	elseif source == gui["btnRelease"] then
		if type(getWaterLevel(getElementPosition(localPlayer))) ~= "boolean" then
			local row = guiGridListGetSelectedItem(gui["listFishInv"])
			if row == false or row == -1 then
				 exports.NGCdxmsg:createNewDxMessage("You need to select a fish to release",255,255,0)
			else
				addStat("# of times released a fish",1)
				row=row+1
				local name = myFish[row][1]
				local weight = myFish[row][2]
				 exports.NGCdxmsg:createNewDxMessage("Released the "..weight.." Kg "..name.." into the water",255,255,0)
				table.remove(myFish,row)
				updateInv()
			end
		else
			 exports.NGCdxmsg:createNewDxMessage("You need to be near water to release a fish",255,255,0)
		end
	elseif source == btnBuy50 then
		triggerServerEvent("CSGfishBuy",localPlayer,50,30000)
	elseif source == fishsellshopx.button[1] then
		hideShop()
	end
end
addEventHandler("onClientGUIClick",root,click)

local validInt = {
	6,18
}

function isInValidShop()
	if guiGetVisible(fishsellshopx.window[1]) == true then
		return true
	end
	for k,v in pairs(shopMarkers) do
		if isElementWithinMarker(localPlayer,v) == true then
			return true
		end
	end
	local int = getElementInterior(localPlayer)
	if int == 6 or int == 18 then return true end
	return false
end

function show()
	guiSetVisible(windowFishInv,true)
	showCursor(true)
end

function hide()
	guiSetVisible(windowFishInv,false)
	if guiGetVisible(fishsellshopx.window[1]) == false then
		showCursor(false)
	end
end

function toggle()
	if guiGetVisible(windowFishInv) == true then
		hide()
	else
		local bool = isFisherman()
		--outputChatBox(tostring(bool))
		if bool == true then
			show()
		end
	end
end

function toggle0(cmdName)
	if guiGetVisible(windowFishInv) == true then
		hide()
	else
		show()
	end
end
addCommandHandler("fish",toggle0)

function createText()
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Fishing: #33FF33"..fishingMode.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
end

function isInValidBoat(v)
	local model = getElementModel(v)
	if model == 453 or model == 484 then return true end
	return false
end

function toggleFishingMode()
	if isPedInVehicle(localPlayer) == true then
		if isInValidBoat(getPedOccupiedVehicle(localPlayer)) == false then
			return
		end
	end
	if fishingMode == "Off" then
		fishingMode = "On"

	else
		fishingMode = "Off"
		--guiSetVisible(warnImage,false)
		exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false
	end
end

addEventHandler("onClientVehicleEnter",root, function (p)
	if p ~= localPlayer then return end
	if isInValidBoat(source) == false then return end
	if getElementData(p,"Occupation") ~= "Fisherman" then return false end
	bindKey("1","down",toggleFishingMode)
	local boatName = getVehicleName(source)
	 exports.NGCdxmsg:createNewDxMessage("This "..boatName.." is equiped with fishing equipment",0,255,0)
	 exports.NGCdxmsg:createNewDxMessage("Press 1 to Toggle Fishing",0,255,0)
	fishTimer = setTimer(fish0,1000,0)
	addEventHandler("onClientRender",root,createText) end)
addEventHandler("onClientVehicleExit",root,function (p)
	if p ~= localPlayer then return end
	if isInValidBoat(source) == false then return end
	onExit(p)
	 end)

function onExit(p)
	if p ~= localPlayer then return end
	exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false
	if isTimer(fishTimer) then
		killTimer(fishTimer)
	end
	--guiSetVisible(warnImage,false)
	unbindKey("1","down",toggleFishingMode)
	removeEventHandler("onClientRender",root,createText)
end

function CSGfishRecData(t)
	if t == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}} end
	myFish = t[1]
	databaseStats = t[2]
	--permits = t[3][1]
	updateInv(false)
	addStat("# of Fish Caught In Life Time",1)
end
addEvent("CSGfishRecData",true)
addEventHandler("CSGfishRecData",localPlayer,CSGfishRecData)

function CSGfishRecRecords(t)
	records = t
	updateInv(false)
end
addEvent("CSGfishRecRecords",true)
addEventHandler("CSGfishRecRecords",localPlayer,CSGfishRecRecords)

local nameToI = {
	["# of Fish Caught In Life Time"] = 1,
	["# of Common Fish Caught"] = 2,
	["# of Rare or Very Rare Fish Caught"] = 3,
	["# of Other Bad Caught"] = 4,
	["# of Other Good Caught"] = 5,
	["# of times nothing Caught"] = 6,
	["# of times record broken"] = 7,
	["$ Money earned from fishing overall"] = 8,
	["$ Money earned from selling fish"] = 9,
	["$ Money earned from non-selling fish"] = 10,
	["# of times eaten by jaws"] = 11,
	["# of times attacked by things you caught"] = 12,
	["# of times ganged on by sea monsters"] = 13,
	["# of times eaten a fish"] = 14,
	["# of times dropped a fish"] = 15,
	["# of times released a fish"] = 16,
	["$ Fish value caught"] = 17,
	["# of Kilograms of fish caught"] = 18
}

function addStat(k,v)
	databaseStats[nameToI[k]] = databaseStats[nameToI[k]]+v
	updateStatsMenu()
	triggerServerEvent("CSGfishSetStat",localPlayer,tostring(k),v,"","",databaseStats,totalRankPoints)
end
addEvent("CSGfishAddStat",true)
addEventHandler("CSGfishAddStat",localPlayer,addStat)

function updateStatsMenu()
	guiGridListClear(gui["listStats"])
	stats = {
		["# of Fish Caught In Life Time"] = {databaseStats[nameToI["# of Fish Caught In Life Time"]],0,0},
		["# of Common Fish Caught"] = {databaseStats[nameToI["# of Common Fish Caught"]],3,0},
		["# of Rare or Very Rare Fish Caught"] = {databaseStats[nameToI["# of Rare or Very Rare Fish Caught"]],15,0},
		["# of Other Bad Caught"] = {databaseStats[nameToI["# of Other Bad Caught"]],0,0},
		["# of Other Good Caught"] = {databaseStats[nameToI["# of Other Good Caught"]],0,0},
		["# of times nothing Caught"] = {databaseStats[nameToI["# of times nothing Caught"]],0,0},
		["# of times record broken"] = {databaseStats[nameToI["# of times record broken"]],4,0},
		["$ Money earned from fishing overall"] = {databaseStats[nameToI["$ Money earned from fishing overall"]],0,0},
		["$ Money earned from selling fish"] = {databaseStats[nameToI["$ Money earned from selling fish"]],0,0,},
		["$ Money earned from non-selling fish"] = {databaseStats[nameToI["$ Money earned from non-selling fish"]],0,0},
		["# of times eaten by jaws"] = {databaseStats[nameToI["# of times eaten by jaws"]],0,0},
		["# of times attacked by things you caught"] = {databaseStats[nameToI["# of times attacked by things you caught"]],0,0},
		["# of times ganged on by sea monsters"] = {databaseStats[nameToI["# of times ganged on by sea monsters"]],0,0},
		["# of times eaten a fish"] = {databaseStats[nameToI["# of times eaten a fish"]],0,0},
		["# of times dropped a fish"] = {databaseStats[nameToI["# of times dropped a fish"]],0,0},
		["# of times released a fish"] = {databaseStats[nameToI["# of times released a fish"]],0,0},
		["$ Fish value caught"] = {databaseStats[nameToI["$ Fish value caught"]],0,0},
		["# of Kilograms of fish caught"] = {databaseStats[nameToI["# of Kilograms of fish caught"]],0,0},
	}
	totalRankPoints = 0
	totalPoints = 0
	for k,v in pairs(stats) do
		local ptsToAdd = (tonumber(v[1])*tonumber(v[2]))
		totalRankPoints=totalRankPoints+ptsToAdd
		stats[k][3] = ptsToAdd
		totalPoints=totalPoints+tonumber(v[1])
		local row = guiGridListAddRow(gui["listStats"])
		guiGridListSetItemText(gui["listStats"], row, 1, ""..tostring(k).."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 2, ""..stats[k][1].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 3, ""..stats[k][2].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 4, ""..stats[k][3].."", false, false )
		if v[2] > 0 then
			for i=1,4 do
				guiGridListSetItemColor(gui["listStats"],row,i,0,255,0)
			end
		end
	end
	guiSetText(gui["lblTotalPoints"],"Total Points: "..totalPoints.."")
	guiSetText(gui["lblTotalRankPoints"],"Total Rank Points: "..totalRankPoints.."")
end

local first = true

function updateRanksMenu()
	guiGridListClear(gui["listRanks"])
	for k,v in pairs(ranks) do
		ranks[k][3] = totalRankPoints-tonumber(ranks[k][2])
	end

	local currentRank = ""
    for k,v in pairs(ranks) do
		local needed = tonumber(v[2])
        if totalRankPoints > needed then
            ranks[k][3] = "+"..tostring((totalRankPoints-needed))..""
            currentRank = ranks[k][1]
			rankI = k
        elseif totalRankPoints < needed then
            ranks[k][3] = "-"..tostring((needed-totalRankPoints))..""
        elseif totalRankPoints == needed then
            ranks[k][3] = "0"
            currentRank = ranks[k][1]
			rankI = k
        end
    end
	guiSetText(gui["lblCurrentRank"],"Rank: "..currentRank.."")
	for k,v in pairs(ranks) do
		local row = guiGridListAddRow(gui["listRanks"])
		guiGridListSetItemText(gui["listRanks"], row, 1, tostring(v[1]), false, false )
		guiGridListSetItemText(gui["listRanks"], row, 2, tostring(v[2]), false, false )
		guiGridListSetItemText(gui["listRanks"], row, 3, tostring(v[3]), false, false )
		guiGridListSetItemText(gui["listRanks"], row, 4, tostring(v[4]), false, false )
		if v[1] == currentRank then
			for i=1,4 do
				guiGridListSetItemColor(gui["listRanks"],row,i,0,255,0)
			end
		end
	end
	if first == true then
		first = false
		rank = currentRank
	end
	if rank ~= currentRank then
		exports.NGCdxmsg:createNewDxMessage("Congratulations! You have been promoted to "..currentRank.."!",0,255,0)
		rank = currentRank
	end
end

function job(bool)
	if bool == true then
		if isFisherman() == true then
			guiSetEnabled(gui["listRanks"],true)
		end
	else
		guiSetEnabled(gui["listRanks"],false)
	end
end
addEvent("CSGfishJob",true)
addEventHandler("CSGfishJob",localPlayer,job)

function showShop()
	guiSetVisible(fishsellshopx.window[1],true)
	showCursor(true)
	 exports.NGCdxmsg:createNewDxMessage("Welcome to the AUR Fish Shop! You can sell your fish here.",0,255,0)
end

function hideShop()
	guiSetVisible(fishsellshopx.window[1],false)
	if guiGetVisible(windowFishInv) == false then
		showCursor(false)
	end
end
addEventHandler("onClientPlayerWasted",localPlayer,hideShop)

function hitShop(p)
	if p ~= localPlayer then return end
	if isPedInVehicle(p) then return end
	showShop()
end

for k,v in pairs(shopPos) do
	local m = createMarker(v[1],v[2],v[3]-1,"cylinder",2,255,255,0,100)
	addEventHandler("onClientMarkerHit",m,hitShop)
	table.insert(shopMarkers,m)
end
--[[
txd = engineLoadTXD ( ":CSGmods/Mods/skins/CSGfish/sea.txd" )
engineImportTXD ( txd, 49 )
dff = engineLoadDFF ( ":CSGmods/Mods/skins/CSGfish/sea.dff", 49 )
engineReplaceModel ( dff, 49 )
]]
job(true)
setTimer(function() if isFisherman() == true then job(true) else job(false) end end,1000,5)
bindKey("2","down",fish)
bindKey("F5","down",toggle)

function printR()
	local str = toJSON(records)
	outputConsole(str)
end
addCommandHandler("printrecords",printR)

addEvent( "onPlayerRankChange" )
addEventHandler( "onPlayerRankChange", root,
	function ( oldRank, newRank )
		updateInv(false)
	end
)

--Map--
Objects = {
createObject ( 3886, 971.70001, -2073, 1, 0, 0, 90 ),
createObject ( 3886, 961.29999, -2073, 1, 0, 0, 90 ),
createObject ( 3886, 950.90002, -2073, 1, 0, 0, 90 ),
createObject ( 3886, 971.7002, -2048.3994, 1, 0, 0, 90 ),
createObject ( 3886, 961.29999, -2048.3999, 1, 0, 0, 90 ),
createObject ( 3886, 950.90039, -2048.3994, 1, 0, 0, 90 ),
createObject ( 3886, 943.70001, -2071, 1, 0, 0, 180 ),
createObject ( 3886, 943.70001, -2060.7, 1, 0, 0, 179.995 ),
createObject ( 3886, 943.70001, -2050.3, 1, 0, 0, 179.995 ),
createObject ( 3886, 943.70001, -2081.3999, 1, 0, 0, 179.995 ),
createObject ( 3886, 943.7002, -2091.7002, 1, 0, 0, 179.995 ),
createObject ( 3886, 950.90039, -2093.7998, 1, 0, 0, 90 ),
createObject ( 3886, 961.2998, -2093.7998, 1, 0, 0, 90 ),
createObject ( 3886, 971.5, -2093.7998, 0.1, 9.998, 0, 90 ),
createObject ( 11497, 1002.2, -2118.7, 12.1, 0, 0, 174 ),
createObject ( 8493, 916.29999, -2134.3, 14.8, 0, 0, 58 ),
createObject ( 1437, 931, -2133.5, -0.4, 315, 0, 150 ),
createObject ( 1437, 930.5, -2133.2, -0.4, 315, 0, 149.996 ),
createObject ( 1437, 926.59998, -2131, -0.4, 315, 0, 149.996 ),
createObject ( 1437, 927.09998, -2131.3, -0.4, 315, 0, 149.996 ),
createObject ( 2406, 995.59998, -2122.2, 13.3, 0, 0, 145.997 ),
createObject ( 2406, 994.90002, -2121.7, 13.3, 0, 0, 145.992 ),
createObject ( 10831, 976.90002, -2149.8999, 17, 0, 0, 180 ),
createObject ( 994, 962.79999, -2155.6001, 12.1 ),
createObject ( 994, 962.79999, -2159.5, 12.1 ),
createObject ( 994, 962.79999, -2151.8, 12.1 ),
createObject ( 994, 962.79999, -2148, 12.1 ),
createObject ( 994, 962.79999, -2144, 12.1 ),
createObject ( 994, 962.79999, -2140.1001, 12.1 ),
createObject ( 1250, 981, -2135.8, 13.1, 0, 0, 270 ),
createObject ( 1250, 972.79999, -2135.5, 13.1, 0, 0, 90 ),
createObject ( 994, 984.59998, -2159.5, 12.1 ),
createObject ( 994, 984.59998, -2155.6001, 12.1 ),
createObject ( 994, 984.59998, -2151.7, 12.1 ),
createObject ( 994, 984.59998, -2147.8, 12.1 ),
createObject ( 994, 984.59998, -2144, 12.1 ),
createObject ( 994, 984.59998, -2140.1001, 12.1 ),
createObject ( 3886, 943.70001, -2102.1001, 1, 0, 0, 179.995 ),
createObject ( 3886, 943.70001, -2112.3999, 1, 0, 0, 179.995 ),
createObject ( 3886, 950.90002, -2114.3, 1, 0, 0, 90 ),
createObject ( 3886, 961.29999, -2114.3, 1, 0, 0, 90 ),
createObject ( 3886, 971.5, -2114.3, 0.1, 9.998, 0, 90 ),
createObject ( 3886, 936.40002, -2048.3999, 1, 0, 0, 90 ),
createObject ( 3886, 936.5, -2073.1001, 1, 0, 0, 90 ),
createObject ( 3886, 936.5, -2093.7, 1, 0, 0, 90 ),
createObject ( 3886, 936.40002, -2114.5, 1, 0, 0, 90 ),
createObject ( 1237, 944.90002, -2116.7, 1.9 ),
createObject ( 1237, 943.29999, -2045.9, 1.9 ),
createObject ( 1237, 944.09998, -2045.9, 1.9 ),
createObject ( 1237, 942.59998, -2045.9, 1.9 ),
createObject ( 1237, 944.90039, -2045.9004, 1.9 ),
createObject ( 1237, 944.09998, -2116.7, 1.9 ),
createObject ( 1237, 943.29999, -2116.7, 1.9 ),
createObject ( 1237, 942.5, -2116.7, 1.9 ),
createObject ( 1231, 975.20001, -2050.1001, 4.6 ),
createObject ( 1231, 975.2002, -2046.9004, 4.6 ),
createObject ( 1231, 976.20001, -2074.5, 4.6 ),
createObject ( 1231, 976.09961, -2071.3994, 4.6 ),
createObject ( 1231, 966.20001, -2095.5, 4.6 ),
createObject ( 1231, 966.29999, -2112.6001, 4.6 ),
createObject ( 1231, 966.2002, -2092.0996, 4.6 ),
createObject ( 1231, 966.2998, -2116, 4.6 ),
createObject ( 1363, 943.79999, -2072.8999, 2.7 ),
createObject ( 1363, 943.90002, -2093.8, 2.7 ),
createObject ( 1363, 943.90002, -2114.1001, 2.7 ),
createObject ( 1363, 943.90002, -2048.5, 2.7 ),
createObject ( 1231, 931.5, -2046.8, 4.6 ),
createObject ( 1231, 931.5, -2050, 4.6 ),
createObject ( 1231, 931.59998, -2071.5, 4.6 ),
createObject ( 1231, 931.59998, -2074.7, 4.6 ),
createObject ( 1231, 931.59998, -2092.1001, 4.6 ),
createObject ( 1231, 931.59998, -2095.3, 4.6 ),
createObject ( 1231, 931.5, -2112.8999, 4.6 ),
createObject ( 1231, 931.5, -2116.1001, 4.6 ),
createObject ( 1236, 1000.2, -2113.2, 12.8, 0, 0, 174 ),
createObject ( 1264, 997.70001, -2113.3999, 12.6 ),
createObject ( 1264, 997.59998, -2112.5, 12.6 ),
createObject ( 1264, 998.40002, -2112.8, 12.6 ),
createObject ( 2745, 989.09998, -2135, 13.3, 0, 0, 180 ),
createObject ( 3743, 1154.6, -2355.2, -31.8, 0, 0, 51.998 ),
createObject ( 3743, 1068.6, -2187.3999, -57.5, 0, 0, 51.998 ),
}
 for index, object in ipairs ( Objects ) do
    setElementDoubleSided ( object, true )
end

if (fileExists("c_fish.lua")) then
	fileDelete("c_fish.lua")
end
