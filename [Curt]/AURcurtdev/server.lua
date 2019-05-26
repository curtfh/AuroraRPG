--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal & Curt
All Rights Reserved 2017
________________________________________________
]]--
function getPathScript (thePlayer, theCommand, scriptname)
	if (getPlayerName(thePlayer) == "[AUR]Curt" or getPlayerName(thePlayer) == "[AUR]Anubhav") then 
		local name = getResourceFromName(scriptname)
		if (name) then 
			local path = getResourceOrganizationalPath(name)
			outputChatBox(path, thePlayer)
		end 
	end
end 
addCommandHandler("getpath", getPathScript)



--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal
All Rights Reserved 2017
________________________________________________
]]--

local elementsAllowed = {
	["player"] = true, 
	["ped"] = true, 
	["vehicle"] = true, 
	["object"] = true, 
	["pickup"] = true, 
	["marker"] = true,
	['all'] = true,
}

function findResourceName(plr, _, elementType)
	if (elementType and elementsAllowed[elementType]) then
		local x, y, z = getElementPosition(plr)
		local colShape = createColSphere(x, y, z, 25)
		attachElements(plr, colShape)

		if (getElementsWithinColShape(colShape, elementType) and #getElementsWithinColShape(colShape, elementType) > 0) then
			for i, v in ipairs(getElementsWithinColShape(colShape)) do
				if (elementType == "all" or v.type == elementType) then
					local x, y, z = getElementPosition(v)
					local x, y, z = tostring(x), tostring(y), tostring(z)

					if (v.parent.id and v.parent.id ~= "" and v.parent.id.type == "resource") then
						outputChatBox("X, Y, Z: "..x..", "..y..", "..z.." | Resource Name: "..v.parent.id, plr, 255, 255, 0)
					elseif (v.parent.parent.id and v.parent.parent.id ~= "" and v.parent.id.type == "resource") then
						outputChatBox("X, Y, Z: "..x..", "..y..", "..z.." | Resource Name: "..v.parent.parent.id, plr, 255, 255, 0)
					elseif (v.parent.parent.parent.id and v.parent.parent.parent.id ~= "" and v.parent.id.type == "resource") then
						outputChatBox("X, Y, Z: "..x..", "..y..", "..z.." | Resource Name: "..v.parent.parent.parent.id, plr, 255, 255, 0)
					elseif (v.parent.parent.parent.parent.id and v.parent.parent.parent.parent.id ~= "" and v.parent.id.type == "resource") then
						outputChatBox("X, Y, Z: "..x..", "..y..", "..z.." | Resource Name: "..v.parent.parent.parent.parent.id, plr, 255, 255, 0)
					else
						outputChatBox("Couldn't find resource name for: X,Y,Z: "..x..", "..y..", "..z, plr, 255, 255, 0)
					end
				end
			end
		else
			outputChatBox("No such element was found in this colshape!", plr, 255, 255, 0)
		end
	else
		outputChatBox("Invalid element type entered", plr, 255, 255, 0)
	end
end
addCommandHandler("devfrs", findResourceName)