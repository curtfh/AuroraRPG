local drug1 = nil
local drug2 = nil
local drug3 = nil
local earn = nil
local positions = {}

local CraftingPanel = {
    button = {},
    staticimage = {},
    label = {},
    radiobutton = {}
}

addEventHandler("onClientResourceStart",resourceRoot,function()
	--CraftingPanel.staticimage[1] = guiCreateStaticImage(155, 204, 493, 246, "background.png", false)
	CraftingPanel.staticimage[1] = guiCreateWindow(64, 106, 450,250, "Aurora ~ Craft", false)
	guiWindowSetSizable(CraftingPanel.staticimage[1], false)
	guiSetAlpha(CraftingPanel.staticimage[1], 1.00)
	guiSetVisible(CraftingPanel.staticimage[1],false)
	centerWindows(CraftingPanel.staticimage[1])
	CraftingPanel.staticimage[3] = guiCreateStaticImage(140, 106, 50, 45, "plus.png", false, CraftingPanel.staticimage[1])
	CraftingPanel.radiobutton[1] = guiCreateRadioButton(28, 33, 102, 29, "Ritalin", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[1], "default-bold-small")
	guiRadioButtonSetSelected(CraftingPanel.radiobutton[1], true)
	CraftingPanel.radiobutton[2] = guiCreateRadioButton(28, 70, 102, 29, "Weed", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[2], "default-bold-small")
	CraftingPanel.radiobutton[3] = guiCreateRadioButton(28, 112, 102, 29, "Ecstasy", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[3], "default-bold-small")
	CraftingPanel.radiobutton[4] = guiCreateRadioButton(28, 151, 102, 29, "Cocaine", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[4], "default-bold-small")
	CraftingPanel.radiobutton[5] = guiCreateRadioButton(28, 190, 102, 29, "Heroine", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[5], "default-bold-small")
	CraftingPanel.radiobutton[6] = guiCreateRadioButton(204, 34, 102, 29, "Ritalin", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[6], "default-bold-small")
	CraftingPanel.radiobutton[7] = guiCreateRadioButton(204, 70, 102, 29, "Weed", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[7], "default-bold-small")
	CraftingPanel.radiobutton[8] = guiCreateRadioButton(204, 112, 102, 29, "Ecstasy", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[8], "default-bold-small")
	CraftingPanel.radiobutton[9] = guiCreateRadioButton(204, 151, 102, 29, "Cocaine", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[9], "default-bold-small")
	CraftingPanel.radiobutton[10] = guiCreateRadioButton(204, 190, 102, 29, "Heroine", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.radiobutton[10], "default-bold-small")
	CraftingPanel.label[1] = guiCreateLabel(316, 15, 15, 221, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, CraftingPanel.staticimage[1])
	CraftingPanel.button[1] = guiCreateButton(331, 150, 130, 30, "Craft", false, CraftingPanel.staticimage[1])
	guiSetProperty(CraftingPanel.button[1], "NormalTextColour", "FFAAAAAA")
	CraftingPanel.button[2] = guiCreateButton(331, 189, 130, 30, "Close", false, CraftingPanel.staticimage[1])
	guiSetProperty(CraftingPanel.button[2], "NormalTextColour", "FFAAAAAA")
	--CraftingPanel.label[2] = guiCreateLabel(331, 122, 137, 23, "Are you sure about this?", false, CraftingPanel.staticimage[1])
	--guiSetFont(CraftingPanel.label[2], "default-bold-small")
	editbox = guiCreateEdit(331, 118,130,30,"0",false,CraftingPanel.staticimage[1])
	CraftingPanel.label[3] = guiCreateLabel(331, 34, 137, 23, "First Type:", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.label[3], "default-bold-small")
	CraftingPanel.label[4] = guiCreateLabel(331, 63, 137, 23, "Second Type:", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.label[4], "default-bold-small")
	CraftingPanel.label[5] = guiCreateLabel(331, 92, 137, 23, "Result:", false, CraftingPanel.staticimage[1])
	guiSetFont(CraftingPanel.label[5], "default-bold-small")
	addEventHandler("onClientGUIClick",CraftingPanel.button[1],crafting,false)
	addEventHandler("onClientGUIClick",CraftingPanel.button[2],closePanel,false)
	addEventHandler("onClientGUIClick",CraftingPanel.staticimage[3],selectCrafted,false)
	addEventHandler("onClientGUIChanged",editbox, removeL,false)
	addEventHandler("onClientMouseEnter",CraftingPanel.staticimage[3],Enter,false)
	addEventHandler("onClientMouseLeave",CraftingPanel.staticimage[3],Leave,false)
	sexy = setTimer(function()
		monitor()
	end,1000,0)
end)


