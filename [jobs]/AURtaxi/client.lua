local screenWidth, screenHeight = guiGetScreenSize()

serviceLightOn=false
serviceStatus="Off"
function createText()
	if serviceLightOn==true then
          exports.CSGpriyenmisc:dxDrawColorText( "#eeeeeeTaxi Service:#e50005 "..serviceStatus.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "default-bold" )
          exports.CSGpriyenmisc:dxDrawColorText( "#eeeeeeTaxi Service:#e50005 "..serviceStatus.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "default-bold" )

	end
end

function drawText()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (vehicle) then
		if getElementModel(vehicle) == 420 or getElementModel(vehicle) == 438 then
			if getElementData(localPlayer,"Occupation") == "Taxi Driver" then
				screenWidth,screenHeight = guiGetScreenSize()
				exports.CSGpriyenmisc:dxDrawColorText ( "#eeeeeeTaxi Service:#e50005 "..serviceStatus.."", screenWidth*0.08, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
			end
		end
	end
end
addEventHandler("onClientRender",root,drawText)

local sx, sy = guiGetScreenSize()
local rx, ry = 1920, 1080
if sx == 800 then
text = 2.00
text2 = 4
elseif sx == 1024 then
text = 1.9
text2 = 3
elseif sx >= 1280 then
text = 1
text2 = 2
end

function monitorDENjob()
if sx == 800 then
text = 2.00
text2 = 4
elseif sx == 1024 then
text = 1.9
text2 = 3
elseif sx >= 1280 then
text = 1
text2 = 2
end
end
addEventHandler("onClientRender", root, monitorDENjob)


function togLight(state)
	serviceLightOn=state
	if state==true then
		serviceStatus="On"
		exports.NGCdxmsg:createNewDxMessage("Service Status "..serviceStatus..".",0,255,0)
	else
		serviceStatus="Off"
		exports.NGCdxmsg:createNewDxMessage("Service Status "..serviceStatus..".",255,0,0)
	end
end
addEvent("NGCtaxi.togLight",true)
addEventHandler("NGCtaxi.togLight",localPlayer,togLight)

addEventHandler("onClientVehicleEnter",root,function(p)
	if p ~= localPlayer then return end
	local v = source
	if getElementModel(v) == 420 or getElementModel(v) == 438 then
		if getVehicleController(v) == localPlayer then
			if serviceLightOn==true then
			--	addEventHandler("onClientRender",root,createText)
			end
		end
	end
end)

addEventHandler("onClientVehicleExit",root,function(p)
	if p ~= localPlayer then return end
	serviceLightOn=false
---	removeEventHandler("onClientRender",root,createText)
end)



 function onElementDataChange( dataName, oldValue )
        if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Taxi Driver" then
                initTaxiOccupation()
        elseif dataName == "Occupation" then
                stopTaxiOccupation()
        end
end

addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false )

function onTaxiTeamChange ( oldTeam, newTeam )
       if getElementData ( localPlayer, "Occupation" ) == "Taxi Driver" and source == localPlayer then
               setTimer ( function ()
               if getPlayerTeam( localPlayer ) then
                          local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
                              if newTeam == "Unoccupied" then
                                      stopTaxiOccupation()
                             elseif getElementData ( localPlayer, "Occupation" ) == "Taxi Driver" and newTeam == "Civilian Workers" then
                                      initTaxiOccupation()
                               end
                     end
            end, 200, 1 )
       end
end
addEventHandler( "onClientPlayerTeamChange", localPlayer, onTaxiTeamChange, false )

function onResourceStart()
       setTimer ( function ()
                     if getPlayerTeam( localPlayer ) then
                               local team = getTeamName ( getPlayerTeam( localPlayer ) )
                            if getElementData ( localPlayer, "Occupation" ) == "Taxi Driver" and team == "Civilian Workers" then
                                 initTaxiOccupation()
                       end
                    end
               end
        , 2500, 1 )
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart )

