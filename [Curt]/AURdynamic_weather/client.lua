--[[
Server: AuroraRPG
Resource Name: Dynamic Weather
Version: 1.0
Developer/s: Curt
]]--
local isEnabled = true
local timer = nil
local nightt = false
local dayy = false

function settingValue ()
	if not fileExists("settings.xml") then
		local settings = xmlCreateFile("settings.xml","weather_settings_client")
		xmlCreateChild(settings,"enable_dynamic_weather")
		xmlSaveFile(settings)
	end
	local node = xmlLoadFile ("settings.xml")
	local enable_dynamic_weather = xmlFindChild(node, "enable_dynamic_weather", 0)
	if (enable_dynamic_weather == "true") then 
		isEnabled = true
		setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	elseif (enable_dynamic_weather == "false") then 
		isEnabled = false
		setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	end 
	xmlSaveFile(node)
end
settingValue()


local weather_list_LS = {
	--NAME | WEATHER ID
	{"Extra Sunny", 0},
	{"Sunny", 1},
	{"Extra Sunny with Smog", 2},
	{"Sunny with Smog", 3},
	{"Cloudy", 4},
	{"Rainy", 16},
}

local weather_list_SF = {
	--NAME | WEATHER ID
	{"Sunny", 5},
	{"Extra Sunny", 6},
	{"Cloudy", 7},
	{"Rainy", 8},
	{"Foggy", 9},
}

local weather_list_LV = {
	--NAME | WEATHER ID
	{"Sunny", 10},
	{"Extra Sunny", 11},
	{"Cloudy", 12},
	{"Extra Sunny", 13},
	{"Extra Sunny", 17},
	{"Sandstorm", 19},
}

function goDynamicWeather ()
	if (isEnabled == false or dayy == true) then
		return false
	end
	local timehour, timeminute = getTime()
	
	if (exports.server:getPlayChatZone(getLocalPlayer()) == "LS") then
		local randomtable = math.random(#weather_list_LS)
		setWeatherBlended(weather_list_LS[randomtable][2])
		exports.NGCdxmsg:createNewDxMessage("The today's weather for "..timehour..":"..timeminute.." is "..weather_list_LS[randomtable][1].." in Los Santos.", 255, 255, 255)
	elseif (exports.server:getPlayChatZone(getLocalPlayer()) == "SF") then
		local randomtable = math.random(#weather_list_SF)
		setWeatherBlended(weather_list_SF[randomtable][2])
		exports.NGCdxmsg:createNewDxMessage( "The today's weather for "..timehour..":"..timeminute.." is "..weather_list_LS[randomtable][1].." in San Fierro.", 255, 255, 255)
	elseif (exports.server:getPlayChatZone(getLocalPlayer()) == "LV") then
		local randomtable = math.random(#weather_list_LV)
		setWeatherBlended(weather_list_LV[randomtable][2])
		exports.NGCdxmsg:createNewDxMessage("The today's weather for "..timehour..":"..timeminute.." is "..weather_list_LS[randomtable][1].." in Las Venturas.", 255, 255, 255)
	end
end 
goDynamicWeather()
timer = setTimer(goDynamicWeather, math.random(1800000, 7200000), 0)



function enableweatherdynamic ()
	if (isEnabled == true) then 
		exports.NGCdxmsg:createNewDxMessage( "The dynamic weather is already enabled. To disable type /sunny.", 255, 255, 255)
		return
	end 
	
	local node = xmlLoadFile ("settings.xml")
	local enable_dynamic_weather = xmlFindChild(node, "enable_dynamic_weather", 0)
	xmlNodeSetValue(enable_dynamic_weather, "true")
	isEnabled = true
	setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	xmlSaveFile(node)
	exports.NGCdxmsg:createNewDxMessage("The dynamic weather has been enabled. To disable type /sunny.", 255, 255, 255)
	goDynamicWeather()
	timer = setTimer(goDynamicWeather, math.random(1800000, 7200000), 0)
end
addCommandHandler ( "dynamicweather", enableweatherdynamic, true)

function sunny()
	local node = xmlLoadFile ("settings.xml")
	local enable_dynamic_weather = xmlFindChild(node, "enable_dynamic_weather", 0)
	xmlNodeSetValue(enable_dynamic_weather, "false")
	isEnabled = false
	setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	exports.NGCdxmsg:createNewDxMessage( "Weather changed to Sunny.", 255, 255, 255)
	setWeather(1)
	if isTimer(timer) then 
		killTimer(timer)
	end 
	xmlSaveFile(node)
end
addCommandHandler ("sunny", sunny, true)

function rainy()
	local node = xmlLoadFile ("settings.xml")
	local enable_dynamic_weather = xmlFindChild(node, "enable_dynamic_weather", 0)
	xmlNodeSetValue(enable_dynamic_weather, "false")
	isEnabled = false
	setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	exports.NGCdxmsg:createNewDxMessage( "Weather changed to Rainy.", 255, 255, 255)
	setWeather(8)
	if isTimer(timer) then 
		killTimer(timer)
	end 
	xmlSaveFile(node)
end
addCommandHandler ("rainy", rainy, true)

function foggy()
	local node = xmlLoadFile ("settings.xml")
	local enable_dynamic_weather = xmlFindChild(node, "enable_dynamic_weather", 0)
	xmlNodeSetValue(enable_dynamic_weather, "false")
	isEnabled = false
	setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	exports.NGCdxmsg:createNewDxMessage( "Weather changed to Foggy.", 255, 255, 255)
	setWeather(9)
	if isTimer(timer) then 
		killTimer(timer)
	end 
	xmlSaveFile(node)
end
addCommandHandler ("foggy", foggy, true)

function sandstorm()
	local node = xmlLoadFile ("settings.xml")
	local enable_dynamic_weather = xmlFindChild(node, "enable_dynamic_weather", 0)
	xmlNodeSetValue(enable_dynamic_weather, "false")
	isEnabled = false
	setElementData(localPlayer, "AURdynamic_weather", isEnabled)
	exports.NGCdxmsg:createNewDxMessage( "Weather changed to Foggy.", 255, 255, 255)
	setWeather(19)
	if isTimer(timer) then 
		killTimer(timer)
	end 
	xmlSaveFile(node)
end
addCommandHandler ("sandstorm", sandstorm, true)

function day_()
	if (not dayy) then
		setTime(9,0)
		isEnabled = false
		dayy = true
		setElementData(localPlayer, "AURdynamic_weather", isEnabled)
		exports.NGCdxmsg:createNewDxMessage("Successfully changed your time to day",0,255,0)
	else
		dayy = false
		isEnabled = true
		goDynamicWeather()
		setElementData(localPlayer, "AURdynamic_weather", not isEnabled)
		exports.NGCdxmsg:createNewDxMessage("Successfully changed your time to default",0,255,0)
	end
end
addCommandHandler ("day", day_, true)

function night_()
	if (not dayy) then
		setTime(0,0)
		setCloudsEnabled(false)
		isEnabled = false
		dayy = true
		setElementData(localPlayer, "AURdynamic_weather", isEnabled)
		exports.NGCdxmsg:createNewDxMessage("Successfully changed your time to night",0,255,0)
	else
		dayy = false
		isEnabled = true
		goDynamicWeather()
		setElementData(localPlayer, "AURdynamic_weather", not isEnabled)
		exports.NGCdxmsg:createNewDxMessage("Successfully changed your time to default",0,255,0)
	end
end
addCommandHandler ("night", night_, true)