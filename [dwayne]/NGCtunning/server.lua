------------------------------------------------------------------------------------
--  Show GUI --
------------------------------------------------------------------------------------
function showTunePanel(thePlayer)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	if (not isElement(theVehicle)) then return end
	local theData = getVehicleHandling(theVehicle)
	triggerClientEvent(thePlayer, "showMain", thePlayer, theData)
	exports.NGCdxmsg:createNewDxMessage(thePlayer,"Changes cost $3500",0,255,0)
end
addEvent("showTunePanel", true)
addEventHandler("showTunePanel", root, showTunePanel)

------------------------------------------------------------------------------------
--  Take Player Money --
------------------------------------------------------------------------------------
function buySession(thePlayer)
	takePlayerMoney(thePlayer,3500)
	exports.NGCdxmsg:createNewDxMessage(thePlayer,"You have tunned the vehicle and paid $3500",0,255,0)
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	local data = getHandlingData(theVehicle)
	local id = getElementData(theVehicle,"vehicleID")
	exports.DENmysql:exec("UPDATE vehicles SET tune=? where uniqueid=?",data,id)
end
addEvent("buySession", true)
addEventHandler("buySession", root, buySession)

------------------------------------------------------------------------------------
--  Set Car Data --
------------------------------------------------------------------------------------
function injectCarData(theCar, theValue)
	if (not isElement(theCar)) then return false end
	for i, v in pairs(theValue) do
		setVehicleHandling(theCar, i, v)
	end
end
addEvent("injectCarData", true)
addEventHandler("injectCarData", root, injectCarData)

------------------------------------------------------------------------------------
--  Concatenation and Compression Function --
------------------------------------------------------------------------------------
-- Should string be compressed
local compress = true


local gname = {
--[[	[1] = "engineType",
	[2] = "engineAcceleration",
	[3] = "numberOfGears",]]
	[1] = "driveType",
	[2] = "handlingFlags",
	[3] = "suspensionForceLevel",
	[4] = "suspensionDamping",
	[5] = "suspensionUpperLimit",
	[6] = "suspensionLowerLimit",
	[7] = "suspensionFrontRearBias",
	[8] = "brakeDeceleration",
	[9] = "tractionBias",
	[10] = "tractionMultiplier",
	[11] = "tractionLoss",
	[12] = "brakeBias",
	[13] = "mass",
	[14] = "dragCoeff",
	[15] = "turnMass",
	[16] = "suspensionAntiDiveMultiplier",
	[17] = "steeringLock",
	[18] = "engineAcceleration",
	[19] = "maxVelocity",
	[20] = "suspensionHighSpeedDamping",
	[21] = "engineInertia",
}

function toCode(theData, theVehicle)
	local theString = ""

	local defaultCarData = getOriginalHandling(getElementModel(theVehicle))
	for i, v in ipairs(gname) do
		if (theData[v] ~= defaultCarData[v]) then
			local val = tostring(i).."_"..tostring(theData[v])
			theString = theString.." "..val
		end
	end

	if (compress) then
		theString = theString:gsub("0000", "%*")
		theString = theString:gsub("00", "%/")
		theString = theString:gsub("99999", "%=")
		theString = theString:gsub("9999", "%^")
		theString = theString:gsub("99", "%+")
	end

	return theString
end

function fromCode(theString)
	theString = tostring(theString)

	if (compress) then
		theString = theString:gsub("%*", "0000")
		theString = theString:gsub("%/", "00")
		theString = theString:gsub("%=", "99999")
		theString = theString:gsub("%^", "9999")
		theString = theString:gsub("%+", "99")
	end

	local theData = {}
	for v in string.gmatch(theString, "%S+") do
		local vs = {}
		local y, z = string.find(v, "_")
		vs[1] = tonumber(string.sub(v, 1, y-1)) -- gname index
		vs[2] = string.sub(v, z+1) -- setting value

		if (tostring(tonumber(vs[2])) == vs[2]) then
			vs[2] = tonumber(vs[2])
		end
		theData[gname[vs[1]]] = vs[2]
	end

	return theData
end

------------------------------------------------------------------------------------
--  Export Functions --
------------------------------------------------------------------------------------

-- SET
function setHandlingData(theVehicle, theValue)
	if (not theVehicle) then return false end
	if (not (getVehicleType(theVehicle) == "Automobile" or getVehicleType(theVehicle) == "Monster Truck")) then return false end
	injectCarData(theVehicle, fromCode(tostring(theValue)))
	return true
end
addEvent("setHandlingData", true)
addEventHandler("setHandlingData", root, setHandlingData)

-- GET
function getHandlingData(theVehicle)
	if (not isElement(theVehicle)) then return false end
	if (getVehicleType(theVehicle) ~= "Automobile" and getVehicleType(theVehicle) ~= "Monster Truck") then return false end

	return toCode(getVehicleHandling(theVehicle), theVehicle)
end
