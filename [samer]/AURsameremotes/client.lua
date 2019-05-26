local showWheel = false
local screenX, screenY = guiGetScreenSize()
local sX, sY = screenX / 1366, screenY / 768
local index = 1
local currEmote = "None"
local data = {}

local allEmotes = { "cometome", "orangejustice", "starpower", "takethel", "shout_01", "lkaround_loop", "infinitedab", "electroshuffle",
	"floss", "wash_up", "defaultdance", "bestmates", "eagle"}

local animToText = {
	["cometome"] = "Bring It On",
	["orangejustice"] = "Orange Justice",
	["starpower"] = "True Heart",
	["takethel"] = "Take The L",
	["shout_01"] = "Groove Jam",
	["lkaround_loop"] = "Hype",
	["infinitedab"] = "Infinite Dab",
	["electroshuffle"] = "Electro Shuffle",
	["floss"] = "Floss",
	["wash_up"] = "Fresh",
	["defaultdance"] = "Default Dance",
	["bestmates"] = "Best Mates",
	["eagle"] = "Eagle"
}

local animToImage = {
	["cometome"] = "bringiton.png",
	["orangejustice"] = "orangejustice.png",
	["starpower"] = "starpower.png",
	["takethel"] = "taketheelf.png",
	["shout_01"] = "groovejam.png",
	["lkaround_loop"] = "hype.png",
	["infinitedab"] = "infinitedab.png",
	["electroshuffle"] = "electroshuffle.png",
	["floss"] = "floss.png",
	["wash_up"] = "fresh.png",
	["defaultdance"] = "default.png",
	["bestmates"] = "bestmates.png",
	["eagle"] = "eagle.png"
}


