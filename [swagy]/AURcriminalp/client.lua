local screenW, screenH = guiGetScreenSize()
GUIEditor = {
    label = {},
    button = {},
    window = {},
    gridlist = {},
    memo = {}
}
local localElements = {}
local text = ""

local drugTraffickerVehicles = {
	[499] = true,
	[609] = true,
	[498] = true,
	[455] = true,
	[414] = true,
	[422] = true,
	[482] = true,
	[413] = true,
	[440] = true,
	[543] = true,
	[478] = true,
	[554] = true,
}

function getVehiclesText ()

	for k,v in pairs (drugTraffickerVehicles) do
		text = ""..text.."\n-"..getVehicleNameFromID(k).." | ID: "..k..""
	end
	return text

end

local information = {
	--Activities | Description
	{"ATM Hacking", "ATM robberies can be done by going to any ATM and clicking on hack.\nRewards for hacking ATM:\n\nEasy - 100,000\nMedium - 200,000\nHard - 300,000  \n\nThis information was updated on 4/15/17 by [AUR]Anubhav"},
	{"Bank Robbery", "Bank Rob is a Criminal event where Criminals must work together to rob the bank, to earn money you must find the gates passwords to reach the last level of the bank, kill/evade the cops once you survive you will get your reward ( You need at least 5 Criminals or more to start it ).\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Drug Shipment", "DSR is a criminal event where Criminals must work together to fill up the Shipment with a huge amount of every type of drugs where cops will try to stop you but you have to kill them incase to survive with the Drug Shipment at the end every Criminal will recieve payouts.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Store Robbery", "Store Robbery is a Criminal event where criminals must work together to rob stores, aim at the ped every criminal will recieve payouts at the end.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"House Robbery", "Work as a Thief and enter a house secretly to rob it's expensive objects then sell them to a Thief dealer to earn cash.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Crafting Drugs", "Craft your own drugs in the LS Drug factory (Skull blip).\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Mansion Raid", " Mansion Raid (MR) is a Criminal event where Criminals must work together to rob the mansion money and kill it's guards ( You need at least 5 Criminals or more to start it ).\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Turfing", "Turfing is a criminal activity where gang members must work together to control the Las Ventuars City.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Radio Towers", "Control radio towers with your gang to evade getting wanted while taking turfs.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Killing Cops", "No information yet please PM Curt on Forums to finish this information. \n\nReward: $300,000"},
	{"Vehicle Hijack", "Hijack an expensive vehicle and take it to the vehicles dealer and earn money.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Illegal Race", "No information yet please PM Curt on Forums to finish this information. \n\nReward: $300,000"},
	{"Drug Farmer", "Work as a Drug Farmer and plant your own drugs in Red Country.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Briefcase", "Steal the money bag and take it to your boss and earn money.\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Mafia Event", "No information yet please PM Curt on Forums to finish this information. \n\nReward: $300,000"},
	{"Top Criminal", "Participate to the Top Criminal event and kill all the Criminals and be the top criminal of the server ( You need at least 8 Criminals for this event ).\n\nThis information was updated on 4/15/17 by [AUR]Smiler"},
	{"Drug Store", "No information yet please PM Curt on Forums to finish this information. \n\nReward: $300,000"},
	{"Drug Trafficker", "Drug Trafficker is actually a duty where you can use your own Truck to load drugs on it and be able to sell it.\n\n Available Commands:\n/drug_inventory - To edit your drugs prices and check how much drugs you have.\n/start_selling - To start selling drugs (you need to be in your truck)\n/stop_selling - To stop selling drugs.\n\n Allowed Vehicles:\n"..getVehiclesText()..""},
}

function openGUI()
	if (isElement(GUIEditor.window[1])) then 
		killTimer(localElements["antiCursorBug"])
		destroyElement(GUIEditor.window[1])
		showCursor(false)
		return 
	end 
	GUIEditor.window[1] = guiCreateWindow((screenW - 835) / 2, (screenH - 484) / 2, 835, 484, "AuroraRPG - Criminal", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.gridlist[1] = guiCreateGridList(9, 30, 295, 444, false, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Criminal Activities", 0.9)
	GUIEditor.memo[1] = guiCreateMemo(307, 35, 518, 348, "", false, GUIEditor.window[1])
	guiMemoSetReadOnly(GUIEditor.memo[1], true)
	GUIEditor.label[1] = guiCreateLabel(312, 396, 503, 15, string.format(exports.AURlanguage:getTranslate("Current Criminal Level: %s", true), getElementData(localPlayer, "criminalrank")) , false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.label[2] = guiCreateLabel(312, 421, 308, 15, string.format(exports.AURlanguage:getTranslate("Current Criminal Points: %s", true), getElementData(localPlayer, "criminalpoints")), false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(312, 446, 308, 15, string.format(exports.AURlanguage:getTranslate("Required Points To Level Up: %s", true), getElementData(localPlayer, "criminalnextrank")), false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.button[1] = guiCreateButton(683, 438, 136, 33, exports.AURlanguage:getTranslate("Close",true), false, GUIEditor.window[1])    
	
	for i=1, #information do 
		guiGridListAddRow(GUIEditor.gridlist[1], information[i][1])
	end 
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
	  local valueR = ""
		  if row >= 0 and col >= 0 then 
			for i=1, #information do
				if (information[i][1] == guiGridListGetItemText(source, guiGridListGetSelectedItem (source), 1)) then 
					guiSetText(GUIEditor.memo[1], exports.AURlanguage:getTranslate(information[i][2], true))
					return					
				end
			end
				guiSetText(GUIEditor.memo[1], exports.AURlanguage:getTranslate("Please select an activity on the list.", true))
			else
				guiSetText(GUIEditor.memo[1], exports.AURlanguage:getTranslate("Please select an activity on the list.", true))
		  end 
	end, false) 

	addEventHandler("onClientGUIClick", GUIEditor.button[1], function() 
		openGUI()
	end, false)
	showCursor(true)
	localElements["antiCursorBug"] = setTimer(function()
		if (not isCursorShowing()) then 
			showCursor(true)
		end 
	end, 500, 0)
end 

function Bindcommand ()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) == "Criminals" or getTeamName(getPlayerTeam(getLocalPlayer())) == "Bloods") then 
		openGUI()
	end 
end 

addEventHandler("onClientResourceStart", resourceRoot,function()
	bindKey("F5", "down", Bindcommand)
end)

if (fileExists("client.lua")) then fileDelete("client.lua") end 
