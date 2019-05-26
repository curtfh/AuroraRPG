createSearchLight (569.64,-1852.78,9.42, 569.64,-1852.78,7.42, 1, 3)
local light1 = createSearchLight (568.77,-2000.89,5.69, 568.77,-2000.89,100.69, 0.3, 13)
local light2 = createSearchLight (566.42,-2000.82,5.69, 532.42,-2000.82,100.69, 0.3, 13)
local light3 = createSearchLight (570.87,-2000.87,5.69, 608.87,-2000.87,100.69, 0.3, 13)

local light4 = createSearchLight (585.91,-1849.54,10.28, 570.48,-1863.14,4.51, 0.3, 8)
local light5 = createSearchLight (553.22,-1848.82,10.32, 570.48,-1863.14,4.51, 0.3, 8)
local light6 = createSearchLight (585.92,-1866.83,10.32, 570.48,-1863.14,4.51, 0.3, 8)
local light7 = createSearchLight (553.29,-1866.62,10.32, 570.48,-1863.14,4.51, 0.3, 8)

local light8 = createSearchLight (555.56,-1853.59,6.42, 555.56,-1865.59,8.66, 0.1, 8)
local light9 = createSearchLight (559.79,-1853.35,6.42, 559.56,-1866.59,8.66, 0.1, 8)
local light10 = createSearchLight (562.79,-1853.35,6.42, 562.56,-1867.59,8.66, 0.1, 8)
local light11 = createSearchLight (574.35,-1853.97,6.42, 574.56,-1867.59,8.66, 0.1, 8)
local light12 = createSearchLight (578.35,-1853.97,6.42, 578.56,-1867.59,8.66, 0.1, 8)
local light13 = createSearchLight (582.35,-1853.97,6.42, 582.56,-1867.59,8.66, 0.1, 8)
local offs = 0

local lights = {
    {"corona", 1, 566.56481933594, -1854.9465332031, 10.318841934204},
    {"corona", 1, 572.39929199219, -1854.9465332031, 10.318841934204},
    {"corona", 1, 569.9423828125, -1876.3403320313, 7.8188419342041},
	{"corona", 1, 569.9423828125, -1885.6627197266, 7.8188419342041},
    {"corona", 1, 574.48718261719, -1881.2161865234, 7.8188419342041},
    {"corona", 1, 564.861328125, -1881.2161865234, 7.8188419342041},
    {"corona", 3, 564.861328125, -1862.8427734375, 2.9876441955566},
    {"corona", 3, 574.361328125, -1862.3435058594, 2.9876441955566},
    {"corona", 3, 569.611328125, -1856.3435058594, 2.9876441955566},
    {"corona", 3, 570.111328125, -1859.8435058594, 2.9876441955566},
    {"corona", 3, 567.361328125, -1867.9661865234, 2.9876441955566},
    {"corona", 3, 573.611328125, -1867.7161865234, 2.9876441955566},
    {"corona", 3, 569.611328125, -1864.7161865234, 2.9876441955566},
    {"corona", 3, 562.861328125, -1857.9661865234, 2.9876441955566},
    {"corona", 3, 575.98370361328, -1857.9661865234, 2.9876441955566},
    {"corona", 3, 578.73370361328, -1864.4661865234, 2.9876441955566},
    {"corona", 3, 559.73370361328, -1867.4661865234, 2.9876441955566},
    {"corona", 3, 558.73370361328, -1860.2161865234, 2.9876441955566},
    {"corona", 3, 582.40502929688, -1858.7161865234, 2.9876441955566},
    {"corona", 3, 569.611328125, -1861.0935058594, 10.487644195557},
    {"corona", 3, 559.111328125, -1861.0935058594, 10.487644195557},
    {"corona", 3, 579.48370361328, -1861.0935058594, 10.487644195557},
    {"corona", 3, 563.98370361328, -1864.8435058594, 10.487644195557},
    {"corona", 3, 574.98370361328, -1864.8435058594, 10.487644195557},
    {"corona", 3, 574.9833984375, -1856.0927734375, 10.487644195557},
    {"corona", 3, 563.73370361328, -1856.0935058594, 10.487644195557},
    {"cylinder", 1, 569.88269042969, -1876.2061767578, 3.7038617134094},
    {"cylinder", 1, 574.87231445313, -1881.1217041016, 3.7038617134094},
    {"cylinder", 1, 569.83264160156, -1885.9510498047, 3.7038617134094},
    {"cylinder", 1, 564.88781738281, -1881.1458740234, 3.7038617134094},
    {"checkpoint", 1, 569.86822509766, -1881.0313720703, 9.919038772583},
    {"cylinder", 1, 565.74731445313, -1854.7462158203, 6.3264694213867},
    {"cylinder", 1, 573.36975097656, -1854.7462158203, 6.3264694213867},
    {"corona", 3, 590.32916259766, -1904.9923095703, 10.037041664124},
    {"corona", 3, 603.39831542969, -1894.2095947266, 10.234810829163},
    {"corona", 3, 614.71466064453, -1884.3310546875, 10.395962715149},
    {"corona", 3, 607.97601318359, -1874.7663574219, 9.5978231430054},
}

