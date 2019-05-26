-- set player database position
function updatePlayerDatabasePosition ( thePlayer, x, y, z, int, dimension )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if x and y and z then
			local updatePosition = exports.DENmysql:exec( "UPDATE accounts SET x=?, y=?, z=? WHERE id=?", x, y, z, userID  )
			if ( updatePosition ) then
				if ( int ) and tostring(int):match("^%s*$") then
					local updateInt = exports.DENmysql:exec( "UPDATE accounts SET interior=? WHERE id=?", tonumber(int), userID  )
				end
				if ( dimension ) and tostring(dimension):match("^%s*$") then
					local updateDim = exports.DENmysql:exec( "UPDATE accounts SET dimension=? WHERE id=?", tonumber(dimension), userID  )
				end
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

-- Check if the player is loggedin
function isPlayerLoggedIn ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local username = getElementData( thePlayer, "playerAccount" )
		if ( username ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get the player his account id
function getPlayerAccountId ( thePlayer )
	outputDebugString ( "This export 'getPlayerAccountId' should be replaced with 'getPlayerAccountID'!", 3 )
	return getPlayerAccountID ( thePlayer )
end

-- Function for the old server ID exported function
function playerID ( thePlayer )
	outputDebugString ( "This export 'playerID' should be replaced with 'getPlayerAccountID'!", 3 )
	return getPlayerAccountID ( thePlayer )
end

-- New function, all exports should move to this one
function getPlayerAccountID ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if ( userID ) then
			return tonumber(userID)
		else
			return false
		end
	else
		return false
	end
end

-- Set player interior
addEvent( "setServerPlayerInterior", true )
addEventHandler( "setServerPlayerInterior", root,
	function ( theInterior )
		local x, y, z = getElementPosition( source )
		setElementInterior( source, theInterior, x, y, z )
	end
)

-- Set player interior
addEvent( "setServerPlayerDimension", true )
addEventHandler( "setServerPlayerDimension", root,
	function ( theDimension )
		setElementDimension( source, theDimension )
	end
)

-- Get the player his groupID
function getPlayerGroupID ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local groupID = getElementData( thePlayer, "GroupID" )
		if ( groupID ) then
			return groupID
		else
			return false
		end
	else
		return false
	end
end

-- Get the player his account name
function getPlayerAccountName ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local username = getElementData( thePlayer, "playerAccount" )
		if ( username ) then
			return tostring(username)
		else
			return false
		end
	else
		return false
	end
end

local emailSpam = {}

-- Change the email of the player
function updatePlayerEmail ( thePlayer, theEmail, thePassword )
	if ( emailSpam[thePlayer] ) and ( getTickCount()-emailSpam[thePlayer] < 300000 ) then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Due spamming you need to wait 5 minutes to change your password again!", 225, 0, 0)
		return false
	elseif ( thePlayer ) and ( theEmail ) and ( thePassword ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local getUserData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", userID )
		if ( getUserData.password == string.lower( sha256(thePassword) ) ) or ( getUserData.password == sha256(thePassword) ) then
			if ( string.match(theEmail, "^.+@.+%.%a%a%a*%.*%a*%a*%a*") )then
				local updateEmail = exports.DENmysql:exec( "UPDATE accounts SET email = ? WHERE id = ?", theEmail, userID )
				if ( updateEmail ) then
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "Your email is successfully changed!", 0, 225, 0)
					triggerClientEvent( thePlayer, "resetSettingsEditFields", thePlayer )
					emailSpam[thePlayer] = getTickCount()
					return true
				else
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "We couldn't change your email, try again!", 225, 0, 0)
					return false
				end
			else
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "You didn't enter a vaild email adress!", 225, 0, 0)
				return false
			end
		else
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "The password of your account isn't correct!", 225, 0, 0)
			return false
		end
	else
		return false
	end
end

local passwordSpam = {}

