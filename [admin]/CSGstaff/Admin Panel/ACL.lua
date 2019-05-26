-- GUI table
local adminGUI = getAdminPanelGUI ()
-- ACL Table
local adminPanelACL = {
	-- Tabs
	{ adminGUI.GUItabs[1], 0 },
	{ adminGUI.GUItabs[2], 0 },
	{ adminGUI.GUItabs[3], 0 },
	{ adminGUI.GUItabs[4], 5 },
	{ adminGUI.GUItabs[6], 5 },
	{ adminGUI.GUItabs[7], 5 },
	-- Buttons
	{ adminGUI.GUIbuttons[1], 0 }, -- Slap Player
	{ adminGUI.GUIbuttons[2], 0 }, -- Freeze Player
	{ adminGUI.GUIbuttons[3], 1 }, -- Kick Player
	{ adminGUI.GUIbuttons[4], 0 }, -- Reconnect
	{ adminGUI.GUIbuttons[5], 0 }, -- Warp To Player
	{ adminGUI.GUIbuttons[6], 4 }, -- Warp Player To...
	{ adminGUI.GUIbuttons[7], 2 }, -- Fix Vehicle
	{ adminGUI.GUIbuttons[8], 1 }, -- Destroy Vehicle
	{ adminGUI.GUIbuttons[9], 1 }, -- Spectate Player
	{ adminGUI.GUIbuttons[10], 4 }, -- Give Vehicle
	{ adminGUI.GUIbuttons[11], 4 }, -- Set Skin
	{ adminGUI.GUIbuttons[12], 0 }, -- Rename
	{ adminGUI.GUIbuttons[13], 3 }, -- Give health
	{ adminGUI.GUIbuttons[80], 3 }, -- Give Armor
	{ adminGUI.GUIbuttons[14], 3 }, -- Give Jetpack
	{ adminGUI.GUIbuttons[15], 4 }, -- Give Premium Car
	{ adminGUI.GUIbuttons[16], 5 }, -- Give Weapon
	{ adminGUI.GUIbuttons[17], 0 }, -- Punish Player
	{ adminGUI.GUIbuttons[18], 0 }, -- Interior
	{ adminGUI.GUIbuttons[20], 0 }, -- Dimension
}

-- Punishments ACL
local punishmentTypes = {
	{ "Mainchat/teamchat mute", 0 },
	{ "Global mute", 0 },
	{ "Jail", 0 },
	{ "Account ban", 3 },
	{ "Serial ban", 3 },
}

-- Function that gets the ACL table
function onCheckPlayerACL ()
	for i=1,#adminPanelACL do
		if ( adminPanelACL[i][2] > getPlayerAdminLevel( localPlayer ) ) then
			guiSetEnabled ( adminPanelACL[i][1], false )
		else
			guiSetEnabled ( adminPanelACL[i][1], true )
		end
		--if getPlayerAdminLevel( localPlayer ) == 7 then
			--guiSetEnabled(adminGUI.GUItabs[4],false)
			--guiSetEnabled(adminGUI.GUItabs[6],false)
			--guiSetEnabled(adminGUI.GUItabs[7],false)
		--end
	end
	guiComboBoxClear ( adminGUI.GUIcombos[2] )
	for i=1,#punishmentTypes do
		if ( getPlayerAdminLevel( localPlayer ) >= punishmentTypes[i][2] ) then
			guiComboBoxAddItem( adminGUI.GUIcombos[2], punishmentTypes[i][1] )
		end
	end
	if (exports.server:getPlayerAccountName(localPlayer) == "Valken") then
		guiSetEnabled(adminGUI.GUItabs[7], true)
	end	
end