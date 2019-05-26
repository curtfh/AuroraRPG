function setPlayerFreecamEnabled(player, x, y, z, dontChangeFixedMode)
	return triggerClientEvent(player,"doSetFreecamEnabled", getRootElement(), x, y, z, dontChangeFixedMode)
end

function setPlayerFreecamDisabled(player, dontChangeFixedMode)
	return triggerClientEvent(player,"doSetFreecamDisabled", getRootElement(), dontChangeFixedMode)
end

function setPlayerFreecamOption(player, theOption, value)
	return triggerClientEvent(player,"doSetFreecamOption", getRootElement(), theOption, value)
end

function isPlayerFreecamEnabled(player)
	return getElementData(player,"freecam:state")
end

function enableFreecam (player) 
	if (getTeamName(getPlayerTeam(player)) == "Staff") then 
		if (not isPlayerFreecamEnabled (player)) then 
			local x, y, z = getElementPosition (player) 
			setPlayerFreecamEnabled (player, x, y, z) 
			--toggleAllControls(player, false)
			setElementFrozen(player, true)
			toggleControl(player, "jump", false)
			toggleControl(player, "fire", false)
			toggleControl(player, "next_weapon", false)
			toggleControl(player, "previous_weapon", false)
			toggleControl(player, "forwards", false)
			toggleControl(player, "backwards", false)
			toggleControl(player, "left", false)
			toggleControl(player, "right", false)
			toggleControl(player, "zoom_in", false)
			toggleControl(player, "zoom_out", false)
			toggleControl(player, "sprint", false)
			toggleControl(player, "look_behind", false)
			toggleControl(player, "crouch", false)
			toggleControl(player, "action", false)
			toggleControl(player, "walk", false)
			toggleControl(player, "aim_weapon", false)
			toggleControl(player, "conversation_yes", false)
			toggleControl(player, "conversation_no", false)
			toggleControl(player, "group_control_forwards", false)
			toggleControl(player, "group_control_back", false)
			toggleControl(player, "enter_exit", false)
		else 
			setPlayerFreecamDisabled (player) 
			--toggleAllControls(player, true)
			setCameraTarget(player, player)
			setElementFrozen(player, false)
			toggleControl(player, "jump", true)
			toggleControl(player, "fire", true)
			toggleControl(player, "next_weapon", true)
			toggleControl(player, "previous_weapon", true)
			toggleControl(player, "forwards", true)
			toggleControl(player, "backwards", true)
			toggleControl(player, "left", true)
			toggleControl(player, "right", true)
			toggleControl(player, "zoom_in", true)
			toggleControl(player, "zoom_out", true)
			toggleControl(player, "sprint", true)
			toggleControl(player, "look_behind", true)
			toggleControl(player, "crouch", true)
			toggleControl(player, "action", true)
			toggleControl(player, "walk", true)
			toggleControl(player, "aim_weapon", true)
			toggleControl(player, "conversation_yes", true)
			toggleControl(player, "conversation_no", true)
			toggleControl(player, "group_control_forwards", true)
			toggleControl(player, "group_control_back", true)
			toggleControl(player, "enter_exit", true)
		end 
	end 
end 
addCommandHandler ('freecam', enableFreecam) 