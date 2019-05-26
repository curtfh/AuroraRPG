local carData = {}
local defaultCarData = {}
local newCarData = {}
local isBought = 0

GUIEditor = {
    button = {},
    label = {}
}

local screenWidth, screenHeight = guiGetScreenSize()
------------------------------------------------------------------------------------
--  GUI Design --
------------------------------------------------------------------------------------

-- Main Window --

windowMain = guiCreateWindow((screenWidth-640)/2, (screenHeight-440)/2, 625, 499, "NGC ~ Tune", false)
guiWindowSetSizable(windowMain, false)
guiSetAlpha(windowMain, 0.90)
guiSetVisible(windowMain, false)

tabpanel = guiCreateTabPanel((640 - 587) / 2, 20, 587, 381, false, windowMain)

main = guiCreateTab("Tunning", tabpanel)

tab3 = guiCreateScrollPane(5, 7, 577, 343, false, main)

GUIEditor.label[1] = guiCreateLabel(30, 40, 120, 30, "Engine Type : ", false, tab3)
w1bar1 = guiCreateScrollBar(200, 40, 300, 20, true, false, tab3)
GUIEditor.label[2] = guiCreateLabel(200, 60, 60, 30, "petrol", false, tab3)
GUIEditor.label[3] = guiCreateLabel(320, 60, 60, 30, "diesel", false, tab3)
GUIEditor.label[4] = guiCreateLabel(440, 60, 60, 30, "electric", false, tab3)
GUIEditor.label[5] = guiCreateLabel(30, 90, 120, 30, "Control Unit : ", false, tab3)
w1bar3 = guiCreateScrollBar(200, 90, 300, 20, true, false, tab3)
GUIEditor.label[6] = guiCreateLabel(200, 110, 120, 30, "Top Speed", false, tab3)
GUIEditor.label[8] = guiCreateLabel(430, 110, 80, 30, "Acceleration", false, tab3)
GUIEditor.label[9] = guiCreateLabel(30, 140, 120, 30, "Drive Type : ", false, tab3)
w1bar4 = guiCreateScrollBar(200, 140, 300, 20, true, false, tab3)
GUIEditor.label[10] = guiCreateLabel(200, 160, 120, 30, "fwd", false, tab3)
GUIEditor.label[11] = guiCreateLabel(330, 160, 40, 30, "awd", false, tab3)
GUIEditor.label[12] = guiCreateLabel(460, 160, 40, 30, "rwd", false, tab3)
GUIEditor.label[13] = guiCreateLabel(30, 190, 120, 30, "Gears : ", false, tab3)
w1bar2 = guiCreateScrollBar(200, 190, 300, 20, true, false, tab3)
GUIEditor.label[14] = guiCreateLabel(250, 210, 30, 30, "1", false, tab3)
GUIEditor.label[15] = guiCreateLabel(300, 210, 30, 30, "2", false, tab3)
GUIEditor.label[16] = guiCreateLabel(350, 210, 30, 30, "3", false, tab3)
GUIEditor.label[17] = guiCreateLabel(400, 210, 30, 30, "4", false, tab3)
GUIEditor.label[18] = guiCreateLabel(450, 210, 30, 30, "5", false, tab3)
GUIEditor.label[19] = guiCreateLabel(30, 240, 120, 30, "Steering : ", false, tab3)
w1bar5 = guiCreateScrollBar(200, 240, 300, 20, true, false, tab3)
GUIEditor.label[20] = guiCreateLabel(200, 260, 120, 30, "Tight", false, tab3)
GUIEditor.label[21] = guiCreateLabel(350, 260, 20, 30, "|", false, tab3)
GUIEditor.label[22] = guiCreateLabel(430, 260, 80, 30, "Loose", false, tab3)
GUIEditor.label[23] = guiCreateLabel(30, 331, 120, 30, "Fluid Pressure : ", false, tab3)
w2bar1 = guiCreateScrollBar(200, 331, 300, 20, true, false, tab3)
GUIEditor.label[24] = guiCreateLabel(200, 351, 40, 30, "less", false, tab3)
GUIEditor.label[25] = guiCreateLabel(480, 351, 40, 30, "more", false, tab3)
GUIEditor.label[26] = guiCreateLabel(30, 391, 120, 30, "Damping : ", false, tab3)
w2bar2 = guiCreateScrollBar(200, 397, 300, 20, true, false, tab3)
GUIEditor.label[27] = guiCreateLabel(200, 417, 40, 30, "min", false, tab3)
GUIEditor.label[28] = guiCreateLabel(480, 417, 40, 30, "max", false, tab3)
GUIEditor.label[29] = guiCreateLabel(34, 459, 120, 30, "HighSpeed Damping : ", false, tab3)
w2bar3 = guiCreateScrollBar(200, 459, 300, 20, true, false, tab3)
GUIEditor.label[30] = guiCreateLabel(200, 479, 120, 30, "min", false, tab3)
GUIEditor.label[31] = guiCreateLabel(480, 479, 40, 30, "max", false, tab3)
GUIEditor.label[32] = guiCreateLabel(34, 538, 120, 30, "UpperLimit : ", false, tab3)
w2bar4 = guiCreateScrollBar(200, 528, 300, 20, true, false, tab3)
guiScrollBarSetScrollPosition(w2bar4, 100.0)
GUIEditor.label[33] = guiCreateLabel(204, 562, 120, 30, "high", false, tab3)
GUIEditor.label[34] = guiCreateLabel(484, 558, 40, 30, "low", false, tab3)
GUIEditor.label[35] = guiCreateLabel(34, 608, 120, 30, "LowerLimit : ", false, tab3)
w2bar5 = guiCreateScrollBar(200, 602, 300, 20, true, false, tab3)
GUIEditor.label[36] = guiCreateLabel(204, 628, 120, 30, "low", false, tab3)
GUIEditor.label[37] = guiCreateLabel(484, 628, 40, 30, "high", false, tab3)
GUIEditor.label[38] = guiCreateLabel(34, 672, 120, 30, "Bias : ", false, tab3)
w2bar6 = guiCreateScrollBar(200, 672, 300, 20, true, false, tab3)
GUIEditor.label[39] = guiCreateLabel(200, 706, 120, 30, "rear", false, tab3)
GUIEditor.label[40] = guiCreateLabel(484, 702, 40, 30, "front", false, tab3)
GUIEditor.label[41] = guiCreateLabel(34, 758, 120, 30, "Distribution : ", false, tab3)
w4bar1 = guiCreateScrollBar(200, 758, 300, 20, true, false, tab3)
GUIEditor.label[42] = guiCreateLabel(204, 792, 90, 30, "light", false, tab3)
GUIEditor.label[43] = guiCreateLabel(480, 788, 90, 30, "heavy", false, tab3)
GUIEditor.label[44] = guiCreateLabel(34, 828, 120, 30, "Turn Inertia : ", false, tab3)
w4bar2 = guiCreateScrollBar(200, 828, 300, 20, true, false, tab3)
guiScrollBarSetScrollPosition(w4bar2, 100.0)
GUIEditor.label[45] = guiCreateLabel(204, 858, 40, 30, "less", false, tab3)
GUIEditor.label[46] = guiCreateLabel(484, 858, 40, 30, "more", false, tab3)
GUIEditor.label[47] = guiCreateLabel(34, 958, 120, 30, "Down-force : ", false, tab3)
w4bar3 = guiCreateScrollBar(200, 894, 300, 20, true, false, tab3)
guiScrollBarSetScrollPosition(w4bar3, 100.0)
GUIEditor.label[48] = guiCreateLabel(204, 918, 90, 30, "less", false, tab3)
GUIEditor.label[49] = guiCreateLabel(480, 918, 90, 30, "more", false, tab3)
GUIEditor.label[50] = guiCreateLabel(34, 894, 120, 30, "Anti-Roll Bar : ", false, tab3)
w4bar4 = guiCreateScrollBar(200, 958, 300, 20, true, false, tab3)
guiScrollBarSetScrollPosition(w4bar4, 100.0)
GUIEditor.label[51] = guiCreateLabel(200, 978, 40, 30, "soft", false, tab3)
GUIEditor.label[52] = guiCreateLabel(484, 978, 40, 30, "stiff", false, tab3)
GUIEditor.label[56] = guiCreateLabel(16, 6, 166, 24, "Engine & Transmission tune", false, tab3)
guiSetFont(GUIEditor.label[56], "default-bold-small")
guiLabelSetColor(GUIEditor.label[56], 71, 241, 12)
guiLabelSetHorizontalAlign(GUIEditor.label[56], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[56], "center")
GUIEditor.label[57] = guiCreateLabel(10, 290, 125, 15, "Suspension tune", false, tab3)
guiSetFont(GUIEditor.label[57], "default-bold-small")
guiLabelSetColor(GUIEditor.label[57], 71, 241, 12)
guiLabelSetHorizontalAlign(GUIEditor.label[57], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[57], "center")
GUIEditor.label[58] = guiCreateLabel(10, 732, 73, 14, "Body tune", false, tab3)
guiSetFont(GUIEditor.label[58], "default-bold-small")
guiLabelSetColor(GUIEditor.label[58], 44, 243, 11)
guiLabelSetHorizontalAlign(GUIEditor.label[58], "center", false)
guiLabelSetVerticalAlign(GUIEditor.label[58], "center")