addEventHandler("onClientRender", root, function()
	if (showWheel) then
		local cursorX, cursorY = getCursorPosition()
		local cursorX, cursorY = screenX * cursorX, screenY * cursorY
		rot = - (-90 + math.deg ( math.atan2 ( ( cursorX - (screenX / 2)-100 ), ( cursorY - screenY / 2 ) ) ) % 360)
		dxDrawCircle(screenX / 2, screenY / 2, (sY*sX*98)/sX+sY, 0, 360, tocolor(36, 37, 39, 200), tocolor(36, 37, 39, 100), 50) -- inner circle
		dxDrawCircle(screenX / 2, screenY / 2, (sY*sX*300)/sX+sY, 0, 360, tocolor(30, 37, 56, 200), tocolor(30, 37, 56, 100), 50) -- outer circle
		dxDrawImage((screenX / 2)-100, screenY / 2, 200, 14, "arrow2.png", rot, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawLine(sX*584, sY*386, sX*780, sY*386, tocolor(127, 127, 127, 255), 1, true)
		dxDrawText(currEmote, sX*602, sY*400, sX*763, sY*422, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawRectangle(sX*445, sY*23, sX*488, sY*47, tocolor(0, 0, 0, 255), true)
        dxDrawRectangle(sX*444, sY*22, sX*488, sY*47, tocolor(30, 37, 56, 200), true)
        dxDrawText("Scroll with your middle mouse button", sX*446, sY*26, sX*932, sY*69, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
		if (index == 1) then
			--Default dance
			dxDrawImage(sX*630, sY*108, sX*109, sY*125, "images/default.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
			dxDrawText("Default Dance", sX*620, sY*243, sX*761, sY*260, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			--from 1 to 5 (tab)
			if (data[1]) then
				dxDrawImage(sX*777, sY*197, sX*139, sY*134, "images/"..animToImage[data[1]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[1]], sX*791, sY*341, sX*932, sY*358, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[1]], sX*791, sY*339, sX*932, sY*356, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[1]], sX*789, sY*341, sX*930, sY*358, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[1]], sX*789, sY*339, sX*930, sY*356, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[1]], sX*790, sY*340, sX*931, sY*357, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[2]) then
				dxDrawImage(sX*820, sY*383, sX*111, sY*109, "images/"..animToImage[data[2]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[2]], sX*786, sY*503, sX*927, sY*520, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[2]], sX*786, sY*501, sX*927, sY*518, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[2]], sX*784, sY*503, sX*925, sY*520, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[2]], sX*784, sY*501, sX*925, sY*518, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[2]], sX*785, sY*502, sX*926, sY*519, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[3]) then
				dxDrawImage(sX*629, sY*492, sX*103, sX*124, "images/"..animToImage[data[3]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[3]], sX*620, sY*631, sX*761, sY*648, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[3]], sX*620, sY*629, sX*761, sY*646, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[3]], sX*618, sY*631, sX*759, sY*648, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[3]], sX*618, sY*629, sX*759, sY*646, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[3]], sX*619, sY*630, sX*760, sY*647, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[4]) then
				dxDrawImage(sX*439, sY*383, sX*109, sY*109, "images/"..animToImage[data[4]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[4]], sX*430, sY*513, sX*571, sY*530, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[4]], sX*430, sY*511, sX*571, sY*528, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[4]], sX*428, sY*513, sX*569, sY*530, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[4]], sX*428, sY*511, sX*569, sY*528, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[4]], sX*429, sY*512, sX*570, sY*529, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[5]) then
				dxDrawImage(sX*462, sY*197, sX*118, sY*134, "images/"..animToImage[data[5]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[5]], sX*443, sY*341, sX*584, sY*358, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if ((rot < -73) and (rot > -119)) then
				currEmote = "Default Dance"
			elseif ((rot < -14) and (rot > -56)) then
				if (data[1]) then
					currEmote = animToText[data[1]]
				end
			elseif ((rot < 53) and (rot > -2)) then
				if (data[2]) then
					currEmote = animToText[data[2]]
				end
			elseif not ((rot > -233) and (rot < 56)) then
				if (data[3]) then
					currEmote = animToText[data[3]]
				end
			elseif ((rot < -181) and (rot > -226)) then
				if (data[4]) then
					currEmote = animToText[data[4]]
				end
			elseif ((rot < -136) and (rot > -156)) then
				if (data[5]) then
					currEmote = animToText[data[5]]
				end
			else
				currEmote = "None"
			end
		end
		if (index == 2) then
			--from 6 to 11
			if (data[6]) then
				dxDrawImage(sX*630, sY*108, sX*109, sY*125, "images/"..animToImage[data[6]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[6]], sX*620, sY*243, sX*761, sY*260, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[7]) then
				dxDrawImage(sX*777, sY*197, sX*139, sY*134, "images/"..animToImage[data[7]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[7]], sX*791, sY*341, sX*932, sY*358, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[7]], sX*791, sY*339, sX*932, sY*356, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[7]], sX*789, sY*341, sX*930, sY*358, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[7]], sX*789, sY*339, sX*930, sY*356, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[7]], sX*790, sY*340, sX*931, sY*357, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[8]) then
				dxDrawImage(sX*820, sY*383, sX*111, sY*109, "images/"..animToImage[data[8]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[8]], sX*786, sY*503, sX*927, sY*520, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[8]], sX*786, sY*501, sX*927, sY*518, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[8]], sX*784, sY*503, sX*925, sY*520, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[8]], sX*784, sY*501, sX*925, sY*518, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[8]], sX*785, sY*502, sX*926, sY*519, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[9]) then
				dxDrawImage(sX*629, sY*492, sX*103, sX*124, "images/"..animToImage[data[9]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[9]], sX*620, sY*631, sX*761, sY*648, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[9]], sX*620, sY*629, sX*761, sY*646, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[9]], sX*618, sY*631, sX*759, sY*648, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[9]], sX*618, sY*629, sX*759, sY*646, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[9]], sX*619, sY*630, sX*760, sY*647, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[10]) then
				dxDrawImage(sX*439, sY*383, sX*109, sY*109, "images/"..animToImage[data[10]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[10]], sX*430, sY*513, sX*571, sY*530, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[10]], sX*430, sY*511, sX*571, sY*528, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[10]], sX*428, sY*513, sX*569, sY*530, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[10]], sX*428, sY*511, sX*569, sY*528, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
				dxDrawText(animToText[data[10]], sX*429, sY*512, sX*570, sY*529, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if (data[11]) then
				dxDrawImage(sX*462, sY*197, sX*118, sY*134, "images/"..animToImage[data[11]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
				dxDrawText(animToText[data[11]], sX*443, sY*341, sX*584, sY*358, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			end
			if ((rot < -73) and (rot > -119)) then
				if (data[6]) then
					currEmote = animToText[data[6]]
				end
			elseif ((rot < -14) and (rot > -56)) then
				if (data[7]) then
					currEmote = animToText[data[7]]
				end
			elseif ((rot < 53) and (rot > -2)) then
				if (data[8]) then
					currEmote = animToText[data[8]]
				end
			elseif not ((rot > -233) and (rot < 56)) then
				if (data[9]) then
					currEmote = animToText[data[9]]
				end
			elseif ((rot < -181) and (rot > -226)) then
				if (data[10]) then
					currEmote = animToText[data[10]]
				end
			elseif ((rot < -136) and (rot > -156)) then
				if (data[11]) then
					currEmote = animToText[data[11]]
				end
			else
				currEmote = "None"
			end
		end
		if (index == 3) then
			-- from 12 to 12
			dxDrawImage(sX*630, sY*108, sX*109, sY*125, "images/"..animToImage[data[12]], 0, 0, 0, tocolor(255, 255, 255, 255), true)
			dxDrawText(animToText[data[12]], sX*620, sY*243, sX*761, sY*260, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", true, true, true, false, false)
			if ((rot < -73) and (rot > -119)) then
				if (data[12]) then
					currEmote = animToText[data[12]]
				end
			else
				currEmote = "None"
			end
		end
	end
end)

addEventHandler( "onClientKey", root,
    function (btn)
		if (showWheel) then
			if (btn == "mouse_wheel_up") then
				if (index == 1) then
					if (#data < 6) then
						-- do nothing
					end
					if (#data >= 6) and (#data < 12) then
						index = 2
					end
					if (#data == 12) then
						index = 3
					end
				end
				if (index == 2) then
					index = 1
				end
				if (index == 3) then
					index = index - 1
				end
			elseif (btn == "mouse_wheel_down") then
				if (index == 3) then
					index = 1
				end
				if (index == 2) then
					if (#data < 12) then
						index = 1
					end
					if (#data == 12) then
						index = 3
					end
				end
				if (index == 1) then
					if (#data >= 6) then
						index = index + 1
					end
				end
			end
		end
    end
)

addEventHandler("onClientKey", root,
	function(btn, pressOrRelease)
		if (showWheel) then
			if (btn == "mouse1") and (pressOrRelease) then
				if (index == 1) then
					if ((rot < -73) and (rot > -119)) then
						executeCommandHandler("fortnite", "defaultdance")
						showWheel = not showWheel
						showCursor(showWheel)
						index = 1
					elseif ((rot < -14) and (rot > -56)) then
						if (data[1]) then
							executeCommandHandler("fortnite", data[1])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < 53) and (rot > -2)) then
						if (data[2]) then
							executeCommandHandler("fortnite", data[2])
							currEmote = animToText[data[2]]
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif not ((rot > -233) and (rot < 56)) then
						if (data[3]) then
							executeCommandHandler("fortnite", data[3])
							currEmote = animToText[data[3]]
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < -181) and (rot > -226)) then
						if (data[4]) then
							executeCommandHandler("fortnite", data[4])
							currEmote = animToText[data[4]]
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < -136) and (rot > -156)) then
						if (data[5]) then
							executeCommandHandler("fortnite", data[5])
							currEmote = animToText[data[5]]
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					end
				end
				if (index == 2) then
					if ((rot < -73) and (rot > -119)) then
						if (data[6]) then
							executeCommandHandler("fortnite", data[6])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < -14) and (rot > -56)) then
						if (data[7]) then
							executeCommandHandler("fortnite", data[7])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < 53) and (rot > -2)) then
						if (data[8]) then
							executeCommandHandler("fortnite", data[8])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif not ((rot > -233) and (rot < 56)) then
						if (data[9]) then
							executeCommandHandler("fortnite", data[9])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < -181) and (rot > -226)) then
						if (data[10]) then
							executeCommandHandler("fortnite", data[10])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					elseif ((rot < -136) and (rot > -156)) then
						if (data[11]) then
							executeCommandHandler("fortnite", data[11])
							showWheel = not showWheel
							showCursor(showWheel)
							index = 1
						end
					end
				end
				if (index == 3) then
					if (data[12]) then
						executeCommandHandler("fortnite", data[12])
						showWheel = not showWheel
						showCursor(showWheel)
						index = 1
					end
				end
			end
		end
	end
)

addEvent("AURemotes.showWheel", true)
addEventHandler("AURemotes.showWheel", root,
	function(tab)
		data = tab
		showWheel = not showWheel
		showCursor(showWheel)
		index = 1
end)

if (fileExists("client.lua")) then
	fileDelete("client.lua")
end