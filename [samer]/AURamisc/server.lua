--
-- Author: Ab-47; State: BETA 1.2.
-- Additional Notes; N/A; Rights: All Rights Reserved by Developers with permission by Ab-47.
-- Project: AURamisc/server.lua consisting of 2 file(s).
-- Directory: [ab-47]/AURamisc/server.lua
-- Side Notes: BETA version 1.2 (Unstable Release)
--

local element = {
	attached = {},
	contact = {},
	busy = {},
	requested = {},
	spamTimer = {},
	autoDecline = {},
}

function handle_glue(plr)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
	if (element.requested[plr]) then exports.NGCdxmsg:createNewDxMessage("You have already requested to glue to a vehicle!", plr, 255, 0, 0) return end
	if (exports.server:getPlayerWantedPoints(plr) > 0) then exports.NGCdxmsg:createNewDxMessage("You cannot use this feature whilst wanted!", plr, 255, 0, 0) return end
	if (exports.AURgames:isPlayerSigned(plr)) then exports.NGCdxmsg:createNewDxMessage("You cannot use this feature whilst signed for mini-games!", plr, 255, 0, 0) return end
	if (getPlayerTeam(plr) == getTeamFromName("Mechanic")) then
		exports.NGCdxmsg:createNewDxMessage("You cannot use this feature with your current occupation!", plr, 255, 0, 0)
		return
	elseif (getPlayerTeam(plr) == getTeamFromName("Staff")) then
		return
	end
		if (not element.attached[plr]) then
			if (isTimer(element.spamTimer[plr])) then exports.NGCdxmsg:createNewDxMessage("You may only use this feature once every 60 seconds!", plr, 255, 0, 0) return end
			element.contact[plr] = {getPedContactElement(plr)}
			if (not element.contact[plr] and not getElementData(element.contact[plr][1], "vehicleOwner_")) then
				exports.NGCdxmsg:createNewDxMessage("This vehicle has no owner or you're not standing on a vehicle to use this feature!", plr, 255, 0, 0)
				return
			end
			local vehicleOwner_ = getElementData(element.contact[plr][1], "vehicleOwner")
			if (element.busy[vehicleOwner_]) then exports.NGCdxmsg:createNewDxMessage("The vehicle owner is currently busy handling a request, please try again later!", plr, 255, 0, 0) return end
			if (vehicleOwner_ and getPedOccupiedVehicle(vehicleOwner_) == element.contact[plr][1]) then
				local dim1 = getElementDimension(plr)
				local dim2 = getElementDimension(vehicleOwner_)
				if tonumber(dim1) == 0 and tonumber(dim2) == 0 and tonumber(dim1) == tonumber(dim2) then
					triggerClientEvent(vehicleOwner_, "AURpremium.request_glue", plr, plr, vehicleOwner_)
					element.busy[vehicleOwner_] = true
					element.requested[plr] = true
					element.spamTimer[plr] = setTimer(function()  outputDebugString("[ab-47]/AURamisc: ("..getPlayerName(plr)..") glue data expired.") end, 1000*60, 1)
					element.autoDecline[plr] = setTimer(initiate_glue, 1000*20, 1, plr, "declined", vehicleOwner_, nil, "Auto Declined")
					exports.NGCdxmsg:createNewDxMessage("You've requested to glue on "..getPlayerName(vehicleOwner_).."'s vehicle, please wait for response!", plr, 255, 0, 0)
				else
					exports.NGCdxmsg:createNewDxMessage("You cannot glue to a vehicle which is in another dimension!", plr, 255, 0, 0)
				end
			end
		else
			initiate_glue(plr, "unglue")
		end
	end
end
addCommandHandler("glue", handle_glue)

