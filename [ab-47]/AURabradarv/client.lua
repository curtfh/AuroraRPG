--[[
    --------------------------------------
    # Resource Name                       
	  Grand Theft Auto V | Radar          
	# Author                              
	  Rage
	  Special Thanks to MrTasty(dxMap & Blips) 
	# Date created                        
	  25.04.2014                          
	# Last update                         
      01.01.2015	                      
	# Updates                             
	  [01.01.2015]                        
	  -Moved from shader to dx            
	  -Blips support                      
	--------------------------------------  
--]]

local screenW,screenH = guiGetScreenSize()
local resW,resH = 1280,720
local sW,sH =  (screenW/resW), (screenH/resH)


--Features
local alwaysRenderMap = false
local alwaysRenderOxygen = false
local disableGTASAhealth = true
local disableGTASAarmor = true
local disableGTASAoxygen = true
local enableBlipDistance = true

--Dimensions & Sizes
 --Blip size, pixels relative to 256x256 resolution

local worldW, worldH = 3072, 3072
local blip = 14
local turn = true
local alpha = 255
local sRotating = 0
local rt = dxCreateRenderTarget(290, 175)



-- Useful functions --
function findRotation(x1,y1,x2,y2) --Author: Doomed_Space_Marine & robhol
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end
function getPointFromDistanceRotation(x, y, dist, angle) --Author: robhol
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end
	
