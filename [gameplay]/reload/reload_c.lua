local blockedTasks = {
	"TASK_SIMPLE_IN_AIR", -- We're falling or in a jump.
	"TASK_SIMPLE_JUMP", -- We're beginning a jump
	"TASK_SIMPLE_LAND", -- We're landing from a jump
	"TASK_SIMPLE_GO_TO_POINT", -- In MTA, this is the player probably walking to a car to enter it
	"TASK_SIMPLE_NAMED_ANIM", -- We're performing a setPedAnimation
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE", -- Opening a car door
	"TASK_SIMPLE_CAR_GET_IN", -- Entering a car
	"TASK_SIMPLE_CLIMB", -- We're climbing or holding on to something
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD", -- When we try to jump but something hits us on the head
	"TASK_SIMPLE_FALL", -- We fell
	"TASK_SIMPLE_GET_UP", -- We're getting up from a fall
}

setTimer(function() reloadSpam = 0 end, 1000, 0)

local function reloadWeapon()
	reloadSpam = reloadSpam + 1
	if (reloadSpam > 5) then
		return
	end
	-- Remove the ability to reload with a full clip in some weapons to avoid network abuse (purposely desyncing etc).
	local ammo = getPedAmmoInClip( localPlayer )
	local wep = getPedWeapon( localPlayer )
	if ( ( wep == 23 and ammo == 17 ) or ( wep == 24 and ammo == 7 ) or ( wep == 27 and ammo == 7 ) or ( wep == 29 and ammo == 30 )
	or ( wep == 30 and ammo == 30 ) or ( wep == 31 and ammo == 50 ) ) then
		return
	end

	local state = getControlState("aim_weapon")
	local state2 = getControlState("jump")
	if state then
		return
	end
	if state2 then
		return
	end
	if isPedInVehicle(localPlayer) then
		return
	end
	-- Prevent instant reload while performing a jump
	-- Disable Jump By Default
	local task = getPedSimplestTask(localPlayer)
	if (task == "TASK_SIMPLE_JUMP" or task == "TASK_SIMPLE_IN_AIR" or task == "TASK_SIMPLE_CLIMB" or task == "TASK_SIMPLE_LAND" and not doesPedHaveJetPack(localPlayer)) then return false end
	for idx, badTask in ipairs( blockedTasks ) do
		-- If the player is performing any unwanted tasks, do not fire an event to reload
		if ( task == badTask ) then
			return
		end
	end
	if (isControlEnabled("jump")) then
		addEventHandler("onClientPreRender", root, enableJump)
		toggleControl("jump", false)
		toggleControl("aim_weapon", false)
	end
	--setControlState("jump",false)
	-- If you reload and press shift at the exact same time you're able to instant reload so temporarily disable jump
	triggerServerEvent( "relWep", resourceRoot )
end


local frames = 0

function enableJump()
	if (frames >= 3) then
		removeEventHandler("onClientPreRender", root, enableJump)
		toggleControl("jump", true)
		toggleControl("aim_weapon", true)
		frames = 0
	else
		frames = frames + 1
	end
end

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end

addCommandHandler( "Reload weapon",
	function ()
	if isPedAiming(localPlayer) then
		exports.NGCdxmsg:createNewDxMessage("You can't reload while aiming",255,0,0)
		return false
	else
		setTimer( reloadWeapon, 50, 1 )
		end
	end
)
bindKey("r", "down", "Reload weapon")
