local CSGGroupsGUI = {}
local AURGroupsGUI = {}
local theFounderAccount = false
local theGroupID = false
nickToPlayer={}
exports.DENsettings:addPlayerSetting( "groupblips", "true" )
exports.DENsettings:addPlayerSetting( "grouptags", "false" )

blacklist = {
    edit = {},
    button = {},
    window = {},
    label = {},
	radiobutton = {},
    gridlist = {}
	}



SlotsWnd = {
    button = {},
    window = {},
    edit = {},
    label = {}
}

PointsPanel = {
		button = {},
		window = {},
		edit = {},
		label = {}
	}
NamePanel = {
		button = {},
		window = {},
		edit = {},
		label = {}
	}

groupX = {
    tab = {},
    tabpanel = {},
    label = {},
    gridlist = {},
    window = {}
}

gtype = {
    radio = {}
}

--[[guiGridListAddColumn(groupX.gridlist[1], "XP", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data1", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data2", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data3", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data4", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data5", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data6", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data7", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data8", 0.1)
guiGridListAddColumn(groupX.gridlist[1], "Data9", 0.1)
]]
function createGroupWindows ()
	-- Window
	CSGGroupsGUI[1] = guiCreateWindow(628,406,550,402,"AuroraRPG ~ Groups Management",false)
	setWindowPrefs ( CSGGroupsGUI[1] )
	CSGGroupsGUI[2] = guiCreateTabPanel(9,25,532,368,false,CSGGroupsGUI[1])
	-- Tab 1
	CSGGroupsGUI[3] = guiCreateTab("Main",CSGGroupsGUI[2])
	CSGGroupsGUI[4] = guiCreateButton(7,12,151,29,"Create new group",false,CSGGroupsGUI[3])
	CSGGroupsGUI[5] = guiCreateEdit(162,11,153,30,"",false,CSGGroupsGUI[3])
	gtype.radio[1] = guiCreateRadioButton(320,11,70,30, "Criminals", false,CSGGroupsGUI[3])
	gtype.radio[2] = guiCreateRadioButton(390,11,70,30, "Law", false,CSGGroupsGUI[3])
	gtype.radio[3] = guiCreateRadioButton(440,11,70,30, "Other", false,CSGGroupsGUI[3])

	guiSetProperty(gtype.radio[1], "NormalTextColour", "FFFF0000")
	guiSetProperty(gtype.radio[2], "NormalTextColour", "FF0D63F0")
	guiSetProperty(gtype.radio[3], "NormalTextColour", "FFECCF10")
	CSGGroupsGUI[6] = guiCreateLabel(9,44,519,11,string.rep("-",128),false,CSGGroupsGUI[3])
	CSGGroupsGUI[7] = guiCreateLabel(9,64,130,16,"Your current group:",false,CSGGroupsGUI[3])
	--CSGGroupsGUI[450] = guiCreateLabel(350,64,130,16,"Group Slots:",false,CSGGroupsGUI[3])
	--guiSetFont(CSGGroupsGUI[450], "default-bold-small")
	CSGGroupsGUI[8] = guiCreateLabel(9,91,130,16,"Member count:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[9] = guiCreateLabel(9,119,130,16,"Group Leader:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[10] = guiCreateLabel(9,148,130,16,"Date created:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[11] = guiCreateLabel(9,177,130,16,"Date joined:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[12] = guiCreateLabel(9,207,130,16,"Group bank balance:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[13] = guiCreateLabel(9,236,130,16,"Your rank:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[14] = guiCreateLabel(9,283,519,11,string.rep("-",128),false,CSGGroupsGUI[3])
	CSGGroupsGUI[15] = guiCreateLabel(9,268,130,16,"Turf color:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[17] = guiCreateButton(7,304,151,29,"Leave group",false,CSGGroupsGUI[3])
	CSGGroupsGUI[18] = guiCreateCheckBox(167,304,139,29,"Enable group blips",false,false,CSGGroupsGUI[3])
	CSGGroupsGUI[19] = guiCreateCheckBox(303,304,213,29,"Enable red nametags for members",false,false,CSGGroupsGUI[3])
	--CSGGroupsGUI[450] = guiCreateLabel(197,64,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[20] = guiCreateLabel(137,64,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[21] = guiCreateLabel(137,90,385,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[22] = guiCreateLabel(137,118,381,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[23] = guiCreateLabel(137,147,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[24] = guiCreateLabel(137,176,377,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[25] = guiCreateLabel(137,207,384,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[26] = guiCreateLabel(137,236,383,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[27] = guiCreateLabel(137,269,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[1600] = guiCreateLabel(259,64,130,16,"Group Type:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[1601] = guiCreateLabel(357,64,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[1602] = guiCreateLabel(259,91,130,16,"Group Level:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[1603] = guiCreateLabel(357,91,382,16,"N/A",false,CSGGroupsGUI[3])
	CSGGroupsGUI[1604] = guiCreateLabel(259,119,130,16,"Group Exp:",false,CSGGroupsGUI[3])
	CSGGroupsGUI[1605] = guiCreateLabel(357,119,382,16,"N/A",false,CSGGroupsGUI[3])
	guiSetFont(CSGGroupsGUI[1600],"default-bold-small")
	guiSetFont(CSGGroupsGUI[1601],"default-bold-small")
	guiSetFont(CSGGroupsGUI[1602],"default-bold-small")
	guiSetFont(CSGGroupsGUI[1603],"default-bold-small")
	guiSetFont(CSGGroupsGUI[1604],"default-bold-small")
	guiSetFont(CSGGroupsGUI[1605],"default-bold-small")
	--[[Type
    AURGroupsGUI[1] = guiCreateWindow(351, 214, 586, 258, "AUR Groups ~ Group Type", false)
    guiWindowSetSizable(AURGroupsGUI[1], false)

    AURGroupsGUI[2] = guiCreateLabel(165, 33, 370, 15, "Choose your group type:  Law - Criminal - Civilian", false, AURGroupsGUI[1])
    guiSetFont(AURGroupsGUI[2], "default-bold-small")
    guiLabelSetColor(AURGroupsGUI[2], 225, 180, 0)
    AURGroupsGUI[3] = guiCreateButton(165, 73, 262, 37, "LAW GROUP ", false, AURGroupsGUI[1])
    guiSetFont(AURGroupsGUI[3], "default-bold-small")
    guiSetProperty(AURGroupsGUI[3], "NormalTextColour", "FF2560D8")
    AURGroupsGUI[4] = guiCreateLabel(118, 48, 401, 15, "NOTE: You won't be able to change group type after creating the group!", false, AURGroupsGUI[1])
    guiSetFont(AURGroupsGUI[4], "default-bold-small")
    guiLabelSetColor(AURGroupsGUI[4], 255, 0, 0)
    AURGroupsGUI[5] = guiCreateButton(165, 120, 262, 37, "CRIMINAL GROUP", false, AURGroupsGUI[1])
    guiSetFont(AURGroupsGUI[5], "default-bold-small")
    guiSetProperty(AURGroupsGUI[5], "NormalTextColour", "FFFF0000")
    AURGroupsGUI[6] = guiCreateButton(165, 167, 262, 37, "CIVILIAN GROUP", false, AURGroupsGUI[1])
    guiSetFont(AURGroupsGUI[6], "default-bold-small")
    guiSetProperty(AURGroupsGUI[6], "NormalTextColour", "FFF5FD23")
    AURGroupsGUI[7] = guiCreateButton(9, 219, 133, 29, "Close", false, AURGroupsGUI[1])
	guiWindowSetSizable(AURGroupsGUI[1], false)
	guiSetVisible(AURGroupsGUI[1],false)]]
	-- Tab 2
	CSGGroupsGUI[28] = guiCreateTab("Members",CSGGroupsGUI[2])
	CSGGroupsGUI[29] = guiCreateLabel(6,6,517,15,"All groups members and their status:",false,CSGGroupsGUI[28])
	CSGGroupsGUI[30] = guiCreateGridList(2,24,528,317,false,CSGGroupsGUI[28])
	-- Tab 3
	CSGGroupsGUI[31] = guiCreateTab("Info",CSGGroupsGUI[2])
	CSGGroupsGUI[32] = guiCreateLabel(6,6,115,16,"Group information:",false,CSGGroupsGUI[31])
	CSGGroupsGUI[33] = guiCreateMemo(3,22,526,293,"",false,CSGGroupsGUI[31])
	CSGGroupsGUI[34] = guiCreateButton(3,317,526,22,"Update group information (Group maintainers only)",false,CSGGroupsGUI[31])
	-- Tab 4
	CSGGroupsGUI[35] = guiCreateTab("Settings",CSGGroupsGUI[2])
	CSGGroupsGUI[36] = guiCreateLabel(6,6,185,14,"Group and member maintenace:",false,CSGGroupsGUI[35])
	CSGGroupsGUI[37] = guiCreateGridList(5,25,186,314,false,CSGGroupsGUI[35])
	CSGGroupsGUI[38] = guiCreateLabel(196,6,9,331,string.rep("|\n",30),false,CSGGroupsGUI[35])
	--CSGGroupsGUI[39] = guiCreateButton(206,9,155,36,"Note to all members",false,CSGGroupsGUI[35])
	CSGGroupsGUI[39] = guiCreateButton(206,9,155,36,"Upgrade group",false,CSGGroupsGUI[35])
	CSGGroupsGUI[40] = guiCreateButton(366,9,160,36,"View Exp & Level Info",false,CSGGroupsGUI[35])
	CSGGroupsGUI[41] = guiCreateButton(206,51,155,36,"Invite new member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[500] = guiCreateButton(366,51,160,36,"Group Logs",false,CSGGroupsGUI[35])
	CSGGroupsGUI[600] = guiCreateButton(206,90,155,36,"Warn member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[601] = guiCreateButton(366,90,160,36,"Un-Warn member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[42] = guiCreateButton(206,132,155,36,"Promote member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[43] = guiCreateButton(366,132,160,36,"Demote member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[501] = guiCreateButton(206,216,155,36,"Manage Ranks",false,CSGGroupsGUI[35])
	CSGGroupsGUI[502] = guiCreateButton(366,216,160,36,"Set Rank",false,CSGGroupsGUI[35])
	CSGGroupsGUI[44] = guiCreateButton(206,174,155,36,"Kick member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[45] = guiCreateButton(206,258,155,36,"Change turf color",false,CSGGroupsGUI[35])
	CSGGroupsGUI[700] = guiCreateButton(206,298,155,36,"Set Points",false,CSGGroupsGUI[35])
	---CSGGroupsGUI[800] = guiCreateButton(366,298,160,36,"Rename member",false,CSGGroupsGUI[35])
	CSGGroupsGUI[1500] = guiCreateButton(366,298,160,36,"Buy Slots",false,CSGGroupsGUI[35])
	CSGGroupsGUI[46] = guiCreateButton(366,258,160,36,"Delete group",false,CSGGroupsGUI[35])
	CSGGroupsGUI[47] = guiCreateButton(366,173,160,36,"Set new leader",false,CSGGroupsGUI[35])
	--CSGGroupsGUI[48] = guiCreateLabel(207,318,319,20,"Trail, Member, Group staff, Group Leader, Group Founder",false,CSGGroupsGUI[35])
	--CSGGroupsGUI[49] = guiCreateLabel(207,302,319,20,"Ranks:",false,CSGGroupsGUI[35])

	-- Tab 5
	CSGGroupsGUI[50] = guiCreateTab("Bank",CSGGroupsGUI[2])
	CSGGroupsGUI[51] = guiCreateLabel(7,8,377,18,"Last bank transactions: (Current balance: $0)",false,CSGGroupsGUI[50])
	CSGGroupsGUI[52] = guiCreateGridList(4,25,525,282,false,CSGGroupsGUI[50])
	CSGGroupsGUI[53] = guiCreateButton(383,309,145,30,"Withdraw",false,CSGGroupsGUI[50])
	CSGGroupsGUI[54] = guiCreateButton(232,309,147,30,"Deposit",false,CSGGroupsGUI[50])
	CSGGroupsGUI[55] = guiCreateEdit(4,310,226,29,"",false,CSGGroupsGUI[50])
	-- Tab 6
	CSGGroupsGUI[56] = guiCreateTab("Invites",CSGGroupsGUI[2])
	CSGGroupsGUI[57] = guiCreateLabel(7,7,394,16,"Group invites:",false,CSGGroupsGUI[56])
	CSGGroupsGUI[58] = guiCreateGridList(4,24,523,278,false,CSGGroupsGUI[56])
	CSGGroupsGUI[59] = guiCreateButton(4,305,260,34,"Accept group invite",false,CSGGroupsGUI[56])
	CSGGroupsGUI[60] = guiCreateButton(267,305,260,34,"Delete group invite",false,CSGGroupsGUI[56])
	-- Tab 7
	CSGGroupsGUI[9000] = guiCreateTab("Blacklist",CSGGroupsGUI[2])

	blacklist.gridlist[1] = guiCreateGridList(9, 17, 258, 319, false, CSGGroupsGUI[9000])
	guiGridListAddColumn(blacklist.gridlist[1], "Account", 0.3)
	guiGridListAddColumn(blacklist.gridlist[1], "Nickname", 0.3)
	guiGridListAddColumn(blacklist.gridlist[1], "By", 0.2)
	guiGridListAddColumn(blacklist.gridlist[1], "Level", 0.2)
	blacklist.button[1] = guiCreateButton(320, 219, 162, 31, "Add account", false, CSGGroupsGUI[9000])
	guiSetProperty(blacklist.button[1], "NormalTextColour", "FFAAAAAA")
	blacklist.button[2] = guiCreateButton(320, 260, 162, 31, "Remove blacklist", false, CSGGroupsGUI[9000])
	guiSetProperty(blacklist.button[2], "NormalTextColour", "FFAAAAAA")

	blacklist.edit[1] = guiCreateEdit(320, 58, 162, 26, "", false, CSGGroupsGUI[9000])
	blacklist.label[1] = guiCreateLabel(320, 26, 162, 22, "Account", false, CSGGroupsGUI[9000])
	guiSetFont(blacklist.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(blacklist.label[1], "center", false)
	blacklist.edit[2] = guiCreateEdit(320, 122, 162, 26, "", false, CSGGroupsGUI[9000])
	blacklist.label[2] = guiCreateLabel(320, 94, 162, 22, "Nickname", false, CSGGroupsGUI[9000])
	guiSetFont(blacklist.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(blacklist.label[2], "center", false)
	blacklist.radiobutton[1] = guiCreateRadioButton(320, 160, 89, 15, "Level 1", false, CSGGroupsGUI[9000])
	blacklist.radiobutton[2] = guiCreateRadioButton(410, 160, 89, 15, "Level 2", false, CSGGroupsGUI[9000])
	blacklist.radiobutton[3] = guiCreateRadioButton(320, 187, 89, 15, "Level 3", false, CSGGroupsGUI[9000])
	blacklist.radiobutton[4] = guiCreateRadioButton(410, 187, 89, 15, "Level 4", false, CSGGroupsGUI[9000])



	-- Tab 8
	CSGGroupsGUI[61] = guiCreateTab("Groups",CSGGroupsGUI[2])
	CSGGroupsGUI[62] = guiCreateLabel(8,6,351,19,"All groups:",false,CSGGroupsGUI[61])
	CSGGroupsGUI[63] = guiCreateGridList(3,24,526,316,false,CSGGroupsGUI[61])

	CSGGroupsGUI[2500] = guiCreateTab("AV",CSGGroupsGUI[2])
	CSGGroupsGUI[2501] = guiCreateLabel(8,6,351,19,"Double click on value to change:",false,CSGGroupsGUI[2500])
	CSGGroupsGUI[2502] = guiCreateGridList(3,24,526,316,false,CSGGroupsGUI[2500])
	guiGridListSetSelectionMode(CSGGroupsGUI[2502],2)


	-- Invites window
	CSGGroupsGUI[64] = guiCreateWindow(340,333,291,434,"Invite a new player",false)
	setWindowPrefs ( CSGGroupsGUI[64] )
	CSGGroupsGUI[65] = guiCreateEdit(9,24,273,24,"",false,CSGGroupsGUI[64])
	CSGGroupsGUI[66] = guiCreateGridList(9,49,272,348,false,CSGGroupsGUI[64])
	CSGGroupsGUI[67] = guiCreateButton(9,401,134,24,"Invite player",false,CSGGroupsGUI[64])
	CSGGroupsGUI[68] = guiCreateButton(146,401,134,24,"Close window",false,CSGGroupsGUI[64])
	-- Group created window
	CSGGroupsGUI[69] = guiCreateWindow(493,312,260,136,"Your group is created!",false)
	setWindowPrefs ( CSGGroupsGUI[69] )
	CSGGroupsGUI[70] = guiCreateLabel(38,27,196,16,"Your group is created!",false,CSGGroupsGUI[69])
	guiLabelSetColor( CSGGroupsGUI[70], 0, 225, 0 )
	CSGGroupsGUI[71] = guiCreateLabel(19,44,227,16,"Press F6 again to manage your group.",false,CSGGroupsGUI[69])
	CSGGroupsGUI[72] = guiCreateLabel(25,61,212,16,"For more information press F1!",false,CSGGroupsGUI[69])
	CSGGroupsGUI[73] = guiCreateButton(39,95,180,32,"Close",false,CSGGroupsGUI[69])
	-- Message to all players window
	CSGGroupsGUI[74] = guiCreateWindow(314,366,364,98,"Send a note to all group members",false)
	setWindowPrefs ( CSGGroupsGUI[74] )
	CSGGroupsGUI[75] = guiCreateEdit(9,24,346,32,"",false,CSGGroupsGUI[74])
	CSGGroupsGUI[76] = guiCreateButton(10,58,176,30,"Send Message",false,CSGGroupsGUI[74])
	CSGGroupsGUI[77] = guiCreateButton(190,58,165,30,"Close Window",false,CSGGroupsGUI[74])
	-- Message to selected player window
	CSGGroupsGUI[78] = guiCreateWindow(314,366,364,98,"Send a note to a selected member",false)
	setWindowPrefs ( CSGGroupsGUI[78] )
	CSGGroupsGUI[79] = guiCreateEdit(9,24,346,32,"",false,CSGGroupsGUI[78])
	CSGGroupsGUI[80] = guiCreateButton(10,58,176,30,"Send Message",false,CSGGroupsGUI[78])
	CSGGroupsGUI[81] = guiCreateButton(190,58,165,30,"Close Window",false,CSGGroupsGUI[78])
	-- Leave group window
	CSGGroupsGUI[82] = guiCreateWindow(622,413,255,112,"Leave group warning",false)
	setWindowPrefs ( CSGGroupsGUI[82] )
	CSGGroupsGUI[85] = guiCreateLabel(36,28,190,17,"Do you want to leave the group?",false,CSGGroupsGUI[82])
	CSGGroupsGUI[83] = guiCreateButton(9,56,237,21,"Yes, I want to leave",false,CSGGroupsGUI[82])
	CSGGroupsGUI[84] = guiCreateButton(9,80,237,21,"No, I changed my mind",false,CSGGroupsGUI[82])
	-- Delete group window
	CSGGroupsGUI[87] = guiCreateWindow(530,328,239,166,"Delete your group",false)
	setWindowPrefs ( CSGGroupsGUI[87] )
	CSGGroupsGUI[90] = guiCreateLabel(87,25,62,17,"Username:",false,CSGGroupsGUI[87])
	CSGGroupsGUI[89] = guiCreateEdit(10,45,220,20,"",false,CSGGroupsGUI[87])
	guiSetEnabled( CSGGroupsGUI[89], false )
	CSGGroupsGUI[91] = guiCreateLabel(87,72,62,17,"Password:",false,CSGGroupsGUI[87])
	CSGGroupsGUI[92] = guiCreateEdit(10,91,220,20,"",false,CSGGroupsGUI[87])
	guiEditSetMasked( CSGGroupsGUI[92], true )
	CSGGroupsGUI[93] = guiCreateButton(11,115,218,19,"Yes I want to delete the group",false,CSGGroupsGUI[87])
	CSGGroupsGUI[94] = guiCreateButton(11,138,218,19,"No I want to keep it",false,CSGGroupsGUI[87])
	-- Set new leader window
	CSGGroupsGUI[95] = guiCreateWindow(622,413,255,112,"Set new leader",false)
	setWindowPrefs ( CSGGroupsGUI[95] )
	CSGGroupsGUI[98] = guiCreateLabel(36,28,190,17,"Do you want to set a new leader?",false,CSGGroupsGUI[95])
	CSGGroupsGUI[96] = guiCreateButton(9,56,237,21,"Yes, I do",false,CSGGroupsGUI[95])
	CSGGroupsGUI[97] = guiCreateButton(9,80,237,21,"No, I changed my mind",false,CSGGroupsGUI[95])
	-- Choose turf color window
	CSGGroupsGUI[100] = guiCreateWindow(583,273,207,240,"Change the turfcolor",false)
	setWindowPrefs ( CSGGroupsGUI[100] )
	CSGGroupsGUI[101] = guiCreateEdit(59,40,88,22,"225",false,CSGGroupsGUI[100])
	CSGGroupsGUI[102] = guiCreateLabel(56,24,91,18,"Red:",false,CSGGroupsGUI[100])
	guiLabelSetColor(CSGGroupsGUI[102],225,0,0)
	CSGGroupsGUI[103] = guiCreateLabel(56,71,91,18,"Green:",false,CSGGroupsGUI[100])
	guiLabelSetColor(CSGGroupsGUI[103],0,225,0)
	CSGGroupsGUI[104] = guiCreateEdit(59,90,88,22,"225",false,CSGGroupsGUI[100])
	CSGGroupsGUI[105] = guiCreateLabel(56,121,91,18,"Blue:",false,CSGGroupsGUI[100])
	guiLabelSetColor(CSGGroupsGUI[105],0,0,225)
	CSGGroupsGUI[106] = guiCreateEdit(59,139,88,22,"225",false,CSGGroupsGUI[100])
	CSGGroupsGUI[107] = guiCreateLabel(8,175,192,17,"Turf color example",false,CSGGroupsGUI[100])
	CSGGroupsGUI[108] = guiCreateButton(10,203,92,25,"Save",false,CSGGroupsGUI[100])
	CSGGroupsGUI[109] = guiCreateButton(105,203,92,25,"Close",false,CSGGroupsGUI[100])

	CSGGroupsGUI[110] = guiCreateButton(425,260,92,30,"Alliances",false,CSGGroupsGUI[3]) -- alliance button
	-- Group members
	column1 = guiGridListAddColumn( CSGGroupsGUI[30], "Nick (Accountname):", 0.30 )
	column2 = guiGridListAddColumn( CSGGroupsGUI[30], "Rank:", 0.20 )
	column0 = guiGridListAddColumn( CSGGroupsGUI[30], "Custom Rank:", 0.20 )
	column0 = guiGridListAddColumn( CSGGroupsGUI[30], "Points:", 0.20 )
	column3 = guiGridListAddColumn( CSGGroupsGUI[30], "Activity:", 0.18 )
	column3 = guiGridListAddColumn( CSGGroupsGUI[30], "Status:", 0.18 )
	-- Group maintenace
	column4 = guiGridListAddColumn( CSGGroupsGUI[37], "Nick (Accountname):", 0.90 )
	-- Group banking
	column5 = guiGridListAddColumn( CSGGroupsGUI[52], "Date:", 0.30 )
	column6 = guiGridListAddColumn( CSGGroupsGUI[52], "Transaction:", 0.60 )
	-- Group invites
	column7 = guiGridListAddColumn( CSGGroupsGUI[58], "Groupname:", 0.50 )
	column8 = guiGridListAddColumn( CSGGroupsGUI[58], "Invited by:", 0.40 )
	-- Groups
	column9 = guiGridListAddColumn( CSGGroupsGUI[63], "Groupname:", 0.40 )
	column90 = guiGridListAddColumn( CSGGroupsGUI[63], "Group Type:", 0.20 )
	column10 = guiGridListAddColumn( CSGGroupsGUI[63], "Membercount:", 0.25 )
	column11 = guiGridListAddColumn( CSGGroupsGUI[63], "Leader:", 0.20 )

	column50 = guiGridListAddColumn( CSGGroupsGUI[2502], "Member name:", 0.3 )
	column51 = guiGridListAddColumn( CSGGroupsGUI[2502], "Hydra:", 0.15 )
	column52 = guiGridListAddColumn( CSGGroupsGUI[2502], "Rustler:", 0.15 )
	column55 = guiGridListAddColumn( CSGGroupsGUI[2502], "Hunter:", 0.15 )
	column54 = guiGridListAddColumn( CSGGroupsGUI[2502], "Seasparrow:", 0.15 )
	column53 = guiGridListAddColumn( CSGGroupsGUI[2502], "Rhino:", 0.15 )

	-- Invite player
	column12 = guiGridListAddColumn( CSGGroupsGUI[66], "Nickname:", 0.30 )
	column13 = guiGridListAddColumn( CSGGroupsGUI[66], "Playtime:", 0.60 )

	---- new things
	CSGGroupsGUI[300] = guiCreateWindow(628,406,500,380,"Group Logs",false)
	setWindowPrefs ( CSGGroupsGUI[300] )
	guiSetAlpha(CSGGroupsGUI[300],0.8)
	CSGGroupsGUI[302] = guiCreateGridList(9,25,532,310,false,CSGGroupsGUI[300])
	column300 = guiGridListAddColumn( CSGGroupsGUI[302], "Logs:", 0.7 )
	column301 = guiGridListAddColumn( CSGGroupsGUI[302], "Date:", 0.5 )
	CSGGroupsGUI[304] = guiCreateButton(180,340,134,24,"Close window",false,CSGGroupsGUI[300])
	CSGGroupsGUI[338] = guiCreateButton(10,340,134,24,"Clear",false,CSGGroupsGUI[300])

	CSGGroupsGUI[305] = guiCreateWindow(628,406,500,380,"Group Ranks",false)
	setWindowPrefs ( CSGGroupsGUI[305] )
	guiSetAlpha(CSGGroupsGUI[305],0.8)
	CSGGroupsGUI[306] = guiCreateGridList(9,25,280,345,false,CSGGroupsGUI[305])
	column302 = guiGridListAddColumn( CSGGroupsGUI[306], "Custom Ranks:", 0.9 )
	CSGGroupsGUI[307] = guiCreateButton(330,340,130,30,"Close window",false,CSGGroupsGUI[305])
	CSGGroupsGUI[308] = guiCreateButton(330,130,130,30,"Add",false,CSGGroupsGUI[305])
	CSGGroupsGUI[309] = guiCreateButton(330,200,130,30,"Remove",false,CSGGroupsGUI[305])
	CSGGroupsGUI[310] = guiCreateEdit(330,80,130,30,"",false,CSGGroupsGUI[305])
	CSGGroupsGUI[311] = guiCreateLabel(350,50,130,30,"Insert Custom Rank",false,CSGGroupsGUI[305])
	guiSetFont(CSGGroupsGUI[311],"default-bold-small")

	CSGGroupsGUI[312] = guiCreateWindow(628,406,300,280,"Set Rank",false)
	setWindowPrefs ( CSGGroupsGUI[312] )
	guiSetAlpha(CSGGroupsGUI[312],0.8)
	CSGGroupsGUI[313] = guiCreateComboBox(20,80,240,280,"Rank",false,CSGGroupsGUI[312])
	CSGGroupsGUI[314] = guiCreateButton(80,130,130,30,"Set",false,CSGGroupsGUI[312])
	CSGGroupsGUI[315] = guiCreateButton(80,180,130,30,"Close",false,CSGGroupsGUI[312])


	PointsPanel.window[1] = guiCreateWindow(265, 210, 293, 173, "AUR ~ Group points", false)
	guiWindowSetSizable(PointsPanel.window[1], false)
	guiSetVisible(PointsPanel.window[1],false)
	setWindowPrefs ( PointsPanel.window[1] )
	PointsPanel.label[1] = guiCreateLabel(24, 25, 251, 27, "Give points to player", false, PointsPanel.window[1])
	guiSetFont(PointsPanel.label[1], "default-bold-small")
	guiLabelSetColor(PointsPanel.label[1], 248, 177, 6)
	guiLabelSetHorizontalAlign(PointsPanel.label[1], "center", false)
	guiLabelSetVerticalAlign(PointsPanel.label[1], "center")
	PointsPanel.edit[1] = guiCreateEdit(23, 85, 252, 32, "", false, PointsPanel.window[1])
	PointsPanel.button[1] = guiCreateButton(141, 127, 134, 32, "Set points", false, PointsPanel.window[1])
	guiSetProperty(PointsPanel.button[1], "NormalTextColour", "FFAAAAAA")
	PointsPanel.button[2] = guiCreateButton(23, 127, 108, 32, "Close", false, PointsPanel.window[1])
	guiSetProperty(PointsPanel.button[2], "NormalTextColour", "FFAAAAAA")
	PointsPanel.label[2] = guiCreateLabel(23, 58, 252, 22, "Current points:0", false, PointsPanel.window[1])
	guiSetFont(PointsPanel.label[2], "default-bold-small")
	guiLabelSetColor(PointsPanel.label[2], 47, 245, 8)
	guiLabelSetHorizontalAlign(PointsPanel.label[2], "center", false)
	guiLabelSetVerticalAlign(PointsPanel.label[2], "center")

	NamePanel.window[1] = guiCreateWindow(265, 210, 293, 173, "AUR ~ Group Tag", false)
	guiWindowSetSizable(NamePanel.window[1], false)
	setWindowPrefs ( NamePanel.window[1] )
	guiSetVisible(NamePanel.window[1],false)
	NamePanel.label[1] = guiCreateLabel(24, 25, 251, 27, "Change player tag", false, NamePanel.window[1])
	guiSetFont(NamePanel.label[1], "default-bold-small")
	guiLabelSetColor(NamePanel.label[1], 248, 177, 6)
	guiLabelSetHorizontalAlign(NamePanel.label[1], "center", false)
	guiLabelSetVerticalAlign(NamePanel.label[1], "center")
	NamePanel.edit[1] = guiCreateEdit(23, 85, 252, 32, "", false, NamePanel.window[1])
	NamePanel.button[1] = guiCreateButton(141, 127, 134, 32, "Change", false, NamePanel.window[1])
	guiSetProperty(NamePanel.button[1], "NormalTextColour", "FFAAAAAA")
	NamePanel.button[2] = guiCreateButton(23, 127, 108, 32, "Close", false, NamePanel.window[1])
	guiSetProperty(NamePanel.button[2], "NormalTextColour", "FFAAAAAA")
--	NamePanel.label[2] = guiCreateLabel(23, 58, 252, 22, "Current Name:", false, NamePanel.window[1])
--	guiSetFont(NamePanel.label[2], "default-bold-small")
--	guiLabelSetColor(NamePanel.label[2], 47, 245, 8)
--	guiLabelSetHorizontalAlign(NamePanel.label[2], "center", false)
---	guiLabelSetVerticalAlign(NamePanel.label[2], "center")

	SlotsWnd.window[1] = guiCreateWindow(173, 223, 446, 142, "AUR ~ Group slots shop", false)
	guiWindowSetSizable(SlotsWnd.window[1], false)
	setWindowPrefs ( SlotsWnd.window[1] )
	SlotsWnd.label[1] = guiCreateLabel(124, 26, 181, 28, "Slot Cost $500,000", false, SlotsWnd.window[1])
	guiSetFont(SlotsWnd.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(SlotsWnd.label[1], "center", false)
	guiLabelSetVerticalAlign(SlotsWnd.label[1], "center")
	SlotsWnd.label[2] = guiCreateLabel(156, 64, 181, 23, "Current slots: ", false, SlotsWnd.window[1])
	guiSetFont(SlotsWnd.label[2], "default-bold-small")
	SlotsWnd.label[3] = guiCreateLabel(21, 97, 103, 23, "Cost : $0", false, SlotsWnd.window[1])
	guiSetFont(SlotsWnd.label[3], "default-bold-small")
	guiLabelSetVerticalAlign(SlotsWnd.label[3], "center")
	SlotsWnd.edit[1] = guiCreateEdit(149, 97, 146, 23, "", false, SlotsWnd.window[1])
	SlotsWnd.button[1] = guiCreateButton(334, 94, 96, 26, "Buy", false, SlotsWnd.window[1])
	guiSetProperty(SlotsWnd.button[1], "NormalTextColour", "FFAAAAAA")
	SlotsWnd.button[2] = guiCreateButton(399, 22, 31, 22, "X", false, SlotsWnd.window[1])
	guiSetFont(SlotsWnd.button[2], "default-bold-small")
	guiSetProperty(SlotsWnd.button[2], "NormalTextColour", "FFFF0000")
	-----------

	groupX.window[1] = guiCreateWindow(40, 69, 551, 426, "AUR ~ Group Exp & Levels stats", false)
	guiWindowSetSizable(groupX.window[1], false)
	guiSetVisible(groupX.window[1],false)
	setWindowPrefs ( groupX.window[1] )

	---groupX.tabpanel[1] = guiCreateTabPanel(9, 27, 500, 390, false, groupX.window[1])

	--[[groupX.tab[1] = guiCreateTab("Information", groupX.tabpanel[1])

	groupX.label[1] = guiCreateLabel(89, 10, 494, 34, "Welcome to Levels and Exp information center", false, groupX.tab[1])
	guiSetFont(groupX.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(groupX.label[1], "center", false)
	guiLabelSetVerticalAlign(groupX.label[1], "center")
	groupX.label[2] = guiCreateLabel(8, 63, 102, 22, "Group Name :", false, groupX.tab[1])
	guiSetFont(groupX.label[2], "default-bold-small")
	groupX.label[3] = guiCreateLabel(390, 63, 102, 22, "Group Type :", false, groupX.tab[1])
	guiSetFont(groupX.label[3], "default-bold-small")
	groupX.label[4] = guiCreateLabel(8, 127, 102, 22, "Group Founder :", false, groupX.tab[1])
	guiSetFont(groupX.label[4], "default-bold-small")
	groupX.label[5] = guiCreateLabel(390, 127, 102, 22, "Group Level :", false, groupX.tab[1])
	guiSetFont(groupX.label[5], "default-bold-small")
	groupX.label[6] = guiCreateLabel(8, 191, 102, 22, "Group XP :", false, groupX.tab[1])
	guiSetFont(groupX.label[6], "default-bold-small")
	groupX.label[7] = guiCreateLabel(127, 63, 102, 22, "N.A", false, groupX.tab[1])
	guiSetFont(groupX.label[7], "default-bold-small")
	groupX.label[8] = guiCreateLabel(527, 63, 102, 22, "N.A", false, groupX.tab[1])
	guiSetFont(groupX.label[8], "default-bold-small")
	groupX.label[9] = guiCreateLabel(127, 127, 102, 22, "N.A", false, groupX.tab[1])
	guiSetFont(groupX.label[9], "default-bold-small")
	groupX.label[10] = guiCreateLabel(527, 127, 102, 22, "N.A", false, groupX.tab[1])
	guiSetFont(groupX.label[10], "default-bold-small")
	groupX.label[11] = guiCreateLabel(127, 191, 102, 22, "N.A", false, groupX.tab[1])
	guiSetFont(groupX.label[11], "default-bold-small")]]

	--groupX.tab[2] = guiCreateTab("Stats", groupX.tabpanel[1])
	groupX.gridlist[1] = guiCreateGridList(6, 40, 661, 326, false, groupX.window[1])
	lbl = guiCreateLabel(6, 370, 181, 28, "", false, groupX.window[1])
	guiSetFont(lbl, "default-bold-small")
	guiLabelSetHorizontalAlign(lbl, "center", false)
	guiLabelSetVerticalAlign(lbl, "center")

	guiGridListAddColumn(groupX.gridlist[1], "Exp", 0.2)
	guiGridListAddColumn(groupX.gridlist[1], "Activity", 0.8)
	--[[guiGridListAddColumn(groupX.gridlist[1], "Data3", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data4", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data5", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data6", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data7", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data8", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data9", 0.1)
	guiGridListAddColumn(groupX.gridlist[1], "Data10", 0.1)]]
	addEventHandler("onClientGUIClick",root,function()
		if source == groupX.window[1] then
			guiSetVisible(groupX.window[1],false)
		elseif source == groupX.gridlist[1] then
			guiSetVisible(groupX.window[1],false)
		end
	end)
	-------------

	setGroupGUIData ()

	-- Leave group handlers
	addEventHandler( "onClientGUIChanged", SlotsWnd.edit[1], removeLetters3, false )
	addEventHandler( "onClientGUIChanged", PointsPanel.edit[1], removeLetters2, false )
	addEventHandler( "onClientGUIClick", SlotsWnd.button[1], buySlots, false )
	addEventHandler( "onClientGUIClick", SlotsWnd.button[2], closeSlots, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[1500], toggleSlots, false )
	--addEventHandler( "onClientGUIClick", CSGGroupsGUI[800], renamemember, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[700], setPoints, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[314], applyTheRank, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[501], showRanks, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[500], ToggleLogs, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[307], onCloseRanks, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[304], onCloseLogs, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[338], deletelogs, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[315], onCloseSetRank, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[308], addRank, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[309], removeRank, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[502], setPlayerRank, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[600], warnPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[601], unwarnPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[17], onClientShowLeavePopup, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[84], onClientCancelLeave, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[83], onClientLeaveGroup, false )
	-- Close popup window
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[73], setGroupsWindowDisabled, false )
	-- Create new group handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[4] , onClientCreateNewGroup, false )
	-- Update group information handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[34], onClientUpdateGroupInformation, false )
	-- Group banking handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[54], onClientGroupBankingDeposit, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[53], onClientGroupBankingWithdraw, false )
	-- Group invites handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[59], onClientAcceptGroupInvite, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[60], onClientDeleteGroupInvite, false )
	-- Note to members handlers
	--addEventHandler( "onClientGUIClick", CSGGroupsGUI[40], onClientNoteToPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[40], onClientXPWnd, false )
	--addEventHandler( "onClientGUIClick", CSGGroupsGUI[39], onClientNoteToAllPlayers, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[39], onClientUpgradeLevel, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[81], onClientCancelNoteToPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[77], onClientCancelNoteToAllPlayers, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[80], onClientSendNoteToPlayer, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[76], onClientSendNoteToAllPlayers, false )
	-- Invite member handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[41]  , onClientGroupInviteWindow, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[68]  , onClientGroupInviteCancel, false )
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[67]  , onClientGroupInviteSend, false )
	-- Handlers for kicking
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[44], onClientGroupKickPlayer, false)
	-- Turf color change handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[45], onClientGroupChangeTurfColor, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[108], onClientGroupApplyTurfColor, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[109], onClientGroupCancelTurfColor, false)
	-- Set new leader handlers
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[47], onClientGroupSetNewFounder, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[97], onClientGroupCancelNewFounder, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[96], onClientGroupApplyNewFounder , false)
	-- Promote and demote handler
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[42], onClientPromoteMember, false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[43], onClientDemoteMember , false)
	-- Delete group
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[46], onClientDeleteGroup , false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[93], onClientDeleteGroupConfirm , false)
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[94], onClientDeleteGroupCancel , false)
	-- Alliances
	addEventHandler( "onClientGUIClick", CSGGroupsGUI[110], onClientOpenAllianceGUI , false)
	-- more


end

function removeLetters2(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end
function removeLetters3(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
	if string.len( tostring( guiGetText(element) ) ) > 2 then
		guiSetText(element,"")
		guiSetText(SlotsWnd.label[3],"Cost: $0")
	end
	local txts = guiGetText(element)
	if ( txts ~= "" and tonumber( txts2 ) and tonumber( txts2 ) <= 10 ) then
		guiSetText( SlotsWnd.label[3], "Cost: $"..exports.server:convertNumber(tonumber( txts ) * 500000))
	else
		guiSetText( SlotsWnd.label[3], "Cost: $0")
	end
end

addEvent("recieveMemberPoint",true)
addEventHandler("recieveMemberPoint",root,function(point)
	guiSetText(PointsPanel.label[2],"Current Points: "..point)
end)

function setPoints()
	local thePlayer,account = getSelectedMaintenanceTabPlayer()
	if thePlayer and isElement(thePlayer) then
		guiSetVisible(PointsPanel.window[1],true)
		guiBringToFront( PointsPanel.window[1] )
		guiSetProperty( PointsPanel.window[1], "AlwaysOnTop", "True" )
		triggerServerEvent("callGroupMemberPoints",localPlayer,thePlayer)
	elseif account then
		guiSetVisible(PointsPanel.window[1],true)
		guiBringToFront( PointsPanel.window[1] )
		guiSetProperty( PointsPanel.window[1], "AlwaysOnTop", "True" )
		triggerServerEvent("callGroupAccountPoints",localPlayer,account)
	else
		exports.NGCdxmsg:createNewDxMessage("Select member first",255,0,0)
	end
end


addEvent("reCallGroupSlot",true)
addEventHandler("reCallGroupSlot",root,function(x)
	if x and  tonumber(x) == 40 then
		guiSetText(SlotsWnd.label[2],"Current Slots: "..x.."/40")
--		exports.NGCnote:addNote("SlotsWarning","#FFFFFF[Groups Slots] #FF0000You have 40 slots!!",255,0,0,5000)
	else
		if x then
			guiSetText(SlotsWnd.label[2],"Current Slots: "..x.."/40")
		end
	end
end)

function onClientXPWnd()
	---if getElementData(localPlayer,"isPlayerPrime") then
		guiSetVisible(groupX.window[1],true)
		guiBringToFront( groupX.window[1] )
		guiSetProperty( groupX.window[1], "AlwaysOnTop", "True" )
		triggerServerEvent("callGroupXP",localPlayer)
		exports.NGCdxmsg:createNewDxMessage("(To reach Level 1) Upgrade required 2000 XP & $100,000",255,250,0)
		exports.NGCdxmsg:createNewDxMessage("(To reach Level 2) Upgrade required 5000 XP & $300,000",255,250,0)
		exports.NGCdxmsg:createNewDxMessage("(To reach Level 3) Upgrade required 9500 XP & $500,000",255,250,0)
		exports.NGCdxmsg:createNewDxMessage("(To reach Level 4) Upgrade required 15000 XP & $700,000",255,250,0)
		exports.NGCdxmsg:createNewDxMessage("(To reach Level 5) Upgrade required 30000 XP & $1,000,000",255,250,0)

	--end
end

function onClientUpgradeLevel()
	--if getElementData(localPlayer,"isPlayerPrime") then
		if getElementData(localPlayer,"GroupRank") == "Group Leader" then
			triggerServerEvent("onFounderUpgradeGroup",localPlayer)
		end
	--end
end

local nFont = guiCreateFont( "font.ttf", 12 )
local nFont2 = guiCreateFont( "font.ttf", 8 )
local viewingAchievement = false
local screenW, screenH = guiGetScreenSize()
function createImage()
    auImage = guiCreateStaticImage((screenW / 2) - 260, (screenH / 2) + 150, 320, 100, "msg.png", false)
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(auImage,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(auImage,x+20,y+150,false)
	guiSetVisible(auImage, false)
	guiSetProperty(auImage, "AlwaysOnTop", "true")
    auLabel1 = guiCreateLabel(10, 15, 324, 53, "Groups ~ Experience points", false, auImage)
    auLabel = guiCreateLabel(10, 55, 324, 53, "", false, auImage)
	guiLabelSetColor(auLabel1,250,135,0)
	guiSetFont(auLabel1,nFont)
	guiSetFont(auLabel,nFont2)
    guiLabelSetHorizontalAlign(auLabel1, "center", false)
	guiLabelSetHorizontalAlign(auLabel, "center", false)
end
addEventHandler("onClientResourceStart", resourceRoot, createImage)

function unlockAch(ach, desc)
	if (viewingAchievement) then setTimer(unlockAch, 8000, 1, ach, desc) return end
    guiSetText(auLabel, ach.."\n+"..desc.." to your group")
    guiBringToFront(auImage)
    guiSetVisible(auImage, true)


    viewingAchievement = true
    local function hideAchievementUnlocked()
        guiSetVisible(auImage, false)
        viewingAchievement = false
    end
    setTimer(hideAchievementUnlocked, 8000, 1)
end
addEvent( "setXPMsg", true )
addEventHandler( "setXPMsg",root, unlockAch)


local toadd = {
	["Criminals"] = {
		[1] = {"Kill in lv",5},
		[2] = {"Turf taken",1},
		[3] = {"Cop killer in CnR event",20},
		[4] = {"Taken RT",2},
		[5] = {"Destroyed AT",15},
		[6] = {"Success CnR event",20},
		[7] = {"Store robbed",5},
		[8] = {"Success MR",20},
		[9] = {"Success Drug truck escort",20},
		[10] = {"Armor Delivery",10},
		[11] = {"Killed a cop",3}, ---added
	},
	["Law"] = {
		[1] = {"Jail someone with Tazer assists",5},
		[2] = {"Turf taken",1},
		[3] = {"Criminal killed in CnR event",20},
		[4] = {"Taken RT",2},
		[5] = {"Success AT",15},
		[6] = {"Success CnR event",20},
		[7] = {"Jailed a criminal",5},
		[8] = {"x3 Criminals jailed",20},
		[9] = {"Jailed +800 WP criminal",30},
		[10] = {"Success Hostages Rescue",10},
	},
	["other"] = {
		[1] = {"Working as a Clothes Seller",7}, --- added
		[2] = {"Working as a Clothes Seller",5}, -- added
		[3] = {"Working as a Trash Collector",3}, -- added
		[4] = {"Working as a Trucker",7}, --- added
		[5] = {"Working as a Pilot",7}, -- added
		[6] = {"Working as a Street Cleaner",2}, --- added
		[7] = {"Working as a Mechanic",3}, ---- added
		[8] = {"Working as a Farmer",0.5}, ---- added
		[9] = {"Working as a Lumberjack",2}, --- added
		[10] = {"Working as a Rescuer Man",3}, -- added
		[11] = {"Working as a Taxi Driver",4}, -- added
		[12] = {"Working as a Miner",3}, -- added
	},
}

addEvent("returnGroupStats",true)
addEventHandler("returnGroupStats",root,function(groupType,stats)
	guiGridListClear(groupX.gridlist[1])
--	if groupType == "Criminals" then
	if groupType then
		if toadd[groupType] then
			for i=1,#toadd[groupType] do
				local row = guiGridListAddRow ( groupX.gridlist[1] )
				--guiGridListSetColumnTitle(groupX.gridlist[1],i,toadd[groupType][i][1])
				guiGridListSetItemText(groupX.gridlist[1],row,1,toadd[groupType][i][2],false,false)
				guiGridListSetItemText(groupX.gridlist[1],row,2,toadd[groupType][i][1],false,false)
				for k,v in ipairs(stats) do
					guiGridListSetItemText(groupX.gridlist[1],row,1,v["action"..i],false,false)
				end
			end
		end
	end
	--end
end)

function toggleSlots()
	if source == CSGGroupsGUI[1500] then
		--if getElementData(localPlayer,"isPlayerPrime") then
			guiSetVisible(SlotsWnd.window[1],true)
			guiBringToFront( SlotsWnd.window[1] )
			guiSetProperty( SlotsWnd.window[1], "AlwaysOnTop", "True" )
			triggerServerEvent("getGroupSlot",localPlayer)
		--end
	end
end
groupslot = false
function buySlots()
	if source == SlotsWnd.button[1] then
		if ( groupslot ) and ( getTickCount()-groupslot < 6000 ) then
			exports.NGCdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
		else
			local amount = guiGetText(SlotsWnd.edit[1])
			local amount = tonumber(amount)
			local cost = amount*500000
			local cost = tonumber(cost)
			if amount and amount > 0 and amount <= 10 then
				triggerServerEvent("buyNewGroupSlot",localPlayer,cost,amount)
				groupWarnSpam = getTickCount()
			end
		end
	end
end

function closeSlots()
	if source == SlotsWnd.button[2] then
		guiSetVisible(SlotsWnd.window[1],false)
	end
end

function renamemember()
	local thePlayer,account = getSelectedMaintenanceTabPlayer()
	if thePlayer and isElement(thePlayer) then
		guiSetVisible(NamePanel.window[1],true)
		guiBringToFront( NamePanel.window[1] )
		guiSetProperty( NamePanel.window[1], "AlwaysOnTop", "True" )
	else
		exports.NGCdxmsg:createNewDxMessage("Select online player!",255,0,0)
	end
end
stopnoobs = {}
function morecheck()
	if source == blacklist.button[2] then
		local blacklist = guiGridListGetItemText(blacklist.gridlist[1], guiGridListGetSelectedItem(blacklist.gridlist[1]), 1)
		if blacklist then
			triggerServerEvent("removeBlacklist",localPlayer,blacklist)
		end
	elseif source == blacklist.button[1] then
		local account = guiGetText(blacklist.edit[1])
		local name = guiGetText(blacklist.edit[2])
		if guiRadioButtonGetSelected(blacklist.radiobutton[1]) then
			selectedLevel = 1
		elseif guiRadioButtonGetSelected(blacklist.radiobutton[2]) then
			selectedLevel = 2
		elseif guiRadioButtonGetSelected(blacklist.radiobutton[3]) then
			selectedLevel = 3
		elseif guiRadioButtonGetSelected(blacklist.radiobutton[4]) then
			selectedLevel = 4
		end
		if account and name and selectedLevel then
			triggerServerEvent("insertBlackList",localPlayer,account,name,selectedLevel)
		else
			exports.NGCdxmsg:createNewDxMessage("Please fill all the fields",255,0,0)
		end
	elseif source == PointsPanel.button[1] then
		local points = guiGetText(PointsPanel.edit[1])
		if points and tonumber(points) then
			local thePlayer,account = getSelectedMaintenanceTabPlayer()
			if thePlayer and isElement(thePlayer) then
				triggerServerEvent("setMemberPoints",localPlayer,points,thePlayer)
			elseif account then
				triggerServerEvent("setAccountPoints",localPlayer,points,account)
			else
				exports.NGCdxmsg:createNewDxMessage("Please select member or account!!",255,0,0)
			end
		end
	elseif source == PointsPanel.button[2] then
		guiSetVisible(PointsPanel.window[1],false)
	elseif source == NamePanel.button[1] then
		local tag = guiGetText(NamePanel.edit[1])
		if tag then
			if isTimer(stopnoobs) then exports.NGCdxmsg:createNewDxMessage("Please wait few seconds before you spam this button!",255,0,0) return false end
			local thePlayer,account = getSelectedMaintenanceTabPlayer()
			if thePlayer and isElement(thePlayer) then
				stopnoobs = setTimer(function() end,5000,1)
				triggerServerEvent("changePlayerNickName",localPlayer,thePlayer,tag)
			else
				exports.NGCdxmsg:createNewDxMessage("Please select an online player",255,0,0)
			end
		end
	elseif source == NamePanel.button[2] then
		guiSetVisible(NamePanel.window[1],false)
	end
end
addEventHandler( "onClientGUIClick",root,morecheck)

addEvent("blacklistsTable",true)
addEventHandler("blacklistsTable",root,function(list)
	guiGridListClear(blacklist.gridlist[1])
	for key, punish in pairs( list ) do
		local row = guiGridListAddRow ( blacklist.gridlist[1] )
		guiGridListSetItemText(blacklist.gridlist[1],row,1,tostring(punish["accountname"]),false,false)
		guiGridListSetItemText(blacklist.gridlist[1],row,2,tostring(punish["name"]),false,false)
		guiGridListSetItemText(blacklist.gridlist[1],row,3,tostring(punish["blacklistedby"]),false,false)
		guiGridListSetItemText(blacklist.gridlist[1],row,4,tostring(punish["level"]),false,false)
	end
end)

-- Create all GUI elements on start of the resource
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		createGroupWindows()
	end
)

function setPlayerRank()
	local thePlayer,account = getSelectedMaintenanceTabPlayer()
	if thePlayer and isElement(thePlayer) then
		guiSetVisible(CSGGroupsGUI[312],true)
		guiBringToFront( CSGGroupsGUI[312] )
		guiSetProperty( CSGGroupsGUI[312], "AlwaysOnTop", "True" )
		triggerServerEvent("getGroupRank",localPlayer)
	elseif account then
		guiSetVisible(CSGGroupsGUI[312],true)
		guiBringToFront( CSGGroupsGUI[312] )
		guiSetProperty( CSGGroupsGUI[312], "AlwaysOnTop", "True" )
		triggerServerEvent("getGroupRank",localPlayer)
	else
		exports.NGCdxmsg:createNewDxMessage("Select player first",255,0,0)
	end
end

local groupWarnSpam = false
function warnPlayer()
	if ( groupWarnSpam ) and ( getTickCount()-groupWarnSpam < 6000 ) then
		exports.NGCdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	else
		local thePlayer,account = getSelectedMaintenanceTabPlayer()
		if thePlayer and isElement(thePlayer) then
			triggerServerEvent("onPlayerGroupWarn",localPlayer,thePlayer)
		elseif account then
			triggerServerEvent("onAccountGroupWarn",localPlayer,account)
		else
			exports.NGCdxmsg:createNewDxMessage("Select player first",255,0,0)
		end
		groupWarnSpam = getTickCount()
	end
end

local groupWarnSpam2 = false
function unwarnPlayer()
	if ( groupWarnSpam2 ) and ( getTickCount()-groupWarnSpam2 < 6000 ) then
		exports.NGCdxmsg:createNewDxMessage( "Due preventing spam you need to wait a few seconds to do this!", 200, 0, 0 )
	else
		local thePlayer,account = getSelectedMaintenanceTabPlayer()
		if thePlayer and isElement(thePlayer) then
			triggerServerEvent("onPlayerGroupUnWarn",localPlayer,thePlayer)
		elseif account then
			triggerServerEvent("onAccountGroupUnWarn",localPlayer,account)
		else
			exports.NGCdxmsg:createNewDxMessage("Select player first",255,0,0)
		end
		groupWarnSpam2 = getTickCount()
	end
end

function applyTheRank()
	local thePlayer,account = getSelectedMaintenanceTabPlayer()
	if thePlayer and isElement(thePlayer) then
		local item = guiComboBoxGetSelected(CSGGroupsGUI[313])
		local text = guiComboBoxGetItemText(CSGGroupsGUI[313], item)
		if text ~= "Rank" then
			local access = false
			triggerServerEvent("applyRank",localPlayer,thePlayer,text,access)
			exports.NGCdxmsg:createNewDxMessage("Rank applied successfully", 0, 255, 0)
		else
			exports.NGCdxmsg:createNewDxMessage("Choose Rank!!", 0, 255, 0)
		end
	else
		local item = guiComboBoxGetSelected(CSGGroupsGUI[313])
		local text = guiComboBoxGetItemText(CSGGroupsGUI[313], item)
		if text ~= "Rank" then
			local access = true
			triggerServerEvent("applyRank",localPlayer,thePlayer,text,access,account)
			exports.NGCdxmsg:createNewDxMessage("Rank applied successfully", 0, 255, 0)
		else
			exports.NGCdxmsg:createNewDxMessage("Choose Rank!!", 0, 255, 0)
		end
	end
end


function ToggleLogs()
	guiSetVisible(CSGGroupsGUI[300],true)
	guiBringToFront( CSGGroupsGUI[300] )
	guiSetProperty( CSGGroupsGUI[300], "AlwaysOnTop", "True" )
	triggerServerEvent("TransferFromLogs",localPlayer)
end

function showRanks()
	guiSetVisible(CSGGroupsGUI[305],true)
	guiBringToFront( CSGGroupsGUI[305] )
	guiSetProperty( CSGGroupsGUI[305], "AlwaysOnTop", "True" )
	triggerServerEvent("getGroupRank",localPlayer)
end

function onCloseSetRank()
	guiComboBoxClear(CSGGroupsGUI[313])
	guiSetVisible( CSGGroupsGUI[312], false )
end
function onCloseRanks()
	guiGridListClear ( CSGGroupsGUI[306] )
	guiSetVisible( CSGGroupsGUI[305], false )
end
function onCloseLogs()
	guiGridListClear ( CSGGroupsGUI[302] )
	guiSetVisible( CSGGroupsGUI[300], false )
end

function deletelogs()
	guiGridListClear ( CSGGroupsGUI[302] )
	triggerServerEvent("cleanGroupLog",localPlayer)
end

addEvent("recivedRanks",true)
addEventHandler("recivedRanks",root,function(RanksDB)
	guiGridListClear( CSGGroupsGUI[306] )
	guiComboBoxClear(CSGGroupsGUI[313])
	for key, punish in pairs( RanksDB ) do
		local row = guiGridListAddRow ( CSGGroupsGUI[306] )
		guiGridListSetItemText(CSGGroupsGUI[306],row,column302,tostring(punish["rank"]),false,false)
		guiComboBoxAddItem ( CSGGroupsGUI[313], punish["rank"] )
	end
end)

addEvent("recivedLogsToGroup",true)
addEventHandler("recivedLogsToGroup",root,function(damnLogs)
	guiGridListClear ( CSGGroupsGUI[302] )
	for key, punish in pairs( damnLogs ) do
		local row = guiGridListAddRow ( CSGGroupsGUI[302] )
		guiGridListSetItemText(CSGGroupsGUI[302],row,column301,tostring(punish["timestamp"]),false,false)
		guiGridListSetItemText(CSGGroupsGUI[302],row,column300,tostring(punish["log"]),false,false)
    end
end)

function removeRank()
	local gr = guiGridListGetItemText(CSGGroupsGUI[306], guiGridListGetSelectedItem(CSGGroupsGUI[306]), 1)
	triggerServerEvent("removeRank",localPlayer,gr)
	triggerServerEvent("getGroupRank",localPlayer)
end

function addRank()
	local name = guiGetText(CSGGroupsGUI[310])
	if string.len(name) > 20 or string.len(name) <= 3 then
		exports.NGCdxmsg:createNewDxMessage("Your rank name is too long or short. Please try again with shorter/longer rank name.", 255, 0, 0)
	else
		if string.match (name, "None") or string.match(name, '[0-9]') or not tostring(name) then
			exports.NGCdxmsg:createNewDxMessage("You can't add this name as rank!", 255, 0, 0)
		else
				triggerServerEvent("addGroupRank", localPlayer, name)
				exports.NGCdxmsg:createNewDxMessage("Rank added successfully", 0, 255, 0)
				triggerServerEvent("getGroupRank",localPlayer)
		end
	end
end


-- Get the GUI table
function getGroupsTableGUI ()
	return CSGGroupsGUI
end

function getGroupsTypeGUI ()
	return AURGroupsGUI
end

-- Center the window and set is not visable untill we need it
function setWindowPrefs ( theWindow )
	guiWindowSetMovable ( theWindow, true )
	guiWindowSetSizable ( theWindow, false )
	guiSetVisible ( theWindow, false )

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end

-- Get the selected player in the maintenance tab
function getSelectedMaintenanceTabPlayer ()
	local theAccountName = nickToPlayer[guiGridListGetItemText ( CSGGroupsGUI[37], guiGridListGetSelectedItem ( CSGGroupsGUI[37] ), 1 )]
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[37] )
	if ( theAccountName ) and ( tostring( row ) ~= "-1" ) then
		local thePlayer = exports.server:getPlayerFromAccountname ( theAccountName )
		if ( thePlayer ) and ( isElement( thePlayer ) ) then
			return thePlayer, theAccountName
		else
			return false, theAccountName
		end
	else
		return false, false
	end
end

-- Get the selected member from the invites grid
function getSelectedInviteTabPlayer ()
	local thePlayerName = guiGridListGetItemText ( CSGGroupsGUI[66], guiGridListGetSelectedItem ( CSGGroupsGUI[66] ), 1 )
	if ( thePlayerName ) and ( getPlayerFromName( thePlayerName ) ) then
		return getPlayerFromName( thePlayerName )
	else
		return false
	end
end

-- Set some GUI element data
function setGroupGUIData ()
	for i=1,#CSGGroupsGUI do
		if i == 7 or i == 8 or i == 9 or i == 10 or i == 11 or i == 12 or i == 13 or i == 15 or i == 18 or i == 19 or i == 29 or i == 32 or i == 36  or i ==51 or i == 57 or i == 62 or i == 70 or i == 85 or i == 90 or i == 91 or i == 98 or i == 102 or i == 103 or i == 105 or i == 1600 or i == 1601 or i == 1602 or i == 1603 or i == 1604 or i == 1605 then
			guiSetFont(CSGGroupsGUI[i],"default-bold-small")
		end

		if i == 30 or i == 37 or i == 52 or i == 58 or i == 63 or i == 66 then
			guiGridListSetSelectionMode(CSGGroupsGUI[i],0)
		end

		if i == 70 or i == 71 or i == 72 or i == 102 or i == 103 or i == 105 or i == 107 then
			guiLabelSetHorizontalAlign(CSGGroupsGUI[i],"center",false)
		end
	end
end

-- Clear all the gridlists
function clearAllGroupGrids ()
	guiGridListClear ( CSGGroupsGUI[30] )
	guiGridListClear ( CSGGroupsGUI[37] )
	guiGridListClear ( CSGGroupsGUI[52] )
	guiGridListClear ( CSGGroupsGUI[58] )
	guiGridListClear ( CSGGroupsGUI[2502] )
	guiGridListClear ( CSGGroupsGUI[63] )
	guiGridListClear ( CSGGroupsGUI[66] )
	guiGridListClear( CSGGroupsGUI[306] )
	guiComboBoxClear(CSGGroupsGUI[313])
end

-- Get the state of the groups window
function getGroupWindowVisable ()
	if ( guiGetVisible ( CSGGroupsGUI[1] ) ) then
		return true
	else
		return false
	end
end

-- Set the groups window disabled
function setGroupsWindowDisabled ()
	guiSetVisible ( CSGGroupsGUI[1] , false )
	guiSetVisible ( CSGGroupsGUI[69], false )
	guiSetVisible ( CSGGroupsGUI[64], false )
	guiSetVisible ( CSGGroupsGUI[74], false )
	guiSetVisible ( CSGGroupsGUI[78], false )
	guiSetVisible ( CSGGroupsGUI[82], false )
	guiSetVisible ( CSGGroupsGUI[87], false )
	guiSetVisible ( CSGGroupsGUI[95], false )
	guiSetVisible ( CSGGroupsGUI[100], false )
	guiSetVisible ( groupX.window[1], false )
	guiSetVisible ( CSGGroupsGUI[300], false )
	guiSetVisible ( CSGGroupsGUI[305], false )
	guiSetVisible ( CSGGroupsGUI[312], false )
	guiSetVisible ( SlotsWnd.window[1], false )
	guiSetVisible ( PointsPanel.window[1], false )
	guiSetVisible ( NamePanel.window[1], false )
	showCursor( false )
end

-- Hide the group window though server
addEvent( "onClientFinishGroupCreate", true )
addEventHandler( "onClientFinishGroupCreate", root,
	function ( state )
		local state = state or false
		guiSetVisible ( CSGGroupsGUI[1] , false )
		guiSetVisible ( CSGGroupsGUI[69], state )
		guiSetVisible ( CSGGroupsGUI[64], false )
		guiSetVisible ( CSGGroupsGUI[74], false )
		guiSetVisible ( CSGGroupsGUI[78], false )
		guiSetVisible ( CSGGroupsGUI[82], false )
		guiSetVisible ( CSGGroupsGUI[87], false )
		guiSetVisible ( CSGGroupsGUI[95], false )
		guiSetVisible ( CSGGroupsGUI[100], false )
		guiSetVisible ( groupX.window[1], false )
		guiSetVisible ( CSGGroupsGUI[300], false )
		guiSetVisible ( CSGGroupsGUI[305], false )
		guiSetVisible ( CSGGroupsGUI[312], false )
		guiSetVisible ( SlotsWnd.window[1], false )
		guiSetVisible ( PointsPanel.window[1], false )
		guiSetVisible ( NamePanel.window[1], false )
		showCursor( state )
	end
)

-- Hide the groups window
addEvent( "onClientHideGroupsWindow", true )
addEventHandler( "onClientHideGroupsWindow", root,
	function ()
		guiSetVisible ( CSGGroupsGUI[1] , false )
		guiSetVisible ( CSGGroupsGUI[82], false )
		showCursor( false )
	end
)

-- Reset the tabels
function resetGroupLabels ()
	--guiSetText( CSGGroupsGUI[450], "N/A" )
	guiSetText( CSGGroupsGUI[20], "N/A" )
	guiSetText( CSGGroupsGUI[21], "N/A" )
	guiSetText( CSGGroupsGUI[22], "N/A" )
	guiSetText( CSGGroupsGUI[23], "N/A" )
	guiSetText( CSGGroupsGUI[24], "N/A" )
	guiSetText( CSGGroupsGUI[25], "N/A" )
	guiSetText( CSGGroupsGUI[51], "Last bank transactions: (Current balance: $0)" )
	guiSetText( CSGGroupsGUI[26], "N/A" )
	guiSetText( CSGGroupsGUI[27], "N/A" )
	guiSetText( CSGGroupsGUI[1601], "N/A" )
	guiSetText( CSGGroupsGUI[1603], "N/A" )
	guiSetText( CSGGroupsGUI[1605], "N/A" )
	guiSetText( CSGGroupsGUI[33], "" )
end

g = "Criminals"

addCommandHandler("gg",function(cmd,int)
	g = int
end)

addEventHandler ( 'onClientGUIDoubleClick', root, function ( btn )
	if ( source == CSGGroupsGUI[63] ) then
		if getElementData(localPlayer,"isPlayerPrime") then
			local row, col = guiGridListGetSelectedItem ( CSGGroupsGUI[63] )
			if ( row ~= -1 and col ~= 0 ) then
				local name = guiGridListGetItemText(CSGGroupsGUI[63], guiGridListGetSelectedItem(CSGGroupsGUI[63]), 1)
				--triggerServerEvent("primeForcedGroupsToDelete",localPlayer,name)
				triggerServerEvent("primeForcedGroupsXP",localPlayer,name,g)
			end
		end
	end
end)

function getSelectedPlayer ()
	local theAccountName = nickToPlayer[guiGridListGetItemText ( CSGGroupsGUI[2502], guiGridListGetSelectedItem ( CSGGroupsGUI[2502] ), 1 )]
	local row, column = guiGridListGetSelectedItem ( CSGGroupsGUI[2502] )
	if ( theAccountName ) and ( tostring( row ) ~= "-1" ) then
		local thePlayer = exports.server:getPlayerFromAccountname ( theAccountName )
		if ( thePlayer ) and ( isElement( thePlayer ) ) then
			return thePlayer, theAccountName
		else
			return false, theAccountName
		end
	else
		return false, false
	end
end

addEventHandler ( 'onClientGUIDoubleClick', root, function ( btn )
	if ( source == CSGGroupsGUI[2502] ) then
		--if getElementData(localPlayer,"isPlayerPrime") then
		--if getElementData(localPlayer,"GroupRank") == "Manager" or getElementData(localPlayer,"GroupRank") == "Deputy Leader" or getElementData(localPlayer,"GroupRank") == "Group Leader" then
		if getElementData(localPlayer,"GroupRank") == "Deputy Leader" or getElementData(localPlayer,"GroupRank") == "Group Leader" then
			local row, col = guiGridListGetSelectedItem ( CSGGroupsGUI[2502] )
			if ( row ~= -1 and col ~= 0 ) then
				local name = guiGridListGetItemText(CSGGroupsGUI[2502], guiGridListGetSelectedItem(CSGGroupsGUI[2502]), 1)
				local data = guiGridListGetItemData(CSGGroupsGUI[2502], guiGridListGetSelectedItem(CSGGroupsGUI[2502]), col)
				local data = tonumber(data)
				if name and data and col then
					if data == 0 or data == 1 then
						exports.NGCdxmsg:createNewDxMessage("You are attempting to change "..name.." AV access",0,255,0)
						local thePlayer,account = getSelectedPlayer()
						if thePlayer and isElement(thePlayer) then
							triggerServerEvent("changeMemberAvAccess",localPlayer,thePlayer,data,col)
						else
							triggerServerEvent("changeMemberAvAccess",localPlayer,account,data,col)
						end
					end
				end
			end
	--	end
		end
	end
end)

addEventHandler ( 'onClientGUIClick', root, function ( btn )
	if ( source == CSGGroupsGUI[63] ) then
		if getElementData(localPlayer,"isPlayerPrime") then
			local row, col = guiGridListGetSelectedItem ( CSGGroupsGUI[63] )
			if ( row ~= -1 and col ~= 0 ) then
				local name = guiGridListGetItemText(CSGGroupsGUI[63], guiGridListGetSelectedItem(CSGGroupsGUI[63]), 1)
				outputChatBox(name,255,250,250)
			end
		end
	end
end)

-- Set the groups window visable
function setGroupWindowVisable ( groupsTable, invitesTable, memberTable, bankingTable, membersTable, groupID )
	if not ( memberTable ) then theRank = "Guest" else theRank = memberTable.grouprank end
	local groupsACL = getGroupsACL ()
	local groupRanks = getGroupRankACL ()

	resetGroupLabels ()

	if ( groupsACL ) and ( groupRanks ) and ( groupRanks[theRank] ) then
		for i=1,#groupsACL do
			if not ( memberTable ) and ( groupsACL[i][2] == 999 ) then
				guiSetEnabled( groupsACL[i][1], true )
			elseif ( memberTable ) and ( groupRanks[theRank] < 5 ) and ( groupsACL[i][2] == 888 ) then
				guiSetEnabled( groupsACL[i][1], true )
			elseif ( groupRanks[theRank] ) and ( groupRanks[theRank] >= groupsACL[i][2] ) then
				guiSetEnabled( groupsACL[i][1], true )
			else
				guiSetEnabled( groupsACL[i][1], false )
			end
		end

		if ( membersTable ) then memberCount = #membersTable else memberCount = "N/A" end

		local state1 = exports.DENsettings:getPlayerSetting( "groupblips" )
		local state2 = exports.DENsettings:getPlayerSetting( "grouptags" )
		guiCheckBoxSetSelected( CSGGroupsGUI[18], state1 )
		guiCheckBoxSetSelected( CSGGroupsGUI[19], state2 )

		if ( membersTable ) then insertGroupMemberList( membersTable ) end


		local groupsTableRow = nil
		local groupsTableName = nil
		local groupsTableFounder = nil
		local groupsTableDate = nil
		local groupsTableBalance = nil
		local groupsTableInfo = nil
		local groupsTableGType = nil
		local groupsTableLVL = nil
		local groupsTableXP = nil

		if ( groupsTable ) then
			guiGridListClear(CSGGroupsGUI[63] )
			for i=1,#groupsTable do
				local row1 = guiGridListAddRow ( CSGGroupsGUI[63] )
				guiGridListSetItemText( CSGGroupsGUI[63], row1, 1, groupsTable[i].groupname, false, false )
				guiGridListSetItemText( CSGGroupsGUI[63], row1, 2, groupsTable[i].gType, false, false )
				if groupsTable[i].gType == "Criminals" then
					guiGridListSetItemColor( CSGGroupsGUI[63], row1, 2, 255, 0, 0 )
				elseif groupsTable[i].gType == "Law" then
					guiGridListSetItemColor( CSGGroupsGUI[63], row1, 2, 0, 100, 200 )
				elseif groupsTable[i].gType == "other" then
					guiGridListSetItemColor( CSGGroupsGUI[63], row1, 2, 255, 225, 0 )
				end
				if groupsTable[i].groupsLimit then
					guiGridListSetItemText( CSGGroupsGUI[63], row1, 3, groupsTable[i].membercount.."/"..groupsTable[i].groupsLimit.." members", false, true )
				else
					guiGridListSetItemText( CSGGroupsGUI[63], row1, 3, groupsTable[i].membercount.." member(s)", false, true )
				end
				--guiGridListSetItemText( CSGGroupsGUI[63], row1, 2, groupsTable[i].membercount.."/"..groupsTable[i].groupsLimit.." members", false, true )
				if getElementData(localPlayer,"isPlayerPrime") then
					guiGridListSetItemText( CSGGroupsGUI[63], row1, 4, groupsTable[i].groupid.."| Banking: $"..exports.server:convertNumber(groupsTable[i].groupbalance), false, false )
				else
					guiGridListSetItemText( CSGGroupsGUI[63], row1, 4, groupsTable[i].groupleader, false, false )
				end
				if ( tonumber( groupsTable[i].groupid ) == groupID ) then
					groupsTableRow = groupsTable[i].groupid
					groupsTableName = groupsTable[i].groupname
					groupsTableFounder = groupsTable[i].groupleader
					groupsTableDate = groupsTable[i].datecreated
					groupsTableBalance = groupsTable[i].groupbalance
					groupTableTurf = groupsTable[i].turfcolor
					groupsTableInfo = groupsTable[i].groupinfo
					groupsTableGType = groupsTable[i].gType
					groupsTableLVL = groupsTable[i].groupLevel
					groupsTableXP = groupsTable[i].groupXP

					theGroupID = groupsTable[i].groupid
					theFounderAccount = groupsTable[i].groupleader
				end
			end
		end

		if ( invitesTable ) then
			guiGridListClear(CSGGroupsGUI[58] )
			for i=1,#invitesTable do
				local row2 = guiGridListAddRow ( CSGGroupsGUI[58] )
				guiGridListSetItemText( CSGGroupsGUI[58], row2, 1, invitesTable[i].groupname, false, false )
				guiGridListSetItemText( CSGGroupsGUI[58], row2, 2, invitesTable[i].invitedby, false, false )
				guiGridListSetItemData( CSGGroupsGUI[58], row2, 1, invitesTable[i].groupid )
			end
		end

		if ( bankingTable ) then
			guiGridListClear(CSGGroupsGUI[52] )
			for i=1,#bankingTable do
				local row3 = guiGridListAddRow ( CSGGroupsGUI[52] )
				guiGridListSetItemText( CSGGroupsGUI[52], row3, 1, bankingTable[i].datum, false, false )
				guiGridListSetItemText( CSGGroupsGUI[52], row3, 2, bankingTable[i].transaction, false, false )
			end
		end

		if ( groupTableTurf  ) then turfColorData = exports.server:stringExplode( groupTableTurf, "," ) end

		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[20], groupsTableName ) end
		if ( memberCount ) then guiSetText( CSGGroupsGUI[21], memberCount ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[22], groupsTableFounder ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[23], groupsTableDate ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[24], memberTable.joindate ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[25], "$"..exports.server:convertNumber( groupsTableBalance ) ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[51], "Last bank transactions: (Current balance: $"..exports.server:convertNumber( groupsTableBalance )..")" ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[26], memberTable.grouprank ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[27], "This is the turf color" ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[1601], groupsTableGType ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[1603], groupsTableLVL ) end
		if ( groupsTableRow ) then guiSetText( CSGGroupsGUI[1605], groupsTableXP ) end
		if ( groupsTableRow ) then if groupsTableInfo then guiSetText( CSGGroupsGUI[33], groupsTableInfo ) end end
		if ( turfColorData  ) then guiLabelSetColor( CSGGroupsGUI[27], turfColorData[1], turfColorData[2], turfColorData[3] ) end
		if groupsTableGType == "Criminals" then
			guiLabelSetColor( CSGGroupsGUI[1601],255,0,0)
		elseif groupsTableGType == "Law" then
			guiLabelSetColor( CSGGroupsGUI[1601],0,100,200)
		else
			guiLabelSetColor( CSGGroupsGUI[1601],255,255,0)
		end
		guiLabelSetColor( CSGGroupsGUI[1603],0,205,0)
		guiLabelSetColor( CSGGroupsGUI[1605],255,0,0)
		guiSetVisible ( CSGGroupsGUI[1], true )
		showCursor( true )
	else
		print(tostring(groupsACL))
		print(tostring(groupRanks))
		print(tostring(groupRanks[theRank]))
		exports.NGCdxmsg:createNewDxMessage( "We couldn't open groups panel, contact a developer please!", 200, 0, 0 )
	end
end

function insertGroupMemberList( membersTable )
	guiGridListClear(CSGGroupsGUI[30] )
	guiGridListClear(CSGGroupsGUI[37] )
	guiGridListClear(CSGGroupsGUI[2502] )

	for i=1,#membersTable do
		local row1 = guiGridListAddRow ( CSGGroupsGUI[30] )
		local row2 = guiGridListAddRow ( CSGGroupsGUI[37] )
		local row3 = guiGridListAddRow ( CSGGroupsGUI[2502] )

		local playerElement = exports.server:getPlayerFromAccountname ( membersTable[i].membername )
		local customride = membersTable[i].customrank
		if membersTable[i].warned == 1 then
			sta = "Warned"
		else
			sta = "Active"
		end
		guiGridListSetItemText( CSGGroupsGUI[2502], row3, 1, membersTable[i].membername, false, false )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 1, membersTable[i].grouprank )
		if membersTable[i].hydra == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 2,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 2, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 2,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 2, 0, 225, 0 )
		end
		if membersTable[i].rustler == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 3,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 3, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 3,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 3, 0, 225, 0 )

		end
		if membersTable[i].hunter == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 4,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 4, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 4,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 4, 0, 225, 0 )

		end
		if membersTable[i].seasparrow == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 5,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 5, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 5,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 5, 0, 225, 0 )

		end
		if membersTable[i].rhino == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 6,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 6, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 6,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 6, 0, 225, 0 )

		end
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 2, membersTable[i].hydra )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 3, membersTable[i].rustler )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 4, membersTable[i].hunter )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 5, membersTable[i].seasparrow )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 6, membersTable[i].rhino )

		guiGridListSetItemText( CSGGroupsGUI[30], row1, 4, membersTable[i].points, false, false )
		guiGridListSetItemText( CSGGroupsGUI[30], row1, 6, sta, false, false )
		guiGridListSetItemText( CSGGroupsGUI[30], row1, 1, membersTable[i].membername, false, false )
		guiGridListSetItemText( CSGGroupsGUI[30], row1, 2, membersTable[i].grouprank, false, false )
		if customride == false or customride == nil or string.len(customride) < 3 or customride == "" or customride == " " then
			guiGridListSetItemText( CSGGroupsGUI[30], row1, 3, "None", false, false )
		else
			guiGridListSetItemText( CSGGroupsGUI[30], row1, 3, customride, false, false )
		end
		guiGridListSetItemText( CSGGroupsGUI[37], row2, 1, membersTable[i].membername, false, false )
		guiGridListSetItemData( CSGGroupsGUI[37], row2, 1, membersTable[i].grouprank )
		nickToPlayer[membersTable[i].membername]=membersTable[i].membername
		if ( playerElement ) and ( isElement( playerElement ) ) then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 1, getPlayerName(playerElement).." ("..membersTable[i].membername..")", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 1, 0, 225, 0 )
			guiGridListSetItemText ( CSGGroupsGUI[30], row1, 5, "Online", false, false )

			guiGridListSetItemText( CSGGroupsGUI[30], row1, 1, getPlayerName(playerElement).." ("..membersTable[i].membername..")", false, false )
			guiGridListSetItemText( CSGGroupsGUI[37], row2, 1, getPlayerName(playerElement).." ("..membersTable[i].membername..")", false, false )

			guiGridListSetItemColor( CSGGroupsGUI[30], row1, 5, 0, 225, 0 )
			guiGridListSetItemColor( CSGGroupsGUI[30], row1, 1, 0, 225, 0 )
			guiGridListSetItemColor( CSGGroupsGUI[37], row2, 1, 0, 225, 0 )
			nickToPlayer[getPlayerName(playerElement).." ("..membersTable[i].membername..")"]=membersTable[i].membername

		else
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 1, 225, 0, 0 )
			guiGridListSetItemText ( CSGGroupsGUI[30], row1, 5, compareTimestampDays( membersTable[i].lastonline ), false, false )
			guiGridListSetItemColor( CSGGroupsGUI[37], row2, 1, 225, 0, 0 )
		end
	end
