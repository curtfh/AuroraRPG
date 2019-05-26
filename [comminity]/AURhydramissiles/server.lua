function toggleCOntrolss(plr, funcs, toggle )
	toggleControl(plr, "vehicle_secondary_fire", toggle)
end
addEvent("AURhydramissles.triggz", true)
addEventHandler("AURhydramissles.triggz", resourceRoot, toggleCOntrolss)