GUIEditor = {
    gridlist = {},
    window = {},
    button = {},
    memo = {}
}

local cursorTimerChecker

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
	{"Drug Trafficker", "Drug Trafficker is actually a duty where you can use your own Truck to load drugs on it and be able to sell it.\n\n Available Commands:\n/drug_inventory - To edit your drugs prices and check how much drugs you have.\n/start_selling - To start selling drugs (you need to be in your truck)\n/stop_selling - To stop selling drugs."},

}

function loadGUI ()
	if (isElement(GUIEditor.window[1])) then return false end 
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 831) / 2, (screenH - 462) / 2, 831, 462, "AuroraRPG ~ Criminal Activities", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.gridlist[1] = guiCreateGridList(9, 31, 305, 421, false, GUIEditor.window[1])
	GUIEditor.gridlist[2] = guiGridListAddColumn(GUIEditor.gridlist[1], "Criminal Events", 0.9)
	GUIEditor.memo[1] = guiCreateMemo(320, 31, 501, 387, "Please select an activity on the list.", false, GUIEditor.window[1])
	guiMemoSetReadOnly(GUIEditor.memo[1], true)
	GUIEditor.button[1] = guiCreateButton(703, 422, 118, 30, "Close", false, GUIEditor.window[1])    
	guiSetVisible(GUIEditor.window[1], false)
	
	if (GUIEditor.gridlist[2]) then 
		for i=1, #information do 
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText (GUIEditor.gridlist[1], row, GUIEditor.gridlist[2], information[i][1], false, false)
		end 
	end 
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function() 
		if (guiGetVisible(GUIEditor.window[1]) == true) then 
			showCursor(false, false)
			guiSetVisible(GUIEditor.window[1], false)
			if (isTimer(cursorTimerChecker)) then 
				killTimer(cursorTimerChecker)
			end
		end 
	end, false)
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
	  local valueR = ""
		  if row >= 0 and col >= 0 then 
			for i=1, #information do
				if (information[i][1] == guiGridListGetItemText(source, guiGridListGetSelectedItem (source), 1)) then 
					guiSetText(GUIEditor.memo[1], information[i][2])
					return					
				end
			end
				guiSetText(GUIEditor.memo[1], "Please select an activity on the list.")
			else
				guiSetText(GUIEditor.memo[1], "Please select an activity on the list.")
		  end 
	end, false) 
end 

function Bindcommand ()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) == "Criminals" or getTeamName(getPlayerTeam(getLocalPlayer())) == "Bloods") then 
		if (isElement(GUIEditor.window[1])) then
			if (guiGetVisible(GUIEditor.window[1]) == true) then 
				showCursor(false, false)
				killTimer(cursorTimerChecker)
				guiSetVisible(GUIEditor.window[1], false)
			else 
				showCursor(true, true)
				guiSetVisible(GUIEditor.window[1], true)
				cursorTimerChecker = setTimer(function()
					if (isCursorShowing() == false) then 
						showCursor(true, true)
						return
					end 
					return 
				end, 1000, 0)
			end 
		end 
	end 
end 

addEventHandler("onClientResourceStart", resourceRoot,function()
	loadGUI()
	bindKey("F5", "down", Bindcommand)
end)
