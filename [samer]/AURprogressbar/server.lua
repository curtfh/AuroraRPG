function drawProgressBar(player, text, time, r, g, b, reverse)
	player = player or root
	triggerClientEvent(player, "AURprogressbar.drawProgressBar", resourceRoot, text, time, r, g, b, reverse)
	return true
end