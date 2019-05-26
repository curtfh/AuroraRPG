local startx = 112
local starty = 1026
local startz = 14
local screenStartX = guiGetScreenSize()
local SPECWIDTH = screenStartX
local screenStartX = screenStartX * 0
local SPECHEIGHT = (SPECWIDTH / 16) * 7  -- height (changing requires palette adjustments too)
local screenStartY = SPECHEIGHT / 2
local BANDS = 40
local use_dx = true
local screenWidth, screenHeight = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()
local marker = {}
local pmarker = {}
local markertbl = {
	{221.6, -1856.77, 13.76},
	{230.84, -1856.94, 13.76},
	{223.73, -1861.99, 4.99},
	{228.84, -1861.94, 4.96},
	{252.2, -1856.9, 13.76},
	{200.5, -1856.83, 13.76},
	{217.53, -1834.23, 4.69},
	{235.21, -1834.28, 4.69},
	{239.61, -1850.39, 4.69},
	{ 213.5, -1850.36, 4.69},
}
local pmarkertbl = {
	{223.38, -1842.46, 3.69},
	{223.38, -1845.6, 3.69},
	{228.16, -1845.75, 3.69},
	{228.16, -1842.32, 3.69},
	{232.58, -1842.22, 3.69},
	{232.82, -1845.44, 3.69},
	{232.82, -1839.44, 3.69},
	{228.16, -1839.19, 3.69},
	{223.38, -1839.12, 3.69},
}

function loadDat()
	for index, markers in pairs(markertbl) do
		marker[index] = createMarker(markers[1], markers[2], markers[3]-1, "corona", 2, 255, 255, 255, 255)
		theTimer = setTimer(function() setMarkerColor(marker[index], math.random(0,255), math.random(0,255), math.random(0,255)) end, 500, 0)
	end
	for index_, markers_ in pairs(pmarkertbl) do
		pmarker[index_] = createMarker(markers_[1], markers_[2], markers_[3]-1, "corona", 4, 255, 255, 255, 255)
		theTimer = setTimer(function() setMarkerColor(pmarker[index_], math.random(0,255), math.random(0,255), math.random(0,255)) end, 300, 0)
	end
end
addEventHandler("onClientResourceStart", root, loadDat)

