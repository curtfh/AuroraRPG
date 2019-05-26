crash = {{{{{{{{ {}, {}, {} }}}}}}}}



-----------------------------------------------------------------------
------------------------ Settings ---------------------------------
-----------------------------------------------------------------------
crash = {{{{{{{{ {}, {}, {} }}}}}}}}
Rules = {
{"Egyptian"},
{"English"},
{"France"},
{"Italian"},
{"Russian"},
{"Portuguese"},
{"Tunisian"},
}

Commands = {
{"Function Binds"},
{"Chat Binds"},
{"Server Commands"},
}

Informations = {
{"FAQ"},
{"Events"},
}

Updates = {
{"Recently Updates"},
}

Roster = {
{"Staff Duties"},
{"Staff Roster"},
}

About = {
{"AUR info"},
}



function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/1.5
	guiSetPosition(theWindow,x,y,false)
end

-- RULES
-- local rules_ _file = fileOpen("Rules/rules_ .txt", true)
local rules_egyptian_file = fileOpen("Rules/eg.txt", true)
local rules_english_file = fileOpen("Rules/en.txt", true)
local rules_italian_file = fileOpen("Rules/it.txt", true)
local rules_portuguese_file = fileOpen("Rules/pt.txt", true)
local rules_russian_file = fileOpen("Rules/ru.txt", true)
local rules_france_file = fileOpen("Rules/fr.txt", true)
local rules_tunisian_file = fileOpen("Rules/tn.txt", true)

-- local _Rules = fileRead(rules_ _file, 50000)
local France_Rules = fileRead(rules_france_file, 50000)
local Egyptian_Rules = fileRead(rules_egyptian_file, 50000)
local English_Rules = fileRead(rules_english_file, 50000)
local Italian_Rules = fileRead(rules_italian_file, 50000)
local Portuguese_Rules = fileRead(rules_portuguese_file, 50000)
local Russian_Rules = fileRead(rules_russian_file, 50000)
local Tunisian_Rules = fileRead(rules_tunisian_file, 50000)



-- OTHERS
-- local other_ _file = fileOpen("Other/ .txt", true)

local other_AURinfo_file = fileOpen("Other/AURinfo.txt", true)
local other_events_file = fileOpen("Other/Events.txt", true)
local other_faq_file = fileOpen("Other/FAQ.txt", true)
local other_staff_duties_file = fileOpen("Other/Staff_duties.txt", true)
local other_staff_roster_file = fileOpen("Other/Staff_roster.txt", true)
local other_updates_file = fileOpen("Other/Updates.txt", true)
local servercmd_file = fileOpen("Other/servercmd.txt", true)

--local _Info = fileRead(other_ _file, 50000)
local AURinfo_Info = fileRead(other_AURinfo_file, 50000)
local Events_Info = fileRead(other_events_file, 50000)
local FAQ_Info = fileRead(other_faq_file, 50000)
local Staff_D_Info = fileRead(other_staff_duties_file, 50000)
local Staff_R_Info = fileRead(other_staff_roster_file, 50000)
local servcmd_info = fileRead(servercmd_file, 50000)
---local Updates_Info = fileRead(other_updates_file, 50000)
Updates_Info = ""

Options = {
{"Rules"},
{"Commands"},
{"Informations"},
{"Updates"},
{"Staff Roster"},
{"About AUR"},
{"Close"},
}

AURhelp_window = guiCreateWindow(302,86,701,585,"AUR ~ Extensive Documentation",false)
centerWindows(AURhelp_window)
AURhelp_image = guiCreateStaticImage(200,30,340,80,"images/logo.png",false,AURhelp_window)
AURhelp_Label = guiCreateLabel(230,110,500,50,"Extensive Documentation",false,AURhelp_window)
	guiLabelSetColor(AURhelp_Label,0,200,200)
	guiLabelSetVerticalAlign(AURhelp_Label,"top")
	guiLabelSetHorizontalAlign(AURhelp_Label,"left",false)
	guiSetFont(AURhelp_Label,"sa-header")
AURhelp_Credits = guiCreateLabel(490,566,220,20,"© Smith 2016 AUR ~ Extensive Documentation",false,AURhelp_window)
	guiLabelSetColor(AURhelp_Credits,255,250,250)
	guiLabelSetVerticalAlign(AURhelp_Credits,"top")
	guiLabelSetHorizontalAlign(AURhelp_Credits,"left",false)
	guiSetFont(AURhelp_Credits,"default-small")
