local crimeSetup = false
local clueCount = 0
local clues = {349, 350, 325, 335, 337, 347, 358, 2263, 2703, 2837, 928, 3082, 1946, 1025, 2647, 2702, 2769}
local objs = {}
local tableofclues = {}
local blips = {}
local peds = {}
local cols = {}
local cols2 = {}
cityToUse = "LS"

local dests = {
	{1531.3452148438,-1631.5815429688,13.627583503723},
	{2004.3118896484,-1442.8776855469,13.562582969666,"LS"},
	{2150.640625,-1293.8365478516,23.978977203369,"LS"},
	{1603.1121826172,-1036.9809570313,23.914047241211,"LS"},
	{957.00476074219,-1632.6430664063,13.540469169617,"LS"},
	{1726.6306152344,-1632.5029296875,20.215179443359,"LS"},
	{1325.7783203125,-1279.9487304688,12.993987083435,"LS"},
	{1257.4794921875,-1280.3414306641,12.913123130798,"LS"},
	{1205.25,-1279.9801025391,12.998148918152,"LS"},
	{1060.3488769531,-1269.8489990234,13.396063804626,"LS"},
	{944.69012451172,-1227.373046875,16.379028320313,"LS"},
	{916.95092773438,-1322.5111083984,13.107110977173,"LS"},
	{818.32952880859,-1339.0447998047,13.142149925232,"LS"},
	{1041.1795654297,-1745.6037597656,13.014188766479,"LS"},
	{1086.3431396484,-1779.8048095703,13.195708274841,"LS"},
	{1151.0877685547,-1617.8758544922,13.396173477173,"LS"},
	{1300.2083740234,-1664.1832275391,13.3828125,"LS"},
	{1329.8410644531,-1477.9383544922,12.989696502686,"LS"},
	{1304.8502197266,-1823.0179443359,13.546875,"LS"},
	{2014.7495117188,-1518.5422363281,3.4064054489136,"LS"},
	{2734.0595703125,-1655.7940673828,13.0703125,"LS"},
}

local possibleSkins = {	1,105,106,107,102,103,104,108,109,110,114,115,116,111,112,113}
pro = {}
reload = {}

