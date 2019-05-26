
fadeCamera ( true ) --Remove MTA fade
gameOver = false
local shakingPieces = {}


function shakeOnRender()
	if gameOver == false then
	    local currentTick = getTickCount()
	    for object,originalTick in pairs(shakingPieces) do
	        --calculate the amount of time that has passed in ms
	        local tickDifference = currentTick - originalTick
	        --if the time has exceeded its max
	        if tickDifference > 2400 then
				shakingPieces[object] = nil --remove it from the table loop
	        else
	            --since newx/newy increases by 1 every 125ms, we can use this ratio to calculate a more accurate time
	            local newx = tickDifference/125 * 1
	            local newy = tickDifference/125 * 1
	        	if isElement ( object ) then
					setElementRotation ( object, math.deg( 0.555 ), 3 * math.cos(newy + 1), 3 * math.sin(newx + 1) )
	        	end
			end
	    end
	end
end
addEventHandler ( "onClientRender", root, shakeOnRender )

function ShakePieces ( fallingPiece )
	--we store the time when the piece was told to shake under a table, so multiple objects can be stored
	shakingPieces[fallingPiece] = getTickCount()
end
addEvent("clientShakePieces",true) --For triggering from server
addEventHandler("clientShakePieces", root, ShakePieces)
local NGCFalloutGUI = {}


function createFalloutWindows ()
	NGCFalloutGUI[300] = guiCreateWindow(340,333,291,334,"NGC Fallout",false)
	setWindowPrefs ( NGCFalloutGUI[300] )
	guiSetAlpha(NGCFalloutGUI[300],0.8)
	NGCFalloutGUI[4] = guiCreateButton(70,80,134,24,"Create",false,NGCFalloutGUI[300])
	NGCFalloutGUI[3] = guiCreateButton(70,140,134,24,"Destroy",false,NGCFalloutGUI[300])
	NGCFalloutGUI[2] = guiCreateButton(70,200,134,24,"Shake",false,NGCFalloutGUI[300])
	NGCFalloutGUI[1] = guiCreateButton(70,280,134,24,"Close window",false,NGCFalloutGUI[300])
	addEventHandler("onClientGUIClick",NGCFalloutGUI[4],function() triggerServerEvent("createfallout",localPlayer) end,false)
	addEventHandler("onClientGUIClick",NGCFalloutGUI[3],function() triggerServerEvent("destroyfallout",localPlayer) end,false)
	addEventHandler("onClientGUIClick",NGCFalloutGUI[2],function() triggerServerEvent("shakefallout",localPlayer) end,false)
	addEventHandler("onClientGUIClick",NGCFalloutGUI[1],function() showCursor(false) guiSetVisible(NGCFalloutGUI[300],false) end,false)
end

-- Create all GUI elements on start of the resource
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function ()
		 createFalloutWindows ()
	end
)
-- Center the window and set is not visable untill we need it
function setWindowPrefs ( theWindow )
	guiWindowSetMovable ( theWindow, true )
	guiWindowSetSizable ( theWindow, false )
	guiSetVisible ( theWindow, false )

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end


addEvent("showFallout",true)
addEventHandler("showFallout",root,function()
	showCursor(true)
	guiSetVisible(NGCFalloutGUI[300],true)
end)