button6 = guiCreateButton(62, 431, 126, 30, "Apply changes", false, windowMain)
button7 = guiCreateButton(441, 431, 122, 28, "Exit", false, windowMain)
buttonReset = guiCreateButton(246, 431, 126, 30, "Reset", false, windowMain)

------------------------------------------------------------------------------------
--  Handler Functions --
------------------------------------------------------------------------------------

function compareData (i, mul, newVal)
	local delta = defaultCarData[i] - newVal
	if (delta < 0) then delta = 0 - delta end
	if (delta > mul) then
		return true
	else
		return false
	end
end


function handleGuiClick()

	-- Exit
	if (source == button7) then
		showCursor(false)
		guiSetVisible(windowMain, false)

		local theVehicle = getPedOccupiedVehicle(localPlayer)
		setElementFrozen(theVehicle, false)
		setVehicleDamageProof(theVehicle,false)
		if (isBought == 1) then
			triggerServerEvent("buySession", localPlayer, localPlayer)
		end
	end

	-- Reset
	if (source == buttonReset) then
		local theCar = getPedOccupiedVehicle(localPlayer)
		local newCarData = defaultCarData
		newCarData["headLight"] = nil
		newCarData["tailLight"] = nil
		newCarData["monetary"] = nil
		triggerServerEvent("injectCarData", localPlayer, theCar, defaultCarData)
		triggerServerEvent("showTunePanel", localPlayer, localPlayer)
	end

	-- Save
	if (source == button6) then
		isBought = 1
		local theCar = getPedOccupiedVehicle(localPlayer)
		local mul = 0

		-- Transmission
		local etype = defaultCarData["engineType"]
		if (guiScrollBarGetScrollPosition(w1bar1) <= 33.33) then etype = "petrol" end
		if (guiScrollBarGetScrollPosition(w1bar1) > 33.33 and guiScrollBarGetScrollPosition(w1bar1) <= 66.66) then etype = "diesel" end
		if (guiScrollBarGetScrollPosition(w1bar1) > 66.66) then etype = "electric" end
		newCarData["engineType"] = etype

		local gears = defaultCarData["numberOfGears"]
		if (guiScrollBarGetScrollPosition(w1bar2) <= 20) then gears = 1 end
		if (guiScrollBarGetScrollPosition(w1bar2) > 20 and guiScrollBarGetScrollPosition(w1bar2) <= 40) then gears = 2 end
		if (guiScrollBarGetScrollPosition(w1bar2) > 40 and guiScrollBarGetScrollPosition(w1bar2) <= 60) then gears = 3 end
		if (guiScrollBarGetScrollPosition(w1bar2) > 60 and guiScrollBarGetScrollPosition(w1bar2) <= 80) then gears = 4 end
		if (guiScrollBarGetScrollPosition(w1bar2) > 80) then gears = 5 end
		newCarData["numberOfGears"] = gears

		local bar3 = math.floor(tonumber(guiScrollBarGetScrollPosition(w1bar3)))
		local inert = defaultCarData["engineInertia"]
		local vel = defaultCarData["maxVelocity"]
		local accel = defaultCarData["engineAcceleration"]
		if (bar3 > 40) then
			vel = vel - (vel*(bar3-40)/60)/2.2 - (60-(bar3-40)) --45% + (fix) decrease max
			accel = accel + (accel*(bar3-40)/60)*2 --200% increase max
			inert = inert --Remains Same
		else
			vel = vel --Remains Same
			accel = accel + (accel*(40-bar3)/40) --100% increase max
			inert = inert + ((40-bar3)/40*100)^1.3 --100^1.3 increase max
			if (inert > 1000) then inert = 1000 end
		end
		newCarData["engineInertia"] = inert
		newCarData["engineAcceleration"] = accel
		newCarData["maxVelocity"] = vel

		local dtype = defaultCarData["driveType"]
		if (guiScrollBarGetScrollPosition(w1bar4) <= 33.33) then dtype = "fwd" end
		if (guiScrollBarGetScrollPosition(w1bar4) > 33.33 and guiScrollBarGetScrollPosition(w1bar4) <= 66.66) then dtype = "awd" end
		if (guiScrollBarGetScrollPosition(w1bar4) > 66.66) then dtype = "rwd" end
		newCarData["driveType"] = dtype

		local bar5 = tonumber(guiScrollBarGetScrollPosition(w1bar5))
		bar5 = (bar5 - 50) * 0.2
		newCarData["steeringLock"] = defaultCarData["steeringLock"]+ bar5

		-- Suspension
		local bar1 = tonumber(guiScrollBarGetScrollPosition(w2bar1))
		mul = (5 - 0.5) / 100
		bar1 = 0.5 + bar1 * mul
		if (compareData("suspensionForceLevel", mul, bar1)) then
			newCarData["suspensionForceLevel"] = bar1
		end

		local bar2 = tonumber(guiScrollBarGetScrollPosition(w2bar2))
		mul = (1.51 - 0.01) / 100
		bar2 = 0.01 + bar2 * mul
		if (compareData("suspensionDamping", mul, bar2)) then
			newCarData["suspensionDamping"] = bar2
		end

		local bar3 = tonumber(guiScrollBarGetScrollPosition(w2bar3))
		mul = (5 - 0) / 100
		bar3 = 0 + bar3 * mul
		if (compareData("suspensionHighSpeedDamping", mul, bar3)) then
			newCarData["suspensionHighSpeedDamping"] = bar3
		end

		local bar4 = tonumber(guiScrollBarGetScrollPosition(w2bar4))
		mul = (0.5 - 0.1) / 100
		bar4 = 0.1 + bar4 * mul
		if (compareData("suspensionUpperLimit", mul, bar4)) then
			newCarData["suspensionUpperLimit"] = bar4
		end

		local bar5 = tonumber(guiScrollBarGetScrollPosition(w2bar5))
		mul = (0.21 - 0.01) / 100
		bar5 = 0.01 + bar5 * mul
		if (compareData("suspensionLowerLimit", mul, 0 - bar5)) then
			newCarData["suspensionLowerLimit"] = 0 - bar5
		end

		local bar6 = tonumber(guiScrollBarGetScrollPosition(w2bar6))
		mul = (0.8 - 0.2) / 100
		bar6 = 0.2 + bar6 * mul
		if (compareData("suspensionFrontRearBias", mul, bar6)) then
			newCarData["suspensionFrontRearBias"] = bar6
		end


		local bar1 = tonumber(guiScrollBarGetScrollPosition(w4bar1))
		mul = defaultCarData["mass"] / 100
		bar1 = (bar1 - 50) * mul
		if (compareData("mass", mul, defaultCarData["mass"]+bar1)) then
			newCarData["mass"] = defaultCarData["mass"] + bar1
		end

		local bar2 = tonumber(guiScrollBarGetScrollPosition(w4bar2))
		mul = defaultCarData["turnMass"] / 100
		bar2 = (bar2 - 50) * mul
		if (compareData("turnMass", mul, defaultCarData["turnMass"]+bar2)) then
			newCarData["turnMass"] = defaultCarData["turnMass"] + bar2
		end

		local bar3 = tonumber(guiScrollBarGetScrollPosition(w4bar3))
		mul = defaultCarData["dragCoeff"] / 100
		bar3 = (bar3 - 50) * mul
		if (compareData("dragCoeff", mul, defaultCarData["dragCoeff"]+bar3)) then
			newCarData["dragCoeff"] = defaultCarData["dragCoeff"] + bar3
		end

		local bar4 = tonumber(guiScrollBarGetScrollPosition(w4bar4))
		mul = (3.1 - 0.1) / 100
		bar4 = 0.1 + bar4 * mul
		if (compareData("suspensionAntiDiveMultiplier", mul, bar4)) then
			newCarData["suspensionAntiDiveMultiplier"] = bar4
		end

		triggerServerEvent("injectCarData", localPlayer, theCar, newCarData)
		setTimer(triggerServerEvent, 500, 1, "showTunePanel", localPlayer, localPlayer)
	end
