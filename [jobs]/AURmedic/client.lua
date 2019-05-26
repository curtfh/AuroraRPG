healVal = 10
healTime = 1000
healTable = {}
medicFarming = {}
medicFarmingTimer = {}
healReward = 70
local scoreCD = {}
function playerHeal ( attacker, weapon, bodypart, loss )
    local health = getElementHealth(source)+loss
	if attacker ~= false and source ~= nil then
		if healTable[source] == nil then
			healTable[source] = false
		end
		if getElementType ( attacker ) == "vehicle" then
		return
		end
		if attacker and getElementType(attacker) == "player" and getPlayerTeam(attacker) then
			if (( getTeamName ( getPlayerTeam ( attacker ) ) == "Paramedics" )) and ( weapon == 41 ) then
				slow = false
				local pro = getElementData(attacker,"isPlayerProtected")
				if pro then healTime = 6000 else healTime = 1000 end
				if not healTable[source] then
					local stat = getPedStat(source,24)
					if stat == 1000 then check = 200 else check = 100 end
					if ( health < check ) and (health > 0 ) then
						if not ( isMedicHealAllowed ( attacker ) ) then
							healTable[source] = true
							setTimer ( timeFix, healTime, 1,source )

							triggerServerEvent ( "healedPlayer", attacker, nil, source, healVal )
							cancelEvent()
						else
							healTable[source] = true
							setTimer ( timeFix, healTime, 1,source )


							triggerServerEvent ( "healedPlayer", attacker, healReward, source, healVal )
							cancelEvent()
						end
					else
						cancelEvent()
					end
				else
					cancelEvent()
				end
			end
			if (getElementData(attacker,"skill") == "Support Unit") and ( weapon == 41 ) then
				if exports.DENlaw:isLaw(attacker) and exports.DENlaw:isLaw(source) then
					slow = false
					local pro = getElementData(attacker,"isPlayerProtected")
					if pro then healTime = 6000 else healTime = 1000 end
					if not healTable[source] then
						local stat = getPedStat(source,24)
						if stat == 1000 then check = 200 else check = 100 end
						if ( health < check ) and (health > 0 ) then
							if not ( isMedicHealAllowed ( attacker ) ) then
								healTable[source] = true
								setTimer ( timeFix, healTime, 1,source )

								triggerServerEvent ( "healedPlayer", attacker, nil, source, healVal )
								cancelEvent()
							else
								healTable[source] = true
								setTimer ( timeFix, healTime, 1,source )


								triggerServerEvent ( "healedPlayer", attacker, healReward, source, healVal )
								cancelEvent()
							end
						else
							cancelEvent()
						end
					else
						cancelEvent()
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, playerHeal )

function timeFix ( player )
	healTable[player] = false
end

function onPlayerDamageByMedic ( attacker, weapon, bodypart, loss )
	if  not ( medicFarming[attacker] ) then
		medicFarming[attacker] = {}
	end

	if ( isElement( attacker ) ) and ( source == localPlayer ) then
		if ( attacker ~= source ) then
		if attacker and getElementType(attacker) == "player" and getPlayerTeam(attacker) then
			if ( getPlayerTeam ( attacker ) ) and ( getTeamName ( getPlayerTeam ( attacker ) ) == "Paramedics" ) and ( weapon == 41 ) then
				return
			else
				table.insert( medicFarming[attacker], source )
				medicFarmingTimer[attacker] = setTimer( removeHealAttack, 60000, 1, attacker, source )
			end
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", root, onPlayerDamageByMedic )

function removeHealAttack ( attacker, victim )
	if ( medicFarming[attacker] ) then
		for i=1,#medicFarming[attacker] do
			if ( medicFarming[attacker][i] == victim ) then
				table.remove( medicFarming[attacker], i )
			end
		end
	end
end

function isMedicHealAllowed ( attacker )
	if ( medicFarming[attacker] ) then
		for i=1,#medicFarming[attacker] do
			if ( medicFarming[attacker][i] == localPlayer ) then
				return false
			end
		end
	end
	return true
