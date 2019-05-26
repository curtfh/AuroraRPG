
-- Check if a player is a law player
local lawTeams = {
	"Government",
	"Military Forces",
}
local antiGot = {}
local gMoneyTime = 0
local RadarAreasTurf = {}
local RadarAreaColTurf = {}

local AreaPosition = {
	{aPosX = 2174.421875, aPosY = -1295.3916015625, aSizeX = 80, aSizeY = 70},
	{aPosX = 2174.421875, aPosY = -1295.3916015625, aSizeX = 80, aSizeY = 70},
	{aPosX = 2173.9609375, aPosY = -1378.2900390625, aSizeX = 80, aSizeY = 70},
	{aPosX = 2078.109375, aPosY = -1294.4248046875, aSizeX = 80, aSizeY = 70},
	{aPosX = 2077.3232421875, aPosY = -1377.8662109375, aSizeX = 80, aSizeY = 70},
	{aPosX = 2219.2548828125, aPosY = -1476.8798828125, aSizeX = 80, aSizeY = 70},
	{aPosX = 2311.26171875, aPosY = -1377.5478515625, aSizeX = 80, aSizeY = 70},
	{aPosX = 2435.5068359375, aPosY = -1729.0986328125, aSizeX = 100, aSizeY = 90},
	{aPosX = 2347.30859375, aPosY = -1734.15234375, aSizeX = 80, aSizeY = 70},
	{aPosX = 2209.3193359375, aPosY = -1741.8974609375, aSizeX = 80, aSizeY = 70},
	{aPosX = 1998.0556640625, aPosY = -1681.7880859375, aSizeX = 80, aSizeY = 70},
	{aPosX = 2001.9541015625, aPosY = -1766.7431640625, aSizeX = 80, aSizeY = 70},
	{aPosX = 1833.6494140625, aPosY = -2166.3916015625, aSizeX = 120, aSizeY = 90},
	{aPosX = 2721.1015625, aPosY = -2047.16015625, aSizeX = 100, aSizeY = 120},
	{aPosX = 2600.7861328125, aPosY = -2046.115234375, aSizeX = 100, aSizeY = 120},
	{aPosX = 2421.412109375, aPosY = -1925.0380859375, aSizeX = 90, aSizeY = 90},
	{aPosX = 2737.947265625, aPosY = -1485.9453125, aSizeX = 140, aSizeY = 100},
	{aPosX = 2742.0703125, aPosY = -1648.9052734375, aSizeX = 90, aSizeY = 140},
	{aPosX = 2568.546875, aPosY = -1257.4306640625, aSizeX = 140, aSizeY = 60},
	{aPosX = 1965.376953125, aPosY = -2108.6845703125, aSizeX = 140, aSizeY = 100},
	{aPosX = 1687.2158203125, aPosY = -1873.1796875, aSizeX = 140, aSizeY = 100},

}

--[[



ttt={}
addCommandHandler("draw",function(p,cmd,w,h)
	local x,y,z = getElementPosition(p)
	dis = createRadarArea(x,y,w,h,255,0,0,255)
	exports.NGCdxmsg:createNewDxMessage("aPosX = "..x..", aPosY = "..y..", aSizeX = "..w..", aSizeY = "..h)
end)

addCommandHandler("del",function()
	if isElement(dis) then destroyElement(dis) end
end)
]]

function getDataProgress1 (turfcol)
	local turfnum = getElementData(turfcol, "number")
	local sqlData = executeSQLQuery("SELECT * FROM turfssys WHERE Turf=?", turfnum)
	local LAll = sqlData[1].Team1Progress
	return LAll
end

function setTurfProgress1 (turfcol, num)
	local turfnum = getElementData(turfcol, "number")
	executeSQLQuery("UPDATE turfssys SET Team1Progress=? WHERE Turf=?", num, turfnum )
	if num == 100 then
		setTurfProgress2(turfcol,0)
	end
end

function getDataTeam1 (turfcol)
	local turfnum = getElementData(turfcol, "number")
	local sqlData = executeSQLQuery("SELECT * FROM turfssys WHERE Turf=?", turfnum)
	local gAll = sqlData[1].Team1
	return gAll
