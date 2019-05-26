


selectedLanguage = "en"

availableTranslations = {
	["en"] = {
		["menu.mainMenu"] = "Categories",
		["menu.performance"] = "Performance",
		["menu.optical"] = "Parts",
		["menu.extras"] = "Extras",
		["menu.color"] = "Color",

		["menu.performance.engine"] = "Engine",
		["menu.performance.turbo"] = "Turbo",
		["menu.performance.nitro"] = "Nitro",
		["menu.performance.tires"] = "Tires",
		["menu.performance.brakes"] = "Brakes",
		["menu.performance.weightReduction"] = "Weight Reduction",

		["menu.optical.frontBumper"] = "Front Bumper",
		["menu.optical.rearBumper"] = "Rear Bumper",
		["menu.optical.hood"] = "Hood",
		["menu.optical.exhaust"] = "Exhaust",
		["menu.optical.spoiler"] = "Spoiler",
		["menu.optical.wheels"] = "Wheels",
		["menu.optical.sideSkirt"] = "Side Skirt",
		["menu.optical.roofScoop"] = "Roof Scoop",
		["menu.optical.hidraulics"] = "Hidraulics",
		["menu.optical.lampColor"] = "Lamp Color",

		["menu.extras.frontWheelSize"] = "Front Wheel Size",
		["menu.extras.rearWheelSize"] = "Rear Wheel Size",
		["menu.extras.offroad"] = "Offroad",
		["menu.extras.driveType"] = "Drive Type",
		["menu.extras.steeringLock"] = "Steering Lock",
		["menu.extras.numberplate"] = "License Plate",

		["tuningPack.0"] = "Default",
		["tuningPack.1"] = "Bronze Pack",
		["tuningPack.2"] = "Silver Pack",
		["tuningPack.3"] = "Gold Pack",
		["tuningPack.wheelSize.veryNarrow"] = "Very narrow",
		["tuningPack.wheelSize.narrow"] = "Narrow",
		["tuningPack.wheelSize.wide"] = "Wide",
		["tuningPack.wheelSize.veryWide"] = "Very wide",
		["tuningPack.offroad.dirt"] = "Dirt",
		["tuningPack.offroad.sand"] = "Sand",
		["tuningPack.driveType.front"] = "Front Wheel Drive",
		["tuningPack.driveType.all"] = "All Wheel Drive",
		["tuningPack.driveType.rear"] = "Rear Wheel Drive",
		["tuningPack.numberplate.random"] = "Random",
		["tuningPack.numberplate.custom"] = "Custom",

		["tuningPack.optical.neon.1"] = "White",
		["tuningPack.optical.neon.2"] = "Blue",
		["tuningPack.optical.neon.3"] = "Green",
		["tuningPack.optical.neon.4"] = "Red",
		["tuningPack.optical.neon.5"] = "Yellow",
		["tuningPack.optical.neon.6"] = "Pink",
		["tuningPack.optical.neon.7"] = "Orange",
		["tuningPack.optical.neon.8"] = "Light Blue",
		["tuningPack.optical.neon.9"] = "Rasta",
		["tuningPack.optical.neon.10"] = "White + Light Blue",

		["tuningPack.optical.paintjob.1"] = "Custom Paint 1",
		["tuningPack.optical.paintjob.2"] = "Custom Paint 2",
		["tuningPack.optical.paintjob.3"] = "Custom Paint 3",
		["tuningPack.optical.paintjob.4"] = "Custom Paint 4",
		["tuningPack.optical.paintjob.5"] = "Custom Paint 5",
		["tuningPack.optical.paintjob.6"] = "Custom Paint 6",
		["tuningPack.optical.paintjob.7"] = "Custom Paint 7",
		["tuningPack.optical.paintjob.8"] = "Custom Paint 8",


		["tuningPrice.free"] = "Free",
		["tuningPack.remove"] = "Remove",
		["tuningPack.install"] = "Install",
		["tuning.active"] = "Active",

		["navbar.select"] = "Select",
		["navbar.buy"] = "Purchase",
		["navbar.navigate"] = "Navigate",
		["navbar.back"] = "Back",
		["navbar.exit"] = "Exit",
		["navbar.camera"] = "Move camera",

		["notification.error.notCompatible"] = "The selected component (%s) is not compatible with your vehicle!",
		["notification.error.itemIsPurchased"] = "The selected component (%s) is already have on your vehicle!",
		["notification.error.notEnoughMoney"] = "You don't have enough money!",
		["notification.success.purchased"] = "Successfully purchased the selected component!",
		---["notification.warning.airRideInstalled"] = "WARNING!\nAir-Ride installed in your vehicle.\nPlease remove it before install Hydraulics!",

		["prompt.text"] = "Are you sure you want to buy the selected element?",
		["prompt.info.1"] = "Selected element",
		["prompt.info.2"] = "Tuning price",
		["prompt.button.1"] = "Purchase (Enter)",
		["prompt.button.2"] = "Cancel (Backspace)",

		---["message.airride.error"] = "Usage: /airride [0 - 5] (0 => Default suspension)",
	},
}



function getLocalizedText(stringCode, ...)
	if stringCode then
		if availableTranslations[selectedLanguage] then
			if availableTranslations[selectedLanguage][stringCode] then
				if ... then
					return availableTranslations[selectedLanguage][stringCode]:format(...)
				else
					return availableTranslations[selectedLanguage][stringCode]
				end
			end
		end
	end

	if ... then
		return stringCode .. "|" .. table.concat({...}, "|")
	else
		return stringCode
	end
end

tuningMenu = {
	--[1] = {
		--["categoryName"] = getLocalizedText("menu.performance"),
		--[[["subMenu"] = {
			[1] = {
				["categoryName"] = getLocalizedText("menu.performance.engine"),
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true}, -- component, offsetX, offsetZ, zoom, hide component
				["upgradeData"] = "engine", --engine,turbo,tires,brakes,weightreduction
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"engineAcceleration"}, {"maxVelocity"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 100000, ["tuningData"] = {{"engineAcceleration", 2}, {"maxVelocity", 10}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 300000, ["tuningData"] = {{"engineAcceleration", 6}, {"maxVelocity", 20}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 550000, ["tuningData"] = {{"engineAcceleration", 8}, {"maxVelocity", 30}}}
				}
			},
			[2] = {
				["categoryName"] = getLocalizedText("menu.performance.turbo"),
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true},
				["upgradeData"] = "turbo",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"engineInertia"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 100000, ["tuningData"] = {{"engineInertia", -10}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 200000, ["tuningData"] = {{"engineInertia", -20}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 500000, ["tuningData"] = {{"engineInertia", -30}}}
				}
			},
			[3] = {
				["categoryName"] = getLocalizedText("menu.performance.nitro"),
				["cameraSettings"] = {"boot_dummy", -65, 15, 6, true},
				["upgradeData"] = "nitro",
				["subMenu"] = {
					--[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = 0},
					[1] = {["categoryName"] = "500 Nos", ["tuningPrice"] = 5000, ["tuningData"] = 500},
					[2] = {["categoryName"] = "1000 Nos", ["tuningPrice"] = 10000, ["tuningData"] = 1000},
					[3] = {["categoryName"] = "2500 Nos", ["tuningPrice"] = 25000, ["tuningData"] = 2500},
					[4] = {["categoryName"] = "5000 Nos", ["tuningPrice"] = 40000, ["tuningData"] = 5000}
				}
			},
			[4] = {
				["categoryName"] = getLocalizedText("menu.performance.tires"),
				["cameraSettings"] = {"wheel_rb_dummy", 60, 10, 4},
				["upgradeData"] = "tires",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"tractionMultiplier"}, {"tractionLoss"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 100000, ["tuningData"] = {{"tractionMultiplier", 0.05}, {"tractionLoss", 0.02}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 200000, ["tuningData"] = {{"tractionMultiplier", 0.1}, {"tractionLoss", 0.03}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 300000, ["tuningData"] = {{"tractionMultiplier", 0.15}, {"tractionLoss", 0.04}}}
				}
			},
			[5] = {
				["categoryName"] = getLocalizedText("menu.performance.brakes"),
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeData"] = "brakes",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"brakeDeceleration"}, {"brakeBias"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 100000, ["tuningData"] = {{"brakeDeceleration", 0.05}, {"brakeBias", 0.1}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 210000, ["tuningData"] = {{"brakeDeceleration", 0.1}, {"brakeBias", 0.175}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 350000, ["tuningData"] = {{"brakeDeceleration", 0.14}, {"brakeBias", 0.25}}}
				}
			},
			[6] = {
				["categoryName"] = getLocalizedText("menu.performance.weightReduction"),
				["upgradeData"] = "weightreduction",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"mass"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 105000, ["tuningData"] = {{"mass", -100}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 250000, ["tuningData"] = {{"mass", -200}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 450000, ["tuningData"] = {{"mass", -300}}}
				}
			}
		}
	},]]--
	[1] = {
		["categoryName"] = getLocalizedText("menu.optical"),
		["availableUpgrades"] = {}, -- automatic getting optical upgrades to selected category
		["subMenu"] = {
			[1] = {["categoryName"] = getLocalizedText("menu.optical.frontBumper"), ["upgradeSlot"] = 14, ["tuningPrice"] = 7000, ["cameraSettings"] = {"bump_front_dummy", 130, 10, 6}},
			[2] = {["categoryName"] = getLocalizedText("menu.optical.rearBumper"), ["upgradeSlot"] = 15, ["tuningPrice"] = 6000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[3] = {["categoryName"] = getLocalizedText("menu.optical.hood"), ["upgradeSlot"] = 0, ["tuningPrice"] = 10000},
			[4] = {["categoryName"] = getLocalizedText("menu.optical.exhaust"), ["upgradeSlot"] = 13, ["tuningPrice"] = 2000, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[5] = {["categoryName"] = getLocalizedText("menu.optical.spoiler"), ["upgradeSlot"] = 2, ["tuningPrice"] = 3500, ["cameraSettings"] = {"boot_dummy", -65, 3, 8}},
			[6] = {["categoryName"] = getLocalizedText("menu.optical.wheels"), ["upgradeSlot"] = 12, ["tuningPrice"] = 900},
			[7] = {["categoryName"] = getLocalizedText("menu.optical.sideSkirt"), ["upgradeSlot"] = 3, ["tuningPrice"] = 9000, ["cameraSettings"] = {"ug_wing_right", 65, 3, 4}},
			[8] = {["categoryName"] = getLocalizedText("menu.optical.roofScoop"), ["upgradeSlot"] = 7, ["tuningPrice"] = 5000},
			[9] = {["categoryName"] = getLocalizedText("menu.optical.hidraulics"), ["upgradeSlot"] = 9, ["tuningPrice"] = 15000},
			[10] = { -- custom optical item
				["categoryName"] = getLocalizedText("menu.optical.lampColor"),
				["cameraSettings"] = {"bonnet_dummy", 90, 3, 13},
				["upgradeSlot"] = 18,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("menu.optical.lampColor"), ["tuningPrice"] = 500, ["tuningData"] = "headlight"},
				}
			},
			--[[[11] = { -- custom optical item BUGGED
				["categoryName"] = "Neon",
				["cameraSettings"] = {"chassis_dummy", 0, 3, 10},
				["upgradeSlot"] = 19,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.1"), ["tuningPrice"] = 5000, ["tuningData"] = "white"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.2"), ["tuningPrice"] = 10000, ["tuningData"] = "blue"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.3"), ["tuningPrice"] = 15000, ["tuningData"] = "green"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.4"), ["tuningPrice"] = 20000, ["tuningData"] = "red"},
					[6] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.5"), ["tuningPrice"] = 25000, ["tuningData"] = "yellow"},
					[7] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.6"), ["tuningPrice"] = 30000, ["tuningData"] = "pink"},
					[8] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.7"), ["tuningPrice"] = 35000, ["tuningData"] = "orange"},
					[9] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.8"), ["tuningPrice"] = 40000, ["tuningData"] = "lightblue"},
					[10] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.9"), ["tuningPrice"] = 45000, ["tuningData"] = "rasta"},
					[11] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.10"), ["tuningPrice"] = 50000, ["tuningData"] = "ice"},
				}
			},
			[12] = { -- custom optical item
				["categoryName"] = "Custom PaintJob Bugged",
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true}, -- component, offsetX, offsetZ, zoom, hide component
				["upgradeSlot"] = 20,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.1"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 1"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.2"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 2"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.3"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 3"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.4"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 4"},
					[6] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.5"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 5"},
					[7] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.6"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 6"},
					[8] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.7"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 7"},
					[9] = {["categoryName"] = getLocalizedText("tuningPack.optical.paintjob.8"), ["tuningPrice"] = 5000, ["tuningData"] = "Custom Paint 8"},
				}
			},]]--
		}
	},
	[2] = {
		["categoryName"] = getLocalizedText("menu.extras"),
		["subMenu"] = {
			[1] = {
				["categoryName"] = getLocalizedText("menu.extras.frontWheelSize"),
				["cameraSettings"] = {"bump_front_dummy", 105, 5, 5, true},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryNarrow"), ["tuningPrice"] = 50000, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.narrow"), ["tuningPrice"] = 60000, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 5000, ["tuningData"] = "default"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.wide"), ["tuningPrice"] = 70000, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryWide"), ["tuningPrice"] = 90000, ["tuningData"] = "verywide"}
				}
			},
			[2] = {
				["categoryName"] = getLocalizedText("menu.extras.rearWheelSize"),
				["cameraSettings"] = {"bump_rear_dummy", -90, 5, 5, true},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryNarrow"), ["tuningPrice"] = 50000, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.narrow"), ["tuningPrice"] = 60000, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 5000, ["tuningData"] = "default"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.wide"), ["tuningPrice"] = 70000, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryWide"), ["tuningPrice"] = 90000, ["tuningData"] = "verywide"}
				}
			},
			[3] = {
				["categoryName"] = getLocalizedText("menu.extras.offroad"),
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 10000, ["tuningData"] = "default"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.offroad.dirt"), ["tuningPrice"] = 50000, ["tuningData"] = "dirt"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.offroad.sand"), ["tuningPrice"] = 50000, ["tuningData"] = "sand"}
				}
			},
			[4] = {
				["categoryName"] = getLocalizedText("menu.extras.driveType"),
				["propertyName"] = "driveType",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.driveType.front"), ["tuningPrice"] = 10000, ["tuningData"] = "fwd"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.driveType.all"), ["tuningPrice"] = 20000, ["tuningData"] = "awd"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.driveType.rear"), ["tuningPrice"] = 30000, ["tuningData"] = "rwd"}
				}
			},
			[5] = {
				["categoryName"] = getLocalizedText("menu.extras.steeringLock"),
				["propertyName"] = "steeringLock",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 10000, ["tuningData"] = false},
					[2] = {["categoryName"] = "30°", ["tuningPrice"] = 50000, ["tuningData"] = 30},
					[3] = {["categoryName"] = "40°", ["tuningPrice"] = 105000, ["tuningData"] = 40},
					[4] = {["categoryName"] = "50°", ["tuningPrice"] = 200500, ["tuningData"] = 50},
					[5] = {["categoryName"] = "60°", ["tuningPrice"] = 307500, ["tuningData"] = 60}
				}
			},
			[6] = {
				["categoryName"] = getLocalizedText("menu.extras.numberplate"),
				["cameraSettings"] = {"wheel_lb_dummy", -65, 4, 5},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.numberplate.random"), ["tuningPrice"] = 75000, ["tuningData"] = "random"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.numberplate.custom"), ["tuningPrice"] = 150000, ["tuningData"] = "custom"}
				}
			},
		}
	},
	[3] = {
		["categoryName"] = getLocalizedText("menu.color"),
		["subMenu"] = {}
	}
}