end

local rankI = {}
local ranks = {
	{"Medical Student",0,0,"Base Salary"},
	{"Paramedic in Training",25,0,"Base Salary"},
	{"Recruit Paramedic",50,0,"Base Salary"},
	{"Experienced Paramedic",75,0,"Base Salary + 10%"},
	{"Recruit Doctor",100,0,"Base Salary + 20%"},
	{"Experienced Doctor",200,0,"Base Salary + 30%"},
	{"Head Doctor",300,0,"Base Salary + 40%"},
	{"Recruit Surgeon",400,0,"Base Salary + 45%"},
	{"Experienced Surgeon",500,0,"Base Salary + 50%"},
	{"Head Surgeon",600,0,"Base Salary + 55%"},
	{"CSG Medical Head",700,0,"Base Salary + 60%"},
	{"CSG Medical CEO",800,0,"Base Salary + 65%"},

}

-- Medic panel
medicPanelWindow = guiCreateWindow(409,182,441,459,"AUR ~ Medic Panel",false)
medicPanelGrid = guiCreateGridList(9,23,423,249,false,medicPanelWindow)
guiGridListSetSelectionMode(medicPanelGrid,0)

local column1 = guiGridListAddColumn(medicPanelGrid," Playername:",0.45)
local column2 = guiGridListAddColumn(medicPanelGrid,"Health:",0.1)
local column3 = guiGridListAddColumn(medicPanelGrid,"Location:",0.4)

medicPanelButton1 = guiCreateButton(10,277,134,33,"Mark player",false,medicPanelWindow)
medicPanelButton2 = guiCreateButton(148,277,137,33,"Mark all players",false,medicPanelWindow)
medicPanelButton3 = guiCreateButton(290,277,141,33,"Delete blips",false,medicPanelWindow)

medicPanelRadio1 = guiCreateRadioButton(14,320,361,22,"Show all injured players",false,medicPanelWindow)
medicPanelRadio2 = guiCreateRadioButton(14,346,361,22,"Show only players with less then 80% health",false,medicPanelWindow)
medicPanelRadio3 = guiCreateRadioButton(14,372,361,22,"Show only players with less then 60% health",false,medicPanelWindow)
medicPanelRadio4 = guiCreateRadioButton(14,398,361,22,"Show only players with less then 40% health",false,medicPanelWindow)
medicPanelRadio5 = guiCreateRadioButton(14,424,361,22,"Show only players with less then 20% health",false,medicPanelWindow)

btnStats = guiCreateButton(290, 325, 141, 33, "Stats", false, medicPanelWindow)
btnRanks = guiCreateButton(290, 368, 141, 33, "Ranks", false, medicPanelWindow)
btnHelp = guiCreateButton(290, 416, 141, 33, "Help / Info", false, medicPanelWindow)

GUIEditor = {
    gridlist = {},
    button = {},
    label = {},
}
winStats = guiCreateWindow(165, 105, 477, 304, "AUR ~ Paramedic Stats", false)
guiWindowSetSizable(winStats, false)

listStats = guiCreateGridList(9, 22, 459, 246, false, winStats)
guiGridListAddColumn(listStats, "Stat", 0.5)
guiGridListAddColumn(listStats, "Value", 0.1)
guiGridListAddColumn(listStats, "Rank Value", 0.1)
guiGridListAddColumn(listStats, "Total Rank Value", 0.2)
lblTotalRankPoints = guiCreateLabel(7, 273, 138, 19, "Total Rank Points: ", false, winStats)
btnExitStats = guiCreateButton(249, 272, 219, 23, "Hide / Exit", false, winStats)


GUIEditor = {
    label = {},
}
winRanks = guiCreateWindow(165, 105, 477, 304, "AUR ~ Paramedic Ranks", false)
guiWindowSetSizable(winRanks, false)

