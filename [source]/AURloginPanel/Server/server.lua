-- Positions for the matrix view for the login screen
local matrixViewPositions = {
	{2060.693359375, 1323.3287353516, 65.554336547852, 2154.0563964844, 1301.9788818359, 36.787712097168},
	{-488.73297119141, 2129.7478027344, 131.07089233398, -577.43792724609, 2095.4423828125, 100.17473602295},
	{355.38235473633, -1999.6640625, 34.214122772217, 401.36798095703, -2077.3337402344, -8.8294067382813},
	{2373.4975585938, 69.472595214844, 68.322166442871, 2420.0559082031, -10.329551696777, 30.060695648193},
	{2055.7841796875, 1197.9633789063, 25.738883972168, 2141.7668457031, 1147.1596679688, 20.643169403076},
	{2321.8068847656, -1100.53125, 76.947044372559, 2365.5268554688, -1017.3639526367, 42.716026306152},
	{-807.52880859375, 2699.8017578125, 75.263061523438, -853.92779541016, 2777.5541992188, 32.816757202148},
	{196.63110351563, 2660.5759277344, 53.300601959229, 262.5549621582, 2594.3989257813, 17.598323822021},
	{-458.94390869141, -164.11698913574, 123.5959777832, -548.6953125, -195.21823120117, 92.332641601563},
	{-1070.3149414063, -1610.5084228516, 94.326530456543, -1135.0595703125, -1682.0073242188, 67.944076538086},
	{-632.33306884766, -1473.3518066406, 44.557136535645, -545.33532714844, -1492.6140136719, -0.833984375},
	{270.52749633789, -1205.0640869141, 110.60611724854, 321.99029541016, -1128.5759277344, 71.861503601074},
	{1156.4423828125, -1441.9432373047, 38.343357086182, 1086.1207275391, -1504.4560546875, 4.4757308959961},
	{-1267.3508300781, 1106.96484375, 102.32939910889, -1311.2535400391, 1019.9342041016, 80.008575439453},
	{-2662.2238769531, 2242.8115234375, 89.52938079834, -2584.8740234375, 2297.583984375, 57.639293670654},
} 

local antisaveTimers = {}
local loggingIn = {}


