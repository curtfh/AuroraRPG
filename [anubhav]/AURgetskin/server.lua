function getSkin(player)
	outputChatBox("* Your skin ID is: "..getElementModel(player), player, 255, 255, 0)
end
addCommandHandler("myskin", getSkin)