local ped = {
	--x,y,z,scale,rot
	{575.38757, -1881.08289, 4.79567, 1, 258},
	{569.93652, -1886.51111, 4.79567, 1, 178},
	{564.34991, -1881.19971, 4.79567, 1, 81},
	{569.85242, -1875.70093, 4.79567, 1, 2},

	{569.81067, -1881.28760, 9.75393, 1, 2},

	{559.74872, -1852.20898, 7.42400, 4, 175},
	{580.28497, -1851.37524, 7.42400, 4, 185},

	{553.33392, -1873.30676, 7.98823, 4, 303}
}

local createdlights = {}
local createdpeds = {}

for i,v in ipairs(lights) do 
	local lightm = createMarker (v[3], v[4], v[5], v[1], v[2], 255, 255, 255, 255)
	table.insert (createdlights, lightm)
end 

setTimer(function()
	for i,v in ipairs(ped) do
		local thePed = createPed(218, v[1], v[2], v[3], v[5])
		setElementFrozen(thePed, true)
		addEventHandler("onClientPedDamage", thePed, function() cancelEvent() end)
		table.insert (createdpeds, thePed)
	end 
end, 10000, 1)


local lightobj1 = createObject(354, 557.08789, -1862.7266, 3.73295, 0, 0, 0)
local lightobj2 = createObject(354, 583.73181, -1862.06433, 3.95159, 0, 0, 0)
local smokeObj = createObject(2005, 569.75818, -1875.07715, 4.08648)
local fireObj = createObject(2023, 557.08789, -1862.7266, 3.73295)
local fireObj2 = createObject(2023, 583.73181, -1862.06433, 3.95159)
setElementDimension(lightobj1, 3)
setElementDimension(lightobj2, 3)
setElementDimension(smokeObj, 3)
setElementDimension(fireObj, 3)
setElementDimension(fireObj2, 3)



GUIEditor = {
    edit = {},
    button = {},
    window = {},
    scrollbar = {},
    label = {}
}
local screenW, screenH = guiGetScreenSize()

function goLightsInStage ()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) ~= "Staff") then return false end
	triggerServerEvent ("AURconcert2.changelights", resourceRoot, "targetlight")
end 
addCommandHandler("targetlight", goLightsInStage)

function goLightsTurnLeft ()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) ~= "Staff") then return false end
	triggerServerEvent ("AURconcert2.changelights", resourceRoot, "turning_light_left")
end 
addCommandHandler("lightturnleft", goLightsTurnLeft)

function goLightsTurnRight ()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) ~= "Staff") then return false end
	triggerServerEvent ("AURconcert2.changelights", resourceRoot, "turning_light_right")
end 
addCommandHandler("lightturnright", goLightsTurnRight)

