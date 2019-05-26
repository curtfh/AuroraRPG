
lp = getLocalPlayer()
rRoot = getResourceRootElement(getThisResource())
---
function showTransWin()
	guiSetVisible(TransWindow,true)
	showCursor(true)
	guiBringToFront(TransWindow)
end
addEvent("showTransWin",true)
addEventHandler("showTransWin",root,showTransWin)

function startDriverMission()
	triggerServerEvent("startDriverMission",lp,lp)
end

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

function closeWindow()
		guiSetVisible(TransWindow,false)
		showCursor(false)
end

function missionDone(won)
	if won == true then
		missionDone = playSound("missionDone.mp3")
	else
		missionFail = playSound("fail.mp3")
	end
end
addEvent("missionDone",true)
addEventHandler("missionDone",root,missionDone)

addEventHandler("onClientResourceStart",rRoot,function()
	triggerServerEvent("requestDx",lp,lp)
	--
	TransWindow = guiCreateWindow(346, 191, 613, 336,"Driver Mission",false)
	guiSetVisible(TransWindow,false)
	
        tabpanel1 = guiCreateTabPanel(11, 28, 592, 296, false, TransWindow)

        tab1 = guiCreateTab("AuroraRPG driver mission", tabpanel1)
		image1 = guiCreateStaticImage(20, 6, 72, 91, ":AURTransporter/driver.png", false, tab1)
        image2 = guiCreateStaticImage(173, 10, 270, 81, ":AURTransporter/proxys.png", false, tab1)
	TransMemo = guiCreateMemo(10, 107, 578, 112, "Driving Mission which makes you able to transport a ped to the \"D\" blip and you'll get reward from that. Your limit time is 5minutes, so  don't be late. And this missions starts each 10minutes and for each ride you make you'll get 50k.", false, tab1)
	TransLabel = guiCreateLabel(41,175,168,18,"Do You Accept The Mission ?",false,tab1)
	TransButtonYes = guiCreateButton(92, 226, 95, 35, "I accept this mission",false,tab1)
	 guiSetFont(TransButtonYes, "clear-normal")
        guiSetProperty(TransButtonYes, "NormalTextColour", "FF24F707")
	TransButtonNo = guiCreateButton(364, 226, 95, 35, "I refuse this mission",false,tab1)
	guiSetFont(TransButtonNo, "clear-normal")
        guiSetProperty(TransButtonNo, "NormalTextColour", "FFFC0113") 
	if TransWindow then
		guiWindowSetSizable	(TransWindow,false)
		guiWindowSetMovable	(TransWindow,false)
		centerWindow(TransWindow)
		--
		addEventHandler("onClientGUIClick",root,function()
			if source == TransButtonYes then
				startDriverMission()
				closeWindow()
			elseif source == TransButtonNo then
				closeWindow()
			end
		end )
	end
end )

function makeTexts(dxTexts,maxDis)
	if ( dxTexts and type(dxTexts) == "table" ) then
		addEventHandler("onClientRender",getRootElement(),function()
			local px,py,pz = getElementPosition(getLocalPlayer())		
			for k,v in ipairs ( dxTexts ) do	
			local sx, sy, sz = v[1],v[2],v[3] + 1
			local c1,c2,c3 =  0,255,0
			local size =  1.2
			local font = "pricedown"
			local site = isLineOfSightClear (px,py,pz,sx,sy,sz,true,true,true,true,false,true,false,lp)
				if (  c1 and c2 and c3 and size and font and site) then
					local x,y = getScreenFromWorldPosition(sx, sy, sz)
						if x then
							local dis = getDistanceBetweenPoints3D(sx, sy, sz,px,py,pz)
								if dis and dis < maxDis then
									dxDrawText("Driver Mission", x, y, x, y, tocolor(c1,c2,c3),size,font)
								end
						end
				end
			end
		end	)
	end
end

function startDxDrawing(posTable,maxDis)
	if ( tonumber(maxDis) and posTable and type(posTable) == "table" ) then
		makeTexts(posTable,maxDis)
	end
end
addEvent("startDxDrawing",true)
addEventHandler("startDxDrawing",root,startDxDrawing)