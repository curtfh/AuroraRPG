--[[
dt1 = exports.customblips:createCustomBlip(99999,99999,16,16,"0.png",1)
dt2 = exports.customblips:createCustomBlip(99999,99999,16,16,"1.png",1)
exports.customblips:setCustomBlipVisible(dt1,false)
exports.customblips:setCustomBlipVisible(dt2,false)

addEvent("drawDTblip1",true)
addEventHandler("drawDTblip1",root,function(x,y)
	exports.customblips:setCustomBlipPosition(dt1,x,y)
	exports.customblips:setCustomBlipStreamRadius(dt1,5000)
	exports.customblips:setCustomBlipVisible(dt1,true)
end)

addEvent("drawDTblip2",true)
addEventHandler("drawDTblip2",root,function(x,y)
	exports.customblips:setCustomBlipPosition(dt2,x,y)
	exports.customblips:setCustomBlipStreamRadius(dt2,5000)
	exports.customblips:setCustomBlipVisible(dt2,true)
end)

addEvent("redrawDTblip",true)
addEventHandler("redrawDTblip",root,function()


	exports.customblips:setCustomBlipVisible(dt1,false)
	exports.customblips:setCustomBlipVisible(dt2,false)
	exports.customblips:setCustomBlipStreamRadius(dt1,1)
	exports.customblips:setCustomBlipStreamRadius(dt2,1)
end)


]]
