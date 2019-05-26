function paygarbagecleaner(pay)
 if pay == nil or pay == 0 then return end
 ---exports.CSGaccounts:addPlayerMoney(source, exports.NGCVIP:getVIPPaymentBonus(source,pay), "Street Cleaner")
 exports.AURpayments:addMoney(source,pay,"Custom","Street Cleaner",0,"AURstreetscleaner")
 end
 addEvent("paygarbagecleaner", true)addEventHandler("paygarbagecleaner", getRootElement(), paygarbagecleaner)
