
addEventHandler("onClientResourceStart", resourceRoot,
function()
	-- TXD
	local skin = engineLoadTXD("scar.txd", true)
	engineImportTXD(skin, 593)
	local skin = engineLoadDFF("scar.dff", 0)
	engineReplaceModel(skin, 593)
	setTimer(repl,5000,1)
end)

function repl()
	local skin = engineLoadTXD("scar.txd", true)
	engineImportTXD(skin, 593)
	local skin = engineLoadDFF("scar.dff", 0)
	engineReplaceModel(skin, 593)
end