listRanks = guiCreateGridList(9, 22, 459, 246, false, winRanks)
guiGridListAddColumn(listRanks, "Rank", 0.4)
guiGridListAddColumn(listRanks, "Points Needed", 0.1)
guiGridListAddColumn(listRanks, "Net Value", 0.1)
guiGridListAddColumn(listRanks, "Benifits", 0.4)
lblRank = guiCreateLabel(10, 275, 201, 19, "Rank:", false, winRanks)
btnExitRanks = guiCreateButton(249, 272, 219, 23, "Hide / Exit", false, winRanks)


guiRadioButtonSetSelected(medicPanelRadio1,true)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(medicPanelWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(medicPanelWindow,x,y,false)

guiWindowSetMovable (medicPanelWindow, true)
guiWindowSetSizable (medicPanelWindow, false)
guiSetVisible (medicPanelWindow, false)
guiSetVisible(winRanks,false)
guiSetVisible(winStats,false)

addEventHandler("onClientGUIClick",root,function()
	if source == btnStats then
		if guiGetVisible(winStats) then
			guiSetVisible(winStats,false)
		else
			guiSetVisible(winStats,true)
		end
	elseif source == btnRanks then
		if guiGetVisible(winRanks) then
			guiSetVisible(winRanks,false)
		else
			guiSetVisible(winRanks,true)
		end
	elseif source == btnExitRanks then
		guiSetVisible(winRanks,false)
		if not(guiGetVisible(medicPanelWindow)) and not(guiGetVisible(winStats)) then
			showCursor(false)
		end
	elseif source == btnExitStats then
		guiSetVisible(winStats,false)
		if not(guiGetVisible(medicPanelWindow)) and not(guiGetVisible(winRanks)) then
			showCursor(false)
		end
	elseif source == btnHelp then
		exports.NGCdxmsg:createNewDxMessage("Please refer to F1 for help",255,255,0)
	end
end)

function showMedicPanel ()
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) and (getTeamName(getPlayerTeam(localPlayer)) == "Paramedics") then
		if guiGetVisible(medicPanelWindow) then
			guiSetVisible(medicPanelWindow, false)
			guiSetVisible(winStats,false)
			guiSetVisible(winRanks,false)
			showCursor(false,false)
		else
			updateStatsAndRanks(false)
			guiSetVisible(medicPanelWindow,true)
			loadInjuredPlayers()
			showCursor(true,true)
		end
	end
end
bindKey ( "F5", "down", showMedicPanel )

function onUserChangedMedicPanelSetting ()
	if ( source == medicPanelRadio1 ) or ( source == medicPanelRadio2 ) or ( source == medicPanelRadio3 ) or ( source == medicPanelRadio4 ) or ( source == medicPanelRadio5 ) then
		loadInjuredPlayers()
	end
end
addEventHandler ( "onClientGUIClick", root, onUserChangedMedicPanelSetting )

local doAutoUpdateBlips = false

setTimer ( function ()
	if ( doAutoUpdateBlips ) then
		onMarkAllPlayers()
	end
end, 10000, 0)

function onMarkSelectedPlayer ()
	local thePlayer = guiGridListGetItemText ( medicPanelGrid, guiGridListGetSelectedItem ( medicPanelGrid ), 1 )
	if thePlayer == "" or thePlayer == " " then
		outputChatBox("You didn't select a player!", 225 ,0 ,0)
	else
		if ( isElement( getPlayerFromName(thePlayer ) ) ) then
			local attachedElements = getAttachedElements ( getPlayerFromName(thePlayer) )
			if ( attachedElements ) then
				for ElementKey, ElementValue in ipairs ( attachedElements ) do
					if ( getElementType ( ElementValue ) == "blip" ) then
						if ( getBlipIcon ( ElementValue ) == 22 ) then
							return
						end
					end
				end
			end
			local theBlip = createBlipAttachedTo ( getPlayerFromName(thePlayer), 22 )
		end
	end
end
addEventHandler("onClientGUIClick", medicPanelButton1, onMarkSelectedPlayer, false)