function openGui ()
	if (getTeamName(getPlayerTeam(getLocalPlayer())) ~= "Staff") then return false end
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
	else 
		GUIEditor.window[1] = guiCreateWindow((screenW - 418) / 2, (screenH - 317) / 2, 418, 317, "AuroraRPG - Light System", false)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.label[1] = guiCreateLabel(11, 40, 38, 15, "Red: ", false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[1], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[1], 255, 0, 0)
		GUIEditor.label[2] = guiCreateLabel(10, 65, 38, 15, "Green:", false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[2], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[2], 0, 255, 0)
		GUIEditor.label[3] = guiCreateLabel(10, 90, 38, 15, "Blue:", false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[3], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[3], 0, 0, 255)
		GUIEditor.label[4] = guiCreateLabel(10, 115, 38, 15, "Alpha:", false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[4], "default-bold-small")
		GUIEditor.scrollbar[1] = guiCreateScrollBar(48, 40, 265, 15, true, false, GUIEditor.window[1])
		GUIEditor.scrollbar[2] = guiCreateScrollBar(48, 65, 265, 15, true, false, GUIEditor.window[1])
		GUIEditor.scrollbar[3] = guiCreateScrollBar(48, 90, 265, 15, true, false, GUIEditor.window[1])
		GUIEditor.scrollbar[4] = guiCreateScrollBar(53, 115, 265, 15, true, false, GUIEditor.window[1])
		GUIEditor.edit[1] = guiCreateEdit(323, 34, 46, 21, "255", false, GUIEditor.window[1])
		guiEditSetMaxLength(GUIEditor.edit[1], 3)
		guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 100)
		GUIEditor.edit[2] = guiCreateEdit(323, 59, 46, 21, "255", false, GUIEditor.window[1])
		guiEditSetMaxLength(GUIEditor.edit[2], 3)
		guiScrollBarSetScrollPosition(GUIEditor.scrollbar[2], 100)
		GUIEditor.edit[3] = guiCreateEdit(323, 84, 46, 21, "255", false, GUIEditor.window[1])
		guiEditSetMaxLength(GUIEditor.edit[3], 3)
		guiScrollBarSetScrollPosition(GUIEditor.scrollbar[3], 100)
		GUIEditor.edit[4] = guiCreateEdit(328, 109, 46, 21, "255", false, GUIEditor.window[1])
		guiScrollBarSetScrollPosition(GUIEditor.scrollbar[4], 100)    
		guiEditSetMaxLength(GUIEditor.edit[4], 3)
		GUIEditor.label[5] = guiCreateLabel(6, 24, 255, 16, "Auto updates when you change this settings", false, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[5], "default-bold-small")
		GUIEditor.button[1] = guiCreateButton(19, 187, 89, 34, "All Lights, Random Color", false, GUIEditor.window[1])
		GUIEditor.button[2] = guiCreateButton(118, 187, 89, 34, "All Lights, Off", false, GUIEditor.window[1])
		GUIEditor.button[3] = guiCreateButton(219, 187, 89, 34, "All Lights, Fade In", false, GUIEditor.window[1])
		GUIEditor.button[4] = guiCreateButton(318, 187, 89, 34, "All Lights, Fade Out", false, GUIEditor.window[1])
		GUIEditor.button[5] = guiCreateButton(19, 231, 89, 34, "All Lights, Flash", false, GUIEditor.window[1])
		GUIEditor.button[6] = guiCreateButton(217, 231, 89, 34, "Each Lights, Random Color", false, GUIEditor.window[1])
		GUIEditor.button[7] = guiCreateButton(118, 231, 89, 34, "All Lights, On", false, GUIEditor.window[1])
		GUIEditor.button[8] = guiCreateButton(318, 231, 89, 34, "Crazy Lights", false, GUIEditor.window[1])
		GUIEditor.button[9] = guiCreateButton(118, 273, 89, 34, "Reset", false, GUIEditor.window[1])
		GUIEditor.button[10] = guiCreateButton(217, 273, 89, 34, "Close Panel", false, GUIEditor.window[1])
		
		showCursor(true)
		addEventHandler("onClientGUIClick", GUIEditor.button[10], function()
			openGui()
		end, false)
		
		addEventHandler("onClientGUIScroll", GUIEditor.scrollbar[1], function(scroll)
			local value = guiScrollBarGetScrollPosition(scroll)
			guiSetText(GUIEditor.edit[1], value*2.55)
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "red", value*2.55)
		end, false)
		
		addEventHandler("onClientGUIScroll", GUIEditor.scrollbar[2], function(scroll)
			local value = guiScrollBarGetScrollPosition(scroll)
			guiSetText(GUIEditor.edit[2], value*2.55)
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "green", value*2.55)
		end, false)
		
		addEventHandler("onClientGUIScroll", GUIEditor.scrollbar[3], function(scroll)
			local value = guiScrollBarGetScrollPosition(scroll)
			guiSetText(GUIEditor.edit[3], value*2.55)
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "blue", value*2.55)
		end, false)
		
		addEventHandler("onClientGUIScroll", GUIEditor.scrollbar[4], function(scroll)
			local value = guiScrollBarGetScrollPosition(scroll)
			guiSetText(GUIEditor.edit[4], value*2.55)
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "alpha", value*2.55)
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_random", math.random(0,255), math.random(0,255), math.random(0,255), 255)
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_off")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_fadein")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[4], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_fadeout")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[5], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_flash")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[6], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "eachlights_random")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[7], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_on")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[8], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "all_crazy")
		end, false)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[9], function()
			triggerServerEvent ("AURconcert2.changelights", resourceRoot, "reset")
		end, false)
	end 
