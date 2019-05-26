local scoreCD = {}

function getPedMaxHealth(ped)
    -- Output an error and stop executing the function if the argument is not valid
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")

    -- Grab his player health stat.
    local stat = getPedStat(ped, 24)

    -- Do a linear interpolation to get how many health a ped can have.
    -- Assumes: 100 health = 569 stat, 200 health = 1000 stat.
    local maxhealth = 100 + (stat - 569) / 4.31

    -- Return the max health. Make sure it can't be below 1
    return math.max(1, maxhealth)
end

addEventHandler("onPlayerQuit",root,function() scoreCD[source]=nil end)

function healedPlayer ( money, healedplayer, healVal )
	local x, y, z = getElementPosition(source)
	local x2, y2, z2 = getElementPosition(healedplayer)
	local health = getElementHealth(healedplayer)
	if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 5 then
		if getPedWeapon ( source ) == 41 then
			if ( money ) then
				if getPlayerMoney(healedplayer) > money then
				local stat = getPedStat(healedplayer, 24)
				local maxhealth = 100 + (stat - 569) / 4.31
				if getElementHealth(healedplayer) == math.max(1, maxhealth) then
				exports.NGCdxmsg:createNewDxMessage(source,"This player doesn't need more Health",255,0,0)
				return false end
					setElementHealth ( healedplayer, health + healVal )
					triggerClientEvent(source,"CSGmedicAddStat",source,"Healed Health",healVal)
					triggerClientEvent(source,"CSGmedicAddStat",source,"Money earned from healing",money)

				----	givePlayerMoney ( healedplayer, money*-1 )
					--givePlayerMoney ( source, money )
					exports.AURpayments:takeMoney(healedplayer,money,"AURmedic")
					exports.AURpayments:addMoney(source,money,"Custom","Paramedics",0,"AURmedic")
					if scoreCD[source] == nil then scoreCD[source]={} end
					if scoreCD[source][healedplayer] == nil then scoreCD[source][healedplayer] = 0 end
						if scoreCD[source][healedplayer] > 1 then
							exports.CSGscore:givePlayerScore(attacker,0.1)
						elseif scoreCD[source][healedplayer] == 1 then
							setTimer(function() if isElement(source) then scoreCD[source][healedplayer]=0 end end,180000,1)
							scoreCD[source][healedplayer]=1.1
						else
							triggerClientEvent(source,"CSGmedicAddStat",source,"Unique person heals",1)
							exports.CSGscore:givePlayerScore(source,0.1)
							scoreCD[source][healedplayer]=scoreCD[source][healedplayer]+0.1
							exports.CSGtopjobs:didWork(source,"paramedic",0.1)
							triggerClientEvent(source,"CSGmedicAddStat",source,"Score earned from healing",0.1)
							local data = exports.Denstats:getPlayerAccountData(source,"paramedic2")

							if data == nil or data == false then
								data = {}
							else
								data = fromJSON(data)
							end
							if type(data) ~= "table" then
								data = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0}
								for i=1,10 do data[i]=0 end
							end
							if data["healscore"] == nil then data["healscore"] = 0 end
							data["healscore"] = data["healscore"] + 0.1
							data = toJSON(data)
							exports.Denstats:setPlayerAccountData(source,"paramedic2",data)--]]

						end
				else
					exports.NGCdxmsg:createNewDxMessage ( source, "The player you want heal doesn't have enough money!", 225,0,0)
					triggerClientEvent(source,"CSGmedicAddStat",source,"Poor person healing incidents",1)
				end
			else
				setElementHealth ( healedplayer, health + healVal )
				triggerClientEvent(source,"CSGmedicAddStat",source,"Healed Health",healVal)
				exports.NGCdxmsg:createNewDxMessage( source, "No money for you! You attacked the patient before healing.", 225,0,0)
			end
		end
	end
end
addEvent ( "healedPlayer", true )
addEventHandler ( "healedPlayer", root, healedPlayer )