function loadDJPanel()
	windowWidth, windowHeight = 526, 252
	windowX, windowY = (screenWidth / 2) - (windowWidth / 2), (screenHeight / 2) - (windowHeight / 2)
	djmain_window = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "NGC DJ Center", false)
	guiWindowSetSizable(djmain_window, false)
	guiSetAlpha(djmain_window, 1.00)
	guiSetVisible(djmain_window, false)

	djmain_labelx = guiCreateLabel(15, 27, 496, 35, "Aurora ~ DJ Center", false, djmain_window)
	djmain_labely = guiCreateLabel(15, 104, 496, 35, "Enter a valid URL to play", false, djmain_window)
	djmain_labelr = guiCreateLabel(16, 178, 117, 25, "Red", false, djmain_window)
	djmain_labelg = guiCreateLabel(145, 178, 117, 25, "Green", false, djmain_window)
	djmain_labelb = guiCreateLabel(272, 178, 117, 25, "Blue", false, djmain_window)
	
	djmain_pmusic = guiCreateButton(9, 208, 129, 39, "Play Music", false, djmain_window)
	djmain_smusic = guiCreateButton(143, 208, 129, 39, "Stop Music", false, djmain_window)
	djmain_close = guiCreateButton(382, 208, 129, 38, "Close Panel", false, djmain_window)
	djmain_sdefault = guiCreateButton(395, 140, 116, 35, "Default", false, djmain_window)
	
	djmain_urledit = guiCreateEdit(9, 69, 502, 35, "", false, djmain_window)
	djmain_editr = guiCreateEdit(16, 139, 117, 36, "", false, djmain_window)
	djmain_editg = guiCreateEdit(145, 139, 117, 36, "", false, djmain_window)
	djmain_editb = guiCreateEdit(272, 139, 117, 36, "", false, djmain_window)
	
	guiLabelSetHorizontalAlign(djmain_labelx, "center", false)
	guiLabelSetHorizontalAlign(djmain_labelr, "center", false)
	guiLabelSetHorizontalAlign(djmain_labelg, "center", false)
	guiLabelSetHorizontalAlign(djmain_labelb, "center", false)
	
	guiLabelSetColor(djmain_labelx, 254, 126, 0)
	guiLabelSetColor(djmain_labely, 254, 126, 0)
	guiLabelSetColor(djmain_labelr, 254, 0, 0)
	guiLabelSetColor(djmain_labelg, 6, 247, 12)
	guiLabelSetColor(djmain_labelb, 11, 92, 241)
	
	guiLabelSetVerticalAlign(djmain_labelx, "center")
	guiLabelSetVerticalAlign(djmain_labely, "center")
	guiLabelSetVerticalAlign(djmain_labelr, "center")
	guiLabelSetVerticalAlign(djmain_labelg, "center")
	guiLabelSetVerticalAlign(djmain_labelb, "center")
	
	guiSetProperty(djmain_pmusic, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(djmain_smusic, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(djmain_close, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(djmain_sdefault, "NormalTextColour", "FFAAAAAA")   

	guiSetFont(djmain_labelx, "clear-normal")
	guiSetFont(djmain_labely, "default-bold-small")
	guiSetFont(djmain_pmusic, "default-bold-small")
	guiSetFont(djmain_smusic, "default-bold-small")
	guiSetFont(djmain_close, "default-bold-small")
	guiSetFont(djmain_labelr, "clear-normal")
	guiSetFont(djmain_labelg, "clear-normal")
	guiSetFont(djmain_labelb, "clear-normal")
	guiSetFont(djmain_sdefault, "default-bold-small")
	
	centerWindow(djmain_window)
	
	addEventHandler("onClientGUIClick", djmain_close, function()if(source==djmain_close)then guiSetVisible(djmain_window, false) showCursor(false)end end)
	addEventHandler("onClientGUIClick", djmain_pmusic, function()if(source==djmain_pmusic)then init_pmusic() end end)
	addEventHandler("onClientGUIClick", djmain_smusic, function()if(source==djmain_smusic)then init_smusic() end end)
end
addEventHandler("onClientResourceStart", resourceRoot, loadDJPanel)

function centerWindow(center_window)
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

function init_pmusic()
	if (source == djmain_pmusic) then
		if (isElement(djmain_urledit)) then
			local urldat = guiGetText(djmain_urledit) or nil
			if (urldat == "" or nil) then outputChatBox("Please enter a link to play!.", 255, 0, 0) return end
			triggerServerEvent("NGCconcert.startmusic", root, urldat, localPlayer)
			mstate = "Started"
		end
	end
end

function init_smusic()
	if (source == djmain_smusic) then
		if (stream and isElement(stream)) then
			triggerServerEvent("NGCconcert.initstopmusic", root)
			mstate = "Stopped"
			reset()
		end
	end
end

function stopmusic()
	destroyElement(stream)
	removeEventHandler("onClientRender", root, init_render)
	reset()
end
addEvent("NGCconcert.stopmusic", true)
addEventHandler("NGCconcert.stopmusic", root, stopmusic)

function handlePanel()
	if (not getPlayerTeam(localPlayer) == getTeamFromName("Staff")) then return end
	if (not guiGetVisible(djmain_window)) then
		guiSetVisible(djmain_window, true)
		showCursor(not isCursorShowing(), true)
	else
		guiSetVisible(djmain_window, false)
		showCursor(false)
	end
end
addCommandHandler("openixon02", handlePanel)

local peakData, ticks, maxbpm, startTime, release, peak, peaks
function reset ( )
	peaks = {}
	for k=0, BANDS - 1 do
		peaks[k] = {}
	end
	peakData = {}
	ticks = getTickCount()
	maxbpm = 1
	bpmcount = 1
	startTime = 0
	release = { }
	peak = 0
end

addEvent("NGCconcert.playmus", true)
addEventHandler("NGCconcert.playmus", root, function ( url, plr )
	if ( stream and isElement(stream) ) then
		destroyElement(stream)
	end
	player = plr
        -- Deal with sound
	stream = playSound3D(url, startx, starty, startz, true)
	setSoundMinDistance(stream, 1)
	setSoundMaxDistance(stream, 10000)
	setTimer(setSoundPanningEnabled, 1000, 1, stream, false)
	startTicks = getTickCount()
	ticks = getTickCount()
	reset ( )
	-- Deal with shaders

	-- Create shader
	shader_cinema, tec = dxCreateShader ( "texreptransform.fx" )
	if not shader_cinema then return end
	-- If the image is too bright, you can darken it
	-- If the image is too bright, you can darken it
	dxSetShaderValue ( shader_cinema, "gBrighten", -0.15 )
	-- Set the angle, grayscaled, rgb
	local radian=math.rad(0)
	dxSetShaderValue ( shader_cinema, "gRotAngle", radian )
	dxSetShaderValue ( shader_cinema, "gGrayScale", 0 )
	dxSetShaderValue ( shader_cinema, "gRedColor", 0 )
	dxSetShaderValue ( shader_cinema, "gGrnColor", 0 )
	dxSetShaderValue ( shader_cinema, "gBluColor", 0 )
	-- Set image alpha (1 max)
	dxSetShaderValue ( shader_cinema, "gAlpha", 1 )
	-- Set scrolling (san set negative and positive values)
	dxSetShaderValue ( shader_cinema, "gScrRig",  0)
       	dxSetShaderValue ( shader_cinema, "gScrDow", 0)
	-- Scale and offset (don't need to change that)
        dxSetShaderValue ( shader_cinema, "gHScale", 1 )
	dxSetShaderValue ( shader_cinema, "gVScale", 1 )
	dxSetShaderValue ( shader_cinema, "gHOffset", 0 )
	dxSetShaderValue ( shader_cinema, "gVOffset", 0 ) 
	if not shader_cinema then
		outputChatBox( "Could not create shader. Please use debugscript 3" )
		return
	else
                -- new render target slightly bigger
		tar = dxCreateRenderTarget ( SPECWIDTH, SPECHEIGHT )
		-- reduce our width
		SPECWIDTH = SPECWIDTH - 6
		-- Apply our shader to the drvin_screen texture
		engineApplyShaderToWorldTexture ( shader_cinema, "drvin_screen" )
	end
	--if (handled == true) then
		--simply do nothing. xD.. cause it's already being handled, we don't have to do anything.
	--else
	--	handled = true
		addEventHandler("onClientRender", root, init_render) 
	--end
	
end)
function init_render ( )
                -- Get 2048 / 2 samples and return BANDS bars ( still needs scaling up )
		local fftData = getSoundFFTData(stream, 2048, BANDS)
		-- get our screen size
		local w, h = guiGetScreenSize()
		-- if fftData is false it hasn't loaded
		if ( fftData == false ) then
			--dxDrawText("Stream not loaded yet.", w-300, h-150)
			return
		end
		-- Draw a nice now playing thingy
		if ( getSoundMetaTags(stream).stream_name ~= nil ) then
			--local len = string.len(getSoundMetaTags(stream).stream_name)
			--dxDrawText("Now Playing: " .. getSoundMetaTags(stream).stream_name, w-(270+(len*2.8)), h-150)
		else
			--dxDrawText("Now Playing: -", w-(270), h-150)
		end
		-- Calculate our bars by the fft data
		calc ( fftData, stream )
	end
-- Util stuff
function timetostring ( input, input2 )
	local minutes = input / 60
	local seconds = input % 60
	local minutes2 = input2 / 60
	local seconds2 = input2 % 60
	return string.format("%2.2i:%2.2i", minutes2, seconds2)
end
function avg ( num )
	return maxbpm / bpmcount
end
function avg2 ( num1, num2, num )
	return (num1+num2)/num
end
function round(num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end
function getAverageBPM ( )
	return maxbpm / bpmcount
end
function min ( num1, num2 ) 
	return num1 <= num2 and num1 or num2
end
function max ( num1, num2 ) 
	return num1 >= num2 and num1 or num2
end
function calc ( fft, stream )
	-- Render to a render target and clear it
	dxSetRenderTarget( tar, true )

	-- Set a random seed
	math.randomseed ( getTickCount ( ) )
	-- Get our "Average" bpm
	local bpm = getSoundBPM ( stream )

	if ( bpm == false or bpm == nil or bpm == 0  ) then
		bpm = 1
	end

	local calced = {}
	local y = 0
	local bC=0
	local specbuf = 0
	local w, h = guiGetScreenSize()

	local r,g,b = 0,0,0
	local var = bpm + 37

	-- use bpm to determine r,g,b though there are better ways of doing this.
	if ( var <= 56 ) then
		r,g,b = math.random(100,255), 184, math.random(100,255)--[[99, 184, 255]]
	end
	if ( var >= 57 and var < 83 ) then
		r,g,b = math.random(100,255), 184, math.random(100,255)--[[238, 174, 238]]
	end
	if ( var >= 83 and var < 146 ) then
		r,g,b = math.random(100,255), 184, math.random(100,255)--[[238, 174, 238]]
	end

	if ( var >= 146 and var < 166 ) then
		r,g,b = math.random(100,255), 184, math.random(100,255)--[[99, 184, 255]]
	end
	if ( var > 166 and var <= 200 ) then
		r,g,b = math.random(100,255), 184, math.random(100,255)--[[238, 201, 0]]
	end

	if ( var >= 200 ) then
		r,g,b = var, 0, 0
	end

	local tags = getSoundMetaTags(stream)
	local bSpawnParticles = true
	if ( bpm <= 1 and getSoundBPM ( stream ) == false and getSoundPosition ( stream ) <= 20 ) then
		r,g,b = 255, 255, 255
		dxDrawImage ( 0, 00, SPECWIDTH, SPECHEIGHT+100, "bg.png", 0, 0,0, tocolor(r, g, b, 255), false )
		dxDrawText(string.format("Gathering data...", bpm), screenStartX+10, screenStartY-30, screenStartX+10, screenStartY-30, tocolor(255, 255, 255, 255 ), 1.5, "arial")
		bSpawnParticles = false
	else
		-- always make this bigger because when you tint it the image will look smaller.
		local var = 600
		local var2 = 400
		--dxDrawImage ( -var2, -var, SPECWIDTH+(var2*2), SPECHEIGHT+(var*2)+100, "bg.png", 0, 0,0, tocolor(r, g, b, 255) )
		dxDrawImage ( 0, 00, SPECWIDTH, SPECHEIGHT+100, "bg.png", 0, 0,0, tocolor(r, g, b, 255), false )
	end
	local movespeed = (1 * (bpm / 180)) + 1
	local dir = bpm <= 100 and "down" or "up"
	local prevcalced = calced
        -- loop all the bands.
	for x, peak in ipairs(fft) do
		local posx = x - 1
		-- fft contains our precalculated data so just grab it.
		peak = fft [ x ]
		y=math.sqrt(peak)*3*(SPECHEIGHT-4); -- scale it (sqrt to make low values more visible)

		if (y > 200+SPECHEIGHT) then
			y=SPECHEIGHT+200
		end -- cap it
		calced[x] = y

		y = y - 1
		if ( y >= -1 ) then
			dxDrawRectangle((posx*(SPECWIDTH/BANDS))+10+screenStartX, screenStartY, 10, max((y+1)/4, 1), tocolor(r, g, b, 255 ))
		end
		if ( bSpawnParticles == true ) then
			for key = 0, 40 do
				if ( peaks[x][key] == nil ) then
					if ( #peaks[x] <= 20 and prevcalced[x] <= calced[x] and ( release[x] == true or release[x] == nil ) and y > 1 ) then
						local rnd = math.random(0, 0)
						peaks[x][key] = {}
						if ( dir == "up" ) then
							peaks[x][key]["pos"] = screenStartY
						else
							peaks[x][key]["pos"] = screenStartY+((y+1)/4)
						end
						peaks[x][key]["posx"] = (posx*(SPECWIDTH/BANDS))+12+screenStartX+(2-key)
						peaks[x][key]["alpha"] = 128
						peaks[x][key]["dirx"] = 0
						release[x] = false
						setTimer(function ( ) release[x] = true end, 100, 1)
					end
				else
					if ( bpm > 0 ) then
						local maxScreenPos = 290
						local AlphaMulti = 255 / maxScreenPos
						value = peaks[x][key]
						if ( value ~= nil ) then
							local sX = value.posx
							dxDrawRectangle( value.posx, value.pos, 2, 2, tocolor(r, g, b, value.alpha))
							value.pos = dir == "down" and value.pos + movespeed or value.pos - movespeed
							value.posx = value.posx + (movespeed <= 2 and math.random(-movespeed,movespeed) or math.random(-1, 1))
							value.alpha = value.alpha - (AlphaMulti) - math.random(1, 4)
							
							if ( value.alpha <= 0 ) then
								peaks[x][key] = nil
							end
						end
					end
				end
			end
		end
	end
	if ( bSpawnParticles == true ) then
		dxDrawText(string.format((tags.artist ~= nil and tags.artist .. ", " or "") .."BPM: %i", bpm), screenStartX+10, screenStartY-30, screenStartX+20, screenStartY-30, tocolor(255, 255, 255, 255 ), 1.5, "arial")
	end
	local pelement = "Requested by: "..tostring(player) or "N/A"
	local mstate = mstate or "Started"
	dxDrawText(pelement.." ("..(mstate)..")", screenStartX+10, screenStartY-90, screenStartX+10, screenStartY-60, tocolor(255, 255, 255, 255 ), 2, "arial")
	dxDrawText(tags.title or tags.stream_name or "Unknown", screenStartX+10, screenStartY-60, screenStartX+10, screenStartY-60, tocolor(255, 255, 255, 255 ), 2, "arial")
	dxDrawText(timetostring(getSoundLength(stream), getSoundPosition(stream)), SPECWIDTH-50, screenStartY-40, SPECWIDTH-80, screenStartY-40, tocolor(255, 255, 255, 255 ), 1.5, "arial")

	dxSetRenderTarget()
	dxSetShaderValue ( shader_cinema, "gTexture", tar )
end