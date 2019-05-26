addEvent("fixyy", true)
addEventHandler("fixyy", resourceRoot,
    function (barrierObject)
        setObjectBreakable(barrierObject, false)
    end
)


function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		return false
	end
end

addEvent("onClientVehiclePostDamage", true)
addEventHandler("onClientVehiclePostDamage",root,function(attacker)
	if attacker and isElement(attacker) and getElementType(attacker) == "object" then
		if getElementData(attacker,"isBarrier") then
			sx, sy, sz = getElementVelocity (source)
			speed = math.floor(((sx^2 + sy^2 + sz^2)^(0.5))*180)
			outputDebugString(speed)
			if speed >= 10 then
				outputDebugString("speed 20")
				local own = getElementData(attacker,"barrierOwner")
				if own and isElement(own) then
					outputDebugString("owner")
					local id = getElementData(attacker,"barrierID")
					if id then
						outputDebugString("ID")
						triggerServerEvent("removeBarrierSpeed",own,id)
					end
				end
			end
		end
	end
end)
