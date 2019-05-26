local taxpercent = 1
setElementData(root, "AURtax.tax", taxpercent)
function getCurrentTax ()
	setElementData(root, "AURtax.tax", taxpercent)
	return taxpercent
end 

function setTaxRating (plr, cmd, newtax)	
	if (getTeamName(getPlayerTeam(plr)) == "Staff") then 
		setElementData(root, "AURtax.tax", math.abs(newtax))
		taxpercent = math.abs(newtax)
		outputChatBox("AuroraRPG: The tax percentage has been set to "..math.abs(newtax).."%. This affects the entire transaction.", root, 255, 255, 255)
	end
end 
addCommandHandler("staffsettax", setTaxRating)
