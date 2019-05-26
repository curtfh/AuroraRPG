

function cclient()
for ind,plr in ipairs(getElementsByType("player")) do
setElementData(plr,"c",getPlayerMoney(plr))
end
end
setTimer(cclient,100,0)