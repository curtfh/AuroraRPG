function startDatabase()
	if (not getResourceFromName("DENmysql")) or (getResourceState(getResourceFromName("DENmysql")) == "loaded") or (db == false) then
		cancelEvent()
		outputChatBox(""..getResourceName(getThisResource()).." failed to start due to some MySQL resource failure.", root, 255, 0, 0)
	else
		exports.DENmysql:exec("CREATE TABLE IF NOT EXISTS groupmanagers_blacklist (id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, blacklistedElement TEXT, type INT)")
	end
end
addEventHandler("onResourceStart", resourceRoot, startDatabase)

function openGMPanel(thePlayer)
	if (exports.CSGstaff:isPlayerStaff(thePlayer)) and (exports.CSGstaff:getPlayerAdminLevel(thePlayer) >= 3) then
		local res = exports.DENmysql:query("SELECT * FROM groupmanagers_blacklist")
		triggerClientEvent(thePlayer, "AURgm.openGMPanel", thePlayer, res)
	end
end
addCommandHandler("gm", openGMPanel)

function addBlacklist(plr, blacklistedElement, type)
	exports.DENmysql:exec("INSERT INTO groupmanagers_blacklist (blacklistedElement, type) VALUES(?,?)", blacklistedElement, type)
end
addEvent("AURgm.addBlacklist", true)
addEventHandler("AURgm.addBlacklist", root, addBlacklist)

function removeBlacklist(plr, blacklistedElement, type)
	exports.DENmysql:exec("DELETE FROM groupmanagers_blacklist WHERE blacklistedElement=? AND type=?", blacklistedElement, type)
end
addEvent("AURgm.removeBlacklist", true)
addEventHandler("AURgm.removeBlacklist", root, removeBlacklist)

addEvent("findThrowGroups",true)
addEventHandler("findThrowGroups",root,function(gn)
	if gn then
		local datatable = exports.DENmysql:query("SELECT * FROM groupmanager WHERE groupname=?",gn)
		if datatable then
			exports.NGCdxmsg:createNewDxMessage(source,"Please wait we are sending logs...",255,0,0)
			triggerClientEvent(source,"callClientgroupInviteLogs",source,datatable,gn)
		else
			exports.NGCdxmsg:createNewDxMessage(source,"Group with this name not found please try again",255,0,0)
		end
	end
end)

antispam = {}

addCommandHandler( "gmlog",
	function ( thePlayer )
		local theAccount = exports.server:getPlayerAccountName ( thePlayer )
		if ( theAccount ) then
			if exports.CSGstaff:isPlayerStaff(thePlayer) and exports.CSGstaff:getPlayerAdminLevel(thePlayer) >= 3 then
				--if isTimer(antispam[thePlayer]) then exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can open invite logs once every 1 minute",255,0,0) return false end
				--antispam[thePlayer] = setTimer(function() end,60000,1)
				triggerClientEvent( thePlayer, "openGMPanel", thePlayer )
			end
		end
	end
)