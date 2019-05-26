function onResourceStart()
    txd = engineLoadTXD("presents.txd")
    engineImportTXD(txd, 1339)
    
    dff = engineLoadDFF("presents.dff", 1339)
    engineReplaceModel(dff, 1339)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart)
