setTimer(function()
	for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
		if v and getElementDimension(v) == 8000 then
			local streamAllowed = getElementData(v, "setModelStream") or false
			if streamAllowed then
				local x,y,z = getElementPosition(localPlayer)
				local x2,y2,z2 = getElementPosition(v)
				if (getDistanceBetweenPoints2D(x,y,x2,y2) <= 300) then
					setElementDimension(v,0)
				end
			end
		end
	end
	for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
		if v and getElementDimension(v) == 0 then
			local streamAllowed = getElementData(v, "setModelStream") or false
			if streamAllowed then
				local x,y,z = getElementPosition(localPlayer)
				local x2,y2,z2 = getElementPosition(v)
				if (getDistanceBetweenPoints2D(x,y,x2,y2) > 300) then
					setElementDimension(v,8000)
				end
			end
		end
	end
end,10000,0)

function loadPeds(peds)
	for i, v in pairs(peds) do
   		local animBlock, animName = unpack(v)
    	if animBlock ~= "" and animName ~= "" then
   			setPedAnimation(i, animBlock, animName, -1, true, false, false)
   		end
   	end
end
addEvent("AURstaticpedveh.recieveCPed", true)
addEventHandler("AURstaticpedveh.recieveCPed", root, loadPeds)