function getMainCategoryIDByName(name)
	if name then
		for categoryID, row in ipairs(tuningMenu) do
			if name == row["categoryName"] then
				return categoryID
			end
		end
	end

	return -1
end


local availableCustomPaints = {
	["Custom Paint 1"] = 2,
	["Custom Paint 2"] = 3,
	["Custom Paint 3"] = 4,
	["Custom Paint 4"] = 5,
	["Custom Paint 5"] = 6,
	["Custom Paint 6"] = 7,
	["Custom Paint 7"] = 8,
	["Custom Paint 8"] = 9,
}


local sportList = {
  [559] = "Jester",
  [561] = "Stratum",
  [560] = "Sultan",
  [562] = "Elegy",
  [558] = "Uranus",
  [535] = "Slamvan",
  [534] = "Remington",
  [565] = "Flash",
}

local vehicleCustomPaint = {}
local CustomPaintCommandTimer
local accountNos = {}
rotating = true
notAllowedModels = {592,577,511,548,512,593,425,520,417,487,553,488,497,563,476,447,519,460,469,
513,510,522,461,448,468,586,581,509,481,462,521,463,472,473,493,595,484,430,453,452,446,454,449,
537,538,570,569,590}

nosOn = false
local Keys = {
	"delete","tab", "lalt", "ralt"
}
--[[
function nitroSwitch(_,state)

		veh = getPedOccupiedVehicle(localPlayer)
		if veh and isElement(veh) then
			if getVehicleController ( veh ) == localPlayer then
				if state == "up" and isVehicleNitroActivated(veh) and getVehicleController(veh) == localPlayer then
					setVehicleNitroActivated(veh, false)
					removeVehicleUpgrade(veh, 1010)
					nosOn = false
					removeEventHandler("onClientRender",root,removeNos)
				elseif state == "down" and getVehicleController(veh) == localPlayer then

						local model = getElementModel(veh)
						for ind,num in ipairs(notAllowedModels) do
							if model == num then
								return
							end
						end
						addVehicleUpgrade(veh, 1010)
						setVehicleNitroActivated(veh, true)
						nosOn = true
						removeEventHandler("onClientRender",root,removeNos)
						addEventHandler("onClientRender",root,removeNos)
					else
						setVehicleNitroActivated(veh, false)
						removeVehicleUpgrade(veh, 1010)
						nosOn = false
						removeEventHandler("onClientRender",root,removeNos)
					end
				end
			end
		end
	end
end




function removeNos()

		if nosOn then
			veh = getPedOccupiedVehicle(localPlayer,0)
			if veh and isElement(veh) then
				if getVehicleController ( veh ) == localPlayer then

						if isVehicleNitroActivated(veh) then
							local model = getElementModel(veh)
							for ind,num in ipairs(notAllowedModels) do
								if model == num then
									reset()
									return
								end
							end

						end
					else
						reset()
					end
				else
					reset()
				end
			else
				reset()
			end
		else
			reset()
		end
	else
		reset()
	end
end

function reset()
	veh = getPedOccupiedVehicle(localPlayer,0)
	if veh and isElement(veh) then
		if getVehicleController ( veh ) == localPlayer then
			removeEventHandler("onClientRender",root,removeNos)
			setVehicleNitroActivated(veh, false)
			removeVehicleUpgrade(veh, 1010)
			nosOn = false
		else
			if nosOn == true then
				removeEventHandler("onClientRender",root,removeNos)
				nosOn = false
			end
		end
	end
end
]]



addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, vehicle in ipairs(getElementsByType("vehicle", root, true)) do
		if getElementData(vehicle, "tuning.CustomPaint") then
			addCustomPaint(vehicle, getElementData(vehicle, "tuning.CustomPaint"), true)
		end
	end
end)




addEvent("tuning->CustomPaint", true)
addEventHandler("tuning->CustomPaint", root, function(vehicle, CustomPaint)
	if vehicle and isElement(vehicle) then
		if isElementStreamedIn(vehicle) then
			if CustomPaint then
				addCustomPaint(vehicle, CustomPaint, true)
			else
				if vehicleCustomPaint[vehicle] then
					if vehicleCustomPaint[vehicle]["shader"] and vehicleCustomPaint[vehicle]["texture"] then
						if isElement(vehicleCustomPaint[vehicle]["shader"]) then
							destroyElement(vehicleCustomPaint[vehicle]["shader"])
						end
						if isElement(vehicleCustomPaint[vehicle]["texture"]) then
							destroyElement(vehicleCustomPaint[vehicle]["texture"])
						end
						vehicleCustomPaint[vehicle] = nil
					end
				end
			end
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "vehicle" then
		local CustomPaintColor = getElementData(source, "tuning.CustomPaint") or false
		if CustomPaintColor then
			addCustomPaint(source, CustomPaintColor, true)
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "vehicle" then
		if vehicleCustomPaint[source] then
			if isElement(vehicleCustomPaint[source]["shader"]) then
				destroyElement(vehicleCustomPaint[source]["shader"])
			end
			if isElement(vehicleCustomPaint[source]["texture"]) then
				destroyElement(vehicleCustomPaint[source]["texture"])
			end
			vehicleCustomPaint[source] = nil
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if getElementType(source) == "vehicle" then
		if vehicleCustomPaint[source] then
			-- destroy shader
			if isElement(vehicleCustomPaint[source]["shader"]) then
				destroyElement(vehicleCustomPaint[source]["shader"])
			end
			if isElement(vehicleCustomPaint[source]["texture"]) then
				destroyElement(vehicleCustomPaint[source]["texture"])
			end
			vehicleCustomPaint[source] = nil
		end
	end
end)


function addCustomPaint(vehicle, CustomPaint, setDefault)
	if not vehicleCustomPaint[vehicle] then
		vehicleCustomPaint[vehicle] = {}
	end
	if availableCustomPaints[CustomPaint] then
		if setDefault then
			vehicleCustomPaint[vehicle]["oldCustomPaintID"] = availableCustomPaints[CustomPaint]
		end

		vehicleCustomPaint[vehicle]["CustomPaint"] = CustomPaint
		if isElement(vehicleCustomPaint[vehicle]["shader"]) then
			destroyElement(vehicleCustomPaint[vehicle]["shader"])
		end
		if isElement(vehicleCustomPaint[vehicle]["texture"]) then
			destroyElement(vehicleCustomPaint[vehicle]["texture"])
		end
			--- add shader
		vehicleCustomPaint[vehicle]["shader"] = dxCreateShader("shader.fx", 0, 100, false, "vehicle")
		vehicleCustomPaint[vehicle]["texture"] = dxCreateTexture("Normal/"..availableCustomPaints[CustomPaint]..".png")
		why = "vehiclegrunge256"
		if getVehicleType(vehicle) == "Automobile" and not sportList[getElementModel(vehicle)] and getElementModel(vehicle) ~= 432 then
			why = "vehiclegrunge256"
		elseif getVehicleType(vehicle) == "Helicopter" and getElementModel(vehicle) == 487 then
			why = "maverick92body128"
		elseif getVehicleType(vehicle) == "Helicopter" and getElementModel(vehicle) == 563 then
			why = "raindance92body128"
		elseif getVehicleType(vehicle) == "Automobile" and sportList[getElementModel(vehicle)] then
			local model = getElementModel(vehicle)
			if model == 559 then -- jester
				why = "#emapjesterbody256"
			elseif model == 561 then -- stratum
				why = "#emapstratum292body256"
			elseif model == 560 then --- sultan
				why = "#emapelegybody128"
			elseif model == 562 then --- elegy
				why = "#emapelegybody128"
			elseif model == 558 then --- Uranus
				why = "#emapuranus92body256"
			elseif model == 534 then --- Remington
				why = "remapremington256body"
			elseif model == 565 then --- Flash
				why = "#emapflash92body256"
			elseif model == 535 then --- Slamvan
				why = "#emapslamvan92body128"
			end
		end
		engineApplyShaderToWorldTexture ( vehicleCustomPaint[vehicle]["shader"], why,vehicle )
		dxSetShaderValue ( vehicleCustomPaint[vehicle]["shader"], "gTexture", vehicleCustomPaint[vehicle]["texture"] )
		vehicleCustomPaint[vehicle]["object.zOffset"] = -0.5
	end
