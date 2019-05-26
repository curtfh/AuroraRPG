local weaponTable = { [22]=69, [23]=70, [24]=71, [25]=72, [26]=73, [27]=74, [28]=75, [29]=76, [32]=75, [30]=77, [31]=78, [34]=79, [33]=79 }

addEvent("satchelWeapon",true)
addEventHandler("satchelWeapon", root,
function()
	takeWeapon(source,40)
end)

local abuseRPG = {}
local abuseNade = {}

addEvent("setNadePos",true)
addEventHandler("setNadePos", root,function(id)
	setElementPosition(id,0,0,50000)
end)

addEvent("setWeaponAbuse",true)
addEventHandler("setWeaponAbuse", root,function(id)
	if id == 35 or id == 36 then
		if isTimer(abuseRPG[source]) then return false end
		setElementData(source,"isRPGTimer",true)
		abuseRPG[source] = setTimer(function(player)
			setElementData(player,"isRPGTimer",false)
		end,5000,1,source)
	else
		if isTimer(abuseNade[source]) then return false end
		setElementData(source,"isNadeTimer",true)
		outputDebugString("Added anti nade for "..getPlayerName(source))
		abuseNade[source] = setTimer(function(player)
			setElementData(player,"isNadeTimer",false)
			outputDebugString("remove anti nade for "..getPlayerName(player))
		end,5000,1,source)
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		setElementData(v,"isRPGTimer",false)
		setElementData(v,"isNadeTimer",false)
	end
end)

addEvent("givePlayerRefundRPG",true)
addEventHandler("givePlayerRefundRPG", root,
function()
	if getPlayerPing(source) >= 600 then exports.NGCdxmsg:createNewDxMessage(source,"We can't refund lagger player",255,0,0) return false end
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		giveWeapon ( source,35, 1, true )
		exports.CSGaccounts:forceWeaponSync(source)
		exports.NGCdxmsg:createNewDxMessage(source,"[Anti spam RPG] : +1 ammo for RPG",255,255,0)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"We can't refund lagger player Reason : "..msg,255,0,0)
	end
end)

addEvent("givePlayerRefundNade",true)
addEventHandler("givePlayerRefundNade", root,
function(theType)
	if getPlayerPing(source) >= 600 then exports.NGCdxmsg:createNewDxMessage(source,"We can't refund lagger player",255,0,0) return false end
	local can,msg = exports.NGCmanagement:isPlayerLagging(source)
	if can then
		giveWeapon ( source,theType, 1, true )
		exports.CSGaccounts:forceWeaponSync(source)
		exports.NGCdxmsg:createNewDxMessage(source,"[Anti spam RPG] : +1 ammo for Nades",255,255,0)
	else
		exports.NGCdxmsg:createNewDxMessage(source,"We can't refund lagger player Reason : "..msg,255,0,0)
	end
end)



addEvent("takePlayerTrainingMoney",true)
addEventHandler("takePlayerTrainingMoney", root,
function()
	if ( source ) then
		exports.NGCmanagement:RPM( source, 250 )
	end
end
)

local addition = 50*10 -- percent * 10

--[[addEvent("onFinishWeaponTraining",true)
addEventHandler("onFinishWeaponTraining", root,
function( theWeapon )
	if ( source ) and ( theWeapon ) then
		if ( getPedStat ( source, weaponTable[tonumber(theWeapon)] ) <= 1000-addition ) then
			if ( tonumber(theWeapon) == 26 ) and ( getPedStat ( source, weaponTable[tonumber(theWeapon)] ) +addition >= 1000 ) then
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), 1000 )
			else
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), math.min(1000, getPedStat ( source, weaponTable[tonumber(theWeapon)] ) +addition) )
			end
			exports.csgscore:givePlayerScore(source,1)
			--exports.NGCdxmsg:createNewDxMessage(source,"Earned +1 Score for Successfull weapons training!",0,255,0)
			exports.NGCnote:addNote("Weapons","Earned +1 Score for Successfull weapons training!",source,0,255,0,3000)
		elseif ( getPedStat ( source, weaponTable[tonumber(theWeapon)] ) +addition >= 1000 ) then
			if not ( tonumber(theWeapon) == 26 ) then
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), 1000 )
			else
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), 1000 )
			end
			exports.csgscore:givePlayerScore(source,1)
			--exports.NGCdxmsg:createNewDxMessage(source,"Earned +1 Score for Successfull weapons training!",0,255,0)
			exports.NGCnote:addNote("Weapons","Earned +1 Score for Successfull weapons training!",source,0,255,0,3000)
		end


	end
end
)]]--

