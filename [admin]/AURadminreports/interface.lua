GUIEditor = {
    tab = {},
    staticimage = {},
    edit = {},
    window = {},
    tabpanel = {},
    button = {},
    label = {},
    gridlist = {},
    memo = {}
}
local currentfile = ":server/Images/disc.png"
local currfile = ""
local repotings = {}
local total = 0

function getReportsUpdated(report)
	repotings = report
	
	if (isElement(GUIEditor.window[2])) then 
		for i=1, #repotings do
			if (repotings[i][9] ~= true) then 
				local row = guiGridListAddRow(GUIEditor.gridlist[2], i, repotings[i][6], repotings[i][2])
				guiGridListSetItemColor (GUIEditor.gridlist[2], row, 1, 0, 255, 0 )
				guiGridListSetItemColor (GUIEditor.gridlist[2], row, 2, 0, 255, 0 )
				guiGridListSetItemColor (GUIEditor.gridlist[2], row, 3, 0, 255, 0 )
				total = total + 1
			end
		end 
		
		for i=1, #repotings do
			if (repotings[i][9] == true) then 
				local row = guiGridListAddRow(GUIEditor.gridlist[2], i, repotings[i][6], repotings[i][2])
				guiGridListSetItemColor (GUIEditor.gridlist[2], row, 1, 255, 0, 0 )
				guiGridListSetItemColor (GUIEditor.gridlist[2], row, 2, 255, 0, 0 )
				guiGridListSetItemColor (GUIEditor.gridlist[2], row, 3, 255, 0, 0 )
			end
		end 
	end
end 
addEvent("AURadminreports.updateReports",true)
addEventHandler( "AURadminreports.updateReports", resourceRoot, getReportsUpdated)

function updateScreenshot(filename, image)
	if (not fileExists(filename)) then 
		local file = fileCreate(filename)
		fileWrite(file, image)
		fileClose(file)
	end 
	
	if (isElement(GUIEditor.window[2])) then 
		if (filename ~= "not_avail.jpg") then 
			guiSetEnabled(GUIEditor.gridlist[2], true)
			guiStaticImageLoadImage(GUIEditor.staticimage[2], filename)
			currentfile = filename
		else
			guiSetEnabled(GUIEditor.gridlist[2], true)
			currentfile = "not_avail.jpg"
			guiStaticImageLoadImage(GUIEditor.staticimage[2], filename)
		end
	else
		currentfile = ""
	end 
end 
addEvent("AURadminreports.updateScreenshot",true)
addEventHandler( "AURadminreports.updateScreenshot", resourceRoot, updateScreenshot)