end

function setTurfTeam1 (turfcol, Team)
	local turfnum = getElementData(turfcol, "number")
	executeSQLQuery("UPDATE turfssys SET Team1=? WHERE Turf=?", Team, turfnum )
end

function getDataProgress2 (turfcol)
	local turfnum = getElementData(turfcol, "number")
	local sqlData = executeSQLQuery("SELECT * FROM turfssys WHERE Turf=?", turfnum)
	local oAll = sqlData[1].Team2Progress
	return oAll
end

function setTurfProgress2 (turfcol, num)
	local turfnum = getElementData(turfcol, "number")
	executeSQLQuery("UPDATE turfssys SET Team2Progress=? WHERE Turf=?", num, turfnum )
end

function getDataTeam2 (turfcol)
	local turfnum = getElementData(turfcol, "number")
	local sqlData = executeSQLQuery("SELECT * FROM turfssys WHERE Turf=?", turfnum)
	local GAll = sqlData[1].Team2
	return GAll
end

function setTurfTeam2 (turfcol, Team)
	local turfnum = getElementData(turfcol, "number")
	executeSQLQuery("UPDATE turfssys SET Team2=? WHERE Turf=?", Team, turfnum )
end

function getTeamsTurf(L)
    local Table = {}
    local sTable = {}
    for Col, Area in pairs(RadarAreaColTurf) do
        if getDataProgress1 (Area) >= L then
            if L >= 96 then
                table.insert(Table, {getDataTeam1(Area)})
            end
        elseif getDataProgress2 (Area) >= L then
            if L >= 96 then
                table.insert(Table, {getDataTeam2(Area)})
            end
        end
    end
    local tTable = {}
    for i, M in pairs(Table) do
        if not tTable[M[1]] then
            tTable[M[1]] = 1
        else
        tTable[M[1]] = tTable[M[1]] + 1
        end
    end
    return {tTable, sTable}
end

function getTeamOnlineMember(Team)
    local Table = {}
    for i, player in ipairs(getElementsByType("player")) do
        if Team == "LAW" then
			if isLaw(player) == true then
				table.insert(Table, player)
			end
		elseif Team == "Criminals" then
			if getPlayerTeam(player)then
				if getTeamName(getPlayerTeam(player)) == "Criminals" then
					table.insert(Table, player)
				end
			end
        end
    end
    return Table
end


addEventHandler("onResourceStart", resourceRoot,function()
	setTimer(function()
		for Col, Area in pairs(RadarAreaColTurf) do
			local Progress11 = getDataProgress1(Area)
			local Progress21 = getDataProgress2(Area)
			local g11 = getDataTeam1 (Area)
			local g21 = getDataTeam2 (Area)
			if g11 == "LAW" then
				r1,g1,b1 = 0,100,200
			elseif g11 == "Criminals" then
				r1,g1,b1 = 255,0,0
			end
			if g21 == "LAW" then
				r2,g2,b2 = 0,100,200
			elseif g21 == "Criminals" then
				r2,g2,b2 = 255,0,0
			end
			if Progress11 > Progress21 then
				setRadarAreaColor(Area, r1, g1, b1, 175)
			end
			if Progress11 < Progress21 then
				setRadarAreaColor(Area, r2, g2, b2, 175)
			end
		end
	end, 1000, 1)
end)
local playersInTurf = {}

