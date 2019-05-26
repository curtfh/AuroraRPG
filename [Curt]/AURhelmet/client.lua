function getDataFromSettings ()
	setElementData(localPlayer, "DENsettings.helmetenabled", exports.DENsettings:getPlayerSetting("helmetenabled"))
end 
addEvent("AURhelmet.getDataFromSettings", true)
addEventHandler("AURhelmet.getDataFromSettings", localPlayer, getDataFromSettings)