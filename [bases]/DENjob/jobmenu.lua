exports.DENsettings:addPlayerSetting("jobcalls", "true")

function createJobWindow()
	jobWindow = guiCreateWindow(289,332,269,204,"AUR ~ Job",false)
	jobLabel1 = guiCreateLabel(12,29,241,17,"Current occupation:",false,jobWindow)
	guiLabelSetHorizontalAlign(jobLabel1,"center",false)
	guiSetFont(jobLabel1,"default-bold-small")
	jobCheckBox = guiCreateCheckBox(21,72,239,29,"Accept service requests from users",false,false,jobWindow)
	guiCheckBoxSetSelected(jobCheckBox,true)
	guiSetFont(jobCheckBox,"default-bold-small")
	jobButton1 = guiCreateButton(9,112,251,38,"End shift",false,jobWindow)
	jobButton2 = guiCreateButton(9,156,251,38,"Quit job",false,jobWindow)
	jobLabel2 = guiCreateLabel(12,48,241,17,"Leading Staff",false,jobWindow)
	guiLabelSetColor(jobLabel2,238	,154	,0)
	guiLabelSetHorizontalAlign(jobLabel2,"center",false)
	guiSetFont(jobLabel2,"default-bold-small")

	guiWindowSetMovable (jobWindow, true)
	guiWindowSetSizable (jobWindow, false)
	guiSetVisible (jobWindow, false)

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(jobWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(jobWindow,x,y,false)

	addEventHandler("onClientGUIClick", jobButton1, onEndShift, false)
	addEventHandler("onClientGUIClick", jobButton2, onQuitJob, false)
	addEventHandler("onClientGUIClick", jobCheckBox, onCheckJobCheckboxClick, false)

end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		createJobWindow()
	end
)

function onCheckJobCheckboxClick ()
	exports.DENsettings:setPlayerSetting("jobcalls", tostring(guiCheckBoxGetSelected( jobCheckBox )) )
	setElementData( localPlayer, "doesWantJobCalls", guiCheckBoxGetSelected( jobCheckBox ) )
end

function showJobGUI ()
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) then
	if not (isPedOnGround(localPlayer)) then 
		if guiGetVisible(jobWindow) then
			guiSetVisible(jobWindow,false)
			showCursor(false)
		end 
		exports.NGCdxmsg:createNewDxMessage("You can't end shift here",255,0,0) 
		return false 
	end
		if not guiGetVisible(jobWindow) then
			guiSetVisible(jobWindow,true)
			showCursor(true)
			updateLabel ()
			-- Check the occupation and set the label status
			occupation = getElementData( localPlayer, "Occupation" )
			if occupation == "" then
				guiSetText(jobLabel2, "Unemployed")
			else
				guiSetText(jobLabel2, occupation)
			end
		else
			guiSetVisible(jobWindow,false)
			showCursor(false)
		end
	end
end
bindKey("F2","down",showJobGUI)

addEvent( "updateLabel", true )
function updateLabel ()

	-- Check the occupation and set the label status
	local occupation = getElementData( localPlayer, "Occupation" )
	if occupation == "" then
		guiSetText(jobLabel2, "Unemployed")
	else
		guiSetText(jobLabel2, occupation)
	end

	-- Check the team and set the shift status
	if (getTeamName(getPlayerTeam(localPlayer)) == "Unoccupied") then
		guiSetText ( jobButton1, "Start shift" )
	else
		guiSetText ( jobButton1, "End shift" )
	end

	-- Check is player has no job
	if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals") or (getTeamName(getPlayerTeam(localPlayer)) == "Unemployed") or (getTeamName(getPlayerTeam(localPlayer)) == "CS:GO") then
		guiSetEnabled ( jobButton1, false )
		guiSetEnabled ( jobButton2, false )
	else
		guiSetEnabled ( jobButton1, true )
		guiSetEnabled ( jobButton2, true )
	end
end
addEventHandler( "updateLabel", root, updateLabel )

local shift = 1