end

function removeCustomPaint(vehicle, previewMode)
	if vehicleCustomPaint[vehicle] then
		triggerServerEvent("tuning->CustomPaint", localPlayer, vehicle, false)
	end

	if not previewMode then
		setElementData(vehicle, "tuning.CustomPaint", false)
	end
end

function saveCustomPaint(vehicle, CustomPaint)
	setElementData(vehicle, "tuning.CustomPaint", CustomPaint)
	triggerServerEvent("tuning->CustomPaint", localPlayer, vehicle, CustomPaint)
end

function restoreOldCustomPaint(vehicle)
	if vehicle then
		local CustomPaintColor = getElementData(vehicle, "tuning.CustomPaint") or false

		if vehicleCustomPaint[vehicle] then
			if vehicleCustomPaint[vehicle]["shader"] and vehicleCustomPaint[vehicle]["texture"] then
				local CustomPaintModel = availableCustomPaints[vehicleCustomPaint[vehicle]["oldCustomPaintID"]]

				if CustomPaintModel then
					addCustomPaint(vehicle, CustomPaintModel)
				else
					if isElement(vehicleCustomPaint[vehicle]["shader"]) then
						destroyElement(vehicleCustomPaint[vehicle]["shader"])
					end
					if isElement(vehicleCustomPaint[vehicle]["texture"]) then
						destroyElement(vehicleCustomPaint[vehicle]["texture"])
					end
				end
				vehicleCustomPaint[vehicle] = nil
			end
		end
		if CustomPaintColor then
			triggerServerEvent("tuning->CustomPaint", localPlayer, vehicle, CustomPaintColor)
		end
	end
end

local availableNeons = {
	["white"] = 5764,
	["blue"] = 5681,
	["green"] = 18448,
	["red"] = 18215,
	["yellow"] = 18214,
	["pink"] = 18213,
	["orange"] = 14399,
	["lightblue"] = 14400,
	["rasta"] = 14401,
	["ice"] = 14402
}

local vehicleNeon = {}
local neonCommandTimer

addEvent("tuning->Neon", true)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for neonName, replaceModel in pairs(availableNeons) do
		local neonCOL = engineLoadCOL("files/neons/neonCollision.col")
		local neonDFF = engineLoadDFF("files/neons/" .. neonName .. ".dff")

		engineReplaceModel(neonDFF, replaceModel)
		engineReplaceCOL(neonCOL, replaceModel)
	end

	for _, vehicle in ipairs(getElementsByType("vehicle", root, true)) do
		if getElementData(vehicle, "tuning.neon") then
			if getElementData(vehicle, "vehicle.neon.active") then
				addNeon(vehicle, getElementData(vehicle, "tuning.neon"), true)
			end
		end
	end
	rotating = true
end)

addCommandHandler("neon", function()
	if isTimer(neonCommandTimer) then
		return
	end

	neonCommandTimer = setTimer(function() end, 2000, 1)

	local vehicle = getPedOccupiedVehicle(localPlayer)

	if vehicle then
		if getVehicleOccupant(vehicle, 0) == localPlayer then
			local neonColor = getElementData(vehicle, "tuning.neon") or false

			if neonColor then
				local neonActive = getElementData(vehicle, "vehicle.neon.active") or false

				if not neonActive then
					triggerServerEvent("tuning->Neon", localPlayer, vehicle, neonColor)
					setElementData(vehicle, "vehicle.neon.active", true)
				else
					triggerServerEvent("tuning->Neon", localPlayer, vehicle, false)
					setElementData(vehicle, "vehicle.neon.active", false)
				end
			end
		end
	end
end)

addEventHandler("tuning->Neon", root, function(vehicle, neon)
	if isElementStreamedIn(vehicle) then
		if neon then
			addNeon(vehicle, neon, true)
		else
			if vehicleNeon[vehicle] then
				if vehicleNeon[vehicle]["object.1"] and vehicleNeon[vehicle]["object.2"] then
					destroyElement(vehicleNeon[vehicle]["object.1"])
					destroyElement(vehicleNeon[vehicle]["object.2"])
					vehicleNeon[vehicle] = nil
				end
			end
		end
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	if getElementType(source) == "vehicle" then
		if getElementData(source, "vehicle.neon.active") then
			local neonColor = getElementData(source, "tuning.neon") or false

			if neonColor then
				addNeon(source, neonColor, true)
			end
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	if getElementType(source) == "vehicle" then
		if vehicleNeon[source] then
			if isElement(vehicleNeon[source]["object.1"]) then
				destroyElement(vehicleNeon[source]["object.1"])
			end

			if isElement(vehicleNeon[source]["object.2"]) then
				destroyElement(vehicleNeon[source]["object.2"])
			end

			vehicleNeon[source] = nil
		end
	end
end)

addEventHandler("onClientElementDestroy", root, function()
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	if getElementType(source) == "vehicle" then
		if vehicleNeon[source] then
			if isElement(vehicleNeon[source]["object.1"]) then
				destroyElement(vehicleNeon[source]["object.1"])
			end

			if isElement(vehicleNeon[source]["object.2"]) then
				destroyElement(vehicleNeon[source]["object.2"])
			end

			vehicleNeon[source] = nil
		end
	end
end)

addEventHandler("onClientRender", root, function()
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	for vehicle, neon in pairs(vehicleNeon) do
		if neon["object.1"] and neon["object.2"] then
			if vehicle and isElement(vehicle) then
				attachElements(neon["object.1"], vehicle, 0.8, 0, neon["object.zOffset"])
				attachElements(neon["object.2"], vehicle, -0.8, 0, neon["object.zOffset"])
			end
		end
	end
end)

function addNeon(vehicle, neon, setDefault)
	if not vehicleNeon[vehicle] then
		vehicleNeon[vehicle] = {}
	end

	if setDefault then
		vehicleNeon[vehicle]["oldNeonID"] = availableNeons[neon]
	end

	vehicleNeon[vehicle]["neon"] = neon

	if vehicleNeon[vehicle]["object.1"] or vehicleNeon[vehicle]["object.2"] then
		if availableNeons[neon] then
			setElementModel(vehicleNeon[vehicle]["object.1"], availableNeons[neon])
			setElementModel(vehicleNeon[vehicle]["object.2"], availableNeons[neon])
		else
			destroyElement(vehicleNeon[vehicle]["object.1"])
			destroyElement(vehicleNeon[vehicle]["object.2"])
		end
	else
		local vehicleX, vehicleY, vehicleZ = getElementPosition(vehicle)
		if availableNeons[neon] then
			vehicleNeon[vehicle]["object.1"] = createObject(availableNeons[neon], 0, 0, 0)
			vehicleNeon[vehicle]["object.2"] = createObject(availableNeons[neon], 0, 0, 0)

			setElementPosition(vehicleNeon[vehicle]["object.1"], vehicleX, vehicleY, vehicleZ)
			setElementPosition(vehicleNeon[vehicle]["object.2"], vehicleX, vehicleY, vehicleZ)
		end
	end

	vehicleNeon[vehicle]["object.zOffset"] = -0.5
end

function removeNeon(vehicle, previewMode)
	if vehicleNeon[vehicle] then
		triggerServerEvent("tuning->Neon", localPlayer, vehicle, false)
	end

	if not previewMode then
		setElementData(vehicle, "tuning.neon", false)
		setElementData(vehicle, "vehicle.neon.active", false)
	end
end

function saveNeon(vehicle, neon)
	setElementData(vehicle, "tuning.neon", neon)
	setElementData(vehicle, "vehicle.neon.active", true)
	exports.NGCdxmsg:createNewDxMessage("Use /neon to turn the neon on/off",255,255,0)
	triggerServerEvent("tuning->Neon", localPlayer, vehicle, neon)
end

function restoreOldNeon(vehicle)
	if vehicle then
		local neonColor = getElementData(vehicle, "tuning.neon") or false
		local neonActivated = getElementData(vehicle, "vehicle.neon.active") or false

		if vehicleNeon[vehicle] then
			if vehicleNeon[vehicle]["object.1"] and vehicleNeon[vehicle]["object.2"] then
				local neonModel = availableNeons[vehicleNeon[vehicle]["oldNeonID"]]

				if neonModel then
					setElementModel(vehicleNeon[vehicle]["object.1"], neonModel)
					setElementModel(vehicleNeon[vehicle]["object.2"], neonModel)
				else
					destroyElement(vehicleNeon[vehicle]["object.1"])
					destroyElement(vehicleNeon[vehicle]["object.2"])
					vehicleNeon[vehicle] = nil
				end
			end
		end

		if neonColor then
			if neonActivated then
				triggerServerEvent("tuning->Neon", localPlayer, vehicle, neonColor)
			end
		end
	end
end


local screenX, screenY = guiGetScreenSize()

cursorIsMoving, pickingColor, pickingLuminance = false, false, false

local pickerData = {}
local availableTextures = {
	["palette"] = dxCreateTexture("files/images/palette.png", "argb", true, "clamp"),
	["light"] = dxCreateTexture("files/images/light.png", "argb", true, "clamp"),
}

local lightIconXOffset = 20

local screenX, screenY = guiGetScreenSize()
if screenX >= 1024 then
	scaleFactor = screenX / 1366
else
	scaleFactor = screenX / 1024
end

local tuningMarkers = {}
local tuningMarkersCount = 0

local markerImageMaxVisibleDistance = 35

local availableTextures = {
	["logo"] = dxCreateTexture("files/images/logo.png", "argb", true, "clamp"),
	["hoveredrow"] = dxCreateTexture("files/images/hoveredrow.png", "argb", true, "clamp"),
	["menunav"] = dxCreateTexture("files/images/menunav.png", "argb", true, "clamp"),
	["mouse"] = dxCreateTexture("files/images/navbar/mouse.png", "argb", true, "clamp"),
}

local availableIcons = {
	["wrench"] = "",
	["long-arrow-up"] = "",
	["long-arrow-down"] = "",
	["info-circle"] = "",
	["check"] = "",
	["exclamation-triangle"] = "",
}

local mouseTable = {
	["speed"] = {0, 0},
	["last"] = {0, 0},
	["move"] = {0, 0}
}

local panelState = false
local enteredVehicle = false
local availableFonts = nil

local panelWidth, rowHeight = 350 * scaleFactor, 35 * scaleFactor
local panelX, panelY = 32, 32
local logoHeight = panelWidth / 2

local hoveredCategory, selectedCategory, selectedSubCategory = 1, 0, 0
local maxRowsPerPage, currentPage = 7, 1

local compatibleOpticalUpgrades = {}
local equippedTuning = 1

local navbarButtonHeight = 30 * scaleFactor
local navigationBar = {
	{"", {"Enter"}, false},
	{"", {"long-arrow-up", "long-arrow-down"}, true},
	{"", {"Backspace"}, false},
	{getLocalizedText("navbar.camera"), {"mouse"}, "image", 30}
}

local noticeData = {
	["text"] = false,
	["type"] = "info",
	["tick"] = 0,
	["state"] = "",
	["height"] = 0,
	["timer"] = nil
}

local cameraSettings = {}

local promptDialog = {
	["state"] = false,
	["itemName"] = "",
	["itemPrice"] = 0
}

local availableOffroadAbilities = {
	["dirt"] = {0x100000, 2},
    ["sand"] = {0x200000, 3}
}

local availableOffroadAbilities = {
	["dirt"] = {0x100000, 2},
    ["sand"] = {0x200000, 3}
}

local availableWheelSizes = {
	["front"] = {
		["verynarrow"] = {0x100, 1},
		["narrow"] = {0x200, 2},
		["wide"] = {0x400, 4},
		["verywide"] = {0x800, 5}
	},
	["rear"] = {
		["verynarrow"] = {0x1000, 1},
		["narrow"] = {0x2000, 2},
		["wide"] = {0x4000, 4},
		["verywide"] = {0x8000, 5}
	}
}

