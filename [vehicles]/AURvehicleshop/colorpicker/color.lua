r1,g1,b1,r2,g2,b2 = 255,255,255,255,255,255
function openColorPicker()

	colorPicker.openSelect(colors)

end

function closeColorPicker()

	colorPicker.closeSelect()

end

function closedColorPicker()
	colorPicker.closeSelect()
	cpicker = false
	if vehicle and isElement(vehicle) then
		local r1, g1, b1, r2, g2, b2 = getVehicleColor(vehicle, true)
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		local r, g, b = getVehicleHeadLightColor(vehicle)
		setVehicleHeadLightColor(vehicle, r, g, b)
	end
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if r and g and b then
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1,g1,b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2,g2,b2 = r, g, b
		end
		if vehicle and isElement(vehicle) then
			setVehicleColor(vehicle,r1,g1,b1,r2,g2,b2)
			if (guiCheckBoxGetSelected(checkColor3)) then
				setVehicleOverrideLights(vehicle, 2)
				setVehicleHeadLightColor(vehicle, r, g, b)
			end
		end
	end
end
addEventHandler("onClientRender", root, updateColor)
