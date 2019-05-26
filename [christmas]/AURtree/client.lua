local startx = -1502.2064208984
local starty = -386.91455078125
local startz = 7.078125

addEvent("playmus", true)
addEventHandler("playmus", root, function ( url )
	if ( stream ) then
		destroyElement(stream)
	end

        -- Deal with sound
	stream = playSound3D(url, startx, starty, startz, true)
	setSoundMinDistance(stream, 1)
	setSoundMaxDistance(stream, 1000)
end
end
