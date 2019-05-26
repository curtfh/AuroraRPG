local settingsTable
local phoneBackgroundCombo
local settingsGUI = {}
local currentPage = 1
local goToNextPageButton
local goToPreviousPageButton
local pageButtonSize = 20
local settingCheckboxWidth, settingCheckboxHeight = 130, 25


addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()),
function ()
	settingsTable =
	{
		{

		{nil, nil,nil, "AUR Performance"},
		{nil, "VIPCar","true", "VIP Car mod"},
		{nil, "Mapmods","true", "HD map interiors"},
		{nil, "roads","true", "HD roads"},
		{nil, "blur", "false", "Blur"},
		{nil, "jobs", "true", "Job Name"},
		{nil, "heathaze", "false", "Heat Haze"},
		{nil, "clouds", "false", "Clouds"},

		{nil, nil,nil, "AUR Personal Settings"},
		{nil, "helmetenabled","true","Helmet"},
		
		
		{nil, nil,nil, "AUR Blips"},
		{nil, "allianceblips","false","Disable Alliance blips"},
		{nil, "oldgr","false","Old group/Ally blips"},
		{nil, "custom","true","See Custom blips"},
		{nil, "stores","true","See Stores blips"},
		{nil, "craft","true","See Craft blips"},
		{nil, "radar", "false", "See all players"},
		{nil, "ATM", "true", "See ATM blips"},

		{nil, nil,nil, "AUR HUD & Shaders Config"},
		{nil, "billboards", "true", "Billboards"},
		{nil, "hud", "true", "Modded Hud"},
		{nil, "map", "true", "Modded Radar"},
		{nil, "gpsonhud", "true", "GPS Location"},
		{nil, "musiccontrol","true","Music controller"},


		{nil, nil,nil, "AUR Sms & Calls"},
		{nil, "smsnotification", "true", "SMS Unread"},
		{nil, "smschatbox", "true", "SMS Output"},
		{nil, "jobcalls", "true", "Enable job calls"},
		{nil, "chatbox", "true", "Chat Box"},


		{nil, nil,nil, "AUR Misc"},
		{nil, "turfBag","false","Turfing bag log"},
		{nil, "crimlog", "true", "Criminal log"},
		{nil, "drugtimer","true","See drug timers"},
		{nil, "premchat","true","See premium chat"},
		{nil, "supportchat","true","Support chat"},

		},
		{ -- second screen


		},
		{ -- third screen

		},


	}
	for i=1,#settingsTable do
		for ind=1,#settingsTable[i] do
			if not exports.DENsettings:getPlayerSetting(settingsTable[i][ind][2]) then
				exports.DENsettings:addPlayerSetting(settingsTable[i][ind][2], settingsTable[i][ind][3])
			end
		end
	end

	exports.DENsettings:addPlayerSetting("phoneBackground", "1")
	if sH >= 700 then
		settingCheckboxHeight = 25
	end
	dis = exports.DENsettings:getPlayerSetting('distance')
	if dis then
		setFarClipDistance(tonumber(math.floor(dis)))
	else
		exports.DENsettings:setPlayerSetting('distance',1000)
	end
end
)


addEvent("onPlayerSettingChange",true)
addEventHandler("onPlayerSettingChange",localPlayer,function(s,v)
	if s == "supportchat" and v == false then
		setElementData(localPlayer,"chatOutputSupport",false,true)
	elseif s == "supportchat" and v == true then
		setElementData(localPlayer,"chatOutputSupport",true,true)
	end
end)



-- Settings from the CSG Phone
local settings = {"blur","heathaze","clouds","chatbox","sms","groupblips","grouptags","turfBag"}
	function coldsnake( theSetting, newValue, oldValue )
		if ( newValue ~= nil ) then
			if ( theSetting == "blur" ) then
				if ( newValue == true ) then
					setBlurLevel ( 36 )
				else
					setBlurLevel ( 0 )
				end
			elseif ( theSetting == "heathaze" ) then
				if ( newValue == true ) then
					setHeatHaze ( 100 )
				else
					setHeatHaze ( 0 )
				end
			elseif ( theSetting == "clouds" ) then
				setCloudsEnabled ( newValue )
			elseif ( theSetting == "chatbox" ) then
				showChat ( newValue )
			elseif ( theSetting == "sms" ) then
				setElementData( localPlayer, "SMSoutput", newValue )
			elseif ( theSetting == "groupblips" ) then
				triggerEvent( "onClientSwitchGroupBlips", localPlayer, newValue )
			elseif ( theSetting == "grouptags" ) then
				triggerEvent( "onClientSwitchGroupTags", localPlayer, newValue )
			elseif ( theSetting == "turfBag" ) then
				if newValue == true then
					setElementData(localPlayer,"turfBag",true)
				else
					setElementData(localPlayer,"turfBag",false)
				end
			elseif ( theSetting == "distance") then 
				setFarClipDistance ( newValue )
			end
		end
	end

