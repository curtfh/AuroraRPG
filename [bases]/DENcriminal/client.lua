
local criminalJobMarkers = {
	[1] = {2531.62, -1666.45, 15.16, 270 },
	[2] = {1407.56, -1300.06, 13.54 },
	[3] = {-2159.34, 654.18, 52.36,305 },
	[4] = {1686.6,1217.83,10.64,260 },
	[5] = {2127.69, 2377.1, 10.82,176 },
	[6] = {2575.17, 489.37, 14.1,90 }, --The Terrorists
	[7] = {914.62, 1446.12, 23.2,183 }, --The Cobras
}

xnxx = {
    tab = {},
    tabpanel = {},
    label = {},
    gridlist = {},
    window = {},
    button = {},
    memo = {}
}

crimJobWindow = guiCreateWindow(121, 138, 537, 384, "AUR ~ Criminals", false)
guiWindowSetSizable(crimJobWindow, false)

xnxx.tabpanel[1] = guiCreateTabPanel(9, 24, 514, 346, false, crimJobWindow)

xnxx.tab[1] = guiCreateTab("Information", xnxx.tabpanel[1])

xnxx.label[1] = guiCreateLabel(158, 13, 177, 40, "Information about this job", false, xnxx.tab[1])
guiSetFont(xnxx.label[1], "default-bold-small")
guiLabelSetColor(xnxx.label[1], 12, 147, 242)
guiLabelSetHorizontalAlign(xnxx.label[1], "center", true)
guiLabelSetVerticalAlign(xnxx.label[1], "center")
crimJobMemo = guiCreateLabel(10, 67, 495, 197, "There are multiple Criminals in AUR, each with a score requirement. To see the multiple criminal classes, go to the criminal job marker and near it is another marker to specialize into another type of criminal.  Criminals earn money through various ways. The following is criminal income(s)	> Los Venturas Turfing. Earn money when you take a turf for your group!	> Capture the Flag and deliver it! > Sell weapons or sell drugs! (/sellweps /selldrugs) > Rob stores! /holdup or /robstore at the cash register! > Destroy the armored truck and prevent it from being delivered! > Rob the casino or rob the bank and more!", false, xnxx.tab[1])
guiSetFont(crimJobMemo, "default-bold-small")
guiLabelSetColor(crimJobMemo, 254, 254, 254)
guiLabelSetHorizontalAlign(crimJobMemo, "center", true)
crimJobCloseScreen2 = guiCreateButton(191, 273, 117, 39, "Close", false, xnxx.tab[1])
guiSetProperty(crimJobCloseScreen2, "NormalTextColour", "FFAAAAAA")

xnxx.tab[2] = guiCreateTab("Employ", xnxx.tabpanel[1])

