addEvent("dmgProofFix",true)
addEventHandler("dmgProofFix",localPlayer,function(v)
	setVehicleDamageProof(v,false)
	setTimer(function()
		setVehicleDamageProof(v,false)
	end,1000,5)
end)

exports.AURcriminalskill:createCriminalSkill(  983.77, 1473.54, -14, 178.27020263672 )