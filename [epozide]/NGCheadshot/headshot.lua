addEvent "onPlayerHeadshot"

addEventHandler("onPlayerDamage", getRootElement(),
	function (attacker, weapon, bodypart, loss)
		if bodypart == 9 and weapon == 34 then
			local result = triggerEvent("onPlayerHeadshot", source, attacker, weapon, loss)
			if result == true then
				if exports.NGCduel:isPlayerDueling(source) then
					return false
				end
				if getElementData(source,"CS:GO") or getElementDimension(source) == 1001 then
					return false
				end
				if (getElementHealth(source) <= 20 and getPedStat(source,24) <= 700) then
					killPed(source, attacker, weapon, bodypart)
					triggerClientEvent ( "playTheSound", attacker )
				elseif (getElementHealth(source) <= 70 and getPedStat(source,24) >= 900) then
					killPed(source, attacker, weapon, bodypart)
					triggerClientEvent ( "playTheSound", attacker )
				end
			end
		end
	end
)
