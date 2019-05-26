local screenWidth,screenHeight = guiGetScreenSize()
local achievement_name
local achievement_reawrd
local achievement_description
local achievement_table = {}
local theSound
local start 
GUIEditor = {
	gridlist = {},
	window = {},
	button = {},
	column = {},
	label = {}
}



function openAchiGUI ()
	GUIEditor.window[1] = guiCreateWindow((screenWidth - 825) / 2, (screenHeight - 473) / 2, 825, 473, "Achievements", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.gridlist[1] = guiCreateGridList(14, 29, 801, 414, false, GUIEditor.window[1])
	GUIEditor.column[1] = guiGridListAddColumn(GUIEditor.gridlist[1], "Achievement Name", 0.5)
	GUIEditor.column[2] = guiGridListAddColumn(GUIEditor.gridlist[1], "Accomplished?", 0.5)
	GUIEditor.label[1] = guiCreateLabel(19, 448, 156, 15, "Total Achievements:", false, GUIEditor.window[1])
	GUIEditor.button[1] = guiCreateButton(688, 448, 117, 15, "Close", false, GUIEditor.window[1])    
	addEventHandler("onClientGUIClick", GUIEditor.button[1], triggerAchiGUI, false)
end 


function triggerAchiGUI ()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
		else
		openAchiGUI()
		showCursor(true)
		triggerServerEvent("aurachievements.getClientInfo", resourceRoot, getLocalPlayer())
	end 
end
addCommandHandler("achievements", triggerAchiGUI, true)

function updateList (data)
	local dataTable = fromJSON(data)
	local tableCount = 0
	local exist = -2
	for i=1, #achievement_table do
	tableCount = tableCount + 1
		for j=1, #dataTable do 
			if (tableCount == dataTable[j][1]) then 
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, GUIEditor.column[1], achievement_table[i][1], false, false)
				guiGridListSetItemText(GUIEditor.gridlist[1], row, GUIEditor.column[2], "Yes", false, false)
				guiGridListSetItemColor (GUIEditor.gridlist[1], row, GUIEditor.column[1], 0, 255, 0)
				guiGridListSetItemColor (GUIEditor.gridlist[1], row, GUIEditor.column[2], 0, 255, 0)
				exist = tableCount
			end 
		end 
		if (exist ~= tableCount) then 
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, GUIEditor.column[1], achievement_table[i][1], false, false)
			guiGridListSetItemText(GUIEditor.gridlist[1], row, GUIEditor.column[2], "No", false, false)
			guiGridListSetItemColor (GUIEditor.gridlist[1], row, GUIEditor.column[1], 255, 0, 0)
			guiGridListSetItemColor (GUIEditor.gridlist[1], row, GUIEditor.column[2], 255, 0, 0)
		end 
	end 
	guiSetText(GUIEditor.label[1], "Total Achievements: "..tableCount)
end 
addEvent("aurachievements.tableUpdate", true)
addEventHandler("aurachievements.tableUpdate", localPlayer, updateList)

function updateAch (data)
	achievement_table = fromJSON(data)
end 
addEvent("aurachievements.achievement_list", true)
addEventHandler("aurachievements.achievement_list", localPlayer, updateAch)

function triggerNotifi (name, des, ades) 
	achievement_name = name
	achievement_description = des
	achievement_reawrd = ades
	addEventHandler("onClientRender", root, toRender)
	start = getTickCount()
	theSound = playSound("sound.mp3", false)
end 
addEvent("aurachievements.triggerNotifi", true)
addEventHandler("aurachievements.triggerNotifi", localPlayer, triggerNotifi)

function toRender()
	if (not isElement(theSound)) then
		achievement_reawrd = ""
		achievement_description = ""
		achievement_name = ""
		theSound = nil
		start = nil
		removeEventHandler("onClientRender", getRootElement(), toRender)
		return true
	end
	local now = getTickCount()
	local elapsedTime = now - start
	local endTime = start + 3000
	local duration = endTime - start
	local progress = elapsedTime / duration
	local x1, y1, z1 = interpolateBetween ( 0, 0, 0, screenWidth, screenHeight, 255, progress, "OutBack")
	if (getSoundPosition(theSound) >=  10) then
		achievement_reawrd = ""
		achievement_description = ""
		achievement_name = ""
		theSound = nil
		start = nil
		removeEventHandler("onClientRender", getRootElement(), toRender)
	elseif (getSoundPosition(theSound) >=  7.5) then
		dxDrawImage(screenWidth/2.62, screenHeight/1.38, x1/3.5, y1/9, "achievement.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText("To open your achievements", screenWidth/2.17, y1/1.283, x1/3.5, screenHeight/9, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
		dxDrawText("Type /achievements!", screenWidth/2.17, y1/1.25, x1/3.5, screenHeight/9, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	elseif (getSoundPosition(theSound) >=  4.5) then
		dxDrawImage(screenWidth/2.62, screenHeight/1.38, x1/3.5, y1/9, "achievement.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(achievement_name, screenWidth/2.17, y1/1.283, x1/3.5, screenHeight/9, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
		dxDrawText(achievement_description, screenWidth/2.17, y1/1.25, x1/3.5, screenHeight/9, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	else
		dxDrawImage(screenWidth/2.62, screenHeight/1.38, x1/3.5, y1/9, "achievement.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(achievement_name, screenWidth/2.17, y1/1.283, x1/3.5, screenHeight/9, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
		dxDrawText(achievement_reawrd, screenWidth/2.17, y1/1.25, x1/3.5, screenHeight/9, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
	end 
	
end