local savedVehicleColors = {["all"] = false, ["headlight"] = false}
local moneyChangeTable = {["tick"] = 0, ["amount"] = 0}

local vehicleNumberplate = ""

addEvent("tuning->ShowMenu", true)
addEvent("tuning->HideMenu", true)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, value in ipairs(getElementsByType("marker", resourceRoot, true)) do
		if getElementData(value, "tuningMarkerSettings") then
			tuningMarkers[value] = true
			tuningMarkersCount = tuningMarkersCount + 1
		end
	end

	for i = 1, 4 do
		table.insert(tuningMenu[getMainCategoryIDByName(getLocalizedText("menu.color"))]["subMenu"], {
			["categoryName"] = getLocalizedText("menu.color") .. " " .. i,
			["tuningPrice"] = 10000,
			["tuningData"] = "color" .. i
		})
	end
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	if panelState and enteredVehicle then
		resetOpticalUpgrade()
		setVehicleColorsToDefault()
		triggerEvent("tuning->HideMenu", localPlayer)
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	if getElementType(source) == "marker" then
		if getElementData(source, "tuningMarkerSettings") then
			tuningMarkers[source] = true
			tuningMarkersCount = tuningMarkersCount + 1
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	if getElementType(source) == "marker" then
		if getElementData(source, "tuningMarkerSettings") then
			tuningMarkers[source] = nil
			tuningMarkersCount = tuningMarkersCount - 1
		end
	end
end)