addEventHandler("onResourceStart", resourceRoot,
function()
--	executeSQLQuery("DROP TABLE turfssys")
	executeSQLQuery("CREATE TABLE IF NOT EXISTS turfssys ( Turf TEXT, Team1 TEXT, Team2 TEXT, Team1Progress INT, Team2Progress INT)")
	executeSQLQuery("CREATE TABLE IF NOT EXISTS turfspos ( Turf TEXT, X INT, Y INT, Z INT, SizeX INT, SizeY INT )")
	local check = executeSQLQuery("SELECT * FROM turfssys" )
	local check2 = executeSQLQuery("SELECT * FROM turfspos" )
	if #check ~= #AreaPosition then
		for i=1,#AreaPosition do
			executeSQLQuery("INSERT INTO turfssys (Turf, Team1, Team2, Team1Progress, Team2Progress) VALUES(?,?,?,?,?)", "Turf["..tostring(i).."]", "", "Criminals", 0, 100)
		end
	end
		if #check2 ~= #AreaPosition then
		for i=1,#AreaPosition do
			executeSQLQuery("INSERT INTO turfspos (Turf,X,Y,Z,SizeX,SizeY) VALUES(?,?,?,?,?,?)", "Turf["..tostring(i).."]", AreaPosition[i]["aPosX"], AreaPosition[i]["aPosY"], AreaPosition[i]["aSizeX"], AreaPosition[i]["aSizeY"])
		end
	end
	for i,v in pairs(AreaPosition) do
		local sqlData = executeSQLQuery("SELECT * FROM turfssys WHERE Turf=?", "Turf["..tostring(i).."]")
		local r, g, b = 255, 255, 255
		local gga = tostring(sqlData[1].Team1)
		local ggb = tostring(sqlData[1].Team2)
		local Progress1 = tonumber(sqlData[1].Team1Progress)
		local Progress2 = tonumber(sqlData[1].Team2Progress)
		local TurfArea = createRadarArea(v["aPosX"], v["aPosY"], v["aSizeX"], v["aSizeY"], r, g, b, 175)
		local TurfAreaCol = createColRectangle(v["aPosX"], v["aPosY"], v["aSizeX"], v["aSizeY"])
		setElementData(TurfAreaCol,"owner",sqlData[1].Team1 or sqlData[1].Team2 or "Unknown")
		setElementData(TurfAreaCol,"Progress1",Progress1)
		setElementData(TurfAreaCol,"Progress2",Progress2)
		RadarAreasTurf[TurfArea] = {["WARNING"] = {}}
		RadarAreaColTurf[TurfAreaCol] = TurfArea
		addEventHandler("onColShapeHit", TurfAreaCol,function(player)
			if getElementType(player) == "player" then
				local Area = RadarAreaColTurf[source]
				local Team = getTeamName(getPlayerTeam(player))--getElementData(player, "g")
				local oA = getDataTeam1(Area)
				local LA = getDataProgress1(Area)
				local r1, g1, b1 = 0,100,200--Wrong:getTeamChatColor(oA)
				local oB = getDataTeam2(Area)
				local LB = getDataProgress2(Area)
				local r2, g2, b2 = 255,0,0---Wrong:getTeamChatColor(oB)
				if oA == "LAW" then
					r1,g1,b1 = 0,100,200
				elseif oA == "Criminals" then
					r1,g1,b1 = 255,0,0
				end
				if oB == "LAW" then
					r2,g2,b2 = 0,100,200
				elseif oB == "Criminals" then
					r2,g2,b2 = 255,0,0
				end
				if oA ~= "" and LA > 0 then setElementData(player, "TurfStat1", {oA..": "..LA.."%", {r1, g1, b1}}) else setElementData(player, "TurfStat1", false) end
				if oB ~= "" and LB > 0 then setElementData(player, "TurfStat2", {oB..": "..LB.."%", {r2, g2, b2}}) else setElementData(player, "TurfStat2", false) end
			end
		end)
	    addEventHandler("onColShapeLeave", TurfAreaCol,function(player)
			if getElementType(player) == "player" then
				local pInMarker = getElementsWithinColShape ( source , "player" )
				local cInMarker = { }
				for index , playerx in ipairs ( pInMarker ) do
					if isLaw(playerx) == true or getTeamName(getPlayerTeam(playerx)) == "Criminals" then
						table.insert ( cInMarker, playerx )
					end
				end
				if #cInMarker <= 0 then
					local area = RadarAreaColTurf[source]
					setRadarAreaFlashing(area, false)
				end
				setElementData(player, "TurfStat1", false)
				setElementData(player, "TurfStat2", false)
			end
		end)
		setElementData(TurfArea,"number",sqlData[1].Turf)
	end
end)

