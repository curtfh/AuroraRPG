
addEventHandler("onClientResourceStart", resourceRoot,
function()
	-- TXD
	local txd = engineLoadTXD("giftbox.txd")
	engineImportTXD(txd, 2034)
	-- COL
	local col = engineLoadCOL("giftbox.col")
	engineReplaceCOL(col, 2034)
	-- DFF
	local dff = engineLoadDFF("giftbox.dff", 0)
	engineReplaceModel(dff, 2034)
	engineSetModelLODDistance(2034, 500)
	local skin = engineLoadTXD("santa.txd", true)
	engineImportTXD(skin, 89)
	local skin = engineLoadDFF("santa.dff", 0)
	engineReplaceModel(skin, 89)
	setTimer(repl,5000,1)
end)

function repl()
	local txd = engineLoadTXD("giftbox.txd")
	engineImportTXD(txd, 2034)
	-- COL
	local col = engineLoadCOL("giftbox.col")
	engineReplaceCOL(col, 2034)
	-- DFF
	local dff = engineLoadDFF("giftbox.dff", 0)
	engineReplaceModel(dff, 2034)
	engineSetModelLODDistance(2034, 500)
	local skin = engineLoadTXD("santa.txd", true)
	engineImportTXD(skin, 89)
	local skin = engineLoadDFF("santa.dff", 0)
	engineReplaceModel(skin, 89)
end