addEventHandler("onClientRender", root, function()
	--** Tuning marker image
	if not exports.server:isPlayerLoggedIn(localPlayer) then return false end
	if tuningMarkersCount ~= 0 then
		local cameraX, cameraY, cameraZ = getCameraMatrix()

		for marker, id in pairs(tuningMarkers) do
			if marker and isElement(marker) then
				if getElementAlpha(marker) ~= 0 and getElementDimension(marker) == getElementDimension(localPlayer) then
					local markerX, markerY, markerZ = getElementPosition(marker)
					local markerDistance = getDistanceBetweenPoints3D(cameraX, cameraY, cameraZ, markerX, markerY, markerZ)

					if markerDistance <= markerImageMaxVisibleDistance then
						if isLineOfSightClear(cameraX, cameraY, cameraZ, markerX, markerY, markerZ, false, false, false, true, false, false, false) then
							local screenX, screenY = getScreenFromWorldPosition(markerX, markerY, markerZ + 1, 1)

							if screenX and screenY then
								local imageScale = 1 - (markerDistance / markerImageMaxVisibleDistance) * 0.5
								local alphaScale = 255 - (markerDistance / markerImageMaxVisibleDistance) * 1.0

								local imageWidth, imageHeight = 256 * imageScale, 128 * imageScale
								local imageX, imageY = screenX - (imageWidth / 2), screenY - (imageHeight / 2)

								dxDrawImage(imageX, imageY, imageWidth, imageHeight, availableTextures["logo"], 0, 0, 0, tocolor(255, 255, 255, 255 * alphaScale))
							end
						end
					end
				end
			else
				tuningMarkers[marker] = nil
			end
		end
	end

	-- ** Tuning menu
	if panelState and enteredVehicle then
		--> Logo
		dxDrawRectangle(panelX, panelY, panelWidth, logoHeight * scaleFactor, tocolor(0, 0, 0, 200))
		dxDrawImage(panelX, panelY, panelWidth, logoHeight * scaleFactor, availableTextures["logo"])


		--> Notification
		if noticeData["text"] then
			if noticeData["state"] == "showNotice" then
				local animationProgress = (getTickCount() - noticeData["tick"]) / 300
				local animationState = interpolateBetween(0, 0, 0, logoHeight * scaleFactor, 0, 0, animationProgress, "Linear")

				noticeData["height"] = animationState

				if animationProgress > 1 then
					noticeData["state"] = "fixNoticeJumping"

					noticeData["timer"] = setTimer(function()
						noticeData["tick"] = getTickCount()
						noticeData["state"] = "hideNotice"
					end, string.len(noticeData["text"]) * 50, 1)
				end
			elseif noticeData["state"] == "hideNotice" then
				local animationProgress = (getTickCount() - noticeData["tick"]) / 300
				local animationState = interpolateBetween(logoHeight * scaleFactor, 0, 0, 0, 0, 0, animationProgress, "Linear")

				noticeData["height"] = animationState

				if animationProgress > 1 then
					noticeData["text"] = false
				end
			elseif noticeData["state"] == "fixNoticeJumping" then
				noticeData["height"] = (logoHeight * scaleFactor)
			end

			dxDrawRectangle(panelX, panelY, panelWidth, noticeData["height"], tocolor(0, 0, 0, 200))

			if noticeData["height"] == (logoHeight * scaleFactor) then
				local noticeIcon, iconColor = "", {255, 255, 255}

				if noticeData["type"] == "info" then
					noticeIcon, iconColor = availableIcons["info-circle"], {85, 178, 243}
				elseif noticeData["type"] == "warning" then
					noticeIcon, iconColor = availableIcons["exclamation-triangle"], {220, 190, 120}
				elseif noticeData["type"] == "error" then
					noticeIcon, iconColor = availableIcons["exclamation-triangle"], {200, 80, 80}
				elseif noticeData["type"] == "success" then
					noticeIcon, iconColor = availableIcons["check"], {130, 220, 115}
				end

				dxDrawText(noticeIcon, panelX + 5, panelY + 5, panelX + 5 + panelWidth - 10, panelY + 5 + noticeData["height"] - 10, tocolor(iconColor[1], iconColor[2], iconColor[3], 255), 1.0, availableFonts["icons"], "left", "top")
				dxDrawText(noticeData["text"], panelX + 10, panelY, panelX + 10 + panelWidth - 20, panelY + noticeData["height"], tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "center", "center", false, true)
			end
		end

		--> Looping table
		loopTable, categoryCount, categoryName = {}, 0, "N/A"

		if selectedCategory == 0 then
			loopTable = tuningMenu
			categoryName = getLocalizedText("menu.mainMenu")

			navigationBar[1][1] = getLocalizedText("navbar.select")
			navigationBar[3][1] = getLocalizedText("navbar.exit")
		elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
			loopTable = tuningMenu[selectedCategory]["subMenu"]
			categoryName = tuningMenu[selectedCategory]["categoryName"]

			if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then -- Color
				navigationBar[1][1] = getLocalizedText("navbar.buy")
			else
				navigationBar[1][1] = getLocalizedText("navbar.select")
			end

			navigationBar[3][1] = getLocalizedText("navbar.back")
		elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
			if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then -- Optical
				if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
					loopTable = tuningMenu[selectedCategory]["availableUpgrades"]
					categoryName = tuningMenu[selectedCategory]["categoryName"]
				else
					loopTable = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["subMenu"]
					categoryName = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["categoryName"]
				end
			else
				loopTable = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["subMenu"]
				categoryName = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["categoryName"]
			end

			navigationBar[1][1] = getLocalizedText("navbar.buy")
			navigationBar[3][1] = getLocalizedText("navbar.back")
		end

		--> Current category
		local panelY = panelY + (logoHeight * scaleFactor)

		dxDrawRectangle(panelX, panelY, panelWidth, rowHeight, tocolor(0, 0, 0, 255))
		dxDrawText(utf8.upper(categoryName), panelX + 10, panelY, panelX + 10 + panelWidth - 20, panelY + rowHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "center", false, false, false, true)
		dxDrawText(hoveredCategory .. " / " .. #loopTable, panelX + 10, panelY, panelX + 10 + panelWidth - 20, panelY + rowHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)

		--> Menu rows
		local panelY = panelY + rowHeight

		for id, row in ipairs(loopTable) do
			if id >= currentPage and id <= currentPage + maxRowsPerPage then
				local rowX, rowY, rowWidth, rowHeight = panelX, panelY + (categoryCount * rowHeight), panelWidth, rowHeight

				if selectedCategory == 0 or selectedSubCategory == 0 then
					equippedUpgrade = -1
				elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
					if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
						if row["upgradeID"] == equippedTuning then
							equippedUpgrade = id
						end
					else
						if id == equippedTuning then
							equippedUpgrade = id
						end
					end
				else
					if id == equippedTuning then
						equippedUpgrade = id
					end
				end

				if hoveredCategory ~= id then
					if categoryCount %2 == 0 then
						dxDrawRectangle(rowX, rowY, rowWidth, rowHeight, tocolor(0, 0, 0, 150))
					else
						dxDrawRectangle(rowX, rowY, rowWidth, rowHeight, tocolor(0, 0, 0, 200))
					end

					dxDrawText(row["categoryName"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "center", false, false, false, true)

					if equippedUpgrade ~= id then
						if row["tuningPrice"] then
							if row["tuningPrice"] == 0 then
								dxDrawText(getLocalizedText("tuningPrice.free"), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(198, 83, 82, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							else
								dxDrawText("$ " .. formatNumber(row["tuningPrice"], ","), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(255, 255, 255, 200), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							end
						end
					else
						dxDrawText(getLocalizedText("tuning.active"), rowX + 15, rowY, rowX + 15 + rowWidth - 30 - dxGetTextWidth(availableIcons["wrench"], 1.0, availableFonts["icons"]) - 10, rowY + rowHeight, tocolor(150, 255, 150, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
						dxDrawText(availableIcons["wrench"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(150, 255, 150, 255), 1.0, availableFonts["icons"], "right", "center", false, false, false, true)
					end
				else
					dxDrawImage(rowX, rowY, rowWidth, rowHeight, availableTextures["hoveredrow"])

					dxDrawText(row["categoryName"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "left", "center", false, false, false, true)

					if equippedUpgrade ~= id then
						if row["tuningPrice"] then
							if row["tuningPrice"] == 0 then
								dxDrawText(getLocalizedText("tuningPrice.free"), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							else
								dxDrawText("$ " .. formatNumber(row["tuningPrice"], ","), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 200), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							end
						end
					else
						dxDrawText(getLocalizedText("tuning.active"), rowX + 15, rowY, rowX + 15 + rowWidth - 30 - dxGetTextWidth(availableIcons["wrench"], 1.0, availableFonts["icons"]) - 10, rowY + rowHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
						dxDrawText(availableIcons["wrench"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 255), 1.0, availableFonts["icons"], "right", "center", false, false, false, true)
					end
				end

				categoryCount = categoryCount + 1
			end
		end

		dxDrawImage(panelX, panelY + (categoryCount * rowHeight), panelWidth, rowHeight, availableTextures["menunav"])

		--> Scrollbar
		if categoryCount >= (maxRowsPerPage + 1) and categoryCount ~= #loopTable then
			local rowVisible = math.max(0.05, math.min(1.0, (maxRowsPerPage + 1) / #loopTable))
			local scrollbarHeight = ((maxRowsPerPage + 1) * rowHeight) * rowVisible
			local scrollbarPosition = math.min((currentPage - 1) / #loopTable, 1.0 - rowVisible) * ((maxRowsPerPage + 1) * rowHeight)

			dxDrawRectangle(panelX + panelWidth - 2, panelY + scrollbarPosition, 2, scrollbarHeight, tocolor(50, 220, 80, 200))
		end

		--> Navigation Bar
		local navbarWidth = getNavbarWidth()
		local barOffsetX = 0

		drawRoundedRectangle(screenX - navbarWidth + 8 - 90, screenY - 12 - rowHeight, navbarWidth, rowHeight, 1, tocolor(0, 0, 0, 180))

		for _, row in ipairs(navigationBar) do
			local textLength = dxGetTextWidth(row[1], 0.5, availableFonts["chalet"]) + 20
			local navX, navY, navHeight = screenX - navbarWidth - 80 + barOffsetX, screenY - 12 - rowHeight, rowHeight
			local navWidth = 0

			for id, icon in ipairs(row[2]) do
				local buttonWidth = 0

				if type(row[3]) == "string" and row[3] == "image" then
					buttonWidth = row[4]
				elseif type(row[3]) == "boolean" and row[3] then
					buttonWidth = dxGetTextWidth(availableIcons[icon], 1.0, availableFonts["icons"]) + 20
				elseif type(row[3]) == "boolean" and not row[3] then
					buttonWidth = dxGetTextWidth(icon, 0.5, availableFonts["chalet"]) + 10
				end

				local iconX = navX + textLength - 5 + ((id - 1) * buttonWidth) + ((id - 1) * 5)

				if type(row[3]) == "boolean" then
					drawRoundedRectangle(iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), buttonWidth, navbarButtonHeight, 1, tocolor(255, 255, 255, 255))
				end

				if type(row[3]) == "string" and row[3] == "image" then
					dxDrawImage(iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), buttonWidth, navbarButtonHeight, availableTextures[icon])
				elseif type(row[3]) == "boolean" and row[3] then
					dxDrawText(availableIcons[icon], iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), iconX + buttonWidth, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)) + navbarButtonHeight, tocolor(0, 0, 0, 255), 1.0, availableFonts["icons"], "center", "center")
				elseif type(row[3]) == "boolean" and not row[3] then
					dxDrawText(icon, iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), iconX + buttonWidth, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)) + navbarButtonHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "center", "center")
				end

				navWidth = navWidth + buttonWidth + 10
			end

			dxDrawText(row[1], navX, navY, navX + navWidth, navY + navHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "center")

			barOffsetX = barOffsetX + (navWidth + textLength)
		end

		--> Prompt dialog
		--> Prompt dialog
		if promptDialog["state"] then
			local promptWidth = dxGetTextWidth(getLocalizedText("prompt.text"), 0.5, availableFonts["chalet"]) + 20
			local promptWidth, promptHeight = promptWidth, 120 * scaleFactor
			local promptX, promptY = (screenX / 2) - (promptWidth / 2), (screenY / 2) - (promptHeight / 2)

			drawRoundedRectangle(promptX, promptY, promptWidth, promptHeight, 1, tocolor(0, 0, 0, 200))
			dxDrawText(getLocalizedText("prompt.text"), promptX + 10, promptY + 5, promptX + 10 + promptWidth - 20, promptY + 5 + promptHeight - 10, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "top")

			dxDrawText("#cccccc" .. getLocalizedText("prompt.info.1") ..": #ffffff" .. promptDialog["itemName"], promptX + 15, promptY + 30, promptX + 15 + promptWidth - 30, promptY + 30 + promptHeight - 60, tocolor(255, 255, 255, 255), 0.45, availableFonts["chalet"], "left", "top", false, false, false, true)
			dxDrawText("#cccccc" .. getLocalizedText("prompt.info.2") .. ": #ffffff$ " .. formatNumber(promptDialog["itemPrice"], ","), promptX + 15, promptY + 30 + dxGetFontHeight(0.45, availableFonts["chalet"]), promptX + 15 + promptWidth - 30, promptY + 30 + dxGetFontHeight(0.45, availableFonts["chalet"]) + promptHeight - 60, tocolor(255, 255, 255, 255), 0.45, availableFonts["chalet"], "left", "top", false, false, false, true)

			local buttonX, buttonY, buttonWidth, buttonHeight = promptX + 10, promptY + promptHeight - 10 - navbarButtonHeight, (promptWidth / 2) - 20, navbarButtonHeight

			drawRoundedRectangle(buttonX, buttonY, buttonWidth, buttonHeight, 1, tocolor(110, 207, 112, 255))
			dxDrawText(getLocalizedText("prompt.button.1"), buttonX, buttonY, buttonX + buttonWidth, buttonY + buttonHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "center", "center")

			drawRoundedRectangle((buttonX + buttonWidth + 20), buttonY, buttonWidth, buttonHeight, 1, tocolor(200, 80, 80, 255))
			dxDrawText(getLocalizedText("prompt.button.2"), (buttonX + buttonWidth + 20), buttonY, (buttonX + buttonWidth + 20) + buttonWidth, buttonY + buttonHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "center", "center")
		end

		--> License Plate inputbox
		if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
			if selectedSubCategory == 6 and hoveredCategory == 2 then
				local boxX, boxY, boxWidth, boxHeight = panelX + 2, panelY + (categoryCount * rowHeight) + rowHeight, panelWidth - 4, rowHeight

				drawBorderedRectangle(boxX, boxY, boxWidth, boxHeight, 2, tocolor(0, 0, 0, 255), tocolor(30, 30, 30, 255))
				dxDrawText(vehicleNumberplate, boxX, boxY, boxX + boxWidth, boxY + boxHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "center", "center")
			end
		end
	end
end)

addEventHandler("onClientPreRender", root, function(timeSlice)

	--> Calculate mouse move speed
	if isCursorShowing() then
		local cursorX, cursorY = getCursorPosition()

		mouseTable["speed"][1] = math.sqrt(math.pow((mouseTable["last"][1] - cursorX) / timeSlice, 2))
		mouseTable["speed"][2] = math.sqrt(math.pow((mouseTable["last"][2] - cursorY) / timeSlice, 2))

		mouseTable["last"][1] = cursorX
		mouseTable["last"][2] = cursorY
	end

	--> Camera
	if panelState and enteredVehicle then
		local _, _, _, _, _, _, roll, fov = getCameraMatrix()
		local cameraZoomProgress = (getTickCount() - cameraSettings["zoomTick"]) / 500
		local cameraZoomAnimation = interpolateBetween(fov, 0, 0, cameraSettings["zoom"], 0, 0, cameraZoomProgress, "Linear")

		if cameraSettings["moveState"] == "moveToElement" then
			local currentCameraX, currentCameraY, currentCameraZ, currentCameraRotX, currentCameraRotY, currentCameraRotZ = getCameraMatrix()
			local cameraProgress = (getTickCount() - cameraSettings["moveTick"]) / 1000
			local cameraX, cameraY, cameraZ, componentX, componentY, componentZ = _getCameraPosition("component")
			local newCameraX, newCameraY, newCameraZ = interpolateBetween(currentCameraX, currentCameraY, currentCameraZ, cameraX, cameraY, cameraZ, cameraProgress, "Linear")
			local newCameraRotX, newCameraRotY, newCameraRotZ = interpolateBetween(currentCameraRotX, currentCameraRotY, currentCameraRotZ, componentX, componentY, componentZ, cameraProgress, "Linear")
			local newCameraZoom = interpolateBetween(fov, 0, 0, 60, 0, 0, cameraProgress, "Linear")

			setCameraMatrix(newCameraX, newCameraY, newCameraZ, newCameraRotX, newCameraRotY, newCameraRotZ, roll, newCameraZoom)

			if cameraProgress > 0.5 then
				cameraSettings["moveState"] = "freeMode"
				cameraSettings["zoom"] = 60
			end
		elseif cameraSettings["moveState"] == "backToVehicle" then
			local currentCameraX, currentCameraY, currentCameraZ, currentCameraRotX, currentCameraRotY, currentCameraRotZ = getCameraMatrix()
			local cameraProgress = (getTickCount() - cameraSettings["moveTick"]) / 1000
			local cameraX, cameraY, cameraZ, vehicleX, vehicleY, vehicleZ = _getCameraPosition("vehicle")
			local newCameraX, newCameraY, newCameraZ = interpolateBetween(currentCameraX, currentCameraY, currentCameraZ, cameraX, cameraY, cameraZ, cameraProgress, "Linear")
			local newCameraRotX, newCameraRotY, newCameraRotZ = interpolateBetween(currentCameraRotX, currentCameraRotY, currentCameraRotZ, vehicleX, vehicleY, vehicleZ, cameraProgress, "Linear")
			local newCameraZoom = interpolateBetween(fov, 0, 0, 60, 0, 0, cameraProgress, "Linear")

			setCameraMatrix(newCameraX, newCameraY, newCameraZ, newCameraRotX, newCameraRotY, newCameraRotZ, roll, newCameraZoom)

			if cameraProgress > 0.5 then
				cameraSettings["moveState"] = "freeMode"
				cameraSettings["zoom"] = 60
			end
		elseif cameraSettings["moveState"] == "freeMode" then
			local cameraX, cameraY, cameraZ, elementX, elementY, elementZ = _getCameraPosition("both")

			setCameraMatrix(cameraX, cameraY, cameraZ, elementX, elementY, elementZ, roll, cameraZoomAnimation)

			if getKeyState("mouse1") and not pickingColor and not pickingLuminance and isCursorShowing() and not isMTAWindowActive() and not promptDialog["state"] then
				cameraSettings["freeModeActive"] = true
			else
				cameraSettings["freeModeActive"] = false
			end
		end
	end
end)

addEventHandler("onClientCursorMove", root, function(cursorX, cursorY, absoluteX, absoluteY)

	if panelState and enteredVehicle then
		if cameraSettings["freeModeActive"] then
			lastCursorX = mouseTable["move"][1]
			lastCursorY = mouseTable["move"][2]

			mouseTable["move"][1] = cursorX
			mouseTable["move"][2] = cursorY

			if cursorX > lastCursorX then
				cameraSettings["currentX"] = cameraSettings["currentX"] - (mouseTable["speed"][1] * 100)
			elseif cursorX < lastCursorX then
				cameraSettings["currentX"] = cameraSettings["currentX"] + (mouseTable["speed"][1] * 100)
			end

			if cursorY > lastCursorY then
				cameraSettings["currentZ"] = cameraSettings["currentZ"] + (mouseTable["speed"][2] * 50)
			elseif cursorY < lastCursorY then
				cameraSettings["currentZ"] = cameraSettings["currentZ"] - (mouseTable["speed"][2] * 50)
			end

			cameraSettings["currentY"] = cameraSettings["currentX"]
			cameraSettings["currentZ"] = math.max(cameraSettings["minimumZ"], math.min(cameraSettings["maximumZ"], cameraSettings["currentZ"]))
		end
	end
end)

addEventHandler("onClientCharacter", root, function(character)
	if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
		if selectedSubCategory == 6 and hoveredCategory == 2 then
			if #vehicleNumberplate < 8 then
				local supportedCharacters = {
					["q"] = true, ["w"] = true, ["x"] = true, ["4"] = true,
					["e"] = true, ["r"] = true, ["c"] = true, ["5"] = true,
					["t"] = true, ["z"] = true, ["v"] = true, ["6"] = true,
					["u"] = true, ["i"] = true, ["b"] = true, ["7"] = true,
					["o"] = true, ["p"] = true, ["n"] = true, ["8"] = true,
					["a"] = true, ["s"] = true, ["m"] = true, ["9"] = true,
					["d"] = true, ["f"] = true, ["0"] = true, ["-"] = true,
					["g"] = true, ["h"] = true, ["1"] = true, [" "] = true,
					["j"] = true, ["k"] = true, ["2"] = true,
					["l"] = true, ["y"] = true, ["3"] = true,
				}

				if supportedCharacters[character] then
					vehicleNumberplate = vehicleNumberplate .. utf8.upper(character)
					setVehiclePlateText(enteredVehicle, vehicleNumberplate)
				end
			end
		end
	end
end)

addEventHandler("onClientKey", root, function(key, pressed)

	if panelState and enteredVehicle then
		if pressed then
			if key == "arrow_d" and not promptDialog["state"] then
				if hoveredCategory > #loopTable or hoveredCategory == #loopTable then
					hoveredCategory = #loopTable
				else
					if hoveredCategory > maxRowsPerPage then
						currentPage = currentPage + 1
					end

					hoveredCategory = hoveredCategory + 1

					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if selectedSubCategory ~= 0 then
							if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
								showNextOpticalUpgrade()
							else
								if selectedSubCategory == 11 then -- Neon
									addNeon(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
								elseif selectedSubCategory == 12 then -- Neon
									addCustomPaint(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
								end
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
						if selectedSubCategory == 1 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", loopTable[hoveredCategory]["tuningData"])
						elseif selectedSubCategory == 2 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", loopTable[hoveredCategory]["tuningData"])
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
						setVehicleColorsToDefault()
						setPaletteType(loopTable[hoveredCategory]["tuningData"])
						updatePaletteColor(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
					end

					playSoundEffect("menunavigate.mp3")
				end
			elseif key == "arrow_u" and not promptDialog["state"] then
				if hoveredCategory < 1 or hoveredCategory == 1 then
					hoveredCategory = 1

					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if selectedSubCategory ~= 0 then
							if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
								showDefaultOpticalUpgrade()
							end
						end
					end
				else
					if currentPage - 1 >= 1 then
						currentPage = currentPage - 1
					end

					hoveredCategory = hoveredCategory - 1

					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if selectedSubCategory ~= 0 then
							if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
								if hoveredCategory == 1 then -- Default upgrade
									removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory])
								else
									showNextOpticalUpgrade()
								end
							else
								if selectedSubCategory == 11 then -- Neon
									if hoveredCategory == 1 then
										removeNeon(enteredVehicle, true)
									else
										addNeon(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
									end
								elseif selectedSubCategory == 12 then -- addCustomPaint
									if hoveredCategory == 1 then
										removeCustomPaint(enteredVehicle, true)
									else
										addCustomPaint(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
									end
								end
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
						if selectedSubCategory == 1 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", loopTable[hoveredCategory]["tuningData"])
						elseif selectedSubCategory == 2 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", loopTable[hoveredCategory]["tuningData"])
						elseif selectedSubCategory == 6 then
							if equippedTuning ~= vehicleNumberplate then
								setVehiclePlateText(enteredVehicle, equippedTuning)
								vehicleNumberplate = equippedTuning
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
						setVehicleColorsToDefault()
						setPaletteType(loopTable[hoveredCategory]["tuningData"])
						updatePaletteColor(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
					end

					playSoundEffect("menunavigate.mp3")
				end
			elseif key == "backspace" then
				if promptDialog["state"] then
					promptDialog["state"] = false
				else
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) and selectedSubCategory == 6 then
						if hoveredCategory == 2 then
							if #vehicleNumberplate - 1 >= 0 then
								vehicleNumberplate = string.sub(vehicleNumberplate, 1, #vehicleNumberplate - 1)
								setVehiclePlateText(enteredVehicle, vehicleNumberplate)
							else
								setVehiclePlateText(enteredVehicle, "")
								vehicleNumberplate = ""
							end

							return
						else
							if equippedTuning ~= vehicleNumberplate then
								setVehiclePlateText(enteredVehicle, equippedTuning)
								vehicleNumberplate = equippedTuning
							end
						end
					end

					if selectedCategory == 0 and selectedSubCategory == 0 then
						triggerEvent("tuning->HideMenu", localPlayer)
					elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then -- Color
							destroyColorPicker()
							setVehicleColorsToDefault()
						end

						selectedCategory, hoveredCategory, currentPage = 0, 1, 1
					elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
						moveCameraToDefaultPosition()

						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then -- Optical
							if selectedSubCategory ~= 0 then
								if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
									resetOpticalUpgrade() -- reset to equipped upgrade
									tuningMenu[selectedCategory]["availableUpgrades"] = {}
									equippedTuning = 1
								else
									if selectedSubCategory == 10 then -- Lamp color
										destroyColorPicker()
										setVehicleColorsToDefault()
										setVehicleOverrideLights(enteredVehicle, 1)
									elseif selectedSubCategory == 11 then -- Neon
										restoreOldNeon(enteredVehicle)
									elseif selectedSubCategory == 12 then -- Neon
										restoreOldCustomPaint(enteredVehicle)
									end
								end
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then -- Extras
							if selectedSubCategory == 1 then
								local defaultWheelSize = (equippedTuning == 1 and "verynarrow") or (equippedTuning == 2 and "narrow") or (equippedTuning == 3 and "default") or (equippedTuning == 4 and "wide") or (equippedTuning == 5 and "verywide")

								triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", defaultWheelSize)
							elseif selectedSubCategory == 2 then
								local defaultWheelSize = (equippedTuning == 1 and "verynarrow") or (equippedTuning == 2 and "narrow") or (equippedTuning == 3 and "default") or (equippedTuning == 4 and "wide") or (equippedTuning == 5 and "verywide")

								triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", defaultWheelSize)
							end
						end

						selectedSubCategory, hoveredCategory, currentPage = 0, 1, 1
					end

					playSoundEffect("menuback.wav")

					if enteredVehicle then
						for component in pairs(getVehicleComponents(enteredVehicle)) do
							setVehicleComponentVisible(enteredVehicle, component, true)
						end
					end
				end
			elseif key == "enter" then
				if not promptDialog["state"] then
					if selectedCategory == 0 then
						selectedCategory, currentPage, hoveredCategory = hoveredCategory, 1, 1

						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
							savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
							savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}

							createColorPicker(enteredVehicle, panelX + 2, (panelY + (logoHeight * scaleFactor) + rowHeight + (categoryCount * rowHeight) + rowHeight) + 2, panelWidth - 4, (panelWidth / 2) * scaleFactor, "color1")
						end

						playSoundEffect("menuenter.mp3")
					elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.performance")) then
							local componentCompatible = false

							if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
								local tuningDataName = loopTable[hoveredCategory]["upgradeData"]
								local equippedTuningID = getElementData(enteredVehicle, "tuning." .. tuningDataName) or 1
								outputDebugString(tuningDataName)

								if tuningDataName == "nitro" then
									equippedTuning = -1
									componentCompatible = true
								else
									if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck"}) then
										--local driveType = getVehicleHandling(enteredVehicle)["driveType"]
										--equippedTuning = (driveType == "fwd" and 1) or (driveType == "awd" and 2) or (driveType == "rwd" and 3)
										---outputDebugString(tuningDataName.." is the part")
										--engine,turbo,tires,brakes,weightreduction
										if tuningDataName == "engine" then
											local value = getVehicleHandling(enteredVehicle)["maxVelocity"]
											local old = getOriginalHandling(getElementModel(enteredVehicle))["maxVelocity"]
											local new = value-old
											local column = (math.floor( new * 100 ) / 100 )
											equippedTuning = (column == 10 and 2) or (column == 20 and 3) or (column == 30 and 4) or 1
										elseif tuningDataName == "turbo" then
											local value = getVehicleHandling(enteredVehicle)["engineInertia"]
											local old = getOriginalHandling(getElementModel(enteredVehicle))["engineInertia"]
											local new = value-old
											local column = (math.floor( new * 100 ) / 100 )
											equippedTuning = (column == -10 and 2) or (column == -20 and 3) or (column == -30 and 4) or 1
										elseif tuningDataName == "tires" then
											local value = getVehicleHandling(enteredVehicle)["tractionMultiplier"]
											local old = getOriginalHandling(getElementModel(enteredVehicle))["tractionMultiplier"]
											local new = value-old
											local column = (math.floor( new * 100 ) / 100 )
											equippedTuning = (column == 0.05 and 2) or (column == 0.1 and 3) or (column == 0.15 and 4) or 1
										elseif tuningDataName == "brakes" then
											local value = getVehicleHandling(enteredVehicle)["brakeDeceleration"]
											local old = getOriginalHandling(getElementModel(enteredVehicle))["brakeDeceleration"]
											local new = value-old
											local column = (math.floor( new * 100 ) / 100 )
											equippedTuning = (column == 0.05 and 2) or (column == 0.1 and 3) or (column == 0.14 and 4) or 1
										elseif tuningDataName == "weightreduction" then
											local value = getVehicleHandling(enteredVehicle)["mass"]
											local old = getOriginalHandling(getElementModel(enteredVehicle))["mass"]
											local new = value-old
											local column = (math.floor( new * 100 ) / 100 )
											equippedTuning = (column == -100 and 2) or (column == -200 and 3) or (column == -300 and 4) or 1
										else
											equippedTuning = equippedTuningID
										end
										componentCompatible = true
									end
								end
							end

							if componentCompatible then
								setCameraAndComponentVisible()
								selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
							if isGTAUpgradeSlot(loopTable[hoveredCategory]["upgradeSlot"]) then
								local upgradeSlot = loopTable[hoveredCategory]["upgradeSlot"]
								local compatibleUpgrades = getVehicleCompatibleUpgrades(enteredVehicle, upgradeSlot)

								if compatibleUpgrades[1] == nil then
									giveNotification("error", getLocalizedText("notification.error.notCompatible", loopTable[hoveredCategory]["categoryName"]))
								else
									setCameraAndComponentVisible()

									compatibleOpticalUpgrades = compatibleUpgrades
									equippedTuning = getVehicleUpgradeOnSlot(enteredVehicle, upgradeSlot)

									table.insert(tuningMenu[selectedCategory]["availableUpgrades"], {
										["categoryName"] = getLocalizedText("tuningPack.0"),
										["tuningPrice"] = 0,
										["upgradeID"] = 0
									})

									for id, upgrade in pairs(compatibleOpticalUpgrades) do
										table.insert(tuningMenu[selectedCategory]["availableUpgrades"], {
											["categoryName"] = tuningMenu[selectedCategory]["subMenu"][hoveredCategory]["categoryName"] .. " " .. id,
											["tuningPrice"] = tuningMenu[selectedCategory]["subMenu"][hoveredCategory]["tuningPrice"],
											["upgradeID"] = upgrade
										})
									end

									selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
									showDefaultOpticalUpgrade()
								end
							else -- Customs optical elements (Neon, Air-Ride etc..)
								local componentCompatible = false
								if hoveredCategory == 10 then -- Lamp color
									if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
										equippedTuning = -1

										setVehicleOverrideLights(enteredVehicle, 2)

										savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
										savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}

										createColorPicker(enteredVehicle, panelX + 2, (panelY + (logoHeight * scaleFactor) + (rowHeight * 2) + rowHeight) + 2, panelWidth - 4, (panelWidth / 2) * scaleFactor, "headlight")

										componentCompatible = true
									end
								elseif hoveredCategory == 11 then -- Neon
									if isComponentCompatible(enteredVehicle, "Automobile") then
										local currentNeon = getElementData(enteredVehicle, "tuning.neon") or false

										if currentNeon == "white" then currentNeon = 2
										elseif currentNeon == "blue" then currentNeon = 3
										elseif currentNeon == "green" then currentNeon = 4
										elseif currentNeon == "red" then currentNeon = 5
										elseif currentNeon == "yellow" then currentNeon = 6
										elseif currentNeon == "pink" then currentNeon = 7
										elseif currentNeon == "orange" then currentNeon = 8
										elseif currentNeon == "lightblue" then currentNeon = 9
										elseif currentNeon == "rasta" then currentNeon = 10
										elseif currentNeon == "ice" then currentNeon = 11
										else currentNeon = 1
										end

										equippedTuning = currentNeon
										removeNeon(enteredVehicle, true)

										componentCompatible = true
									end
								elseif hoveredCategory == 12 then -- CustomPaint
									if isComponentCompatible(enteredVehicle, "Automobile","Helicopter") then
										local currentCustomPaint = getElementData(enteredVehicle, "tuning.custompaint") or false

										equippedTuning = currentCustomPaint
										removeCustomPaint(enteredVehicle, true)

										componentCompatible = true
									end
								end

								if componentCompatible then
									setCameraAndComponentVisible()
									selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
								end
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
							local componentCompatible = false

							if hoveredCategory == 1 then
								if isComponentCompatible(enteredVehicle, "Automobile") then
									equippedTuning = getVehicleWheelSize(enteredVehicle, "front")
									triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", loopTable[hoveredCategory]["subMenu"][1]["tuningData"])

									componentCompatible = true
								end
							elseif hoveredCategory == 2 then
								if isComponentCompatible(enteredVehicle, "Automobile") then
									equippedTuning = getVehicleWheelSize(enteredVehicle, "rear")
									triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", loopTable[hoveredCategory]["subMenu"][1]["tuningData"])

									componentCompatible = true
								end
							elseif hoveredCategory == 3 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
									equippedTuning = getVehicleOffroadAbility(enteredVehicle)
									componentCompatible = true
								end
							elseif hoveredCategory == 4 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad"}) then
									local driveType = getVehicleHandling(enteredVehicle)["driveType"]

									equippedTuning = (driveType == "fwd" and 1) or (driveType == "awd" and 2) or (driveType == "rwd" and 3)
									componentCompatible = true
								end
							elseif hoveredCategory == 5 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike", "BMX"}) then
									local steeringLock = getVehicleHandling(enteredVehicle)["steeringLock"]

									equippedTuning = (steeringLock == 30 and 2) or (steeringLock == 40 and 3) or (steeringLock == 50 and 4) or (steeringLock == 60 and 5) or 1
									componentCompatible = true
								end
							elseif hoveredCategory == 6 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
									equippedTuning = getVehiclePlateText(enteredVehicle)
									vehicleNumberplate = equippedTuning
									componentCompatible = true
								end
							end

							if componentCompatible then
								setCameraAndComponentVisible()
								selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
							promptDialog = {
								["state"] = true,
								["itemName"] = categoryName .. " (" .. loopTable[hoveredCategory]["categoryName"] .. ")",
								["itemPrice"] = loopTable[hoveredCategory]["tuningPrice"]
							}
						end

						playSoundEffect("menuenter.mp3")
					elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
						promptDialog = {
							["state"] = true,
							["itemName"] = categoryName .. " (" .. loopTable[hoveredCategory]["categoryName"] .. ")",
							["itemPrice"] = loopTable[hoveredCategory]["tuningPrice"]
						}
					end
				else -- Buying item after accepted prompt
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.performance")) then
						if hoveredCategory == equippedTuning then
							giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
							promptDialog["state"] = false
						else
							if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
								if loopTable[hoveredCategory]["tuningData"] ~= 0 then
									local tuningName = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeData"]
									if tuningName ~= "nitro" then
										triggerServerEvent("tuning->PerformanceUpgrade", localPlayer, enteredVehicle, loopTable[hoveredCategory]["tuningData"])
										equippedTuning = hoveredCategory
									else
										if loopTable[hoveredCategory]["tuningData"] ~= 0 then
											triggerServerEvent("onPlayerBuyNOS",localPlayer,localPlayer,loopTable[hoveredCategory]["tuningData"])
										end
									end

									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								end
							else
								giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
								promptDialog["state"] = false
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
							if equippedTuning == loopTable[hoveredCategory]["upgradeID"] then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									if loopTable[hoveredCategory]["upgradeID"] == 0 then
										triggerServerEvent("tuning->OpticalUpgrade", localPlayer, enteredVehicle, "remove", equippedTuning)
										equippedTuning = 0
									else
										triggerServerEvent("tuning->OpticalUpgrade", localPlayer, enteredVehicle, "add", loopTable[hoveredCategory]["upgradeID"])
										equippedTuning = loopTable[hoveredCategory]["upgradeID"]
									end
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						else
							if selectedSubCategory == 10 then -- Lamp color
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
									savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}

									triggerServerEvent("tuning->Color", localPlayer, enteredVehicle, savedVehicleColors["all"], savedVehicleColors["headlight"])

									equippedTuning = -1
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							elseif selectedSubCategory == 11 then -- Neon
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									saveNeon(enteredVehicle, loopTable[hoveredCategory]["tuningData"], true)

									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							elseif selectedSubCategory == 12 then -- Neon
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									saveCustomPaint(enteredVehicle, loopTable[hoveredCategory]["tuningData"], true)

									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
						if selectedSubCategory == 1 or selectedSubCategory == 2 then
							local vehicleSide = (selectedSubCategory == 1 and "front") or (selectedSubCategory == 2 and "rear")

							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, vehicleSide, loopTable[hoveredCategory]["tuningData"])

									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 3 then
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									triggerServerEvent("tuning->OffroadAbility", localPlayer, enteredVehicle, loopTable[hoveredCategory]["tuningData"])

									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 4 or selectedSubCategory == 5 then
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									triggerServerEvent("tuning->HandlingUpdate", localPlayer, enteredVehicle, tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["propertyName"], loopTable[hoveredCategory]["tuningData"])

									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 6 then
							if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
								if loopTable[hoveredCategory]["tuningData"] == "random" then
									vehicleNumberplate = generateString(8)
								elseif loopTable[hoveredCategory]["tuningData"] == "custom" then
									vehicleNumberplate = vehicleNumberplate
								end

								triggerServerEvent("tuning->LicensePlate", localPlayer, enteredVehicle, vehicleNumberplate)

								equippedTuning = vehicleNumberplate
								moneyChange(loopTable[hoveredCategory]["tuningPrice"])
								promptDialog["state"] = false
							else
								giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
								promptDialog["state"] = false
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
						if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
							savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
							savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}

							triggerServerEvent("tuning->Color", localPlayer, enteredVehicle, savedVehicleColors["all"], savedVehicleColors["headlight"])

							equippedTuning = hoveredCategory
							moneyChange(loopTable[hoveredCategory]["tuningPrice"])
							promptDialog["state"] = false
						else
							giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
							promptDialog["state"] = false
						end
					end
				end
			end

			if key == "mouse_wheel_up" and not promptDialog["state"] then
				if isCursorShowing() and not isMTAWindowActive() then
					cameraSettings["zoom"] = math.max(cameraSettings["zoom"] - 5, 30)
					cameraSettings["zoomTick"] = getTickCount()
				end
			elseif key == "mouse_wheel_down" and not promptDialog["state"] then
				if isCursorShowing() and not isMTAWindowActive() then
					cameraSettings["zoom"] = math.min(cameraSettings["zoom"] + 5, 60)
					cameraSettings["zoomTick"] = getTickCount()
				end
			end
		end
	end
end)

addEventHandler("tuning->ShowMenu", root, function(vehicle)
	if source and vehicle then
		if not panelState then
			enteredVehicle = vehicle

			createFonts()

			hoveredCategory, selectedCategory, selectedSubCategory = 1, 0, 0
			maxRowsPerPage, currentPage = 7, 1

			navigationBar[1][1] = getLocalizedText("navbar.select")
			navigationBar[2][1] = getLocalizedText("navbar.navigate")
			navigationBar[3][1] = getLocalizedText("navbar.back")

			if noticeData["timer"] then
				if isTimer(noticeData["timer"]) then
					killTimer(noticeData["timer"])
				end
			end

			noticeData = {
				["text"] = false,
				["type"] = "info",
				["tick"] = 0,
				["state"] = "",
				["height"] = 0,
				["timer"] = nil
			}

			local _, _, vehicleRotation = getElementRotation(enteredVehicle)
			local cameraRotation = vehicleRotation + 60

			cameraSettings = {
				["distance"] = 9,
				["movingSpeed"] = 2,
				["currentX"] = math.rad(cameraRotation),
				["defaultX"] = math.rad(cameraRotation),
				["currentY"] = math.rad(cameraRotation),
				["currentZ"] = math.rad(15),
				["maximumZ"] = math.rad(35),
				["minimumZ"] = math.rad(0),
				["freeModeActive"] = false,
				["zoomTick"] = 0,
				["zoom"] = 60
			}

			cameraSettings["moveState"] = "freeMode"

			promptDialog = {
				["state"] = false,
				["itemName"] = "",
				["itemPrice"] = 0
			}

			panelState = true
			toggleAllControls(false)
			setPlayerHudComponentVisible("all", false)
			showChat(false)
			showCursor(true)
		end
	end
end)

function isPlayerModding(player)
	if player == localPlayer then
		if panelState == true then
			return true
		else
			return false
		end
	end
end

addEventHandler("tuning->HideMenu", root, function()
	if enteredVehicle and panelState then
		panelState = false
		toggleAllControls(true)
		setPlayerHudComponentVisible("all", true)
		showChat(true)
		enteredVehicle = nil
		destroyFonts()
		setCameraTarget(localPlayer)
		showCursor(false)

		triggerServerEvent("tuning->ResetMarker", root, localPlayer)
	end
end)

--[[

if isTimer(noticeData["timer"]) then
			killTimer(noticeData["timer"])
		end
		destroyColorPicker()
		destroyFonts()
		promptDialog["state"] = false
		panelState = false
		selectedCategory, hoveredCategory, currentPage = 0, 1, 1
		hoveredCategory, selectedCategory, selectedSubCategory = 1, 0, 0
		maxRowsPerPage, currentPage = 7, 1
		enteredVehicle = nil
		toggleAllControls(true)
		setPlayerHudComponentVisible("all", true)
		showChat(true)
		showCursor(false)
		triggerServerEvent("tuning->ResetMarker", root, localPlayer)

		]]

function closeAll()
	if enteredVehicle and panelState then
		if promptDialog["state"] then
			promptDialog["state"] = false
		end
		if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) and selectedSubCategory == 6 then
			if hoveredCategory == 2 then
				if #vehicleNumberplate - 1 >= 0 then
					vehicleNumberplate = string.sub(vehicleNumberplate, 1, #vehicleNumberplate - 1)
					setVehiclePlateText(enteredVehicle, vehicleNumberplate)
				else
					setVehiclePlateText(enteredVehicle, "")
					vehicleNumberplate = ""
				end
			else
				if equippedTuning ~= vehicleNumberplate then
					setVehiclePlateText(enteredVehicle, equippedTuning)
					vehicleNumberplate = equippedTuning
				end
			end
		end
		if selectedCategory == 0 and selectedSubCategory == 0 then
			triggerEvent("tuning->HideMenu", localPlayer)
		elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
			if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then -- Color
				destroyColorPicker()
				setVehicleColorsToDefault()
			end
			selectedCategory, hoveredCategory, currentPage = 0, 1, 1
		elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
			moveCameraToDefaultPosition()
			if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then -- Optical
				if selectedSubCategory ~= 0 then
					if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
						resetOpticalUpgrade() -- reset to equipped upgrade
						tuningMenu[selectedCategory]["availableUpgrades"] = {}
						equippedTuning = 1
					else
						if selectedSubCategory == 10 then -- Lamp color
							destroyColorPicker()
							setVehicleColorsToDefault()
							setVehicleOverrideLights(enteredVehicle, 1)
						elseif selectedSubCategory == 11 then -- Neon
							restoreOldNeon(enteredVehicle)
						elseif selectedSubCategory == 12 then -- Neon
							restoreOldCustomPaint(enteredVehicle)
						end
					end
				end
			elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then -- Extras
				if selectedSubCategory == 1 then
					local defaultWheelSize = (equippedTuning == 1 and "verynarrow") or (equippedTuning == 2 and "narrow") or (equippedTuning == 3 and "default") or (equippedTuning == 4 and "wide") or (equippedTuning == 5 and "verywide")
					triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", defaultWheelSize)
				elseif selectedSubCategory == 2 then
					local defaultWheelSize = (equippedTuning == 1 and "verynarrow") or (equippedTuning == 2 and "narrow") or (equippedTuning == 3 and "default") or (equippedTuning == 4 and "wide") or (equippedTuning == 5 and "verywide")
					triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", defaultWheelSize)
				end
			end
			selectedSubCategory, hoveredCategory, currentPage = 0, 1, 1
		end
		if enteredVehicle then
			for component in pairs(getVehicleComponents(enteredVehicle)) do
				setVehicleComponentVisible(enteredVehicle, component, true)
			end
		end
	end
end

addEventHandler("onClientPlayerWasted",localPlayer,function()
	if source == localPlayer then
		if isTimer(closingTimer) then killTimer(closingTimer) end
		closingTimer = setTimer(closeAll,1000,5)
	end
end)


addEventHandler("onClientVehicleExit", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
			if isPlayerModding(localPlayer) then

					if isTimer(closingTimer) then killTimer(closingTimer) end
					closingTimer = setTimer(closeAll,1000,5)

			end
        end
    end
)

function moneyChange(amount)
	triggerServerEvent("takeModdingMoney",localPlayer,localPlayer,(loopTable[hoveredCategory]["tuningPrice"]))
	giveNotification("success", getLocalizedText("notification.success.purchased"))
	playSoundEffect("moneychange.wav")

	if amount > 0 then
		moneyChangeTable = {
			["tick"] = getTickCount() + 5000,
			["amount"] = amount
		}
	end
end

function createFonts()
	availableFonts = {
		chalet = dxCreateFont("files/fonts/chalet.ttf", 22 * scaleFactor, false, "antialiased"),
		icons = dxCreateFont("files/fonts/icons.ttf", 11 * scaleFactor, false, "antialiased")
	}
	if not availableFonts["chalet"] then
		availableFonts["chalet"] = "default-bold"
	end
	if not availableFonts["icons"] then
		availableFonts["icons"] = "default-bold"
	end
end

function destroyFonts()
	if availableFonts then
		for fontName, fontElement in pairs(availableFonts) do
			destroyElement(fontElement)
			availableFonts[fontName] = nil
		end

		availableFonts = nil
	end
end

function drawTextWithBorder(text, offset, x, y, w, h, borderColor, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	for offsetX = -offset, offset do
		for offsetY = -offset, offset do
			dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), x + offsetX, y + offsetY, w + offsetX, h + offsetY, borderColor, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		end
	end

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function giveNotification(type, text)
	type = type or "info"

	if noticeData["timer"] then
		if isTimer(noticeData["timer"]) then
			killTimer(noticeData["timer"])
		end
	end

	noticeData = {
		["text"] = text,
		["type"] = type,
		["tick"] = getTickCount(),
		["state"] = "showNotice",
		["height"] = 0,
		["timer"] = nil
	}

	playSoundEffect("notification.mp3")
end

function getNavbarWidth()
	local barOffsetX = 0

	for _, row in ipairs(navigationBar) do
		local textLength = dxGetTextWidth(row[1], 0.5, availableFonts["chalet"]) + 20
		local navWidth = 0

		for id, icon in ipairs(row[2]) do
			local buttonWidth = 0

			if type(row[3]) == "string" and row[3] == "image" then
				buttonWidth = row[4]
			elseif type(row[3]) == "boolean" and row[3] then
				buttonWidth = dxGetTextWidth(availableIcons[icon], 1.0, availableFonts["icons"]) + 20
			elseif type(row[3]) == "boolean" and not row[3] then
				buttonWidth = dxGetTextWidth(icon, 0.5, availableFonts["chalet"]) + 10
			end

			navWidth = navWidth + buttonWidth + 10
		end

		barOffsetX = barOffsetX + (navWidth + textLength)
	end

	return barOffsetX
end

function hasPlayerMoney(money)
	if getPlayerMoney(localPlayer) >= money then
		return true
	end

	return false
end

function drawRoundedRectangle(x, y, w, h, rounding, borderColor, bgColor, postGUI)
	borderColor = borderColor or tocolor(0, 0, 0, 200)
	bgColor = bgColor or borderColor
	rounding = rounding or 2

	dxDrawRectangle(x, y, w, h, bgColor, postGUI)
	dxDrawRectangle(x + rounding, y - 1, w - (rounding * 2), 1, borderColor, postGUI)
	dxDrawRectangle(x + rounding, y + h, w - (rounding * 2), 1, borderColor, postGUI)
	dxDrawRectangle(x - 1, y + rounding, 1, h - (rounding * 2), borderColor, postGUI)
	dxDrawRectangle(x + w, y + rounding, 1, h - (rounding * 2), borderColor, postGUI)
end

function showDefaultOpticalUpgrade()
	if panelState then
		if enteredVehicle then
			if equippedTuning ~= 0 then
				removeVehicleUpgrade(enteredVehicle, equippedTuning)
			elseif equippedTuning == 0 then
				removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory])
			end
		end
	end
end

function showNextOpticalUpgrade()
	if panelState then
		if enteredVehicle then
			addVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory - 1])
		end
	end
end

function resetOpticalUpgrade()
	if panelState then
		if enteredVehicle then
			if equippedTuning ~= 0 then
				addVehicleUpgrade(enteredVehicle, equippedTuning)
			else
				if hoveredCategory - 1 == 0 then
					removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory])
				else
					removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory - 1])
				end
			end
		end
	end
