local taserAntiSpam = {}
local taserAssists = {}

function getPlayerTaserAssister(plr)
	if (not taserAssists[plr] or not isElement(taserAssists[plr]) or taserAssists[plr].type ~= "player") then return false end
	return taserAssists[plr] or false
end

function clearPlayerTaserAssists(plr)
	taserAssists[plr] = nil
	return true
end

addEvent("onPlayerTased", true)
addEventHandler("onPlayerTased", root,
	function (cop)
		if (taserAntiSpam[source] and (getTickCount() - taserAntiSpam[source]) < 3250) then return end
		if (exports.CSGnewturfing2:isPlayerInRT(source)) then return end
		source:setAnimation("CRACK", "crckidle2")
		source:setData("tased", true)
		cop.weaponSlot = 1
		Timer(
			function (source)
				if (isElement(source)) then
					source:setAnimation()
					source:removeData("tased")
					taserAntiSpam[source] = getTickCount()
				end
			end, 2250, 1, source
		)
		taserAssists[source] = cop
	end
)

setWeaponProperty("silenced", "pro", "maximum_clip_ammo", 7)
setWeaponProperty("silenced", "std", "maximum_clip_ammo", 5)
setWeaponProperty("silenced", "poor", "maximum_clip_ammo", 3)