end
addCommandHandler("lightsystem", openGui)

local ticker
local couns = 2000
local endTime
local onGoing = false
local timer 
local timerflash 
addEvent("AURconcert2.lightaffects",true)
addEventHandler( "AURconcert2.lightaffects", resourceRoot,
    function(typez, value, rz, gz, bz, az)
    	outputDebugString("Trigger")
		if (typez == "red") then 
			for i,v in ipairs(createdlights) do 
				local r, g, b, a = getMarkerColor (v)
				setMarkerColor(v, value, g, b, a)
				setSkyGradient(0,0,0,value,g,b)
			end 
		elseif (typez == "green") then 
			for i,v in ipairs(createdlights) do 
				local r, g, b, a = getMarkerColor (v)
				setMarkerColor(v, r, value, b, a)
				setSkyGradient(0,0,0,r,value,b)
			end 
		elseif (typez == "blue") then 
			for i,v in ipairs(createdlights) do 
				local r, g, b, a = getMarkerColor (v)
				setMarkerColor(v, r, g, value, a)
				setSkyGradient(0,0,0,r,g,value)
			end 
		elseif (typez == "alpha") then 
			for i,v in ipairs(createdlights) do 
				local r, g, b, a = getMarkerColor (v)
				setMarkerColor(v, r, g, b, value)
			end 
		elseif (typez == "danceped") then
			for i,v in ipairs(createdpeds) do 
				setPedAnimation ( v, "fortnite", value )
				exports.transformers:setAnimsdsd(value)
			end 
		elseif (typez == "all_random") then 
			for i,v in ipairs(createdlights) do 
				setMarkerColor(v, rz, gz, bz, az)
				setSkyGradient(0,0,0,rz,gz,bz)
			end 
		elseif (typez == "all_off") then 
			setElementDimension(lightobj1, 3)
			setElementDimension(lightobj2, 3)
			for i,v in ipairs(createdlights) do 
				local r, g, b, a = getMarkerColor (v)
				setMarkerColor(v, r, g, b, 0)
			end 
			setSearchLightEndRadius (light1, 0.3)
			setSearchLightEndRadius (light2, 0.3)
			setSearchLightEndRadius (light3, 0.3)
			setSearchLightEndRadius (light4, 0)
			setSearchLightEndRadius (light5, 0)
			setSearchLightEndRadius (light6, 0)
			setSearchLightEndRadius (light7, 0)
			setSearchLightEndRadius (light8, 0)
			setSearchLightEndRadius (light9, 0)
			setSearchLightEndRadius (light10, 0)
			setSearchLightEndRadius (light11, 0)
			setSearchLightEndRadius (light12, 0)
			setSearchLightEndRadius (light13, 0)
		elseif (typez == "all_fadein") then 
			if (onGoing == false) then 
				setElementDimension(lightobj1, 3)
				setElementDimension(lightobj2, 3)
				ticker = getTickCount()
				endTime = ticker + couns
				addEventHandler("onClientRender", getRootElement(), markerFadeIn)
			end
		elseif (typez == "all_fadeout") then 
			if (onGoing == false) then 
				setElementDimension(lightobj1, 3)
				setElementDimension(lightobj2, 3)
				ticker = getTickCount()
				endTime = ticker + couns
				addEventHandler("onClientRender", getRootElement(), markerFadeOut)
			end
		elseif (typez == "all_flash") then 
			if (isTimer(timerflash)) then 
				killTimer(timerflash)
				setElementDimension(lightobj1, 3)
				setElementDimension(lightobj2, 3)
				return
			end 
			setElementDimension(lightobj1, 0)
			setElementDimension(lightobj2, 0)
			timerflash = setTimer(function()
				for i,v in ipairs(createdlights) do 
					local r, g, b, a = getMarkerColor (v)
					if (a == 255) then 
						az = 0
					else
						az = 255
					end 
					setMarkerColor(v, r, g, b, az)
				end 
				if (offs == 0.3) then 
					setSearchLightEndRadius (light1, 13)
					setSearchLightEndRadius (light2, 13)
					setSearchLightEndRadius (light3, 13)
					setSearchLightEndRadius (light4, 8)
					setSearchLightEndRadius (light5, 8)
					setSearchLightEndRadius (light6, 8)
					setSearchLightEndRadius (light7, 8)
					setSearchLightEndRadius (light8, 8)
					setSearchLightEndRadius (light9, 8)
					setSearchLightEndRadius (light10, 8)
					setSearchLightEndRadius (light11, 8)
					setSearchLightEndRadius (light12, 8)
					setSearchLightEndRadius (light13, 8)
					offs = 13
				else 
					setSearchLightEndRadius (light1, 0.3)
					setSearchLightEndRadius (light2, 0.3)
					setSearchLightEndRadius (light3, 0.3)
					setSearchLightEndRadius (light4, 0.3)
					setSearchLightEndRadius (light5, 0.3)
					setSearchLightEndRadius (light6, 0.3)
					setSearchLightEndRadius (light7, 0.3)
					setSearchLightEndRadius (light8, 0.3)
					setSearchLightEndRadius (light9, 0.3)
					setSearchLightEndRadius (light10, 0.3)
					setSearchLightEndRadius (light11, 0.3)
					setSearchLightEndRadius (light12, 0.3)
					setSearchLightEndRadius (light13, 0.3)
					offs = 0.3
				end 
			end, 50, 0)
			
		elseif (typez == "eachlights_random") then 
			for i,v in ipairs(createdlights) do 
				local c, x, z, a = getMarkerColor (v)
				local r,g,b = math.random(0,255), math.random(0,255), math.random(0,255)
				setMarkerColor(v, r,g,b, a)
				setSkyGradient(0,0,0,r,g,b)
			end 
		elseif (typez == "all_on") then 
			for i,v in ipairs(createdlights) do 
				local r, g, b, a = getMarkerColor (v)
				setMarkerColor(v, r, g, b, 255)
			end 
			setSearchLightEndRadius (light1, 13)
			setSearchLightEndRadius (light2, 13)
			setSearchLightEndRadius (light3, 13)
			setSearchLightEndRadius (light4, 8)
			setSearchLightEndRadius (light5, 8)
			setSearchLightEndRadius (light6, 8)
			setSearchLightEndRadius (light7, 8)
			setSearchLightEndRadius (light8, 8)
			setSearchLightEndRadius (light9, 8)
			setSearchLightEndRadius (light10, 8)
			setSearchLightEndRadius (light11, 8)
			setSearchLightEndRadius (light12, 8)
			setSearchLightEndRadius (light13, 8)
		elseif (typez == "all_crazy") then 
			if (isTimer(timer)) then 
				setElementDimension(lightobj1, 3)
				setElementDimension(lightobj2, 3)
				killTimer(timer)
				return
			end 
			setElementDimension(lightobj1, 0)
			setElementDimension(lightobj2, 0)
			timer = setTimer(function()
				for i,v in ipairs(createdlights) do 
					setMarkerColor(v, math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255))
				end 
				setSearchLightEndPosition (light1, math.random(400, 700),0-(math.random(1800, 2200)),100.69)
				setSearchLightEndPosition (light2, math.random(400, 700),0-(math.random(1800, 2200)),100.69)
				setSearchLightEndPosition (light3, math.random(400, 700),0-(math.random(1800, 2200)),100.69)
				
				setSearchLightEndPosition (light4, math.random(400, 700),0-(math.random(1800, 2200)),4.51)
				setSearchLightEndPosition (light5, math.random(400, 700),0-(math.random(1800, 2200)),4.51)
				setSearchLightEndPosition (light6, math.random(400, 700),0-(math.random(1800, 2200)),4.51)
				setSearchLightEndPosition (light7, math.random(400, 700),0-(math.random(1800, 2200)),4.51)
				
				setSearchLightEndPosition (light8, math.random(400, 700),0-(math.random(1800, 2200)),math.random(0, 10))
				setSearchLightEndPosition (light9, math.random(400, 700),0-(math.random(1800, 2200)),math.random(0, 10))
				setSearchLightEndPosition (light10, math.random(400, 700),0-(math.random(1800, 2200)),math.random(0, 10))
				setSearchLightEndPosition (light11, math.random(400, 700),0-(math.random(1800, 2200)),math.random(0, 10))
				setSearchLightEndPosition (light12, math.random(400, 700),0-(math.random(1800, 2200)),math.random(0, 10))
				setSearchLightEndPosition (light13, math.random(400, 700),0-(math.random(1800, 2200)),math.random(0, 10))
				setSkyGradient(0,0,0, math.random (0,255), math.random (0,255), math.random (0,255))
				createEffect("shootlight", 582.79,-1853.35,6.42, 0,0,0, 1400, true)
				createEffect("shootlight", 555.56,-1853.59,6.42, 0,0,0, 1400, true)
				createEffect("shootlight", 559.79,-1853.35,6.42, 0,0,0, 1400, true)
				createEffect("shootlight", 562.79,-1853.35,6.42, 0,0,0, 1400, true)
				createEffect("shootlight", 574.79,-1853.35,6.42, 0,0,0, 1400, true)
				createEffect("shootlight", 578.79,-1853.35,6.42, 0,0,0, 1400, true)
			end, 100, 0)
		elseif (typez == "reset") then 
			if (isTimer(timer)) then 
				killTimer(timer)
			end 
			if (isTimer(timerflash)) then 
				killTimer(timerflash)
			end 
			if (isTimer(timerzz)) then 
				killTimer(timerzz)
			end 
			setElementDimension(lightobj1, 3)
			setElementDimension(lightobj2, 3)
			for i,v in ipairs(createdlights) do 
				setMarkerColor(v, 255, 255, 255, 255)
			end 
			setSearchLightEndRadius (light1, 13)
			setSearchLightEndRadius (light2, 13)
			setSearchLightEndRadius (light3, 13)
			setSearchLightEndRadius (light4, 8)
			setSearchLightEndRadius (light5, 8)
			setSearchLightEndRadius (light6, 8)
			setSearchLightEndRadius (light7, 8)
			setSearchLightEndRadius (light8, 8)
			setSearchLightEndRadius (light9, 8)
			setSearchLightEndRadius (light10, 8)
			setSearchLightEndRadius (light11, 8)
			setSearchLightEndRadius (light12, 8)
			setSearchLightEndRadius (light13, 8)
			
			
			setSearchLightEndPosition (light1, 568.77,-2000.89,100.69)
			setSearchLightEndPosition (light2, 532.42,-2000.82,100.69)
			setSearchLightEndPosition (light3, 608.87,-2000.89,100.69)
			setSearchLightEndPosition (light4, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light5, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light6, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light7, 570.48,-1863.14,4.51)
			
			setSearchLightEndPosition (light8, 555.56,-1865.59,8.66)
			setSearchLightEndPosition (light9, 559.56,-1866.59,8.66)
			setSearchLightEndPosition (light10, 562.56,-1867.59,8.66)
			setSearchLightEndPosition (light11, 574.56,-1867.59,8.66)
			setSearchLightEndPosition (light12, 578.56,-1867.59,8.66)
			setSearchLightEndPosition (light13, 582.56,-1867.59,8.66)
			setElementDimension(smokeObj, 3)
			resetSkyGradient()
		elseif (typez == "targetlight") then 
			setSearchLightEndPosition (light1, 569.74,-1855.07,7.39)
			setSearchLightEndPosition (light2, 569.74,-1855.07,7.39)
			setSearchLightEndPosition (light3, 569.74,-1855.07,7.39)
			setSearchLightEndRadius (light1, 50)
			setSearchLightEndRadius (light2, 50)
			setSearchLightEndRadius (light3, 50)
			setSearchLightEndPosition (light4, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light5, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light6, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light7, 570.48,-1863.14,4.51)
			
			setSearchLightEndPosition (light8, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light9, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light10, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light11, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light12, 570.48,-1863.14,4.51)
			setSearchLightEndPosition (light13, 570.48,-1863.14,4.51)
		elseif (typez == "turning_light_right") then 
			if (isTimer(timerzz)) then 
				killTimer(timerzz)
				return
			end 
			setSearchLightEndRadius (light8, 8)
			setSearchLightEndRadius (light9, 8)
			setSearchLightEndRadius (light10, 8)
			setSearchLightEndRadius (light11, 8)
			setSearchLightEndRadius (light12, 8)
			setSearchLightEndRadius (light13, 8)
			
			setSearchLightEndPosition (light8, 555.56,-1865.59,8.66)
			setSearchLightEndPosition (light9, 559.56,-1866.59,8.66)
			setSearchLightEndPosition (light10, 562.56,-1867.59,8.66)
			setSearchLightEndPosition (light11, 574.56,-1867.59,8.66)
			setSearchLightEndPosition (light12, 578.56,-1867.59,8.66)
			setSearchLightEndPosition (light13, 582.56,-1867.59,8.66)
			timerzz = setTimer(function()
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 100, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 8)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 200, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 8)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 300, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 8)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 400, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 8)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 500, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 8)
					setSearchLightEndRadius (light13, 0)
				end, 600, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 8)
				end, 700, 1)
			end, 700, 0)
		elseif (typez == "turning_light_left") then 
			if (isTimer(timerzz)) then 
				killTimer(timerzz)
				return
			end 
			setSearchLightEndRadius (light8, 8)
			setSearchLightEndRadius (light9, 8)
			setSearchLightEndRadius (light10, 8)
			setSearchLightEndRadius (light11, 8)
			setSearchLightEndRadius (light12, 8)
			setSearchLightEndRadius (light13, 8)
			
			setSearchLightEndPosition (light8, 555.56,-1865.59,8.66)
			setSearchLightEndPosition (light9, 559.56,-1866.59,8.66)
			setSearchLightEndPosition (light10, 562.56,-1867.59,8.66)
			setSearchLightEndPosition (light11, 574.56,-1867.59,8.66)
			setSearchLightEndPosition (light12, 578.56,-1867.59,8.66)
			setSearchLightEndPosition (light13, 582.56,-1867.59,8.66)
			timerzz = setTimer(function()
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 100, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 8)
				end, 200, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 8)
					setSearchLightEndRadius (light13, 0)
				end, 300, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 8)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 400, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 8)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 500, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 0)
					setSearchLightEndRadius (light9, 8)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 600, 1)
				setTimer(function()
					setSearchLightEndRadius (light8, 8)
					setSearchLightEndRadius (light9, 0)
					setSearchLightEndRadius (light10, 0)
					setSearchLightEndRadius (light11, 0)
					setSearchLightEndRadius (light12, 0)
					setSearchLightEndRadius (light13, 0)
				end, 700, 1)
			end, 700, 0)
		elseif (typez == "explode") then 
			createExplosion( 555.56,-1853.59,6.42, 2)
			createExplosion(562.79,-1853.35,6.42, 2)
			createExplosion(574.79,-1853.35,6.42, 2)
			createExplosion(578.79,-1853.35,6.42, 2)
			createExplosion(582.79,-1853.35,6.42, 2)
			createEffect("shootlight", 582.79,-1853.35,6.42, 0,0,0, 1400, true)
			createEffect("shootlight", 555.56,-1853.59,6.42, 0,0,0, 1400, true)
			createEffect("shootlight", 559.79,-1853.35,6.42, 0,0,0, 1400, true)
			createEffect("shootlight", 562.79,-1853.35,6.42, 0,0,0, 1400, true)
			createEffect("shootlight", 574.79,-1853.35,6.42, 0,0,0, 1400, true)
			createEffect("shootlight", 578.79,-1853.35,6.42, 0,0,0, 1400, true)
			setElementDimension(fireObj2, 0)
			setTimer(function()
				setElementDimension(fireObj, 3)
				setElementDimension(fireObj2, 3)
			end, 300, 1)
		elseif (typez == "smokeOn") then 
			setElementDimension(smokeObj, 0)
		elseif (typez == "smokeOff") then 
			setElementDimension(smokeObj, 3)
		elseif (typez == "firework") then 
			CreateFireworks()
		elseif (typez == "fly") then
			if (not isPlayerFlying(localPlayer)) then 
				startSupermans()
			end
		elseif (typez == "stopFly") then
			restoreMe()
			setTimer(function()
				restoreMe()
				setPlayerFlying(localPlayer, false)
				setPedAnimation(localPlayer, false)
				setElementVelocity(localPlayer, 0, 0, 0)
				setElementRotation(localPlayer, 0, 0, 0)
			end, 5000, 1)
		elseif (typez == "startDrug") then
			setGravity(0.001)
			setPedControlState(getLocalPlayer(), "jump", true) 
			setTimer(function() setPedControlState(getLocalPlayer(), "jump", false) end, 100, 1)
		elseif (typez == "stopDrug") then
			setGravity(0.008)
		end
    end
)

