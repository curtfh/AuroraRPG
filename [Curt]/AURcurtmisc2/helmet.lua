function hetlmetTest (plr)
	local obj = createObject(2054, 0,0,-10 )
	setObjectScale(obj,1)
	exports.bone_attach:attachElementToBone(obj,plr,1,-0.0050,0.025,0.125,0,4,180)
end 
addCommandHandler("heltest", hetlmetTest)