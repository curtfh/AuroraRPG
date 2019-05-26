function refundAmmo (id)
	giveWeapon(source, id, 1)
end 
addEvent("AURnadespam.refund", true)
addEventHandler("AURnadespam.refund", root, refundAmmo)

function checkChange(theKey, oldValue)
	if (theKey== "toDeleteProj") then
		destroyElement(source)
        outputDebugString("Deleted Proje")
    end
end
addEventHandler("onElementDataChange", root, checkChange)