-- Check if there is not already a player ingame with the same serial
addEventHandler("onPlayerConnect", root,
	function (playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
		for k, thePlayer in pairs(getElementsByType("player")) do
			if (getPlayerSerial(thePlayer) == playerSerial) then
				cancelEvent(true, "There is already a player online with this serial!")
				return
			end
		end
	end
)


function startMatrix(player)
	if (getElementType(player) == "player") then
		if (exports.server:isPlayerLoggedIn(player) == false) then
			--fadeCamera(player, false, 1, 0, 0, 0)
			--setTimer(function () if (isElement(player)) then fadeCamera(player, true) end end, 1000, 1)
			fadeCamera(player, true)
			local x, y, z, lx, ly, lz = unpack(matrixViewPositions[math.random(#matrixViewPositions)])
			setCameraMatrix(player, x, y, z, lx, ly, lz)
		else
			return false
		end
	else
		return false
	end
end


-- When the player joins spawn him in-game
addEventHandler("onPlayerJoin", root,
	function ()

		spawnPlayer(source, 0, 0, 0)
		setCameraTarget(source)
		fadeCamera(source, true, 0)
		local x, y, z, lx, ly, lz = unpack(matrixViewPositions[math.random(#matrixViewPositions)])
		local cameraMatrix = setCameraMatrix(source, x, y, z, lx, ly, lz)
		--[[local cameraMartix = startMatrix(source)
		if not cameraMatrix then
			setCameraMatrix(source, 1323.96, -1281.04, 23.45, 1363.29, -1278.48, 23.45, 0, 88)
			exports.NGCdxmsg:createNewDxMessage(root, "Debug: couldn't set matrix", 255, 255, 255)
		end]]
		setPlayerHudComponentVisible(source, "radar", false)
		setPlayerHudComponentVisible(source, "area_name", false)
		setElementDimension(source, 1234)
		showChat(source, false)
	end
)

-- Kick the player when he has a too low resolution
--[[addEvent( "doKickPlayer", true )
addEventHandler( "doKickPlayer", root,
	function ()
		kickPlayer( source, "Connection refused due a too low screen resolution" )
	end
)]]--

-- When the player spawns check if we show the login screen or draw a ban window
addEvent( "doSpawnPlayer", true )
addEventHandler( "doSpawnPlayer", root,
	function ()
		if (type(getElementData(source, "playerAccount")) == "string") then 
			return
		end 
		local time = getRealTime()
		local banData = exports.DENmysql:querySingle( "SELECT * FROM bans WHERE serial=? LIMIT 1", getPlayerSerial( source ) )
		if ( banData ) then
			if ( time.timestamp > tonumber( banData.banstamp ) ) and not ( tonumber( banData.banstamp ) == 0 ) then
				local removeBanData = exports.DENmysql:exec( "DELETE FROM bans WHERE serial = ?", getPlayerSerial( source ) )
				triggerClientEvent( source, "setLoginWindowVisable", source )
			else
				setElementData( source, "Occupation", "Banned" )
				--kickPlayer(source,"Banned from the server")
				triggerClientEvent( source, "setLoginWindowVisable", source )
			end
		else
			triggerClientEvent( source, "setLoginWindowVisable", source )
		end
	end
)

-- Timestap convert
function timestampConvert ( timeStamp )
	local time = getRealTime(timeStamp)

	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute

	return "" .. hour ..":" .. minute .." - " .. month .."/" .. day .."/" .. year ..""
end

-- When the player creates a new account
addEvent( "doAccountRegister", true )
addEventHandler( "doAccountRegister", root,
	function ( username, password1, password2, email, genderMale, genderFemale )
		if not (exports.DENmysql:getConnection()) then
			triggerClientEvent(source,"setWarningLabelText",source, "error", "Network Down", "Server network is down! Please try again later.")
			return false
		end

		if ( exports.DENmysql:querySingle( "SELECT username FROM accounts WHERE username=? LIMIT 1", string.lower( username ) ) ) then
			triggerClientEvent( source, "setWarningLabelText", source, "error", "Username Already Taken", "This username is already taken!")
		elseif ( #exports.DENmysql:query( "SELECT * FROM accounts WHERE serial = ?", getPlayerSerial( source ) ) >= 5 ) then
			triggerClientEvent( source, "setWarningLabelText", source, "error", "Serial Limit", "You can only register 5 accounts for each serial!")
		else
			if ( genderFemale ) then theGender = 93 else theGender = 0 end
			if ( exports.DENmysql:exec( "INSERT INTO accounts SET username=?, password=?, email=?, serial=?, skin=?", string.lower( username ), sha256( password1 ), email, getPlayerSerial( source ), theGender ) ) then
				local userData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", string.lower( username ), sha256( password1 ) )
				exports.DENmysql:exec("INSERT INTO weapons SET userid=?", tonumber( userData.id ) )
				exports.DENmysql:exec("INSERT INTO playerstats SET userid=?", tonumber( userData.id ) )
				triggerClientEvent( source, "setWarningLabelText", source, "success", "Registration Completed", "Your account is now registered! Please go back to the login panel to login.")
			end
		end
	end
)

-- When the player password changed
function onPasswordRequestCallback ()
	-- callBack functie after password is changed nothing important though
end

local iamHere = {}
-- When the player send the login forum
function doPlayerLogin (username, password, usernameTick, passwordTick)
	if not (exports.DENmysql:getConnection()) then
		triggerClientEvent(source,"setWarningLabelText",source, "error", "Network Down", "Server network is down! Please try again later.")
		return false
	end


	if ( exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", string.lower( username ), hash( "sha512", password ):lower() ) ) then
		-- If the password is a MD5 password from the old system then force the player to change it
		triggerClientEvent( source, "setWarningLabelText", source, "error", "Account Error", "Unable to login, please change password first!")
	elseif ( exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", string.lower( username ), sha256( password ) ) ) then
		-- If the password is correct and a sha256 password then log the player in
		--exports.irc:outputIRC(tostring(loggingIn[username]))
		if (not loggingIn[username] or getTickCount()-loggingIn[username] >= 10000) then
			loggingIn[username] = getTickCount() --set this true to prevent it from logging in again
			--exports.irc:outputIRC(username.." login stored.")
		else
			--exports.irc:outputIRC(username.." was refused login since he spammed the shit out of login.")
			return false
		end

		local banData = exports.DENmysql:querySingle( "SELECT * FROM bans WHERE account=? LIMIT 1", string.lower( username ) )
		if ( banData ) then
			if ( banData.banstamp == 0 ) then
				--triggerClientEvent( source, "setWarningLabelText", source, "This account is Permanently Banned from the server!", "loginWindow", 225, 0, 0 )
			elseif ( getRealTime().timestamp < banData.banstamp ) then
				--triggerClientEvent( source, "setWarningLabelText", source, "This account is banned from the server till: "..timestampConvert( banData.banstamp ), "loginWindow", 225, 0, 0 )
			elseif ( banData.banstamp > 0 ) and ( getRealTime().timestamp > banData.banstamp ) and ( exports.DENmysql:exec( "DELETE FROM bans WHERE account=?", string.lower( username ) ) ) then
				triggerClientEvent( source, "setWarningLabelText", source, "success", "Account Unban", "Your account is now unbanned! Try to login now.")
			end
		end 
		local accountData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username=? AND password=? LIMIT 1", string.lower( username ), sha256( password ) )
		local groupData = exports.DENmysql:querySingle( "SELECT * FROM groups_members WHERE memberid=? LIMIT 1", accountData.id )

		for k,v in ipairs(getElementsByType("player")) do
			if (getElementData(v,"accountUserID") == accountData.id and v ~= source) then
				--kickPlayer(v,"Accounts",getPlayerName(source).." has logged into your account.")
				exports.NGCdxmsg:createNewDxMessage(source,"This account is already online!",255,0,0)
				cancelEvent(true,"Unable to login")
				return
				false
			end
		end
		if iamHere[source] == true then
			exports.NGCdxmsg:createNewDxMessage(source,"Logging into game server",255,0,0)
		return false end
		iamHere[source] = true
		removeElementData( source, "temp:UsernameData" ) removeElementData( source, "temp:PasswordData" )

		triggerClientEvent ( source, "updateAccountXMLData", source, username, password, usernameTick, passwordTick )

		exports.DENmysql:exec( "INSERT INTO logins SET serial=?, ip=?, nickname=?, accountname=?", getPlayerSerial( source ), getPlayerIP ( source ), getPlayerName( source ), username )
		exports.DENmysql:exec( "UPDATE accounts SET serial=?,IP=? WHERE id=?", getPlayerSerial( source ), getPlayerIP( source ), accountData.id )
		
		if ( banData ) then
			setPlayerTeam ( source, getTeamFromName("Criminals") )
		else 
			setPlayerTeam ( source, getTeamFromName(accountData.team) )
		end 

		setElementData( source, "isThisMe",false)
		setElementData( source, "playTime", accountData.playtime )
		setElementData( source, "APS", accountData.APS )
		setElementData( source, "accountUserID", accountData.id )
		setElementData( source, "tempdata.accountUserID", accountData.id )
		if ( banData ) then
				setElementData( source, "Occupation", "Player Banned" )
			else 
				setElementData( source, "Occupation", accountData.occupation )
		end 
		setElementData( source, "playerAccount", accountData.username )
		setElementData( source, "playerEmail", accountData.email )
		setElementData( source, "playerIP", getPlayerIP ( source ) )
		setElementData( source, "joinTick", getTickCount() )
		setElementData( source, "playerScore",accountData.score)

		setElementData( source, "carLicence", true )
		setElementData( source, "planeLicence", true )
		setElementData( source, "bikeLicence", true )
		setElementData( source, "chopperLicence", true )
		setElementData( source, "boatLicence", true )
		if ( groupData ) then
			setElementData( source, "Group", groupData.groupname )
			setElementData( source, "GroupRank", groupData.grouprank )
			setElementData( source, "GroupID", tonumber(groupData.groupid) )
		end

		if ( tonumber(accountData.VIP) < 1 ) then
			setElementData( source, "isPlayerVIP", false )
			setElementData( source, "VIP", "No" )
			setElementData(source,"VIPType",accountData.VIPType)
		else
			setElementData( source, "isPlayerVIP", true )
			setElementData( source, "VIP", "Yes" )
			setElementData(source,"VIPType",accountData.VIPType)
		end

		triggerClientEvent( source, "setAllWindowsHided", source )
		triggerClientEvent( source, "clientPlayerLogin", source, accountData.id, username )

		--fadeCamera( source, false, 1.0, 0, 0, 0 )
		--setTimer( fadeCamera, 2000, 1, source, true, 1.0, 0, 0, 0 )
		setTimer( createPlayerElementIntoGame, 1000, 1, source, accountData )
		antisaveTimers[source] = setTimer(allowSaving,10000,1,source)

		triggerEvent( "onPlayerLogin", source )
		loggingIn[username] = nil
	else
		-- If the password is wrong
		triggerClientEvent( source, "setWarningLabelText", source, "warning", "Wrong Details", "Wrong username and/or password!")
	end
end

addEvent( "doPlayerLogin", true )
addEventHandler( "doPlayerLogin", root, doPlayerLogin)

function allowSaving(player)
	if (isElement(player)) then
		if (antisaveTimers[source]) then
			antisaveTimers[source] = nil
		end
	end
end

-- Change password
addEvent( "onPlayerUpdatePasswords", true )
addEventHandler( "onPlayerUpdatePasswords", root,
	function ( password )
		if ( getElementData( source, "temp:UsernameData" ) ) then
			if ( exports.DENmysql:exec( "UPDATE accounts SET password=? WHERE username=?", sha256( password ), getElementData( source, "temp:UsernameData" ) ) ) then
				triggerClientEvent ( source, "setLoginWindowVisable", source )
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "Your password is changed!", 0, 225, 0 )
			else
				triggerClientEvent ( source, "setLoginWindowVisable", source )
				exports.NGCdxmsg:createNewDxMessage( thePlayer, "We couldn't change your password try again!", 225, 0, 0 )
			end
		else
			triggerClientEvent ( source, "setLoginWindowVisable", source )
			exports.NGCdxmsg:createNewDxMessage( thePlayer, "We couldn't change your password try again!", 225, 0, 0 )
		end
	end
)
local holdOn = {}
-- Spawn the player into the world
function createPlayerElementIntoGame ( thePlayer, dataTable )
	if ( exports.server:isPlayerLoggedIn( thePlayer ) ) then
		local playerID = exports.server:getPlayerAccountID( thePlayer )

		exports.NGCdxmsg:createNewDxMessage( thePlayer, "Welcome back to AuroraRPG, " .. getPlayerName( thePlayer ) .. "!", 238, 154, 0 )
           --redirectPlayer(thePlayer, "5.196.10.31" , 22003 )
		setCameraTarget( thePlayer, thePlayer )
		showChat( thePlayer, true )
		setPlayerHudComponentVisible ( thePlayer, "radar", true )
		setPlayerHudComponentVisible ( thePlayer, "area_name", true )

		if ( dataTable.team == "Criminals" ) or ( dataTable.team == "Unemployed" ) or ( dataTable.team == "Unoccupied" ) then
			spawnPlayer( thePlayer, dataTable.x, dataTable.y, dataTable.z +1, dataTable.rotation, dataTable.skin, dataTable.interior, dataTable.dimension)
			setPlayerTeam(thePlayer,getTeamFromName(tostring(dataTable.team)))
			setElementData(thePlayer,"Occupation",dataTable.occupation)
		else
			spawnPlayer( thePlayer, dataTable.x, dataTable.y, dataTable.z +1, dataTable.rotation, dataTable.jobskin, dataTable.interior, dataTable.dimension)
			setPlayerTeam(thePlayer,getTeamFromName(tostring(dataTable.team)))
			setElementData(thePlayer,"Occupation",dataTable.occupation)
		end

		local CJCLOTTable = fromJSON( tostring( dataTable.cjskin ) )
		if CJCLOTTable then
			for theType, index in pairs( CJCLOTTable ) do
				local texture, model = getClothesByTypeIndex ( theType, index )
				addPedClothes ( thePlayer, texture, model, theType )
			end
		end

		local weapons = fromJSON( dataTable.weapons )
		if ( weapons ) then
			for weapon, ammo in pairs( weapons ) do
				if not ( tonumber(weapon) == 37 ) and not ( tonumber(weapon) == 18 ) then
					giveWeapon( thePlayer, tonumber(weapon), tonumber(ammo) )
				end
			end
		end

		local playerStatus = exports.DENmysql:querySingle( "SELECT * FROM playerstats WHERE userid=?", playerID )
		if ( playerStatus ) then
			local wepSkills = fromJSON( playerStatus.weaponskills )
			if ( wepSkills ) then
				for skillint, valueint in pairs( wepSkills ) do
					if ( tonumber(valueint) > 950 ) then
						setPedStat ( thePlayer, tonumber(skillint), 995 )
					else
						setPedStat ( thePlayer, tonumber(skillint), tonumber(valueint) )
					end
				end
			end
		end

		if ( dataTable.health == 0 ) then
			killPed( thePlayer )
		else
			setElementHealth( thePlayer, tonumber( dataTable.health ) )
		end

		exports.DENmysql:exec( "UPDATE groups_members SET lastonline=? WHERE memberid=?", getRealTime().timestamp, playerID )

		setPedArmor( thePlayer, tonumber( dataTable.armor ) )
		setPlayerMoney( thePlayer, tonumber( dataTable.money ) )
		setPedFightingStyle ( thePlayer, tonumber( dataTable.fightstyle ) )

		setElementData ( thePlayer, "isPlayerLoggedin", true )
		setElementData ( thePlayer, "wantedPoints", tonumber( dataTable.wanted ) )

		local jailData = exports.DENmysql:querySingle("SELECT * FROM jail WHERE userid=?",dataTable.id)
		if (jailData) then
			triggerClientEvent( thePlayer, "onSetPlayerJailed", thePlayer, jailData.jailtime )
		end

		triggerEvent ( "onServerPlayerLogin", thePlayer, playerID, dataTable.username )
	    exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer )
		if isTimer(holdOn[thePlayer]) then return false end
		holdOn[thePlayer] = setTimer(function(plr)
			iamHere[plr] = false
		end,15000,1,thePlayer)
	end
end

function isAllowedToSave(player)
	if (isTimer(antisaveTimers[player])) then
		return false
	else
		return true
	end
end


addEventHandler("onPlayerCommand",root,
    function(command)
	if (type(getElementData(source, "playerAccount")) ~= "string") then 
	    cancelEvent()
	end
end)