setTimer(function()
	for i, thePlayer in ipairs (getElementsByType("player")) do
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(31), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(38), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(29), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(26), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(25), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(33), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(28), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(27), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(23), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(22), 1000 )
		onUpdatePlayerWeaponSkills ( thePlayer, tonumber(24), 1000 )
	end 
end, 10000, 0)

function getWeaponSkillsJSON( thePlayer )
	local weaponSkills = {}
	local vaildSkill = false

	for i=69,79 do
		local theSkill = getPedStat ( thePlayer, i )
		if ( theSkill ) then
			weaponSkills[i] = theSkill
			vaildSkill = true
		end
	end

	if ( vaildSkill ) then
		return toJSON( weaponSkills )
	else
		return nil
	end
end

function onUpdatePlayerWeaponSkills ( thePlayer, theWeapon, theLevel )
	theLevel = tonumber(theLevel)
	theWeapon = tonumber(theWeapon)
	local playerID = exports.server:getPlayerAccountID( thePlayer )
	local theStat = getPedStat ( thePlayer, theWeapon )
	if ( weaponTable[theWeapon] ) then
		if ( weaponTable[theWeapon] >= 69 ) or ( weaponTable[theWeapon] <= 79 ) then

			if theWeapon == 26 then
				if theLevel == 995 then
					theLevel = 1000
				end
			end
			if ( setPedStat( thePlayer, weaponTable[theWeapon], theLevel ) ) then
				local theSkills = getWeaponSkillsJSON( thePlayer )
				exports.DENstats:setPlayerAccountData ( thePlayer, "weaponskills", theSkills, true )
				--exports.NGCdxmsg:createNewDxMessage( thePlayer, getWeaponNameFromID ( theWeapon ).." weapon skill is now upgraded by "..(addition/10).."%!", 0, 225, 0 )
				return true
			end
		end
	end
end

-- Modifications to weapons

-- Explosives
setWeaponProperty( 39, "poor", "damage", 40 )
setWeaponProperty( 39, "std", "damage", 40 )
setWeaponProperty( 39, "pro", "damage", 40 )

setWeaponProperty( "grenade", "pro", "damage", 40 )
setWeaponProperty( "grenade", "std", "damage", 40 )
setWeaponProperty( "grenade", "poor", "damage", 40 )

--AK-47
setWeaponProperty(30, "poor", "damage",35)
setWeaponProperty(30, "std", "damage",35)
setWeaponProperty(30, "pro", "damage",35)
setWeaponProperty(30, "poor", "accuracy", 1.5)
setWeaponProperty(30, "std", "accuracy", 1.5)
setWeaponProperty(30, "pro", "accuracy", 1.5)
setWeaponProperty(30, "poor", "maximum_clip_ammo", 50)
setWeaponProperty(30, "std", "maximum_clip_ammo", 50)
setWeaponProperty(30, "pro", "maximum_clip_ammo", 50)
--M4
setWeaponProperty(31, "poor", "damage",24)
setWeaponProperty(31, "std", "damage",24)
setWeaponProperty(31, "pro", "damage",24)
setWeaponProperty(31, "poor", "accuracy", 1.5)
setWeaponProperty(31, "std", "accuracy", 1.5)
setWeaponProperty(31, "pro", "accuracy", 1.5) 
setWeaponProperty(31, "poor", "maximum_clip_ammo", 100)
setWeaponProperty(31, "std", "maximum_clip_ammo", 100)
setWeaponProperty(31, "pro", "maximum_clip_ammo", 100)
setWeaponProperty(31, "pro", "anim_loop_stop", 0.33)
--- Minigun
setWeaponProperty( 38, "poor", "damage", 1 )
setWeaponProperty( 38, "std", "damage", 1 )
setWeaponProperty( 38, "pro", "damage", 1 )

setWeaponProperty( 38, "poor", "maximum_clip_ammo", 500 )
setWeaponProperty( 38, "std", "maximum_clip_ammo", 500 )
setWeaponProperty( 38, "pro", "maximum_clip_ammo", 500 )

setWeaponProperty( 38, "poor", "accuracy", 5)
setWeaponProperty( 38, "std", "accuracy", 5)
setWeaponProperty( 38, "pro", "accuracy", 5)
--mp5
setWeaponProperty(29, "poor", "damage", 26 )
setWeaponProperty(29, "std", "damage", 26 )
setWeaponProperty(29, "pro", "damage", 26 )
setWeaponProperty(29, "poor", "accuracy", 3)
setWeaponProperty(29, "std", "accuracy", 3)
setWeaponProperty(29, "pro", "accuracy", 3)
setWeaponProperty(29, "poor", "maximum_clip_ammo", 40)
setWeaponProperty(29, "std", "maximum_clip_ammo", 40)
setWeaponProperty(29, "pro", "maximum_clip_ammo", 40)

