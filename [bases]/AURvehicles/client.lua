
GUIEditor = {
    label = {}
}
vehiclesWindow = guiCreateWindow(102, 133, 539, 330, "Aurora ~ Vehicles", false)
guiWindowSetSizable(vehiclesWindow, false)

vehiclesGrid = guiCreateGridList(10, 27, 356, 289, false, vehiclesWindow)
vehicleName = guiGridListAddColumn(vehiclesGrid, " Vehiclename:", 0.4)
vehicleMaxV = guiGridListAddColumn(vehiclesGrid, "Speed", 0.1)
vehicleMaxP = guiGridListAddColumn(vehiclesGrid, "Seats", 0.1)
spawnVehicleSystemButton = guiCreateButton(383, 66, 146, 33, "Spawn Vehicle", false, vehiclesWindow)
guiSetProperty(spawnVehicleSystemButton, "NormalTextColour", "FF3AEE10")
closeWindowButton = guiCreateButton(383, 286, 146, 30, "Close Window", false, vehiclesWindow)
guiSetProperty(closeWindowButton, "NormalTextColour", "FFFEFEFE")
GUIEditor.label[1] = guiCreateLabel(383, 31, 146, 25, "Options", false, vehiclesWindow)
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)

guiGridListSetSortingEnabled ( vehiclesGrid, true )
guiSetProperty(vehiclesGrid,"SortEnabled","False")
guiSetProperty(vehiclesGrid,"SortList","False")
guiSetProperty(vehiclesGrid,"SortSettingEnabled","False")
guiSetProperty(vehiclesGrid,"SortMode","Ascending")

addEventHandler("onClientGUIClick", closeWindowButton, function() guiSetVisible(vehiclesWindow, false) showCursor( false, false ) guiGridListClear ( vehiclesGrid ) end, false)

