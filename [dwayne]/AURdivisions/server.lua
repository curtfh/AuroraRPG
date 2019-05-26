spam = {}

addEvent("finishCase", true)
addEventHandler("finishCase", root,
function ()
	if isTimer(spam[source]) then return false end
	spam[source] = setTimer(function() end,5000,1)
	local rank = getElementData(source,"Rank")
	if rank == "Commander" then
		money = 10000
	elseif rank == "Captain" then
		money = 8000
	elseif rank == "Lieutenant" then
		money = 6000
	elseif rank == "Sergeant" then
		money = 4000
	else
		money = 2000
	end
	exports.NGCdxmsg:createNewDxMessage(source, "[Criminal invistigation] : You earned $"..(money) .." because you have solved the case", 0, 100, 200)
	exports.AURpayments:addMoney(source,money,"Custom","Misc",0,"AURdivisions")
end)
