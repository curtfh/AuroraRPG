function listAllPlayers (player)
	outputChatBox("-- AuroraRPG Benchmark -- List Player's GPU --", player)
	for theKey,thePlayer in ipairs(getElementsByType("player")) do
		outputChatBox(getPlayerName(thePlayer).." - "..getElementData(thePlayer, "AURBenchmark.gpu").." ("..getElementData(thePlayer, "AURBenchmark.vram").."MB)", player)
	end 
	outputChatBox("-- AuroraRPG Benchmark -- End of Line --", player)
end 
addCommandHandler("listspecs", listAllPlayers)