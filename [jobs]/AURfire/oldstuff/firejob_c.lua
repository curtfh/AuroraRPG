------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  firejob_c.luac (client-side)
--  Firefighter Job
--  Priyen Patel
------------------------------------------------------------------------------------
local shift = false
local cd = false
function resetCD()
    cd = false
end

function shiftUpdate(shif)
	shift=shif
end
addEvent("CSGfireShiftUpdate",true)
addEventHandler("CSGfireShiftUpdate",localPlayer,shiftUpdate)
modelpoints = {}
themodel = {}
function attackFire(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
    if (hitElement) == false then return end
    if isElement(hitElement) == false then return end
    if weapon == 42 then
        local model = getElementModel(hitElement)
        if model < 2022 or model > 2024  then return end
        if (isInFireFighterMode(localPlayer)) then
            if cd == false then
				cd = true
				if not modelpoints[hitElement] then modelpoints[hitElement] = 0 end
				modelpoints[hitElement] = modelpoints[hitElement]+1
				themodel = hitElement
				if modelpoints[hitElement] == 100 then
					triggerServerEvent("CSGfireHitFire",localPlayer,hitElement)
					modelpoints[hitElement] = 0
					themodel = false
				end
                setTimer(resetCD,50,1)
            end
        end
    end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,attackFire)


local screenW, screenH = guiGetScreenSize()
local screenWidth, screenHeight = guiGetScreenSize()

