




addEvent("onStaffRejectCustomTitle",true)
addEventHandler("onStaffRejectCustomTitle",root,function(acc,tit)
	local dbData = exports.DENmysql:querySingle("SELECT * FROM titles WHERE account=? AND title=?",acc,tit)
	if dbData then
		--local isDone = false
		--for k,v in ipairs(getElementsByType("player")) do
			--if exports.server:getPlayerAccountName(v) == acc then
				--isDone = true
			--end
		--end
		--if isDone == true then
			--exports.AURpayments:addMoney(v,10000000,"Custom","Misc",0,"AURtitles")
		--else
		local dbData = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE username=?",acc)
		if dbData then
			local balanceCheck = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", dbData.userid )
			local totalNewBalance = (balanceCheck.balance + 10000000)
			if exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", totalNewBalance,dbData.userid) then
				exports.DENmysql:exec("DELETE FROM titles WHERE account=? AND title=?",acc,tit)
				exports.NGCdxmsg:createNewDxMessage(source,"You have rejected "..tit.." title for "..acc,0,255,0)
				triggerEvent("onStaffLoadTitles",source)
			end
		end
	end
end)

addEvent("onStaffApproveCustomTitle",true)
addEventHandler("onStaffApproveCustomTitle",root,function(acc,tit)
	local dbData = exports.DENmysql:querySingle("SELECT * FROM titles WHERE account=? AND title=?",acc,tit)
	if dbData then
		exports.DENmysql:exec("UPDATE titles SET active=? WHERE account=? AND title=?",1,acc,tit)
		exports.NGCdxmsg:createNewDxMessage(source,"You have approved "..tit.." title for "..acc,0,255,0)
		triggerEvent("onStaffLoadTitles",source)
	end
end)

addEvent("onStaffLoadTitles",true)
addEventHandler("onStaffLoadTitles",root,function()
	local dbData = exports.DENmysql:query("SELECT * FROM titles WHERE active=?",0)
	if dbData then
		triggerClientEvent(source,"addStaffTitles",source,dbData)
	end
end)


addEvent("onPlayerLoadTitles",true)
addEventHandler("onPlayerLoadTitles",root,function()
	local accountName = exports.server:getPlayerAccountName(source)
	local dbData = exports.DENmysql:query("SELECT * FROM titles WHERE account=? AND active=?",accountName,1)
	if dbData then
		triggerClientEvent(source,"addPlayerTitles",source,dbData)
	end
end)



local latestSpawn = {}
addEvent("onPlayerRequestTitle",true)
addEventHandler("onPlayerRequestTitle",root,function(titleName,r,g,b)
	if ( latestSpawn[getPlayerSerial(source)] ) and ( getTickCount()-latestSpawn[getPlayerSerial(source)] < 300000 ) then
		exports.NGCdxmsg:createNewDxMessage(source,"You can request title once each 5 minutes",255,0,0)
		return false
	end
	if titleName then
		if getPlayerMoney(source) >= 10000000 then
			local accountName = exports.server:getPlayerAccountName(source)
			local dbData = exports.DENmysql:querySingle("SELECT * FROM titles WHERE title=? AND account=?",titleName,accountName)
			if dbData then
				exports.NGCdxmsg:createNewDxMessage(source,"You already requested for this title, please wait admin to accept it",255,0,0)
				return false
			else
				latestSpawn[getPlayerSerial(source)] = getTickCount()
				exports.AURpayments:takeMoney(source,10000000,"AURtitles")
				exports.DENmysql:exec("INSERT INTO titles SET title=?,account=?,active=?,red=?,green=?,blue=?",titleName,accountName,0,r,g,b)
				exports.NGCdxmsg:createNewDxMessage(source,"You have successfuly requested new title, wait for admin to accept it",0,255,0)
				for k,v in ipairs(getElementsByType("player")) do
					if exports.CSGstaff:isPlayerStaff(v) then
						exports.killmessages:outputMessage("New title request by "..getPlayerName(source).." dp /fucknoiwonttell",v,255,150,0)
					end
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(source,"You don't have enough money to buy title",255,0,0)
		end
	end
end)