addEvent( "onClientPlayerTeamChange" )
function initTaxiOccupation()
        if not isTaxi then
			loadjob()
			setElementData(localPlayer,"taxi3",0)
			exports.NGCdxmsg:createNewDxMessage("Bots are marked as Red waypoint blip on the radar",255,255,0)
			isTaxi = true
			guiSetVisible(TaxiJobC.window[1],true)
        end
end

function stopTaxiOccupation ()
       if isTaxi then
			disableJob()
			guiSetVisible(TaxiJobC.window[1],false)
			triggerServerEvent("cleanPedsFromServer",localPlayer)
			exports.CSGranks:closePanel()
			if isTimer(deliverTimer) then killTimer(deliverTimer) end

			end
                isTaxi = false
       end



addEventHandler("onClientPedDamage", root, function()
if getElementData(source,"StopTaxiKill") == true then
cancelEvent()
end
end )
------------------------------------------
----------- JOB


local screenWidth, screenHeight = guiGetScreenSize()

TaxiJobC = {
    label = {},
    window = {}
}
TaxiJobC.window[1] = guiCreateWindow((screenWidth+450)/2, (screenHeight-250)/2, 167, 183, "Taxi Counter", false)
guiWindowSetSizable(TaxiJobC.window[1], false)
guiSetVisible(TaxiJobC.window[1],false)
TaxiJobC.label[1] = guiCreateLabel(17, 22, 138, 31, "Total cash : $ 0", false, TaxiJobC.window[1])
guiSetFont(TaxiJobC.label[1], "default-bold-small")
guiLabelSetVerticalAlign(TaxiJobC.label[1], "center")
TaxiJobC.label[2] = guiCreateLabel(17, 63, 138, 31, "Latest payment : $ 0", false, TaxiJobC.window[1])
guiSetFont(TaxiJobC.label[2], "default-bold-small")
guiLabelSetVerticalAlign(TaxiJobC.label[2], "center")
TaxiJobC.label[3] = guiCreateLabel(17, 102, 138, 31, "Bot Missions : $ 0", false, TaxiJobC.window[1])
guiSetFont(TaxiJobC.label[3], "default-bold-small")
guiLabelSetVerticalAlign(TaxiJobC.label[3], "center")
TaxiJobC.label[4] = guiCreateLabel(17, 143, 138, 31, "Mission Timer :", false, TaxiJobC.window[1])
guiSetFont(TaxiJobC.label[4], "default-bold-small")
guiLabelSetVerticalAlign(TaxiJobC.label[4], "center")





local taxis = { [420]=true, [438]=true }
id = 0
addCommandHandler("printjob",function()
	id = id + 1
	local x, y, z = getElementPosition( localPlayer )
	local r = getPedRotation ( localPlayer )
	outputChatBox("["..id.."] = {"..( math.floor( x * 100 ) / 100 ) .. ", " .. ( math.floor( y * 100 ) / 100 ) .. ", " .. ( math.floor( z * 100 ) / 100 )..","..r.."},",255,255,0)
end)
addCommandHandler("newjob",function()
	id = 0
	outputChatBox("ID = 0",255,255,0)
end)