function onMarkAllPlayers ()
	local healthSetting = 100
	if ( guiRadioButtonGetSelected( medicPanelRadio1 ) ) then healthSetting = 100 end
	if ( guiRadioButtonGetSelected( medicPanelRadio2 ) ) then healthSetting = 80  end
	if ( guiRadioButtonGetSelected( medicPanelRadio3 ) ) then healthSetting = 60  end
	if ( guiRadioButtonGetSelected( medicPanelRadio4 ) ) then healthSetting = 40  end
	if ( guiRadioButtonGetSelected( medicPanelRadio5 ) ) then healthSetting = 20  end

	onRemoveAllBlips()

	for id, player in ipairs(getElementsByType("player")) do
		if ( getElementHealth( player ) < tonumber(healthSetting) ) then
			if not ( player == localPlayer ) then
				local theBlip = createBlipAttachedTo ( player, 22 )
				doAutoUpdateBlips = true
			end
		end
	end
end
addEventHandler("onClientGUIClick", medicPanelButton2, onMarkAllPlayers, false)

function onRemoveAllBlips ()
	for id, player in ipairs(getElementsByType("player")) do
		local attachedElements = getAttachedElements ( player )
		if ( attachedElements ) then
			for ElementKey, ElementValue in ipairs ( attachedElements ) do
				if ( getElementType ( ElementValue ) == "blip" ) then
					if ( getBlipIcon ( ElementValue ) == 22 ) then
						destroyElement( ElementValue )
						doAutoUpdateBlips = false
					end
				end
			end
		end
	end
end
addEventHandler("onClientGUIClick", medicPanelButton3, onRemoveAllBlips, false)

function loadInjuredPlayers()
	local healthSetting = 100
	if ( guiRadioButtonGetSelected( medicPanelRadio1 ) ) then healthSetting = 100 end
	if ( guiRadioButtonGetSelected( medicPanelRadio2 ) ) then healthSetting = 80  end
	if ( guiRadioButtonGetSelected( medicPanelRadio3 ) ) then healthSetting = 60  end
	if ( guiRadioButtonGetSelected( medicPanelRadio4 ) ) then healthSetting = 40  end
	if ( guiRadioButtonGetSelected( medicPanelRadio5 ) ) then healthSetting = 20  end

	local playersFound = false

	guiGridListClear ( medicPanelGrid )
	for id, player in ipairs(getElementsByType("player")) do
		if ( getElementHealth( player ) < tonumber(healthSetting) ) then
			if not ( player == localPlayer ) then
				playersFound = true
				local row = guiGridListAddRow ( medicPanelGrid )
				local x, y, z = getElementPosition ( player )
				guiGridListSetItemText ( medicPanelGrid, row, 1, getPlayerName ( player ), false, false )
				guiGridListSetItemText ( medicPanelGrid, row, 2, "  "..math.floor(getElementHealth ( player )).."%", false, false )
				guiGridListSetItemText ( medicPanelGrid, row, 3, "  "..getZoneName ( x, y, z ).." ("..exports.server:getPlayChatZone()..")", false, false )

				if ( math.floor(getElementHealth ( player ) ) < 30 ) then
					guiGridListSetItemColor ( medicPanelGrid, row, 2, 225, 0, 0 )
				elseif ( math.floor(getElementHealth ( player ) ) > 29 ) and  ( math.floor(getElementHealth ( player ) ) < 70 ) then
					guiGridListSetItemColor ( medicPanelGrid, row, 2, 225, 165, 0 )
				else
					guiGridListSetItemColor ( medicPanelGrid, row, 2, 0, 225, 0 )
				end
			end
		end
	end
	if not ( playersFound ) then
		local row = guiGridListAddRow ( medicPanelGrid )
		guiGridListSetItemText ( medicPanelGrid, row, 1, "No players found", false, false )
		guiGridListSetItemText ( medicPanelGrid, row, 2, "  N/A", false, false )
		guiGridListSetItemText ( medicPanelGrid, row, 3, "  N/A", false, false )
	end
