--
-- Author: Ab-47; State: Complete.
-- Additional Notes; N/A; Rights: All Rights Reserved by Developers and Ab-47.
-- Project: AURraceduels/client.lua consisting of 2 file(s).
-- Directory: AURmstyles/client.lua
-- Side Notes: N/A
--

resourceRoot = getResourceRootElement(getThisResource())

function dxDrawCircle3D( x, y, z, radius, segments, color, width )
	segments = segments or 16;
	color = color or tocolor( 255, 255, 0 );
	width = width or 1;
	local segAngle = 360 / segments;
	local fX, fY, tX, tY;

	for i = 1, segments do
		fX = x + math.cos( math.rad( segAngle * i ) ) * (radius/1.8);
		fY = y + math.sin( math.rad( segAngle * i ) ) * (radius/1.8);
		tX = x + math.cos( math.rad( segAngle * (i+1) ) ) * (radius/1.8);
		tY = y + math.sin( math.rad( segAngle * (i+1) ) ) * (radius/1.8);
		--Bottom
		fX2 = x + math.cos( math.rad( segAngle * i ) ) * (radius/2);
		fY2 = y + math.sin( math.rad( segAngle * i ) ) * (radius/2);
		tX2 = x + math.cos( math.rad( segAngle * (i+10) ) ) * (radius/2);
		tY2 = y + math.sin( math.rad( segAngle * (i+10) ) ) * (radius/2);
		dxDrawLine3D( fX, fY, z, tX, tY, z, color, width/2 );
		dxDrawLine3D( fX, fY, z, tX2, tY2, z - 1, color, width );
		dxDrawLine3D( fX2, fY2, z - 1, tX2, tY2, z - 1, color, width );
	end
end

 local t1 = getTickCount()
 local got = {}
local markers = {}
setTimer(function()
	markers = {}
	local ma = getElementsByType("marker")
	for i, v in pairs(ma) do
		if (v and isElement(v)) then
			if (getElementDimension(localPlayer) == getElementDimension(v)) then
				if getMarkerType(v) == "cylinder" then
					table.insert(markers,v)
				end
			end
		end
	end
end,5000,0)

addEventHandler("onClientPreRender", root,
--setTimer(
    function()
	for i, v in pairs(markers) do
		if (v and isElement(v)) then
			if (getElementDimension(localPlayer) == getElementDimension(v)) then
				if getMarkerType(v) == "cylinder" then
					local plrx, plry, plrz = getElementPosition (localPlayer)
					local markerx, markery, markerz = getElementPosition(v)
					if (getDistanceBetweenPoints3D(plrx, plry, plrz, markerx, markery, markerz) < 50) then
						if not got[v] or got[v] == false or got[v] == nil then
							theRed,Green,Blue,alpha = getMarkerColor(v)
							got[v] = alpha
							if got[v] >= 100 then
								got[v] = 100
							else
								got[v] = 0
							end
						end
						local x,y,z = getElementPosition(v)
						z = z - 0.5
						local r,g,b,a = getMarkerColor(v)
						local size = getMarkerSize(v)
						setMarkerColor(v, r, g, b, 0)
						local t = getTickCount()
						if (t - t1) > 3000 then
							t1 = getTickCount()
						elseif (t - t1) > 5000 then
							x, y, z = interpolateBetween(x, y, z + 1 ,x, y, z,(t - 3000 - t1)/2000, "SineCurve")
						elseif (t - t1) < 3000 then
							x, y, z = interpolateBetween(x, y, z, x, y, z + 1, (t - t1)/3000, "SineCurve")
						end
						dxDrawCircle3D(x, y, z + 1.5, size, 70, tocolor(r, g, b, got[v]), 3)
					end
				end
			end
		end
	end
end)

function handle_reverse()
	local markers = getElementsByType("marker")
	for i, v in ipairs(markers) do
		if (v) then
			local r,g,b,a = getMarkerColor(v)
			setMarkerColor(v, r, g, b, 155)
		end
	end
end
addEventHandler("onClientResourceStop", resourceRoot, handle_reverse)