addEventHandler( "onPlayerSettingChange", root,coldsnake)


function setAS( theSetting,value )
		if ( value ~= nil ) then
			if ( theSetting == "blur" ) then
				if ( value == true ) then
					setBlurLevel ( 36 )
				else
					setBlurLevel ( 0 )
				end
			elseif ( theSetting == "heathaze" ) then
				if ( value == true ) then
					setHeatHaze ( 100 )
				else
					setHeatHaze ( 0 )
				end
			elseif ( theSetting == "clouds" ) then
				setCloudsEnabled ( value )
			elseif ( theSetting == "groupblips" ) then
				triggerEvent( "onClientSwitchGroupBlips", localPlayer, value )
			elseif ( theSetting == "grouptags" ) then
				triggerEvent( "onClientSwitchGroupTags", localPlayer, value )
			elseif ( theSetting == "turfBag" ) then
				if value == true then
					setElementData(localPlayer,"turfBag",true)
				else
					setElementData(localPlayer,"turfBag",false)
				end
			end
		end
	end
function checkSetting()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		for k,v in ipairs(settings) do
			local setting = exports.DENsettings:getPlayerSetting(v)
			setAS(v,setting)
		end
	else
		setTimer( checkSetting, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSetting )
setTimer( checkSetting, 5000, 0 )


function onOpenSettingsApp ( )
	togglePhone()
	executeCommandHandler ( "settings" )
end
apps[4][8] = onOpenSettingsApp

function onCloseSettingsApp ()

	destroyElement(goToPreviousPageButton)
	destroyElement(goToNextPageButton)

	removeEventHandler( "onClientGUIClick", root, onSettingsClick )
	apps[4][7] = false
	clearPageGUI()
	removeEventHandler('onClientGUIComboBoxAccepted',root,onGUIComboBoxAccepted)

end

function onSettingsClick()

	if ( source == settingsGUI[1] ) or ( source == settingsGUI[2] ) or ( source == settingsGUI[4] ) or ( source == settingsGUI[5] ) or ( source == settingsGUI[6] ) then
		guiSetText( source, "")
		if ( source == settingsGUI[2] ) or ( source == settingsGUI[4] ) or ( source == settingsGUI[5] ) or ( source == settingsGUI[6] ) then
			guiEditSetMasked( source, true)
		end
	end

	local setting

	for i=1,#settingsTable[currentPage] do

		if ( source == settingsTable[currentPage][i][1] ) then

			setting = settingsTable[currentPage][i][2]
			break

		end

	end

	if setting then
		exports.DENsettings:setPlayerSetting(setting, tostring(guiCheckBoxGetSelected( source )) )
	end

	if source == goToPreviousPageButton then

		if settingsTable[currentPage-1] then

			switchToPage(currentPage-1)

		end

	elseif source == goToNextPageButton then

		if settingsTable[currentPage+1] then

			switchToPage(currentPage+1)

		end

	end

end

function switchToPage(page)

	clearPageGUI(currentPage)
	currentPage = page
	createPageGUI()
	if page == 1 then

		guiSetEnabled(goToPreviousPageButton, false)

	else

		guiSetEnabled(goToPreviousPageButton, true)

	end

	if page == #settingsTable then

		guiSetEnabled(goToNextPageButton, false)

	else

		guiSetEnabled(goToNextPageButton, true)

	end

end

function clearPageGUI(page)

	local pageToRemove = page or currentPage
	if pageToRemove == 1 then
	destroyElement(scroll)


	elseif pageToRemove == 2 then

		for i=1,#settingsGUI do
			destroyElement(settingsGUI[i])
		end

	elseif pageToRemove == 3 then


		---- model thing destroyElement(ModelsCombo)
		destroyElement(phoneBackgroundCombo)
		destroyElement(distancemeter)
		destroyElement(distancelabel)
		destroyElement(resetdistance)
	end

	for i=1,#settingsTable[currentPage] do

		if isElement(settingsTable[currentPage][i][1]) then

			destroyElement(settingsTable[currentPage][i][1])

		end

	end
	removeEventHandler("onClientGUIScroll",root, changeRenderDistance)
	removeEventHandler( "onClientGUIBlur", root, onGUIBlur )
	removeEventHandler("onClientGUIClick", root, resetdistanceRender)