function dxDraw( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end

addEventHandler("onClientRender",root,function()
	if getElementData(localPlayer,"isPlayerFireFighter") then
		if themodel and isElement(themodel) then
			if modelpoints[themodel] and tonumber(modelpoints[themodel]) and tonumber(modelpoints[themodel]) >= 0 then
				dxDraw("Progress for this fire: "..modelpoints[themodel], 1.75, (screenW - 504) / 2, (screenH - 50) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(200,0,0, 195), 0.7, "pricedown", "center", "center", false, false, true, false, false)
			end
		end
	end
end)

function isInFireFighterMode(p)
	if getPlayerTeam(p) and ((getTeamName(getPlayerTeam(p))) == "Civilian Workers" and exports.server:getPlayerOccupation(p) == "Firefighter") then
		return true
	else
		return false
	end
end
--[[
function attackFireByTruck(ped)
    if isInFireFighterMode(localPlayer) == false then return end

    if getPedOccupiedVehicle(localPlayer) ~= source then return end
    if cd == false then
        cd = true
       -- triggerServerEvent("CSGfireHitFireByTruck",localPlayer,ped)
        --setTimer(resetCD,1000,1)
    end
end
addEventHandler("onClientPedHitByWaterCannon",root,attackFireByTruck)

function attackByTruck2(el)
	if getElementModel(source) == 407 then cancelEvent() return end
	if getElementType(el) == "ped" then cancelEvent() end
end
addEventHandler("onClientPlayerHitByWaterCannon",root,attackByTruck2)

addEventHandler("onClientPedDamage",root,function(at,wep)
	if getElementType(source) == "ped" then
		if getElementData(source,"firePed") then
			if at and isElement(at) then
				if getElementType(at) == "player" then
					if not isPedInVehicle(at) then
						if getElementData(at,"Occupation") == "Firefighter" and getPlayerTeam(at) and getTeamName(getPlayerTeam(at)) == "Civilian Workers" then
							cancelEvent()
						else
							cancelEvent()
						end
					end
				elseif getElementType(at) == "vehicle" then
					local attacker = getVehicleController(at)
					if getElementData(at,"Occupation") == "Firefighter" and getPlayerTeam(at) and getTeamName(getPlayerTeam(at)) == "Civilian Workers" then
						return
					else
						cancelEvent()
					end
				end
			end
		end
	end
end)]]

function togglePilotPanel()
	if getElementData(localPlayer,"Occupation") == "Firefighter" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		exports.CSGranks:openPanel()
	end
end
bindKey("F5","down",togglePilotPanel)


isFire = false
setTimer(function()
	if getElementData(localPlayer,"Occupation") == "Firefighter" and getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		if isFire == false then
			isFire = true
			firedff = engineLoadDFF("FireModel.dff", 2022)
			firedff2 = engineLoadDFF("FireModel2.dff", 2024)
			engineReplaceModel(firedff,2022)
			engineReplaceModel(firedff2,2024)
		end
		for k,v in ipairs(getElementsByType("object",resourceRoot)) do
			setElementAlpha(v,255)
		end
		for k,v in ipairs(getElementsByType("blip",resourceRoot)) do
			local x,y,z = getElementPosition(localPlayer)
			local cx,cy,cz = getElementPosition(v)
			local dist = getDistanceBetweenPoints3D(x,y,z,cx,cy,cz)
			if dist <= 50 then
				setElementData(localPlayer,"isPlayerFireFighter",true)
			else
				setElementData(localPlayer,"isPlayerFireFighter",false)
			end
		end

	else
		if isFire == true then
			isFire = false
			engineRestoreModel(2022)
			engineRestoreModel(2024)
		end
		for k,v in ipairs(getElementsByType("object",resourceRoot)) do
			setElementAlpha(v,0)
		end
		setElementData(localPlayer,"isPlayerFireFighter",false)
	end
end,1000,0)


addEventHandler("onClientResourceStop",resourceRoot,function()
	engineRestoreModel(2022)
	engineRestoreModel(2024)
	for k,v in ipairs(getElementsByType("object",resourceRoot)) do
		if isElement(v) then destroyElement(v) end
	end
	--[[for k,v in ipairs(getElementsByType("ped",resourceRoot)) do
		if isElement(v) then destroyElement(v) end
	end]]
	for k,v in ipairs(getElementsByType("colshape",resourceRoot)) do
		if isElement(v) then destroyElement(v) end
	end

end)

local blips = {}
function CSGfireStarted(x,y,z)
    if isElement(blips[x]) then return end
    blips[x] = createBlip(x,y,z,20)
end
addEvent("CSGfireStarted",true)
addEventHandler("CSGfireStarted",localPlayer,CSGfireStarted)

function CSGfireEnded(x)
	if x == "all" then
		for k,v in pairs(blips) do
			if isElement(v) then
				destroyElement(v)
			end
		end
	else
	    if isElement(blips[x]) then
			destroyElement(blips[x])
		end
	end

end
addEvent("CSGfireEnded",true)
addEventHandler("CSGfireEnded",localPlayer,CSGfireEnded)

addEvent("onPlayerJobChange",true)

function jobChange(nJob,oldJob)
	if nJob == "Firefighter" then
		triggerServerEvent("CSGfireBackOnShift",localPlayer)
	elseif oldJob == "Firefighter" then
		triggerServerEvent("CSGfireQuitJob",localPlayer)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function CSGfireSetCollisions(t,boole)
	for k,v in pairs(t) do
        setElementCollisionsEnabled(k,boole)
        setElementCollisionsEnabled(v,boole)
    end
end
addEvent("CSGfireSetCollisions",true)
addEventHandler("CSGfireSetCollisions",localPlayer,CSGfireSetCollisions)




function monitorShift()
	if not isInFireFighterMode(localPlayer) then
		for k,v in ipairs(getElementsByType("object",resourceRoot)) do
			setElementCollisionsEnabled(v,false)
		end
	end
	if shift == true then return end
	local s = getElementModel(localPlayer)
	if s == 277 or s == 278 or s == 279 then
		local team = getPlayerTeam(localPlayer)
		if team == false then return end
		if getTeamName(team) == "Civilian Workers" then
			triggerServerEvent("CSGfireBackOnShift",localPlayer)
		end
	end
end
setTimer(monitorShift,1000,0)

-----------------------Updated Nov 26th 2012

if fileExists("firejob_c.lua") == true then
	fileDelete("firejob_c.lua")
end
