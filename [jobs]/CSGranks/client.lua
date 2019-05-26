local rand = false


local newsRanks = {
    {"News Reporter in Training",0,0},
    {"Assistant of Photography", 30, 15},
    {"Photographer", 70, 20},
    {"Editor", 120, 25},
    {"Reporter", 170, 30},
    {"Photo Editor", 240, 35},
    {"Head Editor", 320, 40},
    {"Final Redator", 410, 50}
}

local limoRanks = {
 {"Limo Driver In Training",0},
 {"New Limo Driver",15},
 {"Trained Limo Driver",50},
 {"Experienced Limo Driver",150},
 {"Senior Limo Driver",50},
 {"Lead Limo Driver",350},
 {"Head Limo Driver",500},
}

local diverRanks = {
  {"Diver in Training",0,0,500},
 {"Second Class Diver",50,1000,750},
 {"First Class Diver",100,2000,1000},
 {"Chief Diver",200,3000,1500},
 {"Senior Chief Diver",250,10000,2000},
 {"Diving Technician",350,20000,3000},
 {"Master Chief Diver",500,30000,4000},
}

local taxiRanks = {
	{"L0. Driver", 0, 0, 1400},
	{"L1. Driver", 50, 1000, 1700},
	{"L2. Driver", 100, 2000, 2200},
	{"L3. Driver", 200, 3000, 2750},
	{"L4. Driver", 300, 4000, 3500},
	{"L5. Driver", 500, 5000, 4300},
	{"L6. Driver", 750, 6000, 4750},
	{"L7. Driver", 950, 7000, 5100},
	{"L8. Driver", 1200, 8000, 5300},
	{"L9. Driver", 1600, 9000, 5500},
	{"L10. Driver", 3000, 10000, 6000},
}

local rescuerRanks = {
	{ "Rescuer Man in Training",0,0,0},
	{ "New Rescuer Man",50,1000,50},
	{ "Trained Rescuer Man",350,2000,100},
	{ "Experienced Rescuer Man",800,3000,200},
	{ "Senior Rescuer Man",1000,10000,300},
	{ "Lead Rescuer Man",2000,20000,400},
	{ "Head Rescuer Man",3000,30000,500},
}

local pilotRanks = {
	{ "Student Pilot", 0,0,0},
	{ "Flight Engineer", 5000,1000,1000},
	{ "First Officer", 50000,2000,2000},
	{ "Senior First Officer", 100000,3000,3000},
	{ "Captain",500000,10000,4000},
	{ "Senior Captain",1000000,20000,5000},
	{ "Airline CEO", 5000000,30000,10000},
}

local farmerRanks = {
	{"New Farmer",0,0,0},
	{"Trained Farmer",50,1000,100},
	{"The owner of the farm",100,2000,200},
	{"Experienced old man",350,3000,300},
	{"Professional old man",800,10000,400},
	{"Lead Farmer",1300,20000,500},
	{"The Farmer of Aurora",3000,30000,1000},
}

local fisherRanks = {
    { "New Fisherman", 0,0,0},
    { "Regular Fisherman", 50,0,0},
    { "Experienced Fisherman", 200,1000,50},
    { "Seasonal Fisherman", 800,2000,100},
    { "Lead Fisherman",1000,3000,200},
    { "Head Fisherman", 2000,10000,300},
    { "SA Fising CEO", 4000,20000,400},
    { "King of the Ocean", 6000,30000,500},

}


local paramedicRanks = {
    {"Medical Student",0,0,0},
    {"Experienced Doctor",50,1000,50},
    {"Head Doctor",300,2000,100},
    {"Experienced Surgeon",800,3000,200},
    {"Head Surgeon",1000,10000,300},
    {"AUR Medical Head",4000,20000,400},
    {"AUR Medical CEO",8000,30000,500},

}

local truckerRanks = {
	{"Regular Trucker",0,0,0},
    {"Seasoned Trucker",50,1000,2000},
    {"Enthusiast Trucker",100,20000,5000},
    {"Outback Ranger",350,30000,10000},
    {"Commander Trucker",800,10000,15000},
    {"Desert Captain",1000,38000,20000},
    {"King of the Road",3000,40000,30000},
}

local lumberRanks = {
    {"Wood Collector",0,0,0},
    {"Seasonal Woodcutter",50,1000,50},
    {"Constant Lumberjack",100,2000,100},
    {"Forest Woodcutter",350,3000,200},
    {"Head Lumberjack",800,10000,300},
    {"Lumberjack at Charge",1000,20000,400},
    {"Lead Woodcutter",3000,30000,500},
}