end

addEvent("reloadMemb",true)
addEventHandler("reloadMemb",root,function(d)
	if d then
		recallAVList( d )
	end
end)


function recallAVList( membersTable )
	guiGridListClear(CSGGroupsGUI[2502] )

	for i=1,#membersTable do
		local row3 = guiGridListAddRow ( CSGGroupsGUI[2502] )
		local playerElement = exports.server:getPlayerFromAccountname ( membersTable[i].membername )

		guiGridListSetItemText( CSGGroupsGUI[2502], row3, 1, membersTable[i].membername, false, false )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 1, membersTable[i].grouprank )
		if membersTable[i].hydra == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 2,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 2, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 2,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 2, 0, 225, 0 )
		end
		if membersTable[i].rustler == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 3,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 3, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 3,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 3, 0, 225, 0 )

		end
		if membersTable[i].hunter == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 4,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 4, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 4,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 4, 0, 225, 0 )

		end
		if membersTable[i].seasparrow == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 5,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 5, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 5,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 5, 0, 225, 0 )

		end
		if membersTable[i].rhino == 0 then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 6,"Off", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 6, 225, 0, 0 )
		else
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 6,"On", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 6, 0, 225, 0 )

		end
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 2, membersTable[i].hydra )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 3, membersTable[i].rustler )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 4, membersTable[i].hunter )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 5, membersTable[i].seasparrow )
		guiGridListSetItemData( CSGGroupsGUI[2502], row3, 6, membersTable[i].rhino )

		if ( playerElement ) and ( isElement( playerElement ) ) then
			guiGridListSetItemText( CSGGroupsGUI[2502], row3, 1, getPlayerName(playerElement).." ("..membersTable[i].membername..")", false, false )
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 1, 0, 225, 0 )
		else
			guiGridListSetItemColor( CSGGroupsGUI[2502], row3, 1, 225, 0, 0 )
		end
	end