local pos = {

	[1] = {-1534.01, 975.73, 7.19,113.00604248047},
	[2] = {-1672.14, 1298.75, 7.18,129.22711181641},
	[3] = {-1969.4, 1322.6, 7.25,173.72088623047},
	[4] = {-2618.17, 1356.44, 7.11,269.52923583984},
	[5] = {-2834.61, 949.49, 44.09,280.25518798828},
	[6] = {-2859.81, 471.07, 4.35,266.15509033203},
	[7] = {-2803.08, -105.95, 7.18,85.455810546875},
	[8] = {-2798.43, -470.38, 7.18,143.56796264648},
	[9] = {-2598.93, -146.65, 4.33,93.216735839844},
	[10] = {-2508.23, -117.05, 25.61,274.54254150391},
	[11] = {-2395.35, -63.72, 35.32,174.8291015625},
	[12] = {-2018.58, -76.1, 35.32,0},
	[13] = {-1995.83, 137.98, 27.68,269.76998901367},
	[14] = {-1995, 491.37, 35.16,84.756744384766},
	[15] = {-1991.68, 722.39, 45.44,359.52926635742},
	[16] = {-1995.67, 881.06, 45.44,90.396789550781},
	[17] = {-1874.95, 1087.61, 45.44,85.455810546875},
	[18] = {-2164.43, 1167.4, 55.72,1.2641296386719},
	[19] = {-1757.2, -107.78, 3.71,173.02154541016},
	[20] = {-1804.82, -134.56, 6.07,269.6741027832},
	[21] = {-2244.19, 215.89, 35.32,89.674072265625},
	[22] = {-2308.58, 407.65, 35.17,313.99945068359},
	[23] = {-2371.81, 556.56, 24.89,0.37322998046875},
	[24] = {-2208.92, 574.55, 35.17,177.31231689453},
	[25] = {-2133.16, 655.61, 52.36,89.505676269531},
	[26] = {-2116.7, 737.04, 69.56,182.01234436035},
	[27] = {-2082.88, 814.47, 69.56,177.69818115234},
	[28] = {-2520.35, 822.34, 49.97,87.457336425781},
	[29] = {-2585.54, 802.1, 49.98,357.77059936523},
	[30] = {-2734.43, 574.95, 14.55,178.63818359375},

}

local drops = {

	[1] = {-2705.32, 405.87, 4.36,0},
	[2] = {-2612.63, 209.9, 5.39,5.3632202148438},
	[3] = {-2536.6, 141.25, 16.26,207.38562011719},
	[4] = {-2453.61, 137.94, 34.96,312.86773681641},
	[5] = {-2151.66, 188.6, 35.32,270.80828857422},
	[6] = {-1992.46, 291.52, 34.14,161.62219238281},
	[7] = {-1815.04, 161.22, 14.97,272.35162353516},
	[8] = {-1569.61, 667.7, 7.18,268.10977172852},
	[9] = {-1523.39, 838.09, 7.18,81.216461181641},
	[10] = {-1859.07, 1380.58, 7.18,183.12316894531},
	[11] = {-2373.03, 1215.29, 35.27,274.06314086914},
	[12] = {-2492.61, 1206.05, 37.42,205.99671936035},
	[13] = {-2585.23, 1360.75, 7.19,223.06184387207},
	[14] = {-2866.89, 734.93, 30.07,276.08825683594},
	[15] = {-2754.53, 376.32, 4.13,268.32730102539},
	[16] = {-2711.78, 212.48, 4.32,268.95397949219},
	[17] = {-2203.49, 312.45, 35.32,2.5691528320313},
	[18] = {-2026.46, 166.64, 28.83,262.37396240234},
	[19] = {-2128.48, -376.55, 35.33,2.1598815917969},
	[20] = {-1551.48, -443.31, 6,313.90609741211},
	[21] = {-1757.74, 138.58, 3.58,79.266357421875},
	[22] = {-1698.18, 373.01, 7.17,210.07250976563},
	[23] = {-1890.48, 747.39, 45.44,83.966461181641},
	[24] = {-2015.82, 1086.6, 55.71,173.72546386719},
	[25] = {-1780.79, 1199.68, 25.12,173.96630859375},
	[26] = {-2647.17, 1192.26, 55.57,126.87002563477},
	[27] = {-2491.02, 743.59, 35.01,177.05285644531},
	[28] = {-2423.03, 316.04, 34.96,239.4557800293},
	[29] = {-2019.5, -93.83, 35.16,353.10098266602},
	[30] = {-1977.95, -857.11, 32.03,87.415252685547},
}
local peds = {}
local hitMarkers = {}
local TaxiBlips = {}
local TaxiBlips2 = {}
local t={}

