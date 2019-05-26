function bringDonorAnnouncement(plr, amount, de)
	triggerClientEvent(root, "AURanndonor.drawDonorDx", root, plr, tostring(amount), de)
	--local _, speech, URL = convertTextToSpeech(de, getPlayerFromName("[AUR]Curt"), "en")
end

function doTestDonation (plr) 
	if (getTeamName(getPlayerTeam(plr)) == "Staff") then 
		bringDonorAnnouncement(getPlayerName(plr), 30, "This is a test donation for dollar.")
	end 
end 
addCommandHandler("dotestdonation", doTestDonation)

function skipdonatestaff (plr) 
	if (getTeamName(getPlayerTeam(plr)) == "Staff") then 
		triggerClientEvent(root, "AURanndonor.skipDonation", root, true)
	end 
end 
addCommandHandler("skipdonatestaff", skipdonatestaff)

function demospeech (plr) 
	triggerClientEvent(plr, "AURanndonor.drawDonorDx", plr, "AuroraRPG", tostring(1), "This is a test donation for dollar and this is a demo speech for announce speech item at aurorarpg dot com slash v i p.")
end 
addCommandHandler("demospeech", demospeech)