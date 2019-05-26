function loadthings()
	local txd = engineLoadTXD ( "speeds.txd" )
	engineImportTXD ( txd, 1444 )
end




local dxlabel = {
{1692.41, -683.77, 45.4,"120 KM/H"},
{1723.19, -876.78, 57.81 ,"120 KM/H"},
{1671.93, -65.04, 35.92 ,"150 KM/H"},
{1595.1, 92.6, 37.79 ,"180 KM/H"},
{1732.59, 1632.17, 9.16 ,"90 KM/H"},
{457.93, 754.08, 4.91 ,"150 KM/H"},
{-1077.13, 1196.5, 39.24 ,"130 KM/H"},
{-1147.39, 1092.01, 39.43 ,"130 KM/H"},
{-1563.4, 482.86, 7.17 ,"100 KM/H"},
{-1567.67, 669.15, 7.18 ,"100 KM/H"},
{-1809.58, -638.06, 17.04 ,"140 KM/H"},
{-1740.8, -570.2, 16.48 ,"140 KM/H"},
{-1753.77, -618.43, 17.09 ,"140 KM/H"},
{-1830.96, -490.22, 15.1  ,"140 KM/H"},
{423.67, -1695.27, 9.87  ,"150 KM/H"},
{276.94, -1710.2, 7.71  ,"150 KM/H"},
{1264.11, -1410.87, 13.18  ,"180 KM/H"},
{1353.88, -1477.61, 13.54,"180 KM/H"},
{1337.1, -1289.83, 13.54,"180 KM/H"},
{1419.44, -1390.44, 13.39,"180 KM/H"},
{572.66, -1163.98, 25.9,"180 KM/H"},
{645.68, -1286.77, 15.9,"180 KM/H"},
{563.13, -1247.77, 17.28,"180 KM/H"},
{672.12, -1162.56, 15.34,"180 KM/H"},

}
r,g,b = 255,0,0


setTimer(function()
	if r == 255 then
		r,g,b = 0,100,200
	else
		r,g,b = 255,0,0
	end
end,500,0)

function showTextOnTopOfPed()
    local x, y, z = getElementPosition(localPlayer)
	for k,v in ipairs(dxlabel) do
		local mX, mY, mZ = v[1], v[2], v[3]
		local jobb = v[4]

		local sx, sy = getScreenFromWorldPosition(mX, mY, mZ+4)
		if (sx) and (sy) then
			local distance = getDistanceBetweenPoints3D(x, y, z, mX, mY, mZ)
			if (distance < 80) then
				if isPedInVehicle(localPlayer) then

					dxDrawText("Reduce Speed (Max KM/H) : "..jobb, sx+2, sy+2, sx, sy, tocolor(r,g,b, 255), 2-(distance/60), "default-bold", "center", "center")
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,showTextOnTopOfPed)



setTimer(function()
	for k,v in ipairs(getElementsByType("object")) do
		if getElementData(v,"speedCam") == true then
			setObjectBreakable(v, false)
		end
	end
end,10000,0)

loadthings()
