
pedsTable = {
	{1631.33,1840.87,10.6,175}, --- LV hos


}

c = dbConnect("sqlite", "accounts.db")
dbExec(c, "CREATE TABLE IF NOT EXISTS agents(accName TEXT)")

local accounts = {}

--Curt Stuff
function refreshTables ()
	local res = dbPoll(dbQuery(c, "SELECT * FROM agents"), -1)
	for k, v in ipairs(res) do
		accounts[v.accName] = true
	end
end 

function onStartRs()
	refreshTables()
end 
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onStartRs)

--[[function onStopRs()
	local file1 = fileOpen("accounts.json")
	fileWrite(file1, toJSON(accounts))
	fileClose(file1)
end 
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), onStopRs)]]

function refreshDTable (player, cmd)
	if (getTeamName(getPlayerTeam(player)) ~= "Staff") then return end
	refreshTables()
	outputChatBox("Donator Skin Table Refreshed", player, 255, 255, 255)
	
end 
addCommandHandler("refreshskintable", refreshDTable)

function addAccount (account)
	dbExec(c, "INSERT INTO agents (accName) VALUES(?)", account)
	accounts[account] = true
	return true
end 

function delAccount (account)
	if (accounts[account]) then
		dbExec(c, "DELETE FROM agents WHERE accName=?", account)
		accounts[account] = nil
		return true
	end
end 
--end of Curt Stuff 

function createAgent()
	for k,v in ipairs(pedsTable) do
		local marker = createMarker(v[1],v[2],v[3],"cylinder",2,250,0,100,0)
		local thePed2 = createPed ( 124, v[1],v[2],v[3] )
		setElementData(thePed2,"jobPed",true)
		setElementData(thePed2,"jobName","The Winter Soldier\nAvailable for donors")
		setElementData(thePed2,"jobColor",{0, 200, 200})
		setElementFrozen ( thePed2, true )
		setPedRotation ( thePed2, v[4] )
		attachElements(marker,thePed2)
		setElementData( thePed2, "showModelPed", true )
	end
end
createAgent()


local playerSkin = {}
local TWSmode = {}
local timer = {
	one = {},
	two = {},
}

function purchase_TWS(plr)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (exports.server:isPlayerLoggedIn(plr)) then
			local nam = exports.server:getPlayerAccountName(plr)
			if accounts[nam] ~= nil then
				if (isPedOnGround(plr)) then
					local accid = exports.server:getPlayerAccountID(plr)
					if (not TWSmode[accid]) then
						if (isTimer(timer.one[accid])) then return end
						if (isTimer(timer.two[accid])) then
							exports.NGCdxmsg:createNewDxMessage("You can use TWS mode once each 30 minutes", plr, 255, 0, 0)
							return
						end
						TWS_mode(plr, "true")
						exports.NGCnote:addNote("TWSmode Bought", "You have used TWS mode you will be armored", plr, 0, 255, 0)
						timer.one[accid] = setTimer(
							function(plrs)
								if plrs and isElement(plrs) then
									TWS_mode(plrs, "false")
								end
							end
						,60000*10,1,plr)
						timer.two[accid] = setTimer(function(plrs) if plrs and isElement(plrs) then TWS_mode(plr, "false") end end, 60000*30, 1,plr)
					else
						setElementModel(plr,124)
						exports.NGCdxmsg:createNewDxMessage("You've already used TWS mode please wait!", plr, 255, 0, 0)
						return
					end
				end
			end
		end
	end
end
addCommandHandler("tws", purchase_TWS)

function TWS_mode(plr, string)
	if (plr and string) then
		local accid = exports.server:getPlayerAccountID(plr)
		if (string == "false") then
			if (TWSmode[accid]) or getElementModel(plr) == 124 then
				TWSmode[accid] = nil
				exports.NGCdxmsg:createNewDxMessage("Your TWS mode has worn off!", plr, 255, 0, 0)
				if playerSkin[accid] ~= nil then
					setElementModel(plr,playerSkin[accid])
				else
					setElementModel(plr,0)
				end
				triggerClientEvent(plr,"activeShield",plr,false)
				setElementData(plr, "tws_enabled", false)
				if (isTimer(timer.one[accid]))then killTimer(timer.one[accid]) end
			end
		elseif (string == "true") then
			if (not TWSmode[accid]) then
				TWSmode[accid] = true
				playerSkin[accid] = getElementModel(plr)
				setElementModel(plr,124)
				setPedArmor(plr,100)
				triggerClientEvent(plr,"activeShield",plr,true)
				setElementData(plr, "tws_enabled", true)
			end
		end
	end
end

function isPlayerInTWSMode(plr)
	if (plr and isElement(plr)) then
		local accid = exports.server:getPlayerAccountID(plr)
		if (TWSmode[accid]) then
			return true
		else
			return false
		end
	end
end

addEventHandler("onResourceStop",resourceRoot,function()
	for k,v in pairs(getElementsByType("player")) do
		if isPlayerInTWSMode(v) or getElementModel(v) == 124 then
			local accid = exports.server:getPlayerAccountID(v)
			if playerSkin[accid] ~= nil then
				setElementModel(v,playerSkin[accid])
			else
				setElementModel(v,0)
			end
		end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if isPlayerInTWSMode(source) then
		TWS_mode(source, "false")
	end
end)

addEventHandler("onPlayerSpawn",root,function()
	if isPlayerInTWSMode(source) then
		TWS_mode(source, "true")
	end
end)

function informPlayerOnModelChange(oldModel)
    if ( getElementType(source) == "player" ) then -- Make sure the element is a player
        if getElementModel(source) == 124 then
			if isPlayerInTWSMode(source) == false then
				setElementModel(source,oldModel)
			end
		end
    end
end
addEventHandler("onElementModelChange", root, informPlayerOnModelChange)

addEvent("AgentArmorSet",true)
addEventHandler("AgentArmorSet",root,function(va,tm,attacker, weapon)
	local arm = math.floor(getPedArmor(source))
	if arm > 6 then
		if getElementDimension(source) == 0 then
			setPedArmor(source,arm-va)
		else
			setPedArmor(source,arm-10)
		end
	elseif arm >= 1 and arm <= 6 then
		setPedArmor(source,0)
	else
		local hp = getElementHealth(source)
		if tm == 1 then
			if getElementDimension(source) == 0 then
				if (hp - 8 < 1) then
					killPed(source, attacker, weapon)
					return false
				end
				setElementHealth(source,getElementHealth(source)-8)
			else
				if (hp - 15 < 1) then
					killPed(source, attacker, weapon)
					return false
				end
				setElementHealth(source,getElementHealth(source)-15)
			end
		else
			if getElementDimension(source) == 0 then
				if (hp - 4 < 1) then
					killPed(source, attacker, weapon)
					return false
				end
				setElementHealth(source,getElementHealth(source)-4)
			else
				if (hp - 15 < 1) then
					killPed(source, attacker, weapon)
					return false
				end
				setElementHealth(source,getElementHealth(source)-15)
			end
		end
	end
end)

-- all cops get buggy can't use tazer (need fix)
--function deleteWhenLeftJob (pr,currentWeaponID)
	--if getPlayerTeam(source) then
		--if getPedWeapon(source) == 23 or currentWeaponID == 23 then
			--setPedWeaponSlot(source,3)
		--end
	--end
--end
--addEventHandler( "onPlayerWeaponSwitch", root, deleteWhenLeftJob )