end

function formatNumber(amount, spacer)
	if not spacer then
		spacer = ","
	end

	amount = math.floor(amount)

	local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
	return left .. (num:reverse():gsub("(%d%d%d)", "%1" .. spacer):reverse()) .. right
end

function playSoundEffect(soundFile)
	if soundFile then
		local soundEffect = playSound("files/sounds/" .. soundFile, false)

		setSoundVolume(soundEffect, 0.5)
	end
end

function getPositionFromElementOffset(element, offsetX, offsetY, offsetZ)
	local elementMatrix = getElementMatrix(element)
    local elementX = offsetX * elementMatrix[1][1] + offsetY * elementMatrix[2][1] + offsetZ * elementMatrix[3][1] + elementMatrix[4][1]
    local elementY = offsetX * elementMatrix[1][2] + offsetY * elementMatrix[2][2] + offsetZ * elementMatrix[3][2] + elementMatrix[4][2]
    local elementZ = offsetX * elementMatrix[1][3] + offsetY * elementMatrix[2][3] + offsetZ * elementMatrix[3][3] + elementMatrix[4][3]

    return elementX, elementY, elementZ
end

function getVehiclePerformance(vehicle,checkType)
	if vehicle then
		local flags = getVehicleHandling(vehicle)[checkType]

		for name, flag in pairs(availableOffroadAbilities) do
			if isFlagSet(flags, flag[1]) then
				return flag[2]
			end
		end

		return 1
	end