-- Change the password of the player
function updatePlayerPassword ( thePlayer, newPassword, newPassword2, oldPassword )
	if ( passwordSpam[thePlayer] ) and ( getTickCount()-passwordSpam[thePlayer] < 300000 ) then
		exports.NGCdxmsg:createNewDxMessage(thePlayer, "Due spamming you need to wait 5 minutes to change your email again!", 225, 0, 0)
		return false
	elseif ( thePlayer ) and ( newPassword ) and ( newPassword2 ) and ( oldPassword ) then
		if ( newPassword == newPassword2 ) then
			local userID = getElementData( thePlayer, "accountUserID" )
			local getUserData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id = ?", userID )
			if ( getUserData.password == string.lower( sha256(oldPassword) ) ) or ( getUserData.password == sha256(oldPassword) ) then
				if not ( string.match(newPassword, "^%s*$") ) and ( string.len( newPassword ) > 8 ) then
					if ( exports.DENmysql:exec( "UPDATE accounts SET password=? WHERE id = ?", sha256(newPassword), userID ) ) then
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "Your password is successfully changed!", 0, 225, 0)
						triggerClientEvent( thePlayer, "resetSettingsEditFields", thePlayer )
						passwordSpam[thePlayer] = getTickCount()
						return true
					else
						exports.NGCdxmsg:createNewDxMessage(thePlayer, "We couldn't change your password, try again!", 225, 0, 0)
						return false
					end
				else
					exports.NGCdxmsg:createNewDxMessage(thePlayer, "Your password contains illegal characters, is empty or to short!", 225, 0, 0)
					return false
				end
			else
				exports.NGCdxmsg:createNewDxMessage(thePlayer, "Your old password doesn't match!", 225, 0, 0)
				return false
			end
		else
			exports.NGCdxmsg:createNewDxMessage(thePlayer, "The passwords don't match!", 225, 0, 0)
			return false
		end
	else
		return true
	end
end

-- Get the playtime of the player
function getPlayerPlayTime ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local playtime = getElementData ( thePlayer, "playTime" )
		if ( playtime ) then
			return tonumber(playtime)
		else
			return false
		end
	else
		return false
	end
end

local cz = {
	["LS"] = {1484, -1401},
	["SF"] = {-2310, 402},
	["LV"] = {1797, 1713},
}
-- Get the zone of the user
function getPlayChatZone ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local theZone = calculatePlayerChatZone( thePlayer )
		if ( theZone ) then
			return tostring(theZone)
		else
			return false
		end
	else
		return false
	end
end

function calculatePlayerChatZone( thePlayer )
	--[[local x, y, z = getElementPosition(thePlayer)
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
	end]]

	local SX, SY, SZ = getElementPosition(thePlayer)
	local distanceLS = getDistanceBetweenPoints2D(SX, SY, cz["LS"][1], cz["LS"][2])
	local distanceSF = getDistanceBetweenPoints2D(SX, SY, cz["SF"][1], cz["SF"][2])
	local distanceLV = getDistanceBetweenPoints2D(SX, SY, cz["LV"][1], cz["LV"][2])
	if (distanceLS < distanceSF and distanceLS < distanceLV) then
		return "LS"
	elseif (distanceSF < distanceLS and distanceSF < distanceLV) then
		return "SF"
	else
		return "LV"
	end
end

-- Get the player his email
function getPlayerAccountEmail ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local theEmail = getElementData( thePlayer, "playerEmail" )
		if ( theEmail ) then
			return theEmail
		else
			return false
		end
	else
		return false
	end
end

-- Get player VIP hours
function getPlayerVIPHours ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if getElementData(thePlayer, "isPlayerVIP" ) then
			local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=?", userID )
			if ( playerData ) and ( playerData.VIP ) then
				return tonumber(playerData.VIP)
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

-- Get player premium hours
function getPlayerPremiumHours ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if getElementData(thePlayer, "isPlayerPremium" ) then
			local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=?", userID )
			if ( playerData ) and ( playerData.premium ) then
				return tonumber(playerData.premium)
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