function onEndShift ()
	if not (isPedOnGround(localPlayer)) then exports.NGCdxmsg:createNewDxMessage("You can't end shift here",255,0,0) return false end
	if ( onSpamProtection () ) then
		if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals")  then
			exports.NGCdxmsg:createNewDxMessage("You can't go off-duty as a criminal!", 200, 0, 0)
		elseif ( getTeamName( getPlayerTeam( localPlayer ) ) == "CS:GO")  then
			exports.NGCdxmsg:createNewDxMessage("You can't go off-duty as a CS:GO!", 200, 0, 0)
		elseif ( isPedInVehicle( localPlayer ) ) then
			exports.NGCdxmsg:createNewDxMessage("You can't go off-duty in a car!", 200, 0, 0)
		elseif isPedDead(localPlayer) then
			exports.NGCdxmsg:createNewDxMessage("You can't go off-duty now", 200, 0, 0)
		elseif (getTickCount() - getElementData(localPlayer, "ldt") < 5000) then
			exports.NGCdxmsg:createNewDxMessage("You must not have taken damage in last 5 seconds to end shift.", 200, 0, 0)
		elseif shift == 1 then
			shift = 0
			-- You are on shift
			if exports.DENlaw:isPlayerLawEnforcer(localPlayer) then
				if deathMatch and isTimer(deathMatch) then return false end
				setElementData(localPlayer,"StopDeathmatching",true)
				deathMatch = setTimer(function()
					setElementData(localPlayer,"StopDeathmatching",false)
				end,30000,1)
			end
			triggerServerEvent( 'onEndShift', localPlayer )
			triggerEvent( "onClientPlayerTeamChange", localPlayer )
		else
			shift = 1
			-- You are off shift
			restoreShift = getElementData( localPlayer, "Occupation" )
			triggerServerEvent( 'onStartShift', localPlayer, restoreShift )
			triggerEvent( "onClientPlayerTeamChange", localPlayer )
			if isTimer(deathMatch) then killTimer(deathMatch) end
			setElementData(localPlayer,"StopDeathmatching",false)
		end
	else
		exports.NGCdxmsg:createNewDxMessage("Stop clicking the off-duty button! Now wait 30 seconds", 200, 0, 0)
	end
end

local theSpam = {}

function onSpamProtection ()
	if not ( theSpam[localPlayer] ) then
		theSpam[localPlayer] = 1
		return true
	elseif ( theSpam[localPlayer] >= 4 ) then
		return false
	else
		theSpam[localPlayer] = theSpam[localPlayer] +1
		if ( theSpam[localPlayer] >= 4 ) and not ( isTimer( clearTimer ) ) then clearTimer = setTimer( clearSpamProtection, 40000, 1 ) end
		return true
	end
end

function clearSpamProtection ()
	if ( theSpam[localPlayer] ) then
		theSpam[localPlayer] = 0
	end
end

function onQuitJob ()
	local elementStandingOn = getPedContactElement ( localPlayer )
	-- Quit yourjob permanent
	if not (isPedOnGround(localPlayer)) then exports.NGCdxmsg:createNewDxMessage("You can't quit job here",255,0,0) return false end
	if elementStandingOn and not getElementType(elementStandingOn) == "vehicle" or elementStandingOn and not getElementType(elementStandingOn) == "object" then exports.NGCdxmsg:createNewDxMessage("You have to be on the ground to quit your job",255,0,0) end
	if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals")  then
		exports.NGCdxmsg:createNewDxMessage("You can't quit your job as a criminal!", 200, 0, 0)
	elseif ( getTeamName( getPlayerTeam( localPlayer ) ) == "CS:GO")  then
		exports.NGCdxmsg:createNewDxMessage("You can't quit your team is CS:GO!", 200, 0, 0)
	elseif ( isPedInVehicle( localPlayer ) ) then
		exports.NGCdxmsg:createNewDxMessage("You can't quit your job in a car!", 200, 0, 0)
	elseif (getTickCount() - getElementData(localPlayer, "ldt") < 5000) then
		exports.NGCdxmsg:createNewDxMessage("You must not have taken damage in last 5 seconds to quit job.", 200, 0, 0)
	else
		oldShift = getElementData( localPlayer, "Occupation" )
		if exports.DENlaw:isPlayerLawEnforcer(localPlayer) then
			if deathMatch and isTimer(deathMatch) then return false end
			setElementData(localPlayer,"StopDeathmatching",true)
			deathMatch = setTimer(function()
				setElementData(localPlayer,"StopDeathmatching",false)
			end,30000,1)
		end
		triggerServerEvent( 'onQuitJob', localPlayer, oldShift )
		triggerEvent( "onClientPlayerTeamChange", localPlayer )
	end
end

function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawText(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,
		( sWidth/resolutionX )*scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI
    )
end

local screenWidth, screenHeight = guiGetScreenSize()
function createText()
	if getElementData(localPlayer,"StopDeathmatching") then
		if deathMatch and isTimer(deathMatch) then
			local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( deathMatch )
			local timeLeft = math.floor(timeLeft / 1000)
			if timeLeft > 0 then
				dxDrawRelativeText( "Cool down: "..timeLeft.." seconds", 520,719,1156.0,274.0,tocolor(0,0,0,230),1.2,"pricedown","left","top",false,false,false )
				dxDrawRelativeText( "Cool down: "..timeLeft.." seconds", 520,720,1156.0,274.0,tocolor(0,0,0,230),1.2,"pricedown","left","top",false,false,false )
				dxDrawRelativeText( "Cool down: "..timeLeft.." seconds", 520,721,1156.0,274.0,tocolor(0,0,0,230),1.2,"pricedown","left","top",false,false,false )
				dxDrawRelativeText( "Cool down: "..timeLeft.." seconds", 520,720,1156.0,274.0,tocolor(0,255,0,255),1.2,"pricedown","left","top",false,false,false )
			end
		end
	end
end
addEventHandler("onClientRender",root,createText)