end

function getVehicleOffroadAbility(vehicle)
	if vehicle then
		local flags = getVehicleHandling(vehicle)["handlingFlags"]

		for name, flag in pairs(availableOffroadAbilities) do
			if isFlagSet(flags, flag[1]) then
				return flag[2]
			end
		end

		return 1
	end
end

function getVehicleWheelSize(vehicle, side)
	if vehicle and side then
		local flags = getVehicleHandling(vehicle)["handlingFlags"]

		for name, flag in pairs(availableWheelSizes[side]) do
			if isFlagSet(flags, flag[1]) then
				return flag[2]
			end
		end

		return 3
	end
end

function isGTAUpgradeSlot(slot)
	if slot then
		for i = 0, 16 do
			if slot == i then
				return true
			end
		end
	end

	return false
end

function isFlagSet(val, flag)
	return (bitAnd(val, flag) == flag)
end

function moveCameraToComponent(component, offsetX, offsetZ, zoom)
	if component then
		local _, _, vehicleRotation = getElementRotation(enteredVehicle)

		offsetX = offsetX or cameraSettings["defaultX"]
		offsetZ = offsetZ or 15
		zoom = zoom or 9

		local cameraRotation = vehicleRotation + offsetX

		cameraSettings["moveState"] = "moveToElement"
		cameraSettings["moveTick"] = getTickCount()
		cameraSettings["viewingElement"] = component
		cameraSettings["currentX"] = math.rad(cameraRotation)
		cameraSettings["currentY"] = math.rad(cameraRotation)
		cameraSettings["currentZ"] = math.rad(offsetZ)
		cameraSettings["distance"] = zoom
	end