function removeL(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
end

function Enter()
	guiSetAlpha(source,0.5)
end

function Leave()
	guiSetAlpha(source,1)
end

function closePanel()
	if isTimer(checker) then killTimer(checker) end
	guiSetVisible(CraftingPanel.staticimage[1],false)
	showCursor(false)
	setElementData(localPlayer,"isPlayerCrafting",false)
end

function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end

function msg(s)
	return exports.NGCdxmsg:createNewDxMessage(s,255,0,0)
end


function startCrafting()
	if not isPedOnGround(localPlayer) then
		msg("You must be on the ground")
		return
	end
	local cx, cy, cz = getElementPosition(localPlayer)
	if (getDistanceBetweenPoints3D(1628, -1471, 22, cx, cy, cz) > 1500) then
		msg("You are too far away from Los Santos")
		return
	end
	if getElementInterior(localPlayer) ~= 0 or getElementDimension(localPlayer) ~= 0 then
		msg("You can't craft drugs outside the main world!")
		return
	end
	local x, y, z = getElementPosition(localPlayer)
	if (z >= 55) then
		msg("You can't craft drugs on this height!!")
		return
	end
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals" then
		msg("You can't craft drugs while you're not a criminal!")
		return
	end
	local x,y,z = unpack(positions)
	if x and y and z then
		local cx, cy, cz = getElementPosition(localPlayer)
		if (getDistanceBetweenPoints3D(x,y,z, cx, cy, cz) < 100) then
			msg("This spot is now visibled , please change the area!!!")
			return
		end
	end
	if getElementData(localPlayer,"isPlayerCrafting") then
		msg("You are already crafting, wait for the progress")
		return
	end
	if getElementData(localPlayer,"isPlayerMakingDrugs") then
		msg("You can't craft drugs while you are making drugs!",255,0,0)
		return false
	end
	if isCursorShowing(localPlayer) then
		msg("Please close any panel before you do this")
		return
	end
	guiSetVisible(CraftingPanel.staticimage[1],true)
	showCursor(true)
	resetLab()
	getMyDrug()
	checker = setTimer(getMyDrug,500,0)
end
addCommandHandler("craft",startCrafting)


function getPlayerDrugAmount(name)
	local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
	if drugsTable == nil then return false end
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2] == name) then
			return drugNames[a2],tonumber(b)
		end
	end
end

function getMyDrug()
	if not guiGetVisible(CraftingPanel.staticimage[1]) then
		if isTimer(checker) then killTimer(checker) end
		return
	end
	local drugsTable,drugNames = exports.CSGdrugs:getDrugsTable()
	if drugsTable == nil then return false end
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2]) then
			if drugNames[a2] == "Ritalin" then
				guiSetText(CraftingPanel.radiobutton[1],"Ritalin ("..b..")")
				guiSetText(CraftingPanel.radiobutton[6],"Ritalin ("..b..")")
			elseif drugNames[a2] == "Weed" then
				guiSetText(CraftingPanel.radiobutton[2],"Weed ("..b..")")
				guiSetText(CraftingPanel.radiobutton[7],"Weed ("..b..")")
			elseif drugNames[a2] == "Ecstasy" then
				guiSetText(CraftingPanel.radiobutton[3],"Ecstasy ("..b..")")
				guiSetText(CraftingPanel.radiobutton[8],"Ecstasy ("..b..")")
			elseif drugNames[a2] == "Cocaine" then
				guiSetText(CraftingPanel.radiobutton[4],"Cocaine ("..b..")")
				guiSetText(CraftingPanel.radiobutton[9],"Cocaine ("..b..")")
			elseif drugNames[a2] == "Heroine" then
				guiSetText(CraftingPanel.radiobutton[5],"Heroine ("..b..")")
				guiSetText(CraftingPanel.radiobutton[10],"Heroine ("..b..")")
			end
		end
	end
end