addCommandHandler("staff",function(player)
	for Col, Area in pairs(RadarAreaColTurf) do
		if isElementWithinColShape ( player, Col ) then
			local pInMarker = getElementsWithinColShape ( Col , "player" )
			local cInMarker = { }
			for index , playerx in ipairs ( pInMarker ) do
				if isLaw(playerx) == true or getTeamName(getPlayerTeam(playerx)) == "Criminals" then
					table.insert ( cInMarker, playerx )
				end
			end
			if #cInMarker <= 0 then
				local area = RadarAreaColTurf[Col]
				setRadarAreaFlashing(Area, false)
			end
			setElementData(player, "TurfStat1", false)
			setElementData(player, "TurfStat2", false)
			if isLaw(player) == true then
				if "Law" == getDataTeam1(Area) then
					if getDataProgress1(Area) == 100 then return end
					local ggg = getDataProgress1(Area) + 1
					setTurfProgress1(Area,ggg)
					local ggga = getDataProgress2(Area) - 1
					setTurfProgress2(Area,ggga)
				end
			end
			if getTeamName(getPlayerTeam(player)) == "Criminals" then
				if "Criminals" == getDataTeam2(Area) then
					if getDataProgress2(Area) == 100 then return end
					local ggg = getDataProgress2(Area) + 1
					setTurfProgress2(Area,ggg)
					local ggag = getDataProgress1(Area) - 1
					setTurfProgress1(Area,ggag)
				end
			end
		end
	end
end)

addEvent ("onPlayerJobChange", true)
addEventHandler ("onPlayerJobChange", root, function()
	for Col, Area in pairs(RadarAreaColTurf) do
		if isElementWithinColShape ( source, Col ) then
			local pInMarker = getElementsWithinColShape ( Col , "player" )
			local cInMarker = { }
			for index , playerx in ipairs ( pInMarker ) do
				if isLaw(playerx) == true or getTeamName(getPlayerTeam(playerx)) == "Criminals" then
					table.insert ( cInMarker, playerx )
				end
			end
			if #cInMarker <= 0 then
				local area = RadarAreaColTurf[Col]
				setRadarAreaFlashing(Area, false)
			end
			setElementData(source, "TurfStat1", false)
			setElementData(source, "TurfStat2", false)
			if isLaw(source)  == true then
				if "Law" == getDataTeam1(Area) then
					if getDataProgress1(Area) == 100 then return end
					local ggg = getDataProgress1(Area) + 1
					setTurfProgress1(Area,ggg)
					local ggga = getDataProgress2(Area) - 1
					setTurfProgress2(Area,ggga)
				end
			end
			if getTeamName(getPlayerTeam(source)) == "Criminals" then
				if "Criminals" == getDataTeam2(Area) then
					if getDataProgress2(Area) == 100 then return end
					local ggg = getDataProgress2(Area) + 1
					setTurfProgress2(Area,ggg)
					local ggag = getDataProgress1(Area) - 1
					setTurfProgress1(Area,ggag)
				end
			end
		end
	end
end)


addEventHandler("onPlayerJailed",root,function()
	for Col, Area in pairs(RadarAreaColTurf) do
		if isElementWithinColShape ( source, Col ) then
			local pInMarker = getElementsWithinColShape ( Col , "player" )
			local cInMarker = { }
			for index , playerx in ipairs ( pInMarker ) do
				if isLaw(playerx)  == true or getTeamName(getPlayerTeam(playerx)) == "Criminals" then
					table.insert ( cInMarker, playerx )
				end
			end
			if #cInMarker <= 0 then
				local area = RadarAreaColTurf[Col]
				setRadarAreaFlashing(Area, false)
			end
			setElementData(source, "TurfStat1", false)
			setElementData(source, "TurfStat2", false)
			if isLaw(source) == true then
				if "Law" == getDataTeam1(Area) then
					if getDataProgress1(Area) == 100 then return end
					local ggg = getDataProgress1(Area) + 1
					setTurfProgress1(Area,ggg)
					local ggga = getDataProgress2(Area) - 1
					setTurfProgress2(Area,ggga)
				end
			end
			if getTeamName(getPlayerTeam(source)) == "Criminals" then
				if "Criminals" == getDataTeam2(Area) then
					if getDataProgress2(Area) == 100 then return end
					local ggg = getDataProgress2(Area) + 1
					setTurfProgress2(Area,ggg)
					local ggag = getDataProgress1(Area) - 1
					setTurfProgress1(Area,ggag)
				end
			end
		end
	end
end)

