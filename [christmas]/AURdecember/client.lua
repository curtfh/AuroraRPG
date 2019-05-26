--[[
AuroraRPG - aurorarpg.com
This resource is property of AuroraRPG.
Author: Curt
All Rights Reserved 2017
]]--

function RGBToHex(red, green, blue, alpha)
	if( ( red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255 ) or ( alpha and ( alpha < 0 or alpha > 255 ) ) ) then
		return nil
	end
	if alpha then
		return string.format("#%.2X%.2X%.2X%.2X", red, green, blue, alpha)
	else
		return string.format("#%.2X%.2X%.2X", red, green, blue)
	end
end

function string.split(str)

   if not str or type(str) ~= "string" then return false end

   local splitStr = {}
   for i=1,string.len(str) do
      local char = str:sub( i, i )
      table.insert( splitStr , char )
   end

   return splitStr 
end
 
function removeHEXFromString(str) 
	return str:gsub("#%x%x%x%x%x%x", "") 
end 

local sound
local screenW, screenH = guiGetScreenSize()
local theText = "Loading Scene..."
local lyrics = {
	-- Secs, Show
	{0, "Merry Christmas from\nAuroraRPG Management"},
	{5, "Hope you have a great day!"},
	{15, "Keep enjoying playing AuroraRPG"},
	{18, "We love you all. Its a great time that this is the last month of 2017!"},
	{25, "<3"},
	{25.5, ""},
	{27, "I just can't wait"},
	{35, "I don't want a lot for Christmas"},
	{38, "There is just one thing I need"},
	{41, "And I don't care about the presents"},
	{44, "Underneath the Christmas tree"},
	{47, "I don't need to hang my stocking"},
	{51, "There upon the fireplace"},
	{54, "Santa Claus won't make me happy"},
	{57, "With a toy on Christmas Day"},
	{60, "I just want you for my own"},
	{63, "More than you could ever know"},
	{67, "Make my wish come true"},
	{70, "All I want for Christmas"},
	{73, "Is you"},
	{76, "You, baby"},
	{79, "Oh, I won't ask for much this Christmas"},
	{83, "I won't even wish for snow"},
	{85, "And I'm just gonna keep on waiting"},
	{89, "Underneath the mistletoe"},
	{92, "I won't make a list and send it"},
	{96, "To the North Pole for Saint Nick"},
	{99, "I won't even stay awake to"},
	{102, "Hear those magic reindeer click"},
	{105, "'Cause I just want you here tonight"},
	{108, "Holding on to me so tight"},
	{111, "What more can I do?"},
	{114, "Cause baby all I want for Christmas is you"},
	{121, "You"},
	{123, "Oh-ho, all the lights are shining"},
	{127, "So brightly everywhere"},
	{131, "And the sound of children"},
	{134, "Laughter fills the air"},
	{138, "And everyone is singing"},
	{140, "I hear those sleigh bells ringing"},
	{143, "Santa won't you bring me the one I really need?"},
	{146, "Won't you please bring my baby to me?"},
	{148, "Yeah"},
	{150, "Oh, I don't want a lot for Christmas"},
	{153, "This is all I'm asking for"},
	{157, "I just wanna see my baby (Yeahhh)"},
	{159, "Standing right outside my door"},
	{162, "Oh I just want you for my own"},
	{164, "For my own"},
	{165, "Baby"},
	{166, "More than you could ever know"},
	{168, "Make my wish come true"},
	{171, "Baby all I want for Christmas is"},
	{178, "You baby"},
	{185, "All I want for Christmas is you baby"},
}