local garbageRanks = {
	{"Garbage Collector",0,0,0},
	{"Constant Garbage man",50,1000,50},
	{"City Garbage man",100,2000,100},
	{"Head Garbage man",350,3000,200},
	{"Senior Garbage man",800,10000,300},
	{"Lead Garbage man",1000,20000,400},
	{"Garbage man King",2000,30000,500},
}

local firefighterRanks = {
	{"Volunteer firefighter",0,0,0},
	{"Probationary firefighter",50,1000,100},
	{"Lieutenant Firefighter",100,2000,150},
	{"Battalion Chief",350,3000,200},
	{"Assistant Fire Chief",800,10000,300},
	{"Fire Chief",1000,20000,500},
	{"Fire Commissioner",3000,30000,700},
}

local minerRanks = {
	{"Starter", 0},
	{"New Miner", 50},
	{"Fledgling Miner", 100},
	{"Apprentice Miner", 300},
	{"Adept Miner", 700},
	{"Expert Miner", 1300},
	{"Master Miner", 1600},
	{"Legend Miner", 2400},
	{"Proficient Miner", 3000},
	{"Official Miner", 6000},
}

local occupationToStat = {
    ["Farmer"] = "farmer",
    ["Diver"] = "diver",
    ["Rescuer Man"] = "rescuerMan",
    ["Pilot"] = "pilot",
    ["Paramedic"] = "paramedic",
    ["Firefighter"] = "firefighter",
    ["Trash Collector"] = "garbage",
    ["Mechanic"] = "MechanicPoints",
    ["Hooker"] = "hooker",
    ["Trucker"] = "trucking",
    ["Fisherman"] = "fisherman",
    ["Paramedic"] = "paramedic2",
    ["News Reporter"] = "newsreporter",
    ["Lumberjack"] = "lj",
	["Taxi Driver"] = "limoDriver",
	--["Miner"] = "miner",
	["Pizza Boy"] = "pizzas",
}


local occupationToRank = {
    ["Farmer"] = farmerRanks,
    ["Diver"] = diverRanks,
    ["Rescuer Man"] = rescuerRanks,
    ["Pilot"] = pilotRanks,
    ["Paramedic"] = paramedicRanks,
    ["Firefighter"] = firefighterRanks,
    ["Trash Collector"] = garbageRanks,
    ["Hooker"] = hookerRanks,
    ["Trucker"] = truckerRanks,
    ["Fisherman"] = fisherRanks,
    ["Trucker"] = truckerRanks,
    ["Paramedic"] = paramedicRanks,
    ["News Reporter"] = newsRanks,
    ["Lumberjack"] = lumberRanks,
	["Taxi Driver"] = taxiRanks,
	--["Miner"] = minerRanks,
	["Pizza Boy"] = pizzaboyRanks,
}


--[[local SAPDUserToRank = {


	["epozide"] = "SAPD Commander",

}



local militaryUserToRank = {


	["epozide"] = "Military Special Member",

}

]]

-- Timer that checks the ranks

warned=false

setTimer(

	function ()

		local occupation = getElementData( localPlayer, "Occupation" )

		local rank = getElementData( localPlayer, "Rank" )

		if ( occupationToRank[occupation] ) then

			local stat = exports.DENstats:getPlayerAccountData( localPlayer, occupationToStat[occupation] )

			if occupation == "Paramedic" then

				if stat == nil or stat == false then

					stat = 0

				else

					stat = fromJSON(stat)

					if type(stat) == "table" then

						if (stat["rankPTS"]) then

							stat = stat["rankPTS"]

						else

							stat = 0

						end

					else

						stat = 0

					end

				end

			end

			if ( stat ) then

				local theRank = false

				for i=1,#occupationToRank[occupation] do

					if not ( theRank ) then

						--if occupation == "Police Officer" or occupation == "SAPD" then

						--	theRank = "(PO)-"..occupationToRank[occupation][i][1]..""

						--elseif occupation == "Traffic Officer" then

						--	theRank = "(TO)-"..occupationToRank[occupation][i][1]..""

						--else

							theRank = occupationToRank[occupation][i][1]

						--end

					elseif ( occupationToRank[occupation][i][2] <= stat ) then

						--if occupation == "Police Officer" then

						--	theRank = "(PO)-"..occupationToRank[occupation][i][1]..""

						--elseif occupation == "Traffic Officer" then

						--	theRank = "(TO)-"..occupationToRank[occupation][i][1]..""

						--else

							theRank = occupationToRank[occupation][i][1]

						--end

						--theRank = occupationToRank[occupation][i][1]

					end

				end

				if ( rank ~= theRank ) then setElementData( localPlayer, "Rank", theRank ) if ( rank ~= occupation ) then triggerEvent( "onPlayerRankChange", localPlayer, rank, theRank ) end end

			end

		else

				if occupation == "Criminal" or exports.AURgroups:isGroup(localPlayer,occupation,"crim") then

					if rank == false or rank == "" then

						setElementData(localPlayer,"Rank","Petty Criminal")

					end
				elseif occupation == "SWAT Team" or occupation == "Military Forces" then

					if getElementData(localPlayer,"skill") then
						setElementData(localPlayer,"Rank",getElementData(localPlayer,"skill"))
					else
						if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Military Forces" then
							setElementData(localPlayer,"Rank","Military Forces")
						elseif getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "SWAT Team" then
							setElementData(localPlayer,"Rank","SWAT Team")
						end
					end

				else

					if ( rank ~= occupation ) then setElementData( localPlayer, "Rank", occupation ) end

				end



		end

	end, 10000, 0

)