function initiate_glue(plr, condition, owner, slot, autoState)
	--if (owner and busy[owner]) then return end
	if (autoState and autoState == "Auto Declined") then
		if (element.attached[plr]) then return end
		exports.NGCdxmsg:createNewDxMessage("The vehicle owner took too long to respond so you were auto-declined!", plr, 255, 0, 0)
		exports.NGCdxmsg:createNewDxMessage("You took too long to respond so the player was auto-declined!", owner, 255, 0, 0)
		triggerClientEvent(owner, "AURpremium.remove_panel", plr, plr, owner)
			if (element.busy[owner]) then
				element.busy[owner] = false
			end
			element.requested[plr] = false
		return
	end
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (getPedOccupiedVehicle(plr)) then return end
		if (condition == "declined") then if (element.requested[plr]) then element.requested[plr] = false end if (element.busy[owner]) then element.busy[owner] = false end exports.NGCdxmsg:createNewDxMessage("The vehicle owner has declined or you've been auto declined upon request to glue!", plr, 255, 0, 0) return end
		--if (not element.contact[plr][1]) then return end
		if (not element.attached[plr]) then
			if (element.contact[plr] and getElementType(element.contact[plr][1]) == "vehicle") then
				if (getPedContactElement(plr) ~= element.contact[plr][1]) then
					exports.NGCdxmsg:createNewDxMessage("Your proccess could not be completed due to leaving veh glue area!", plr, 255, 0, 0)
					exports.NGCdxmsg:createNewDxMessage("The requested player did not glue due to leaving veh glue area!", owner, 255, 0, 0)
					element.requested[plr] = false
					element.busy[owner] = false
					return
				end
				local px, py, pz = getElementPosition(plr)
				local vx, vy, vz = getElementPosition(element.contact[plr][1])
				local sx = px - vx
				local sy = py - vy
				local sz = pz - vz

				local rotpX = 0
				local rotpY = 0
				local rotpZ = getPlayerRotation(plr)

				local rotvX,rotvY,rotvZ = getVehicleRotation(element.contact[plr][1])

				local t = math.rad(rotvX)
				local p = math.rad(rotvY)
				local f = math.rad(rotvZ)

				local ct = math.cos(t)
				local st = math.sin(t)
				local cp = math.cos(p)
				local sp = math.sin(p)
				local cf = math.cos(f)
				local sf = math.sin(f)

				local z = ct*cp*sz + (sf*st*cp + cf*sp)*sx + (-cf*st*cp + sf*sp)*sy
				local x = -ct*sp*sz + (-sf*st*sp + cf*cp)*sx + (cf*st*sp + sf*cp)*sy
				local y = st*sz - sf*ct*sx + cf*ct*sy

				local rotX = rotpX - rotvX
				local rotY = rotpY - rotvY
				local rotZ = rotpZ - rotvZ

				attachElements(plr, element.contact[plr][1], x, y, z, rotX, rotY, rotZ)
				element.attached[plr] = true
				element.busy[owner] = false
				element.requested[plr] = false
				setPedWeaponSlot(plr, slot)
				if (isTimer(element.autoDecline[plr])) then
					killTimer(element.autoDecline[plr])
				end
				exports.NGCdxmsg:createNewDxMessage("Your request has been accepted and you're now glued, use /glue again to unglue!", plr, 0, 255, 0)
			end
		else
			element.attached[plr] = false
			if (element.busy[owner]) then
				element.busy[owner] = false
			end
			if (isTimer(element.autoDecline[plr])) then
				killTimer(element.autoDecline[plr])
			end
			element.requested[plr] = false
			detachElements(plr, element.contact[plr][1])
			exports.NGCdxmsg:createNewDxMessage("You've unglued from the vehicle!", plr, 255, 0, 0)
		end
	end
end
addEvent("AURpremium.initiate_glue", true)
addEventHandler("AURpremium.initiate_glue", root, initiate_glue)

function onVehStartEnd(plr)
	if (plr and element.attached[plr] or element.requested[plr]) then
		cancelEvent()
		exports.NGCdxmsg:createNewDxMessage("You cannot enter a vehicle whilst being glued or requested to be glued!", plr, 255, 0, 0)
	end
end
addEventHandler("onVehicleStartEnter", root, onVehStartEnd)

function onVehDestroyed()
	if (source and getElementType(source) == "vehicle" and getElementData(source, "vehicleOwner")) then
		local owner = getElementData(source, "vehicleOwner")
		local attachedElements = getAttachedElements(source)
		for index, ele in pairs(attachedElements) do
			if (getElementType(ele) == "player" and element.attached[ele]) then
				detachElements(ele, source)
				element.attached[ele] = false
				exports.NGCdxmsg:createNewDxMessage("The vehicle was destroyed resulting in you being unglued!", ele, 255, 0, 0)
			end
		end
	end
end
addEventHandler("onElementDestroy", root, onVehDestroyed)
