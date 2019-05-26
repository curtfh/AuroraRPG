function nix(playerSource)
if (exports.server:getPlayerAccountName(source) ~= "ortega") then
if (getPlayerSkin(playerSource) == 304) then
exports.NGCdxmsg:createNewDxMessage(playerSource,"You are already a Super Nixy Girl, Do you want to be fucked or what?",255,0,0)
else
setPlayerSkin(playerSource, 304)
exports.NGCdxmsg:createNewDxMessage(playerSource,"You are now Super Nixy girl!",255,0,220)
  end
 end
end
addCommandHandler("nix", nix)