-- Check if a player is VIP or not
function isPlayerVIP ( thePlayer )
	if ( isElement( thePlayer ) ) then
		if ( getElementData(thePlayer, "isPlayerVIP" ) ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Check if a player is premium or not
function isPlayerPremium ( thePlayer )
	if ( isElement( thePlayer ) ) then
		if ( getElementData(thePlayer, "isPlayerPremium" ) ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get player vehicles (returns table)
function getPlayerVehicles ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local playerVehicles = exports.DENmysql:query( "SELECT * FROM vehicles WHERE ownerid = ?", userID )
		if playerVehicles and #playerVehicles > 0 then
			return playerVehicles
		else
			return false
		end
	else
		return false
	end
end

-- Get player group name
function getPlayerGroupName ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local playerGroup = getElementData( thePlayer, "Group" )
		if ( playerGroup ) then
			return tostring(playerGroup)
		else
			return false
		end
	else
		return false
	end
end

-- Get player bank money
function getPlayerBankBalance ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local accountBalance = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", userID )
		if ( accountBalance ) then
			return tonumber(accountBalance.balance)
		else
			return false
		end
	else
		return false
	end
end

-- Give player bank money
function givePlayerBankMoney ( thePlayer, money )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if tostring(money):match("^%s*$") and not ( userID) then
			return false
		else
			if string.match(tostring(money),'^%d+$') then
			local bankMoney = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", userID )
				if ( bankMoney ) then
					local bankBalance = (tonumber(bankMoney.balance) + tonumber(money))
					local updateBank = exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", bankBalance, userID )
					if ( updateBank ) then
						return true
					else
						return false
					end
				else
					return false
				end
			else
				return false
			end
		end
	else
		return false
	end
end

-- Take player bank money
function takePlayerBankMoney ( thePlayer, money)
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		if tostring(money):match("^%s*$") and not ( userID) then
			return false
		else
			if string.match(tostring(money),'^%d+$') then
			local bankMoney = exports.DENmysql:querySingle( "SELECT * FROM banking WHERE userid = ?", userID )
				if ( bankMoney ) then
					local bankBalance = (tonumber(bankMoney.balance) - tonumber(money))
					local updateBank = exports.DENmysql:exec( "UPDATE banking SET balance = ? WHERE userid = ?", bankBalance, userID)
					if ( updateBank ) then
						return true
					else
						return false
					end
				else
					return false
				end
			else
				return false
			end
		end
	else
		return false
	end
end

-- Does player have a creditcard
function doesPlayerHaveCreditcard ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local getCreditcard = getElementData( thePlayer, "creditcard" )
		if ( tonumber(getCreditcard) == 1 ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get player bank transactions (return a table)
function getGroupColor ( groupName )
	if ( groupName ) then
		local groupTable = exports.DENmysql:querySingle( "SELECT * FROM groups WHERE groupname = ?", groupName )
		if ( groupTable ) then
			return groupTable.turfcolor
		else
			return false
		end
	else
		return false
	end
end

-- Get player bank transactions (return a table)
function getPlayerBankTransactions ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local userID = getElementData( thePlayer, "accountUserID" )
		local playerTransactions = exports.DENmysql:query( "SELECT * FROM banking_transactions WHERE userid = ?", userID )
		if playerTransactions and #playerTransactions > 0 then
			return playerTransactions
		else
			return false
		end
	else
		return false
	end
end

function updatePlayerJobSkin(plr, skin)
	if (not isElement(plr)) then
		return false
	end
	local id = getElementData(plr, "accountUserID")
	exports.DENmysql:exec("UPDATE `accounts` SET `jobskin` =? WHERE `id` =?", skin, id)
	return true
end

-- Get player occupation
function getPlayerOccupation ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local playerOccupation = getElementData(thePlayer, "Occupation")
		if ( playerOccupation ) then
			return tostring(playerOccupation)
		else
			return false
		end
	else
		return false
	end
end

function isPlayerArrested ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local getArrestStatus = getElementData(thePlayer, "isPlayerArrested")
		if ( getArrestStatus ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get the player his wanted points
function getPlayerWantedPoints ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local wantedPoints = getElementData( thePlayer, "wantedPoints" )
		if ( wantedPoints ) then
			return tonumber(wantedPoints)
		else
			return false
		end
	else
		return false
	end
end

-- Set the player his wanted points
function setPlayerWantedPoints ( thePlayer, points )
	if ( isElement( thePlayer ) ) then
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( points ) )
		if ( setWantedPoints ) and ( points ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Get the player his wanted points
function givePlayerWantedPoints ( thePlayer, points )
	if ( isElement( thePlayer ) ) then
		local wantedPoints = getElementData( thePlayer, "wantedPoints" )
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( ( wantedPoints + points ) ) )
		if ( setWantedPoints ) and ( points ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Remove the player his wanted points
function removePlayerWantedPoints ( thePlayer, points )
	if ( isElement( thePlayer ) ) then
		local wantedPoints = getElementData( thePlayer, "wantedPoints" )
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", tonumber( ( wantedPoints - points ) ) )
		if ( setWantedPoints ) and ( points ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Remove all the wanted points off the player
function removeAllPlayerWantedPoints ( thePlayer )
	if ( isElement( thePlayer ) ) then
		local setWantedPoints = setElementData( thePlayer, "wantedPoints", 0 )
		if ( setWantedPoints ) then
			return true
		else
			return false
		end
	else
		return false
	end
end

-- Convert numbers into a number with commas
function convertNumber ( theNumber )
	if ( theNumber ) then
		local convertedNumber = cvtNumber( theNumber )
		if ( convertedNumber ) then
			return tostring(convertedNumber)
		else
			return false
		end
	end
end

function cvtNumber( theNumber )
	local formatted = theNumber
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
	if (k==0) then
		break
		end
	end
	return formatted
end

-- Get player from name part
function getPlayerFromNamePart( namePart )
local result = false
    if namePart then
        for i, player in ipairs(getElementsByType("player")) do
            if string.find(getPlayerName(player):lower(), tostring(namePart):lower(), 1, true) then
				if result then return false end
					result = player
				end
			end
		end
    return result
end

-- Convert RGB to HEX
function convertRGBToHEX(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

-- Add vehicle into vehicle system and database
function addPlayerVehicle ( thePlayer, vehicleID, ownerID, vehicleHealth, boughtPrice, color1, color2, x, y, z, rotation )
	if ( thePlayer) and ( vehicleID ) and ( ownerID ) and ( vehicleHealth ) and ( boughtPrice ) and ( color1 ) and ( x ) and ( y ) and ( z ) and  ( rotation ) then
		local createVehicle = exports.DENmysql:exec("INSERT INTO vehicles SET vehicleid=?, ownerid=?, vehiclehealth=?, boughtprice=?, color1=?, color2=?, x=?, y=?, z=?, rotation=?"
			,vehicleID
			,ownerID
			,vehicleHealth
			,boughtPrice
			,color1
			,color2
			,x
			,y
			,z
			,rotation)
		if ( createVehicle ) then
			local getVehicleTheID = exports.DENmysql:querySingle( "SELECT * FROM vehicles WHERE color1 = ? AND color2 = ? AND ownerid = ?", color1, color2, ownerID)
			if ( getVehicleTheID ) then
				local addVehicleIntoVehicleSystem = exports.DENvehicles:onPlayerBoughtVehicle( thePlayer, vehicleID, x, y, z, rotation, getVehicleTheID.uniqueid, color1, color2 )
				if ( addVehicleIntoVehicleSystem ) then
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

-- Clean chat message from badwords
swearWords = {
}

function cleanStringFromBadWords ( message )
	if message:match("^%s*$") then
		return false
	else
		local new = ""
		local messageNonFilterd = message
		local iter = 0
		for word in message:gmatch("%S+") do
			iter = iter + 1
			for i,swr in ipairs(swearWords) do
				local src = word:lower():gsub("%s","")
				local src = src:gsub("#%x%x%x%x%x%x","")
				local src = src:gsub("%c","")
				local src = src:gsub("%p","")
				local pat = swr:lower():gsub("%s","")
				if src:find(pat) then
					local replaceString = ""
					for x=1,word:gsub("#%x%x%x%x%x%x",""):len() do
						replaceString = replaceString.."*"
					end
					word = word:gsub(word,replaceString)
				end
			end
			if iter == 1 and word:len() > 2 then
				word = word:gsub("%a",string.upper,1)
			end
			new = new..word.." "
		end
		if new ~= "" then message = new end
		return message, messageNonFilterd
	end
end

-- String explode
function stringExplode(self, separator)
    Check("stringExplode", "string", self, "ensemble", "string", separator, "separator")

    if (#self == 0) then return {} end
    if (#separator == 0) then return { self } end

    return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end

function Check(funcname, ...)
    local arg = {...}

    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end

    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end

        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

function getPlayerGroup(player)
	if (isElement(player)) then
		if (exports.server:isPlayerLoggedIn(player) == true) then
			local group = getElementData(player,"Group")
			if group then
				return group --should be string
			else
				return false
			end
		else
			return false
		end
	end
end

function getPlayerGroupRank(player)
	if (isElement(player)) then
		if (exports.server:isPlayerLoggedIn(player) == true) then
			if (getPlayerGroup(player)) then
				local rank = getElementData(player,"GroupRank")
				if rank then
					return rank
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function getPlayerFPS(player)
	if (isElement(player)) then
		return getElementData(player,"FPS")
	else
		return false
	end
end

function isPlayerJailed(player)
	if (isElement(player)) then
		return getElementData(player,"isPlayerJailed")
	else
		return false
	end
end

-- isPlayerDamaged in 10 seconds
local abusers = {}

addEventHandler("onPlayerDamage", root,
    function(attacker)
        if attacker then
            if isTimer(abusers[source]) then
                killTimer(abusers[source])
            end
            abusers[source] = setTimer(
                function(abuser)
                    abusers[abuser] = nil
                end, 10000, 1, source
            )
        end
    end
)

function isPlayerDamaged(player)
    return abusers[player] and isTimer(abusers[player]) or false
end

addEventHandler( "onPlayerWasted", getRootElement( ),
	function()
		if source and isTimer(abuseTimer) then
			killTimer(abuseTimer)
	end
end
)