end
addEventHandler("onClientGUIClick", root, handleGuiClick)



function guiLoadData ()

	-- Transmission
	local etype = carData["engineType"]
	if (etype == "petrol") then etype = 0 end
	if (etype == "diesel") then etype = 50 end
	if (etype == "electric") then etype = 100 end
	guiScrollBarSetScrollPosition(w1bar1, etype)

	local gears = carData["numberOfGears"]
	gears = (gears*20) - 10
	guiScrollBarSetScrollPosition(w1bar2, gears)

	local trans = tonumber(carData["engineAcceleration"]) - tonumber(defaultCarData["engineAcceleration"])
	local inert = tonumber(carData["engineInertia"]) - tonumber(defaultCarData["engineInertia"])
	if (inert == 0) then
		trans = (trans/defaultCarData["engineAcceleration"])*(60/2) + 40
	else
		trans = 40 - ((trans/defaultCarData["engineAcceleration"])*40)
	end
	guiScrollBarSetScrollPosition(w1bar3, trans)

	local dtype = carData["driveType"]
	if (dtype == "fwd") then dtype = 0 end
	if (dtype == "awd") then dtype = 50 end
	if (dtype == "rwd") then dtype = 100 end
	guiScrollBarSetScrollPosition(w1bar4, dtype)

	local bar5 = carData["steeringLock"]
	bar5 = (carData["steeringLock"] - defaultCarData["steeringLock"]) / 0.2
	guiScrollBarSetScrollPosition(w1bar5,(bar5 + 50))

	-- Suspension
	guiScrollBarSetScrollPosition(w2bar1, tonumber(((carData["suspensionForceLevel"] - 0.5)*100) /(5-0.5)))
	guiScrollBarSetScrollPosition(w2bar2, tonumber(((carData["suspensionDamping"] - 0.01)*100) /(1.51 - 0.01)))
	guiScrollBarSetScrollPosition(w2bar3, tonumber(((carData["suspensionHighSpeedDamping"] - 0) *100) /(5 - 0)))
	guiScrollBarSetScrollPosition(w2bar4, tonumber(((carData["suspensionUpperLimit"] - 0.1)*100) /(0.5 - 0.1)))
	guiScrollBarSetScrollPosition(w2bar5, tonumber(((-carData["suspensionLowerLimit"] - 0.01)*100) /(0.21 - 0.01)))
	guiScrollBarSetScrollPosition(w2bar6, tonumber(((carData["suspensionFrontRearBias"] - 0.2)*100) /(0.8 - 0.2)))

	local bar1 = carData["mass"]
	bar1 = (carData["mass"] - defaultCarData["mass"]) / (defaultCarData["mass"]/100)
	guiScrollBarSetScrollPosition(w4bar1,(bar1 + 50))

	local bar2 = carData["turnMass"]
	bar2 = (carData["turnMass"] - defaultCarData["turnMass"]) / (defaultCarData["turnMass"]/100)
	guiScrollBarSetScrollPosition(w4bar2,(bar2 + 50))

	local bar3 = carData["dragCoeff"]
	bar3 = (carData["dragCoeff"] - defaultCarData["dragCoeff"]) / (defaultCarData["dragCoeff"]/100)
	guiScrollBarSetScrollPosition(w4bar3,(bar3 + 50))

	guiScrollBarSetScrollPosition(w4bar4, tonumber(((carData["suspensionAntiDiveMultiplier"] - 0.1)*100) /(3.1 - 0.1)))