end
function createPageGUI()

	local rowsDone

	if currentPage == 1 then

		scroll = guiCreateScrollPane(BGX+BGWidth/12,BGY+25+(settingCheckboxHeight*(#settingsTable[3]/2)), 0.90*BGWidth, 0.90*BGHeight,false)

		guiSetProperty( scroll, "AlwaysOnTop", "True" )



	for i=1,#settingsTable[currentPage] do

		local row = math.floor((i-1))
		if i == 1 then row = 0 end
		local isFirstOfTheRow = ( i/2 ~= math.floor(i/2) ) or i == 1
		local x,y, width, height = BGX+(0.05*BGWidth),BGY+math.max(20,0.05*BGHeight)+((row)*settingCheckboxHeight),settingCheckboxWidth,settingCheckboxHeight
		--if not isFirstOfTheRow then
		--	x = BGX+(0.05*BGWidth)+110
		--end

		local settings = settingsTable[currentPage]
		local state = exports.DENsettings:getPlayerSetting(settings[i][2])
		if settings[i][3] == nil then
		settings[i][9] = guiCreateLabel ( x,y, width, height, settings[i][4], 	false,scroll )
		guiSetProperty ( settings[i][9], "AlwaysOnTop", "True" )
		else
		settings[i][1] = guiCreateCheckBox ( x,y, width, height, settings[i][4], state, false,scroll )
		guiSetProperty ( settings[i][1], "AlwaysOnTop", "True" )
		end


	end


	elseif currentPage == 2 then

		local BGy = settingCheckboxHeight + BGY
		settingsGUI[1] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.05*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"New email",false) -- Email
		settingsGUI[2] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.12*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Current password",false) -- Current password
		settingsGUI[3] = guiCreateButton(BGX+(0.05*BGWidth),BGy+(0.19*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Change email",false) -- Change mail button

		settingsGUI[4] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.30*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"New password",false) -- New pass
		settingsGUI[5] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.37*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Confirm new password",false) -- New pass confirm
		settingsGUI[6] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.44*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Current password",false) -- Old pass
		settingsGUI[7] = guiCreateButton(BGX+(0.05*BGWidth),BGy+(0.51*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Change password",false) -- Change pass button

		for i=1,#settingsGUI do
			guiSetProperty( settingsGUI[i], "AlwaysOnTop", "True" )
		end

		addEventHandler( "onClientGUIClick", settingsGUI[3], onChangePlayerEmail )
		addEventHandler( "onClientGUIClick", settingsGUI[7], onChangePlayerPassword )


	elseif currentPage == 3 then


		---- model thing ModelsCombo = guiCreateComboBox ( BGX+(0.05*BGWidth),BGY+80+(settingCheckboxHeight*(#settingsTable[3]/2)), 0.90*BGWidth, 0.2*BGHeight, "Phone Models",false)
		phoneBackgroundCombo = guiCreateComboBox ( BGX+(0.05*BGWidth),BGY+80+(settingCheckboxHeight*(#settingsTable[3]/2)), 0.90*BGWidth, 0.4*BGHeight, "Phone Background",false)
		distancelabel = guiCreateLabel(BGX+(0.05*BGWidth),BGY+130, 0.90*BGWidth, 0.4*BGHeight,"World far distance: "..(math.floor(getFarClipDistance())), false)
		distancemeter = guiCreateScrollBar(BGX+(0.05*BGWidth),BGY+160, 0.90*BGWidth, 0.08*BGHeight, true, false)
		resetdistance = guiCreateButton(BGX+(0.2*BGWidth),BGY+250, 0.60*BGWidth, 0.08*BGHeight,"Reset distance",false)
		sd = (getFarClipDistance()/100)
		guiScrollBarSetScrollPosition ( distancemeter, sd )
		guiSetProperty ( phoneBackgroundCombo, "AlwaysOnTop", "True" )
		guiSetProperty( distancemeter, "AlwaysOnTop", "True" )
		guiSetProperty( distancelabel, "AlwaysOnTop", "True" )
		guiSetProperty( resetdistance, "AlwaysOnTop", "True" )
		addEventHandler("onClientGUIScroll", distancemeter, changeRenderDistance)
		addEventHandler("onClientGUIClick", resetdistance, resetdistanceRender)
		---- model thing guiSetProperty( ModelsCombo, "AlwaysOnTop", "True" )

		---- model thing for i=1,3 do
			---- model thing guiComboBoxAddItem ( ModelsCombo, '' .. tostring(i))
		---- model thing end
		for i=1,8 do
			guiComboBoxAddItem ( phoneBackgroundCombo, 'Background ' .. tostring(i))
		end
	end

	addEventHandler( "onClientGUIBlur", root, onGUIBlur )

end

function resetdistanceRender()
	exports.DENsettings:setPlayerSetting('distance',1000)
	setFarClipDistance ( 1000 )
	sd = (getFarClipDistance()/100)
	if distancemeter then guiScrollBarSetScrollPosition ( distancemeter, sd ) end
	guiSetText ( distancelabel, "Actual Distance: 1000" )
end

function changeRenderDistance ()
    pos = guiScrollBarGetScrollPosition(distancemeter)
    distance = (guiScrollBarGetScrollPosition(distancemeter) / 100) * 10000
    if pos < 5 then distance = 200 guiSetText ( distancelabel, "Actual Distance: "..(math.floor(distance)).."" ) end
    if math.floor(distance) >= 200 and math.floor(distance) <= 10000 then
		guiSetText ( distancelabel, "Actual Distance: "..(math.floor(distance)).."" )
		setFarClipDistance ( tonumber(math.floor(distance)) )
		exports.DENsettings:setPlayerSetting('distance',math.floor(distance))
	end
end

function onGUIComboBoxAccepted(comboBox)
	if currentPage == 3 and comboBox == phoneBackgroundCombo then
		local selectedBG = guiComboBoxGetItemText(phoneBackgroundCombo,guiComboBoxGetSelected(phoneBackgroundCombo))
		local selectedBG = string.sub(selectedBG, 12 )
		if ( selectedBG ~= "round" ) then
			BGnumber = selectedBG
			exports.DENsettings:setPlayerSetting("phoneBackground", selectedBG )
		end

	--[[ model thing  elseif currentPage == 3 and comboBox == ModelsCombo then
		local selectedBG2 = guiComboBoxGetItemText(ModelsCombo,guiComboBoxGetSelected(ModelsCombo))
		local selectedBG2 = string.sub(selectedBG2, 1 )
		if ( selectedBG2 ~= "round" ) then
			phonemodel = selectedBG2
			exports.DENsettings:setPlayerSetting("phoneModel", selectedBG2 )
			setElementData(localPlayer,"Phone", selectedBG2)
		end]]
	elseif currentPage == 3 and comboBox == SMSringtoneCombo then
		local selectedRingtone = guiComboBoxGetItemText(SMSringtoneCombo,guiComboBoxGetSelected(SMSringtoneCombo))
		local selectedRingtone = string.gsub(selectedRingtone, "Ringtone ","" )
		if ( #selectedRingtone >= 1  ) then
			exports.DENsettings:setPlayerSetting("smsringtonenumber", selectedRingtone )
			playSound("Ringtones/"..tostring(selectedRingtone)..".mp3")
			--playSound("apps\\ringtones\\"..tostring(selectedRingtone)..".mp3")
		end
	end
end

function onGUIBlur()

	if currentPage == 2 then
		onSetEditDataBack ()
	end

end

function onSetEditDataBack ()
	if ( string.match(guiGetText(source), "^%s*$") ) then
		if ( source == settingsGUI[1] ) then
			guiSetText( source, "New email")
		elseif ( source == settingsGUI[2] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "Current password")
		elseif ( source == settingsGUI[4] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "New password")
		elseif ( source == settingsGUI[5] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "Confirm new password")
		elseif ( source == settingsGUI[6] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "Current password")
		end
	end
end

addEvent( "resetSettingsEditFields", true )
function resetSettingsEditFields ()
	guiEditSetMasked( settingsGUI[1], false)
	guiEditSetMasked( settingsGUI[2], false)
	guiEditSetMasked( settingsGUI[4], false)
	guiEditSetMasked( settingsGUI[5], false)
	guiEditSetMasked( settingsGUI[6], false)
end
addEventHandler( "resetSettingsEditFields", root, resetSettingsEditFields )

function onChangePlayerEmail ()
	local theEmail = guiGetText(settingsGUI[1])
	local thePassword = guiGetText(settingsGUI[2])
	triggerServerEvent( "onPlayerEmailChange", localPlayer, theEmail, thePassword )
end

function onChangePlayerPassword ()
	local newPassword1 = guiGetText(settingsGUI[4])
	local newPassword2 = guiGetText(settingsGUI[5])
	local oldPassword = guiGetText(settingsGUI[6])
	triggerServerEvent( "onPlayerPasswordChange", localPlayer, newPassword1, newPassword2, oldPassword )
end

apps[4][9] = onCloseSettingsApp