function getPlayers(col)
	if col then
		local pInMarker = getElementsWithinColShape ( col , "player" )
		local cInMarker1 = { }
		local cInMarker2 = { }
		for index , playerx in ipairs ( pInMarker ) do
			if isLaw(playerx) == true then
				table.insert ( cInMarker1, playerx )
			end
			if getTeamName(getPlayerTeam(playerx)) == "Criminals" then
				table.insert ( cInMarker2, playerx )
			end
		end
		return cInMarker1,cInMarker2
	end
end
setTimer(function()
	for Col, Area in pairs(RadarAreaColTurf) do
		local pInMarker = getElementsWithinColShape ( Col , "player" )
		local cInMarker = { }
		for index , player in ipairs ( pInMarker ) do
			if isLaw(player) == true or getTeamName(getPlayerTeam(player)) == "Criminals" then
				table.insert ( cInMarker, player )
			else
				setElementData(player, "TurfStat1", false)
				setElementData(player, "TurfStat2", false)
			end
		end
		if #cInMarker <= 0 then
			local area = RadarAreaColTurf[Col]
			setRadarAreaFlashing(area, false)
		end
	end
	gMoneyTime = gMoneyTime + 1
    if gMoneyTime == 250 then
        gMoneyTime = 0
        for G, X in pairs(getTeamsTurf(96)[1]) do
			local OnlineMember = getTeamOnlineMember(G)
            local MoneyPerOnlineMember = math.floor((5000*X)/#OnlineMember)
            for i, player in ipairs(OnlineMember) do
                if isPlayerInLS(player) and getPlayerIdleTime(player) < 300000  then
					if isLaw(player) == true or getTeamName(getPlayerTeam(player)) == "Criminals" then
						exports.NGCdxmsg:createNewDxMessage("You have earned $"..MoneyPerOnlineMember.." from capturing The Territories.", player, 0, 255, 0)
						givePlayerMoney(player,MoneyPerOnlineMember)
					end
				end
			end
		end
	end
	for Col, Area in pairs(RadarAreaColTurf) do
		for i, player in ipairs(getElementsWithinColShape(Col, "player")) do
			if isLaw(player)  == true or getTeamName(getPlayerTeam(player)) == "Criminals" then
			if isPedDead(player) == false and getElementDimension(player) == 0 and getElementInterior(player) == 0 then
				if isLaw(player) then
					Team = "LAW"
				elseif ( getPlayerTeam(player) == getTeamFromName("Criminals")) then
					Team = "Criminals"
				else
					Team = "Unknown"
				end
				if not isPedInVehicle(player) then
					local x, y, z = getElementPosition(player)
					if z < 150 and z >= 1 and not doesPedHaveJetPack(player) then
						local oA = getDataTeam1(Area)
						local LA = getDataProgress1 (Area)
						local oB = getDataTeam2(Area)
						local LB = getDataProgress2 (Area)
						if oA == "LAW" then
							r1,g1,b1 = 0,100,200
						elseif oA == "Criminals" then
							r1,g1,b1 = 255,0,0
						end
						if oB == "LAW" then
							r2,g2,b2 = 0,100,200
						elseif oB == "Criminals" then
							r2,g2,b2 = 255,0,0
						end
						if LA < 85 and LB < 85 then
							setRadarAreaFlashing(Area, true)
						end
						if LA < 75 and LA > 50 and LB < 60 then
							r1,g1,b1 = 255,255,255
						elseif LA < 90 and LA > 75 and LB < 60 then
							r1,g1,b1 = 255,255,0
						elseif LB < 75 and LB > 50 and LA < 60 then
							r2,g2,b2 = 255,255,255
						elseif LB < 90 and LB > 75 and LA < 60 then
							r2,g2,b2 = 255,255,0
						else
							if isRadarAreaFlashing(Area) then
								setRadarAreaFlashing(Area, false)
								RadarAreasTurf[Area]["WARNING"] = {}
							end
						end
						if RadarAreasTurf[Area]["WARNING"][Team] == nil then
							if oA ~= Team and LA > 50 and LA < 75 then
								RadarAreasTurf[Area]["WARNING"][Team] = true
							elseif oB ~= Team and LB > 50 and LB < 75 then
								RadarAreasTurf[Area]["WARNING"][Team] = true
							end
						end
						if LA >= 51 and oA == Team then
							if LA == 51 then
								if Team == "LAW" then
									msgLaw("Law Enforcements have provoked the Territory")
									msgCrim("Law Enforcements have provoked "..z.." street.")
									playSoundFrontEnd(player, 101)
								elseif Team == "Criminals" then
									local x,y,c = getElementPosition(player)
									local z = getZoneName(x,y,c)
									msgCrim("Criminals Enforcements have provoked the Territory")
									msgLaw("Criminals Enforcements have provoked "..z.." street.")
									playSoundFrontEnd(player, 101)
								end
							end
							setRadarAreaColor(Area, r1, g1, b1, 175)
						elseif LB >= 51 and oB == Team then
							if LB == 51 then
								if Team == "LAW" then
									msgLaw("Law Enforcements have provoked the Territory")
									msgCrim("Law Enforcements have provoked "..z.." street.")
									playSoundFrontEnd(player, 101)
								elseif Team == "Criminals" then
									local x,y,c = getElementPosition(player)
									local z = getZoneName(x,y,c)
									msgCrim("Criminals Enforcements have provoked the Territory")
									msgLaw("Criminals Enforcements have provoked "..z.." street.")
									playSoundFrontEnd(player, 101)
								end
							end
							setRadarAreaColor(Area, r2, g2, b2, 175)
						end
						if LA >= 90 and oA == Team then
							if LA == 90 then
								outputDebugString(Team)
								if Team == "LAW" then
									local tbl,crim = getPlayers(Col)
									for k,v in ipairs(tbl) do
										if antiGot[v] and isTimer(antiGot[v]) then return end
										antiGot[v] = setTimer(function() end,5000,1)
										msgLaw("Territory has been secured")
										msgCrim("Law Enforcements have secured "..z.." street.")
										playSoundFrontEnd(v, 101)
										givePlayerMoney(v,5000)
										outputDebugString(getPlayerName(v).." got money")
										exports.NGCnote:addNote("turfing pay","You have earned $5000 for re-taking this territory!",v,0,255,0,5000)
									end
								elseif Team == "Criminals" then
									local tbl,crim = getPlayers(Col)
									for k,v in ipairs(crim) do
										if antiGot[v] and isTimer(antiGot[v]) then return end
										antiGot[v] = setTimer(function() end,5000,1)
										local x,y,c = getElementPosition(v)
										local z = getZoneName(x,y,c)
										msgCrim("Territory has been captured")
										msgLaw("Criminals Enforcements have captured "..z.." street.")
										playSoundFrontEnd(v, 101)
										givePlayerMoney(v,5000)
										outputDebugString(getPlayerName(v).." got money")
										exports.NGCnote:addNote("turfing pay","You have earned $5000 for re-taking this territory!",v,0,255,0,5000)
									end
								end
							end
							setRadarAreaColor(Area, r1, g1, b1, 175)
						elseif LB >= 90 and oB == Team then
							if LB == 90 then
								outputDebugString(Team)

								if Team == "LAW" then
									local tbl,crim = getPlayers(Col)
									for k,v in ipairs(tbl) do
										if antiGot[v] and isTimer(antiGot[v]) then return end
										antiGot[v] = setTimer(function() end,5000,1)
										local x,y,c = getElementPosition(v)
										local z = getZoneName(x,y,c)
										msgLaw("Territory has been secured")
										msgCrim("Law Enforcements have secured "..z.." street.")
										playSoundFrontEnd(v, 101)
										givePlayerMoney(v,5000)
										outputDebugString(getPlayerName(v).." got money")
										exports.NGCnote:addNote("turfing pay","You have earned $5000 from taking this territory!",v,0,255,0,5000)
									end
								elseif Team == "Criminals" then
									local tbl,crim = getPlayers(Col)
									for k,v in ipairs(crim) do
										if antiGot[v] and isTimer(antiGot[v]) then return end
										antiGot[v] = setTimer(function() end,5000,1)
										local x,y,c = getElementPosition(v)
										local z = getZoneName(x,y,c)
										msgCrim("Territory has been captured")
										msgLaw("Criminals Enforcements have captured "..z.." street.")
										playSoundFrontEnd(v, 101)
										givePlayerMoney(v,5000)
										outputDebugString(getPlayerName(v).." got money")
										exports.NGCnote:addNote("turfing pay","You have earned $5000 from taking this territory!",v,0,255,0,5000)
									end
								end
							end
							setRadarAreaColor(Area, r2, g2, b2, 175)
						end
						if oA == "" and oB == "" then
							setTurfTeam1(Area, Team)
							local TeamProgress = getDataProgress1 (Area) + 1
							setTurfProgress1 (Area, TeamProgress)
						elseif oA == Team and oB == "" and LA < 100 then
							local TeamProgress = getDataProgress1 (Area) + 1
							setTurfProgress1 (Area, TeamProgress)
						elseif oB == Team and oA == "" and LB < 100 then
							local TeamProgress = getDataProgress2 (Area) + 1
							setTurfProgress2 (Area, TeamProgress)
						elseif oA == Team and oB ~= "" and LA < 100 then
							local TeamProgress = getDataProgress1 (Area) + 1
							setTurfProgress1 (Area, TeamProgress)
							local TeamProgress = getDataProgress2 (Area) - 1
							setTurfProgress2 (Area, TeamProgress)
							if getDataProgress2 (Area) < 0 then
								local TeamProgress = 0
								setTurfProgress2 (Area, TeamProgress)
								setTurfTeam2(Area, "")
							end
						elseif oB == Team and oA ~= "" and LB < 100 then
							local TeamProgress = getDataProgress2 (Area) + 1
							if TeamProgress > 100 then TeamProgress = 100 end
							setTurfProgress2 (Area, TeamProgress)
							--outputDebugString("line 457")
							local TeamProgress = getDataProgress1 (Area) - 1
							if TeamProgress == 1 then TeamProgress = 0 end
							setTurfProgress1 (Area, TeamProgress)
							if getDataProgress1 (Area) < 0 then
								local TeamProgress = 0
								setTurfProgress1 (Area, TeamProgress)
								setTurfTeam1(Area, "")
							end
						elseif oA ~= Team and oB ~= Team then
							local MinL = math.min(LA, LB)
							if MinL == LA then
								if getDataProgress1 (Area) <= 0 then
									setTurfTeam1(Area, Team)
									setTurfProgress1 (Area, 1)
									if oA == "LAW" then
										r,g,b = 0,100,200
									elseif oA == "Criminals" then
										r,g,b = 255,0,0
									end
									if oB == "LAW" then
										r,g,b = 0,100,200
									elseif oB == "Criminals" then
										r,g,b = 255,0,0
									end
								else
									local TeamProgress = getDataProgress1 (Area) - 1
									setTurfProgress1 (Area, TeamProgress)
									--outputDebugString("line 483")
								end
							elseif MinL == LB then
								if getDataProgress2 (Area) <= 0 then
									setTurfTeam2(Area, Team)
									local TeamProgress = 1
									setTurfProgress2 (Area, TeamProgress)
									if oA == "LAW" then
										r,g,b = 0,100,200
									elseif oA == "Criminals" then
										r,g,b = 255,0,0
									end
									if oB == "LAW" then
										r,g,b = 0,100,200
									elseif oB == "Criminals" then
										r,g,b = 255,0,0
									end
								else
									local TeamProgress = getDataProgress2 (Area) - 1
									setTurfProgress2 (Area, TeamProgress)
									--outputDebugString("Progress - 1 line 502")
								end
							end
						end
					end
				else
					exports.NGCdxmsg:createNewDxMessage( "You can't participate in LAW vs Criminals Game while you're in a vehicle.", player,255, 0, 0)
				end
			end
			end
			local oA = getDataTeam1(Area)
			local LA = getDataProgress1 (Area)
			if oA == "LAW" then
				r1,g1,b1 = 0,100,200
			elseif oA == "Criminals" then
				r1,g1,b1 = 255,0,0
			end
			if oB == "LAW" then
				r1,g1,b1 = 0,100,200
			elseif oB == "Criminals" then
				r1,g1,b1 = 255,0,0
			end
			local oB = getDataTeam2(Area)
			local LB = getDataProgress2 (Area)
			if oA == "LAW" then
				r2,g2,b2 = 0,100,200
			elseif oA == "Criminals" then
				r2,g2,b2 = 255,0,0
			end
			if oB == "LAW" then
				r2,g2,b2 = 0,100,200
			elseif oB == "Criminals" then
				r2,g2,b2 = 255,0,0
			end
			if oA ~= "" and LA > 0 then setElementData(player, "TurfStat1", {oA..": "..LA.."%", {r1, g1, b1},oA,LA}) else setElementData(player, "TurfStat1", false) end
			if oB ~= "" and LB > 0 then setElementData(player, "TurfStat2", {oB..": "..LB.."%", {r2, g2, b2},oB,LB}) else setElementData(player, "TurfStat2", false) end
		end
	end
end,2500, 0)

function payThem(t)
	if t == "Law" then
		msgLaw("Territory has been secured")
		msgCrim("Law Enforcements have secured "..z.." street.")
		playSoundFrontEnd(player, 101)
		givePlayerMoney(player,5000)
		outputDebugString(getPlayerName(player).." got money")
		exports.NGCnote:addNote("turfing pay","You have earned $5000 for re-taking this territory!",player,0,255,0,5000)
	elseif t == "Criminals" then
		local x,y,c = getElementPosition(player)
		local z = getZoneName(x,y,c)
		msgCrim("Territory has been captured")
		msgLaw("Criminals Enforcements have captured "..z.." street.")
		playSoundFrontEnd(player, 101)
		givePlayerMoney(player,5000)
		outputDebugString(getPlayerName(player).." got money")
		exports.NGCnote:addNote("turfing pay","You have earned $5000 for re-taking this territory!",player,0,255,0,5000)
	end
end

function player123Wasted ( ammo, ki, weapon, bodypart )
    for Col, Area in pairs(RadarAreaColTurf) do
		if isElementWithinColShape ( source, Col ) then
			if isLaw(source) == true then
				if "Law" == getDataTeam1(Area) then
				if getDataProgress1(Area) == 100 then return end
				local ggg = getDataProgress1(Area) + 1
				setTurfProgress1(Area,ggg)
				local ggga = getDataProgress2(Area) - 1
				setTurfProgress2(Area,ggga)
				end
			end
			if getTeamName(getPlayerTeam(source)) == "Criminals" then
				if "Criminals" == getDataTeam2(Area) then
					if getDataProgress2(Area) == 100 then return end
					local ggg = getDataProgress2(Area) + 1
					setTurfProgress2(Area,ggg)
					local ggag = getDataProgress1(Area) - 1
					setTurfProgress1(Area,ggag)
				end
			end
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player123Wasted )
addEventHandler ( "onPlayerQuit", getRootElement(), player123Wasted )


function isLaw( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
	else
		return
	end
end

function msgLaw(s)
	for k,v in ipairs(getElementsByType("player")) do
		if isLaw(v) == true then
			local cx, cy, cz = getElementPosition(v)
			if (getDistanceBetweenPoints3D(1628, -1471, 22, cx, cy, cz) < 1500) then
				exports.NGCdxmsg:createNewDxMessage(s,v,0,100,200)
			end
		end
	end
end

function msgCrim(s)
	for k,v in ipairs(getElementsByType("player")) do
		if getPlayerTeam(v) and getTeamName(getPlayerTeam(v)) == "Criminals" then
			local cx, cy, cz = getElementPosition(v)
			if (getDistanceBetweenPoints3D(1628, -1471, 22, cx, cy, cz) < 1500) then
				exports.NGCdxmsg:createNewDxMessage(s,v,225,0,50)
			end
		end
	end
end

function isPlayerInLS(p)
	local cx, cy, cz = getElementPosition(p)
	if (getDistanceBetweenPoints3D(1628, -1471, 22, cx, cy, cz) < 1500) then
		return true
	else
		return false
	end
end

