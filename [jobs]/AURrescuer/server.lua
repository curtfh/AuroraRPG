--giveRescuerScore
addEvent("giveRescuerScore", true)
function score( ammount)
	exports.CSGscore:givePlayerScore(source, ammount)
end
addEventHandler("giveRescuerScore", getRootElement(), score)

addEvent("giveRescuerMoney", true)
function money( ammount)
	---givePlayerMoney(source, ammount)
	exports.CSGranks:addStat(source,1)
	exports.AURpayments:addMoney(source,ammount,"Custom","Rescuer Man",0,"AURrescuer")
end
addEventHandler("giveRescuerMoney", getRootElement(), money)

--get points
function getRank(thePlayer)
	local occc = exports.server:getPlayerOccupation(thePlayer)
	if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
	local pass = exports.denstats:getPlayerAccountData(thePlayer,"rescuerMan")
		setElementData(thePlayer, "rescuer", tostring(pass), true)
	end
end
addEventHandler("onVehicleEnter", getRootElement(), getRank)

addEventHandler("onPlayerLogin", root,
  function()
    local pass = exports.denstats:getPlayerAccountData(source,"rescuerMan")
		setElementData(source, "rescuer", tostring(pass), true)
	end
)

function triggerVoice(str,diff)
	local str2 = ""
	if diff == true then
	str2 = "http://translate.google.com/translate_tts?tl=en&q="..str..""
	else
	str2 = "http://translate.google.com/translate_tts?tl=en&q=Nex Stop: "..str..""
	end
	local veh = getPedOccupiedVehicle(source)
	for k,v in pairs(getVehicleOccupants(veh)) do
		triggerClientEvent(v,"rescuerManVoiceClient",v,str2)
	end
end
addEvent("rescuerManVoice",true)
addEventHandler("rescuerManVoice",root,triggerVoice)

