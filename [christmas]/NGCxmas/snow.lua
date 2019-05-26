function santa(plr)
	setElementModel(plr,199)
	exports.NGCdxmsg:createNewDxMessage("Happy Christmas!",plr,0,255,0)
end
addCommandHandler("santa",santa)