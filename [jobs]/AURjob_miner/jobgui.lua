--[[
Server Name: AuroraRPG
Resource Name: AURjob_miner
Version: 1.0
Developer/s: Curt
]]--

local GUIEditor = {
    button = {},
    window = {},
    label = {},
    memo = {}
}
local screenW, screenH = guiGetScreenSize()

function openGUI ()

	GUIEditor.window[1] = guiCreateWindow((screenW - 604) / 2, (screenH - 435) / 2, 604, 435, "AuroraRPG - Miner", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(14, 31, 108, 15, "Civilian Job - Miner", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[1], 254, 251, 0)
	GUIEditor.label[2] = guiCreateLabel(14, 56, 255, 15, "Current Rank:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	GUIEditor.label[3] = guiCreateLabel(14, 81, 255, 15, "Total Mined Mines:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.label[4] = guiCreateLabel(14, 131, 255, 15, "Total mines left for next rank: ", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.label[5] = guiCreateLabel(14, 106, 255, 15, "Next Rank:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	GUIEditor.label[6] = guiCreateLabel(14, 156, 106, 15, "Job  Description:", false, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[6], "default-bold-small")
	GUIEditor.memo[1] = guiCreateMemo(15, 177, 579, 209, "In this job, you have to go to your assigned location then if you got there, then you have two choices:\n\n- Plant Bomb Mining\n    This method is longer to wait. Because you will plant a bomb then if you planted it then the bomb will explode within 10 seconds. The explotion might be harmful if you are near to it.\n	\n- Peaceful Mining\n    This method is you have to click the mine pictures. There will be no explotion or harmful things will happen.\n\nYou can sell these materials on F10 or craft it (type /craft)\nJob Ranks:\n- L1. Starter \n	Required mines: 0\n	Payment per mine (Labor): est. $500\n	Items you will receive per mine: General Items\n	\n- L2. New Miner\n	Required mines: 50\n	Payment per mine (Labor): est. $1000\n	Items you will receive per mine: 2x ratio of General Items\n	\n- L3. Fledgling Miner\n	Required mines: 100\n	Payment per mine (Labor): est. $2000\n	Items you will receive per mine: 2.5x ratio of General Items\n	\n- L4. Apprentice Miner\n	Required mines: 300\n	Payment per mine (Labor): est. $2300\n	Items you will receive per mine: 3x ratio of General Items\n	\n- L5. Adept Miner\n	Required mines: 800\n	Payment per mine (Labor): est. $2800\n	Items you will receive per mine: 3.5x ratio of General Items | 1x ratio of Gold\n	\n- L6. Expert Miner\n	Required mines: 1000\n	Payment per mine (Labor): est. $3000\n	Items you will receive per mine: 4x ratio of General Items | 2x ratio of Gold\n	\n- L7. Master Miner\n	Required mines: 1600\n	Payment per mine (Labor): est. $3500\n	Items you will receive per mine: 4.5x ratio of General Items | 2.5x ratio of Gold\n	\n- L8. Legend Miner\n	Required mines: 10000\n	Payment per mine (Labor): est. $4500\n	Items you will receive per mine: 5x ratio of General Items | 3x ratio of Gold | 1x ratio of Diamond\n	\n- L9. Proficient Miner\n	Required mines: 30000\n	Payment per mine (Labor): est. $4500\n	Items you will receive per mine: 5x ratio of General Items | 3x ratio of Gold | 1x ratio of Diamond\n	\n- L10. Official Miner\n	Required mines: 50000\n	Required mines: \n	Payment per mine (Labor): est. $5000\n	Items you will receive per mine: 5x ratio of General Items | 3x ratio of Gold | 1.5x ratio of Diamond", false, GUIEditor.window[1])
	guiMemoSetReadOnly(GUIEditor.memo[1], true)
	GUIEditor.button[1] = guiCreateButton(228, 396, 159, 29, "Close", false, GUIEditor.window[1])    
	addEventHandler("onClientGUIClick", GUIEditor.button[1], toggleGUI, false)
end

function toggleGUI()
	if (getElementData(getLocalPlayer(), "Occupation") ~= "Miner") then return end
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
	else
		triggerServerEvent("aurjob_miner.getClientInfos", resourceRoot)
		showCursor(true)
		openGUI()
	end 
end 

bindKey("F5","down", toggleGUI)

function updateGUI (name, payment, isratio, gratio, dratio, mines, nextname, nextrpoint)
	guiSetText(GUIEditor.label[2], "Current Rank: "..name)
	guiSetText(GUIEditor.label[3], "Total Mined Mines: "..mines)
	guiSetText(GUIEditor.label[4], "Total mines left for next rank: "..nextrpoint-mines)
	guiSetText(GUIEditor.label[5], "Next Rank: "..nextname)
end 
addEvent("aurjob_miner.updateGUI", true)
addEventHandler("aurjob_miner.updateGUI", localPlayer, updateGUI)