end

function showMain(theValue)
	newCarData = {}
	carData = theValue
	defaultCarData = getOriginalHandling(getElementModel(getPedOccupiedVehicle(localPlayer)))
	guiSetVisible(windowMain, true)
	showCursor(true)
	guiLoadData()
end
addEvent("showMain", true)
addEventHandler("showMain", localPlayer, showMain)


------------------------------------------------------------------------------------
--  Mapping --
------------------------------------------------------------------------------------

shopMarkers = {
	{ 1041.744, -1017.104, 31.1, 2.5 },
	{ -2723.7060, 217.2689, 3.6133, 2.5 },
	{ 1992.4794921875, 2084.6484375, 9.5, 2.5 },
	{ 2499.6159, -1779.8135, 12.8, 2.5 },
	{ 2386.773, 1050.792, 9.82, 2.5 },
	{ -1786.706, 1215.382, 24.12, 2.5 },
	{ -1205.187, 39.404, 12.85, 2.5 },
	{ 2005.45, -2453.623, 12.547, 2.5 },
	{ 1300.87, 1440.13, 9.82, 5 }, -- LV Airport
	{ -1935.95,245.95,33.5, 2.5 },
}


function onHit(thePlayer, mDim)
	if (thePlayer == localPlayer) then
		if (not (mDim)) then return end
		local theVehicle = getPedOccupiedVehicle(localPlayer)
		if (not (theVehicle)) then return end
		if (not (getVehicleOccupant(theVehicle) == localPlayer)) then return end
		if (not (getVehicleType(theVehicle) == "Automobile" or getVehicleType(theVehicle) == "Monster Truck")) then return end
		local px,py,pz = getElementPosition ( localPlayer )
		local mx, my, mz = getElementPosition ( source )
		if (isVehicleOnGround(theVehicle)) then
			if getElementData(theVehicle,"vehicleOwner") == localPlayer then
				if (not (getPlayerMoney() > 3500)) then return end
				triggerServerEvent("showTunePanel", localPlayer, localPlayer)
				isBought = 0
				setTimer(setElementFrozen, 270, 1, theVehicle, true)
				setVehicleDamageProof(theVehicle,true)
			else
				exports.NGCdxmsg:createNewDxMessage("You can't tune a free vehicle or an other player vehicle.",255,0,0)
			end
		end
	end
end


for i, v in ipairs (shopMarkers) do
	local theMarker = createMarker(v[1], v[2], v[3] -2, "cylinder", 4, 255, 255, 0, 50)
	setElementDimension(theMarker, 0)
	addEventHandler("onClientMarkerHit", theMarker, onHit)
	createBlipAttachedTo(theMarker,35, 2, 200,150,170,255, -1, 300.0)

	if (v[7]) then
		local theObject = createObject(11312, v[1] -v[8], v[2] -v[9], v[3]+0.8, v[4], v[5], v[6])
		setElementDoubleSided(theObject, true)
	end

end