AURhelp_memo = guiCreateMemo(165,174,527,392,"Please, Select one of current Options found in GridList 1.",false,AURhelp_window)
AURhelp_grid1 = guiCreateGridList(10,175,147,130,false,AURhelp_window)
	guiGridListSetSelectionMode(AURhelp_grid1,2)
	AURhelp_grid1_Column = guiGridListAddColumn(AURhelp_grid1,"Possible Options",0.81)
		for k, v in ipairs(Options) do
			local row = guiGridListAddRow ( AURhelp_grid1 )
				guiGridListSetItemText ( AURhelp_grid1 , row, AURhelp_grid1_Column, v[1], false, false )
		end
AURhelp_grid2 = guiCreateGridList(11,312,146,255,false,AURhelp_window)
	guiGridListSetSelectionMode(AURhelp_grid2,2)
	AURhelp_grid2_Column = guiGridListAddColumn(AURhelp_grid2,"Option(s)",0.81)
guiMemoSetReadOnly(AURhelp_memo, true)
guiWindowSetSizable(AURhelp_window,false)
guiSetVisible(AURhelp_window,false)
showCursor(false)

addCommandHandler("rules",
function()
guiSetVisible(AURhelp_window, not guiGetVisible(AURhelp_window))
showCursor(not isCursorShowing())
triggerServerEvent("requestUpdates",resourceRoot)
end
)


function downl(responseData, errno)
    if (errno == 0) then
		Updates_Info = responseData
    else
        Updates_Info = "Failed to collect updates"
    end
end

addEvent("requestUpdates",true)
addEventHandler("requestUpdates",getRootElement(),downl)



function forceShowRules()
	guiSetVisible(AURhelp_window, not guiGetVisible(AURhelp_window))
	showCursor(not isCursorShowing())
	exports.NGCdxmsg:createNewDxMessage("Welcome to AUR Information panel. Read rules carefully & Don't break them.",0,255,0)
end

addEvent("onPlayerForcedRules",true)
addEventHandler("onPlayerForcedRules",root,function()
	guiSetVisible(AURhelp_window, not guiGetVisible(AURhelp_window))
	showCursor(not isCursorShowing())
	exports.NGCdxmsg:createNewDxMessage("Welcome to AUR Information panel. Read rules carefully & Don't break them.",0,255,0)
end)

