function setAnimation(animationBlock, animationID)
	setPedAnimation(client, animationBlock, animationID, -1, true, false)
	setElementData(client, "isPlayerAnimated", true)
end
addEvent("setAnimation", true)
addEventHandler("setAnimation", resourceRoot, setAnimation)

function setAnimationOFF(animationBlock, animationID)
	setPedAnimation(client, false)
	setElementData(client, "isPlayerAnimated", true)
end
addEvent("setAnimationOFF", true)
addEventHandler("setAnimationOFF", resourceRoot, setAnimationOFF)