setTimer(function()
	if getPlayerTeam(localPlayer) then
		if exports.DENjob:isFirstLaw(localPlayer) then
			--if getElementData(localPlayer,"Rank") == getElementData(localPlayer,"Occupation") then
				triggerServerEvent("getCustomRank",localPlayer)
			--end
		end
	end
end,60000,0)

addEvent("recRank",true)

addEventHandler("recRank",localPlayer,function(user,rank,gr)

	--[[if gr=="SAPD" then

		SAPDUserToRank[user]=rank

	elseif gr== "Military Forces" then

		militaryUserToRank[user]=rank

	end]]
end)



-- exports



function getPlayerRankInfo()

	local occupation = getElementData( localPlayer, "Occupation" )

	if occupation and occupationToStat[occupation] then

		local stat = exports.DENstats:getPlayerAccountData( localPlayer, occupationToStat[occupation] )

		if stat then

			local theRank = false

			local theRankN

			for i=1,#occupationToRank[occupation] do
				if not ( theRank ) then

					--if occupation == "Police Officer" then

					--	theRank = "(PO)-"..occupationToRank[occupation][i][1]

					--elseif occupation == "Traffic Officer" then

					--	theRank = "(TO)-"..occupationToRank[occupation][i][1]

					---else

						theRank = occupationToRank[occupation][i][1]

					--end
--
					theRankN = i

				elseif ( tonumber(occupationToRank[occupation][i][2]) <= tonumber(stat) ) then

					---if occupation == "Police Officer" then

					---	theRank = "(PO)-"..occupationToRank[occupation][i][1]

					---elseif occupation == "Traffic Officer" then

					---	theRank = "(TO)-"..occupationToRank[occupation][i][1]
--
					---else

						theRank = occupationToRank[occupation][i][1]

					---end

					theRankN = i

				end

			end

			local nextRank, nextRankPoints

			if occupationToRank[occupation][theRankN+1] then

				nextRank, nextRankPoints = occupationToRank[occupation][theRankN+1][1], occupationToRank[occupation][theRankN+1][2]

			end

			return theRank,stat,theRankN, nextRank, nextRankPoints

		end

	end

end



function getPlayerRankTable()

	local occupation = getElementData( localPlayer, "Occupation" )

	if occupation then

		return occupationToRank[occupation]

	end

	return false

end