function loadjob()
	num = math.random(1,25)
	for i=1,#pos do
		x, y, z, r = pos[i][1], pos[i][2], pos[i][3], pos[i][4]
		local ped = createPed(math.random(20,90),x,y,z+1,r)
		local money = math.random(500,1200)
		if ped then
			local x,y,z = getElementPosition(ped)
			local theMarker = createMarker ( x, y, z -2, "cylinder", 3.0, 200, 100, 0, 150 )
			addEventHandler("onClientMarkerHit",theMarker,hitTaxiPed)
			table.insert ( hitMarkers, theMarker )
			setElementData(ped,"StopTaxiKill",true)
			setElementData(ped,"taximoney",money)
			setElementData(theMarker,"taximoney",money)
			attachElements(ped,theMarker)
			local Tax = createBlip(x,y,20,41, 2000)
			setBlipVisibleDistance(Tax, 2000)
			table.insert ( TaxiBlips, Tax )
			table.insert ( peds, ped )
		end
	end
end
function disableJob()
	for k,v in ipairs(hitMarkers) do
	if isElement(v) then destroyElement(v) end
	end
	for k,v in ipairs(peds) do
	if isElement(v) then destroyElement(v) end
	end

	for k,v in ipairs(TaxiBlips) do
		if isElement(v) then destroyElement(v) end
	end

	for k,v in ipairs(TaxiBlips2) do
		if isElement(v) then destroyElement(v) end
	end

end
addEventHandler("onClientPlayerQuit",localPlayer,disableJob)

