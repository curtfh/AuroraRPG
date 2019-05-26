local cams = { --- x,y,z,w,h,Speed,tax
{ 1640, -810.33, 54,30,10,180,2000},
{ 1732.61, -815.72, 54,30,10,180,2000},
{ 1613.9, 45.92, 37.14,15,10,180,2500},
{ 1712.84, 1606.7, 10.01,10,10,90,2000},
{ 418, 768.99, 5,10,10,150,3500},
{ -1101.74, 1145.83, 37,30,10,130,900},
{ -1559.57, 566.28, 7,30,10,100,500},
{ -1818.51, -577.87, 16,30,10,140,1500},
{ 369.93, -1709.43, 7,20,10,150,1000},
{ 1349.93, -1398.43, 13,30,10,120,2000},
{ 629.55, -1215.09, 18,30,10,180,4000},

}

local tubes = {}
local recentCaughtbyRadar = {}


function getVehicleSpeed( theVehicle, unit )
	if ( unit == nil ) then unit = 0 end
	if ( isElement( theVehicle ) ) then
		local x,y,z = getElementVelocity( theVehicle )
		if ( unit=="mph" or unit==1 or unit =='1' ) then
			return ( x^2 + y^2 + z^2 ) ^ 0.5 * 100
		else
			return ( x^2 + y^2 + z^2 ) ^ 0.5 * 1.61 * 100
		end
	else
		return false
	end
end


function math.round( number, decimals, method )
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if ( method == "ceil" or method == "floor" ) then return math[method] ( number * factor ) / factor
    else return tonumber( ( "%."..decimals.."f" ):format( number ) ) end
end

function hitSpeedCam(hitElement,matchingDim)
	if not matchingDim then return false end
	if hitElement and getElementType(hitElement) == "vehicle" then
		if getVehicleType(hitElement) == "Automobile" or getVehicleType(hitElement) == "Bike" or getVehicleType(hitElement) == "Monster Truck" or getVehicleType(hitElement) == "Quad" then
			local driver = getVehicleOccupant(hitElement)
			if driver and getVehicleController(hitElement) == driver and getElementType(driver) == "player" then
				if ( recentCaughtbyRadar[driver] ) and ( getTickCount()-recentCaughtbyRadar[driver] < 30000 ) then
					return
				else
					if getPlayerTeam( driver ) then
						local team = getTeamName ( getPlayerTeam( driver ) )
						if exports.DENlaw:isLaw(driver) or team == "Staff" or getElementData(driver,"Occupation") ~= "Firefighter" and team ~= "Civilian Workers" or team ~= "Paramedics" then
							return
						else
							--speedx, speedy, speedz = getElementVelocity ( hitElement )
							--actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
							--kmh = math.ceil(actualspeed * 180)
							kmh = math.round( getVehicleSpeed( hitElement ), 0 )
							local ticketTax = getElementData(source, "tax")
							if getElementData(source, "Allowedspeed") < kmh then
								outputDebugString(kmh)
								local moneydriver = getPlayerMoney(driver)
								playSoundFrontEnd ( driver, 101 )
								if getPlayerMoney(driver) > ticketTax and getPlayerMoney(driver) > 0 then
									takePlayerMoney(driver, ticketTax)
									exports.NGCdxmsg:createNewDxMessage(driver,"You have been ticketed for speeding ("..kmh.."km/h). You paid $"..tostring(ticketTax)..".", 255, 255, 0)
									--fadeCamera ( driver, false, 0.2, 255, 255, 255)
									--setTimer ( fadeCamera, 500, 1, driver, true, 2 )
								else
									exports.server:givePlayerWantedPoints(driver,20)
									local wantedStars = getElementData(driver,"wantedPoints")
									exports.NGCdxmsg:createNewDxMessage(driver,"You have been ticketed for speeding ("..kmh.."km/h) and got "..wantedStars.." wanted points.",255, 0, 0)
									--fadeCamera ( driver, false, 0.2, 255, 255, 255)
									--setTimer ( fadeCamera, 500, 1, driver, true, 2 )
								end
							end
						end
					end
				end
			end
		end
	end
end

for k,v in ipairs(cams) do
	local x,y,z,w,h,s,t = v[1],v[2],v[3],v[4],v[5],v[6],v[7]
	tubes = createColSphere(x,y,z,w)
	setElementData(tubes,"Allowedspeed",s)
	setElementData(tubes,"tax",t)
	addEventHandler("onColShapeHit",tubes,hitSpeedCam)
end

local radars = {
{1691.99, -685.61, 47,350},
{1723.04, -875.47, 59.5,183},
{1336.83, -1290.66, 15,0},
{1265.15, -1411.23, 14.5,90},
{1419.15, -1390.03, 14.8,211},
{1354.78, -1475.82, 14.8,130},
{671.63, -1163.03, 16.8,324},
{564.51, -1247.53, 18.8,105},
{ 572.75, -1164.68, 27.2,4},
{ 645.81, -1285.78, 17.5,168},
{422.42, -1694.72, 11.2,265},
{ 278.48, -1711.09, 9.2,46}, --- the end of LS
{-1741.97, -569.85, 18,268},
{ -1753.88, -616.55, 18.5,179},
{ -1809.31, -637.63, 18.5,174},
{ -1831.02, -491.38, 16.5,0},
{ -1903.68, -589.82, 25.9,82},
{-1562, 483.62, 8.8,127},
{ -1568.07, 668.15, 8.8,345},
{ -1146.97, 1092.71, 40.8,316},
{ -1077.09, 1195.35, 40.5,10},
{456.6, 755.25, 6.2,246},
{ 1731.54, 1631.64, 10.5,296},
{1594.76, 91.07, 39.5,353},
{ 1672.09, -64.34, 37.5,180},
}
local obs = {}


for k,v in ipairs(radars) do
	obs = createObject(1444,v[1],v[2],v[3])
	setElementRotation(obs,0,0,v[4])
	setObjectScale(obs,3.5)
	--triggerClientEvent(obs,"prevent_break",obs)
	setElementData(obs,"speedCam",true)
end
