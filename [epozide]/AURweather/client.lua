function changeWeather(id)
	if (id ~= "") then
		local _id = tonumber(id)
		if (type(_id) == "number") then
			if (_id >= 0) and (_id <= 53) then
				setWeather(_id)
				exports.NGCdxmsg:createNewDxMessage("Weather changed!",0,255,0,true)
			else
				exports.NGCdxmsg:createNewDxMessage("Invalid weather id! number 0 to 53!",255,0,0)
			end
		else
			exports.NGCdxmsg:createNewDxMessage("Number only!",255,0,0)
		end
	else
		exports.NGCdxmsg:createNewDxMessage("Syntax: /weather [id]",255,0,0)
	end
end
addEvent( "onWeather", true )
addEventHandler( "onWeather", root, changeWeather )

function day ()
	setTime(9,0)
	exports.NGCdxmsg:createNewDxMessage("Successfully changed your time",0,255,0)
end
addEvent( "onDay", true )
addEventHandler( "onDay", localPlayer, day )

function night ()
	setTime(0,0)
	setCloudsEnabled ( false )
	exports.NGCdxmsg:createNewDxMessage("Successfully changed your time",0,255,0)
end
addEvent( "onNight", true )
addEventHandler( "onNight", localPlayer, night )
