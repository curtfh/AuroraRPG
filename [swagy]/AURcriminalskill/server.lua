local nameToRankPt = {
	{"Petty Criminal", 0},
	--{"Pick Pocket",10},
	--{"Con Artist",20},
	--{"Burglar",10},
	--{"Drug Smuggler",10},
	{"Smooth Talker",10},
	{"Capo",10},
	{"Don of LV",10},
	{"Assassin",10},
}


function changed(name)
	if name == nil then set(source) return end
	setElementData( source, "Rank", name, true )
	exports.NGCdxmsg:createNewDxMessage(source,"You are now a "..name.."!",255,0,0)
	triggerClientEvent(source,"CSGcriminalskills.updateGUI",source)
	exports.DENmysql:exec( "UPDATE playerstats SET `??`=? WHERE userid=?", "criminalRank", tostring(name), exports.server:getPlayerAccountID(source) )
end
addEvent("CSGcriminalskills.changed",true)
addEventHandler("CSGcriminalskills.changed",root,changed)

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if nJob == "Criminal" then
		set(source)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function set(p)
	local userID = exports.server:getPlayerAccountID(p)
	local data = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?", userID )
	if data then
		local theRank = data.criminalRank
		if theRank then
			setElementData( p, "Rank", theRank)
			triggerClientEvent(p,"CSGcriminalskills.updateGUI",p)
		end
	end
end
addEventHandler("onPlayerLogin",root,function()
	local userID = exports.server:getPlayerAccountID(source)
	local data = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?", userID )
	if data then
		local theRank = data.criminalRank
		if theRank then
			setElementData( source, "Rank", theRank)
			triggerClientEvent(source,"CSGcriminalskills.updateGUI",source)
		end
	end
end)


--[[
function setCB(qh,p)
	if isElement(p) then else return end
	local t = dbPoll(qh,0)
	if t == nil then return end
	if #t > 0 then t = t[1] else return end
		local name = tostring(t.criminalRank)
		local valid = false
		for k,v in pairs(nameToRankPt) do if string.lower(v[1]) == string.lower(name) then valid = true end end
		if valid == false then
			name = "Petty Criminal"
			exports.DENmysql:exec( "UPDATE playerstats SET `??`=? WHERE userid=?", "criminalRank", tostring(name), userID)
		end
		setElementData( p, "Rank", name, true )
		triggerClientEvent(p,"CSGcriminalskills.updateGUI",p)
end
addEventHandler("onPlayerLogin",root,function() set(source) end)]]


function onPlayerDamage (attacker, wep, bodypart, loss)

	if (isElement(attacker)) and (getElementType(attacker) == "player") then
		if (getTeamName(getPlayerTeam(source)) ~= "Staff") then
			local rank = getElementData(attacker, "Rank")
			local x,y,z = getElementPosition(source)
			local mx,my,mz = getElementPosition(attacker)
			if (rank == "Assassin") and (wep == 34) and (bodypart == 9) and (getDistanceBetweenPoints3D(x,y,z,mx,my,mz) >= 130) then
				if (getPedArmor(source) >= 50) then
					setPedArmor(source, 0)
					setElementHealth(source, getElementHealth(source) - 50)
				else
					setPedArmor(source, 0)
					setElementHealth(source, getElementHealth(source) - 100)
				end
			end
		end
	end
end
addEventHandler("onPlayerDamage", root, onPlayerDamage)