--uzi
setWeaponProperty(28, "pro", "anim_loop_stop", 0.5)

--- sawn
setWeaponProperty(26, "poor", "damage",5)
setWeaponProperty(26, "std", "damage",5)
setWeaponProperty(26, "pro", "damage",5)
setWeaponProperty(26, "poor", "accuracy", 1.5)
setWeaponProperty(26, "std", "accuracy", 1.5)
setWeaponProperty(26, "pro", "accuracy", 1.5)
setWeaponProperty(26, "poor", "flag_type_dual", true)
setWeaponProperty(26, "std", "flag_type_dual", true)
setWeaponProperty(26, "pro", "flag_type_dual", true) 
setWeaponProperty(26, "poor", "flag_type_constant", false)
setWeaponProperty(26, "std", "flag_type_constant", false)
setWeaponProperty(26, "pro", "flag_type_constant", false) 
setWeaponProperty(26, "poor", "maximum_clip_ammo", 4)
setWeaponProperty(26, "std", "maximum_clip_ammo", 4)
setWeaponProperty(26, "pro", "maximum_clip_ammo", 4)
--combat shotgun
setWeaponProperty(27, "pro", "maximum_clip_ammo", 7)
setWeaponProperty(27, "pro", "damage", 15)
setWeaponProperty(27, "pro", "flag_type_dual", false) 
-- shot
setWeaponProperty(25, "poor", "maximum_clip_ammo", 1)
setWeaponProperty(25, "std", "maximum_clip_ammo", 1)
setWeaponProperty(25, "pro", "anim_loop_stop", 1)
--deagle
setWeaponProperty(24, "poor", "maximum_clip_ammo", 5)
setWeaponProperty(24, "std", "maximum_clip_ammo", 5)
setWeaponProperty(24, "pro", "maximum_clip_ammo", 5)
setWeaponProperty(24, "pro", "flag_type_dual", false) 

--rifle
setWeaponProperty( 33, "poor", "damage", 60 )
setWeaponProperty( 33, "std", "damage", 60 )
setWeaponProperty( 33, "pro", "damage", 60 )
setWeaponProperty( 33, "poor", "move_speed", 1.5 )
setWeaponProperty( 33, "std", "move_speed", 1.5 )
setWeaponProperty( 33, "pro", "move_speed", 1.5 ) 
setWeaponProperty(33, "poor", "maximum_clip_ammo", 3)
setWeaponProperty(33, "std", "maximum_clip_ammo", 3)
setWeaponProperty(33, "pro", "maximum_clip_ammo", 3)
setWeaponProperty(33, "pro", "anim_loop_stop", 0.5)
setWeaponProperty(33, "poor", "flag_move_and_shoot", true)
setWeaponProperty(33, "std", "flag_move_and_shoot", true)
setWeaponProperty(33, "pro", "flag_move_and_shoot", true)
setWeaponProperty(33, "pro", "flag_type_dual", false) 

--Disable CBUG
local glitches = {"quickreload","fastmove","fastfire","crouchbug","highcloserangedamage","hitanim","fastsprint","baddrivebyhitbox","quickstand"}

function enableGlitches ()
   for _,glitch in ipairs(glitches) do
      setGlitchEnabled (glitch, false)
   end 
end
addEventHandler ( "onResourceStart", getResourceRootElement ( ),enableGlitches)

-- Take
addCommandHandler("take",function(player,command,types)
	if types == "melee" then
		for i=1,9 do
			if i~= 3 then
				takeWeapon(player,i)
			end
		end
		exports.NGCdxmsg:createNewDxMessage(player,"You have successfully removed melee weapons from your weapon inventory",255,0,0)
	elseif types == "special" then
		for i=42,46 do
			takeWeapon(player,i)
		end
		exports.NGCdxmsg:createNewDxMessage(player,"You have successfully removed other/parachute from your weapon inventory",255,0,0)
	elseif types == "other" then
		for i=10,15 do
			if i ~= 13 then
				takeWeapon(player,i)
			end
		end
		exports.NGCdxmsg:createNewDxMessage(player,"You have successfully removed dildo/other types from your weapon inventory",255,0,0)
	end
end)

addCommandHandler("weapons",function(player,command)
	outputChatBox("Do /take melee for this weapon (Brass Knuckles,Golf Club,Knife,Baseball Bat,Shovel,Pool Cue,Katana)",player,255,255,0)
	outputChatBox("Do /take special for this weapon (Fire Extinguisher,Camera,Goggles,Parachute)",player,255,155,0)
	outputChatBox("Do /take other for this weapon (Dildo,Vibrator,Flowers,Cane)",player,255,55,0)
end)
