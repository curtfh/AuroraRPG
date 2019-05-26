local nameToRankPt = {

	{"Petty Criminal", 0},

	{"Pick Pocket",10},

	{"Con Artist",20},

	{"Burgler",10},

	{"Drug Smuggler",10},

	{"Smooth Talker",10},

	{"Capo",10},

	{"Don of LV",10},

	{"Soldier",10},

	{"Car Jacker",10},

	{"Hood Rat",10},

	{""},

	{""},

}





function changed( name, p )

	if (p) then source = p end

	setElementData( source, "skill", name, true )

	if ( #name == 0 ) then

		name = "Police Officer"

	end

	--outputDebugString(tostring(name))

	exports.NGCdxmsg:createNewDxMessage( source, "You are now a "..name.."!", 0, 255, 0 )

	if name == "Support Unit" then

		takeWeapon( source, 41 )

		giveWeapon( source, 41, 1500 )

	else

		takeWeapon( source, 41 )

	end

	triggerClientEvent( source, "NGClawskills.updateGUI", source )

	exports.DENmysql:exec( "UPDATE playerstats SET `??`=? WHERE userid=?", "lawRank", tostring(name), exports.server:getPlayerAccountID(source) )



end

addEvent( "NGClawskills.changed", true )

addEventHandler( "NGClawskills.changed", root, changed )



addEventHandler("onVehicleDamage",root,function(loss)

	local owner = getElementData(source,"vehicleOwner")

	if owner ~= nil then

		if isElement(owner) == true then

			if getElementData(owner,"skill") == "The Tank" then

				local m=math.floor(loss)/2

				local he=getElementHealth(source,m)-loss

				setElementHealth(source,he+m)

			end

		end

	end

end)



addEvent("onPlayerJobChange",true)

function jobChange(nJob,oldJob)

	if exports.DENlaw:isLaw(source) == false then

		removeElementData(source,"skill")

	else

		local skill = exports.DENstats:getPlayerAccountData(source,"lawRank")

		if (skill) then changed(skill,source) end

	end

end

addEventHandler("onPlayerJobChange",root,jobChange)



addEvent("onServerPlayerLogin",true)

addEventHandler("onServerPlayerLogin",root,function()

	if exports.DENlaw:isLaw(source) then

		local skill = exports.DENstats:getPlayerAccountData(source,"lawRank")

		if (skill) then changed(skill,source) end

	end

end)



addEvent("onPlayerJobChange",true)

function jobChange(nJob,oldJob)

	if exports.DENlaw:isLaw(source) == true then

		set(source)

	end

end

addEventHandler("onPlayerJobChange",root,jobChange)



function set(p)
	local userID = exports.server:getPlayerAccountID(p)
	local data = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?", userID )
	if data then
		local theRank = data.lawRank
		if theRank then
			setElementData( p, "skill", theRank)
			triggerClientEvent(p,"NGClawskills.updateGUI",p)
		end
	end
end

addEventHandler("onPlayerLogin",root,function()
	local userID = exports.server:getPlayerAccountID(source)
	local data = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?", userID )
	if data then
		local theRank = data.lawRank
		if theRank then
			setElementData( source, "skill", theRank)
			triggerClientEvent(source,"NGClawskills.updateGUI",source)
		end
	end
end)

--[[

function setCB(qh,p)

	if isElement(p) then else return end

	local t = dbPoll(qh,0)

	if t == nil then return end

 		local name = tostring(t.lawRank)

		local valid = false

		for k,v in pairs(nameToRankPt) do if v[1] == name then valid = true end end

		if valid == false then

			name = "Regular Officer"

			exports.DENmysql:exec( "UPDATE playerstats SET `??`=? WHERE userid=?", "lawRank", tostring(name), userID)

		end

		setElementData( p, "skill", name, true )

		triggerClientEvent(p,"NGClawskills.updateGUI",p)

end
addEventHandler("onPlayerLogin",root,function() set(source) end)

]]

addEvent( "lawskills.exploKill", true )

addEventHandler( "lawskills.exploKill", root,

	function( atker, wep, body)

		if ( getElementData( source, "isPlayerArrested" ) == false ) and ( getElementHealth(source) > 0 ) and ( getPlayerWantedLevel(source) > 0 ) and ( exports.CSGnewturfing2:isPlayerInRT(source) == false ) then

			killPed( source, atker, wep, body )

		end

	end

)
