 -- Anti compiller
 -- Anti compiller


local CSGSecurity = {{{{{ {}, {}, {} }}}}}




GUIEditor = {

    label = {}

}



vehiclesWindow = guiCreateWindow(102, 133, 539, 330, "Aurora ~ Vehicles", false)


guiWindowSetSizable(vehiclesWindow, false)



vehiclesGrid = guiCreateGridList(10, 27, 356, 289, false, vehiclesWindow)


vehicleName = guiGridListAddColumn(vehiclesGrid, " Vehiclename:", 0.5)



vehicleMaxV = guiGridListAddColumn(vehiclesGrid, "Max Velocity", 0.2)


vehicleMaxP = guiGridListAddColumn(vehiclesGrid, "Max Passenger", 0.2)



spawnVehicleSystemButton = guiCreateButton(383, 66, 146, 33, "Spawn Vehicle", false, vehiclesWindow)



guiSetProperty(spawnVehicleSystemButton, "NormalTextColour", "FF3AEE10")



closeWindowButton = guiCreateButton(383, 286, 146, 30, "Close Window", false, vehiclesWindow)


guiSetProperty(closeWindowButton, "NormalTextColour", "FFFEFEFE")


GUIEditor.label[1] = guiCreateLabel(383, 31, 146, 25, "Options", false, vehiclesWindow)



guiSetFont(GUIEditor.label[1], "default-bold-small")



guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)




guiGridListSetSortingEnabled ( vehiclesGrid, false )addEventHandler("onClientGUIClick", closeWindowButton, function() guiSetVisible(vehiclesWindow, false) showCursor( false, false ) guiGridListClear ( vehiclesGrid ) end, false)


