local screenW, screenH = guiGetScreenSize()
local theAnimation = {}
local guiS = {}

guiS[1] = guiCreateGridList(0.35, 0.28, 0.12, 0.39, true)
guiGridListAddColumn(guiS[1], "Category", 0.8)
for k, v in ipairs(getElementsByType("animationCategory")) do
	local row = guiGridListAddRow(guiS[1])
	guiGridListSetItemText(guiS[1], row, 1, getElementID(v), false, false)
end

guiS[2] = guiCreateGridList(0.48, 0.28, 0.12, 0.39, true)
guiGridListAddColumn(guiS[2], "Animation", 0.8)

guiS[3] = guiCreateButton(0.35, 0.70, 0.26, 0.04, "", true)
guiSetAlpha(guiS[3], 0.00)


function dxAnimations()
	dxDrawRectangle(screenW * 0.3484, screenH * 0.1972, screenW * 0.2555, screenH * 0.5542, tocolor(0, 0, 0, 169), false)
	dxDrawRectangle(screenW * 0.3508, screenH * 0.1972, screenW * 0.2531, screenH * 0.0694, tocolor(0, 0, 0, 169), false)
	dxDrawText("AuroraRPG - Animations", screenW * 0.3469, screenH * 0.1972, screenW * 0.6039, screenH * 0.2667, tocolor(255, 255, 255, 255), 1.80, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3492, screenH * 0.6986, screenW * 0.2547, screenH * 0.0389, tocolor(0, 0, 0, 169), false)
	dxDrawText("Stop Animation", screenW * 0.3477, screenH * 0.6986, screenW * 0.6039, screenH * 0.7375, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

function toggleGUIs()
	local vis = (not guiGetVisible(guiS[1]))
	for i, v in ipairs(guiS) do
		guiSetVisible(v, vis)
	end
	return vis
end
toggleGUIs()

function toggleDX()
	local s = toggleGUIs()
	showCursor(s)
	if (s) then
		addEventHandler("onClientRender", root, dxAnimations)
	else
		removeEventHandler("onClientRender", root, dxAnimations)
	end
end

function toggleVisible()
	if (guiGetVisible(guiS[1]) == false) then
		if (isElementFrozen(localPlayer)) then
			return false 
		end
		if (getElementDimension(localPlayer) ~= 2000 and getElementDimension(localPlayer) ~= 1000) then
			if (not getElementData(localPlayer, "isPlayerInEvent")) then
				toggleDX()
			end
		end
	else
		toggleDX()
	end
end
bindKey("F7", "down", toggleVisible)

function animationsDo()
	selectedCategory = guiGridListGetItemText(guiS[1], guiGridListGetSelectedItem(guiS[1]), 1)
	if (selectedCategory ~= "") then
		guiGridListClear(guiS[2])
		for k, v in ipairs(getElementChildren(getElementByID(selectedCategory))) do
			local row = guiGridListAddRow(guiS[2])
			guiGridListSetItemText(guiS[2], row, 1, getElementID(v), false, false)
		end
	end
	if (selectedCategory == "") then
		guiGridListClear(guiS[2])
	end
end
addEventHandler("onClientGUIClick", guiS[1], animationsDo, false)

function setAnimations()
	selectedAnimation = guiGridListGetItemText(guiS[2], guiGridListGetSelectedItem(guiS[2]), 1)
	if (selectedAnimation ~= "") then
		if (getElementData(localPlayer, "tazed")) then 
			exports.NGCdxmsg:createNewDxMessage("You can not use animations now!", 255 ,0, 0) 
			return false 
		end
		if (getElementData(localPlayer, "isPlayerArrested")) then 
			exports.NGCdxmsg:createNewDxMessage("You can not use animations now!", 255, 0, 0) 
			return false 
		end
		if (isPedOnGround(localPlayer)) then
			if (not isPedDead(localPlayer)) then
				if (not isPedInVehicle(localPlayer)) then
					local animationBlock = getElementData(getElementByID(selectedAnimation), "block")
					local animationID = getElementData(getElementByID(selectedAnimation), "code")
					theAnimation = {animationBlock, animationID}
					triggerServerEvent("setAnimation", resourceRoot, animationBlock, animationID)
					startMove(false)
				else
					exports.NGCdxmsg:createNewDxMessage("You cannot use animations while in a vehicle.", 255, 0, 0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You cannot use animations while you are dead.", 255, 0, 0)
			end
		end
	end
end
addEventHandler("onClientGUIClick", guiS[2], setAnimations, false)

function onStopAnimation(button)
	if (button ~= "left") then
		return false 
	end
	if (getElementData(localPlayer, "isPlayerAnimated")) then
		setPedAnimation(localPlayer, nil)
		setElementData(localPlayer, "isPlayerAnimated", false)
		theAnimation = {}
		startMove(true)
		triggerServerEvent("setAnimationOFF", resourceRoot)
	end
end
addEventHandler("onClientGUIClick", guiS[3], onStopAnimation, false)

setTimer(
	function()
		if (getElementData(localPlayer, "isPlayerInEvent")) then
			if (getElementData(localPlayer, "isPlayerAnimated")) then
				setPedAnimation(localPlayer, nil)
				triggerServerEvent("setAnimationOFF", resourceRoot)
				startMove(true)
				setElementData(localPlayer, "isPlayerAnimated", false)
			end
			if (guiGetVisible(guiS[1])) then
				toggleDX()
			end
		end
		if (getElementDimension(localPlayer) == 2000 or getElementDimension(localPlayer) == 1000) then
			if (getElementData(localPlayer, "isPlayerAnimated")) then
				setPedAnimation(localPlayer, nil)
				triggerServerEvent("setAnimationOFF", resourceRoot)
				startMove(true)
				setElementData(localPlayer, "isPlayerAnimated", false)
			end
			if (guiGetVisible(guiS[1])) then
				toggleDX()
			end
		end
		if (getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) ~= "CS:GO" and getElementData(localPlayer, "isPlayerAnimated")) then
			if (not getPedAnimation(localPlayer)) then
				local animationBlock, animationID = unpack(theAnimation)
				if (animationBlock) then
					startMove(false)
					triggerServerEvent("setAnimation", resourceRoot, animationBlock, animationID)
					triggerServerEvent("setAnimationOFF", resourceRoot)
				end
			else
				if (getElementData(localPlayer, "isPlayerAnimated")) then
					startMove(false)
				end
			end
		end
		if (getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "CS:GO")  then
			if (getElementData(localPlayer, "isPlayerAnimated")) then
				setPedAnimation(localPlayer, nil)
				triggerServerEvent("setAnimationOFF", resourceRoot)
				setElementData(localPlayer, "isPlayerAnimated", false)
				startMove(true)
			end
			if (guiGetVisible(guiS[1])) then
				toggleDX()
			end
		end
	end
, 5000, 0)

function startMove(state)
	toggleControl("forwards", state)
	toggleControl("backwards", state)
	toggleControl("left", state)
	toggleControl("right", state)
	toggleControl("crouch", state)
	toggleControl("enter_exit", state)
	toggleControl("aim_weapon", state)
	toggleControl("fire", state)
end
