addEvent("farmerdrugs", true)
addEventHandler("farmerdrugs", root,
    function (drugstype)
		if getElementDimension(source) == 0 then
		local wanted = getElementData(source, "wantedPoints")
		amount = math.random(40,100)
		exports.CSGdrugs:giveDrug(source, drugstype, amount)
		exports.server:givePlayerWantedPoints(source, 25)
		exports.NGCdxmsg:createNewDxMessage(source, "You earned "..amount.." hits of "..drugstype..".", 0, 255, 0)
		exports.AURcriminalp:giveCriminalPoints(source, "BankATMRob", 4)
		end
	end
)