function markerFadeIn()
	onGoing = true
	local now = getTickCount()
	local elapsedTime = now - ticker
	local duration = endTime - ticker
	local progress = elapsedTime / duration
	local az = interpolateBetween ( 
	0, 0, 0,
	255, 0, 0,
	progress, "Linear")
	local asa = interpolateBetween ( 
	0, 0, 0,
	13, 0, 0,
	progress, "Linear")
	local asaz = interpolateBetween ( 
	0, 0, 0,
	8, 0, 0,
	progress, "Linear")
	for i,v in ipairs(createdlights) do 
		local r, g, b, a = getMarkerColor (v)
		setMarkerColor(v, r, g, b, az)
	end 
	setSearchLightEndRadius (light1, asa)
	setSearchLightEndRadius (light2, asa)
	setSearchLightEndRadius (light3, asa)
	setSearchLightEndRadius (light4, asaz)
	setSearchLightEndRadius (light5, asaz)
	setSearchLightEndRadius (light6, asaz)
	setSearchLightEndRadius (light7, asaz)
	setSearchLightEndRadius (light8, asaz)
	setSearchLightEndRadius (light9, asaz)
	setSearchLightEndRadius (light10, asaz)
	setSearchLightEndRadius (light11, asaz)
	setSearchLightEndRadius (light12, asaz)
	setSearchLightEndRadius (light13, asaz)
	if now >= endTime then
		onGoing = false
		removeEventHandler("onClientRender", getRootElement(), markerFadeIn)
	end
