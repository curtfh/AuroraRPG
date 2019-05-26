--exports.DENmysql:query("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountToday[accName]),userid,theStamp)
--local t2 = exports.DENmysql:query( "SELECT timestamp FROM crimes WHERE userid=? AND timestamp=?",userid,11111111)
local currentRanks = {}
--[[local setSWATRank = {
	["epozide"] = true,
	["vladimir"] = true,
}

local setMFRank = {
	["epozide"] = true,

}]]

addEvent("getCustomRank",true)
addEventHandler("getCustomRank",root,function ()
	if getPlayerTeam(source) then
		if exports.DENjob:isFirstLaw(source) then
			local user = exports.server:getPlayerAccountName(source)
			local t2 = exports.DENmysql:query( "SELECT * FROM samer_groupmembers WHERE memberAcc=?",user)
			for k,v in pairs(t2) do
				if v.groupRank ~= nil and v.groupRank ~= false then
					setElementData(source,"ExRank",v.groupRank)
				else
					setElementData(source,"ExRank",false)
				end
			end
		else
			setElementData(source,"ExRank",false)
		end
    end
end)

addEvent("removeCustomRank",true)
addEventHandler("removeCustomRank",root,function(founder,target)
	if getElementData(founder,"Group") == "SWAT Team" or getElementData(founder,"Group") == "Military Forces"  then
		local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",target)
		if t2 then
			for k,v in pairs(t2) do
				if v.Rank ~= nil and v.Rank ~= false then
					exports.DENmysql:exec("DELETE FROM officiallawranks WHERE Username=?",target)
					return true
				end
			end
		end
	end
end)

addEventHandler("onServerPlayerLogin",root,function()
    local user = exports.server:getPlayerAccountName(source)
    local t2 = exports.DENmysql:query( "SELECT * FROM samer_groupmembers WHERE memberAcc=?",user)
    for k,v in pairs(t2) do
		if v.groupRank ~= nil and v.groupRank ~= false then
			for _,player in pairs(getElementsByType("player")) do
				triggerClientEvent(player,"recRank",player,user,v.groupRank,v.Lawgroup)
            end
            table.insert(currentRanks,{user,v.groupRank,v.Lawgroup})
        end
    end
    for k,v in pairs(currentRanks) do
        triggerClientEvent(source,"recRank",source,v[1],v[2],v[3])
    end
end)

addEventHandler("onPlayerQuit",root,function()
    local user = exports.server:getPlayerAccountName(source)
    for k,v in pairs(currentRanks) do
        if v[1] == user then
            table.remove(currentRanks,k)
            return
        end
    end
end)

--addCommandHandler("setSWAT Teamrank",
addEvent("setCustomRank",true)
addEventHandler("setCustomRank",root,function (player, groupName, user, theRank)
	if theRank == nil or theRank == "" then
		outputDebugString("Error rank is nil or string")
		return false
	end
	if groupName == "SWAT Team" then
			local rank = ""
			if (user) and (theRank) and (theRank ~= nil and theRank ~= "") then
				rank = theRank

			else
				exports.NGCdxmsg:createNewDxMessage(ps,"Something isn't going well in custom ranks",255,0,0)
				return
			end
			local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
			if #t2 > 0 then
				local isSWATTeam = false
				for k,v in pairs(t2) do
					if v.Lawgroup == "SWAT Team" then
						isSWATTeam=true
					end
				end
				if isSWATTeam == false then
					exports.DENmysql:exec("DELETE FROM officiallawranks WHERE Username=?",user)
					exports.DENmysql:exec("INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"SWAT Team",rank)
					--insert
				else
					exports.DENmysql:exec("UPDATE officiallawranks SET Rank=? WHERE Username=? AND Lawgroup=?",rank,user,"SWAT Team")
					--update
				end
			else --insert
				exports.DENmysql:exec( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"SWAT Team",rank)
			end
			exports.NGCdxmsg:createNewDxMessage(ps,"You have set Username "..user.."'s SWAT Team rank to "..rank..".",0,255,0)
			exports.NGCdxmsg:createNewDxMessage(ps,"Tell that person to reconnect for their rank to be updated on scoreboard",0,255,0)

	elseif groupName == "Military Forces" then
			local rank = ""
			if (user) and (theRank) and (theRank ~= nil and theRank ~= "") then
				rank = theRank

			else
				exports.NGCdxmsg:createNewDxMessage(ps,"Something isn't going well in custom ranks",255,0,0)
				return
			end
			local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
			if #t2 > 0 then
				local ismf = false
				for k,v in pairs(t2) do
					if v.Lawgroup == "Military Forces" then
						ismf=true
					end
				end
				if ismf == false then
					outputDebugString("Deleing from csgranks official law ranks and inserting new")
					exports.DENmysql:exec("DELETE FROM officiallawranks WHERE Username=?",user)
					exports.DENmysql:exec("INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"Military Forces",rank)
					--insert
				else
					outputDebugString("just updating from csgranks official law ranks and inserting new")
					exports.DENmysql:exec("UPDATE officiallawranks SET Rank=? WHERE Username=? AND Lawgroup=?",rank,user,"Military Forces")
					--update
				end
			else --insert
				outputDebugString("Adding from csgranks official law ranks and inserting new")
				exports.DENmysql:exec( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"Military Forces",rank)
			end
			exports.NGCdxmsg:createNewDxMessage(ps, "You have set username "..user.."'s rank to "..rank..".",0,255,0)
			exports.NGCdxmsg:createNewDxMessage(ps, "Tell that person to reconnect for their rank to be updated on scoreboard",0,255,0)

	end
end)

--[[
addCommandHandler("setmfrank",
	function(ps,groupName,user,theRank,,r3)
		if setMFRank[exports.server:getPlayerAccountName(ps)] then
			local rank = ""
			if (user) and (theRank) and (theRank ~= nil and theRank ~= "") then
				rank = theRank
				if () then
					rank=rank.." "....""
				end
				if (r3) then
					rank=rank.." "..r3..""
				end
			else
				exports.NGCdxmsg:createNewDxMessage(ps,"Set mf rank usage: /setmfrank user rank",255,0,0)
				return
			end
			local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
			if #t2 > 0 then
				local ismf = false
				for k,v in pairs(t2) do
					if v.Lawgroup == "Military Forces" then
						ismf=true
					end
				end
				if ismf == false then
					exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"Military Forces",rank)
					--insert
				else
					exports.DENmysql:query("UPDATE officiallawranks SET Rank=? WHERE Username=? AND Lawgroup=?",rank,user,"Military Forces")
					--update
				end
			else --insert
				exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"Military Forces",rank)
			end
			exports.NGCdxmsg:createNewDxMessage(ps, "You have set username "..user.."'s Military Forces rank to "..rank..".",0,255,0)
			exports.NGCdxmsg:createNewDxMessage(ps, "Tell that person to reconnect for their rank to be updated on scoreboard",0,255,0)
		end
	end
)]]

-------------


local newsRanks = {
    {"News Reporter in Training",0,0},
    {"Assistant of Photography", 30, 15},
    {"Photographer", 70, 20},
    {"Editor", 120, 25},
    {"Reporter", 170, 30},
    {"Photo Editor", 240, 35},
    {"Head Editor", 320, 40},
    {"Final Redator", 410, 50}
}

local limoRanks = {
 {"Limo Driver In Training",0},
 {"New Limo Driver",15},
 {"Trained Limo Driver",50},
 {"Experienced Limo Driver",150},
 {"Senior Limo Driver",50},
 {"Lead Limo Driver",350},
 {"Head Limo Driver",500},
}

local diverRanks = {
  {"Diver in Training",0,0,500},
 {"Second Class Diver",50,1000,750},
 {"First Class Diver",100,2000,1000},
 {"Chief Diver",200,3000,1500},
 {"Senior Chief Diver",250,10000,2000},
 {"Diving Technician",350,20000,3000},
 {"Master Chief Diver",500,30000,4000},
}

local taxiRanks = {
	{"L0. Driver", 0, 0, 1400},
	{"L1. Driver", 50, 1000, 1700},
	{"L2. Driver", 100, 2000, 2200},
	{"L3. Driver", 200, 3000, 2750},
	{"L4. Driver", 300, 4000, 3500},
	{"L5. Driver", 500, 5000, 4300},
	{"L6. Driver", 750, 6000, 4750},
	{"L7. Driver", 950, 7000, 5100},
	{"L8. Driver", 1200, 8000, 5300},
	{"L9. Driver", 1600, 9000, 5500},
	{"L10. Driver", 3000, 10000, 6000},
}

local rescuerRanks = {
	{ "Rescuer Man in Training",0,0,0},
	{ "New Rescuer Man",50,1000,50},
	{ "Trained Rescuer Man",350,2000,100},
	{ "Experienced Rescuer Man",800,3000,200},
	{ "Senior Rescuer Man",1000,10000,300},
	{ "Lead Rescuer Man",2000,20000,400},
	{ "Head Rescuer Man",3000,30000,500},
}

local pilotRanks = {
	{ "Student Pilot", 0,0,0},
	{ "Flight Engineer", 5000,1000,1000},
	{ "First Officer", 50000,2000,2000},
	{ "Senior First Officer", 100000,3000,3000},
	{ "Captain",500000,10000,4000},
	{ "Senior Captain",1000000,20000,5000},
	{ "Airline CEO", 5000000,30000,10000},
}

local farmerRanks = {
	{"New Farmer",0,0,0},
	{"Trained Farmer",50,1000,100},
	{"The owner of the farm",100,2000,200},
	{"Experienced old man",350,3000,300},
	{"Professional old man",800,10000,400},
	{"Lead Farmer",1300,20000,500},
	{"The Farmer of Aurora",3000,30000,1000},
}

local fisherRanks = {
    { "New Fisherman", 0,0,0},
    { "Regular Fisherman", 50,0,0},
    { "Experienced Fisherman", 200,1000,50},
    { "Seasonal Fisherman", 800,2000,100},
    { "Lead Fisherman",1000,3000,200},
    { "Head Fisherman", 2000,10000,300},
    { "SA Fising CEO", 4000,20000,400},
    { "King of the Ocean", 6000,30000,500},

}


local paramedicRanks = {
    {"Medical Student",0,0,0},
    {"Experienced Doctor",50,1000,50},
    {"Head Doctor",300,2000,100},
    {"Experienced Surgeon",800,3000,200},
    {"Head Surgeon",1000,10000,300},
    {"AUR Medical Head",4000,20000,400},
    {"AUR Medical CEO",8000,30000,500},

}

local truckerRanks = {
	{"Regular Trucker",0,0,0},
    {"Seasoned Trucker",50,1000,2000},
    {"Enthusiast Trucker",100,20000,5000},
    {"Outback Ranger",350,30000,10000},
    {"Commander Trucker",800,10000,15000},
    {"Desert Captain",1000,38000,20000},
    {"King of the Road",3000,40000,30000},
}

local lumberRanks = {
    {"Wood Collector",0,0,0},
    {"Seasonal Woodcutter",50,1000,50},
    {"Constant Lumberjack",100,2000,100},
    {"Forest Woodcutter",350,3000,200},
    {"Head Lumberjack",800,10000,300},
    {"Lumberjack at Charge",1000,20000,400},
    {"Lead Woodcutter",3000,30000,500},
}



local garbageRanks = {
	{"Garbage Collector",0,0,0},
	{"Constant Garbage man",50,1000,50},
	{"City Garbage man",100,2000,100},
	{"Head Garbage man",350,3000,200},
	{"Senior Garbage man",800,10000,300},
	{"Lead Garbage man",1000,20000,400},
	{"Garbage man King",2000,30000,500},
}

local firefighterRanks = {
	{"Volunteer firefighter",0,0,0},
	{"Probationary firefighter",50,1000,100},
	{"Lieutenant Firefighter",100,2000,150},
	{"Battalion Chief",350,3000,200},
	{"Assistant Fire Chief",800,10000,300},
	{"Fire Chief",1000,20000,500},
	{"Fire Commissioner",3000,30000,700},
}

local minerRanks = {
	{"Starter", 0},
	{"New Miner", 50},
	{"Fledgling Miner", 100},
	{"Apprentice Miner", 300},
	{"Adept Miner", 700},
	{"Expert Miner", 1300},
	{"Master Miner", 1600},
	{"Legend Miner", 2400},
	{"Proficient Miner", 3000},
	{"Official Miner", 6000},
}

local traffickerRanks =
{
	{"Starter", 0},
	{"Drug Runner", 150},
	{"Drug Falcon", 300},
	{"Drug Kingpin", 500},
	{"Drug Lord", 2000},
}

local postmanRanks = {
	{"Starter Postman", 20, 0, 500},
	{"Enlisted Postman", 50, 0, 700},
	{"Mail Deliverer", 90, 0, 1500},
	{"Expert Postman", 150, 0, 2500},
}

local occupationToStat = {
    ["Farmer"] = "farmer",
    ["Diver"] = "diver",
    ["Rescuer Man"] = "rescuerMan",
    ["Pilot"] = "pilot",
    ["Paramedic"] = "paramedic",
    ["Firefighter"] = "firefighter",
    ["Trash Collector"] = "garbage",
    ["Mechanic"] = "MechanicPoints",
    ["Hooker"] = "hooker",
    ["Trucker"] = "trucking",
    ["Fisherman"] = "fisherman",
    ["Paramedic"] = "paramedic2",
    ["News Reporter"] = "newsreporter",
    ["Lumberjack"] = "lj",
	["Taxi Driver"] = "limoDriver",
	["Pizza Boy"] = "pizzas",
	["Drug Trafficker"] = "drugTrafficker",
	["Postman"] = "postmanMails"
}

--[[local occupationToStat = {
    ["Farmer"] = "farmer",
    ["Diver"] = "diver",
    ["Rescuer Man"] = "rescuerMan",
    ["Pilot"] = "pilot",
    ["Paramedic"] = "paramedic",
    ["Firefighter"] = "firefighter",
    ["Trash Collector"] = "garbage",
    ["Mechanic"] = "MechanicPoints",
    ["Hooker"] = "hooker",
    ["Trucker"] = "trucking",
    ["Fisherman"] = "fisherman",
    ["Paramedic"] = "paramedic2",
    ["News Reporter"] = "newsreporter",
    ["Lumberjack"] = "lj",
	["Taxi Driver"] = "limoDriver",
	["Miner"] = "miner",
}]]--


local occupationToRank = {
    ["Farmer"] = farmerRanks,
    ["Diver"] = diverRanks,
    ["Rescuer Man"] = rescuerRanks,
    ["Pilot"] = pilotRanks,
    ["Paramedic"] = paramedicRanks,
    ["Firefighter"] = firefighterRanks,
    ["Trash Collector"] = garbageRanks,
    ["Hooker"] = hookerRanks,
    ["Trucker"] = truckerRanks,
    ["Fisherman"] = fisherRanks,
    ["Trucker"] = truckerRanks,
    ---["News Reporter"] = newsRanks,
    ["Lumberjack"] = lumberRanks,
	["Taxi Driver"] = taxiRanks,
	["Pizza Boy"] = pizzaboyRanks,
	["Drug Trafficker"] = traffickerRanks,
	["Postman"] = postmanRanks,
}

function getOccupationToRankTable()
    return occupationToRank
end

function getRank(e,occ)
    local occupation = occ
        if ( occupationToRank[occupation] ) then
            local stat = exports.DENstats:getPlayerAccountData( e, occupationToStat[occupation] )
			if not stat or stat == nil or stat == false or type(stat) ~= "number" then stat = 0 end
            if ( stat ) then
                local number=0
                local theRank = false
                for i=1,#occupationToRank[occupation] do
                    if not ( theRank ) then
                        theRank = occupationToRank[occupation][i][1]
                        number=i
                    elseif ( tonumber(occupationToRank[occupation][i][2]) <= tonumber(stat) ) then
                        theRank = occupationToRank[occupation][i][1]
                        number=i
                    end
                end
                return theRank,number,#occupationToRank[occupation]
            else
                return false
            end
		else
			return false
        end
    return false
end

function getRankAccountFromID(e,occ)
    local occupation = occ
        if ( occupationToRank[occupation] ) then
            local stat = exports.DENmysql:querySingle("SELECT ? FROM playerstats WHERE userid=? LIMIT 1", occupationToStat[occupation], e)[occupationToStat[occupation]]
			if not stat or stat == nil or stat == false or type(stat) ~= "number" then stat = 0 end
            if ( stat ) then
                local number=0
                local theRank = false
                for i=1,#occupationToRank[occupation] do
                    if not ( theRank ) then
                        theRank = occupationToRank[occupation][i][1]
                        number=i
                    elseif ( tonumber(occupationToRank[occupation][i][2]) <= tonumber(stat) ) then
                        theRank = occupationToRank[occupation][i][1]
                        number=i
                    end
                end
                return theRank,number,#occupationToRank[occupation]
            else
                return false
            end
		else
			return false
        end
    return false
end


addEventHandler("onPlayerWasted",root,function(_,k)
	if (k) and isElement(k) then
		local kills = exports.DENstats:getPlayerAccountData(k,"kills")
		if kills == nil or kills==false then kills=0 end
		exports.DENstats:setPlayerAccountData(k,"kills",kills+1)
	end
	local am = exports.DENstats:getPlayerAccountData(source,"deaths")
	if am==nil or am==false then am=0 end
	am=am+1
	if getElementData(source,"isPlayerInEvent") == true then
		return
	end
	exports.DENstats:setPlayerAccountData(source,"deaths",am)
end)


function addStat(e,add)
	local occupation = getElementData(e,"Occupation")
	if ( occupationToRank[occupation] ) then
		local stat = exports.DENstats:getPlayerAccountData( e, occupationToStat[occupation] )
		if not stat or stat == false or stat == nil then stat = 0 end
		local total = tonumber(add)+tonumber(stat)
		local total = tonumber(total)
		exports.DENstats:setPlayerAccountData(e,occupationToStat[occupation],total)
		checkPromotion(e)
	end
end

function checkPromotion(e)
	local occupation = getElementData(e,"Occupation")
	if ( occupationToRank[occupation] ) then
		local stat = exports.DENstats:getPlayerAccountData( e, occupationToStat[occupation] )
		if stat then
			for i=1,#occupationToRank[occupation] do
				if ( occupationToRank[occupation][i][2] == stat ) then
					if tonumber(occupationToRank[occupation][i][3]) > 0 then
						local money = occupationToRank[occupation][i][3]
						local newrank = occupationToRank[occupation][i][1]
						exports.AURpayments:addMoney(e,tonumber(money),"Custom","Misc",0,"CSGranks from "..occupation)
						exports.NGCdxmsg:createNewDxMessage(e,"You have reached new rank in "..occupation,255,255,0)
						exports.NGCdxmsg:createNewDxMessage(e,"("..newrank..") promotion payment $"..exports.server:convertNumber(money),255,255,0)
					end
				end
				local theRank = false
				if ( occupationToRank[occupation][i][2] <= stat ) then
					theRank = occupationToRank[occupation][i][1]
				end
				if theRank == getElementData(e,"Rank") then
					local mo = occupationToRank[occupation][i][4]
					if mo > 0 then
						exports.AURpayments:addMoney(e,tonumber(mo),"Custom","Misc",0,"CSGranks from "..occupation)
						exports.NGCdxmsg:createNewDxMessage(e,"("..theRank..") Worker Payment: $"..exports.server:convertNumber(mo),0,255,0)
					end
				end
			end
		end
	end
end
