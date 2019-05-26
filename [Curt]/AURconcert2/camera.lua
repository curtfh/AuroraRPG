texture = createBrowser (1280, 720, true, false)
logo = dxCreateTexture("logo.png")
local isPlaying = false
setDevelopmentMode(false, true)

addEventHandler("onClientBrowserCreated", texture, 
	function()
		--toggleBrowserDevTools(texture, true)
		loadBrowserURL(texture, "http://mta/local/cef/sfx.html")
		setBrowserVolume (texture, 100)
	end
)

addEventHandler ( "onClientBrowserDocumentReady" , texture , 
	function ( url ) 
		--executeBrowserJavascript(source, "var element = document.getElementById('videoConcert'); element.currentTime = 120;")
		--outputDebugString("Success")
	end 
)



addCommandHandler("rbrowser", function()
	loadBrowserURL(texture, "http://mta/local/cef/sfx.html")
end)

function renderDXCamera()
		if (not texture) then
			texture = createBrowser (800,600, false, false)
		end

		local x, y = 569.22,-1846.97,5.04
		dxDrawMaterialLine3D(x,y,11.46,x,y,3.2, texture, 35, tocolor(255, 255, 255, 255), x, y-25, 5)
		
		local x1, y1 = 553.25,-1856.86,4.86,99
		dxDrawMaterialLine3D(x1,y1,11.46,x1,y1,3.2, texture, 20.9, tocolor(255, 255, 255, 255), x1+9000, y1-100, 5)
		
		local x2, y2 = 586.25,-1856.86,4.84,266
		dxDrawMaterialLine3D(x2,y2,11.46,x2,y2,3.2, texture, 20.9, tocolor(255, 255, 255, 255), x2+200000, y2-100, 5)
		
		local x3, y3 = 558.84,-1855.18,4.83,358
		dxDrawMaterialLine3D(x3,y3,6.4,x3,y3,3.2, texture, 13, tocolor(255, 255, 255, 255), x3, y3-25, 5)
		
		local x4, y4 = 580.56,-1855.05,5.84,358
		dxDrawMaterialLine3D(x4,y4,6.4,x4,y4,3.2, texture, 13, tocolor(255, 255, 255, 255), x4, y4-25, 5)
		
		local x5, y5 = 569.37,-1855.63,10.29,358
		dxDrawMaterialLine3D(x5,y5,10.5,x5,y5,8.5, logo, 4, tocolor(255, 255, 255, 255), x5, y5-25, 5)
		
		local x6, y6 = 569.48,-1867.51,11.29,359
		dxDrawMaterialLine3D(x6,y6,12.5,x6,y6,10.5, logo, 4, tocolor(255, 255, 255, 255), x6, y6-25, 5)
end
addEventHandler("onClientRender", root, renderDXCamera)

local triggered = false
addEvent("AURconcert2.setDuration",true)
addEventHandler( "AURconcert2.setDuration", resourceRoot, function(dur)
	if (isPlaying == true) then 
		if (triggered == false) then 
			executeBrowserJavascript(texture, "startSquence();")
			executeBrowserJavascript(texture, "var player = videojs('videoConcert');player.currentTime("..dur..");player.play();")
			triggered = true
		else
			executeBrowserJavascript(texture, "var player = videojs('videoConcert');player.currentTime("..dur..");console.log('syncing')")
		end
		setTime(23,0)
		showChat(false)
		showPlayerHudComponent("all", false)
	end 
end)

addEvent("AURconcert2.readyMusic",true)
addEventHandler( "AURconcert2.readyMusic", resourceRoot, function()
	triggerServerEvent ("AURconcert2.getDuration", resourceRoot)
	outputDebugString("Recieved Data")
	isPlaying = true
end)

bindKey ( "7", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(528.00598144531, -1948.3559570313, 19.624509811401, 570.37176513672, -1858.3046875, 9.8308115005493, 0, 70)
	end 
end )

bindKey ( "8", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(568.53637695313, -2025.6845703125, 8.606348991394, 568.01293945313, -1925.7005615234, 10.313843727112, 0, 70)
	end 
end )

bindKey ( "9", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(601.43621826172, -1906.2409667969, 13.281805992126, 531.69616699219, -1835.7459716797, 0.36755284667015, 0, 70)
	end 
end )

bindKey ( "4", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(569.86779785156, -1891.8544921875, 4.6133551597595, 566.20843505859, -1792.0390625, 9.460033416748, 0, 70)
	end 
end )

bindKey ( "5", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(502.73388671875, -2063.2954101563, 64.033294677734, 545.72308349609, -1974.3486328125, 48.528179168701, 0, 70)
	end 
end )

bindKey ( "6", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(539.86145019531, -1890.3962402344, 5.8077192306519, 622.55340576172, -1834.1766357422, 6.9917693138123, 0, 70)
	end 
end )

bindKey ( "3", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(547.74176025391, -1894.0905761719, 18.262847900391, 602.92108154297, -1818.9542236328, -17.927989959717, 0, 70)
	end 
end )

bindKey ( "2", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(570.484375, -1876.4116210938, 6.8467416763306, 565.25183105469, -1776.5493164063, 6.4603204727173, 0, 70)
	end 
end )

bindKey ( "1", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(569.53448486328, -1848.75390625, 8.1258096694946, 572.72192382813, -1948.3192138672, -0.62540376186371, 0, 70)
	end 
end )

bindKey ( "0", "down", function()
	if (getPlayerName(getLocalPlayer()) == "[AUR]Curt") then
		setCameraMatrix(631.81689453125, -2029.7716064453, 54.026168823242, 582.74987792969, -1945.7843017578, 30.819269180298, 0, 70)
	end 
end )