function out(player)
    setElementPosition (source, 1575.95, -1329.55, 16.48)
	setElementDimension (source, 0)
end
addEvent ("warpOut", true)
addEventHandler ("warpOut", getRootElement(), out)

function enter(player)
    setElementPosition (source, 1547.06, -1366.3, 326.21)
	setElementDimension (source, 0)
end
addEvent ("warpIn", true)
addEventHandler ("warpIn", getRootElement(), enter)

function buy()
	if getPlayerMoney(source) >= 8000 then
		giveWeapon (source, 46,0)
		exports.NGCdxmsg:createNewDxMessage("You have bought a parachute", source, 0, 255, 0)
		exports.AURpayments:takeMoney(source,8000,"AUR Parachute")
	end
end
addEvent ("buyPara", true)
addEventHandler ("buyPara", getRootElement(), buy)

function armor()
	if getPlayerMoney(source) >= 15000 then
		setPedArmor(source, 100)
		exports.NGCdxmsg:createNewDxMessage("You have bought an armor", source, 0, 255, 0)
		exports.AURpayments:takeMoney(source,15000,"AUR Armor")
	end
end
addEvent ("buyArm", true)
addEventHandler ("buyArm", getRootElement(), armor)