setTimer(function()
	if getElementDimension(localPlayer) ~= 0 then
		guiSetVisible(vehiclesWindow, false) showCursor( false, false ) guiGridListClear ( vehiclesGrid )
	end
	if getElementHealth(localPlayer) < 1 then
		guiSetVisible(vehiclesWindow, false)
		showCursor( false, false )
		guiGridListClear ( vehiclesGrid )
	end
end,500,0)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(vehiclesWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(vehiclesWindow,x,y,false)

guiWindowSetMovable (vehiclesWindow, true)
guiWindowSetSizable (vehiclesWindow, false)
guiSetVisible (vehiclesWindow, false)

local pilotJobVehicles = {
[593] = {"Dodo", 6, 1, 1, 1},		-- LOW Cargo
[513] = {"Stuntplane", 6, 1, 1, 1},	-- LOW Cargo
[511] = {"Beagle", 6, 1, 1, 1},		-- MEDIUM Cargo
[563] = {"Raindance", 6, 1, 1, 1},	-- MEDIUM Cargo
[487] = {"Maverick", 6, 1, 1, 1},	-- MEDIUM Cargo
[553] = {"Nevada", 6, 1, 1, 1},		-- LARGE Cargo
[519] = {"Shamal", 6, 1, 1, 1},		-- MEDIUM Cargo
[592] = {"Andromada", 6, 1, 1, 1},	-- Large Cargo
}
---L1 Stuntplane Dodo,L2 Beagle,L3 Raindance,L4 Maverick,L5 Shamal, L6 Nevada , L7 Andromada
--[[local allPilotJobVehicles = {
[511] = {"Beagle", 6, 1, 1, 1},
[593] = {"Dodo", 6, 1, 1, 1},
[417] = {"Leviathan", 6, 1, 1, 1},
[519] = {"Shamal", 6, 1, 1, 1},
[553] = {"Nevada", 6, 1, 1, 1},
[487] = {"Maverick", 6, 1, 1, 1},
[513] = {"Stuntplane", 6, 1, 1, 1},
[583] = {"Tug",6,1,1,1},
}]]

local pilotTug = {
[583] = {"Tug",6,1,1,1},
}

local criminalJobVehicles = {
[468] = {"Sanchez", 0, 0, 1, 1},
[466] = {"Glendale", 0, 0, 1, 1},
[580] = {"Stafford", 0, 0, 1, 1},
[566] = {"Tahoma", 0, 0, 1, 1},
}

local copLV = {
[596] = {"Police Car (LS)", 0, 1, 1, 1},
[597] = {"Police Car (SF)", 0, 1, 1, 1},
[598] = {"Police Car (LV)", 0, 1, 1, 1},
[523] = {"HPV1000", 0, 1, 1, 1},
--[497] = {"Police Maverick", 0, 1, 1, 1},
[426] = {"Premier", 23, 1, 1, 1}
}

local pMav = {
[497] = {"Police Maverick", 0,1,1,1,r=54,g=100,b=200,r2=255,g2=255,b2=255},
}


local FarmerVehicles = {
[532] = {"Combine Harvester",131,131,131,131,r=255,g=255,b=0,r2=255,g2=255,b2=255},
}

local sapdGroupVehicles = {
[596] = {"Police Car (Los Santos)", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[597] = {"Police Car (San Fierro)", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[598] = {"Police Car (Las Venturas)", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[427] = {"Enforcer", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[490] = {"FBI Rancher",131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[560] = {"Sultan",131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[411] = {"Infernus",131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[451] = {"Turismo",131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[523] = {"HPV1000", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[415] = {"Cheetah", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[426] = {"Premier", 131,131,131,131,r=100,g=100,b=100,r2=255,g2=255,b2=255},
[601] = {"S.W.A.T.",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},
}
local sapdGroupVehiclesGIGN = {
[596] = {"Police Car (Los Santos)", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[597] = {"Police Car (San Fierro)", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[598] = {"Police Car (Las Venturas)", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[427] = {"Enforcer", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[490] = {"FBI Rancher",131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[560] = {"Sultan",131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[411] = {"Infernus",131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[451] = {"Turismo",131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[523] = {"HPV1000", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[415] = {"Cheetah", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[426] = {"Premier", 131,131,131,131,r=0,g=0,b=140,r2=255,g2=255,b2=255},
[601] = {"S.W.A.T.",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},
}
local SSGGroupVehicles = {
[596] = {"Police Car (Los Santos)", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[597] = {"Police Car (San Fierro)", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[598] = {"Police Car (Las Venturas)", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[427] = {"Enforcer", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[490] = {"FBI Rancher",131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[560] = {"Sultan",131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[411] = {"Infernus",131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[451] = {"Turismo",131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[523] = {"HPV1000", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[415] = {"Cheetah", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[426] = {"Premier", 131,131,131,131,r=0,g=50,b=120,r2=255,g2=255,b2=255},
[601] = {"S.W.A.T.",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},
}


local militaryVehicles_Cars = {
[470] = {"Patriot", 44, 44, 44, 44},
[433] = {"Barracks", 44, 44, 44, 44},
[428] = {"Securicar", 44, 44, 44, 44},
[426] = {"Premier", 44, 44, 44, 44},
[500] = {"Mesa", 44, 44, 44, 44},
[579] = {"Huntley", 44, 44, 44, 44},
[598] = {"Police Car (LV)", 44, 44, 44, 44},
[490] = {"FBI Rancher", 44, 44, 44, 44},
[599] = {"Police Ranger", 44, 44, 44, 44},
[415] = {"Cheetah", 44, 44, 44, 44},
[468] = {"Sanchez", 44, 44, 44, 44},
[522] = {"NRG-500",44, 44, 44, 44},
[411] = {"Infernus",44, 44, 44, 44},
[416] = {"Ambulance",44, 44, 44, 44},
[431] = {"Bus",44, 44, 44, 44},
[432] = {"Rhino",44, 44, 44, 44},
}

local medicJobVehicles = {
[416] = {"Ambulance", 1, 3, 0, 0}
}

local freeVehicles2 = {
[462] = {"Faggio", 1, 1, 0, 0}
}

local freeVehicles = {
[481] = {"BMX", 1, 1, 0, 0},
[510] = {"Mountain Bike", 1, 1, 0, 0},
[509] = {"Bike", 1, 1, 0, 0},
[462] = {"Faggio", 1, 1, 0, 0}
}

local freeBoat = {
    [473] = {"Dinghy",1,1,0,0},
}

local mechanicJobVehicles = {
[554] = {"Yosemite", 0, 6, 0, 0},
[525] = {"Towtruck", 0, 6, 0, 0},
[422] = {"Bobcat", 0, 6, 0, 0},
[589] = {"Club", 6, 6, 0, 0}
}

local minerVehs = {
[572] = {"Mower", 0, 0, 0, 0},
}


local delieveryMan = {
[440] = {"Rumpo", 0, 6, 0, 0},
[413] = {"Delivery Van", 0, 6, 0, 0},
}

local policeJobVehicles = {
[523] = {"HPV1000", 106, 1, 1, 1},
[596] = {"Police Car (LS)", 106, 1, 1, 1},
[597] = {"Police Car (SF)", 106, 1, 1, 1},
[598] = {"Police Car (LV)", 106, 1, 1, 1},
[599] = {"Police Ranger", 106, 1, 1, 1},
[559] = {"Jester", 106, 1, 1, 1}
}

local fireFighterVehicles = {
[407] = {"Fire Truck",3,1,1,1},
[544] = {"Fire Truck (Ladder)",3,1,1,1}
}


local trashCollectorJobVehicles = {
[408] = {"Trash Collector",0,6,0,0},
}

local truckerJobVehicles = {
[403] = {"Linerunner", 0, 6, 0, 0},
[514] = {"Tanker", 0, 6, 0, 0},
[515] = {"Roadtrain", 0, 6, 0, 0},
}
--403 Linerunner, 415 tanker, 515 Roadtrain
local streetcleanVehicles = {
[574] = {"Sweeper", 0, 6, 0, 0},
}

local electricanVehicles = {
[552] = {"Utility Van", 0, 6, 0, 0},
}

local crimBaseVehicles = {
[500] = {"Mesa", 0, 0, 0, 0},
[468] = {"Sanchez", 0, 0, 0, 0},
[426] = {"Premier", 0, 0, 0, 0},
[415] = {"Cheetah", 0, 0, 0, 0},
[457] = {"Caddy", 0, 0, 0, 0},
}

local limoveh = {
 [409] = {"Stretch",131,131,131,131,r=255,g=255,b=255,r2=255,g2=255,b2=255},
  }

local rescveh = {
 [472] = {"Coastguard",131,131,131,131,r=255,g=255,b=255,r2=255,g2=255,b2=255},
 }

local SG = {
 [596] = {"Police Car (LS)",0,6,0,0,r=255,g=255,b=255,r2=255,g2=255,b2=255},
 }


local TO = {
[596] = {"Police Car (LS)",0,6,0,0,r=0,g=100,b=200,r2=255,g2=255,b2=255},
[523] = {"HPV1000",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},
 }


local CC = {
[489] = {"Rancher",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[554] = {"Yosemite",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[599] = {"Police Ranger",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},
[523] = {"HPV1000",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},
 }


local PO = {
[596] = {"Police Car (LS)",0,6,0,0,r=0,g=100,b=200,r2=255,g2=255,b2=255},
[597] = {"Police Car (SF)",0,6,0,0,r=0,g=100,b=200,r2=255,g2=255,b2=255},
[598] = {"Police Car (LV)",0,6,0,0,r=0,g=100,b=200,r2=255,g2=255,b2=255},
[426] = {"Premier",0,6,0,0,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[523] = {"HPV1000",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},

 }


local PD = {
 [405] = {"Sentinel",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [415] = {"Cheetah",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [559] = {"Jester",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [579] = {"Huntley",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 }


local CIA = {
 [405] = {"Sentinel",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [415] = {"Cheetah",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [559] = {"Jester",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [402] = {"Buffalo",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 [579] = {"Huntley",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
 }
--- and maverick

local maverick = {
[497] = {"Police Helicopter",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
}

local maverickmf = {
[497] = {"Police Helicopter",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[425] = {"Hunter",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
}

local maverickswat = {
[497] = {"Police Helicopter",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[447] = {"Seasparrow",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
}

local FBI = {
[596] = {"Police Car (LS)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[597] = {"Police Car (SF)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[598] = {"Police Car (LV)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[599] = {"Police Ranger",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[402] = {"Buffalo",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[579] = {"Huntley",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[541] = {"Bullet",131,131,131,131,r=100,g=100,b=100,r2=33,g2=33,b2=33},
[490] = {"FBI Rancher",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[528] = {"FBI Truck",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[523] = {"HPV1000",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},

 }


--- and mavrick
local SO = {
[596] = {"Police Car (LS)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[597] = {"Police Car (SF)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[598] = {"Police Car (LV)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[599] = {"Police Ranger",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[402] = {"Buffalo",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[579] = {"Huntley",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[427] = {"Enforcer",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[451] = {"Turismo",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[523] = {"HPV1000",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},

 }
--- maverick, raindance

local TA = {
[596] = {"Police Car (LS)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[597] = {"Police Car (SF)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[598] = {"Police Car (LV)",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[427] = {"Enforcer",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[599] = {"Police Ranger",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[490] = {"FBI Rancher",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[528] = {"FBI Truck",131,131,131,131,r=65,g=105,b=225,r2=100,g2=100,b2=100},
[402] = {"Buffalo",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[579] = {"Huntley",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[451] = {"Turismo",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[541] = {"Bullet",131,131,131,131,r=100,g=100,b=100,r2=33,g2=33,b2=33},
[405] = {"Sentinel",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[415] = {"Cheetah",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[559] = {"Jester",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[489] = {"Rancher",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[554] = {"Yosemite",131,131,131,131,r=100,g=100,b=100,r2=100,g2=100,b2=100},
[523] = {"HPV1000",131,131,131,131,r=0,g=100,b=200,r2=255,g2=255,b2=255},

 }

local FishermanVehs = {
    [453] = {"Reefer",1,1,1,1},
}

local newsVehicles = {
    [582] = {"News Van",0,6,0,0},
    [488] = {"News Chopper",0,6,0,0},
}

local minerVehicles = {
    [486] = {"Dozer",0,6,0,0},
    [468] = {"Sanchez",0,6,0,0},
}

local postmanVehicles = {
    [462] = {"Faggio",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
    [499] = {"Benson",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local fuelTankers = {
    [514] = {"Tanker",0,6,0,0},
}

local taxiVehs = {
    [420] = {"Taxi",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
    [438] = {"Taxi Cab",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local mailVehs = {
    [462] = {"Faggio",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local pizzaVehs = {
    [448] = {"Pizza Bike",0,6,0,0,r=255,g=255,b=0,r2=255,g2=255,b2=0},
}

local foodVehs = {
    [423] = {"Ice-Cream Truck",0,6,0,0},
}

local abagVehs = {
    [485] = {"Baggage",1,1,1,1},
 }

local lumber = {
    [578] = {"DFT-30",0,0,0,0},
}

local pizzaboy = {
    [448] = {"Pizzaboy",0,0,0,0},
}


local vehicleMarkers = {
-- taken from other one

-- GOV
{1557.28, -1607.42, 13.38, 100, 100, 100, SG, "Government", "Junior Officer", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, SG, "Government", "Junior Officer", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, SG, "Government", "Junior Officer", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, SG, "Government", "Junior Officer", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, SG, "Government", "Junior Officer", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, SG, "Government", "Junior Officer", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, SG, "Government", "Junior Officer", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, SG, "Government", "Junior Officer", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, SG, "Government", "Junior Officer", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, SG, "Government", "Junior Officer", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, SG, "Government", "Junior Officer", 90.19775390625},
{2315.62, 2460.36, 3.27, 100, 100, 100, SG, "Government", "Junior Officer", 90.70037841796875},
{-224.38, 995.57, 19.57, 100, 100, 100, SG, "Government", "Junior Officer", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, SG, "Government", "Junior Officer", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, SG, "Government", "Junior Officer", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, SG, "Government", "Junior Officer", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "Junior Officer", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "Junior Officer", 270},


{1557.28, -1607.42, 13.38, 100, 100, 100, TO, "Government", "Traffic Officer", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, TO, "Government", "Traffic Officer", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, TO, "Government", "Traffic Officer", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, TO, "Government", "Traffic Officer", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, TO, "Government", "Traffic Officer", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, TO, "Government", "Traffic Officer", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, TO, "Government", "Traffic Officer", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, TO, "Government", "Traffic Officer", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, TO, "Government", "Traffic Officer", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, TO, "Government", "Traffic Officer", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, TO, "Government", "Traffic Officer", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, TO, "Government", "Traffic Officer", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, TO, "Government", "Traffic Officer", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, TO, "Government", "Traffic Officer", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, TO, "Government", "Traffic Officer", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, TO, "Government", "Traffic Officer", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "Traffic Officer", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "Traffic Officer", 270},


{1557.28, -1607.42, 13.38, 100, 100, 100, CC, "Government", "County Chief", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, CC, "Government", "County Chief", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, CC, "Government", "County Chief", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, CC, "Government", "County Chief", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, CC, "Government", "County Chief", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, CC, "Government", "County Chief", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, CC, "Government", "County Chief", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, CC, "Government", "County Chief", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, CC, "Government", "County Chief", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, CC, "Government", "County Chief", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, CC, "Government", "County Chief", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, CC, "Government", "County Chief", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, CC, "Government", "County Chief", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, CC, "Government", "County Chief", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, CC, "Government", "County Chief", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, CC, "Government", "County Chief", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "County Chief", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "County Chief", 270},


{1557.28, -1607.42, 13.38, 100, 100, 100, PO, "Government", "Police Officer", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, PO, "Government", "Police Officer", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, PO, "Government", "Police Officer", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, PO, "Government", "Police Officer", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, PO, "Government", "Police Officer", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, PO, "Government", "Police Officer", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, PO, "Government", "Police Officer", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, PO, "Government", "Police Officer", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, PO, "Government", "Police Officer", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, PO, "Government", "Police Officer", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, PO, "Government", "Police Officer", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, PO, "Government", "Police Officer", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, PO, "Government", "Police Officer", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, PO, "Government", "Police Officer", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, PO, "Government", "Police Officer", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, PO, "Government", "Police Officer", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "Police Officer", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "Police Officer", 270},

{1557.28, -1607.42, 13.38, 100, 100, 100, PD, "Government", "Police Detective", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, PD, "Government", "Police Detective", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, PD, "Government", "Police Detective", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, PD, "Government", "Police Detective", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, PD, "Government", "Police Detective", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, PD, "Government", "Police Detective", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, PD, "Government", "Police Detective", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, PD, "Government", "Police Detective", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, PD, "Government", "Police Detective", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, PD, "Government", "Police Detective", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, PD, "Government", "Police Detective", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, PD, "Government", "Police Detective", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, PD, "Government", "Police Detective", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, PD, "Government", "Police Detective", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, PD, "Government", "Police Detective", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, PD, "Government", "Police Detective", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "Police Detective", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "Police Detective", 270},

{1557.28, -1607.42, 13.38, 100, 100, 100, CIA, "Government", "NSA Agent", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, CIA, "Government", "NSA Agent", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, CIA, "Government", "NSA Agent", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, CIA, "Government", "NSA Agent", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, CIA, "Government", "NSA Agent", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, CIA, "Government", "NSA Agent", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, CIA, "Government", "NSA Agent", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, CIA, "Government", "NSA Agent", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, CIA, "Government", "NSA Agent", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, CIA, "Government", "NSA Agent", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, CIA, "Government", "NSA Agent", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, CIA, "Government", "NSA Agent", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, CIA, "Government", "NSA Agent", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, CIA, "Government", "NSA Agent", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, CIA, "Government", "NSA Agent", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, CIA, "Government", "NSA Agent", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "NSA Agent", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "NSA Agent", 270},

{1557.28, -1607.42, 13.38, 100, 100, 100, FBI, "Government", "FBI Agent", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, FBI, "Government", "FBI Agent", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, FBI, "Government", "FBI Agent", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, FBI, "Government", "FBI Agent", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, FBI, "Government", "FBI Agent", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, FBI, "Government", "FBI Agent", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, FBI, "Government", "FBI Agent", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, FBI, "Government", "FBI Agent", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, FBI, "Government", "FBI Agent", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, FBI, "Government", "FBI Agent", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, FBI, "Government", "FBI Agent", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, FBI, "Government", "FBI Agent", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, FBI, "Government", "FBI Agent", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, FBI, "Government", "FBI Agent", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, FBI, "Government", "FBI Agent", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, FBI, "Government", "FBI Agent", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "FBI Agent", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "FBI Agent", 270},

{1557.28, -1607.42, 13.38, 100, 100, 100, TA, "Government", "National Task Force", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, TA, "Government", "National Task Force", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, TA, "Government", "National Task Force", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, TA, "Government", "National Task Force", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, TA, "Government", "National Task Force", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, TA, "Government", "National Task Force", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, TA, "Government", "National Task Force", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, TA, "Government", "National Task Force", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, TA, "Government", "National Task Force", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, TA, "Government", "National Task Force", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, TA, "Government", "National Task Force", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, TA, "Government", "National Task Force", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, TA, "Government", "National Task Force", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, TA, "Government", "National Task Force", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, TA, "Government", "National Task Force", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, TA, "Government", "National Task Force", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "National Task Force", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "National Task Force", 270},

{1557.28, -1607.42, 13.38, 100, 100, 100, TA, "Government", "Government", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, TA, "Government", "Government", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, TA, "Government", "Government", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, TA, "Government", "Government", 90.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, TA, "Government", "Government", 90.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, TA, "Government", "Government", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, TA, "Government", "Government", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, TA, "Government", "Government", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, TA, "Government", "Government", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, TA, "Government", "Government", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, TA, "Government", "Government", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, TA, "Government", "Government", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, TA, "Government", "Government", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, TA, "Government", "Government", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, TA, "Government", "Government", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, TA, "Government", "Government", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverick, "Government", "Government", 89},
{1082.27, -355.98, 74.11, 100, 100, 100, maverick, "Government", "Government", 270},

{1565.64, -1706.15, 28.39, 54, 100, 139, pMav, "Government", "NSA Agent", 93},
{1565.64, -1694.14, 28.39, 54, 100, 139, pMav, "Government", "NSA Agent", 93},

{1565.64, -1706.15, 28.39, 54, 100, 139, pMav, "Government", "FBI Agent", 93},
{1565.64, -1694.14, 28.39, 54, 100, 139, pMav, "Government", "FBI Agent", 93},

{1565.64, -1706.15, 28.39, 54, 100, 139, SWATMav, "Government", "National Task Force", 93},
{1565.64, -1694.14, 28.39, 54, 100, 139, SWATMav, "Government", "National Task Force", 93},

{-1754,954,24,255, 255, 0, taxiVehs, "Civilian Workers", "Taxi Driver", 89},
{-2031.45, 171.02, 28.83, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 270 },
{-1684.59,1.1,3.55, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 138 },
{-2120.73,1411.91,-0.56, 238, 201, 0, FishermanVehs, "Civilian Workers", "Fisherman", 357 },
{-2130.72,1412.81,-0.56, 238, 201, 0, FishermanVehs, "Civilian Workers", "Fisherman", 357 },
{-2787.5,1348.42,-0.56, 238, 201, 0, rescveh, "Civilian Workers", "Rescuer Man", 52 },
{-1865.89,-213.33,18.38, 238, 201, 0, trashCollectorJobVehicles, "Civilian Workers", "Trash Collector", 357 },
{-1851,-194.69,18.37, 238, 201, 0, trashCollectorJobVehicles, "Civilian Workers", "Trash Collector", 179 },
-- PARAMEDIC
{1177.8963623047,-1308.6086425781,13.826147079468, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 271.59991455078},
{1178.8790283203,-1339.1666259766,13.870504379272, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 271.59991455078},
{2000.69,-1410.3,16.99, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 357 },
{2042.1, -1447.77, 17.64, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 267.21746826172 },
{-2654.01, 624.47, 14.45, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 92.25634765625 },
{-2654.01, 588.75, 14.45, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 91.02587890625 },
{1617.9898681641,1851.2003173828,10.8203125, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 180.42846679688 },
{1596.9125976563,1850.9556884766,10.8203125, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 180.42846679688 },
{-304.92, 1032.07, 19.59, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 265.06292724609 },
{-304.92, 1015.68, 19.59, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 273.52255249023 },
{-1525.43, 2526.3, 55.75, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 1.7441101074219 },
{-2187.04, -2307.81, 30.62, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 313.14535522461 },
{ 1260.74, 329.73, 19.9, 0, 225, 225, medicJobVehicles, "Paramedics", "Paramedic", 338.14535522461 },
-- MECHANIC
{2061.17, -1877.93, 13.54, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 273.35775756836 },
{1036.44, -1029.38, 32.1, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 181.33486938477 },
{-1917.28, 283.7, 41.04, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 177.07757568359 },
{708.32, -461.6, 16.33, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 91.492797851562 },
{1958.26, 2170.14, 10.82, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 180.52734375 },
{-81.78, 1133.29, 19.74, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 184.21881103516 },
{-2222.18,-2332.76,30.62, 238, 201, 0, mechanicJobVehicles, "Civilian Workers", "Mechanic", 316 }, 
-- TRUCKER
{2198.68, -2235.25, 13.54, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 223.52848815918 },
{2213.99, -2221.01, 13.54, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 227.86267089844 },
{685.21, 1832.83, 5.24, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 358.33828735352 },
{672.15, 1833.6, 5.17, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 358.40420532227 },
{-1730, -127.85, 3.55, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 135.39483642578 },
{-1734.75, -58.51, 3.54, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 134.98834228516 },
{-2098.97, -2239.55, 30.62, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 142.87112426758 },
{-2105.06, -2235.67, 30.62, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 141.88784790039 },
{-43.45, -1143.88, 1.07, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 76.847778320312 },
{-68.8, -1120.3, 1.07, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 68.574951171875 },
{52.15, -278.15, 1.69, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 353.00436401367 },
{65.92, -278.49, 1.57, 238, 201, 0, truckerJobVehicles, "Civilian Workers", "Trucker", 353.00436401367 },

--SAPD PD's
{1557.28, -1607.42, 13.38, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 173.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 83.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, sapdGroupVehicles, "Air Force","Air Force", 86.208282470703},
{1564.53, -1647.45, 28.39, 100, 100, 100, maverickmf, "Air Force","Air Force", 89},
--NSA
{1557.28, -1607.42, 13.38, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 181.35133361816},
{1567.36, -1607.42, 13.38, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 180.41200256348},
{1577.7, -1607.42, 13.38, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 190.43716430664},
{1600.64, -1687.93, 5.89, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 173.8310546875},
{1600.64, -1695.92, 5.89, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 83.906616210938},
{-1587.94, 650.68, 7.18, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 0.18402099609375},
{-1599.62, 650.68, 7.18, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 1.4364929199219},
{-1610.81, 650.68, 7.18, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 1.1233825683594},
{-1622.64, 650.68, 7.18, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 2.3758239746094},
{-1634.44, 650.68, 7.18, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 2.3758239746094},
{2313.86, 2475.1, 3.27, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 90},
{2315.62, 2460.36, 3.27, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 90},
{-224.38, 995.57, 19.57, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 260.17395019531},
{622.25, -588.91, 17.19, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 271.21539306641},
{-2171.07, -2359.86, 30.62, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 44.437622070312},
{-1400.57, 2637.79, 55.68, 100, 100, 100, SSGGroupVehicles, "Government","SSG", 86.208282470703},
--GIGN
{1557.28, -1607.42, 13.38, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 181.35133361816},
{1567.36, -1607.42, 13.38, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 180.41200256348},
{1577.7, -1607.42, 13.38, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 190.43716430664},
{1600.64, -1687.93, 5.89, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 173.8310546875},
{1600.64, -1695.92, 5.89, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 83.906616210938},
{-1587.94, 650.68, 7.18, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 0.18402099609375},
{-1599.62, 650.68, 7.18, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 1.4364929199219},
{-1610.81, 650.68, 7.18, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 1.1233825683594},
{-1622.64, 650.68, 7.18, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 2.3758239746094},
{-1634.44, 650.68, 7.18, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 2.3758239746094},
{2313.86, 2475.1, 3.27, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 90},
{2315.62, 2460.36, 3.27, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 90},
{-224.38, 995.57, 19.57, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 260.17395019531},
{622.25, -588.91, 17.19, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 271.21539306641},
{-2171.07, -2359.86, 30.62, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 44.437622070312},
{-1400.57, 2637.79, 55.68, 0, 0, 140, sapdGroupVehiclesGIGN, "GIGN","GIGN", 86.208282470703},
--MF PD's
{1557.28, -1607.42, 13.38, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 181.35133361816, "noOccupation" },
{1567.36, -1607.42, 13.38, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 180.41200256348, "noOccupation" },
{1577.7, -1607.42, 13.38, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 190.43716430664, "noOccupation" },
{1600.64, -1687.93, 5.89, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 173.8310546875, "noOccupation" },
{1600.64, -1695.92, 5.89, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 83.906616210938, "noOccupation" },
{-1587.94, 650.68, 7.18, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 0.18402099609375, "noOccupation" },
{-1599.62, 650.68, 7.18, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 1.4364929199219, "noOccupation" },
{-1610.81, 650.68, 7.18, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 1.1233825683594, "noOccupation" },
{-1622.64, 650.68, 7.18, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 2.3758239746094, "noOccupation" },
{-1634.44, 650.68, 7.18, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 2.3758239746094, "noOccupation" },
{2313.86, 2475.1, 3.27, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 90, "noOccupation" },
{2315.62, 2460.36, 3.27, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 90, "noOccupation" },
{-224.38, 995.57, 19.57, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 260.17395019531, "noOccupation" },
{622.25, -588.91, 17.19, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 271.21539306641, "noOccupation" },
{-2171.07, -2359.86, 30.62, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 44.437622070312, "noOccupation" },
{-1400.57, 2637.79, 55.68, 0, 100, 0, militaryVehicles_Cars, "Military Forces","Military Forces", 86.208282470703, "noOccupation" },
{1564.53, -1647.45, 28.39, 100, 100, 100, maverickmf, "Military Forces","Military Forces", 89, "noOccupation"},
{1082.27, -355.98, 74.11, 100, 100, 100, maverickmf, "Military Forces", "Military Forces", 270, "noOccupation"},
-- Pilot
{1823.96, -2622.38, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 355.45434570312 },
{1889.96, -2624.38, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 355.45434570312 },
{1986.93, -2382, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 86.367584228516 },
{1986.93, -2315.86, 13.54, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 86.367584228516 },
{-1211.6, -149.53, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 132.54382324219 },
{-1250.48, -103.51, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 137.07574462891 },
{-1339.34, -541.2, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 213.01441955566 },
{-1413.88, -580.55, 14.14, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 200.02288818359 },
{1610.52, 1620.44, 10.82, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 3.9853515625 },
{1370.24, 1713.69, 10.82, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 257.50424194336 },
{1369.1, 1755.95, 10.82, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot", 260.75073242188 },
{417.41, 2508.86, 16.48, 238, 201, 0, pilotJobVehicles, "Civilian Workers", "Pilot",88.375073242188 },
{1895.09, -2243.45, 13, 238, 201, 0, pilotTug, "Civilian Workers", "Pilot", 272 },
{1718.86, 1614.22, 9.5, 238, 201, 0, pilotTug, "Civilian Workers", "Pilot", 162 },
{-1546.43, -441.99, 5.5, 238, 201, 0, pilotTug, "Civilian Workers", "Pilot", 48 },
-- Criminal vehicles
{1715,1209.79,10.82, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 269 , "noOccupation" },
{1715,1220.11,10.82, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 269 , "noOccupation" },
{1715,1199.43,10.82, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 269 , "noOccupation" },

{1421.87, -1307.55, 13.55, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 358.85464477539, "noOccupation" },
{2129.84, 2351.31, 10.67, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 91.72900390625, "noOccupation" },
{2517.35, -1672.48, 14.04, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 56.072326660156, "noOccupation" },
{-2154.13, 649.83, 52.36, 200, 0, 0, criminalJobVehicles, "Criminals", "Criminal", 264.90365600586 , "noOccupation" },
-- Fire fighter
{1104.01, -1206.79, 17.8, 255, 255, 0, fireFighterVehicles, "Civilian Workers", "Firefighter", 180},
{1095.53, -1206.79, 17.8, 255, 255, 0, fireFighterVehicles, "Civilian Workers", "Firefighter", 180},
{1086.96, -1206.79, 17.8, 255, 255, 0, fireFighterVehicles, "Civilian Workers", "Firefighter", 180},
{-2021.38, 75.04, 28.1, 255, 255, 0, fireFighterVehicles, "Civilian Workers", "Firefighter", 275},
{-2021.38, 83.94, 28.1, 255, 255, 0, fireFighterVehicles, "Civilian Workers", "Firefighter", 275},
{-2021.38, 92.93, 28.1, 255, 255, 0, fireFighterVehicles, "Civilian Workers", "Firefighter", 275},
-- Street cleaner
{ 2191.42, -1970.7, 13.55, 225, 225, 0, streetcleanVehicles, "Civilian Workers", "Street Cleaner", 183.33988952637},
{ -2095.27, 84.92, 35.31, 225, 225, 0, streetcleanVehicles, "Civilian Workers", "Street Cleaner", 359.70062255859},
---- Farmer Job
{ -1208.81, -1068.01, 128.26, 225, 225, 0, FarmerVehicles, "Civilian Workers", "Farmer", 292.30303955078},
{  -1038.4, -1167.36, 129.21, 225, 225, 0, FarmerVehicles, "Civilian Workers", "Farmer", 93},
{  -1038.4, -1161.44, 129.21, 225, 225, 0, FarmerVehicles, "Civilian Workers", "Farmer", 93},
{ 711.26,1948.05,4.53, 225, 225, 0, FarmerVehicles, "Civilian Workers", "Farmer", 178},
{ 721.26,1948.05,4.53, 225, 225, 0, FarmerVehicles, "Civilian Workers", "Farmer", 178},
-- Electrican
{ -2092.1564941406, 95.542877197266, 35.3203125, 225, 225, 0, electricanVehicles, "Civilian Workers", "Electrician", 90 },
{ 1620.2939453125, -1887.7960205078, 13.547839164734, 225, 225, 0, electricanVehicles, "Civilian Workers", "Electrician", 90 },
-- Fisherman
{ 933.1, -2059.83, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 85},
{ 933.1, -2086.83, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 90},
{ -2417.9, 2302.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 267},
{ 1624.54, 571.48, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 270},
--airport attendant
{1653.06, -2260.5, 13.5,255,255,0,abagVehs,"Civilian Workers", "Airport Attendant", 0},
-- Fuel tank driver
{ 2599.85, -2199.13, 13.24, 255, 255, 0, fuelTankers, "Civilian Workers", "Fuel Tank Driver", 180},
-- Taxi driver
{989.73, -1524.16, 13.55 , 255, 255, 0, taxiVehs, "Civilian Workers", "Taxi Driver", 178},
{ 992.42, -1532.61, 13.57 , 255, 255, 0, taxiVehs, "Civilian Workers", "Taxi Driver", 85},
--Limo
{ 1034.26, -1124.67, 22.89, 255, 255, 0, limoveh, "Civilian Workers", "Limo Driver", 270},
-- Trash
{ 2184.35, -1988.25, 13.55, 225, 225, 0, trashCollectorJobVehicles, "Civilian Workers", "Trash Collector", 355},
--News Reporter
{751.45, -1341.09, 13.52,255,255,0,newsVehicles,"Civilian Workers", "News Reporter",270},
--Mail Officer
{1710.56, -1610.41, 13.25, 255, 255, 0, mailVehs, "Civilian Workers", "Mail Officer", 270},
--Pizza Boy
{2096.26, -1817.62, 13.0,255,255,0,pizzaVehs, "Civilian Workers", "Pizza Boy", 95},
--Foods Vendor
{ 2697.37, -1108.09, 69.54,255,255,0,delieveryMan,"Civilian Workers","Delievery Man",88.8},
-- Coastguard
{ 184.11, -1938.87, -0.56, 255, 255, 0, rescveh, "Civilian Workers", "Rescuer Man",  184.41107177734},
--lumber
{ -565.63165283203,-194.77699279785,78.639511108398, 255, 255, 0, lumber, "Civilian Workers", "Lumberjack",  87},
{ -503.74, -202.06, 78.4, 255, 255, 0, lumber, "Civilian Workers", "Lumberjack",  4}, 
{ 1567.36,40.01,23.49, 255, 255, 0, lumber, "Civilian Workers", "Lumberjack",  100}, 
--miner
{-382.43,2178.1,-13.91,255,255,0,minerVehs,"Civilian Workers", "Miner",264},
--postman
{-1926.98, 721.92, 45.44,255,255,0,postmanVehicles,"Civilian Workers", "Postman",360},
--pizzaboy
{-1716.96,1350.3,7.17,255,255,0,pizzaboy,"Civilian Workers", "Pizza Boy",126},
}


local JobsToTables = {
["Junior Officer"] = SG,
["Traffic Officer"] = TO,
["County Chief"] = CC,
["Police Officer"] = PO,
["Police Detective"] = PD,
["NSA Agent"] = CIA,
["FBI Agent"] = FBI,
["National Task Force"] = TA,
["Military Forces"] = militaryVehicles,
["NSA Team"] = sapdGroupVehicles,
["SSG"] = SSGGroupVehicles,
["GIGN"] = sapdGroupVehiclesGIGN,
["SWAT Team"] = sapdGroupVehicles,
["Paramedic"] = medicJobVehicles,
["Mechanic"] = mechanicJobVehicles,
["Pilot"] = PilotJobVehicles,
["Trucker"] = truckerJobVehicles,
["Criminal"] = criminalJobVehicles,
["Criminals"] = crimBaseVehicles,
["Firefighter"] = fireFighterVehicles,
["Bus Driver"] = busJobVehicles,
["Street Cleaner"] = streetcleanVehicles,
["Electrician"] = electricanVehicles,
["Fisherman"] = FishermanVehs,
["K-9 Unit Officer"] = policeDogJobVehicles,
["Trash Collector"] = trashCollectorJobVehicles,
["News Reporter"] = newsVehicles,
["Fuel Tank Driver"] = fuelTankers,
["Taxi Driver"] = taxiVehs,
["Server Security Agency"] = SSA,
["SSA Director"] = SSA,
["SSA Operative"] = SSA,
}

local asdmarkers = {}
local workingWithTable=false
for i,v in pairs(vehicleMarkers) do
    if getPlayerTeam ( localPlayer ) then
        local overRide=false
        if v[8] ~= nil and v[8] == "Government" then
            if getTeamName(getPlayerTeam ( localPlayer )) == "Government" or getTeamName(getPlayerTeam ( localPlayer )) == "Air Force" or getTeamName(getPlayerTeam ( localPlayer )) == "SWAT Team" or getTeamName(getPlayerTeam ( localPlayer )) == "Military Forces" then
                overRide=true
            end
        end
        if overRide==false and getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
            getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or
            getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then

            elref = createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])
            asdmarkers [elref ] = v[7]
            setElementData(elref, "freeVehiclesSpawnRotation", v[10])
            setElementData(elref, "isMakerForFreeVehicles", true)

            if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
        end
    end
end

local workingWith = {}
HydraRow = 0
RustlerRow = 0
HunterRow = 0
SeasparrowRow = 0
RhinoRow = 0
column = nil
addEventHandler("onClientMarkerHit", root,
	function ( hitElement, matchingDimension )
		if getElementType ( hitElement ) == "player" and getElementData( source, "isMakerForFreeVehicles" ) == true and hitElement == localPlayer then
			guiGridListClear ( vehiclesGrid )
			if not isPedInVehicle(localPlayer) then
				if (asdmarkers [source] ) then
					HydraRow = 0
					RustlerRow = 0
					HunterRow = 0
					SeasparrowRow = 0
					RhinoRow = 0
					if column then
						guiGridListRemoveColumn ( vehiclesGrid, column )
						column = nil
					end
					workingWithTable=asdmarkers [source]
					for i,v in pairs( asdmarkers [source] ) do
						if hitElement == localPlayer then
							local px,py,pz = getElementPosition ( hitElement )
							local mx, my, mz = getElementPosition ( source )
							if ( pz-3 < mz ) and ( pz+3 > mz ) then
								if ( getElementData( source, "groupMarkerName" ) ) and ( getElementData( localPlayer, "Group" ) ~= "None" ) and not ( getElementData( source, "groupMarkerName" ) == getElementData( localPlayer, "Group" ) ) then
									exports.NGCdxmsg:createNewDxMessage("You are not allowed to use this vehicle marker!", 225 ,0 ,0)
								else
									local row = guiGridListAddRow ( vehiclesGrid )
									setElementData(source,"FreeVehiclesMarker",true)
									workingWith[tostring(v[1])] = tonumber(i)
									tbl = getOriginalHandling(i)
									guiGridListSetItemText ( vehiclesGrid, row, vehicleName, tostring(v[1]), false, false )
									guiGridListSetItemData ( vehiclesGrid, row, vehicleName, tostring(i) )
									guiGridListSetItemText ( vehiclesGrid, row, vehicleMaxV, tbl["maxVelocity"]-35, false, false )
									guiGridListSetItemText ( vehiclesGrid, row, vehicleMaxP, getVehicleMaxPassengers(i), false, false )
									if isVehicleAV(tonumber(i)) then
										if not row or row == 0 or row < 0 then
											local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,0, 1 )
											if selectedVehicle == getVehicleNameFromModel(i) then
												row = 0
											end
										end
										guiGridListSetItemData(vehiclesGrid,row,vehicleMaxV,0)
										guiGridListSetItemColor( vehiclesGrid, row, 1, 225, 0, 0 )
										----
										if getVehicleNameFromModel(i) == "Hydra" then
											HydraRow = row
										elseif getVehicleNameFromModel(i) == "Rustler" then
											RustlerRow = row
										elseif getVehicleNameFromModel(i) == "Hunter" then
											HunterRow = row
										elseif getVehicleNameFromModel(i) == "Seasparrow" then
											SeasparrowRow = row
										elseif getVehicleNameFromModel(i) == "Rhino" then
											RhinoRow = row
										end
										triggerServerEvent("callGroupSpawnAccess",localPlayer)
									end
									if isTrucker(tonumber(i)) then
										if not row or row == 0 or row < 0 then
											local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,0, 1 )
											if selectedVehicle == getVehicleNameFromModel(i) then
												row = 0
											end
										end
										guiGridListSetItemData(vehiclesGrid,row,vehicleMaxP,1)
										guiGridListSetItemColor( vehiclesGrid, row, 1, 0, 225, 0 )
										--403 Linerunner, 514 tanker, 515 Roadtrain
										triggerEvent("checkCivilianAccess",localPlayer)
									end
									if isPilot(tonumber(i)) then
										if not row or row == 0 or row < 0 then
											local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,0, 1 )
											if selectedVehicle == getVehicleNameFromModel(i) then
												row = 0
											end
										end
										guiGridListSetItemData(vehiclesGrid,row,vehicleMaxP,1)
										guiGridListSetItemColor( vehiclesGrid, row, 1, 0, 225, 0 )
										-----L1 Stuntplane Dodo,L2 Beagle,L3 Raindance,L4 Maverick,L5 Nevada, L6 Shamal , L7 Andromada
										triggerEvent("checkCivilianAccess",localPlayer)
									end
									guiSetVisible( vehiclesWindow, true )
									showCursor( true, true )

									theVehicleRoation = getElementData(source, "freeVehiclesSpawnRotation")
									theMarker = source
								end
							end
						end
					end
				end
			end
		end
	end
)


addEvent("checkCivilianAccess",true)
addEventHandler("checkCivilianAccess",root,function(t)
	local theRank,stat,theRankN, nextRank, nextRankPoints = exports.CSGranks:getPlayerRankInfo()
	if theRank and stat then
--[[		if getElementData(localPlayer,"Occupation") == "Trucker" then
			if stat <= 99 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Truck1Row, 1 )
				if selectedVehicle == "Linerunner" then
					guiGridListSetItemColor( vehiclesGrid, Truck1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Truck1Row, vehicleMaxP, 1 )
				end
			elseif stat > 100 and stat <= 799 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Truck1Row, 1 )
				if selectedVehicle == "Linerunner" then
					guiGridListSetItemColor( vehiclesGrid, Truck1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Truck1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Truck2Row, 1 )
				if selectedVehicle == "Tanker" then
					guiGridListSetItemColor( vehiclesGrid, Truck2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Truck2Row, vehicleMaxP, 1 )
				end
			elseif stat > 800 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Truck1Row, 1 )
				if selectedVehicle == "Linerunner" then
					guiGridListSetItemColor( vehiclesGrid, Truck1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Truck1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Truck2Row, 1 )
				if selectedVehicle == "Tanker" then
					guiGridListSetItemColor( vehiclesGrid, Truck2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Truck2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Truck3Row, 1 )
				if selectedVehicle == "Roadtrain" then
					guiGridListSetItemColor( vehiclesGrid, Truck3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Truck3Row, vehicleMaxP, 1 )
				end
			end
		if getElementData(localPlayer,"Occupation") == "Pilot" then
			if stat < 250 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
			elseif stat >= 250 and stat < 1000 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot3Row, 1 )
				if selectedVehicle == "Beagle" then
					guiGridListSetItemColor( vehiclesGrid, Pilot3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot3Row, vehicleMaxP, 1 )
				end

			elseif stat >= 1000 and stat < 2000 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot3Row, 1 )
				if selectedVehicle == "Beagle" then
					guiGridListSetItemColor( vehiclesGrid, Pilot3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot3Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot4Row, 1 )
				if selectedVehicle == "Raindance" then
					guiGridListSetItemColor( vehiclesGrid, Pilot4Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot4Row, vehicleMaxP, 1 )
				end

			elseif stat >= 2000 and stat < 5000 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot3Row, 1 )
				if selectedVehicle == "Beagle" then
					guiGridListSetItemColor( vehiclesGrid, Pilot3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot3Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot4Row, 1 )
				if selectedVehicle == "Raindance" then
					guiGridListSetItemColor( vehiclesGrid, Pilot4Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot4Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot5Row, 1 )
				if selectedVehicle == "Maverick" then
					guiGridListSetItemColor( vehiclesGrid, Pilot5Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot5Row, vehicleMaxP, 1 )
				end

			elseif stat >= 5000 and stat < 10000 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot3Row, 1 )
				if selectedVehicle == "Beagle" then
					guiGridListSetItemColor( vehiclesGrid, Pilot3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot3Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot4Row, 1 )
				if selectedVehicle == "Raindance" then
					guiGridListSetItemColor( vehiclesGrid, Pilot4Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot4Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot5Row, 1 )
				if selectedVehicle == "Maverick" then
					guiGridListSetItemColor( vehiclesGrid, Pilot5Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot5Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot6Row, 1 )
				if selectedVehicle == "Nevada" then
					guiGridListSetItemColor( vehiclesGrid, Pilot6Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot6Row, vehicleMaxP, 1 )
				end
			elseif stat >= 10000 and stat < 20000 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot3Row, 1 )
				if selectedVehicle == "Beagle" then
					guiGridListSetItemColor( vehiclesGrid, Pilot3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot3Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot4Row, 1 )
				if selectedVehicle == "Raindance" then
					guiGridListSetItemColor( vehiclesGrid, Pilot4Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot4Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot5Row, 1 )
				if selectedVehicle == "Maverick" then
					guiGridListSetItemColor( vehiclesGrid, Pilot5Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot5Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot6Row, 1 )
				if selectedVehicle == "Nevada" then
					guiGridListSetItemColor( vehiclesGrid, Pilot6Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot6Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot7Row, 1 )
				if selectedVehicle == "Shamal" then
					guiGridListSetItemColor( vehiclesGrid, Pilot7Row, 1, 0,225, 0 )
					guiGridListSetItemData( vehiclesGrid, Pilot7Row, vehicleMaxP, 1 )
				end
			elseif stat >= 20000 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot1Row, 1 )
				if selectedVehicle == "Stuntplane" then
					guiGridListSetItemColor( vehiclesGrid, Pilot1Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot1Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot2Row, 1 )
				if selectedVehicle == "Dodo" then
					guiGridListSetItemColor( vehiclesGrid, Pilot2Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot2Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot3Row, 1 )
				if selectedVehicle == "Beagle" then
					guiGridListSetItemColor( vehiclesGrid, Pilot3Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot3Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot4Row, 1 )
				if selectedVehicle == "Raindance" then
					guiGridListSetItemColor( vehiclesGrid, Pilot4Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot4Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot5Row, 1 )
				if selectedVehicle == "Maverick" then
					guiGridListSetItemColor( vehiclesGrid, Pilot5Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot5Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot6Row, 1 )
				if selectedVehicle == "Nevada" then
					guiGridListSetItemColor( vehiclesGrid, Pilot6Row, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, Pilot6Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot7Row, 1 )
				if selectedVehicle == "Shamal" then
					guiGridListSetItemColor( vehiclesGrid, Pilot7Row, 1, 0,225, 0 )
					guiGridListSetItemData( vehiclesGrid, Pilot7Row, vehicleMaxP, 1 )
				end
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,Pilot8Row, 1 )
				if selectedVehicle == "Andromada" then
					guiGridListSetItemColor( vehiclesGrid, Pilot8Row, 1, 0,225, 0 )
					guiGridListSetItemData( vehiclesGrid, Pilot8Row, vehicleMaxP, 1 )
				end
			end
		end]]--
	end
end)
---L1 Stuntplane Dodo,L2 Beagle,L3 Raindance,L4 Maverick,L5 Nevada, L6 Shamal , L7 Andromada


addEvent("avList",true)
addEventHandler("avList",root,function(t)
--	if HydraRow == 0 and RustlerRow == 0 and HunterRow == 0 and SeasparrowRow == 0 and RhinoRow == 0 then return false end
	for k=1,#t do
		if t[k][1] == "Hydra" then
			if t[k][2] == 1 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,HydraRow, 1 )
				if selectedVehicle == t[k][1] then
					guiGridListSetItemColor( vehiclesGrid, HydraRow, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, HydraRow, vehicleMaxV, 1 )
				end
			end
		elseif t[k][1] == "Rustler" then
			if t[k][2] == 1 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,RustlerRow, 1 )
				if selectedVehicle == t[k][1] then
					guiGridListSetItemColor( vehiclesGrid, RustlerRow, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, RustlerRow, vehicleMaxV, 1 )
				end
			end
		elseif t[k][1] == "Hunter" then
			if t[k][2] == 1 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,HunterRow, 1 )
				if selectedVehicle == t[k][1] then
					guiGridListSetItemColor( vehiclesGrid, HunterRow, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, HunterRow, vehicleMaxV, 1 )
				end
			end
		elseif t[k][1] == "Seasparrow" then
			if t[k][2] == 1 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,SeasparrowRow, 1 )
				if selectedVehicle == t[k][1] then
					outputDebugString(SeasparrowRow.." seasp")
					guiGridListSetItemColor( vehiclesGrid, SeasparrowRow, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, SeasparrowRow, vehicleMaxV, 1 )
				end
			end
		elseif t[k][1] == "Rhino" then
			if t[k][2] == 1 then
				local selectedVehicle = guiGridListGetItemText ( vehiclesGrid,RhinoRow, 1 )
				if selectedVehicle == t[k][1] then
					guiGridListSetItemColor( vehiclesGrid, RhinoRow, 1, 0,225, 0 )
					guiGridListSetItemData ( vehiclesGrid, RhinoRow, vehicleMaxV, 1 )
				end
			end
		end
	end
end)

function isVehicleAV(md)
	if tonumber(md) == 520 then
		return true
	elseif tonumber(md) == 476 then
		return true
	elseif tonumber(md) == 447 then
		return true
	elseif tonumber(md) == 432 then
		return true
	elseif tonumber(md) == 425 then
		return true
	else
		return false
	end
end

function isTrucker(md)
	if getElementData(localPlayer,"Occupation") == "Trucker" then
		if tonumber(md) == 515 then
			return true
		elseif tonumber(md) == 514 then
			return true
		elseif tonumber(md) == 403 then
			return true
		else
			return false
		end
	else
		return false
	end
end
--L1 Stuntplane Dodo,L2 Beagle,L3 Raindance,L4 Maverick,L5 Nevada, L6 Shamal , L7 Andromada
function isPilot(md)
	if getElementData(localPlayer,"Occupation") == "Pilot" then
		if tonumber(md) == 487 then
			return true
		elseif tonumber(md) == 563 then
			return true
		elseif tonumber(md) == 592 then
			return true
		elseif tonumber(md) == 553 then
			return true
		elseif tonumber(md) == 593 then
			return true
		elseif tonumber(md) == 513 then
			return true
		elseif tonumber(md) == 511 then
			return true
		elseif tonumber(md) == 519 then
			return true
		else
			return false
		end
	else
		return	false
	end
end

addEventHandler( "onClientMarkerLeave", root,
	function ( leftPlayer, matchingDimension )
		if getElementData( source, "isMakerForFreeVehicles" ) == true and leftPlayer == localPlayer then
			guiSetVisible( vehiclesWindow, false )
			showCursor( false, false )
		end
	end
)

-- Reload the markers
function reloadFreeVehicleMarkers ()
    for i,v in pairs( asdmarkers ) do
        destroyElement(i)
    end

    asdmarkers = {}

    for i,v in pairs(vehicleMarkers) do
        if getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or
            getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or
            getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then

            elref =  createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])
            asdmarkers [elref ] = v[7]
            setElementData(elref, "freeVehiclesSpawnRotation", v[10])
            setElementData(elref, "isMakerForFreeVehicles", true)

            if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
        end
    end
end
addEvent("reloadFreeVehicleMarkers", true)
addEventHandler("reloadFreeVehicleMarkers", root, reloadFreeVehicleMarkers )

function spawnTheVehicle ()
if getElementDimension(localPlayer) ~= 0 then return false end
local x,y,z = getElementPosition(theMarker)
local selectedVehicle = guiGridListGetItemText ( vehiclesGrid, guiGridListGetSelectedItem ( vehiclesGrid ), 1 )
local rent = getElementData(theMarker,"FreeVehiclesMarker")
    if selectedVehicle == "" or selectedVehicle == " " then
        exports.NGCdxmsg:createNewDxMessage("You didnt select a vehicle!", 225 ,0 ,0)
    else
        local selectedRow, selectedColumn = guiGridListGetSelectedItem(vehiclesGrid)
        local theVehicleID = workingWith[tostring(selectedVehicle)]
        --local theVehicleID = tonumber(guiGridListGetItemData ( vehiclesGrid, selectedRow, selectedColumn ))
		local access = tonumber(guiGridListGetItemData ( vehiclesGrid, selectedRow,2 ))
		if access == 0 then
			exports.NGCdxmsg:createNewDxMessage("You don't have access to spawn this vehicle",255,0,0)
			return false
		end
		local access2 = tonumber(guiGridListGetItemData ( vehiclesGrid, selectedRow,3 ))
		if access2 == 0 then
			exports.NGCdxmsg:createNewDxMessage("You need promotion to be able to spawn this vehicle check F5",255,0,0)
			return false
		end
        if ( tonumber( theVehicleID) == 481 ) or ( tonumber( theVehicleID) == 510 ) or ( tonumber( theVehicleID) == 509 ) or ( tonumber( theVehicleID) == 462 ) or ( getElementData( localPlayer, "Occupation" ) == "Criminal" ) or ( getElementData( localPlayer, "Occupation" ) == "Drugs farmer" ) or getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
            if exports.server:isPlayerArrested( localPlayer )
			then exports.NGCdxmsg:createNewDxMessage("You can't spawn vehicles while arrested!", 225 ,0 ,0) return end
			if ( getElementData( localPlayer, "wantedPoints" ) >= 20 ) then
                exports.NGCdxmsg:createNewDxMessage("You can't spawn free vehicles when having more then 1 wanted stars!", 225 ,0 ,0)
				return false
            else
                local getTable = workingWithTable --JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
            local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
            local r,g,b=nil,nil,nil
            local r2,g2,b2=nil,nil,nil
            if getTable[theVehicleID].r ~= nil then
                r,g,b=getTable[theVehicleID].r,getTable[theVehicleID].g,getTable[theVehicleID].b
            end
            if getTable[theVehicleID].r2 ~= nil then
                r2,g2,b2=getTable[theVehicleID].r2,getTable[theVehicleID].g2,getTable[theVehicleID].b2
            end
            triggerServerEvent("spawnVehicleSystem", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation,r,g,b,r2,g2,b2)
			outputDebugString("Spawning was from #1")
                guiSetVisible (vehiclesWindow, false)
                showCursor(false,false)
                guiGridListClear ( vehiclesGrid )
            end
        elseif doesPlayerHaveLiceForVehicle(tonumber(theVehicleID)) then
            local getTable = workingWithTable --JobsToTables[getElementData(localPlayer, "Occupation")] or JobsToTables[getTeamName(getPlayerTeam ( localPlayer ))]
            local vehicle,color1,color2,color3,color4 = getTable[theVehicleID][1],getTable[theVehicleID][2],getTable[theVehicleID][3],getTable[theVehicleID][4],getTable[theVehicleID][5]--unpack( getTable[tonumber( theVehicleID )] )
            local r,g,b=nil,nil,nil
            local r2,g2,b2=nil,nil,nil
            if getTable[theVehicleID].r ~= nil then
                r,g,b=getTable[theVehicleID].r,getTable[theVehicleID].g,getTable[theVehicleID].b
            end
            if getTable[theVehicleID].r2 ~= nil then
                r2,g2,b2=getTable[theVehicleID].r2,getTable[theVehicleID].g2,getTable[theVehicleID].b2
            end
            triggerServerEvent("spawnVehicleSystem", localPlayer, x, y, z, theVehicleID, color1, color2, color3, color4, theVehicleRoation,r,g,b,r2,g2,b2)
			outputDebugString("Spawning was from #2")
            guiSetVisible (vehiclesWindow, false)
            showCursor(false,false)
            guiGridListClear ( vehiclesGrid )
        else
            exports.NGCdxmsg:createNewDxMessage("You don't have a licence for this type of vehicle!", 225 ,0 ,0)
        end
    end
end
addEventHandler("onClientGUIClick", spawnVehicleSystemButton, spawnTheVehicle, false)

function doesPlayerHaveLiceForVehicle (vehicleID)
    local playtime = getElementData(localPlayer,"playTime")
    if getVehicleType ( vehicleID ) == "Automobile" or getVehicleType ( vehicleID ) == "Monster Truck"
    or getVehicleType ( vehicleID ) == "Quad" or getVehicleType ( vehicleID ) == "Trailer" then
        if playtime == false or playtime==nil then return true end
        if math.floor((tonumber(playtime)/60)) < 10 then return true end
        if getElementData(localPlayer, "carLicence") then
            return true
        else
            return false
        end
    elseif getVehicleType ( vehicleID ) == "Plane" then
        if getElementData(localPlayer, "planeLicence") then
            return true
        else
            return false
        end
    elseif getVehicleType ( vehicleID ) == "Helicopter" then
        if getElementData(localPlayer, "chopperLicence") then
            return true
        else
            return false
        end
    elseif getVehicleType ( vehicleID ) == "Bike" or getVehicleType ( vehicleID ) == "BMX" then
        if getElementData(localPlayer, "bikeLicence") then
            return true
        else
            return false
        end
    elseif getVehicleType ( vehicleID ) == "Boat" then
        if getElementData(localPlayer, "boatLicence") then
            return true
        else
            return false
        end
    end
end

function getParts()
	local mode = dxGetStatus ( )
	return mode.VideoCardRAM
end

---------------------


-- Free vehicles in SA
--{-237.85,2594.31,62.7, 225, 225, 225, freeVehicles, nil, nil, 359},
--{900.45, -2362.55, 13.24, 225, 225, 225, freeVehicles, nil, nil, 211.119689941406},
--{1537.9, -1658.67, 13.1, 225, 225, 225, freeVehicles, nil, nil, 89.119689941406},
--{2006.59, -1448.51, 13.16, 225, 225, 225, freeVehicles, nil, nil, 83.967041015625},
--{1183.62890625,-1332.7626953125,13.581889152527, 225, 225, 225, freeVehicles, nil, nil, 271},
--{634.12, -580.55, 16.33, 225, 225, 225, freeVehicles, nil, nil, 272.56671142578},
--{-215.45, 986, 19.4, 225, 225, 225, freeVehicles, nil, nil, 267.08993530273},
--{-328.43, 1066.65, 19.74, 225, 225, 225, freeVehicles, nil, nil, 267.42504882812},
--{1624.97, 1824.85, 10.82, 225, 225, 225, freeVehicles, nil, nil, 358.63491821289},
--{2298.42, 2427.28, 10.82, 225, 225, 225, freeVehicles, nil, nil, 178.20922851562},
--{1236.87, 340.18, 19.55, 225, 225, 225, freeVehicles, nil, nil, 332.15197753906},
--{-2656.38, 632.33, 14.45, 225, 225, 225, freeVehicles, nil, nil, 178.54431152344},
--{-1619.24, 721.17, 14.4, 225, 225, 225, freeVehicles, nil, nil, 353.97665405273},
--{-1499.27, 2539.65, 55.84, 225, 225, 225, freeVehicles, nil, nil, 357.30557250977},
--{-2194.67, -2306.59, 30.62, 225, 225, 225, freeVehicles, nil, nil, 316.35888671875},
--{1682.78, -2263.81, 13.5, 225, 225, 225, freeVehicles, nil, nil, 0.81573486328125},
--{-1946.33, 2407.68, 50.01, 225, 225, 225, freeVehicles, nil, nil, 280.81573486328125},