local radarShowing = false
	
    function drawRadar()
		radarShowing = true
	    showPlayerHudComponent("radar", false)
	        if disableGTASAhealth then showPlayerHudComponent("health", false) end
	        if disableGTASAarmor then showPlayerHudComponent("armour", false) end
	        if disableGTASAoxygen then showPlayerHudComponent("breath", false) end
	    if (not isPlayerMapVisible()) then
		    local mW, mH = dxGetMaterialSize(rt)
		    if ( alwaysRenderMap or getElementInterior(localPlayer) == 0 ) then
			    dxSetRenderTarget(rt, true)
			local x, y = getElementPosition(localPlayer)
			local X, Y = mW/2 -(x/(6000/worldW)), mH/2 +(y/(6000/worldH))
			local camX,camY,camZ = getElementRotation(getCamera())
			    --dxDrawRectangle(0, 0, mW, mH, 0xFF7CA7D1) --render background
			    dxDrawImage(X - worldW/2, mH/5 + (Y - worldH/2), worldW, worldH, "img/radar_map.jpg", camZ, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
			    dxSetRenderTarget()
		end	
		--dxDrawImage((20+5)*sW, screenH-((191+5))*sH, (292-10)*sW, (144)*sH, rt, 0, 0, 0, tocolor(255, 255, 255, 150))	
		dxDrawImage((18+5)*sW, screenH-((179+5))*sH, (275-10)*sW, (135)*sH, rt, 0, 0, 0, tocolor(255, 255, 255, 150))
		local health = math.max(math.min(getElementHealth(localPlayer)/(0.232018558500192*getPedStat(localPlayer, 24) -32.018558511152), 1), 0)
		local armor = math.max(math.min(getPedArmor(localPlayer)/100, 1), 0)
		local oxygen = math.max(math.min(getPedOxygenLevel(localPlayer)/(1.5*getPedStat(localPlayer, 225) +1000), 1), 0)

        --# Get rotations
		local _, _, c_Rot = getElementRotation( getCamera());
		local _, _, p_Rot = getElementRotation( localPlayer )		
	    
		local playerHealth = math.floor( getElementHealth( localPlayer ))
	    local playerArmor = math.floor( getPedArmor( localPlayer ))
		local playerOxygen = math.floor( getPedOxygenLevel( localPlayer ))
		    if ( playerHealth  <= 50) then
			    HP_Colour = tocolor(200, 0, 0, 190)
				HP_Alpha = tocolor(200, 0, 0, 100)
			else
			    HP_Colour = tocolor(102, 204, 102, 190)
				HP_Alpha = tocolor(102, 204, 102, 100)				
            end
            if ( playerHealth >= 101 ) then
                maxHealth = 200
            else
                maxHealth = 100
            end				
		
		--# Alpha
		dxDrawRectangle(23.5*sW, 676.5*sH, 130.5*sW, 9.2*sH, HP_Alpha)		
		dxDrawRectangle(156.6*sW, 676.5*sH, 65*sW, 9.2*sH, tocolor(0, 102, 255, 100))
        dxDrawRectangle(225*sW, 676.5*sH, 62.6*sW, 9.2*sH, tocolor(255, 255, 0, 100))
		
		--# Bars
		dxDrawRectangle(23.5*sW, 676.5*sH, 130.5*sW/maxHealth*playerHealth, 9.2*sH, HP_Colour)		
        dxDrawRectangle(156.6*sW, 676.5*sH, 65*sW/100*playerArmor, 9.2*sH, tocolor(0, 102, 255, 190))
        dxDrawRectangle(225*sW, 676.5*sH, 62.6*sW/1000*playerOxygen, 9.2*sH, tocolor(255, 255, 0, 190))		
        --# Radar Cover		
        dxDrawImage(18*sW, 530*sH, 275*sW, 160*sH, "img/radar_cover.png", 0, 0, 0, tocolor(255, 255, 255, 255))		

		--#Blips
		local rx, ry, rz = getElementRotation(localPlayer)
		local lB = (23)*sW
		local rB = (23+265)*sW
		local tB = screenH-(184)*sH
		local bB = tB + (135)*sH
		local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*sH
		for k, v in ipairs(getElementsByType("blip")) do			
			local px, py, pz = getElementPosition(localPlayer)	
			local _,_,camZ = getElementRotation(getCamera())			
			local bx, by, bz = getElementPosition(v)
			local actualDist = getDistanceBetweenPoints2D(px, py, bx, by)
			local maxDist = getBlipVisibleDistance(v)
			if ( actualDist <= maxDist ) then
				local dist = actualDist/(6000/((worldW+worldH)/2))
				local rot = findRotation(bx, by, px, py)-camZ
				local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot)
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy))
				local blipID = getElementData(v, "customIcon") or getBlipIcon(v)
				local _, _, _, bcA = getBlipColor(v)
				local bcR, bcG, bcB = 255, 255, 255

				if getBlipIcon(v) == 0 then
					bcR, bcG, bcB = getBlipColor(v)
				end
				
			    local bUD = "img/blip.png"
			    if (bz - pz) >= 5 then
				    bUD = "img/blip_up.png"
		 	    elseif (bz - pz) <= -5 then
				    bUD = "img/blip_down.png"
			    end				
				
				local bS = getBlipSize(v)
				dxDrawImage(bpx -(blip*bS)*sW/2, bpy -(blip*bS)*sH/2, (blip*bS)*sW, (blip*bS)*sH, "img/blips/"..blipID..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
			end
		end

		if ( renderNorthBlip ) then
			local _,_,camZ = getElementRotation(getCamera())		
			local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, b-cY
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toLeft^2), -camZ+180)
			local bpx = math.max(lB, math.min(rB, bpx))
			local bpy = math.max(tB, math.min(bB, bpy))
			dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "img/blips/4.png", 0, 0, 0)
		end
	    local _,_,camZ = getElementRotation(getCamera())
        dxDrawImage(cX -(blip*1.5)*sW/2, cY -(blip*1.5)*sH/2, (blip*1.5)*sW, (blip*1.5)*sH, "img/player.png", camZ-rz, 0, 0)		
		
		--[[
		sRotating=sRotating+10
	    if ( sRotating==360 ) then
		    sRotating=0
	    end]]
	    --[[
        local localVehicle = getPedOccupiedVehicle(localPlayer)      
        if isElement(localVehicle) and getVehicleType(localVehicle) == "Helicopter" then
		    dxDrawImage(cX -(blip*1.5)*sW/2, cY -(blip*2)*sH/2, (blip*2)*sW, (blip*2)*sH, "img/hunter.png", camZ-rz, 0, 0)
		    dxDrawImage(cX -(blip*1.5)*sW/2, cY -(blip*2)*sH/2, (blip*2)*sW, (blip*2)*sH, "img/hrotor.png", sRotating)	
        elseif isElement(localVehicle) and getVehicleType(localVehicle) == "Plane" then		
		    dxDrawImage(cX -(blip*1.5)*sW/2, cY -(blip*2)*sH/2, (blip*2)*sW, (blip*2)*sH, "img/blips/5.png", camZ-rz, 0, 0)		
		else
		    dxDrawImage(cX -(blip*1.5)*sW/2, cY -(blip*1.5)*sH/2, (blip*1.5)*sW, (blip*1.5)*sH, "img/player.png", camZ-rz, 0, 0)		
        end
		]]
		
		--# Wanted
		local g_wl = getPlayerWantedLevel( localPlayer )
        if ( g_wl > 0 ) then
            if ( turn == true ) then
                alpha = alpha + 5
                    if ( alpha > 180 ) then
                        alpha = 180
                        turn = false
        end
        elseif ( turn == false ) then
            alpha = alpha - 5
                if ( alpha < 0 ) then
                    alpha = 0
                    turn = true
                end
        end
        dxDrawRectangle(23*sW, 536*sH, 265*sW, 135*sH, tocolor(0, 102, 255, alpha))
        else return end		
		end
	end

function showradar()
	if (radarShowing == false) then
		addEventHandler( "onClientRender", root, drawRadar)
		radarShowing = true
	end
end
addEvent("MTA_RP_radarv.showradar", true)
addEventHandler("MTA_RP_radarv.showradar", root, showradar)
addEventHandler("onClientResourceStart", root, showradar)

function undrawradar()
	if (radarShowing == true) then
		removeEventHandler( "onClientRender", root, drawRadar)
		radarShowing = false
	end
end
addEvent("MTA_RP_radarv.undrawradar", true)
addEventHandler("MTA_RP_radarv.undrawradar", root, undrawradar)