addEventHandler("onClientGUIClick", getRootElement(),
function()
if source == AURhelp_grid1 then
	local selectedOption = guiGridListGetItemText (AURhelp_grid1, guiGridListGetSelectedItem (AURhelp_grid1), 1)
	if selectedOption ~= nil then
		if selectedOption == "Rules" then
			guiSetText(AURhelp_memo,"Now that you selected your option, please select the one of the languages ??found in the following list.")
			guiGridListClear(AURhelp_grid2)
			for k, v in ipairs(Rules) do
			local row = guiGridListAddRow ( AURhelp_grid2 )
				guiGridListSetItemText(AURhelp_grid2, row, AURhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Commands" then
			guiSetText(AURhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(AURhelp_grid2)
			for k, v in ipairs(Commands) do
			local row = guiGridListAddRow ( AURhelp_grid2 )
				guiGridListSetItemText ( AURhelp_grid2, row, AURhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Informations" then
			guiSetText(AURhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(AURhelp_grid2)
			for k, v in ipairs(Informations) do
			local row = guiGridListAddRow ( AURhelp_grid2 )
				guiGridListSetItemText ( AURhelp_grid2, row, AURhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Updates" then
			guiSetText(AURhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(AURhelp_grid2)
			for k, v in ipairs(Updates) do
			local row = guiGridListAddRow ( AURhelp_grid2 )
				guiGridListSetItemText ( AURhelp_grid2, row, AURhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Staff Roster" then
			guiSetText(AURhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(AURhelp_grid2)
			for k, v in ipairs(Roster) do
			local row = guiGridListAddRow ( AURhelp_grid2 )
				guiGridListSetItemText ( AURhelp_grid2, row, AURhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "About AUR" then
			guiSetText(AURhelp_memo,"Now that you selected your option, please select the one of the options ??found in the following list.")
			guiGridListClear(AURhelp_grid2)
			for k, v in ipairs(About) do
			local row = guiGridListAddRow ( AURhelp_grid2 )
				guiGridListSetItemText ( AURhelp_grid2, row, AURhelp_grid2_Column, v[1], false, false )
			end
		elseif selectedOption == "Close" then
			guiSetVisible(AURhelp_window, not guiGetVisible(AURhelp_window))
			showCursor(not isCursorShowing())
		else
		guiSetText(AURhelp_memo,"Warning: You have to select one of options found in GridList1!")
		end
	end
elseif source == AURhelp_grid2 then
	local selectedOption = guiGridListGetItemText (AURhelp_grid1, guiGridListGetSelectedItem (AURhelp_grid1), 1)
	local selectedOption2 = guiGridListGetItemText (AURhelp_grid2, guiGridListGetSelectedItem (AURhelp_grid2), 1)
	if selectedOption == "Rules" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "France" then
				guiSetText(AURhelp_memo,France_Rules)
			elseif selectedOption2 == "Egyptian" then
				guiSetText(AURhelp_memo,Egyptian_Rules)
			elseif selectedOption2 == "English" then
				guiSetText(AURhelp_memo,English_Rules)
			elseif selectedOption2 == "Italian" then
				guiSetText(AURhelp_memo,Italian_Rules)
			elseif selectedOption2 == "Portuguese" then
				guiSetText(AURhelp_memo,Portuguese_Rules)
			elseif selectedOption2 == "Russian" then
				guiSetText(AURhelp_memo,Russian_Rules)
			elseif selectedOption2 == "Tunisian" then
				guiSetText(AURhelp_memo,Tunisian_Rules)
			else
				guiSetText(AURhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Commands" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Function Binds" then
				guiSetText(AURhelp_memo,"Function key binds: \n\nF1 - Extensive Documentation such as Rules, Informations and so on.\nF2 - Job window, here you can quit your job or end/start your shift.\nF3 - Vehicle system, manage all your personal vehicles here.\nF4 - Animations windows.\nF5 - Inventory, here you find all your items like drugs, food and other things.\nF6 - Group system, manage your group or the group your currently in.\nF8 or ` - Console window.\nF9 - Stats window.\nF10 - Trade window\nF11 - Map window, in this windown you can see all blips for Jobs, Players, Stores and so on.\nF12 - Taking screenshot of your screen and save it in your MTA San Andreas/screenshoot folder.\n N - AUR Phone (SMSs, Money, Games etc).")
			elseif selectedOption2 == "Chat Binds" then
				guiSetText(AURhelp_memo,"Chat related commands and binds: \n\nT - To talk to someone in MainChat.\nY - To talk to someone in TeamChat.\nU - Talk with people near your position, you get also a text baloon above your head.\nJ - Open AUR Chat system.\n\n\nCommands that can also be used to chat:\n\n/say  - To talk to someone in MainChat.\n/teamsay  - Talk with people in the same team.\n/local or /localchat  - Talk with people near your position, you get also a text baloon above your head.\n/group or /groupchat or /gc - Talk with people in your group.\n/law - To talk with people in Official Laws Team.\n/advert  - When you have something to advertise for example house for sell, one message cost $3,300 (1 minute spam protection).\n/clearchat  - Clear the whole chat.\n\n\nNOTE: You can bind all these commands by using /bind [KEYBOARD KEY] chatbox [COMMANDNAME]")
			elseif selectedOption2 == "Server Commands" then
				guiSetText(AURhelp_memo,servcmd_info)
			else
				guiSetText(AURhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Informations" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "FAQ" then
				guiSetText(AURhelp_memo,FAQ_Info)
			elseif selectedOption2 == "Events" then
				guiSetText(AURhelp_memo,Events_Info)
			else
				guiSetText(AURhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Updates" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Recently Updates" then
				guiSetText(AURhelp_memo,Updates_Info)
			else
				guiSetText(AURhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "Staff Roster" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "Staff Duties" then
				guiSetText(AURhelp_memo, Staff_D_Info)
			elseif selectedOption2 == "Staff Roster" then
				guiSetText(AURhelp_memo, Staff_R_Info)
			else
				guiSetText(AURhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	elseif selectedOption == "About AUR" then
		if selectedOption2 ~= nil then
			if selectedOption2 == "AUR info" then
				guiSetText(AURhelp_memo,AURinfo_Info)
			else
				guiSetText(AURhelp_memo,"Warning: You have to select one of options to get information!")
			end
		end
	else
		guiSetText(AURhelp_memo,"Warning: You have to select one of options found in GridList1!")
	end
end
end
)
