local settings = {
	{"General", {
			{"helmetenabled", "Helmet", "When you're in a bike, you'll get a helmet automatically (Only works if you purchased a helmet at 24/7 shops). \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"supportchat", "Support Chat", "Able to see Support Chat. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"smsnotification", "SMS Unread", "Able to see unread sms notifications. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"smschatbox", "SMS Output", "Able to see sms output. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"jobcalls", "Job Calls", "Able to see job calls output. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"chatbox", "Chatbox", "Able to see chatbox. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"turfBag", "Turf Bag", "Able to see turfing bag log. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "false", false},
			{"crimlog", "Criminal Log", "Able to see criminal log. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"premchat", "Premium/VIP Chat", "Able to see VIP/Premium Chat. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"drugsystem", "Drugs System", "You can switch which style you want old style or new style.\nNew Style: Automated | Old Style: Binds/Buttons", "combo", {"New", "Old"}, "New", false},
		}
	},
	{"Audio", {
			{"musiccontrol", "Music Control", "Able to see music control. Choose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"globalmusic", "Global Music", "When a staff picks a music from their panel, it will automatically plays to the entire players.", "combo", {"Unmute", "Mute"}, "Unmute", false},
			{"quizmusic", "Quiz SFX", "When a player won the quiz, there will be a sound effects to be played.", "combo", {"Unmute", "Mute"}, "Unmute", false},
		}
	},
	{"Map Blips", {
			{"custom", "Custom Blips", "To able to see a custom blips from F11 and mini-map. Choose true to enable or false to disable.", "combo", {"true", "false"}, "true", true},
			{"allianceblips", "Alliance Blips", "To able to see a blip of your alliance members. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"oldgr", "Old Group/Alliance Blips", "To able to see an old version blip of your alliance/group members. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"stores", "Store Blips", "To able to see store blip. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"craft", "Craft Blips", "To able to see drug craft blip. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"radar", "Player Blips", "To able to see all player blips. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
			{"ATM", "ATM Blips", "To able to see all ATM blips. \nChoose true to enable or false to disable.", "combo", {"true", "false"}, "true", false},
		}
	},
	{"Binds", {
			{"weaponBinds", "Enable weapon binds", "Able to use bind weapons.", "combo", {"true", "false"}, "true", true},
			{"weaponBinds1", "Weapon Bind Slot 1", "Choose a key which when pressed will switch to your handgun (Deagle/Tazer/Colt-45)", "textbox", "single", "1", false},
			{"weaponBinds2", "Weapon Bind Slot 2", "Choose a key which when pressed will switch to your shotgun (Combat Shotgun/ Sawed-Off/Shotgun)", "textbox", "single", "2", false},
			{"weaponBinds3", "Weapon Bind Slot 3", "Choose a key which when pressed will switch to your SMG (MP5/Uzi/Tec-9)", "textbox", "single", "3", false},
			{"weaponBinds4", "Weapon Bind Slot 4", "Choose a key which when pressed will switch to your assault rifle. (M4/AK-47)", "textbox", "single", "4", false},
			{"weaponBinds5", "Weapon Bind Slot 5", "SChoose a key which when pressed will switch to your rifle. (Sniper/Country Rifle)", "textbox", "single", "5", false},
			{"weaponBinds6", "Weapon Bind Slot 6", "Choose a key which when pressed will switch to your heavy weapon. (Minigun/Rocket Launchers)", "textbox", "single", "6", false},
			{"weaponBinds7", "Weapon Bind Slot 7", "Choose a key which when pressed will switch to your projectile. (Teargas/Grenade/Molotov/Satchel)", "textbox", "single", "7", false},
			{"weaponBinds8", "Weapon Bind Slot 8", "Choose a key which when pressed will switch to your special weapon. (Spraycan/Camera/Fire Extinguisher)", "textbox", "single", "8", false},
		}
	},
	{"Display", {
			{"hud", "Modified Hud", "Able to see a modified hud. Choose true to enable or false to disable.", "combo", {"true", "false"}, "true", true},
			{"map", "Modified Radar", "Able to see a modified radar. Choose true to enable or false to disable.", "combo", {"true", "false"}, "true", true},
			{"gpsonhud", "GPS Location", "Able to see a GPS location. Choose true to enable or false to disable.", "combo", {"true", "false"}, "true", true},
			{"drugtimer", "Drug Timer", "Able to see drug timers. Choose true to enable or false to disable.", "combo", {"true", "false"}, "true", true},
		}
	},
	{"Graphics", {
			{"distance", "World Far Distance", "Set a value for world far distance. The lower the distance is, the better FPS.", "textbox", "number", "800", true},
			{"VIPCar", "VIP Car Modification", "You'll able to see the VIP Car modification from the game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"billboards", "Billboards", "You'll able to see the billboards from the game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"Mapmods", "HD Map Interiors", "You'll able to see high definition interiors modification from the game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"roads", "HD Road", "You'll able to see high definition road modification from the game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"blur", "Blur Effect", "You'll able to see blur effect from the game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"jobs", "Job Title", "You'll able to see the job titles from all the job locations. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"heathaze", "Heat Haze", "An effect of very hot sun, making it diffcult to see objects clearly from the game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", false},
			{"clouds", "Cloud", "Able to see the clouds. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"snoweather", "Snow", "Able to see snow in game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
			{"snowground", "Ground Snow", "Able to see ground snow shader in game. Choose true to enable or false to disable.", "combo", {"true", "false"}, "false", true},
		}
	},
}

GUIEditor = {
    tab = {},
    label = {},
    tabpanel = {},
    edit = {},
    button = {},
    window = {},
    scrollbar = {},
    combobox = {},
	scrollpane = {}
}
showCursorHandler = false
 
currentValueSettings = -57

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 865) / 2, (screenH - 497) / 2, 865, 497, "AuroraRPG - Settings", false)
		guiSetVisible(GUIEditor.window[1], false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.tabpanel[1] = guiCreateTabPanel(9, 24, 846, 439, false, GUIEditor.window[1])

        
		
		for u, theCategory in ipairs(settings) do
			GUIEditor.tab[u] = guiCreateTab(theCategory[1], GUIEditor.tabpanel[1])
			GUIEditor.scrollpane[u] = guiCreateScrollPane(10, 10, 826, 394, false, GUIEditor.tab[u])
			for i, theData in ipairs(theCategory[2]) do
				if (theData[4] == "combo") then 
					currentValueSettings = currentValueSettings + 79
					if (theData[7] == true) then 
						GUIEditor.label[i+u] = guiCreateLabel(8, currentValueSettings, 798, 40, theData[2]..":\n"..theData[3].."\n- Warning: This setting might effect your game performance.", false, GUIEditor.scrollpane[u])
					else 
						GUIEditor.label[i+u] = guiCreateLabel(8, currentValueSettings, 798, 40, theData[2]..":\n"..theData[3], false, GUIEditor.scrollpane[u])
					end
					guiSetFont(GUIEditor.label[i+u], "default-bold-small")
					GUIEditor.combobox[theData[1]] = guiCreateComboBox(23, currentValueSettings+45, 192, 101, "Choose a value", false, GUIEditor.scrollpane[u])
					
					if not exports.DENsettings:getPlayerSetting(theData[1]) then
						exports.DENsettings:addPlayerSetting(theData[1], theData[6])
					end
					for o, comboData in ipairs(theData[5]) do 
						guiComboBoxAddItem (GUIEditor.combobox[theData[1]], comboData)
						if comboData == tostring(exports.DENsettings:getPlayerSetting(theData[1])) then 
							guiComboBoxSetSelected(GUIEditor.combobox[theData[1]], o-1)
						end 
					end 
				elseif (theData[4] == "textbox") then 
					currentValueSettings = currentValueSettings + 79
					if (theData[7] == true) then 
						GUIEditor.label[i+u] = guiCreateLabel(8, currentValueSettings, 798, 40, theData[2]..":\n"..theData[3].."\n- Warning: This setting might effect your game performance.", false, GUIEditor.scrollpane[u])
					else
						GUIEditor.label[i+u] = guiCreateLabel(8, currentValueSettings, 798, 40, theData[2]..":\n"..theData[3], false, GUIEditor.scrollpane[u])
					end 
					guiSetFont(GUIEditor.label[i+u], "default-bold-small")
					GUIEditor.edit[theData[1]] = guiCreateEdit(23, currentValueSettings+45, 190, 27, "", false, GUIEditor.scrollpane[u])
					if (theData[5] == "number") then 
						guiSetProperty(GUIEditor.edit[theData[1]], "ValidationString", "^[0-9]*$")
					elseif (theData[5] == "single") then 
						guiEditSetMaxLength (GUIEditor.edit[theData[1]], 1)
					end 
					if not exports.DENsettings:getPlayerSetting(theData[1]) then
						exports.DENsettings:addPlayerSetting(theData[1], theData[6])
					end
					guiSetText(GUIEditor.edit[theData[1]], exports.DENsettings:getPlayerSetting(theData[1]))
				end
			end 
		end

        GUIEditor.button[1] = guiCreateButton(744, 467, 101, 20, "Apply", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(9, 467, 101, 20, "Close", false, GUIEditor.window[1])    
		
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[2], openGUI, false)
		addEventHandler ("onClientGUIClick", GUIEditor.button[1], saveSettings, false)
    end
)

function saveSettings()
	for u, theCategory in ipairs(settings) do
		for i, theData in ipairs(theCategory[2]) do
			if (theData[4] == "combo") then 
				if not exports.DENsettings:getPlayerSetting(theData[1]) then
					exports.DENsettings:addPlayerSetting(theData[1], theData[6])
				end
				local item = guiComboBoxGetItemText(GUIEditor.combobox[theData[1]], guiComboBoxGetSelected(GUIEditor.combobox[theData[1]]))
				if item ~= tostring(exports.DENsettings:getPlayerSetting(theData[1])) then 
					exports.DENsettings:setPlayerSetting(theData[1], item)
				end 
			elseif (theData[4] == "textbox") then 
				if not exports.DENsettings:getPlayerSetting(theData[1]) then
					exports.DENsettings:addPlayerSetting(theData[1], theData[6])
				end
				
				local item = guiGetText(GUIEditor.edit[theData[1]])
				if item ~= tostring(exports.DENsettings:getPlayerSetting(theData[1])) then 
					exports.DENsettings:setPlayerSetting(theData[1], item)
				end 
			end
		end 
	end
	exports.NGCdxmsg:createNewDxMessage("The settings that you apply is now saved!", 0, 255, 0)
	guiSetEnabled(GUIEditor.button[1], false)
	guiSetText(GUIEditor.window[1], "The settings that you apply is now saved!")
	setTimer(function()
		guiSetEnabled(GUIEditor.button[1], true)
		guiSetText(GUIEditor.window[1], "AuroraRPG - Settings")
	end, 5000, 1)
end 

function openGUI ()
	if (guiGetVisible(GUIEditor.window[1])) == false then 
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
		showCursorHandler = setTimer(function()
			if (not isCursorShowing()) then 
				showCursor(true)
			end 
		end, 500, 0)
	else 
		guiSetVisible(GUIEditor.window[1], false)
		if isTimer(showCursorHandler) then 
			killTimer(showCursorHandler)
		end 
		showCursor(false)
	end 
end 
addCommandHandler("settings", openGUI)