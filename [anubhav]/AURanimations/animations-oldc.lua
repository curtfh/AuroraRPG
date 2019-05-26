local resX, resY = guiGetScreenSize()
local theAnimation = {}

function makeAnimationGUI()
	animationWindow = guiCreateWindow(resX/2-150,resY/2-200,300,400,"AUR ~ Animations",false)
	guiSetVisible(animationWindow,false)
	animationCategoryList = guiCreateGridList(0.01,0.1,0.45,0.7,true,animationWindow)
	animationList = guiCreateGridList(0.48,0.1,0.45,0.7,true,animationWindow)
	column1 = guiGridListAddColumn(animationCategoryList,"Category",0.8)
	column2 = guiGridListAddColumn(animationList,"Animation",0.8)
	stopButton = guiCreateButton(0.01,0.8,0.9,0.3,"Stop Animation",true,animationWindow)
	addEventHandler("onClientGUIClick", stopButton,
		function()
			if getElementData(localPlayer,"isPlayerAnimated") then
				setPedAnimation(localPlayer,nil)
				setElementData(getLocalPlayer(),"isPlayerAnimated",false)
				theAnimation = {}
				startMove(true)
				triggerServerEvent("setAnimationOFF",getLocalPlayer())
			end
		end
	)
	for k, v in ipairs (getElementsByType("animationCategory")) do
		local row = guiGridListAddRow(animationCategoryList)
		guiGridListSetItemText(animationCategoryList,row,column1,getElementID(v),false,false)
	end
	addEventHandler("onClientGUIClick",animationCategoryList,getAnimations)
	addEventHandler("onClientGUIClick",animationList,setAnimation)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),makeAnimationGUI)

function toggleVisible()
	if (guiGetVisible(animationWindow) == false) then
		if (isElementFrozen(localPlayer)) then
			return false 
		end
		if getElementDimension(localPlayer) ~= 2000 and getElementDimension(localPlayer) ~= 1000 then
			if getElementDimension(localPlayer) ~= 336 then
				guiSetVisible(animationWindow,true)
				showCursor(true)
			end
		end
	else
		guiSetVisible(animationWindow,false)
		showCursor(false)
	end
end
bindKey("F5","down",toggleVisible)

function getAnimations()
	selectedCategory = guiGridListGetItemText(animationCategoryList,guiGridListGetSelectedItem(animationCategoryList),1)
	if (selectedCategory ~= "") then
		guiGridListClear(animationList)
		for k, v in ipairs (getElementChildren(getElementByID(selectedCategory))) do
			local row = guiGridListAddRow(animationList)
			guiGridListSetItemText(animationList,row,column1,getElementID(v),false,false)
		end
	end
	if (selectedCategory == "") then
		guiGridListClear(animationList)
	end
end

function setAnimation()
	selectedAnimation = guiGridListGetItemText(animationList,guiGridListGetSelectedItem(animationList),1)
		if (selectedAnimation ~= "") then
			if getElementData(localPlayer,"tazed") then exports.NGCdxmsg:createNewDxMessage("You can not use animations now!",255,0,0) return end
			if getElementData(localPlayer,"isPlayerArrested") then exports.NGCdxmsg:createNewDxMessage("You can not use animations now!",255,0,0) return end
			if isPedOnGround ( localPlayer ) then
			if (not isPlayerDead(getLocalPlayer())) then
				if (isPedInVehicle(getLocalPlayer()) == false) then
					local animationBlock = getElementData(getElementByID(selectedAnimation),"block")
					local animationID = getElementData(getElementByID(selectedAnimation),"code")
					theAnimation = {animationBlock,animationID}
					triggerServerEvent("setAnimation",getLocalPlayer(),animationBlock,animationID)
					startMove(false)
				else
					exports.NGCdxmsg:createNewDxMessage("You cannot use animations while in a vehicle.",255,0,0)
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You cannot use animations while you are dead.",255,0,0)
				end
			end
		end
end

setTimer(function()
	if getElementData(localPlayer,"isPlayerInEvent") then
		if getElementData(localPlayer,"isPlayerAnimated") then
			setPedAnimation(localPlayer,nil)
			triggerServerEvent("setAnimationOFF",getLocalPlayer())
			startMove(true)
			setElementData(getLocalPlayer(),"isPlayerAnimated",false)
		end
		if guiGetVisible(animationWindow) then
			guiSetVisible(animationWindow,false)
			showCursor(false)
		end
	end
	if getElementDimension(localPlayer) == 2000 or getElementDimension(localPlayer) == 1000 then
		if getElementData(localPlayer,"isPlayerAnimated") then
			setPedAnimation(localPlayer,nil)
			triggerServerEvent("setAnimationOFF",getLocalPlayer())
			startMove(true)
			setElementData(getLocalPlayer(),"isPlayerAnimated",false)
		end
		if guiGetVisible(animationWindow) then
			guiSetVisible(animationWindow,false)
			showCursor(false)
		end
	end
	if getPlayerTeam(localPlayer) and ( getTeamName( getPlayerTeam( localPlayer ) ) ~= "CS:GO")  and getElementData(localPlayer,"isPlayerAnimated") then
		if not getPedAnimation(localPlayer) then
			local animationBlock,animationID = unpack(theAnimation)
			if animationBlock then
				startMove(false)
				triggerServerEvent("setAnimation",getLocalPlayer(),animationBlock,animationID)
				triggerServerEvent("setAnimationOFF",getLocalPlayer())
			end
		else
			if getElementData(localPlayer,"isPlayerAnimated") then
				startMove(false)
			end
		end
	end
	if getPlayerTeam(localPlayer) and ( getTeamName( getPlayerTeam( localPlayer ) ) == "CS:GO")  then
		if getElementData(localPlayer,"isPlayerAnimated") then
			setPedAnimation(localPlayer,nil)
			triggerServerEvent("setAnimationOFF",getLocalPlayer())
			setElementData(getLocalPlayer(),"isPlayerAnimated",false)
			startMove(true)
		end
		if guiGetVisible(animationWindow) then
			guiSetVisible(animationWindow,false)
			showCursor(false)
		end
	end
end,5000,0)

function startMove(state)
	toggleControl("forwards",state)
	toggleControl("backwards",state)
	toggleControl("left",state)
	toggleControl("right",state)
	toggleControl("crouch",state)
	toggleControl("enter_exit",state)
	toggleControl("aim_weapon",state)
	toggleControl("fire",state)
end
