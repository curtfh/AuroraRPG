local info = dxGetStatus()
setElementData(localPlayer, "AURBenchmark.gpu", info["VideoCardName"])
setElementData(localPlayer, "AURBenchmark.vram", info["VideoCardRAM"])