function getDec(occupation)
	local occu = getElementData(localPlayer,"Occupation")
	desc = ""
	if occu == "Mechanic" then
		desc = "Your job is to repair vehicles owned by other players. You can pick 1 of 3 various skins and 1 of 4 vehicles for easier transportation. You are able to use a tow truck to tow other players vehicles if they run out of gas or bounce off the road.\n\nJob perk: To repair a vehicle press right mouse button near it's doors. Use num_2 and num_8 keys to adjust Towtruck's cable height."

	elseif occu == "Paramedics" then
		desc = "Your job is to heal players with you spray can.\nYou can heal player by simply spray them, with the spray can, every time you heal somebody you earn money for it.\n\nParamedics get access to the Ambulance car. For a emergency accident you can use the medic chopper."

	elseif occu == "Trucker" then
		desc = "Your job is to Go to light green marker to take a trailer then deliver it to assigned destination for your payments. Be a Trucker and deliver goods all over the country with a amazing salary. Can you truck?"

	elseif occu == "Pilot" then
		desc = "Your job is to find Cargo on your radar as Big red blips. Pick up the cargo by entering the red marker then deliver it its destination. Your main job is to deliver goods via air, but you can also provide service to Civilians for transport."

	elseif occu == "Bus driver" then
		desc = "Your job is to spawn a bus or coach. Start a route from your panel using F5. Also view Route management, select your any route in the City and complete all bus stops to be paid. Use the GPS system to help you and the automated voice announcements of each stop."

	elseif occu == "Firefighter" then
		desc = "Your job is to extinguishing fire look for red blips on your map. Go to them and you will be encountered by a big fire! Extinguish the fire by using a fire extinguisher or you can use your fire truck. You will be paid for putting out the fires. People's lives depend on you!"

	elseif occu == "Trash Collector" then
		desc = "Your job is to Keep SF clean , keep moving in SF and collect the trash to get earnings."

	elseif occu == "Farmer" then
		desc = "Your job is to plant and farm seeds (Dont forget to buy seeds), go to the yellow area and tap the mouse2 button once to get the seed plant."

	elseif occu == "Fisherman" then
		desc = "Your job is to get fish and earn money go to sea and catch some fishs!"

	elseif occu == "Lumberjack" then
		desc = "Your job is to travel around and cut down trees for production."

	elseif occu == "Rescuer Man" then
		desc = "Your job is to rescue drown people in the sea, you will get paid for each person you save his life."

	elseif occu == "Colthes Seller" then
		desc = "Your job is clothes seller\nCustomers enter the store and ask for thier item and your job is to select it and sell it to them fast\nSo they don't get bored"

	elseif occu == "Diver" then
		desc = "Your job is to find lost/dropped items and bring them back here\nYou can collect 5 items to get earnings and 15 items max\ntake the job and dive in the water\nCheck blue ped blip on the radar"
	
	elseif occu == "Pizza Boy" then
		desc = "Work as a pizza boy and deliver pizzas. Spawn a pizza delivery scooter and fill up your scooter with pizzas. Then, deliver them to the specified locations within the time frame to receive your payment."
	end
	return desc
end