function makeJob(state)
	if exports.server:getPlayChatZone(localPlayer) ~= "LS" then return false end
	if crimeSetup == true then return false end
	if isTimer(pro) then return false end
	if isTimer(reload) then return false end
	if state == true then
		if getPlayerTeam( localPlayer ) and getTeamName ( getPlayerTeam( localPlayer ) ) == "Government" then
			local i = 1
			local validI = false
			while(validI==false) do
				i = math.random(1,#dests)
				if dests[i][4] == cityToUse then
					validI = true
				end
			end
			local x,y,z = dests[i][1],dests[i][2],dests[i][3]
			if x then
				if crimeSetup == true then return false end
				local sk = possibleSkins[math.random(1,#possibleSkins)]
				setupClientCrimeScene(sk, x, y, z)
			end
		end
	else
		pro = setTimer(function()
			if getPlayerTeam( localPlayer ) and getTeamName ( getPlayerTeam( localPlayer ) ) == "Government" then
				if exports.server:getPlayChatZone(localPlayer) ~= "LS" then return false end
				local i = 1
				local validI = false
				while(validI==false) do
					i = math.random(1,#dests)
					if dests[i][4] == cityToUse then
						validI = true
					end
				end
				local x,y,z = dests[i][1],dests[i][2],dests[i][3]
				if x then
					if crimeSetup == true then return false end
					local sk = possibleSkins[math.random(1,#possibleSkins)]
					setupClientCrimeScene(sk, x, y, z)
				end
			end
		end,300000,1)
	end
end

function setupClientCrimeScene(skin, x, y, z)
	if (crimeSetup == false) then
		local ped = createPed(skin, x, y, z)
		if ped then
			setElementHealth(ped,100)
			crimeSetup = true
			exports.NGCdxmsg:createNewDxMessage("[Criminal invistigation] : You have been assigned to a case report to victim placed as (Blue ped blip) in "..getZoneName(x,y,z).." street." , 0,150,250)
			exports.NGCdxmsg:createNewDxMessage("[Criminal invistigation] : You have 2 minutes to solve the case or it will be moved to another detective!!" , 0,150,250)
			table.insert(peds,ped)
			local pedCol = createColSphere(x, y, z, 10)
			local blip = createBlip(x, y, z, 58)
			table.insert(cols,pedCol)
			table.insert(blips,blip)
			attachElements(pedCol,ped)
			setElementHealth(ped, 0)
			if isTimer(reload) then killTimer(reload) end
			reload = setTimer(function()
				exports.NGCdxmsg:createNewDxMessage("[Criminal invistigation] : You have failed in the case (You didn't find required clues)", 250, 0, 0)
				triggerEvent("endJobDetective",localPlayer)
			end,180000,1)
			addEventHandler("onClientColShapeHit", pedCol, function(hitEl, MD)
				if (hitEl and MD and hitEl == localPlayer) then
					for k,v in ipairs(cols) do
						if isElement(v) then destroyElement(v) end
					end
					for k,v in ipairs(blips) do
						if isElement(v) then destroyElement(v) end
					end
					exports.NGCdxmsg:createNewDxMessage("[Criminal invistigation] : Search for clues", 0, 255, 0)
					for i=0, 20 do
					local obj1, obj2, obj3 = x + math.random(-55,55), y + math.random(-55,55), getGroundPosition(x, y, z)
					local object = createObject(clues[math.random(#clues)], obj1, obj2, obj3)
					local col = createColSphere(obj1, obj2, obj3 + 1, 1)
					table.insert(cols2,col)
					table.insert(tableofclues,object)
					addEventHandler("onClientColShapeHit", col, function(hitEl, MD)
					if (hitEl and MD and hitEl == localPlayer) then
						if isElement(object) then destroyElement(object) end
						for k,v in ipairs(tableofclues) do
							if v == object then
							table.remove(tableofclues,k)
							end
						end
						clueCount = clueCount + 1
						exports.NGCdxmsg:createNewDxMessage("[Criminal invistigation] : You've found a clue "..clueCount.."/5", 0, 255, 0)
						if (clueCount == 5) then
							gotThreeClues()
							triggerEvent("endJobDetective",localPlayer)
						end
						playSoundFrontEnd(1)
					end
				end)
			end
				end
			end)
		else
			makeJob(true)
		end
	end
end
addEvent("crimeSceneSetup", true)
addEventHandler("crimeSceneSetup", localPlayer, setupClientCrimeScene)

function gotThreeClues()
	triggerServerEvent("finishCase", localPlayer)
	clueCount = 0
	crimeSetup = false
end

addEvent("endJobDetective", true)
addEventHandler("endJobDetective", localPlayer,
function ()
	if getPlayerTeam( localPlayer ) and getTeamName ( getPlayerTeam( localPlayer ) ) == "Government" then
		for k,v in ipairs(tableofclues) do
			if (isElement(v)) then
				destroyElement(v)
			end
		end
		for k,v in ipairs(cols) do
			if isElement(v) then destroyElement(v) end
		end
		for k,v in ipairs(blips) do
			if isElement(v) then destroyElement(v) end
		end
		for k,v in ipairs(cols2) do
			if isElement(v) then destroyElement(v) end
		end
		for k,v in ipairs(peds) do
			if isElement(v) then destroyElement(v) end
		end
		if isTimer(pro) then killTimer(pro) end
		if isTimer(reload) then killTimer(reload) end
		clueCount = 0
		crimeSetup = false
		makeJob(false)
	else
		deleteWork()
	end
end)

function deleteWork()
	for k,v in ipairs(tableofclues) do
		if (isElement(v)) then
			destroyElement(v)
		end
	end
	for k,v in ipairs(cols) do
		if isElement(v) then destroyElement(v) end
	end
	for k,v in ipairs(blips) do
		if isElement(v) then destroyElement(v) end
	end
	for k,v in ipairs(cols2) do
		if isElement(v) then destroyElement(v) end
	end
	for k,v in ipairs(peds) do
		if isElement(v) then destroyElement(v) end
	end
	if isTimer(pro) then killTimer(pro) end
	if isTimer(reload) then killTimer(reload) end
	clueCount = 0
	crimeSetup = false
end

addEventHandler("onClientPlayerQuit",localPlayer,function()
	if source == localPlayer then
		deleteWork()
	end
end)
--[[
setTimer ( function ()
    if getPlayerTeam( localPlayer ) then
		local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
		if newTeam == "Government" then
			makeJob(true)
		else
			deleteWork()
		end
	end
end,2000, 1 )]]

setTimer ( function ()
    if getPlayerTeam( localPlayer ) then
		local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
		if newTeam == "Government" then
			makeJob(false)
		else
			deleteWork()
		end
	end
end,5000, 0 )


function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawBorderedText(
        tostring( text ),
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,
		scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI
    )
end
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

local screenWidth, screenHeight = guiGetScreenSize()
function createText()
	if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) == "Government" then
		if exports.server:getPlayChatZone(localPlayer) ~= "LS" then return false end
		if reload and isTimer(reload) then
			local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( reload )
			local timeLeft = math.floor(timeLeft / 1000)
			if timeLeft > 0 then
				dxDrawRelativeText( "[Criminal invistigation]: Mission will be finished after ("..timeLeft.." seconds)", 300,730,1256.0,274.0,tocolor(255,255,255,255),1.0,"default-bold","center","top",false,false,false )
			end
		elseif pro and isTimer(pro) then
			local timeLeft, timeLeftEx, timeTotalEx = getTimerDetails ( pro )
			local timeLeft = math.floor(timeLeft / 1000)
			if timeLeft > 0 then
				dxDrawRelativeText( "[Criminal invistigation]: Mission will be ready after ("..timeLeft.." seconds)", 300,730,1256.0,274.0,tocolor(255,255,255,255),1.0,"default-bold","center","top",false,false,false )
			end
		end
	end
end
addEventHandler("onClientRender",root,createText)
