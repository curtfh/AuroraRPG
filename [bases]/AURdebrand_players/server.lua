--[[GENERAL NOTE ABOUT ADDING NEW SKINS:
PLEASE MAKE SURE YOU ADD ACCOUNT SKINS ON TOP OF THE TABLE.
]]
	--Type  |  Whois  |  File  |  Model name
local debranded_skins = {


	-- Account debranded skins 
	
	{"account", "joseph", "joseph2.png", "swat"},
	--{"account", "dioxide", "dioxide2.png", "wmyclot"},
	{"account", "badboy1", "smilerbouden.png", "wmyclot"},
	{"account", "badboy1", "smiler1.png", "swat"},
	{"account", "envynew", "envystaff.png", "wmyclot"},
	{"account", "badboy1", "gamer2.png", "vwfywai"},
	{"account", "jady", "jady3.png", "swat"},
	{"account", "george5", "neuer.jpg", "swmotr5"},
	{"account", "dj3", "lanzon.jpg", "swmotr5"},
	{"account", "jady", "jady2.png", "wmycd1"},
	{"account", "samer61", "samer.png", "swat"},
	{"account", "hama2002", "mo7amed.png", "wmycd1"},
	{"account", "truc0813", "omlet.png", "swfyri"},
	{"account", "paschi", "paschi3.png", "lapd1"},
	{"account", "paschi", "PaschiStaff.png", "wmyclot"},
	{"account", "ch0kri@loly", "ch0kri@loly.png", "swmotr5"},
	{"account", "franklin", "sm3.png", "swmotr5"},
	{"account", "focus", "!RopZ!.png", "wmycd1"},
	{"account", "leonardo", "Swagy.png", "swmotr5"},
	{"account", "ryder", "ryder.png", "ryder"},
	{"account", "lee", "lee25.png", "crogrl3"},
	{"account", "dr.frank", "crash.png", "omonood"},
	{"account", "youssef123", "crash.png", "omonood"}, 
	{"account", "youssefkh19", "gamerskin.png", "vbfypro"},
	{"account", "skander", "rappskin.png", "swmotr5"},
	{"account", "joseph", "joseph-staff.png", "wmyclot"},
	{"account", "george5", "neuer-swat.png", "swat"},
	{"account", "george5", "ThhNmw6.png", "fbi"},
	{"account", "jojosalman", "f3qzisc.png", "cwmohb2"},
	{"account", "amro1", "hhjod5s.png", "swmotr5"},
	{"account", "youssefkh19", "gamer1059.jpg", "hfybe"},
	{"account", "george5", "neuersucks.png", "wmycd1"},
	{"account", "jake", "jakezebbi.jpg", "swat"},
	{"account", "hama2002", "mohamed.jpg", "swmotr5"},
	{"account", "jomarie", "jomarie.png", "swmotr5"},
    {"account", "amro1", "amro1.png", "vwmotr1"},
	{"account",  "truc0813", "staffskin2.png", "wmyclot"},
	{"account",  "sonny", "shruum.png", "swmotr5"},
	{"account",  "badboy1", "smilercrim.png", "swmotr5"},
	
	-- Group debranded skins 
	
	-- {"group", "Military Forces", "mf.png", "swmyhp2"},
	-- {"group", "Military Forces", "mf8.png", "swat"},
	-- {"group", "Military Forces", "mf2.png", "lapd1"},
	-- {"group", "Military Forces", "mf7.png", "army"},
	-- {"group", "Military Forces", "mf5.png", "fbi"},
	{"group", "Çukur", "cukurskin.png", "wmycd1"},
	{"group", "The Terrorists", "t-skin.png", "swmotr5"},
	{"group", "Advanced Assault Forces", "aafskin.png", "swat"},
	{"team",  "Staff", "staffskin2.png", "wmyclot"},
	-- {"group", "HolyCrap", "hc.png", "swmotr5"},
	-- {"group", "Special PoliceForce", "specialpoliceforce.png", "fbi"},
	-- {"group", "Special PoliceForce", "spf2.jpg", "swat"},
	-- {"group", "Special PoliceForce", "spf71.jpg", "wmysgrd"},
	-- {"group", "Pinoy Pride", "pinoypride2.png", "wmycd1"},
	-- {"group", "Pinoy Pride", "pinoypride5.png", "swmotr5"},
	-- {"group", "Ballas Family", "ballas.png", "hmost"},
	-- {"group", "Special PoliceForce", "spfofficer.jpg", "lapdm1"},
	-- {"group", "Kilo Tray Crips", "lee-160.png", "cwmohb2"},
	-- {"group", "Kilo Tray Crips", "lee-230.png", "swmotr5"},
	-- {"group", "Kilo Tray Crips", "lee-261.png", "wmycd1"},
	-- {"group", "HolyCrap", "HolyCrapg.png", "sbmytr3"},
	-- {"group", "Special Mafia", "specialmafia.png", "swmotr5"},
	-- {"group", "Special Assault Team", "aursat.png", "swat"},
	-- {"group", "Special Assault Team", "aursat2.png", "wmysgrd"},

}