end

addEvent( "onClientPlayerTeamChange" )
addEventHandler ( "onClientPlayerTeamChange", root,
function ()
	if ( source == localPlayer ) then
		onRemoveAllBlips ()
	end
end
)

local databaseStats = {}
function updateStatsAndRanks()
	updateStatsMenu()
	updateRanksMenu()
end

addEvent( "onPlayerRankChange" )
addEventHandler( "onPlayerRankChange", root,
	function ( oldRank, newRank )
		updateStatsAndRanks(false)
	end
)

local attemped = false
function CSGmedicRecData()
	t = exports.DENstats:getPlayerAccountData(localPlayer,"paramedic2")
	if t then
	t = fromJSON(t)
	if t == nil then
		if attemped == false then
			setTimer(function() CSGmedicRecData() end,4000,1)
			attemped=true
			return
		end
		t = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0,0,0,0,0}
		for i=1,10 do t[i]=0 end
		databaseStats=t
		triggerServerEvent("CSGmedic.setDefault",localPlayer)
	end
	databaseStats=t
	for i=1,10 do
		if (databaseStats[i]) == nil then databaseStats[i]=0 end
	end
	end
end
addEvent("CSGmedicRecData",true)
addEventHandler("CSGmedicRecData",localPlayer,CSGmedicRecData)

 local nameToI = {
	["Healed Health"] = 1,
	["Score earned from healing"] = "healedscore",
	["Death on Job"] = 3,
	["Unique person heals"] = 4,
	["Poor person healing incidents"] = 5,
	["Money earned from healing"] = 6,
	["Money earned from daily pay"] = 7,
}

function addStat(k,v)
	if databaseStats[tostring(nameToI[k])] then
		databaseStats[tostring(nameToI[k])] = databaseStats[tostring(nameToI[k])]+v
	end
	updateStatsMenu()
	databaseStats["rankPTS"]=totalRankPoints
	triggerServerEvent("CSGmedicSetStat",localPlayer,toJSON(databaseStats))
end
addEvent("CSGmedicAddStat",true)
addEventHandler("CSGmedicAddStat",localPlayer,addStat)

function updateStatsMenu()
	guiGridListClear(listStats)
	stats = {
		["Healed Health"] = {databaseStats[tostring(nameToI["Healed Health"])],0,0},
		["Score earned from healing"] = {databaseStats[tostring(nameToI["Score earned from healing"])],3,0},
		["Death on Job"] = {databaseStats[tostring(nameToI["Death on Job"])],0,0},
		["Unique person heals"] = {databaseStats[tostring(nameToI["Unique person heals"])],0,0},
		["Poor person healing incidents"] = {databaseStats[tostring(nameToI["Poor person healing incidents"])],0,0},
		["Money earned from healing"] = {databaseStats[tostring(nameToI["Money earned from healing"])],0,0},
		["Money earned from daily pay"] = {databaseStats[tostring(nameToI["Money earned from daily pay"])],0,0},
	}
	totalRankPoints = 0
	totalPoints = 0
	for k,v in pairs(stats) do
	if v then
	if tonumber(v[1]) and tonumber(v[2]) then
		local ptsToAdd = (tonumber(v[1])*tonumber(v[2]))
		totalRankPoints=totalRankPoints+ptsToAdd
		stats[k][3] = ptsToAdd
		totalPoints=totalPoints+tonumber(v[1])
		local row = guiGridListAddRow(listStats)
		guiGridListSetItemText(listStats, row, 1, ""..tostring(k).."", false, false )
		guiGridListSetItemText(listStats, row, 2, ""..stats[k][1].."", false, false )
		guiGridListSetItemText(listStats, row, 3, ""..stats[k][2].."", false, false )
		guiGridListSetItemText(listStats, row, 4, ""..stats[k][3].."", false, false )
		if v[2] > 0 then
			for i=1,4 do
				guiGridListSetItemColor(listStats,row,i,0,255,0)
			end
		end
	end
	end
	end
	--guiSetText(gui["lblTotalPoints"],"Total Points: "..totalPoints.."")
	guiSetText(lblTotalRankPoints,"Total Rank Points: "..totalRankPoints.."")