addEventHandler("onPlayerWasted",root,function()
	if getTeamName(getPlayerTeam(source)) == "Paramedics" then
		triggerClientEvent(source,"CSGmedicAddStat",source,"Death on Job",1)
	end
end)

addEventHandler ( "onVehicleEnter", root,
function ( thePlayer, seat, jacked )
	local theMedic = getVehicleController ( source )
	if ( theMedic ) then
		if ( getTeamName ( getPlayerTeam ( theMedic ) ) == "Paramedics" ) then
			if (getElementModel(source) == 416) then 
				local getPlayerHealth = getElementHealth (thePlayer)
				local theHealthFormule = ( 100 / getPlayerHealth )
				local healPrice = ( theHealthFormule * 250  )
				if ( getPlayerMoney( thePlayer ) < healPrice ) then
					exports.NGCdxmsg:createNewDxMessage ( thePlayer, "You don't have enough money for a heal!", 225,0,0)
				else
					if ( math.floor(getPlayerHealth) < 100 ) then
						--givePlayerMoney (theMedic, math.floor(healPrice))
						---takePlayerMoney (thePlayer, math.floor(healPrice))
						exports.AURpayments:takeMoney(thePlayer,math.floor(healPrice),"AURmedic")
						exports.AURpayments:addMoney(theMedic,math.floor(healPrice),"Custom","Paramedics",0,"AURmedic")
						setElementHealth (thePlayer, 100)
					end
				end
			end
		end
	end
end
)

function takeJob (team, occupation)

	if (team == "Paramedics") and (occupation == "Paramedic") then
		triggerClientEvent(source, "AURmedic.startMission", source)
	end
end
addEventHandler("onSetPlayerJob", root, takeJob)

function startShift (occupation)

	if (occupation == "Paramedic") then
		triggerClientEvent(source, "AURmedic.startMission", source)
	end
end
addEventHandler("onStartShift", root, startShift)


function quitJob (oldJob)

	triggerClientEvent(source, "AURmedic.stopMission", source)

end
addEventHandler("onQuitJob", root, quitJob)

function endShift ()

	triggerClientEvent(source, "AURmedic.stopMission", source)

end
addEventHandler("onEndShift", root, endShift)


function medicMissionPayment (player)

	local randomAmount = math.random (1, 2)
	local randomPayment = math.random(1500,4000)
	exports.AURcrafting:addPlayerItem(player, "Alcool", randomAmount)
	exports.NGCdxmsg:createNewDxMessage("You have healed this player and earned "..tostring(randomAmount).."L of Alcool!",player,255,255,0)
	exports.NGCdxmsg:createNewDxMessage("You have healed the injured person and earned $"..tostring(randomPayment).."!",player,255,255,0)
	givePlayerMoney(player, randomPayment)

end
addEvent("AURmedic.pay", true)
addEventHandler("AURmedic.pay", root, medicMissionPayment)



addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	local p = source
	triggerClientEvent(p,"CSGmedicRecData",p,nil)
end)

addEvent("CSGmedic.setDefault",true)
addEventHandler("CSGmedic.setDefault",root,function()
		local t = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0}
		for i=1,10 do t[i]=0 end
		exports.DENstats:setPlayerAccountData(source,"paramedic2",toJSON(t),true)
end)

setTimer(function()
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			triggerClientEvent(v,"CSGmedicRecData",v,nil)
		end
	end
end,5000,1)

 local nameToI = {
	["Healed Health"] = 1,
	["Score earned from healing"] = "healedscore",
	["Death on Job"] = 3,
	["Unique person heals"] = 4,
	["Poor person healing incidents"] = 5,
	["Money earned from healing"] = 6,
	["Money earned from daily pay"] = 7,
}

function CSGmedicSetStat(stat,value,p,bool,_,rankPTS)

	exports.DENstats:setPlayerAccountData(source,"paramedic2",stat)
end
addEvent("CSGmedicSetStat",true)
addEventHandler("CSGmedicSetStat",root,CSGmedicSetStat)