local scene = {
	--seconds, where
	{0, 1444.6223144531, -1535.2733154297, 56.545124053955, 1483.4781494141, -1471.0998535156, 122.66608428955, 0, 70, false},
	{33.5, 1773.9072265625, -1276.546875, 37.983585357666, 1685.5655517578, -1302.1790771484, 77.210304260254, 0, 70, false},
	{33.6, 1482.5615234375, -1468.9439697266, 31.505073547363, 1504.1271972656, -1416.087890625, 113.60961914063, 0, 70, false},
	{34, 1221.3239746094, -1323.3536376953, 29.603773117065, 1125.5915527344, -1323.8264160156, 0.70588880777359, 0, 70, false},
	{34.5, 1514.0074462891, -1676.8519287109, 18.439012527466, 1613.8430175781, -1681.6480712891, 15.298528671265, 0, 70, false},
	{35, 1928.7496337891, -1496.8012695313, 30.252412796021, 2012.0541992188, -1442.1994628906, 21.364656448364, 0, 70, false},
	{43, 774.02972412109, -658.44818115234, 66.912384033203, 723.11236572266, -578.91021728516, 34.031688690186, 0, 70, true},
	{52, 998.99108886719, -368.66317749023, 85.388130187988, 1079.6315917969, -310.19848632813, 76.500373840332, 0, 70, true},
	{64, 370.37658691406, -282.72256469727, 62.5859375, 296.78829956055, -221.02418518066, 34.691947937012, 0, 70, true},
	{74, 276.18661499023, 64.660041809082, 4.0003690719604, 313.49313354492, 156.85006713867, 14.451251029968, 0, 70, true},
	{85, 1073.5998535156, 1190.4584960938, 68.354621887207, 1077.4379882813, 1094.8018798828, 39.456737518311, 0, 70, true},
	{97, 1819.7946777344, 1045.9349365234, 10.138683319092, 1797.8029785156, 1143.0319824219, 19.547744750977, 0, 70, true},
	{102, 2428.3542480469, 2366.5009765625, 18.872047424316, 2337.3857421875, 2325.0241699219, 16.778200149536, 0, 70, true},
	{115, 2396.4565429688, 2652.8017578125, 22.566389083862, 2476.0280761719, 2712.9248046875, 29.888830184937, 0, 70, true},
	{121, 185.30160522461, 1929.2454833984, 18.590494155884, 237.71823120117, 1844.1241455078, 15.973293304443, 0, 70, true},
	{126, -939.63684082031, 1629.3559570313, 51.702301025391, -878.12005615234, 1551.4366455078, 39.690872192383, 0, 70, true},
	{133, -1650.3254394531, 647.34783935547, 20.990097045898, -1572.5440673828, 704.84887695313, -4.3810157775879, 0, 70, true},
	{141, -1892.2369384766, 729.77850341797, 52.947765350342, -1991.2310791016, 731.07904052734, 67.035247802734, 0, 70, true},
	{146, -2017.0854492188, 135.17756652832, 28.835845947266, -2073.0852050781, 218.02040100098, 29.882827758789, 0, 70, true},
	{152, -2188.3752441406, -193.65213012695, 43.039161682129, -2110.205078125, -256.00872802734, 41.992179870605, 0, 70, true},
	{158, -1577.6350097656, -396.75241088867, 8.7609014511108, -1483.4156494141, -408.46377563477, 40.154426574707, 0, 70, true},
	{162, -1501.3292236328, -454.25903320313, 10.559136390686, -1533.8674316406, -365.78646850586, 43.933769226074, 0, 70, true},
	{169, -1551.7498779297, -443.72348022461, 52.29829788208, -1490.0260009766, -372.70837402344, 18.430639266968, 0, 70, true},
	{173, 2785.0539550781, 850.32000732422, 32.999893188477, 2830.6584472656, 937.93054199219, 17.359373092651, 0, 70, true},
	{178, 3073.8657226563, 960.44415283203, 15.955600738525, 3161.2487792969, 912.64025878906, 7.0678434371948, 0, 70, true},
	{185, 3335.673828125, 942.30975341797, 19.161052703857, 3397.4560546875, 1020.5492553711, 11.316619873047, 0, 70, true},

}

local timer
local timer2
local timer3

function cameraMode (status)
	if (status == true) then 
		showChat(false)
		showPlayerHudComponent ("area_name", false)
		showPlayerHudComponent ("radar", false)
		showPlayerHudComponent ("vehicle_name", false)
		showPlayerHudComponent ("radio", false)
		exports.DENsettings:setPlayerSetting("custom", false)
		exports.DENsettings:setPlayerSetting("radar", false)
		triggerServerEvent("AURintroduction.tControls", root, true)
		setElementFrozen(getLocalPlayer(), true)
	else
		showChat(true)
		showPlayerHudComponent ("area_name", true)
		showPlayerHudComponent ("radar", true)
		showPlayerHudComponent ("vehicle_name", true)
		showPlayerHudComponent ("radio", true)
		exports.DENsettings:setPlayerSetting("custom", true)
		exports.DENsettings:setPlayerSetting("radar", true)
		triggerServerEvent("AURintroduction.tControls", root, false)
		setElementFrozen(getLocalPlayer(), false)
		setCameraTarget(getLocalPlayer())
	end 
end