end

local first = true

function updateRanksMenu()
	guiGridListClear(listRanks)
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
	guiSetText(lblRank,"Rank: "..currentRank.."")
	for k,v in pairs(ranks) do
		local row = guiGridListAddRow(listRanks)
		guiGridListSetItemText(listRanks, row, 1, tostring(v[1]), false, false )
		guiGridListSetItemText(listRanks, row, 2, tostring(v[2]), false, false )
		guiGridListSetItemText(listRanks, row, 3, tostring(v[3]), false, false )
		guiGridListSetItemText(listRanks, row, 4, tostring(v[4]), false, false )
		if v[1] == currentRank then
			for i=1,4 do
				guiGridListSetItemColor(listRanks,row,i,0,255,0)
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


local missions = {
{1368.18, -1508.79, 13.54},
{1638.7, -1663.69, 13.57},
{1630.65, -1509.49, 13.59},
{1968.94, -1600.36, 13.55},
{1992.35, -1786.01, 13.55},
{1688.35, -1956.79, 8.25},
{720.11, -1482.76, 1.96},
{731.01, -1155.91, 16.54},
{2465.43, -1740.69, 13.54},
{2751.33, -1434.39, 30.45},
{2532.32, -1034.66, 69.58},
{2281.86, -1107.44, 37.97},
{1588.92, -2205.58, 13.55},
{1837.72, -2107.42, 13.54},
{2101.28, -1923.78, 13.54},
{2235.58, -1263.28, 23.93},
{2068.43, -1743.08, 13.54},
{2110.75, -2125.19, 13.63},
{2773.32, -2485.25, 13.64},
{2652.52, -1610.17, 10.87},
}

function startMedicMission ()
	
	local randomid = math.random(1,#missions)
	medicMarker = createMarker (missions[randomid][1], missions[randomid][2], missions[randomid][3], "cylinder", 2, 255,255,255,0)
	medicPed = createPed (math.random(2,216), missions[randomid][1], missions[randomid][2], missions[randomid][3])
	setPedAnimation (medicPed, "wuzi", "cs_dead_guy")
	medicBlip = createBlipAttachedTo(medicMarker, 22)
	exports.NGCdxmsg:createNewDxMessage("An injured person is calling for the emergency services, head to the red '+' blip to heal him!",255,255,0)

end
addEvent("AURmedic.startMission", true)
addEventHandler("AURmedic.startMission", root, startMedicMission)

function stopMedicMission ()

	if (isElement(medicMarker)) then
		destroyElement(medicBlip)
		destroyElement(medicMarker)
		medicBlip = nil
		medicMarker = nil
		destroyElement(medicPed)
		medicPed = nil
	end
end
addEvent("AURmedic.stopMission", true)
addEventHandler("AURmedic.stopMission", root, stopMedicMission)


function missionHandler (hitElement, matchingDim)

	if not (matchingDim) then return false end
	if (hitElement ~= localPlayer) then return false end
	if (source ~= medicMarker) then return false end
	setElementFrozen(hitElement, true)
	setPedAnimation (hitElement, "medic", "cpr")
	setTimer(setElementFrozen,6500,1,hitElement, false)
	setTimer(setPedAnimation, 6500, 1, hitElement, false)
	setTimer(stopMedicMission,6500,1)
	setTimer(startMedicMission,6500,1)
	triggerServerEvent("AURmedic.pay", resourceRoot, hitElement)
end
addEventHandler("onClientMarkerHit", root, missionHandler)

function onDataChange (dataName, oldValue)

	if (dataName == "Occupation") and (oldValue == "Paramedic") and (getElementData(localPlayer, "Occupation") ~= "Paramedic") then
		stopMedicMission()
	end
end
addEventHandler("onClientElementDataChange", localPlayer, onDataChange)