promotion = {
    staticimage = {},
    label = {},
    button = {},
    window = {},
    memo = {}
}
promotion.window[1] = guiCreateWindow(151, 89, 557, 433, "Aurora ~ Rank information", false)
guiWindowSetSizable(promotion.window[1], false)
guiSetVisible(promotion.window[1],false)
promotion.staticimage[1] = guiCreateStaticImage(35, 26, 491, 124, "logo.png", false, promotion.window[1])
promotion.memo[1] = guiCreateMemo(12, 168, 277, 250, "", false, promotion.window[1])
guiMemoSetReadOnly(promotion.memo[1], true)
promotion.label[1] = guiCreateLabel(314, 169, 80, 22, "Current job:", false, promotion.window[1])
guiSetFont(promotion.label[1], "default-bold-small")
guiLabelSetVerticalAlign(promotion.label[1], "center")
promotion.label[2] = guiCreateLabel(404, 169, 149, 22, "Diver", false, promotion.window[1])
guiSetFont(promotion.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(promotion.label[2], "center", false)
guiLabelSetVerticalAlign(promotion.label[2], "center")
promotion.label[3] = guiCreateLabel(314, 201, 80, 21, "Current rank:", false, promotion.window[1])
guiSetFont(promotion.label[3], "default-bold-small")
guiLabelSetVerticalAlign(promotion.label[3], "center")
promotion.label[4] = guiCreateLabel(404, 201, 149, 22, "L1", false, promotion.window[1])
guiSetFont(promotion.label[4], "default-bold-small")
guiLabelSetHorizontalAlign(promotion.label[4], "center", false)
guiLabelSetVerticalAlign(promotion.label[4], "center")
promotion.label[5] = guiCreateLabel(314, 232, 90, 22, "Current points:", false, promotion.window[1])
guiSetFont(promotion.label[5], "default-bold-small")
guiLabelSetVerticalAlign(promotion.label[5], "center")
promotion.label[6] = guiCreateLabel(404, 232, 149, 22, "0", false, promotion.window[1])
guiSetFont(promotion.label[6], "default-bold-small")
guiLabelSetHorizontalAlign(promotion.label[6], "center", false)
guiLabelSetVerticalAlign(promotion.label[6], "center")
promotion.label[7] = guiCreateLabel(314, 264, 80, 21, "Next rank:", false, promotion.window[1])
guiSetFont(promotion.label[7], "default-bold-small")
guiLabelSetVerticalAlign(promotion.label[7], "center")
promotion.label[8] = guiCreateLabel(404, 264, 149, 22, "L2", false, promotion.window[1])
guiSetFont(promotion.label[8], "default-bold-small")
guiLabelSetHorizontalAlign(promotion.label[8], "center", false)
guiLabelSetVerticalAlign(promotion.label[8], "center")
promotion.label[9] = guiCreateLabel(314, 295, 100, 20, "Next rank points:", false, promotion.window[1])
guiSetFont(promotion.label[9], "default-bold-small")
guiLabelSetVerticalAlign(promotion.label[9], "center")
promotion.label[10] = guiCreateLabel(418, 293, 125, 22, "0", false, promotion.window[1])
guiSetFont(promotion.label[10], "default-bold-small")
guiLabelSetHorizontalAlign(promotion.label[10], "center", false)
guiLabelSetVerticalAlign(promotion.label[10], "center")
promotion.label[11] = guiCreateLabel(314, 325, 100, 20, "Total ranks:", false, promotion.window[1])
guiSetFont(promotion.label[11], "default-bold-small")
guiLabelSetVerticalAlign(promotion.label[11], "center")
promotion.label[12] = guiCreateLabel(408, 323, 149, 22, "7", false, promotion.window[1])
guiSetFont(promotion.label[12], "default-bold-small")
guiLabelSetHorizontalAlign(promotion.label[12], "center", false)
guiLabelSetVerticalAlign(promotion.label[12], "center")
promotion.button[1] = guiCreateButton(354, 378, 126, 30, "Close", false, promotion.window[1])
guiSetProperty(promotion.button[1], "NormalTextColour", "FFFEFEFE")


local screenW,screenH=guiGetScreenSize()

local windowW,windowH=guiGetSize(promotion.window[1],false)

local x,y = (screenW-windowW)/2,(screenH-windowH)/2

guiSetPosition(promotion.window[1],x,y,false)

addEventHandler("onClientGUIClick",promotion.button[1],function()
	if source == promotion.button[1] then
		guiSetVisible(promotion.window[1],false)
		showCursor(false)
	end
end)

function loadInfo()
	local pro = {}
	local theRank,stat,theRankN, nextRank, nextRankPoints = getPlayerRankInfo()
	if not nextRank then nextRank = "Un-Limited" end
	if not nextRankPoints then nextRankPoints = "Un-Limited" end
	de = getDec(getElementData(localPlayer,"Occupation"))
	local delta = getPlayerRankTable()
	local occ = getElementData(localPlayer,"Occupation")
	guiSetText(promotion.label[2],getElementData(localPlayer,"Occupation"))
	if (getElementData(localPlayer,"Occupation") == "Pilot") then 
		guiSetText(promotion.label[5], "Current distance:")
		guiSetText(promotion.label[9], "Required distance:")
	else
		guiSetText(promotion.label[5], "Current points:")
		guiSetText(promotion.label[9], "Next rank points:")
	end 
	guiSetText(promotion.label[4],theRank)
	guiSetText(promotion.label[6],stat)
	guiSetText(promotion.label[8],nextRank)
	guiSetText(promotion.label[10],nextRankPoints)
	guiSetText(promotion.label[12],#delta)
	guiSetText(promotion.memo[1],"")
	guiSetText(promotion.memo[1],"                        Work info\n\n"..de.."\n\n                        Ranks Info")
	for i=1,#occupationToRank[occ] do
		local text = guiGetText(promotion.memo[1])
		pro[i] = "L"..i.."   ("..(occupationToRank[occ][i][1])..")\n Promotion payment ($"..(exports.server:convertNumber(occupationToRank[occ][i][3]))..")\n Worker payment ($"..exports.server:convertNumber(occupationToRank[occ][i][4])..")"
		guiSetText(promotion.memo[1],text.."\n"..pro[i])
	end
	--guiSetText(promotion.memo[1],de.."\n\n\n"..pro[occ])
end

function openPanel()
	if guiGetVisible(promotion.window[1]) then
		guiSetVisible(promotion.window[1],false)
		showCursor(false)
	else
		if getPlayerRankInfo() then
			guiSetVisible(promotion.window[1],true)
			showCursor(true)
			loadInfo()
		end
	end
end

function closePanel()
	if guiGetVisible(promotion.window[1]) then
		guiSetVisible(promotion.window[1],false)
		showCursor(false)
	end
end