xnxx.label[3] = guiCreateLabel(5, 10, 207, 40, "Choose job clothes", false, xnxx.tab[2])
guiSetFont(xnxx.label[3], "default-bold-small")
guiLabelSetColor(xnxx.label[3], 12, 147, 242)
guiLabelSetHorizontalAlign(xnxx.label[3], "center", false)
guiLabelSetVerticalAlign(xnxx.label[3], "center")
theJobGrid = guiCreateGridList(22, 55, 180, 250, false, xnxx.tab[2])
guiGridListAddColumn(theJobGrid, "Skins", 0.5)
guiGridListAddColumn(theJobGrid, "ID", 0.5)
crimJobSetJob = guiCreateButton(223, 272, 109, 33, "Take", false, xnxx.tab[2])
guiSetProperty(crimJobSetJob, "NormalTextColour", "FFAAAAAA")
crimJobCloseScreen = guiCreateButton(391, 272, 109, 33, "Close", false, xnxx.tab[2])
guiSetProperty(crimJobCloseScreen, "NormalTextColour", "FFAAAAAA")
xnxx.label[4] = guiCreateLabel(255, 10, 207, 40, "Quick Note:", false, xnxx.tab[2])
guiSetFont(xnxx.label[4], "default-bold-small")
guiLabelSetColor(xnxx.label[4], 12, 147, 242)
guiLabelSetHorizontalAlign(xnxx.label[4], "center", false)
guiLabelSetVerticalAlign(xnxx.label[4], "center")
xnxx.memo[1] = guiCreateMemo(219, 58, 285, 198, "Don't break other players life/n/n Read server rules", false, xnxx.tab[2])
guiMemoSetReadOnly(xnxx.memo[1], true)
--[[
crimJobWindow = guiCreateWindow(730,213,321,362,"NGC ~ Become a Criminal",false)
crimJobMemo = guiCreateMemo(9,44,303,217,"There are multiple Criminals in NGC, each with a score requirement. To see the multiple criminal classes, go to the criminal job marker and near it is another marker to specialize into another type of criminal.  Criminals earn money through various ways. The following is criminal income(s)	> Los Venturas Turfing. Earn money when you take a turf for your group!	> Capture the Flag and deliver it! > Sell weapons or sell drugs! (/sellweps /selldrugs) > Rob stores! /holdup or /robstore at the cash register! > Destroy the armored truck and prevent it from being delivered! > Rob the casino or rob the bank!",false,crimJobWindow)
crimJobLabel = guiCreateLabel(14,22,257,17,"Information about this job:",false,crimJobWindow)
guiSetFont(crimJobLabel,"default-bold-small")
crimJobSetJob = guiCreateButton(12,268,292,36,"Become a Criminal",false,crimJobWindow)
crimJobCloseScreen = guiCreateButton(12,312,295,36,"Close Screen",false,crimJobWindow)
]]
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(crimJobWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(crimJobWindow,x,y,false)

guiWindowSetMovable (crimJobWindow, true)
guiWindowSetSizable (crimJobWindow, false)
guiSetVisible (crimJobWindow, false)


addEventHandler("onClientGUIClick", crimJobCloseScreen,
function()
	guiSetVisible( crimJobWindow, false )
	showCursor( false, false )
end, false
)


addEventHandler("onClientGUIClick", crimJobCloseScreen2,
function()
	guiSetVisible( crimJobWindow, false )
	showCursor( false, false )
end, false
)

addEventHandler("onClientGUIClick", crimJobSetJob,
	function()
		guiSetVisible( crimJobWindow, false )
		showCursor( false, false )

		local oldTeam = getPlayerTeam( localPlayer )
		if ( getTeamName( oldTeam ) ~= "Criminals" ) then
			triggerEvent( "onClientPlayerTeamChange", localPlayer, oldTeam, getTeamFromName ( "Criminals" ) )
		end

		triggerEvent( "onClientPlayerJobChange", localPlayer, "Criminal", getTeamFromName ( "Criminals" ) )
		triggerServerEvent( "enterCriminalJob", localPlayer )
	end, false
)

function crimMarkerHit( hitPlayer, matchingDimension )
	if ( hitPlayer == localPlayer ) then
		if ( matchingDimension ) then
			local px,py,pz = getElementPosition ( hitPlayer )
			local mx, my, mz = getElementPosition ( source )
			if ( hitPlayer == localPlayer ) and ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
				local vehicle = getPedOccupiedVehicle ( localPlayer )
				if not ( vehicle ) then
					guiSetVisible( crimJobWindow, true )
					showCursor( true, true )
					loadSkinsIntoGrid(getElementData(localPlayer, "Group"))
				end
			end
		end
	end
end


function loadSkinsIntoGrid(grp)



    guiGridListClear( theJobGrid )
	local row = guiGridListAddRow ( theJobGrid )
	guiGridListSetItemText ( theJobGrid, row, 1, "Criminal", false, true )
	guiGridListSetItemText ( theJobGrid, row, 2, "0", false, false )
	if (grp == "The Terrorists") then
		local row1 = guiGridListAddRow ( theJobGrid )
		guiGridListSetItemText ( theJobGrid, row1, 1, "Terrorist", false, true )
		guiGridListSetItemText ( theJobGrid, row1, 2, "230", false, false )
	end

end

for ID in pairs( criminalJobMarkers ) do
	local x, y, z = criminalJobMarkers[ID][1], criminalJobMarkers[ID][2], criminalJobMarkers[ID][3]
	crimMarker = createMarker(x,y,z - 1,"cylinder",2.0, 200, 0, 0 ,7)
	if (ID == 7) then
		pedID = 230
	else
		pedID = 0
	end
	local ped = createPed(pedID,x,y,z,criminalJobMarkers[ID][4])
	if (ID == 7) then
		triggerEvent("AURdebranded_players.activateShader", root,"data/t-skin.png", "swmotr5", ped)
	end
	setElementData(ped,"jobPed",true)
	setElementData(ped,"jobName","Criminal")
	setElementData(ped,"jobColor",{255, 0, 0})
	setElementDimension( crimMarker, 0 )
	setElementFrozen(ped,true)
	setElementData(ped,"showModelPed",true,true)
	blips = exports.customblips:createCustomBlip ( x, y, 16, 16, "image.png", 100 )
	addEventHandler("onClientMarkerHit", crimMarker, crimMarkerHit)
end
blips = exports.customblips:createCustomBlip (  1931, 174, 16, 16, "image.png", 100 )
blips = exports.customblips:createCustomBlip (  2172.33,-1498.44, 16, 16, "image.png", 100 )
