local sound
local enabled = true

addEvent("AURabmath.playTheDrop", true)
addEventHandler("AURabmath.playTheDrop", resourceRoot, 
	function (theDrop)
		if (theDrop) then
			if (isElement(sound)) then
				stopSound(sound)
			end
			if (exports.DENsettings:getPlayerSetting("quizmusic") == "Unmute") then
				sound = playSound("drops/"..theDrop..".mp3")
				setSoundVolume(sound, 0.8)
				--local time_ = getSoundLength(sound.element[source])
				timer = setTimer(function(sound) 
					if (isElement(sound)) then 
						stopSound(sound) 
					end 
				end, 20000, 1, sound)
			end
		end
	end
)

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, value )
		if setting == "quizmusic" then
			if (value == "Mute") then 
				if (isElement(sound)) then
					stopSound(sound)
				end
			end 
		end
	end
)

function toggleMusic()
	exports.NGCdxmsg:createNewDxMessage("Please use /settings > Audio > Quiz SFX and choose unmute. This command is disabled.", 255, 0, 255)
end
addCommandHandler("mutemath", toggleMusic)