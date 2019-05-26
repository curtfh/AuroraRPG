
local isPlayerMuted = false
local muteTime = nil
mtype = {}
-- Event when a player gets muted
addEvent( "onPlayerMute", true )
addEventHandler( "onPlayerMute", root,
	function ( theTime,theType,thePlayer )
		if ( theTime ) then
			if not ( isPlayerMuted ) then
				muteTime = theTime
				isPlayerMuted = true
				exports.NGCdxmsg:createNewDxMessage("You are muted for " .. math.floor(theTime/60).. " minutes!", 225, 0, 0)
				mtype[thePlayer] = theType
				setTimer ( onCheckPlayerMute, 1000, 1 )
			else
				muteTime = theTime
				mtype[thePlayer] = theType
				isPlayerMuted = true
				setTimer ( onCheckPlayerMute, 1000, 1 )
			end
			triggerEvent("onSetPlayerMuted",localPlayer)
		end
	end
)

-- Mute check function
function onCheckPlayerMute ()
	if ( muteTime <= 0 ) or not ( isPlayerMuted ) then
		triggerServerEvent( "onAdminUnmutePlayer", localPlayer, localPlayer )
		isPlayerMuted = false
		exports.NGCdxmsg:createNewDxMessage("You are no longer muted! Behave and read the rules (F1).", 225, 0, 0)
		muteTime = nil
	else
		muteTime = muteTime -1
		setElementData( localPlayer, "muteTimeRemaining", muteTime )
		setTimer ( onCheckPlayerMute, 1000, 1 )
	end
end

-- Event to unmute
addEvent( "onRemovePlayerMute", true )
addEventHandler( "onRemovePlayerMute", root,
	function ()
		isPlayerMuted = false
		setElementData( localPlayer, "muteTimeRemaining", false )
	end
)


addEventHandler("onClientRender",getRootElement(),
function ()
	for i,v in ipairs(getElementsByType("player")) do
		if getElementData(v,"muteTimeRemaining") and tonumber(getElementData(v,"muteTimeRemaining")) > 0  then
			if getElementData(v,"muteType") then
				local name = "["..getElementData(v,"muteType").." Mute] "..math.floor(tonumber(getElementData(v,"muteTimeRemaining"))/60).." minutes"
				if ( not name ) then return end
				local x,y,z = getElementPosition(v)
				local cx,cy,cz = getCameraMatrix()
				if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 15 then
					local px,py = getScreenFromWorldPosition(x,y,z+1,0.06)
					if px then
						local width = dxGetTextWidth(name,1,"sans")
						local r,g,b = 255,150,0
						dxDrawBorderedText(name, px, py, px, py, tocolor(r, g, b, 255), 1, "sans", "center", "center", false, false)
					end
				end
			end
		end
	end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end