local alreadyTriggered = {}

addEvent("onClientCallDebranded",true)
addEventHandler("onClientCallDebranded",root,function()
	local tex = {}
	for k,v in ipairs(debranded_skins) do
		table.insert(tex,v[3])
	end
	triggerClientEvent(source,"downloadDebrandImage",source,tex)
end)

addEvent("onClientAddDebranded",true)
addEventHandler("onClientAddDebranded",root,function()
	for index, player in ipairs(getElementsByType("player")) do
		if alreadyTriggered[player] == true then return false end
		if ( alreadyTriggered[player] ) and ( getTickCount()-alreadyTriggered[player] < 10000 ) then
			return false
		end
		alreadyTriggered[player] = getTickCount()
	triggerClientEvent(source, "AURdebranded_players.forceRestore", resourceRoot, 217)
		for i=1, #debranded_skins do
			if (debranded_skins[i][1] == "account") then
			local acc = exports.server:getPlayerAccountName(player)
				if (debranded_skins[i][2] == acc) then
					local acc = exports.server:getPlayerAccountName(player)
					triggerClientEvent(root, "AURdebranded_players.activateShader", resourceRoot, "data/"..debranded_skins[i][3], debranded_skins[i][4], player)
				end
			elseif (debranded_skins[i][1] == "occupation") then
				if (debranded_skins[i][2] == getElementData(player, "Occupation")) then
					triggerClientEvent(root, "AURdebranded_players.activateShader", resourceRoot, "data/"..debranded_skins[i][3], debranded_skins[i][4], player)
					outputDebugString("Staff")
				end
			elseif (debranded_skins[i][1] == "team") then
				if (debranded_skins[i][2] == getTeamName(getPlayerTeam(player))) then
					triggerClientEvent(root, "AURdebranded_players.activateShader", resourceRoot, "data/"..debranded_skins[i][3], debranded_skins[i][4], player)
				end
			elseif (debranded_skins[i][1] == "staff") then
				if (debranded_skins[i][2] == exports.CSGstaff:isPlayerStaff(player)) then
					triggerClientEvent(root, "AURdebranded_players.activateShader", resourceRoot, "data/"..debranded_skins[i][3], debranded_skins[i][4], player)
				end
			elseif (debranded_skins[i][1] == "group") then
				if (debranded_skins[i][2] == getElementData(player, "Group")) then
					triggerClientEvent(root, "AURdebranded_players.activateShader", resourceRoot, "data/"..debranded_skins[i][3], debranded_skins[i][4], player)
				end
			end
		end
	end
end)


function onPlayerChangedJob (jobName)
	for index, player in ipairs(getElementsByType("player")) do
		if alreadyTriggered[player] == true then return false end
		if ( alreadyTriggered[player] ) and ( getTickCount()-alreadyTriggered[player] < 10000 ) then
			return false
		end
		alreadyTriggered[player] = getTickCount()
		triggerClientEvent(player,"checkDebradTotal",player)
	end
end
addEvent ("onPlayerJobChange", true)
addEventHandler ("onPlayerJobChange", root, onPlayerChangedJob)


addEventHandler("onServerPlayerLogin", getRootElement(), function()
triggerClientEvent(source, "AURdebranded_players.forceRestore", resourceRoot, 217)
	for index, player in ipairs(getElementsByType("player")) do
		if alreadyTriggered[player] == true then return false end
		if ( alreadyTriggered[player] ) and ( getTickCount()-alreadyTriggered[player] < 10000 ) then
			return false
		end
		alreadyTriggered[player] = getTickCount()
		triggerClientEvent(player,"checkDebradTotal",player)
	end
end)

function activateShaderCMD (plr, cmd)
	for index, player in ipairs(getElementsByType("player")) do
		triggerClientEvent(plr, "AURdebranded_players.forceRestore", resourceRoot, 217)
		if alreadyTriggered[player] == true then return false end
		if ( alreadyTriggered[player] ) and ( getTickCount()-alreadyTriggered[player] < 10000 ) then
			return false
		end
		alreadyTriggered[player] = getTickCount()
		triggerClientEvent(player,"checkDebradTotal",player)
	end
	outputChatBox("DeBrand: Activating debranded skins...", plr, 255, 255, 0)
end

addCommandHandler("debranded", activateShaderCMD)