end

function moveCameraToDefaultPosition()
	cameraSettings["moveState"] = "backToVehicle"
	cameraSettings["moveTick"] = getTickCount()
	cameraSettings["viewingElement"] = enteredVehicle

	cameraSettings["currentX"] = cameraSettings["defaultX"]
	cameraSettings["currentY"] = cameraSettings["defaultX"]
	cameraSettings["currentZ"] = math.rad(15)
	cameraSettings["distance"] = 9
end

function _getCameraPosition(element)
	if enteredVehicle and isElement(enteredVehicle) then
	if element == "component" then
		local componentX, componentY, componentZ = getVehicleComponentPosition(enteredVehicle, cameraSettings["viewingElement"])
		local elementX, elementY, elementZ = getPositionFromElementOffset(enteredVehicle, componentX, componentY, componentZ)
		local elementZ = elementZ + 0.2

		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]

		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	elseif element == "vehicle" then
		local elementX, elementY, elementZ = getElementPosition(enteredVehicle)
		local elementZ = elementZ + 0.2

		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]

		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	elseif element == "both" then
		if type(cameraSettings["viewingElement"]) == "string" then
			local componentX, componentY, componentZ = getVehicleComponentPosition(enteredVehicle, cameraSettings["viewingElement"])

			elementX, elementY, elementZ = getPositionFromElementOffset(enteredVehicle, componentX, componentY, componentZ)
		else
			elementX, elementY, elementZ = getElementPosition(enteredVehicle)
		end

		local elementZ = elementZ + 0.2

		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]

		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	end
	end
end

function isValidComponent(vehicle, componentName)
	if vehicle and componentName then
		for component in pairs(getVehicleComponents(vehicle)) do
			if componentName == component then
				return true
			end
		end
	end

	return false
end

function setVehicleColorsToDefault()
	local vehicleColor = savedVehicleColors["all"]
	local vehicleLightColor = savedVehicleColors["headlight"]

	setVehicleColor(enteredVehicle, vehicleColor[1], vehicleColor[2], vehicleColor[3], vehicleColor[4], vehicleColor[5], vehicleColor[6], vehicleColor[7], vehicleColor[8], vehicleColor[9])
	setVehicleHeadLightColor(enteredVehicle, vehicleLightColor[1], vehicleLightColor[2], vehicleLightColor[3])
end

function setCameraAndComponentVisible()
	if getVehicleType(enteredVehicle) == "Automobile" then
		if loopTable[hoveredCategory]["cameraSettings"] then
			local cameraSetting = loopTable[hoveredCategory]["cameraSettings"]

			if isValidComponent(enteredVehicle, cameraSetting[1]) then
				moveCameraToComponent(cameraSetting[1], cameraSetting[2], cameraSetting[3], cameraSetting[4])
			end

			if cameraSetting[5] then
				setVehicleComponentVisible(enteredVehicle, cameraSetting[1], false)
			end
		end
	end
end

function generateString(len)
	if tonumber(len) then
		local allowed = {{48, 57}, {97, 122}}

		math.randomseed(getTickCount())

		local str = ""

		for i = 1, len do
			local charlist = allowed[math.random(1, 2)]

			if i == 4 then
				str = str .. " "
			else
				str = str .. string.char(math.random(charlist[1], charlist[2]))
			end
		end

		return utf8.upper(str)
	end

	return false
end

function isComponentCompatible(vehicle, vehicleType)
	if vehicle and vehicleType then
		if type(vehicleType) == "string" then
			if getVehicleType(vehicle) == vehicleType then
				return true
			else
				giveNotification("error", getLocalizedText("notification.error.notCompatible", loopTable[hoveredCategory]["categoryName"]))
			end
		elseif type(vehicleType) == "table" then
			local typeFounded = false

			for _, modelType in pairs(vehicleType) do
				if modelType == getVehicleType(vehicle) then
					typeFounded = true
				end
			end

			if typeFounded then
				return true
			else
				giveNotification("error", getLocalizedText("notification.error.notCompatible", loopTable[hoveredCategory]["categoryName"]))
			end
		end
	end

	return false
end

function drawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2

	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 200), postGUI)
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 200), postGUI)
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 200), postGUI)
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 200), postGUI)
end

function drawBorderedRectangle(x, y, w, h, borderSize, borderColor, bgColor, postGUI)
	borderSize = borderSize or 2
	borderColor = borderColor or tocolor(0, 0, 0, 200)
	bgColor = bgColor or borderColor

	dxDrawRectangle(x, y, w, h, bgColor, postGUI)
	drawBorder(x, y, w, h, borderSize, borderColor, postGUI)
end