function selectCrafted()
	local sel = guiRadioButtonGetSelected
	if sel(CraftingPanel.radiobutton[1]) then --- 1st drug
		guiSetText(CraftingPanel.label[3],"First Type: Ritalin")
		drug1 = "Ritalin"
	elseif sel(CraftingPanel.radiobutton[2]) then
		guiSetText(CraftingPanel.label[3],"First Type: Weed")
		drug1 = "Weed"
	elseif sel(CraftingPanel.radiobutton[3]) then
		guiSetText(CraftingPanel.label[3],"First Type: Ecstasy")
		drug1 = "Ecstasy"
	elseif sel(CraftingPanel.radiobutton[4]) then
		guiSetText(CraftingPanel.label[3],"First Type: Cocaine")
		drug1 = "Cocaine"
	elseif sel(CraftingPanel.radiobutton[5]) then
		guiSetText(CraftingPanel.label[3],"First Type: Heroine")
		drug1 = "Heroine"
	elseif sel(CraftingPanel.radiobutton[6]) then --- 2nd drug
		guiSetText(CraftingPanel.label[4],"Second Type: Ritalin")
		drug2 = "Ritalin"
	elseif sel(CraftingPanel.radiobutton[7]) then
		guiSetText(CraftingPanel.label[4],"Second Type: Weed")
		drug2 = "Weed"
	elseif sel(CraftingPanel.radiobutton[8]) then
		guiSetText(CraftingPanel.label[4],"Second Type: Ecstasy")
		drug2 = "Ecstasy"
	elseif sel(CraftingPanel.radiobutton[9]) then
		guiSetText(CraftingPanel.label[4],"Second Type: Cocaine")
		drug2 = "Cocaine"
	elseif sel(CraftingPanel.radiobutton[10]) then
		guiSetText(CraftingPanel.label[4],"Second Type: Heroine")
		drug2 = "Heroine"
	end
	if drug1 ~= nil and drug2 ~= nil then
		if drug1 == drug2 then
			drug1 = nil
			drug2 = nil
			drug3 = nil
			earn = nil
			guiSetText(CraftingPanel.label[3],"First Type:")
			guiSetText(CraftingPanel.label[4],"Second Type:")
			guiSetText(CraftingPanel.label[5],"Result:")
			msg("You can't use the same drugs type to craft!")
			return false
		end
		if drug1 == "Ritalin" and drug2 == "Weed" then
			drug3 = "Ecstasy"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Ritalin" and drug2 == "Ecstasy" then
			drug3 = "Cocaine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Ritalin" and drug2 == "Cocaine" then
			drug3 = "Heroine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Ritalin" and drug2 == "Heroine" then
			drug3 = "Weed"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
			-----------------------------------------------------
		elseif drug1 == "Weed" and drug2 == "Ritalin" then
			drug3 = "Ecstasy"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Weed" and drug2 == "Ecstasy" then
			drug3 = "Cocaine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Weed" and drug2 == "Cocaine" then
			drug3 = "Heroine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Weed" and drug2 == "Heroine" then
			drug3 = "Ritalin"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
			-----------------------------------------------------
		elseif drug1 == "Ecstasy" and drug2 == "Weed" then
			drug3 = "Ritalin"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Ecstasy" and drug2 == "Ritalin" then
			drug3 = "Cocaine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Ecstasy" and drug2 == "Cocaine" then
			drug3 = "Heroine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Ecstasy" and drug2 == "Heroine" then
			drug3 = "Weed"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
			-----------------------------------------------------
		elseif drug1 == "Cocaine" and drug2 == "Weed" then
			drug3 = "Ritalin"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Cocaine" and drug2 == "Ritalin" then
			drug3 = "Ecstasy"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Cocaine" and drug2 == "Ecstasy" then
			drug3 = "Heroine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Cocaine" and drug2 == "Heroine" then
			drug3 = "Weed"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
			-----------------------------------------------------
		elseif drug1 == "Heroine" and drug2 == "Weed" then
			drug3 = "Ritalin"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Heroine" and drug2 == "Ritalin" then
			drug3 = "Ecstasy"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Heroine" and drug2 == "Ecstasy" then
			drug3 = "Cocaine"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		elseif drug1 == "Heroine" and drug2 == "Cocaine" then
			drug3 = "Weed"
			guiSetText(CraftingPanel.label[5],"Result: "..drug3)
		end
	end
end
addEvent("destroyCraftShop",true)
function resetLab()
	exports.CSGprogressbar:cancelProgressBar()
	guiSetText(CraftingPanel.label[3],"First Type: ?")
	guiSetText(CraftingPanel.label[4],"Second Type: ?")
	guiSetText(CraftingPanel.label[5],"Result: ?")
	drug1,drug2,drug3,earn = nil,nil,nil,nil
	setElementData(localPlayer,"isPlayerCrafting",false)
end
addEventHandler("destroyCraftShop",root,resetLab)
local sx, sy = guiGetScreenSize()

