-- Some drawing things
local screenX, screenY = guiGetScreenSize()
local scaleMain = 2
local scaleGeneral = 1.5
local startX, startY = 80.0, 98.0
local sizeHeight = 150

if ( screenX == 1024 ) then
	scaleMain = 1.5
	scaleGeneral = 1
	sizeHeight = 125
elseif ( screenX == 800 ) then
	scaleMain = 1.5
	scaleGeneral = 1
	sizeHeight = 100
	startY = 98
elseif ( screenX == 600 ) then
	scaleMain = 1.1
	scaleGeneral = 0.8
	sizeHeight = 70
end

-- When the player pressed login
function onClientPlayerLogin (username, password, usernameTick, passwordTick)
	if ( username:match( "^%s*$" ) ) then
		setWarningLabelText ( "error", "Empty Field", "The username field is empty!")
	elseif ( password:match( "^%s*$" ) ) then
		setWarningLabelText ( "error", "Empty Field", "The password field is empty!")
	else
		setWarningLabelText ( "info", "Attempting", "Attempting to login..." )
		triggerServerEvent( "doPlayerLogin", localPlayer, username, password, usernameTick, passwordTick )
	end
end

-- When the player pressed register
function onClientPlayerRegister (username, password1, password2, email, genderMale, genderFemale)
	if ( username:match( "^%s*$" ) ) then
		setWarningLabelText ( "error", "Empty Field", "The username field is empty!")
	elseif ( password1:match( "^%s*$" ) ) or ( password2:match( "^%s*$" ) ) then
		setWarningLabelText ( "error", "Empty Field", "The password field is empty!")
	elseif ( password1 ~= password2 ) then
		setWarningLabelText ( "error", "Match Field", "The passwords don't match!")
	elseif ( string.len( password1 ) < 8 ) then
		setWarningLabelText ( "error", "Password", "Your password is too short!")
	elseif not ( genderMale ) and not ( genderFemale ) then
		setWarningLabelText ( "error", "Gender", "You didn't select a gender!")
	elseif ( ( string.match( email, "^.+@.+%.%a%a%a*%.*%a*%a*%a*") ) ) then
		setWarningLabelText ( "info", "Account System", "Creating a new account...")
		triggerServerEvent( "doAccountRegister", localPlayer, username, password1, password2, email, genderMale, genderFemale )
	else
		setWarningLabelText ( "error", "Email Address", "You didnt enter a vaild email adress!")
	end
end

-- Convert a timeStamp to a date
function timestampConvert (timeStamp)
	local time = getRealTime(timeStamp)
	local year = time.year + 1900
	local month = time.month + 1
	local day = time.monthday
	local hour = time.hour
	local minute = time.minute

	return "" .. hour ..":" .. minute .." - " .. month .."/" .. day .."/" .. year ..""
end

-- Show the ban screen when trigger serverside
addEvent( "drawClientBanScreen", true )
addEventHandler( "drawClientBanScreen", root,
	function ( banSerial, banReason, banBantime, bannedby )
		TheBanSerial = banSerial
		TheBanReason = banReason
		TheBanBantime = timestampConvert( banBantime )
		TheBanBanner = bannedby
		addEventHandler("onClientRender", root, drawBanScreen )
		--toggleAllControls(source,false,false,false,false)
	end
)

-- Draw the ban screen window
function drawBanScreen ()
	dxDrawText("This serial is banned from the server!",startX, startY,796.0,157,tocolor(200,0,0,230),scaleMain,"pricedown","left","top",false,false,false)
	dxDrawText("Reason: "..TheBanReason,startX,startY+(sizeHeight*1)+15,796.0,sizeHeight,tocolor(238,118,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	if(banBantime ~= 0) then
		dxDrawText("Banned till: "..TheBanBantime,startX,startY+(sizeHeight*2)+5,796.0,sizeHeight,tocolor(238,118,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	else
		dxDrawText("Permanently Banned",startX,startY+(sizeHeight*2)+5,796.0,sizeHeight,tocolor(238,118,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	end
	dxDrawText("Banned By: "..TheBanBanner ,startX,startY+(sizeHeight*3)+5,796.0,sizeHeight,tocolor(0,120,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
	dxDrawText("Serial: "..TheBanSerial,startX,startY+(sizeHeight*4)+5,796.0,sizeHeight,tocolor(0,120,0,230),scaleGeneral,"pricedown","left","top",false,false,false)
end

-- Event when the client player logged in
addEvent( "clientPlayerLogin", true )
addEventHandler( "clientPlayerLogin", root,
	function ( userid, username )
		triggerEvent( "onSetPlayerSettings", root, source )
		triggerEvent( "onClientPlayerLogin", root, source, userid, username )
	end
)

-- When the player login set playtime
addEvent( "onClientPlayerLogin" )
addEventHandler( "onClientPlayerLogin", localPlayer,
	function ()
		if ( getElementData ( localPlayer, "playTime" ) ) then
			local theTime = ( getElementData ( localPlayer, "playTime" ) )
			setElementData( localPlayer, "Play Time", math.floor( theTime / 60 ).." Hours" )
		else
			setElementData( localPlayer, "playTime", 0 )
			setElementData( localPlayer, "Play Time", 0 )
		end
	end
)

