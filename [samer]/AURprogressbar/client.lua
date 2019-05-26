local progressBars = {}
local sx, sy = guiGetScreenSize()
local sx = sx/1366
local sy = sy/768
local x = 0
local start = {}

function drawProgressBar(progress_id, progress_time, progress_r, progress_g, progress_b, progress_reverse)
	progress_reverse = progress_reverse or false
	progress_id = progress_id or "null"
	progress_time = progress_time or 5000
	local tr, tg, tb = getTeamColor(getPlayerTeam(localPlayer))
	progress_r, progress_g, progress_b = progress_r or tr, progress_g or tg, progress_b or tb
	progressBars[x] = {id = progress_id, time = progress_time, no = x, color = {progress_r, progress_g, progress_b}, tp = progress_reverse}
	start[x] = getTickCount()
	x = x + 1
	return x - 1
end
addEvent("AURprogressbar.drawProgressBar", true)
addEventHandler("AURprogressbar.drawProgressBar", resourceRoot, drawProgressBar)

addEventHandler("onClientRender", root, function()
	   	for k, v in pairs(progressBars) do
	   		if #progressBars >= 0 then
	   			local now = {}
	   			local seconds = {}
	   			local color = {}
	   			local with = {}
	   			local text = {}
	   			local colorTable = {}
	   			colorTable[k] = {255, 255, 255}
	   			now[k] = getTickCount()
			    seconds[k] = v.time
				color[k] = v.color or tocolor(0,0,0,170)
				if v.tp == true then
					with[k] = interpolateBetween(826,0,0,0,0,0, (now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]), "Linear")
			    	text[k] = interpolateBetween(100,0,0,0,0,0,(now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]),"Linear")
				else
					with[k] = interpolateBetween(0,0,0,826,0,0, (now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]), "Linear")
			    	text[k] = interpolateBetween(0,0,0,100,0,0,(now[k] - start[k]) / ((start[k] + seconds[k]) - start[k]),"Linear")
				end
			    if (v.color[1] > 200 and v.color[2] > 200 and v.color[3] > 200) then colorTable[k] = {0, 0, 0} end
				dxDrawRectangle(sx*279, sy*303, sx*841, sy*60, tocolor(0, 0, 0, 183), false)
				dxDrawRectangle(sx*284, sy*309, sx*with[k], sy*44, tocolor(v.color[1], v.color[2], v.color[3], 255), false)
				dxDrawText( v.id .. ": " .. math.floor(text[k], 2) .."%", sx*284 + 1, sy*309 + 1, sx*1110 + 1, sy*353 + 1, tocolor(0, 0, 0, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
				dxDrawText( v.id .. ": " .. math.floor(text[k], 2) .."%", sx*284, sy*309, sx*1110, sy*353, tocolor(colorTable[k][1], colorTable[k][2], colorTable[k][3], 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
	    		if now[k] > start[k] + v.time then
	    			progressBars[k] = nil
	    			x = x - 1
				end
	   		end
	   	end
end)

function destroyProgressBar(id)
	if progressBars[id] == nil then return false end
	progressBars[id] = nil
	x = x - 1
end