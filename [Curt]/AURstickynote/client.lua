--[[
AuroraRPG - aurorarpg.com
This resource is property of AuroraRPG.
Author: Curt
All Rights Reserved 2017
]]--
local screenW, screenH = guiGetScreenSize()

local displayOnScreen = {}
function removeHEXFromString(str) 
	return str:gsub("#%x%x%x%x%x%x", "") 
end 

--[[addEventHandler("onClientRender", root,
    function()
		local rectY = 0.9489
		local textY = 0.9567
		for i, theData in ipairs(displayOnScreen) do 
			local r, g, b = theData[4], theData[5], theData[6] or 0, 0, 0
			dxDrawRectangle(screenW * 0.2313, screenH * rectY, screenW * 0.2244, screenH * 0.0311, tocolor(r, g, b, 200), false)
			--dxDrawRectangle(screenW * 0.7256, screenH * rectY, screenW * 0.2244, screenH * 0.0311, tocolor(r, g, b, 200), false)
			--dxDrawText(theData[3], screenW * 0.7281, screenH * textY, screenW * 0.9437, screenH * 0.2011, tocolor(255, 255, 255, 255), 1.10, "default", "right", "top", true, true, false, true, false)
			dxDrawText(theData[3], screenW * 0.2350, screenH * textY, screenW * 0.4494, screenH * 0.9733, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			rectY = rectY - 0.0356
			textY = textY - 0.0361
		end 
    end
)]]--

function displayText (theID, theType, theText, r, g, b)
	for i, theData in ipairs(displayOnScreen) do 
		if (theData[1] == theID) then 
			if (theText == false) then 
				table.remove(displayOnScreen, i)
				return true
			end
			if (theText == "") then 
				table.remove(displayOnScreen, i)
				return true
			end
			if (theText == nil) then 
				table.remove(displayOnScreen, i)
				return true
			end
			displayOnScreen[i][3] = theText
			return true
		end 
	end
	if (theText == false) then return false
	end
	if (theText == "") then return false end
	if (theText == nil) then return false end
	table.insert(displayOnScreen, {theID, theType, theText, r, g, b})
	playSound("textring2.wav")
	return true
end
addEvent("AURstickynote.createTextScreen",true)
addEventHandler("AURstickynote.createTextScreen", localPlayer, displayText)


if (fileExists("client.lua")) then fileDelete("client.lua") end

local render = {}
local x = {}
addEventHandler ( "onClientRender", root, 
    function ( ) 
		local rectY = 0.9489
		local textY = 0.9567
		local textYY = 0.9367
		for i, theData in ipairs(displayOnScreen) do 
			local r, g, b = theData[4], theData[5], theData[6] or 0, 0, 0
			local minWidth = ( -dxGetTextWidth ( theData[3], 1, "default-bold" ) )
			if (minWidth <= -300) then 
				if (type(x[i]) ~= "number") then 
					x[i] = (screenW * 0.2194) + 5
				end 
				x[i] = ( x[i] <= minWidth ) and ( (screenW * 0.2194) + 5 ) or ( x[i] - 0.5 )
				dxDrawRectangle (screenW * 0.2313, screenH * rectY, screenW * 0.2244, screenH * 0.0311, tocolor(r, g, b, 200), false)
				if (not isElement(render[i])) then 
					render[i] = dxCreateRenderTarget (screenW * 0.2194, 50, true)
				end 
				dxSetRenderTarget ( render[i], true )
					dxDrawText (theData[3], x[i], 0, screenW * 0.2194, 50, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "center", false, false, false, false, false)
				dxSetRenderTarget ()
				
				dxDrawImage (screenW * 0.2350, screenH * textYY, screenW * 0.2194, screenH * 0.06, render[i]) 
			else
				dxDrawRectangle(screenW * 0.2313, screenH * rectY, screenW * 0.2244, screenH * 0.0311, tocolor(r, g, b, 200), false)
				dxDrawText(theData[3], screenW * 0.2350, screenH * textY, screenW * 0.4494, screenH * 0.9733, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
			end
			rectY = rectY - 0.0356  
			textY = textY - 0.0361
			textYY = textYY - 0.0361
		end
    end 
) 