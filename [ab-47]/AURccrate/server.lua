--
-- NGCccrate/server.lua consists of 2 files, author:Ab-47 all rights reserved by developers/NGC founders. 
-- Version: 1.0 (Released)
-- Version: 1.1 (Restriction Fixes/Bug Fixes version)
--

local objs1 = {}
local objs2 = {}
local objs3 = {}
local objs4 = {}
local crates = {}

local objs_ = {
	[1] = {1299},
	[2] = {1558},
	[3] = {1685},
	[4] = {925},
}

local allowed_1 = {}
local allowed_2 = {}
local allowed_3 = {}
local allowed_4 = {}

function init_objs(plr, _, string)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
	if (getPlayerTeam(plr) ~= getTeamFromName("Criminals")) then exports.NGCdxmsg:createNewDxMessage("You cannot create a crate whilst not being a criminal!", plr, 255, 0, 0) return end
	if (isPedInVehicle(plr)) then exports.NGCdxmsg:createNewDxMessage("You cannot create crates whilst being in a vehicle!", plr, 255, 0, 0) return end
	if (not isPedOnGround(plr)) then exports.NGCdxmsg:createNewDxMessage("You must be on the ground to use this command!", plr, 255, 0, 0) return end
	if (getElementDimension(plr) ~= 0 or getElementInterior(plr) ~= 0) then exports.NGCdxmsg:createNewDxMessage("You cannot create a crate in another dimension/interior!", plr, 255, 0, 0) return end
		if (getElementData(plr, "boss") or getElementData(plr, "Group") == "Criminal Organization") then
			if (string == "1") then
				if (objs1[plr] ~= nil) then exports.NGCdxmsg:createNewDxMessage("You cannot create more than 1 of this type of crate!", plr, 255, 0, 0) return end
				if (allowed_1[plr] == false) then exports.NGCdxmsg:createNewDxMessage("You can only create the same crate once every 45 seconds!", plr, 255, 0, 0) return end
				local px, py, pz = getElementPosition(plr) 
				local rx,ry,rz = getElementRotation(plr) 
				local mx,my=0,2
				local ra=math.rad(rz)
				local mxo=(mx*math.cos(ra)-my*math.sin(ra)) 
				local myo=(mx*math.sin(ra)+my*math.cos(ra)) 
				crates[plr] = unpack(objs_[1])
				allowed_1[plr] = false
				objs1[plr] = createObject(crates[plr], px+mxo,py+myo,pz-.5)
				setTimer(function() allowed_1[plr] = true if isElement(objs1[plr]) then destroyElement(objs1[plr]) objs1[plr] = nil end end, 45000, 1)
				exports.NGCdxmsg:createNewDxMessage("You have successfully created crate 2912", plr, 0, 255, 0)
			elseif (string == "2") then
				if (objs2[plr] ~= nil) then exports.NGCdxmsg:createNewDxMessage("You cannot create more than 1 of this type of crate!", plr, 255, 0, 0) return end
				if (allowed_2[plr] == false) then exports.NGCdxmsg:createNewDxMessage("You can only create the same crate once every 45 seconds!", plr, 255, 0, 0) return end
				local px, py, pz = getElementPosition(plr)
				local rx,ry,rz = getElementRotation(plr) 
				local mx,my=0,2
				local ra=math.rad(rz)
				local mxo=(mx*math.cos(ra)-my*math.sin(ra)) 
				local myo=(mx*math.sin(ra)+my*math.cos(ra)) 
				crates[plr] = unpack(objs_[2])
				allowed_2[plr] = false
				objs2[plr] = createObject(crates[plr], px+mxo,py+myo,pz-.3)
				setTimer(function() allowed_2[plr] = true if isElement(objs2[plr]) then destroyElement(objs2[plr]) objs2[plr] = nil end end, 45000, 1)
				exports.NGCdxmsg:createNewDxMessage("You have successfully created crate 1271", plr, 0, 255, 0)
			elseif (string == "3") then
				if (objs3[plr] ~= nil) then exports.NGCdxmsg:createNewDxMessage("You cannot create more than 1 of this type of crate!", plr, 255, 0, 0) return end
				if (allowed_3[plr] == false) then exports.NGCdxmsg:createNewDxMessage("You can only create the same crate once every 45 seconds!", plr, 255, 0, 0) return end
				local px, py, pz = getElementPosition(plr)
				local rx,ry,rz = getElementRotation(plr) 
				local mx,my=0,2
				local ra=math.rad(rz)
				local mxo=(mx*math.cos(ra)-my*math.sin(ra)) 
				local myo=(mx*math.sin(ra)+my*math.cos(ra)) 
				crates[plr] = unpack(objs_[3])
				allowed_3[plr] = false
				objs3[plr] = createObject(crates[plr], px+mxo,py+myo,pz-.1)
				setTimer(function() allowed_3[plr] = true if isElement(objs3[plr]) then destroyElement(objs3[plr]) objs3[plr] = nil end end, 45000, 1)
				exports.NGCdxmsg:createNewDxMessage("You have successfully created crate 1685", plr, 0, 255, 0)
			elseif (string == "4") then
				if (objs4[plr] ~= nil) then exports.NGCdxmsg:createNewDxMessage("You cannot create more than 1 of this type of crate!", plr, 255, 0, 0) return end
				if (allowed_4[plr] == false) then exports.NGCdxmsg:createNewDxMessage("You can only create the same crate once every 45 seconds!", plr, 255, 0, 0) return end
				local px, py, pz = getElementPosition(plr)
				local rx,ry,rz = getElementRotation(plr) 
				local mx,my=0,2
				local ra=math.rad(rz)
				local mxo=(mx*math.cos(ra)-my*math.sin(ra)) 
				local myo=(mx*math.sin(ra)+my*math.cos(ra)) 
				crates[plr] = unpack(objs_[4])
				allowed_4[plr] = false
				objs4[plr] = createObject(crates[plr], px+mxo,py+myo,pz)
				setElementRotation(objs4[plr], rx, ry, rz)
				setTimer(function() allowed_4[plr] = true if isElement(objs4[plr]) then destroyElement(objs4[plr]) objs4[plr] = nil end end, 45000, 1)
				exports.NGCdxmsg:createNewDxMessage("You have successfully created crate 925", plr, 0, 255, 0)
			else
				exports.NGCdxmsg:createNewDxMessage("You have entered an invalid value to create.  Syntax: /ccrate [number]", plr, 255, 0, 0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("This command is restricted to criminal bosses/official criminal groups only!", plr, 255, 0, 0)
		end
	end
end
addCommandHandler("ccrate", init_objs)

function destroy_objs(plr, _, string)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (getElementData(plr, "boss") or getElementData(plr, "Group") == "Criminal Organization") then
			if (string == "1") then
				if (objs1[plr] and crates[plr]) then 
					destroyElement(objs1[plr])
					objs1[plr] = nil
					exports.NGCdxmsg:createNewDxMessage("You have successfully destroyed your crate!", plr, 0, 255, 0)
				else
					exports.NGCdxmsg:createNewDxMessage("Sorry, your crate does not exist to be destroyed!", plr, 255, 0, 0)
				end
			elseif (string == "2") then
				if (objs2[plr] and crates[plr]) then
					destroyElement(objs2[plr])
					objs2[plr] = nil
					exports.NGCdxmsg:createNewDxMessage("You have successfully destroyed your crate!", plr, 0, 255, 0)
				else
					exports.NGCdxmsg:createNewDxMessage("Sorry, your crate does not exist to be destroyed!", plr, 255, 0, 0)
				end
			elseif (string == "3") then
				if (objs3[plr] and crates[plr]) then
					destroyElement(objs3[plr])
					objs3[plr] = nil
					exports.NGCdxmsg:createNewDxMessage("You have successfully destroyed your crate!", plr, 0, 255, 0)
				else
					exports.NGCdxmsg:createNewDxMessage("Sorry, your crate does not exist to be destroyed!", plr, 255, 0, 0)
				end
			elseif (string == "4") then
				if (objs4[plr] and crates[plr]) then
					destroyElement(objs4[plr])
					objs4[plr] = nil
					exports.NGCdxmsg:createNewDxMessage("You have successfully destroyed your crate!", plr, 0, 255, 0)
				else
					exports.NGCdxmsg:createNewDxMessage("Sorry, your crate does not exist to be destroyed!", plr, 255, 0, 0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You have entered an invalid value to destroy. Syntax: /dcrate [number]", plr, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("dcrate", destroy_objs)

addEventHandler("onPlayerQuit", getRootElement(),
	function()
		if (getElementData(source, "boss") or getElementData(source, "Group") == "Criminal Organization") then
			if isElement(objs1[source]) then
				destroyElement(objs1[source])
			end
			if isElement(objs2[source]) then
				destroyElement(objs2[source])
			end
			if isElement(objs3[source]) then
				destroyElement(objs3[source])
			end
			if isElement(objs4[source]) then
				destroyElement(objs4[source])
			end
		end
	end
)