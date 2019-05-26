start = nil
intros = {
	{"LS_POLICE_DEPARTMENT", 1477.2, -1662.68, 14.55, 150, 12000, {
		{1438.751953125, -1675.2841796875, 44.631935119629, 1537.390625, -1678.3544921875, 28.474575042725, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("LS Police Department", (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("LS Police Department", (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("LS Police Department", (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("LS Police Department", (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("LS Police Department", x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText("In this introduction, you will know all the functions of the Los Santos Police Department.", (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of the Los Santos Police Department.", (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of the Los Santos Police Department.", (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of the Los Santos Police Department.", (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of the Los Santos Police Department.", x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1567.2919921875, -1628.4794921875, 16.531692504883, 1632.09375, -1698.1513671875, -14.233969688416, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("The Law Enforcement", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Law Enforcement", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Law Enforcement", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Law Enforcement", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Law Enforcement", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("As you can see, you can take police job on this location and take a look on your current job skills.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("As you can see, you can take police job on this location and take a look on your current job skills.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("As you can see, you can take police job on this location and take a look on your current job skills.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("As you can see, you can take police job on this location and take a look on your current job skills.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("As you can see, you can take police job on this location and take a look on your current job skills.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1603.9775390625, -1615.4169921875, 15.397610664368, 1513.7822265625, -1572.951171875, 7.5531783103943,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("The Police Vehicles", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("When you take the job, you can spawn police vehicles in this location.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("When you take the job, you can spawn police vehicles in this location.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("When you take the job, you can spawn police vehicles in this location.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("When you take the job, you can spawn police vehicles in this location.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("When you take the job, you can spawn police vehicles in this location.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1606.7841796875, -1673.0869140625, 6.9823718070984, 1557.693359375, -1760.107421875, 2.7955958843231,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("The Police Vehicles", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Vehicles", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("Also you can spawn police vehicles in here too.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Also you can spawn police vehicles in here too.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Also you can spawn police vehicles in here too.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Also you can spawn police vehicles in here too.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Also you can spawn police vehicles in here too.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1556.27734375, -1637.6728515625, 29.645908355713, 1614.138671875, -1717.4306640625, 12.591262817383,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("The Police Helicopter", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Helicopter", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Helicopter", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Helicopter", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Helicopter", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("And you can spawn police helicopers in this location.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("And you can spawn police helicopers in this location.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("And you can spawn police helicopers in this location.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("And you can spawn police helicopers in this location.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("And you can spawn police helicopers in this location.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1557.0224609375, -1675.435546875, 15.937558174133, 1629.63671875, -1743.013671875, 28.604515075684, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("The Police Computer", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Computer", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Computer", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Computer", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("The Police Computer", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("By pressing F5, you will see a list of wanted players and your police statistics.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("By pressing F5, you will see a list of wanted players and your police statistics.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("By pressing F5, you will see a list of wanted players and your police statistics.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("By pressing F5, you will see a list of wanted players and your police statistics.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("By pressing F5, you will see a list of wanted players and your police statistics.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1500.59765625, -1651.3974609375, 185.35412597656, 1500.640625, -1655.75, 85.448928833008, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat.", (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
	},"[AUR]Curt","05.10.17"},
	
	
	
	{"LS_ALL_SAINTS_GENERAL_HOSPITAL", 1176.88, -1323.78, 14.04, 20, 12000, {
		{1209.7802734375, -1324.7919921875, 12.730535507202, 1113.095703125, -1323.521484375, 38.234218597412, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("All Saints General Hospital", (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("All Saints General Hospital", (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("All Saints General Hospital", (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("All Saints General Hospital", (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText("All Saints General Hospital", x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText("In this introduction, you will know all the functions of All Saints  General Hospital.", (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of All Saints  General Hospital.", (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of All Saints  General Hospital.", (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of All Saints  General Hospital.", (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In this introduction, you will know all the functions of All Saints  General Hospital.", x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1185.2646484375, -1327.8388671875, 17.468894958496, 1095.2861328125, -1347.2021484375, -21.631692886353, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("You can buy medic kits, and each medic kit costs $900. To refill or gain your health type /medkit or /heal.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You can buy medic kits, and each medic kit costs $900. To refill or gain your health type /medkit or /heal.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You can buy medic kits, and each medic kit costs $900. To refill or gain your health type /medkit or /heal.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You can buy medic kits, and each medic kit costs $900. To refill or gain your health type /medkit or /heal.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You can buy medic kits, and each medic kit costs $900. To refill or gain your health type /medkit or /heal.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1182.015625, -1328.6279296875, 13.604486465454, 1093.6357421875, -1283.892578125, 27.309295654297,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("Player Respawn", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Player Respawn", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Player Respawn", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Player Respawn", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Player Respawn", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("Players can respawn here if they died and near to All Saints Hospital.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Players can respawn here if they died and near to All Saints Hospital.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Players can respawn here if they died and near to All Saints Hospital.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Players can respawn here if they died and near to All Saints Hospital.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Players can respawn here if they died and near to All Saints Hospital.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1320.033203125, -1238.548828125, 62.303344726562, 1241.05859375, -1293.25, 34.541019439697,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("Safezone", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Safezone", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Safezone", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Safezone", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Safezone", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("This entire area is safe. It means you won't get killed in here. If you see 'Protected Zone' then your safe from danger.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("This entire area is safe. It means you won't get killed in here. If you see 'Protected Zone' then your safe from danger.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("This entire area is safe. It means you won't get killed in here. If you see 'Protected Zone' then your safe from danger.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("This entire area is safe. It means you won't get killed in here. If you see 'Protected Zone' then your safe from danger.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("This entire area is safe. It means you won't get killed in here. If you see 'Protected Zone' then your safe from danger.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1185.3095703125, -1305.87890625, 13.802556037903, 1094.46484375, -1347.298828125, 8.1840944290161,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("Free Vehicles", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Free Vehicles", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Free Vehicles", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Free Vehicles", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Free Vehicles", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("In here, you can spawn free vehicles.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here, you can spawn free vehicles.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here, you can spawn free vehicles.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here, you can spawn free vehicles.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here, you can spawn free vehicles.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1182.2880859375, -1319.3447265625, 15.170969963074, 1085.798828125, -1320.2119140625, -11.079230308533,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("Paramedic Job", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Paramedic Job", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Paramedic Job", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Paramedic Job", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Paramedic Job", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("In here you can join as a Paramedic. If you become one, then you can heal players.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here you can join as a Paramedic. If you become one, then you can heal players.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here you can join as a Paramedic. If you become one, then you can heal players.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here you can join as a Paramedic. If you become one, then you can heal players.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("In here you can join as a Paramedic. If you become one, then you can heal players.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1184.529296875, -1314.7431640625, 14.973992347717, 1102.5009765625, -1365.421875, -11.540650367737,
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText("Wife", (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Wife", (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Wife", (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Wife", (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText("Wife", x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText("Only donators can only get this. Donate at aurorarpg.com.", (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Only donators can only get this. Donate at aurorarpg.com.", (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Only donators can only get this. Donate at aurorarpg.com.", (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Only donators can only get this. Donate at aurorarpg.com.", (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("Only donators can only get this. Donate at aurorarpg.com.", x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1224.6494140625, -1346.30859375, 166.15110778809, 1224.59375, -1342.478515625, 66.224487304688, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat.", (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText("You finished the introduction. To replay the introduction, type this command /tutorial. If you have further questions, visit aurorarpg.com or ask a question on support chat", x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
	},"[AUR]Curt","05.11.17"},
	
	
	{"SF_TAXI_JOB", -1771.74, 951.35, 24.74, 40, 10000, {
		{-1754.99609375, 904.8974609375, 94.077903747559, -1752.775390625, 967.5029296875, 16.131223678589, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Job location"
				local text2 = "In this introduction, you'll get more information about Taxi Job and how to work as a taxi driver."
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{-1772.6328125, 949.177734375, 26.152299880981, -1773.6591796875, 1047.1728515625, 6.255889415741, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Taxi Job"
				local text2 = "Here you'll be able to take taxi job. Once you be there, you'll get a GUI , press on employ, select skin and take it."
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{ -1764.2978515625, 952.115234375, 25.988599777222, -1666.1796875, 953.685546875, 6.7399892807007, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Taxi Vehicles"
				local text2 = "When you take the job, you'll be able to see this yellow marker, get inside it and select car of your choice."
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{-1389.3828125, 1345.654296875, 40.749099731445, -1405.4814453125, 1246.9599609375, 41.272598266602, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "End of the introduction"
				local text2 = " It's the end of the introduction, type this command /tutorial if you want to replay it. You can also visit our forums aurorarpg.com for more information! Have a nice day!"
				
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
	},"[AUR]Joseph","05.30.17"},
	
	{"LV_CRIMINAL_JOB", 1688.36, 1217.56, 10.63, 70, 8000, {
		{1747.0380859375, 1230.4072265625, 11.446182250977, 1647.3193359375, 1232.0029296875, 18.768623352051, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Criminal Job"
				local text2 = "Inside this building you will be able to go Criminal."
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1694.5390625, 1217.669921875, 11.42081451416, 1595.0732421875, 1220.6513671875, 1.5435963869095, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Criminal, Thief job and criminal skill"
				local text2 = "You will be able to take Criminal job and also Thief, then you can check on 'criminal skills' to know which one you can take depending on your score."
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1731.2587890625, 1210.02734375, 12.387774467468, 1631.484375, 1209.248046875, 5.7242932319641, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Criminal available vehicles"
				local text2 = "Once you've taken criminal job, you can go outside and enter the red blips where free vehicles are given but you can't spawn with 2+ stars"
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) - 1, (screenW * 0.4661) - 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) - 1, (screenW * 0.4661) + 1, (screenH * 0.3000) - 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) - 1, (y1 * 0.2222) + 1, (screenW * 0.4661) - 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.0854) + 1, (y1 * 0.2222) + 1, (screenW * 0.4661) + 1, (screenH * 0.3000) + 1, tocolor(0, 0, 0, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.0854, y1 * 0.2222, screenW * 0.4661, screenH * 0.3000, tocolor(237, 232, 90, 255), 3.00, "pricedown", "left", "top", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) - 1, (screenW * 0.8974) - 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) - 1, (screenW * 0.8974) + 1, (screenH * 0.6019) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) - 1, (y1 * 0.3704) + 1, (screenW * 0.8974) - 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1635) + 1, (y1 * 0.3704) + 1, (screenW * 0.8974) + 1, (screenH * 0.6019) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1635, y1 * 0.3704, screenW * 0.8974, screenH * 0.6019, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
		{1776.0361328125, 1211.9794921875, 41.248039245605, 1696.88671875, 1213.384765625, -19.852777481079, 
			function ()
				local screenW, screenH = guiGetScreenSize()
				local now = getTickCount()
				local elapsedTime = now - start
				local endTime = start + 3000
				local duration = endTime - start
				local progress = elapsedTime / duration
				local x1, y1, z1 = interpolateBetween ( -100, -100, 0, screenW, screenH, 255, progress, "InOutQuad")
				local text1 = "Ending of the Criminal job tour"
				local text2 = "The tour has ended, I hope you enjoyed it and understood everything, if you don't understand something feel free to contact a staff/supporter or ask on support chat"
				
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) - 1, (screenW * 0.6609) - 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) - 1, (screenW * 0.6609) + 1, (screenH * 0.2509) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) - 1, (y1 * 0.1731) + 1, (screenW * 0.6609) - 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, (x1 * 0.1021) + 1, (y1 * 0.1731) + 1, (screenW * 0.6609) + 1, (screenH * 0.2509) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				dxDrawText(text1, x1 * 0.1021, y1 * 0.1731, screenW * 0.6609, screenH * 0.2509, tocolor(66, 134, 244, 255), screenH*0.003, "pricedown", "center", "center", false, true, false, false, false)
				
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) - 1, (screenW * 0.8651) - 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) - 1, (screenW * 0.8651) + 1, (screenH * 0.5417) - 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) - 1, (y1 * 0.2833) + 1, (screenW * 0.8651) - 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, (x1 * 0.1542) + 1, (y1 * 0.2833) + 1, (screenW * 0.8651) + 1, (screenH * 0.5417) + 1, tocolor(0, 0, 0, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				dxDrawText(text2, x1 * 0.1542, y1 * 0.2833, screenW * 0.8651, screenH * 0.5417, tocolor(163, 139, 140, 255), screenH*0.003, "pricedown", "center", "top", false, true, false, false, false)
				showPlayerHudComponent ("radar", false)
			end
		},
	},"Jady","05.11.17"},
	
	
}