end


-- Change the setting for group settings
addEventHandler( "onClientGUIClick", root,
	function ()
		if ( source == CSGGroupsGUI[18] ) then
			exports.DENsettings:setPlayerSetting( "groupblips", tostring( guiCheckBoxGetSelected( CSGGroupsGUI[18] ) ) )
		elseif ( source == CSGGroupsGUI[19] ) then
			exports.DENsettings:setPlayerSetting( "grouptags", tostring( guiCheckBoxGetSelected( CSGGroupsGUI[19] ) ) )
		end
	end
)

-- Event handlers for on-screen changes
addEventHandler( "onClientGUIChanged", root,
	function ()
		if ( source == CSGGroupsGUI[65] ) then
			onClientGroupInviteSearch()
		elseif 	( source == CSGGroupsGUI[102] ) or ( source == CSGGroupsGUI[106] ) or ( source == CSGGroupsGUI[104] ) then
			onClientTurfColorChange()
		end
	end
)

-- Get the accountname of the founder
function getGroupFounderAccountname ()
	if ( theFounderAccount ) then
		return theFounderAccount
	else
		return false
	end
end

-- Get groupID
function getGroupID ()
	if ( theGroupID ) then
		return theGroupID
	else
		return false
	end
end


groupInviteLogs = {
    label = {},
    edit = {},
    button = {},
    window = {},
    radiobutton = {},
    gridlist = {}
}
groupInviteLogs.window[1] = guiCreateWindow(18, 53, 745, 481, "Aurora ~ Group Invites log", false)
guiWindowSetSizable(groupInviteLogs.window[1], false)
guiSetAlpha(groupInviteLogs.window[1], 0.95)
guiSetVisible ( groupInviteLogs.window[1], false )
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(groupInviteLogs.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(groupInviteLogs.window[1],x,y,false)

groupInviteLogs.gridlist[1] = guiCreateGridList(13, 27, 722, 354, false, groupInviteLogs.window[1])
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Playername", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Account name", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Invited by", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Inviter Account", 0.2)
guiGridListAddColumn(groupInviteLogs.gridlist[1], "Time", 0.2)
---guiGridListAddColumn(groupInviteLogs.gridlist[1], "", 0.2)
groupInviteLogs.label[1] = guiCreateLabel(40, 391, 213, 28, "Use search type", false, groupInviteLogs.window[1])
guiSetFont(groupInviteLogs.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(groupInviteLogs.label[1], "center", false)
groupInviteLogs.edit[1] = guiCreateEdit(34, 429, 129, 36, "Group name", false, groupInviteLogs.window[1])
groupInviteLogs.button[1] = guiCreateButton(400, 429, 80, 36, "Search", false, groupInviteLogs.window[1])
groupInviteLogs.button[2] = guiCreateButton(600, 429, 80, 36, "Close", false, groupInviteLogs.window[1])



addEventHandler( "onClientGUIClick", root,function ()
	if source == groupInviteLogs.button[1] then
		local text = guiGetText(groupInviteLogs.edit[1])
		if text then
			exports.NGCdxmsg:createNewDxMessage("Please wait , we are looking for invite logs",255,0,0)
			triggerServerEvent("findThrowGroups",localPlayer,text)
		end
	elseif source == groupInviteLogs.button[2] then
		guiSetVisible ( groupInviteLogs.window[1], false )
		showCursor( false )
	end
end)


-- Open the window and insert the last groupInviteLogs
addEvent( "callClientgroupInviteLogs", true )
addEventHandler( "callClientgroupInviteLogs", root,
	function ( theTable,mn )
		if ( theTable ) then
			guiGridListClear( groupInviteLogs.gridlist[1] )
			--guiGridListSetItemText( groupInviteLogs.gridlist[1],1,1,mn, true,true )
			for i=1,#theTable do
				local row = guiGridListAddRow( groupInviteLogs.gridlist[1] )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 1, theTable[i].nickname, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 2, theTable[i].accountname, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 3, theTable[i].invitedby, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 4, theTable[i].iaccount, false, false )
				guiGridListSetItemText( groupInviteLogs.gridlist[1], row, 5, theTable[i].times, false, false )
			end

		else
			outputChatBox( "Something wen't wrong while loading the last groupInviteLogs! Try again.", 225, 0, 0 )
		end
	end
)

addEvent("openGMPanel",true)
addEventHandler("openGMPanel",root,function()
	guiSetVisible ( groupInviteLogs.window[1], true )
	showCursor( true )
end)