function openMainReport()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
	else
	showCursor(true)
	GUIEditor.window[1] = guiCreateWindow(0.30, 0.27, 0.40, 0.47, "AuroraRPG - Report", true)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.tabpanel[1] = guiCreateTabPanel(0.02, 0.06, 0.96, 0.91, true, GUIEditor.window[1])

	GUIEditor.tab[1] = guiCreateTab("Screenshot Report", GUIEditor.tabpanel[1])

	GUIEditor.gridlist[1] = guiCreateGridList(0.03, 0.04, 0.28, 0.92, true, GUIEditor.tab[1])
	local column = guiGridListAddColumn(GUIEditor.gridlist[1], "Pictures", 0.9)
	GUIEditor.staticimage[1] = guiCreateStaticImage(0.32, 0.13, 0.23, 0.29, ":server/Images/disc.png", true, GUIEditor.tab[1])
	GUIEditor.label[1] = guiCreateLabel(0.32, 0.05, 0.45, 0.04, "Preview (Click the picture for full view):", true, GUIEditor.tab[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	GUIEditor.label[2] = guiCreateLabel(0.32, 0.43, 0.06, 0.05, "Title:", true, GUIEditor.tab[1])
	local gglabel = guiCreateLabel(0.561, 0.204, 0.419, 0.198, "Type this command /rsc to take a screenshot.", true, GUIEditor.tab[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiSetFont(gglabel, "default-bold-small")
	guiLabelSetHorizontalAlign (gglabel, "left", true)
	GUIEditor.memo[1] = guiCreateMemo(0.32, 0.56, 0.67, 0.32, "", true, GUIEditor.tab[1])
	GUIEditor.edit[1] = guiCreateEdit(0.39, 0.42, 0.60, 0.08, "", true, GUIEditor.tab[1])
	GUIEditor.label[3] = guiCreateLabel(0.32, 0.51, 0.14, 0.05, "Description:", true, GUIEditor.tab[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	GUIEditor.button[1] = guiCreateButton(0.32, 0.89, 0.26, 0.07, "Report", true, GUIEditor.tab[1])
	GUIEditor.button[2] = guiCreateButton(0.56, 0.13, 0.12, 0.06, "View", true, GUIEditor.tab[1])
	GUIEditor.button[3] = guiCreateButton(0.71, 0.89, 0.26, 0.07, "Close", true, GUIEditor.tab[1])

	GUIEditor.tab[2] = guiCreateTab("Text Report", GUIEditor.tabpanel[1])

	GUIEditor.label[4] = guiCreateLabel(0.02, 0.05, 0.07, 0.05, "Title:", true, GUIEditor.tab[2])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	GUIEditor.edit[2] = guiCreateEdit(0.09, 0.04, 0.89, 0.07, "", true, GUIEditor.tab[2])
	GUIEditor.label[5] = guiCreateLabel(0.02, 0.15, 0.15, 0.05, "Description:", true, GUIEditor.tab[2])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	GUIEditor.memo[2] = guiCreateMemo(0.01, 0.20, 0.97, 0.64, "", true, GUIEditor.tab[2])
	GUIEditor.button[4] = guiCreateButton(0.13, 0.87, 0.27, 0.10, "Report", true, GUIEditor.tab[2])
	GUIEditor.button[5] = guiCreateButton(0.58, 0.87, 0.27, 0.10, "Close", true, GUIEditor.tab[2])
	guiSetInputMode("no_binds_when_editing")
	
	for i=1, #files do
		guiGridListAddRow(GUIEditor.gridlist[1], files[i])
	end 
	
	
	addEventHandler("onClientGUIClick", GUIEditor.button[5], openMainReport, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[3], openMainReport, false)
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
			for i=1, #files do
				if (files[i] == guiGridListGetItemText(source, row, 1)) then
					guiStaticImageLoadImage(GUIEditor.staticimage[1], "screenshots/"..files[i])
					currentfile = "screenshots/"..files[i]
					currfile = files[i]
					return 
				end 
			end
				guiStaticImageLoadImage(GUIEditor.staticimage[1], ":server/Images/disc.png")
				currentfile = ":server/Images/disc.png"
				currfile = ":server/Images/disc.png"
			else
				guiStaticImageLoadImage(GUIEditor.staticimage[1], ":server/Images/disc.png")
				currentfile = ":server/Images/disc.png"
				currfile = ":server/Images/disc.png"
		  end 
	end, false) 
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
		viewFullScreenshot(currentfile)
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[1], function()
		viewFullScreenshot(currentfile)
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
		if (guiGetText(GUIEditor.edit[1]) ~= "" or guiGetText(GUIEditor.memo[1]) ~= "") then 
			if (currfile == ":server/Images/disc.png") then 
				exports.NGCdxmsg:createNewDxMessage("Please choose a screenshot.",255,0,0)
				return false
			end 
			local time = getRealTime() 
			time.month = time.month + 1 
			time.year = time.year + 1900 
			local unix = getTimestamp(time.year,time.month,time.monthday,time.hour,time.minute,time.second)
			if time.second < 10 then 
			time.second = "0"..time.second 
			end 
			if time.minute < 10 then 
			time.minute = "0"..time.minute 
			end 
			if time.hour < 10 then 
			time.hour = "0"..time.hour 
			end 
			--local filename = "aurora_report-"..time.month.."-"..time.monthday.."-"..time.year.."_"..time.hour.."-"..time.minute.."-"..time.hour..".jpg"
			triggerServerEvent ("AURadminreports.submitReport", resourceRoot, getLocalPlayer(), "screenshot", guiGetText(GUIEditor.edit[1]), guiGetText(GUIEditor.memo[1]), currfile)
			
			openMainReport()
		else
			exports.NGCdxmsg:createNewDxMessage("Please fill up the blanks.",255,0,0)
		end 
	end, false)
	
	
	addEventHandler("onClientGUIClick", GUIEditor.button[4], function()
		if (guiGetText(GUIEditor.edit[2]) ~= "" or guiGetText(GUIEditor.memo[2]) ~= "") then 
			triggerServerEvent ("AURadminreports.submitReport", resourceRoot, getLocalPlayer(), "text", guiGetText(GUIEditor.edit[2]), guiGetText(GUIEditor.memo[2]), nil, nil)
		else
			exports.NGCdxmsg:createNewDxMessage("Please fill up the blanks.",255,0,0)
		end 
	end, false)
	end
end
addCommandHandler("report", openMainReport)

local autoUpdate
local timerzz
function openAdminReport()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) ~= "Staff") then return false end
	if (isElement(GUIEditor.window[2])) then 
		destroyElement(GUIEditor.window[2])
		showCursor(false)
		total = 0
		repotings = {}
		if (isTimer(timerzz)) then killTimer(timerzz) end
	else
	showCursor(true)
	GUIEditor.window[2] = guiCreateWindow(0.12, 0.16, 0.75, 0.71, "AuroraRPG - Admin Report", true)
	guiWindowSetSizable(GUIEditor.window[2], false)

	GUIEditor.label[6] = guiCreateLabel(0.01, 0.04, 0.98, 0.03, "Opened Cases: 0 | Overall Reports: 0", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[6], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
	GUIEditor.gridlist[2] = guiCreateGridList(0.01, 0.07, 0.50, 0.91, true, GUIEditor.window[2])
	guiGridListAddColumn(GUIEditor.gridlist[2], "Report ID", 0.3)
	guiGridListAddColumn(GUIEditor.gridlist[2], "Title", 0.3)
	guiGridListAddColumn(GUIEditor.gridlist[2], "Player", 0.3)
	GUIEditor.label[7] = guiCreateLabel(0.51, 0.08, 0.09, 0.03, "Account Name: ", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[7], "default-bold-small")
	GUIEditor.edit[3] = guiCreateEdit(0.61, 0.07, 0.38, 0.05, "", true, GUIEditor.window[2])
	guiEditSetReadOnly(GUIEditor.edit[3], true)
	GUIEditor.label[8] = guiCreateLabel(0.51, 0.14, 0.08, 0.03, "Player Name: ", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[8], "default-bold-small")
	GUIEditor.edit[4] = guiCreateEdit(0.60, 0.13, 0.39, 0.05, "", true, GUIEditor.window[2])
	guiEditSetReadOnly(GUIEditor.edit[4], true)
	GUIEditor.label[9] = guiCreateLabel(0.51, 0.19, 0.02, 0.03, "IP:", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[9], "default-bold-small")
	GUIEditor.edit[5] = guiCreateEdit(0.54, 0.18, 0.45, 0.04, "", true, GUIEditor.window[2])
	guiEditSetReadOnly(GUIEditor.edit[5], true)
	GUIEditor.label[10] = guiCreateLabel(0.51, 0.25, 0.07, 0.03, "MTA Serial: ", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[10], "default-bold-small")
	GUIEditor.edit[6] = guiCreateEdit(0.59, 0.24, 0.40, 0.04, "", true, GUIEditor.window[2])
	guiEditSetReadOnly(GUIEditor.edit[6], true)
	GUIEditor.label[11] = guiCreateLabel(0.51, 0.29, 0.49, 0.03, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[11], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[11], 255, 0, 0)
	GUIEditor.label[12] = guiCreateLabel(0.51, 0.33, 0.06, 0.03, "Report ID:", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[12], "default-bold-small")
	GUIEditor.edit[7] = guiCreateEdit(0.58, 0.32, 0.10, 0.04, "", true, GUIEditor.window[2])
	guiEditSetReadOnly(GUIEditor.edit[7], true)
	GUIEditor.label[13] = guiCreateLabel(0.51, 0.38, 0.03, 0.03, "Title: ", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[13], "default-bold-small")
	GUIEditor.edit[8] = guiCreateEdit(0.55, 0.37, 0.44, 0.04, "", true, GUIEditor.window[2])
	guiEditSetReadOnly(GUIEditor.edit[8], true)
	GUIEditor.label[14] = guiCreateLabel(0.51, 0.43, 0.07, 0.03, "Description: ", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[14], "default-bold-small")
	GUIEditor.memo[3] = guiCreateMemo(0.51, 0.46, 0.48, 0.14, "", true, GUIEditor.window[2])
	guiMemoSetReadOnly(GUIEditor.memo[3], true)
	GUIEditor.label[15] = guiCreateLabel(0.51, 0.60, 0.26, 0.03, "Attachments (Click the image for full view):", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[15], "default-bold-small")
	GUIEditor.staticimage[2] = guiCreateStaticImage(0.52, 0.64, 0.13, 0.14, ":server/Images/disc.png", true, GUIEditor.window[2])
	GUIEditor.button[6] = guiCreateButton(0.65, 0.64, 0.11, 0.05, "View", true, GUIEditor.window[2])
	GUIEditor.label[16] = guiCreateLabel(0.51, 0.78, 0.49, 0.03, "---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[16], "default-bold-small")
	guiLabelSetColor(GUIEditor.label[16], 255, 0, 0)
	GUIEditor.label[17] = guiCreateLabel(0.51, 0.81, 0.05, 0.03, "Actions:", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[17], "default-bold-small")
	GUIEditor.button[7] = guiCreateButton(0.57, 0.81, 0.12, 0.04, "Valid Report", true, GUIEditor.window[2])
	GUIEditor.button[8] = guiCreateButton(0.52, 0.86, 0.17, 0.04, "Invalid Report and Reason:", true, GUIEditor.window[2])
	GUIEditor.label[18] = guiCreateLabel(0.51, 0.93, 0.29, 0.05, "AuroraRPG - Reporting System", true, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[18], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[18], "left", true)
	GUIEditor.edit[9] = guiCreateEdit(0.69, 0.86, 0.30, 0.04, "Not enough evidence", true, GUIEditor.window[2])
	GUIEditor.button[9] = guiCreateButton(0.69, 0.81, 0.12, 0.04, "Invalid Report", true, GUIEditor.window[2])
	GUIEditor.button[10] = guiCreateButton(0.89, 0.93, 0.10, 0.05, "Close", true, GUIEditor.window[2])
	
	triggerServerEvent ("AURadminreports.requestNewReportingList", resourceRoot, getLocalPlayer())
	
	guiSetInputMode("no_binds_when_editing")
	
	addEventHandler( "onClientGUIClick", GUIEditor.gridlist[2], function(btn) 
	if btn ~= 'left' then return false end 
	  local row, col = guiGridListGetSelectedItem(source) 
		  if row >= 0 and col >= 0 then 
			for i=1, #repotings do
				if (i == math.floor(guiGridListGetItemText(source, row, 1))) then
					--guiStaticImageLoadImage(GUIEditor.staticimage[2], repotings[i][8])
					if (not fileExists(repotings[i][8])) then 
						triggerServerEvent ("AURadminreports.requestScreenshot", resourceRoot, getLocalPlayer(), repotings[i][8])
						guiSetEnabled(GUIEditor.gridlist[2], false)
						guiStaticImageLoadImage(GUIEditor.staticimage[2], "downloading.png")
						guiSetText(GUIEditor.label[6], "Downloading screenshot from the server")
						if (not isTimer(timerzz)) then 
							timerzz = setTimer(function()
								guiSetText(GUIEditor.label[6], "Opened Cases: "..total.." | Overall Reports: "..#repotings.."")
							end, 5000, 1)
						end 
						exports.NGCdxmsg:createNewDxMessage("Downloading screenshot from the server", 255, 255, 0)
					else
						guiSetEnabled(GUIEditor.gridlist[2], true)
						guiStaticImageLoadImage(GUIEditor.staticimage[2], repotings[i][8])
						currentfile = repotings[i][8]
					end
					
					currfile = repotings[i][8]
					guiSetText(GUIEditor.edit[3], repotings[i][1])
					guiSetText(GUIEditor.edit[4], repotings[i][2])
					guiSetText(GUIEditor.edit[5], repotings[i][3])
					guiSetText(GUIEditor.edit[6], repotings[i][4])
					guiSetText(GUIEditor.edit[7], i)
					guiSetText(GUIEditor.edit[8], repotings[i][6])
					guiSetText(GUIEditor.memo[3], repotings[i][7])
					if (repotings[i][9] == true) then 
						guiSetEnabled(GUIEditor.edit[9], false)
						guiSetEnabled(GUIEditor.button[9], false)
						guiSetEnabled(GUIEditor.button[8], false)
						guiSetEnabled(GUIEditor.button[7], false)
						
						guiSetText(GUIEditor.label[6], "This report case is closed")
						guiLabelSetColor (GUIEditor.label[6], 255, 0, 0)
					else
						guiSetEnabled(GUIEditor.edit[9], true)
						guiSetEnabled(GUIEditor.button[9], true)
						guiSetEnabled(GUIEditor.button[8], true)
						guiSetEnabled(GUIEditor.button[7], true)
						guiLabelSetColor (GUIEditor.label[6], 255, 255, 255)
					end 
					--guiSetText(GUIEditor.label[6], "Opened Cases: "..total.." | Overall Reports: "..#repotings.."")
					return 
				end 
			end
				guiStaticImageLoadImage(GUIEditor.staticimage[2], ":server/Images/disc.png")
				currentfile = ":server/Images/disc.png"
				guiLabelSetColor (GUIEditor.label[6], 255, 255, 255)
				guiSetText(GUIEditor.edit[3], "")
				guiSetText(GUIEditor.edit[4], "")
				guiSetText(GUIEditor.edit[5], "")
				guiSetText(GUIEditor.edit[6], "")
				guiSetText(GUIEditor.edit[7], "")
				guiSetText(GUIEditor.edit[8], "")
				guiSetText(GUIEditor.memo[3], "")
				guiSetEnabled(GUIEditor.gridlist[2], true)
				guiSetText(GUIEditor.label[6], "Opened Cases: "..total.." | Overall Reports: "..#repotings.."")
			else
				guiStaticImageLoadImage(GUIEditor.staticimage[2], ":server/Images/disc.png")
				currentfile = ":server/Images/disc.png"
				guiLabelSetColor (GUIEditor.label[6], 255, 255, 255)
				guiSetText(GUIEditor.edit[3], "")
				guiSetText(GUIEditor.edit[4], "")
				guiSetText(GUIEditor.edit[5], "")
				guiSetText(GUIEditor.edit[6], "")
				guiSetText(GUIEditor.edit[7], "")
				guiSetText(GUIEditor.edit[8], "")
				guiSetText(GUIEditor.memo[3], "")
				guiSetEnabled(GUIEditor.gridlist[2], true)
				guiSetText(GUIEditor.label[6], "Opened Cases: "..total.." | Overall Reports: "..#repotings.."")
		  end 
	end, false) 
	
	
	addEventHandler("onClientGUIClick", GUIEditor.button[10], openAdminReport, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[6], function()
		viewFullScreenshot(currentfile)
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.staticimage[2], function()
		viewFullScreenshot(currentfile)
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[7], function()
		if (guiGetText(GUIEditor.edit[7]) == "") then 
			exports.NGCdxmsg:createNewDxMessage("Please select a case in the gridlist.", 255, 0, 0)
		else
			triggerServerEvent ("AURadminreports.setCaseStatus", resourceRoot, getLocalPlayer(), "valid", math.floor(guiGetText(GUIEditor.edit[7])), guiGetText(GUIEditor.edit[9]))
			exports.NGCdxmsg:createNewDxMessage("Report #"..guiGetText(GUIEditor.edit[7]).." has been set to valid.", 40, 237, 255)
			refreshEntireReports()
		end 
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[8], function()
		if (guiGetText(GUIEditor.edit[7]) == "") then 
			exports.NGCdxmsg:createNewDxMessage("Please select a case in the gridlist.", 255, 0, 0)
		else
			triggerServerEvent ("AURadminreports.setCaseStatus", resourceRoot, getLocalPlayer(), "invalid_custom", math.floor(guiGetText(GUIEditor.edit[7])), guiGetText(GUIEditor.edit[9]))
			exports.NGCdxmsg:createNewDxMessage("Report #"..guiGetText(GUIEditor.edit[7]).." has been set to invalid ("..guiGetText(GUIEditor.edit[9])..").", 40, 237, 255)
			refreshEntireReports()
		end 
	end, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[9], function()
		if (guiGetText(GUIEditor.edit[7]) == "") then 
			exports.NGCdxmsg:createNewDxMessage("Please select a case in the gridlist.", 255, 0, 0)
		else
			triggerServerEvent ("AURadminreports.setCaseStatus", resourceRoot, getLocalPlayer(), "invalid", math.floor(guiGetText(GUIEditor.edit[7])), guiGetText(GUIEditor.edit[9]))
			exports.NGCdxmsg:createNewDxMessage("Report #"..guiGetText(GUIEditor.edit[7]).." has been set to invalid.", 40, 237, 255)
			refreshEntireReports()
		end 
	end, false)
	end
end
addCommandHandler("reports", openAdminReport)

function refreshEntireReports()
	if (isElement(GUIEditor.window[2])) then 
		openAdminReport()
	end 
	openAdminReport()
end 

function viewFullScreenshot(path)
	if (isElement(GUIEditor.window[3])) then 
		destroyElement(GUIEditor.window[3])
	else
	GUIEditor.window[3] = guiCreateWindow(0.01, 0.01, 0.99, 0.98, "AuroraRPG - Screenshot", true)
	guiWindowSetSizable(GUIEditor.window[3], false)
	guiSetAlpha(GUIEditor.window[3], 1.00)

	GUIEditor.staticimage[3] = guiCreateStaticImage(0.02, 0.07, 0.96, 0.92, path, true, GUIEditor.window[3])
	GUIEditor.button[11] = guiCreateButton(1134, 28, 104, 18, "Close", false, GUIEditor.window[3])
	addEventHandler("onClientGUIClick", GUIEditor.button[11], viewFullScreenshot, false)
	end
end

