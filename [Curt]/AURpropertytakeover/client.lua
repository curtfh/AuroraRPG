local timerdisplay
function drawTurf(seconds)
	time = seconds
	decreaseSeconds()
	timerdisplay = setTimer(function()
		exports.AURstickynote:displayText("civilturf", "text", "Time to take over: "..time.." second/s.") 
	end, 500, 0)
end
addEvent("AURpropertytakeover.drawCounter", true)
addEventHandler("AURpropertytakeover.drawCounter", root, drawTurf)

function decreaseSeconds()
	time = time
	local function decrease()
		time = time - 1
		if (time == 0 or time < 1) then
			killTimer(timerdisplay)
			exports.AURstickynote:displayText("civilturf", "text", "")
		end
	end
	timer = setTimer(decrease, 1000, time)
end

function removeDrawing()
	killTimer(timerdisplay)
	exports.AURstickynote:displayText("civilturf", "text", "")
	if (isTimer(timer)) then
		killTimer(timer)
	end
end
addEvent("AURpropertytakeover.removeCounter", true)
addEventHandler("AURpropertytakeover.removeCounter", root, removeDrawing)
