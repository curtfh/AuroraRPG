
function clientRenderMagnet ()

	local vehitem = getPedOccupiedVehicle ( getLocalPlayer() )
	if vehitem then
		local mv = getElementData ( vehitem, "magnet" )
		if mv and isElement(mv) then
			local x1, y1, z1 = getElementPosition ( mv )
			if tonumber(x1) and tonumber(y1) and tonumber(z1) then
				local x2, y2, z2 = getElementPosition ( vehitem )
				dxDrawLine3D ( x1, y1, z1, x2, y2, z2, tocolor (0, 0, 0, 255 ), 10 )
			end
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), clientRenderMagnet )