function crafting()
	if source == CraftingPanel.button[1] then
		if drug1 ~= nil and drug2 ~= nil then
			local amount = guiGetText(editbox)
			local amount = tonumber(amount)
			if amount >= 10 then
				local name,hexAmount = getPlayerDrugAmount(tostring(drug1))
				local neme,rexAmount = getPlayerDrugAmount(tostring(drug2))
				if tonumber(hexAmount) >= amount and tonumber(rexAmount) >= amount then
					setElementData(localPlayer,"isPlayerCrafting",true)
					guiSetVisible(CraftingPanel.staticimage[1],false)
					earn = math.floor(amount/2)
					temp1 = math.floor(amount)
					bindKey("space","down",resetCrafting)
					exports.CSGprogressbar:createProgressBar( "Crafting ...", 50, "craftedDrugs" )
				else
					msg("You don't have this amount of drugs")
				end
			else
				msg("Please use valid amount for craft (Min: 10 hits)")
			end
		else
			msg("Please select drugs to craft")
		end
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
	if getElementData(localPlayer,"isPlayerCrafting") then
		if drug1 ~= nil and drug2 ~= nil and earn ~= nil then
			dxDrawRelativeText( "Press Space to cancel this process", 360,669,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Press Space to cancel this process", 360,670,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Press Space to cancel this process", 360,671,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Press Space to cancel this process", 360,670,1156.0,274.0,tocolor(255,255,255,255),1,"pricedown","left","top",false,false,false )

			dxDrawRelativeText( "Crafting ("..temp1.." hits of "..drug1.." + "..temp1.." hits of "..drug2..") = "..earn.." hits of "..drug3, 360,719,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Crafting ("..temp1.." hits of "..drug1.." + "..temp1.." hits of "..drug2..") = "..earn.." hits of "..drug3, 360,720,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Crafting ("..temp1.." hits of "..drug1.." + "..temp1.." hits of "..drug2..") = "..earn.." hits of "..drug3, 360,721,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Crafting ("..temp1.." hits of "..drug1.." + "..temp1.." hits of "..drug2..") = "..earn.." hits of "..drug3, 360,720,1156.0,274.0,tocolor(255,255,255,255),1,"pricedown","left","top",false,false,false )

		end
	end
end
addEventHandler("onClientRender",root,createText)

function resetCrafting()
	if getElementData(localPlayer,"isPlayerCrafting") then
		showCursor(false)
		guiSetVisible(CraftingPanel.staticimage[1],false)
		resetLab()
		unbindKey("space","down",resetCrafting)
		setElementData(localPlayer,"isPlayerCrafting",false)
	end
end

addEvent("craftedDrugs",true)
addEventHandler("craftedDrugs",root,function()
	if drug1 and drug2 and drug3 then
		--outputDebugString("Trigger was added for "..FDrug.."/"..DDrug.."/"..RDrug)
		outputDebugString("Trigger was defined  by taken "..temp1.." and given "..earn)
		triggerServerEvent("drugLabGiven",localPlayer,localPlayer,drug1,drug2,drug3,temp1,earn)
		showCursor(false)
		resetLab()
		setElementData(localPlayer,"isPlayerCrafting",false)
	else
		msg("Error while you're crafting please try again!")
	end
end)


---------------------------------------------------
local code = nil
local hcode = nil
local choosenDrug = nil
local clicks = 0
local labJob = false
drugsLab = {
    button = {},
    staticimage = {},
    label = {}
}
LabDeal = {
    button = {},
    staticimage = {},
    label = {}
}

makingLab = {
    button = {},
    staticimage = {},
    label = {},
    radiobutton = {}
}

local codesTemp = {
	[1]={"215469",27}, -- == 27
	[2]={"654897",39}, -- == 39
	[3]={"378452",29}, -- == 29
	[4]={"378462",30}, -- == 30
	[5]={"278413",25}, -- == 25
	[6]={"645397",34}, -- == 34
	[7]={"192637",28}, -- == 28
	[8]={"124356",21}, -- == 21
	[9]={"976483",37}, -- == 37
	[10]={"453621",21},-- == 21
}

addEventHandler("onClientResourceStart",resourceRoot,function()

	--makingLab.staticimage[1] = guiCreateStaticImage(179, 167, 450, 300, "background.png", false)
	makingLab.staticimage[1] = guiCreateWindow(64, 106, 450,300, "Aurora ~ Drugs Maker", false)
	guiWindowSetSizable(makingLab.staticimage[1], false)
	guiSetVisible(makingLab.staticimage[1],false)
	guiSetAlpha(makingLab.staticimage[1], 1.00)
	centerWindows(makingLab.staticimage[1])
	makingLab.staticimage[2] = guiCreateStaticImage(23, 94, 79, 65, "ritalin.png", false, makingLab.staticimage[1])
	makingLab.staticimage[3] = guiCreateStaticImage(190, 94, 75, 67, "ecstacy.png", false, makingLab.staticimage[1])
	makingLab.staticimage[4] = guiCreateStaticImage(351, 94, 73, 67, "ecstacy.png", false, makingLab.staticimage[1])
	makingLab.staticimage[5] = guiCreateStaticImage(106, 94, 79, 67, "cocaine.png", false, makingLab.staticimage[1])
	makingLab.staticimage[6] = guiCreateStaticImage(269, 94, 77, 67, "heroine.png", false, makingLab.staticimage[1])
	makingLab.label[1] = guiCreateLabel(102, 20, 249, 57, "NGC ~ Drugs Factory", false, makingLab.staticimage[1])
	guiSetFont(makingLab.label[1], "sa-header")
	makingLab.radiobutton[1] = guiCreateRadioButton(28, 169, 64, 26, "Ritalin", false, makingLab.staticimage[1])
	guiSetFont(makingLab.radiobutton[1], "default-bold-small")
	makingLab.radiobutton[2] = guiCreateRadioButton(111, 169, 64, 26, "Cocaine", false, makingLab.staticimage[1])
	guiSetFont(makingLab.radiobutton[2], "default-bold-small")
	makingLab.radiobutton[3] = guiCreateRadioButton(195, 169, 64, 26, "Weed", false, makingLab.staticimage[1])
	guiSetFont(makingLab.radiobutton[3], "default-bold-small")
	makingLab.radiobutton[4] = guiCreateRadioButton(275, 169, 64, 26, "Heroine", false, makingLab.staticimage[1])
	guiSetFont(makingLab.radiobutton[4], "default-bold-small")
	makingLab.radiobutton[5] = guiCreateRadioButton(356, 169, 64, 26, "Ecstasy", false, makingLab.staticimage[1])
	guiSetFont(makingLab.radiobutton[5], "default-bold-small")
	makingLab.label[2] = guiCreateLabel(111, 212, 235, 18, "Each process will give you 35 hits ", false, makingLab.staticimage[1])
	guiSetFont(makingLab.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(makingLab.label[2], "center", false)
	makingLab.button[1] = guiCreateButton(28, 250, 128, 28, "Start", false, makingLab.staticimage[1])
	guiSetProperty(makingLab.button[1], "NormalTextColour", "FFAAAAAA")
	makingLab.button[2] = guiCreateButton(292, 251, 128, 28, "Close", false, makingLab.staticimage[1])
	guiSetProperty(makingLab.button[2], "NormalTextColour", "FFAAAAAA")
	addEventHandler("onClientGUIClick",makingLab.button[1],chooseType,false)
	addEventHandler("onClientGUIClick",makingLab.button[2],function()
		guiSetVisible(makingLab.staticimage[1],false)
		setElementData(localPlayer,"isPlayerMakingDrugs",false)
		showCursor(false)
	end,false)
	---LabDeal.staticimage[1] = guiCreateStaticImage(192, 165, 395, 307, "background.png", false)
	--guiSetVisible(LabDeal.staticimage[1],false)
	LabDeal.staticimage[1] = guiCreateWindow(64, 106, 400,300, "Aurora ~ Drugs Lab", false)
	guiWindowSetSizable(LabDeal.staticimage[1], false)
	guiSetVisible(LabDeal.staticimage[1],false)
	guiSetAlpha(LabDeal.staticimage[1], 1.00)
	centerWindows(LabDeal.staticimage[1])
	guiSetVisible(LabDeal.staticimage[1],false)
--	showCursor(true)

	LabDeal.label[1] = guiCreateLabel(37, 20, 323, 38, "Drugs Lab", false, LabDeal.staticimage[1])
	guiSetFont(LabDeal.label[1], "sa-header")
	guiLabelSetHorizontalAlign(LabDeal.label[1], "center", false)
	guiLabelSetVerticalAlign(LabDeal.label[1], "center")
	LabDeal.label[2] = guiCreateLabel(27, 84, 342, 85, "Before you start making drugs\nYou must be aware from something\nYou will be wanted! and the Government come to get you!", false, LabDeal.staticimage[1])
	guiSetFont(LabDeal.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(LabDeal.label[2], "center", false)
	guiLabelSetVerticalAlign(LabDeal.label[2], "center")
	LabDeal.button[1] = guiCreateButton(142, 221, 125, 26, "I agree", false, LabDeal.staticimage[1])
	guiSetProperty(LabDeal.button[1], "NormalTextColour", "FFAAAAAA")
	LabDeal.button[2] = guiCreateButton(142, 251, 125, 26, "No thx dude !", false, LabDeal.staticimage[1])
	guiSetProperty(LabDeal.button[2], "NormalTextColour", "FFAAAAAA")

	addEventHandler("onClientGUIClick",LabDeal.button[1],startDeal,false)
	addEventHandler("onClientGUIClick",LabDeal.button[2],function()
		guiSetVisible(LabDeal.staticimage[1],false)
		showCursor(false)
		setElementData(localPlayer,"isPlayerMakingDrugs",false)
	end,false)

	---drugsLab.staticimage[1] = guiCreateStaticImage(153, 136, 558, 381, "background.png", false)
	drugsLab.staticimage[1] = guiCreateWindow(64, 106, 550,400, "Aurora ~ Drugs Maker", false)
	guiWindowSetSizable(drugsLab.staticimage[1], false)
	guiSetVisible(drugsLab.staticimage[1],false)
	guiSetAlpha(drugsLab.staticimage[1], 1.00)
	centerWindows(drugsLab.staticimage[1])

	drugsLab.staticimage[2] = guiCreateStaticImage(37, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[3] = guiCreateStaticImage(143, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[4] = guiCreateStaticImage(250, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[5] = guiCreateStaticImage(358, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[6] = guiCreateStaticImage(453, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[7] = guiCreateStaticImage(92, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[8] = guiCreateStaticImage(199, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[9] = guiCreateStaticImage(307, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[10] = guiCreateStaticImage(409, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.button[1] = guiCreateButton(37, 317, 146, 33, "Enter Code", false, drugsLab.staticimage[1])
	guiSetProperty(drugsLab.button[1], "NormalTextColour", "FFAAAAAA")
	drugsLab.button[2] = guiCreateButton(368, 316, 146, 33, "Close", false, drugsLab.staticimage[1])
	guiSetProperty(drugsLab.button[2], "NormalTextColour", "FFAAAAAA")
	drugsLab.label[11] = guiCreateLabel(209, 312, 125, 33, "Code:", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[11], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[11], "center", false)
	guiLabelSetVerticalAlign(drugsLab.label[11], "center")
	drugsLab.label[1] = guiCreateLabel(57, 252, 461, 42, "Enter the correct code to make the recipment", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[1], "sa-header")
	drugsLab.label[2] = guiCreateLabel(32, 101, 76, 19, "1", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[2], "center", false)
	drugsLab.label[3] = guiCreateLabel(138, 101, 76, 19, "2", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[3], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[3], "center", false)
	drugsLab.label[4] = guiCreateLabel(245, 101, 76, 19, "3", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[4], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[4], "center", false)
	drugsLab.label[5] = guiCreateLabel(353, 101, 76, 19, "4", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[5], "center", false)
	drugsLab.label[6] = guiCreateLabel(448, 101, 76, 19, "5", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[6], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[6], "center", false)
	drugsLab.label[7] = guiCreateLabel(87, 204, 76, 19, "6", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[7], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[7], "center", false)
	drugsLab.label[8] = guiCreateLabel(194, 204, 76, 19, "7", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[8], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[8], "center", false)
	drugsLab.label[9] = guiCreateLabel(302, 204, 76, 19, "8", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[9], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[9], "center", false)
	drugsLab.label[10] = guiCreateLabel(404, 204, 76, 19, "9", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[10], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[10], "center", false)
	for i=2,10 do
		addEventHandler("onClientGUIClick",drugsLab.staticimage[i],testCode,false)
	end
	addEventHandler("onClientGUIClick",drugsLab.button[1],makeDrugs,false)
	addEventHandler("onClientGUIClick",drugsLab.button[2],closeLab,false)
end)

function closeLab()
	guiSetVisible(drugsLab.staticimage[1],false)
	showCursor(false)
	setElementData(localPlayer,"isPlayerMakingDrugs",false)
end

addEvent("showDrugLab",true)
addEventHandler("showDrugLab",root,function()
	if getElementData(localPlayer,"isPlayerCrafting") then
		msg("You can't make drugs while you are crafting",255,0,0)
		return false
	end
	if getElementInterior(localPlayer) ~= 0 or getElementDimension(localPlayer) ~= 0 then
		msg("You can't make drugs outside the main world!")
		return
	end
	if guiGetVisible(LabDeal.staticimage[1]) then
		msg("You can't make drugs while you already are doing it!",255,0,0)
		return false
	elseif guiGetVisible(makingLab.staticimage[1]) then
		msg("You can't make drugs while you already are doing it!",255,0,0)
		return false
	elseif guiGetVisible(LabDeal.staticimage[1]) then
		msg("You can't make drugs while you already are doing it!",255,0,0)
		return false
	end
	if getElementData(localPlayer,"isPlayerMakingDrugs") then
		guiSetVisible(LabDeal.staticimage[1],true)
		showCursor(true)
	else
		msg("You are making drugs, please wait",255,0,0)
	end
end)


function startDeal()
	guiSetVisible(LabDeal.staticimage[1],false)
	guiSetVisible(makingLab.staticimage[1],true)
end

function chooseType()
	local sel = guiRadioButtonGetSelected
	if sel(makingLab.radiobutton[1]) then
		choosenDrug = "Ritalin"
	elseif sel(makingLab.radiobutton[2]) then
		choosenDrug = "Cocaine"
	elseif sel(makingLab.radiobutton[3]) then
		choosenDrug = "Weed"
	elseif sel(makingLab.radiobutton[4]) then
		choosenDrug = "Heroine"
	elseif sel(makingLab.radiobutton[5]) then
		choosenDrug = "Ecstasy"
	end
	if choosenDrug ~= nil then
		startProcess()
	else
		msg("You have to select drug first")
	end
end

function startProcess()
	for i=2,10 do
		guiStaticImageLoadImage(drugsLab.staticimage[i],"dot1.png")
		guiSetEnabled(drugsLab.staticimage[i],true)
	end
	guiSetVisible(makingLab.staticimage[1],false)
	guiSetVisible(drugsLab.staticimage[1],true)
	local data = math.random(1,#codesTemp)
	code = codesTemp[data][2]
	outputDebugString(code)
	hcode = 0
	clicks = 0
	guiSetText(drugsLab.label[11],"Code:"..codesTemp[data][1])
end

function resetMaking()
	if getElementData(localPlayer,"isPlayerMakingDrugs") then
		unbindKey("space","down",resetMaking)
		code = nil
		hcode = nil
		clicks = nil
		choosenDrug = nil
		guiSetVisible(drugsLab.staticimage[1],false)
		guiSetVisible(LabDeal.staticimage[1],false)
		guiSetVisible(makingLab.staticimage[1],false)
		showCursor(false)
		labJob = false
		exports.CSGprogressbar:cancelProgressBar()
		setElementData(localPlayer,"markerID",false)
		setElementData(localPlayer,"markerElement",false)
		setElementData(localPlayer,"isPlayerMakingDrugs",false)
	end
end

function monitor()
	if getElementData(localPlayer,"drugsOpen") or getElementData(localPlayer,"drugSelling") then
		if guiGetVisible(drugsLab.staticimage[1]) then
			guiSetVisible(drugsLab.staticimage[1],false)
		end
		if guiGetVisible(LabDeal.staticimage[1]) then
			guiSetVisible(LabDeal.staticimage[1],false)
		end
		if guiGetVisible(makingLab.staticimage[1]) then
			guiSetVisible(makingLab.staticimage[1],false)
		end
		if getElementData(localPlayer,"isPlayerMakingDrugs") then
			resetMaking()
		end
		if getElementData(localPlayer,"isPlayerCrafting") then
			resetCrafting()
			resetLab()
		end
		if guiGetVisible(CraftingPanel.staticimage[1]) then
			guiSetVisible(CraftingPanel.staticimage[1],false)
		end
	end
end

function makeDrugs()
	if code ~= nil then
		if tonumber(code) == tonumber(hcode) then
			guiSetVisible(drugsLab.staticimage[1],false)
			showCursor(true)
			bindKey("space","down",resetMaking)
			labJob = true
			exports.NGCdxmsg:createNewDxMessage("You have the recipment of "..choosenDrug,255,255,0)
			exports.CSGprogressbar:createProgressBar( "Making drugs ...", 50, "makeDrugs" )
		end
	end
end

addEvent("destroyMakeShop",true)
addEventHandler("destroyMakeShop",root,function()
	resetMaking()
end)

addEvent("makeDrugs",true)
addEventHandler("makeDrugs",root,function()
	triggerServerEvent("playerJustMadeDrugs",localPlayer,choosenDrug)
	labJob = false
	showCursor(false)
	unbindKey("space","down",resetMaking)
end)

function testCode()
	if not guiGetEnabled(source) then return false end
	if source == drugsLab.staticimage[2] then
		hcode = hcode + 1
		clicks = clicks+1
	elseif source == drugsLab.staticimage[3] then
		hcode = hcode + 2
		clicks = clicks+1
	elseif source == drugsLab.staticimage[4] then
		hcode = hcode + 3
		clicks = clicks+1
	elseif source == drugsLab.staticimage[5] then
		hcode = hcode + 4
		clicks = clicks+1
	elseif source == drugsLab.staticimage[6] then
		hcode = hcode + 5
		clicks = clicks+1
	elseif source == drugsLab.staticimage[7] then
		hcode = hcode + 6
		clicks = clicks+1
	elseif source == drugsLab.staticimage[8] then
		hcode = hcode + 7
		clicks = clicks+1
	elseif source == drugsLab.staticimage[9] then
		hcode = hcode + 8
		clicks = clicks+1
	elseif source == drugsLab.staticimage[10] then
		hcode = hcode + 9
		clicks = clicks+1
	end
	guiStaticImageLoadImage(source,"dot2.png")
	guiSetEnabled(source,false)
	if clicks > 6 then
		guiSetVisible(drugsLab.staticimage[1],false)
		showCursor(false)
		labJob = false
		resetMaking()
		msg("You have entered more than 6 charachters.You have failed!")
	end
end


local screenWidth, screenHeight = guiGetScreenSize()
function createText()
	if getElementData(localPlayer,"isPlayerMakingDrugs") then
		if labJob == true and choosenDrug ~= nil then
			dxDrawRelativeText( "Press Space to cancel this process", 360,669,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Press Space to cancel this process", 360,670,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Press Space to cancel this process", 360,671,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Press Space to cancel this process", 360,670,1156.0,274.0,tocolor(255,255,255,255),1,"pricedown","left","top",false,false,false )

			dxDrawRelativeText( "Making (35 hits of "..choosenDrug..")", 360,719,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Making (35 hits of "..choosenDrug..")", 360,720,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Making (35 hits of "..choosenDrug..")", 360,721,1156.0,274.0,tocolor(0,0,0,230),1,"pricedown","left","top",false,false,false )
			dxDrawRelativeText( "Making (35 hits of "..choosenDrug..")", 360,720,1156.0,274.0,tocolor(255,255,255,255),1,"pricedown","left","top",false,false,false )

		end
	end
end
addEventHandler("onClientRender",root,createText)


local cmds = {
[1]="reconnect",
[2]="quit",
[3]="connect",
[4]="disconnect",
[5]="exit",
}

function unbindTheBindedKey()
	local key = getKeyBoundToCommand("reconnect")
	local key2 = getKeyBoundToCommand("quit")
	local key3 = getKeyBoundToCommand("connect")
	local key4 = getKeyBoundToCommand("disconnect")
	local key5 = getKeyBoundToCommand("exit")
--	local key6 = getKeyBoundToCommand("takehit")
	local key7 = getKeyBoundToCommand("dropkit")
	if key or key2 or key3 or key4 or key5  or key7 then
		if key then
			theKey = "Reconnect/Disconnect"
		elseif key2 then
			theKey = "Reconnect/Disconnect"
		elseif key3 then
			theKey = "Reconnect/Disconnect"
		elseif key4 then
			theKey = "Reconnect/Disconnect"
		elseif key5 then
			theKey = "Reconnect/Disconnect"
	--	elseif key6 then
	--		theKey = "takehit"
		elseif key7 then
			theKey = "dropkit"
		end
		if disabled then return end
		disabled = true
	else
		if not disabled then return end
		disabled = false
	end
end
setTimer(unbindTheBindedKey,500,0)
stuck = false
function handleInterrupt( status, ticks )
	if (status == 0) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago" )
		if getElementData(localPlayer,"isPlayerLoss") ~= true then
			stuck = true
			setElementData(localPlayer,"isPlayerLoss",true)
		end
	elseif (status == 1) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago and has just ended" )
		triggerServerEvent("setPacketLoss",localPlayer,false)
		if getElementData(localPlayer,"isPlayerLoss") == true then
			stuck = false
			setElementData(localPlayer,"isPlayerLoss",false)
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)

setTimer(function()
	if guiGetVisible(CraftingPanel.staticimage[1]) or guiGetVisible(makingLab.staticimage[1]) or guiGetVisible(LabDeal.staticimage[1]) or guiGetVisible(drugsLab.staticimage[1]) then
		if stuck == true then
			forceHide()
			errormsg("You are lagging due Huge Network Loss you can't open Craft panel")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			errormsg("You are lagging due PING you can't open Craft panel")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			errormsg("You can't open Craft panel in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			forceHide()
			errormsg("You are lagging due FPS you can't open Craft panel")
		end
		if getElementInterior(localPlayer) ~= 0 then
			forceHide()
			errormsg("Please be in the real world instead of interiors and other dims")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			errormsg("Please close Drugs panel")
		end
		if disabled then
			forceHide()
			errormsg("You can't use Craft system while bounded ("..theKey..")")
		end
		if isConsoleActive() then
			forceHide()
			errormsg("You can't use Craft system while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			errormsg("You can't use Craft system while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			errormsg("Please close MTA Main Menu")
		end
		if CraftingPanel.staticimage[1] and guiGetVisible(CraftingPanel.staticimage[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= CraftingPanel.staticimage[1] then
					if guiGetVisible(v) and guiGetVisible(CraftingPanel.staticimage[1]) then
						forceHide()
						errormsg("Please close any panel open!")
					end
				end
			end
		end
		if makingLab.staticimage[1] and guiGetVisible(makingLab.staticimage[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= makingLab.staticimage[1] then
					if guiGetVisible(v) and guiGetVisible(makingLab.staticimage[1]) then
						forceHide()
						errormsg("Please close any panel open!")
					end
				end
			end
		end
		if drugsLab.staticimage[1] and guiGetVisible(drugsLab.staticimage[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= drugsLab.staticimage[1] then
					if guiGetVisible(v) and guiGetVisible(drugsLab.staticimage[1]) then
						forceHide()
						errormsg("Please close any panel open!")
					end
				end
			end
		end
		if LabDeal.staticimage[1] and guiGetVisible(LabDeal.staticimage[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= LabDeal.staticimage[1] then
					if guiGetVisible(v) and guiGetVisible(LabDeal.staticimage[1]) then
						forceHide()
						errormsg("Please close any panel open!")
					end
				end
			end
		end
	end
	if getElementData(localPlayer,"isPlayerMakingDrugs") or getElementData(localPlayer,"isPlayerCrafting") then
		if stuck == true then
			forceHide()
			errormsg("You are lagging due Huge Network Loss you can't craft or make drugs")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			errormsg("You are lagging due PING you can't craft or make drugs")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			errormsg("You can't craft or make drugs in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			forceHide()
			errormsg("You are lagging due FPS you can't craft or make drugs")
		end
		if getElementInterior(localPlayer) ~= 0 then
			forceHide()
			errormsg("Please be in the real world instead of interiors and other dims")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			errormsg("Please close Drugs panel")
		end
		if disabled then
			forceHide()
			errormsg("You can't craft or make drugs while bounded ("..theKey..")")
		end
		if isConsoleActive() then
			forceHide()
			errormsg("You can't craft or make drugs while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			errormsg("You can't use Craft system while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			errormsg("Please close MTA Main Menu")
		end
	end
end,500,0)

function errormsg(s)
	if s then
		exports.NGCdxmsg:createNewDxMessage(s,255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage("You are lagging : You can't craft or make drugs at the moment!",255,0,0)
	end
	resetMaking()
	resetCrafting()
	forceHide ()
	exports.NGCdxmsg:createNewDxMessage("Sorry the process was cancelled by the system",255,0,0)
end

function forceHide ()
	if guiGetVisible(drugsLab.staticimage[1]) then
			guiSetVisible(drugsLab.staticimage[1],false)
	end
	if guiGetVisible(LabDeal.staticimage[1]) then
		guiSetVisible(LabDeal.staticimage[1],false)
	end
	if guiGetVisible(makingLab.staticimage[1]) then
		guiSetVisible(makingLab.staticimage[1],false)
	end
	if getElementData(localPlayer,"isPlayerMakingDrugs") then
		resetMaking()
	end
	if getElementData(localPlayer,"isPlayerCrafting") then
		resetCrafting()
		resetLab()
	end
	if guiGetVisible(CraftingPanel.staticimage[1]) then
		guiSetVisible(CraftingPanel.staticimage[1],false)
	end
	showCursor(false)
	exports.CSGprogressbar:cancelProgressBar()
	outputDebugString("You are lagging")
end