function hitTaxiPed(hitElement)
	if hitElement ~= localPlayer then return false end
	if isPedInVehicle(hitElement) and getVehicleController(getPedOccupiedVehicle(hitElement)) == localPlayer then
	if taxis[getElementModel ( getPedOccupiedVehicle(hitElement) )] then
	local occc = getElementData(localPlayer,"Occupation")
    if ( occc == "Taxi Driver") and ( getTeamName( getPlayerTeam( localPlayer) ) == "Civilian Workers") then
		local attachedElements = getAttachedElements (source)
		for k,v in ipairs(attachedElements) do
			if getElementType(v) == "ped" then
				detachElements(v,source)
				skin,x,y,z = getElementModel(v),getElementPosition(v)
				triggerServerEvent("warpPed",hitElement,skin,x,y,z)
				fadeCamera(false)
				setTimer(fadeCamera,3000,1,true)
				if isElement(v) then destroyElement(v) end
				local money = getElementData(source,"taximoney")
				disableJob()
				area = math.random ( 1, #drops )
				local x,y,z = getElementPosition(hitElement)
				local OccupationDistance = getDistanceBetweenPoints3D ( drops[area][1],drops[area][2],drops[area][3], pos[area][1],pos[area][2],pos[area][3] )
				if OccupationDistance >= 2000 then timer = 160000
				elseif OccupationDistance >= 1000 and OccupationDistance < 2000 then timer = 140000
				elseif OccupationDistance < 1000 and OccupationDistance >= 500 then timer = 100000
				elseif OccupationDistance < 500 then timer = 70000
				end
				deliverTimer = setTimer(function() clearTaxi() end,timer,1)
				local theMarker = createMarker ( drops[area][1],drops[area][2],drops[area][3] -1, "cylinder", 3.0, 200, 100, 0, 150 )
				local tax2 = createBlip(drops[area][1],drops[area][2],20,41, 5000)
				setBlipVisibleDistance(tax2, 5000)
				exports.NGCdxmsg:createNewDxMessage("Drop this passenger in "..getZoneName(drops[area][1],drops[area][2],drops[area][3]).." Street , Red waypoint blip.",0,255,0)
				table.insert(hitMarkers,theMarker)
				table.insert(TaxiBlips2,tax2)
				addEventHandler("onClientMarkerHit",theMarker,hitLastPed)
				setElementData(theMarker,"taximoneyhd",money)
				setElementData(theMarker,"taxitimer",timer)
			end
			end
		end
	end
	end
end

function clearTaxi()
	disableJob()
	triggerServerEvent("cleanPedsFromServer",localPlayer)
	loadjob()
end

function hitLastPed(hitElement)
	if hitElement ~= localPlayer then return false end
	if isPedInVehicle(hitElement) and getVehicleController(getPedOccupiedVehicle(hitElement)) == localPlayer then
	if taxis[getElementModel ( getPedOccupiedVehicle(hitElement) )] then
	local occc = getElementData(localPlayer,"Occupation")
    if ( occc == "Taxi Driver") and ( getTeamName( getPlayerTeam( localPlayer) ) == "Civilian Workers") then
		local money = getElementData(source,"taximoneyhd")
		fadeCamera(false)
		setTimer(fadeCamera,3000,1,true)
		triggerServerEvent("giveTaxiMoney",hitElement,money)
		setElementData(localPlayer,"taxi3",getElementData(localPlayer,"taxi3")+money)
		disableJob()
		if isElement(source) then destroyElement(source) end
		if isTimer(deliverTimer) then killTimer(deliverTimer) end
		triggerServerEvent("cleanPedsFromServer",localPlayer)
		loadjob()
	end
	end
	end
end



function showDXt()
    local occc = getElementData(localPlayer,"Occupation")
    if ( occc == "Taxi Driver") and ( getTeamName( getPlayerTeam( localPlayer) ) == "Civilian Workers") then
        local playerVehicle = getPedOccupiedVehicle ( localPlayer )
        if playerVehicle and ( getElementModel ( playerVehicle) == 420 ) or playerVehicle and ( getElementModel ( playerVehicle) == 438 ) then

            pass = getElementData(localPlayer, "taxi2") or 0
            pass2 = getElementData(localPlayer, "taxi") or 0
            pass3 = getElementData(localPlayer, "taxi3") or 0

            if isTimer(deliverTimer) then
			local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails (deliverTimer)
			local timeLeft = math.floor(timeLeft / 1000)
			if timeLeft and timeLeft > 0 then
					guiSetText(TaxiJobC.label[4],"Mission timer: " ..timeLeft.." Seconds")
				end
			end
			guiSetText(TaxiJobC.label[3],"Bot Missions: $ " ..tostring(pass3))
            guiSetText(TaxiJobC.label[2],"Last payment: $ " ..tostring(pass2))
            guiSetText(TaxiJobC.label[1],"Total cash: $ " ..tostring(pass))

        end
    end
end
addEventHandler("onClientRender",root,showDXt)

function dxDrawFramedText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top + 1, width + 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left + 1, top - 1, width + 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top + 1, width - 1, height + 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left - 1, top - 1, width - 1, height - 1, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI)
	dxDrawText(message, left, top, width, height, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
end

addEventHandler("onClientRender", root,
	function()
		for index, bMarker in ipairs(getElementsByType("marker", resourceRoot)) do
			local timeLeft = getElementData(bMarker, "taximoney")
			local posX, posY, posZ = getElementPosition(bMarker)
			local camX, camY, camZ = getCameraMatrix()
			if getDistanceBetweenPoints3D(camX, camY, camZ, posX, posY, posZ) < 25 then
			local scX, scY = getScreenFromWorldPosition(posX, posY, posZ + 1.6)
				scX, scY = getScreenFromWorldPosition(posX, posY, posZ + 1.4)
				if scX then
					if not timeLeft then return false end
						if timeLeft and timeLeft > 0 then
						if timeLeft >= 1010 then
						r,g,b = 0,255,0
						elseif timeLeft > 800 and timeLeft < 1010 then
						r,g,b = 255,255,0
						elseif timeLeft > 600 and timeLeft <= 800 then
						r,g,b = 255,155,0
						elseif timeLeft <= 600 then
						r,g,b = 255,0,0
						end
						end
					setMarkerColor(bMarker,r,g,b,0)
					dxDrawFramedText("Mission payment: $"..timeLeft, scX, scY, scX, scY, tocolor(r,g,b, 255), 1.5-( getDistanceBetweenPoints3D(camX, camY, camZ, posX, posY, posZ)/20), "bankgothic", "center", "center", false, false, false)
				end
			end
		end
	end
)




function togglePilotPanel()
	if getElementData(localPlayer,"Occupation") == "Taxi Driver" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5","down",togglePilotPanel)