function rendereMe()
	dxDrawText(removeHEXFromString(theText), (screenW * 0.0737) - 1, (screenH * 0.0711) - 1, (screenW * 0.9300) - 1, (screenH * 0.9211) - 1, tocolor(0, 0, 0, 255), 2.50, "default-bold", "center", "center", false, false, true, true, false)
	dxDrawText(removeHEXFromString(theText), (screenW * 0.0737) + 1, (screenH * 0.0711) - 1, (screenW * 0.9300) + 1, (screenH * 0.9211) - 1, tocolor(0, 0, 0, 255), 2.50, "default-bold", "center", "center", false, false, true, true, false)
	dxDrawText(removeHEXFromString(theText), (screenW * 0.0737) - 1, (screenH * 0.0711) + 1, (screenW * 0.9300) - 1, (screenH * 0.9211) + 1, tocolor(0, 0, 0, 255), 2.50, "default-bold", "center", "center", false, false, true, true, false)
	dxDrawText(removeHEXFromString(theText), (screenW * 0.0737) + 1, (screenH * 0.0711) + 1, (screenW * 0.9300) + 1, (screenH * 0.9211) + 1, tocolor(0, 0, 0, 255), 2.50, "default-bold", "center", "center", false, false, true, true, false)
	dxDrawText(theText, screenW * 0.0737, screenH * 0.0711, screenW * 0.9300, screenH * 0.9211, tocolor(255, 255, 255, 255), 2.50, "default-bold", "center", "center", false, false, true, true, false)
	showPlayerHudComponent ("radar", false)
end

function seeMe()
	if (exports.DENsettings:getPlayerSetting("AURIntroduction_696969g") == false) then
		triggerServerEvent("AURdecember.givemoni", resourceRoot, getLocalPlayer())
	end 
	if (isTimer(timer)) then return false end
	exports.DENsettings:setPlayerSetting("snoweather", true)
	exports.DENsettings:setPlayerSetting("snowground", true)
	exports.DENsettings:setPlayerSetting("AURIntroduction_696969g", true)
	fadeCamera(false)
	cameraMode(true)
	addEventHandler("onClientRender", root, rendereMe)
	sound = playSound("fGFNmEOntFA_q0.mp3", false, false)
	timer2 = setTimer(function()
		local theTextes = {}
		local ffff = removeHEXFromString(theText)
		local theFinalOutput = ""
		for word in ffff:gmatch("%w+") do table.insert(theTextes, word) end
		for _,l in ipairs(theTextes) do 
			theFinalOutput = theFinalOutput.." "..RGBToHex(math.random(0,255), math.random(0,255), math.random(0,255))..""..l..""
		end 
		theText = theFinalOutput
	end, 1000, 0)
	
	timer = setTimer(function()
		local duration = getSoundPosition(sound)
		for i, theData in ipairs(lyrics) do 
			if (theData[1] <= duration) then 
				theText = theData[2]
				table.remove(lyrics, i)
				return true
			end 
		end 
	end, 500, 0)
	
	timer3 = setTimer(function()
		local duration = getSoundPosition(sound)
		for i, theData in ipairs(scene) do 
			if (theData[1] <= duration) then 
				if theData[10] == true then 
					fadeCamera(false)
					setTimer(function()
						fadeCamera(true)
						setCameraMatrix(theData[2], theData[3], theData[4], theData[5], theData[6], theData[7], theData[8], theData[9])
					end, 1500, 1)
				else
					setCameraMatrix(theData[2], theData[3], theData[4], theData[5], theData[6], theData[7], theData[8], theData[9])
				end 
				table.remove(scene, i)
				return true
			end 
		end 
	end, 500, 0)
	setTimer(function()
		fadeCamera(true)
	end, 25000, 1)
end 
addCommandHandler("christmas", seeMe)

function seeMeNow ()
	if (exports.DENsettings:getPlayerSetting("AURIntroduction_696969g") == false) then
		seeMe()
	end 
end 

addEvent("AURdecember.go", true)
addEventHandler ( "AURdecember.go", resourceRoot, seeMeNow )

function onSoundStopped (reason)
	if source == sound then 
		if (reason == "finished") then
			killTimer(timer)
			killTimer(timer2)
			killTimer(timer3)
			fadeCamera(false)
			cameraMode(false)
			theText = "Thank you for staying with us for all these years. Merry Christmas and Happy New Year"
			setTimer(function()
				fadeCamera(true)
				removeEventHandler("onClientRender", root, rendereMe)
			end, 10000, 1)
		end
	end
end
addEventHandler ( "onClientSoundStopped", getRootElement(), onSoundStopped )

function getCLoc ()
	local x, y, z, lx, ly, lz, roll, fov = getCameraMatrix()
	setClipboard(x..", "..y..", "..z..", "..lx..", "..ly..", "..lz..", "..roll..", "..fov)
	outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..lz..", "..roll..", "..fov)
end 
addCommandHandler("flz", getCLoc)


if (fileExists("client.lua")) then fileDelete("client.lua") end

addEvent("AURdecember.start", true)
addEventHandler("AURdecember.start", resourceRoot, function()
	seeMe()
end)

if (exports.DENsettings:getPlayerSetting("AURIntroduction_696969g") == false) then
	triggerServerEvent("AURdecember.startIntro", resourceRoot, getLocalPlayer())
end 