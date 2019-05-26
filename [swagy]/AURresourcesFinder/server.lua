function findResource (plr, cmd, resNameF)

	if not (exports.CSGstaff:isPlayerStaff(plr)) then return false end
	for k,v in ipairs (getResources()) do
		local resName = getResourceName(v)
		if (string.find(resName, resNameF)) then
			outputChatBox(resName.." | "..getResourceOrganizationalPath(v), plr,255,255,0)
		else
			outputChatBox("No resource found with this name!",plr,255,0,0)
			break
		end
	end
end
addCommandHandler("findres", findResource)