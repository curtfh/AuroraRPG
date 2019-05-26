local backupSpam = {}


addEvent( "onPlayerPayfine", true )
addEventHandler( "onPlayerPayfine", root,
function ( theMoney )
	exports.AURpayments:takeMoney( source, theMoney,"DENpolice fine" )
	exports.server:setPlayerWantedPoints( source, 0 )
	exports.NGCdxmsg:createNewDxMessage(source,"You have paid $"..exports.server:convertNumber(theMoney).." fine bill!")
end
)

addEventHandler("onPlayerQuit",root,function()
	for k,v in pairs(getElementsByType("player")) do
		if exports.DENlaw:isLaw(v) == true then
			triggerClientEvent(v,"policeUnblip",v,source)
		end
	end
end)

addEvent("returnGovernmentData",true)
addEventHandler("returnGovernmentData",root,function()
	local arrests = exports.DENstats:getPlayerAccountData(source,"arrests")
	local arrestpoints = exports.DENstats:getPlayerAccountData(source,"arrestpoints")
	local tazerassists = exports.DENstats:getPlayerAccountData(source,"tazerassists")
	local rt = exports.DENstats:getPlayerAccountData(source,"radioTurfsTakenAsCop")
	local at = exports.DENstats:getPlayerAccountData(source,"armoredtrucks")
	triggerClientEvent(source,"callBackGovernment",source,tazerassists,arrests,arrestpoints,rt,at)
end)

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function()
	for k,v in pairs(getElementsByType("player")) do
			triggerClientEvent(v,"policeUnblip",v,source)
	end
end)

function payForJail(plr)
	local wantedPoints = getElementData ( plr, "wantedPoints" )
	local jailTime = getElementData( plr, "jailTimeRemaining" )
	local money = jailTime*100
	if getElementData(plr,"isPlayerArrested") then
	exports.NGCdxmsg:createNewDxMessage("You can not use this function while arrested",plr,255,0,0)
	return false
	elseif getElementData(plr,"isPlayerAdminJailed") or exports.server:getPlayerWantedPoints(plr) < 10 then
	exports.NGCdxmsg:createNewDxMessage("You can not avoid an admin jail",plr,255,0,0)
	return false
	elseif getElementData(plr,"isPlayerJailed") then
	if getPlayerMoney(plr) < money then exports.NGCdxmsg:createNewDxMessage("You can not pay this fund right now!",plr,255,0,0) return end
	exports.AURpayments:takeMoney(plr, money,"DENpolice jailfine")
	exports.CSGadmin:removePlayerJailed( plr )
	exports.NGCdxmsg:createNewDxMessage("You've paied fine and got released from the jail",plr,0,255,0)
	setElementData(plr,"isPlayerAdminJailed",false)
	end
end
addCommandHandler("payjailfine",payForJail)