setTimer(function()


	if getElementDimension(localPlayer) ~= 0 then


		guiSetVisible(vehiclesWindow, false) showCursor( false, false ) guiGridListClear ( vehiclesGrid )


	end	if getElementHealth(localPlayer) < 1 then



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

---------------------------- MTA VEHICLES IDS/NAMES------------------------------



--SSG

local ssgheli = {
------------------------------------------------------------------------
[447] = {"Seasparrow",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[487] = {"Maverick",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[519] = {"Shamal",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

}
local ssgCars ={

[528] = {"FBI Truck",0,0,0,0,r=0,g=170,b=0,r2=0,g2=0,b2=0},

[427] = {"Enforcer",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[596] = {"Police Car (LS)",0,0,0,0,r=0,g=0,b=0,r2=0,g2=170,b2=0},

[599] = {"Police Ranger",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[490] = {"FBI Rancher",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[601] = {"S.W.A.T.",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[560] = {"Sultan",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[409] = {"Stretch",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[415] = {"Cheetah",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[500] = {"Mesa",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[451] = {"Turismo",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[494] = {"Hotring Racer",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[411] = {"Infernus",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[541] = {"Bullet", 0,0,0,0,r=22,g=22,b=22,r2=0,g2=170,b2=0},
}

local ssgwater = {

[452] = {"Speeder",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},
[446] = {"Squalo",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},
[472] = {"Coast Guard",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

}
------------------------------------------------------------------------


--The Smurfs

local dcFly = {
------------------------------------------------------------------------
[487] = {"DreamChasers Maverick",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

}

local dcCars = {

[411] = {"Infernus",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[434] = {"Hotknife",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[451] = {"Turismo",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[541] = {"Bullet",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[560] = {"Sultan",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[480] = {"Comet",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[431] = {"Bus",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[495] = {"Sandking",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

[502] = {"Hotring Racer A",0,0,0,0,r=66,g=161,b=244,r2=0,g2=0,b2=0},

}

------------------------------------------------------------------------

--HolyCrap

------------------------------------------------------------------------

local hcFly = {

[487] = {"Maverick",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},
[447] = {"Seasparrow",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

}
local hcAir = {

[519] = {"Shamal",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},
[476] = {"Rustler",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},
[520] = {"Hydra",0, 0, 0, 0,r=0,g=0,b=102,r2=0,g2=0,b2=0},
[487] = {"Maverick",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},
[447] = {"Seasparrow",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

}
local hcCars = {

[451] = {"Turismo",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[411] = {"Infernus",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[541] = {"Bullet",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[489] = {"Rancher",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[560] = {"Sultan",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[437] = {"Coach",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[495] = {"Sandking",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[415] = {"Cheetah",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[494] = {"Hotring Racer",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[504] = {"Bloodring Banger",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[506] = {"Super GT",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[556] = {"Monster truck",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[571] = {"Kart",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[409] = {"Limousine",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[424] = {"BF Injection",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[434] = {"Hotknife",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[463] = {"Freeway",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[468] = {"Sanchez",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[471] = {"Quadbike",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[480] = {"Comet",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[486] = {"Dozer",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[500] = {"Mesa",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[535] = {"Slamvan",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[562] = {"Elegy",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[568] = {"Bandito",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},

[567] = {"Savanna",0,0,0,0,r=0,g=0,b=102,r2=0,g2=0,b2=0},
}
local hcWater = {

[452] = {"Speeder",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},
[446] = {"Squalo",0, 0, 0, 0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

}

------------------------------------------------------------------------

-- GIGN

local GIGN2019_vehicles = {
[598] = {"Police LV", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[599] = {"Police Ranger", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[522] = {"NRG-500", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[523] = {"HPV-1000", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[427] = {"Enforcer", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[470] = {"Patriot", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[411] = {"Infernus", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[579] = {"Huntley", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[560] = {"Sultan", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[551] = {"Merit", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[541] = {"Bullet", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[490] = {"FBI Rancher", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[528] = {"FBI Truck", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[437] = {"Coach", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[601] = {"S.W.A.T.", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[433] = {"Barracks", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
}

local GIGN2019_helicopters = {
[497] = {"Police Maverick", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[447] = {"Seasparrow", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
}

local GIGN2019_planes = {
[519] = {"Shamal", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
}

local GIGN2019_boats = {
[493] = {"Jetmax", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},
[446] = {"Squalo", 131,131,131,131,r=0,g=0,b=100,r2=255,g2=255,b2=255},

}

------------------------------------------------------------------------

--Delta Force

local DFCars = {
------------------------------------------------------------------------

[490] = {"FBI Rancher",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},

[427] = {"Enforcer",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},

[411] = {"Infernus",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},

[495] = {"Sandking",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},

[560] = {"Sultan",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},

[500] = {"Mesa",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},


}
 local DFFly = {
 
 [519] = {"Shamal",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},
 
 }
 
 local DFHeli = {
 
 [497] = {"Police Maverick",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},
 
 [447] = {"Seasparrow",0,0,0,0,r=0,g=128,b=128,r2=0,g2=0,b2=0},
 
 }

------------------------------------------------------------------------

--The Cobras

local CobCars = {
------------------------------------------------------------------------

[482] = {"Burrito",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[427] = {"Enforcer",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[411] = {"Infernus",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[580] = {"Stafford",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[560] = {"Sultan",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[541] = {"Bullet",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

[409] = {"The Very Loooooooong Car",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},

}
 local CobFly = {
 
 [519] = {"Shamal",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},
 [593] = {"Dodo",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},
 
 }
 
 local CobHeli = {
 
 [487] = {"Maverick",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},
 [465] = {"Cobras Little Drone",0,0,0,0,r=0,g=90,b=0,r2=0,g2=0,b2=0},
 
 }
 
 ------------------------------------------------------------------------

--FBI

local FBICars = {
------------------------------------------------------------------------

[490] = {"FBI Rancher",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},

[427] = {"Enforcer",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},

[411] = {"Infernus",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},

[528] = {"FBI Truck",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},

[541] = {"Bullet",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},

[596] = {"Police LS",0,0,0,0,r=0,g=118,b=240, r2=0,g2=0,b2=0},

[597] = {"Police SF",0,0,0,0,r=0,g=118,b=240, r2=0,g2=0,b2=0},

[598] = {"Police LV",0,0,0,0,r=0,g=118,b=240, r2=0,g2=0,b2=0},

[599] = {"Police Ranger",0,0,0,0,r=0,g=118,b=240, r2=0,g2=0,b2=0},


}
 local FBIFly = {
 
 [519] = {"Shamal",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},
 
 }
 
 local FBIHeli = {
 
 [497] = {"Police Maverick",0,0,0,0,r=0,g=118,b=240,r2=0,g2=0,b2=0},
 
 }

------------------------------------------------------------------------

--Military Forces

local affVehicles = {
------------------------------------------------------------------------
[470] = {"Patriot", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[490] = {"FBI Rancher", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[598] = {"Police (LVPD)", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[500] = {"Mesa", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[495] = {"Sandking", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[560] = {"Sultan", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[409] = {"Stretch", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[411] = {"Infernus", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[468] = {"Sanchez", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[579] = {"Huntley", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[427] = {"Enforcer", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[433] = {"Barracks", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[434] = {"Hotknife", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[541] = {"Bullet", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[522] = {"NRG-500", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[528] = {"FBI Truck", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[428] = {"Securicar", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[601] = {"S.W.A.T.", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[559] = {"Jester", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[565] = {"Flash", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

local aafVehicles_Aircraft_Plane = {
[519] = {"Shamal", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[511] = {"Beagle", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[593] = {"Dodo", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
}

local aafVehicles_Aircraft_Copter = {
[497] = {"Police Maverick", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},

}
local aafVehicles_Aircraft_Copter1= {
[497] = {"Police Maverick", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[519] = {"Shamal", 0,0,0,0,r=0,g=0,b=0,r2=0,g2=0,b2=0},

}
local mfBoat = {

[446] = {"Squallo",44, 44 , 44, 44},

[430] = {"Predator",44, 44 , 44, 44 },

[595] = {"Launch",44, 44 , 44, 44 },

}
------------------------------------------------------------------------

-- Special PoliceForce

local spfCars = {

[560] = {"Sultan",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[415] = {"Cheetah",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[451] = {"Turismo",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[495] = {"Sandking",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[429] = {"Banshee",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[489] = {"Rancher",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[411] = {"Infernus",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[579] = {"Huntley",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[434] = {"Hotknife",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[521] = {"FCR-900 ",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[468] = {"Sanchez",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[463] = {"Freeway",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[471] = {"Quad",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[572] = {"Mower",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[506] = {"Super GT",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[560] = {"Sultan",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[561] = {"Stratum",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[568] = {"Bandito",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[475] = {"Sabre",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[409] = {"Stretch",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[587] = {"Euros",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[467] = {"Oceanic",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[545] = {"Hustler",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[500] = {"Mesa",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[580] = {"Stafford",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[575] = {"Broadway",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[400] = {"Landstalker",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[482] = {"Burrito",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[552] = {"Utility Van",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[418] = {"Moonbeam",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[486] = {"Dozer",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[557] = {"Monster Truck",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[443] = {"Packer",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[431] = {"Bus",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[573] = {"Dune",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[524] = {"Cement Truck",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[578] = {"DFT-30",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[455] = {"Flatbed",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[498] = {"Boxville",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[525] = {"Towtruck",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[478] = {"Walton",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[531] = {"Tractor",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

}

local spfAir = {

[519] = {"Shamal",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[593] = {"Dodo",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[553] = {"Nevada",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[513] = {"Stuntplane",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[512] = {"Cropduster",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[476] = {"Rustler",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

}

local spfChoppers = {

[487] = {"Maverick",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[563] = {"Raindance",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[417] = {"Leviathan",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[548] = {"Cargobob",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[488] = {"News chopper",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[447] = {"Seasparrow",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

}


local spfBoats = {

[473] = {"Dinghy",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[595] = {"Launch",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[452] = {"Speeder",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[446] = {"Squallo",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[493] = {"Jetmax",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[484] = {"Marquis",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[539] = {"Vortex",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[454] = {"Tropic",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

[453] = {"Reefer",0, 0, 0, 0,r=40,g=0,b=80,r2=0,g2=0,b2=0},

}
------------------------------------------------------------------------  

local terrVehs = {
[411] = {"Infernus",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[580] = {"Stafford",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[560] = {"Sultan",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[522] = {"Terrorists NRG-500",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[490] = {"Terrorists Rancher",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[468] = {"Sanchez",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[515] = {"Roadtrain",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[495] = {"Sandking",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[494] = {"Hotring Racer",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[489] = {"Rancher",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[457] = {"Caddy",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},
[449] = {"Tram",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},

}

local terrChop = {
[487] = {"Terrorists Maverick",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},

}

local terrAir = {
[519] = {"Shamal",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},

}

local terrWater = {

[446] = {"Squallo",0, 0, 0, 0,r=0,g=0,b=0,r2=0,g2=0,b2=0},

}


------------------------------------------------------------------------  

local b13Vehs = {

[560] = {"Sultan",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[411] = {"Infernus",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[522] = {"NRG-500",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[541] = {"Bullet",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[429] = {"Banshee",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[495] = {"Sandking",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[437] = {"Coach",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[451] = {"Turismo",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[506] = {"Super GT",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[479] = {"Regina",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[521] = {"FCR-900 ",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[463] = {"Freeway",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[561] = {"Stratum",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[568] = {"Bandito",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[409] = {"Stretch",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[482] = {"Burrito",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[556] = {"Monster A",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[443] = {"Packer",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[471] = {"Quadbike",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[535] = {"Slamvan",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[605] = {"damaged Sadler",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[504] = {"Bloodring Banger",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[503] = {"Hotring Racer B",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[502] = {"Hotring Racer A",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

}

------------------------------------------------------------------------  


local b13Choppers = {

[487] = {"Maverick",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[488] = {"News chopper",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[447] = {"Seasparrow",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[563] = {"Raindance",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

}

------------------------------------------------------------------------  

local b13Air = {

[519] = {"Shamal",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[513] = {"Stuntplane",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[476] = {"Rustler",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[511] = {"Beagle",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

}


------------------------------------------------------------------------  

local b13Water = {

[595] = {"Launch",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[460] = {"Skimmer",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[539] = {"Vortex",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[473] = {"Dinghy",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

[484] = {"Marquis",0, 0, 0, 0,r=128,g=0,b=128,r2=255,g2=255,b2=255},

}

------------------------------------------------------------------------  

local fairyCaptain = {

[453] = {"Reefer", 0, 0, 0, 0,r=255,g=255,b=0,r2=0,g2=0,b2=0},

}


------------------------------------------------------------------------  

local pinoyVehs = {

[560] = {"Sultan",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[411] = {"Infernus",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[522] = {"NRG-500",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[541] = {"Bullet",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[578] = {"DFT-30",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[495] = {"Sandking",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[437] = {"Coach",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[451] = {"Turismo",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[506] = {"Super GT",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[479] = {"Regina",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

}

------------------------------------------------------------------------  

local pinoyAir = {

[487] = {"Maverick",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[519] = {"Shamal",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

[447] = {"Seasparrow",0, 0, 0, 0,r=121,g=121,b=121,r2=255,g2=255,b2=255},

}


------------------------------------------------------------------------  

local SpecialVehs = {

[560] = {"Sultan",0, 0, 0, 0,r=100,g=0,b=100,r2=0,g2=0,b2=0},

[411] = {"Infernus",0, 0, 0, 0,r=100,g=0,b=100,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0, 0, 0, 0,r=100,g=0,b=100,r2=0,g2=0,b2=0},

[451] = {"Turismo",0, 0, 0, 0,r=100,g=0,b=100,r2=255,g2=255,b2=255},

}

------------------------------------------------------------------------  

local SpecialChoppers = {

[487] = {"Maverick",0, 0, 0, 0,r=100,g=0,b=100,r2=0,g2=0,b2=0},

}

------------------------------------------------------------------------  

local SpecialAir = {

[519] = {"Shamal",0, 0, 0, 0,r=100,g=0,b=100,r2=0,g2=0,b2=0},

}

------------------------------------------------------------------------  

--SAT

local satheli = {
------------------------------------------------------------------------
[487] = {"Maverick",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

}

------------------------------------------------------------------------  

local satCars ={

[528] = {"FBI Truck",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[427] = {"Enforcer",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[596] = {"Police Car (LS)",0,0,0,0,r=0,g=0,b=255,r2=0,g2=170,b2=0},

[599] = {"Police Ranger",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[490] = {"FBI Rancher",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[601] = {"S.W.A.T.",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[560] = {"Sultan",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[415] = {"Cheetah",0,0,0,0,r=22,g=22,b=22,r2=0,g2=0,b2=0},

[500] = {"Mesa",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[451] = {"Turismo",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[522] = {"NRG-500",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[411] = {"Infernus",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[541] = {"Bullet", 0,0,0,0,r=0,g=0,b=255,r2=0,g2=170,b2=0},

}

local satwater = {

[452] = {"Speeder",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},
[446] = {"Squalo",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},
[472] = {"Coast Guard",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

}

local satAir = {
------------------------------------------------------------------------
[487] = {"Maverick",0,0,0,0,r=0,g=0,b=255,r2=0,g2=0,b2=0},

[519] = {"Shamal",0, 0, 0, 0,r=0,g=0,b=255,r2=0,g2=0,b2=0},
}

------------------------------------------------------------------------  



local vehicleMarkers = {

--GIGN
--{ 1991.32, -102.63, 35.47,0,0,100,gignCars,"GIGN","nil",90,"aGroup",nil,nil,nil,"GIGN"},
--{ 2063.62, -180.36, 36.6,0,0,100,gignFly,"GIGN","nil",270,"aGroup",nil,nil,nil,"GIGN"},
--{2005.98, -181.6, 58.84,0,0,100,gignheli,"GIGN","nil",0,"aGroup",nil,nil,nil,"GIGN"},

	--{-27.799999237061, 244.5, 8.6999998092651, 0, 0, 100, GIGN2019_vehicles, "Government","GIGN", 240.002746, "aGroup",nil,nil,nil,"GIGN"},
	--{-22.89999961853, 253.30000305176, 8.6999998092651, 0, 0, 100, GIGN2019_vehicles, "Government","GIGN", 240.002746, "aGroup",nil,nil,nil,"GIGN"},
	--{-17.89999961853, 262, 8.6999998092651, 0, 0, 100, GIGN2019_vehicles, "Government","GIGN", 240.002746, "aGroup",nil,nil,nil,"GIGN"},
	--{44.299999237061, 192.69999694824, 1.6000000238419, 0, 0, 100, GIGN2019_vehicles, "Government","GIGN", 59.2526245, "aGroup",nil,nil,nil,"GIGN"},
	--{39.599998474121, 214.69999694824, 1.6000000238419, 0, 0, 100, GIGN2019_vehicles, "Government","GIGN", 242.252288, "aGroup",nil,nil,nil,"GIGN"},
	--{49.099998474121, 247.5, 1.6000000238419, 0, 0, 100, GIGN2019_vehicles, "Government","GIGN", 240, "aGroup",nil,nil,nil,"GIGN"},
	--{-43.200000762939, 304.70001220703, 8.8000001907349, 0, 0, 100, GIGN2019_planes, "Government","GIGN", 330.002746, "aGroup",nil,nil,nil,"GIGN"},
	--{64.7, 261.4, 34.2, 0, 0, 100, GIGN2019_helicopters, "Government","GIGN", 180, "aGroup",nil,nil,nil,"GIGN"},
	--{112.80000305176, 328.70001220703, 0.60000002384186, 0, 0, 100, GIGN2019_boats, "Government","GIGN", 328.002593, "aGroup",nil,nil,nil,"GIGN"},
------------------------------------------------------------------------------------------------

--The Exorcist
--{ 2675.26, 513.73, 27.63,118,8,215,exocars,"Criminals","nil",360,"aGroup",nil,nil,nil,"The Exorcist"},
--{ 2669.62,513.73,27.63,118,8,215,exocars,"Criminals","nil",360,"aGroup",nil,nil,nil,"The Exorcist"},
--{ 2664.25,513.16,27.63,118,8,215,exocars,"Criminals","nil",360,"aGroup",nil,nil,nil,"The Exorcist"},
--{ 2690.22,478.82,27.61,118,8,215,exoFly,"Criminals","nil",90,"aGroup",nil,nil,nil,"The Exorcist"},
--{ 2633.46,479.2,27.54,118,8,215,exoAir,"Criminals","nil",90,"aGroup",nil,nil,nil,"The Exorcist"},
------------------------------------------------------------------------------------------------

--DreamChacers
--{ 1956.69, 506.45, 21.98,66, 161, 244,dcCars,"Criminals","nil",360,"aGroup",nil,nil,nil,"DreamChacers"},
--{ 1966.23, 506.45, 21.98,66, 161, 244,dcCars,"Criminals","nil",360,"aGroup",nil,nil,nil,"DreamChacers"},
--{ 1975.5, 506.45, 21.98,66, 161, 244,dcCars,"Criminals","nil",360,"aGroup",nil,nil,nil,"DreamChacers"},
--{ 1961.81, 586.33, 24.52,66, 161, 244,dcFly,"Criminals","nil",90,"aGroup",nil,nil,nil,"DreamChacers"},
------------------------------------------------------------------------------------------------

--HolyCrap
	--{ 2153.44, 3113.71, 46.69,0,0,102,hcCars,"HolyCrap","nil",0,"aGroup",nil,nil,nil,"HolyCrap"},
	--{ 1983.48, 3260.84, 46.61,0,0,102,hcAir,"HolyCrap","nil",270,"aGroup",nil,nil,nil,"HolyCrap"},
	--{ 2243.47, 3115.08, -0.56,0,0,102,hcWater,"HolyCrap","nil",360,"aGroup",nil,nil,nil,"HolyCrap"},
	--{ 2148.99, 3114.86, 46.69,hcCars,"HolyCrap","nil",0,"aGroup",nil,nil,nil,"HolyCrap"},
	--{ 2175.18, 3124.69, 49.22,0,0,0,102,hcFly,"HolyCrap","nil",0,"aGroup",nil,nil,nil,"HolyCrap"},

------------------------------------------------------------------------------------------------

--SSG Position: 
--{ 152.45, 320.51, 2.82 ,22,22,22,ssgheli,"Government","nil",90,"aGroup",nil,nil,nil,"SSG"}, 
--{ 85.15, 297.69, 4.52 ,22,22,22,ssgheli,"Government","nil",270,"aGroup",nil,nil,nil,"SSG"},
--{ 182.46, 378.87, 1.93 ,22,22,22,ssgheli,"Government","nil",270,"aGroup",nil,nil,nil,"SSG"},
--{ 150.46, 462.63, 1.96 ,22,22,22,ssgCars,"Government","nil",90,"aGroup",nil,nil,nil,"SSG"},
--{ 150.75, 477.28, 1.97 ,22,22,22,ssgCars,"Government","nil",90,"aGroup",nil,nil,nil,"SSG"},
--{ 151.03, 492.41, 1.98 ,22,22,22,ssgCars,"Government","nil",90,"aGroup",nil,nil,nil,"SSG"},
--{ -112.43, 385.79, -0.56 ,22,22,22,ssgwater,"Government","nil",90,"aGroup",nil,nil,nil,"SSG"},
------------------------------------------------------------------------------------------------
 
--DF
	--{ 1954.09, -751.93, 138.44,0,128,128,DFCars,"Government","nil",288,"aGroup",nil,nil,nil,"Delta Force"},
	--{ 1957.76, -766.93, 138.44,0,128,128,DFCars,"Government","nil",288,"aGroup",nil,nil,nil,"Delta Force"},
	--{ 1984, -814.19, 141.32,0,128,128,DFHeli,"Government","nil",288,"aGroup",nil,nil,nil,"Delta Force"},
	--{ 2033.53, -701.43, 132.69,0,128,128,DFFly,"Government","nil",17,"aGroup",nil,nil,nil,"Delta Force"},

------------------------------------------------------------------------------------------------
 
--Cobras
	{ 992.49, 1382.58, 21.79,0,90,0,CobCars,"Criminals","nil",90,"aGroup",nil,nil,nil,"The Cobras"},
	{ 992.49, 1377.65, 21.79,0,90,0,CobCars,"Criminals","nil",90,"aGroup",nil,nil,nil,"The Cobras"},
	{ 901.84, 1422.04, 38.96,0,90,0,CobFly,"Criminals","nil",0,"aGroup",nil,nil,nil,"The Cobras"},
	{ 852.21, 1491.96, 51.14,0,90,0,CobHeli,"Criminals","nil",270,"aGroup",nil,nil,nil,"The Cobras"},
	--{ 1984, -814.19, 141.32,0,128,128,DFHeli,"Criminals","nil",288,"aGroup",nil,nil,nil,"The Cobras"},
	--{ 2033.53, -701.43, 132.69,0,128,128,DFFly,"Criminals","nil",17,"aGroup",nil,nil,nil,"The Cobras"},

---------------------------------------------------------------------------------------------------

--FBI
	{ 2868.81, -343.45, 8.75,0,118,240,FBICars,"Government","nil",108.47,"aGroup",nil,nil,nil,"Federal Bureau Of Investigations"},
	{ 2875.2, -355.4, 8.75,0,118,240,FBICars,"Government","nil",124.65,"aGroup",nil,nil,nil,"Federal Bureau Of Investigations"},
	{ 2931.25, -373.97, 15.64,0,118,240,FBIFly,"Government","nil",336.62,"aGroup",nil,nil,nil,"Federal Bureau Of Investigations"},
	{ 2886.27, -301.1, 30.34,0,118,240,FBIHeli,"Government","nil",69.4,"aGroup",nil,nil,nil,"Federal Bureau Of Investigations"},
	{ 2890.59, -288.89, 30.34,0,118,240,FBIHeli,"Government","nil",69.4,"aGroup",nil,nil,nil,"Federal Bureau Of Investigations"},

---------------------------------------------------------------------------------------------------
-- Advanced Assault Forces
	{227.59, 1877.49, 17.64, 84, 107, 46, affVehicles, "Government","Advanced Assault Forces", 356.49185180664, "aGroup",nil,nil,nil,"Advanced Assault Forces"},
	{203.04, 1877.49, 17.64, 84, 107, 46, affVehicles, "Government","Advanced Assault Forces", 356.49185180664, "aGroup",nil,nil,nil,"Advanced Assault Forces"},
	{308.39, 2037.74, 17.64, 84, 107, 46, aafVehicles_Aircraft_Plane, "Government","Advanced Assault Forces", 179.96197509766, "aGroup",nil,nil,nil,"Advanced Assault Forces"},	
	{235.82, 1969.28, 18.53, 84, 107, 46, aafVehicles_Aircraft_Copter, "Government","Advanced Assault Forces", 90, "aGroup",nil,nil,nil,"Advanced Assault Forces"},	
-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Government Agency
--{309.67, 181.12, 5.62 , 60,60,60, fbiCars, "Government", nil, 307.34185791016, "aGroup",nil,nil,nil,"Government Agency"  },
--{303.58, 188.55, 5.62 , 60,60,60, fbiCars, "Government", nil, 309.518280029, "aGroup",nil,nil,nil,"Government Agency"  },
--{285.77, 128.68, 5.77 , 60,60,60, spfFly, "Government", nil, 38.878753662109, "aGroup",nil,nil,nil,"Government Agency"  },
--{302.88, 181.2, 27.03 , 60,60,60, spfAir, "Government", nil, 217.56965637207, "aGroup",nil,nil,nil,"Government Agency"  },
--{225.21, 242.79, -0.56 , 60,60,60, spfWater, "Government", nil, 23.88241577148, "aGroup",nil,nil,nil,"Government Agency"  },
------------------------------------------------------------------------------------------------

--SPF 
--{ 3072.46, -100.41, 21.53, 40,0,80,spfCars,"Government","nil",0,"aGroup",nil,nil,nil,"Special PoliceForce"},
--{ 3062.69, -100.41, 21.54, 40,0,80,spfCars,"Government","nil",0,"aGroup",nil,nil,nil,"Special PoliceForce"},
--{ 3127.7, 23.93, 39.83, 40,0,80,spfCars,"Government","nil",0,"aGroup",nil,nil,nil,"Special PoliceForce"},
--{ 3170.49, -48.38, 39.88, 40,0,80,spfAir,"Government","nil",0,"aGroup",nil,nil,nil,"Special PoliceForce"},
--{ 3151.92, -93.88, 43.06, 40,0,80,spfChoppers,"Government","nil",0,"aGroup",nil,nil,nil,"Special PoliceForce"}, 
--{ 3119.73, 191.23, -0.56, 40,0,80,spfBoats,"Government","nil",0,"aGroup",nil,nil,nil,"Special PoliceForce"}, 

------------------------------------------------------------------------------------------------

-- The Terrorists

{ 2567.39, 539.81, 12.66,255,255,0,terrVehs,"Criminals","nil",267,"aGroup",nil,nil,nil,"The Terrorists"},
{ 2575.57, 539.77, 12.66,255,255,0,terrVehs,"Criminals","nil",90,"aGroup",nil,nil,nil,"The Terrorists"},
{ 2663.06, 500.42, 33.26,255,255,0,terrChop,"Criminals","nil",360,"aGroup",nil,nil,nil,"The Terrorists"},
{ 2565.72, 492.12, 30.6,255,255,0,terrAir,"Criminals","nil",90,"aGroup",nil,nil,nil,"The Terrorists"},
{ 2571.64, 418.51, -0.56,255,255,0,terrWater,"Criminals","nil",175,"aGroup",nil,nil,nil,"The Terrorists"},

------------------------------------------------------------------------------------------------

-- Kilo Tray Crips

-- { 2140.87, 544.74, 13.6, 0, 0, 150,b13Vehs,"Criminals","nil",0,"aGroup",nil,nil,nil,"Kilo Tray Crips"},
-- { 2131.93, 544.74, 13.6, 0, 0, 150,b13Vehs,"Criminals","nil",0,"aGroup",nil,nil,nil,"Kilo Tray Crips"},
-- { 1894.01, 569.27, 34.72, 0, 0, 150,b13Choppers,"Criminals","nil",270,"aGroup",nil,nil,nil,"Kilo Tray Crips"},
-- { 1962.4, 586.95, 31.88, 0, 0, 150,b13Air,"Criminals","nil",270,"aGroup",nil,nil,nil,"Kilo Tray Crips"},
-- { 1882.97, 492.38, -0.56, 0, 0, 150,b13Water,"Criminals","nil", 180,"aGroup",nil,nil,nil,"Kilo Tray Crips"},
------------------------------------------------------------------------------------------------

-- Pinoy's Pride

-- { 876.99, 2071, 19.26, 0, 0, 0,pinoyVehs,"Criminals","nil",0,"aGroup",nil,nil,nil,"Pinoy Pride"},
-- { 884.3, 2071, 19.26, 0, 0, 0,pinoyVehs,"Criminals","nil",0,"aGroup",nil,nil,nil,"Pinoy Pride"},
-- { 891.48, 2071, 19.26, 0, 0, 0,pinoyVehs,"Criminals","nil",0,"aGroup",nil,nil,nil,"Pinoy Pride"},
-- { 881.68, 2174.96, 20.82, 0, 0, 0,pinoyAir,"Criminals","nil",90,"aGroup",nil,nil,nil,"Pinoy Pride"},
-- { 866.4, 2231.32, 19.08, 0, 0, 0,pinoyAir,"Criminals","nil",0,"aGroup",nil,nil,nil,"Pinoy Pride"},

------------------------------------------------------------------------------------------------

-- Special Mafia

-- { 3204.9, 2115.51, 13.13, 0, 0, 0,SpecialVehs,"Criminals","nil",90,"aGroup",nil,nil,nil,"Special Mafia"},
-- { 3204.76, 2124.52, 13.13, 0, 0, 0,SpecialVehs,"Criminals","nil",90,"aGroup",nil,nil,nil,"Special Mafia"},
-- { 3242.68, 2207.6, 13.11, 0, 0, 0,SpecialChoppers,"Criminals","nil",270,"aGroup",nil,nil,nil,"Special Mafia"},
-- { 3243.49, 2154.86, 12.94, 0, 0, 0,SpecialAir,"Criminals","nil",0,"aGroup",nil,nil,nil,"Special Mafia"},

------------------------------------------------------------------------------------------------

--SAT 
-- { 302.75, 181.47, 27.03 ,0,0,255,satheli,"Government","nil",90,"aGroup",nil,nil,nil,"Special Assault Team"}, 
-- { 312.94, 169.47, 27.03 ,0,0,255,satheli,"Government","nil",270,"aGroup",nil,nil,nil,"Special Assault Team"},
-- { 309.86, 181.26, 5.62 ,0,0,255,satCars,"Government","nil",310,"aGroup",nil,nil,nil,"Special Assault Team"},
-- { 304.01, 188.22, 5.62 ,0,0,255,satCars,"Government","nil",310,"aGroup",nil,nil,nil,"Special Assault Team"},
-- { 278.75, 136.67, 6.14, 0, 0, 255,satAir,"Government","nil",40,"aGroup",nil,nil,nil,"Special Assault Team"},
-- { 239.36, 244.35, 0.17, 0, 0, 255,satwater,"Government","nil",90,"aGroup",nil,nil,nil,"Special Assault Team"},


------------------------------------------------------------------------------------------------

--Job
{2490.24, -2737.72, -0.56 , 255,255,0, fairyCaptain, "Civilian Workers", "Fairy Captain", 180, "aGroup",nil,nil,nil,nil  },

}




                                                                          -------------------------------------------------------------------------------------------------

                                                                                                -------------- CHANGE ONLY STUFF BETWEEN THIS AND ABOVE ------------

                                                                                                         --------------------------------------------------------------------



--SCRIPT--



local JobsToTables = {



}



local asdmarkers = {}

local workingWithTable=false

for i,v in pairs(vehicleMarkers) do

    if getPlayerTeam ( localPlayer ) then

        local overRide=false

        if v[8] ~= nil and v[8] == "Government" then

            if getTeamName(getPlayerTeam ( localPlayer )) == "Police" or getTeamName(getPlayerTeam ( localPlayer )) == "Government" or getTeamName(getPlayerTeam ( localPlayer )) == "GIGN" or getTeamName(getPlayerTeam ( localPlayer )) == "Military Forces" then

               -- overRide=true

            end

        end

        if overRide==false and getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or

            getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer,"Group") == v[15] or

            getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil then



            elref = createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])

            asdmarkers [elref ] = v[7]

            setElementData(elref, "freeVehiclesSpawnRotation", v[10])

            setElementData(elref, "isMakerForFreeVehicles", true)



            if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end
			if ( v[11] == "aBusiness" ) then setElementData(elref, "businessMarkerName", v[15] ) end
        end

    end

end



local workingWith = {}

local proWith = {}

local modWith = {}

local count = 0

HydraRow = 0

RustlerRow = 0

HunterRow = 0

SeasparrowRow = 0

RhinoRow = 0



addEventHandler("onClientMarkerHit", root, function(hitElement, matchingDimension)

if getElementType ( hitElement ) == "player" and getElementData(source, "isMakerForFreeVehicles") == true and hitElement == localPlayer then

    guiGridListClear ( vehiclesGrid )

    if not isPedInVehicle(localPlayer) then

        if (asdmarkers [source] ) then

            workingWithTable=asdmarkers [source]

			HydraRow = 0

			RustlerRow = 0

			HunterRow = 0

			SeasparrowRow = 0

			RhinoRow = 0

            for i,v in pairs( asdmarkers [source] ) do

                if hitElement == localPlayer then

					if i then

						local px,py,pz = getElementPosition ( hitElement )

						local mx, my, mz = getElementPosition ( source )

							if ( pz-3 < mz ) and ( pz+3 > mz ) then

								if (( getElementData( source, "groupMarkerName" ) ) and ( getElementData( localPlayer, "Group" ) ~= "None" ) and not ( getElementData( source, "groupMarkerName" ) == getElementData( localPlayer, "Group" ) ) ) or ( getElementData( source, "businessMarkerName" ) ) and ( getElementData( localPlayer, "Business" ) ~= "None" ) and not ( getElementData( source, "businessMarkerName" ) == getElementData( localPlayer, "Business" ) ) then
									exports.NGCdxmsg:createNewDxMessage("You are not allowed to use this vehicle marker!", 225 ,0 ,0)

								else


									if	(( getElementData( source, "groupMarkerName" ) ) and (getElementData(localPlayer, "Group") == "None")) or (( getElementData( source, "businessMarkerName" ) ) and (getElementData(localPlayer, "Business") == "None")) then

										exports.NGCdxmsg:createNewDxMessage("You are not allowed to use this vehicle marker!", 225 ,0 ,0)

										return

									end

									local row = guiGridListAddRow ( vehiclesGrid )

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

										--outputDebugString(count.." with "..row.." with "..i)

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



									guiSetVisible (vehiclesWindow, true)

									showCursor(true,true)



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

end)



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

end-- Reload the markers

function reloadFreeVehicleMarkers ()

    for i,v in pairs( asdmarkers ) do

        destroyElement(i)

    end



    asdmarkers = {}



    for i,v in pairs(vehicleMarkers) do

        if getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer, "Occupation") == v[9] or 
		
		
		
		
			getTeamName(getPlayerTeam ( localPlayer )) == v[8] and v[11] == "noOccupation" or getTeamName(getPlayerTeam ( localPlayer )) == v[8] and getElementData(localPlayer,"Group") == v[15] or




            getTeamName(getPlayerTeam ( localPlayer )) == v[11] or getTeamName(getPlayerTeam ( localPlayer )) == v[12] or v[8] == nil and v[9] == nil or 
			
			
			v[8] == "Military Forces" and getTeamName(getPlayerTeam(localPlayer)) == "Government" then



            elref =  createMarker(v[1], v[2], v[3] -1, "cylinder", 2.2, v[4], v[5], v[6])

            asdmarkers [elref ] = v[7]

            setElementData(elref, "freeVehiclesSpawnRotation", v[10])

            setElementData(elref, "isMakerForFreeVehicles", true)



            if ( v[11] == "aGroup" ) then setElementData(elref, "groupMarkerName", v[15] ) end

			if ( v[11] == "aBusiness" ) then setElementData(elref, "businessMarkerName", v[15] ) end        end

    end

end

addEvent("reloadFreeVehicleMarkers", true)

addEventHandler("reloadFreeVehicleMarkers", root, reloadFreeVehicleMarkers )



function spawnTheVehicle ()

	if getElementDimension(localPlayer) ~= 0 then return false end

local x,y,z = getElementPosition(theMarker)

local selectedVehicle = guiGridListGetItemText ( vehiclesGrid, guiGridListGetSelectedItem ( vehiclesGrid ), 1 )

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

        ---if ( tonumber( theVehicleID) == 481 ) or ( tonumber( theVehicleID) == 510 ) or ( tonumber( theVehicleID) == 509 ) or ( tonumber( theVehicleID) == 462 ) or ( getElementData( localPlayer, "Occupation" ) == "Drugs farmer" ) then

        if ( getElementData( localPlayer, "Occupation" ) == "Drugs farmer" ) then

			exports.NGCdxmsg:createNewDxMessage("You are drugs farmer! you can't spawn from here!!", 225 ,0 ,0)

			return false

		end

        if ( getElementData( localPlayer, "wantedPoints" ) >= 200 ) then

            exports.NGCdxmsg:createNewDxMessage("You can't spawn vehicles when you have more than 200 wanted points!", 225 ,0 ,0)

			return

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

            guiSetVisible (vehiclesWindow, false)

            showCursor(false,false)

            guiGridListClear ( vehiclesGrid )

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

--[[400: Landstalker

401: Bravura

402 : Buffalo

403 : Linerunner

404 : Perenail

405 : Sentinel

406 : Dumper

407 : Firetruck

408 : Trashmaster

409 : Stretch

410 : Manana

411 : Infernus

412 : Voodoo

413 : Pony

414 : Mule

415 : Cheetah

416 : Ambulance

417 : Levetian

418 : Moonbeam

419 : Esperanto

420 : Taxi

421 : Washington

422 : Bobcat

423 : Mr Whoopee

424 : BF Injection

425 : Hunter

426 : Premier

427 : Enforcer

428 : Securicar

429 : Banshee

430 : Predator

431 : Bus

432 : Rhino

433 : Barracks

434 : Hotknife

435 : Artic trailer 1

436 : Previon

437 : Coach

438 : Cabbie

439 : Stallion

440 : Rumpo

441 : RC Bandit

442 : Romero

443 : Packer

444 : Monster

445 : Admiral

446 : Squalo

447 : Seasparrow

448 : Pizza boy

449 : Tram

450 : Artic trailer 2

451 : Turismo

452 : Speeder

453 : Reefer

454 : Tropic

455 : Flatbed

456 : Yankee

457 : Caddy

458 : Solair

459 : Top fun

460 : Skimmer

461 : PCJ 600

462 : Faggio

463 : Freeway

464 : RC Baron

465 : RC Raider

466 : Glendale

467 : Oceanic

468 : Sanchez

469 : Sparrow

470 : Patriot

471 : Quad

472 : Coastgaurd

473 : Dinghy

474 : Hermes

475 : Sabre

476 : Rustler

477 : ZR 350

478 : Walton

479 : Regina

480 : Comet

481 : BMX

482 : Burriro

483 : Camper

484 : Marquis

485 : Baggage

486 : Dozer

487 : Maverick

488 : VCN Maverick

489 : Rancher

490 : FBI Rancher

491 : Virgo

492 : Greenwood

493 : Jetmax

494 : Hotring

495 : Sandking

496 : Blistac

497 : Government maverick

498 : Boxville

499 : Benson

500 : Mesa

501 : RC Goblin

502 : Hotring A

503 : Hotring B

504 : Blood ring banger

505 : Rancher (lure)

506 : Super GT

507 : Elegant

508 : Journey

509 : Bike

510 : Mountain bike

511 : Beagle

512 : Cropduster

513 : Stuntplane

514 : Petrol

515 : Roadtrain

516 : Nebula

517 : Majestic

518 : Buccaneer

519 : Shamal

520 : Hydra

521 : FCR 900

522 : NRG 500

523 : HPV 1000

524 : Cement

525 : Towtruck

526 : Fortune

527 : Cadrona

528 : FBI Truck

529 : Williard

530 : Fork lift

531 : Tractor

532 : Combine

533 : Feltzer

534 : Remington

535 : Slamvan

536 : Blade

537 : Freight

538 : Streak

539 : Vortex

540 : Vincent

541 : Bullet

542 : Clover

543 : Sadler

544 : Firetruck LA

545 : Hustler

546 : Intruder

547 : Primo

548 : Cargobob

549 : Tampa

550 : Sunrise

551 : Merit

552 : Utility van

553 : Nevada

554 : Yosemite

555 : Windsor

556 : Monster A

557 : Monster B

558 : Uranus

559 : Jester

560 : Sultan

561 : Stratum

562 : Elegy

563 : Raindance

564 : RC Tiger

565 : Flash

566 : Tahoma

567 : Savanna

568 : Bandito

569 : Freight flat

570 : Streak

571 : Kart

572 : Mower

573 : Duneride

ID  : Actual name

574 : Sweeper

575 : Broadway

576 : Tornado

577 : AT 400

578 : DFT 30

579 : Huntley

580 : Stafford

581 : BF 400

582 : News van

583 : Tug

584 : Petrol tanker

585 : Emperor

586 : Wayfarer

587 : Euros

588 : Hotdog

589 : Club

590 : Freight box

591 : Artic trailer 3

592 : Andromada

593 : Dodo

594 : RC Cam

595 : Launch

596 : Cop car LS

597 : Cop car SF

598 : Cop car LV

599 : Ranger

600 : Picador

601 : Swat tank

602 : Alpha

603 : Phoenix

604 : Glendale (damage)

605 : Sadler (damage)

606 : Bag box A

607 : Bag box B

608 : Stairs

609 : Boxville (black)

610 : Farm trailer

611 : Utility van trailer

 ]]