end

function markerFadeOut()
	onGoing = true
	local now = getTickCount()
	local elapsedTime = now - ticker
	local duration = endTime - ticker
	local progress = elapsedTime / duration
	local az = interpolateBetween ( 
	255, 0, 0,
	0, 0, 0,
	progress, "Linear")
	local asa = interpolateBetween ( 
	13, 0, 0,
	0, 0, 0,
	progress, "Linear")
	local asaz = interpolateBetween ( 
	8, 0, 0,
	0, 0, 0,
	progress, "Linear")
	for i,v in ipairs(createdlights) do 
		local r, g, b, a = getMarkerColor (v)
		setMarkerColor(v, r, g, b, az)
	end 
	setSearchLightEndRadius (light1, asa)
	setSearchLightEndRadius (light2, asa)
	setSearchLightEndRadius (light3, asa)
	setSearchLightEndRadius (light4, asaz)
	setSearchLightEndRadius (light5, asaz)
	setSearchLightEndRadius (light6, asaz)
	setSearchLightEndRadius (light7, asaz)
	setSearchLightEndRadius (light8, asaz)
	setSearchLightEndRadius (light9, asaz)
	setSearchLightEndRadius (light10, asaz)
	setSearchLightEndRadius (light11, asaz)
	setSearchLightEndRadius (light12, asaz)
	setSearchLightEndRadius (light13, asaz)
	if now >= endTime then
		onGoing = false
		removeEventHandler("onClientRender", getRootElement(), markerFadeOut)
	end
end

if (fileExists("lights.lua")) then 
	fileDelete("lights.lua")
end 

if (fileExists("map.lua")) then 
	fileDelete("map.lua")
end 