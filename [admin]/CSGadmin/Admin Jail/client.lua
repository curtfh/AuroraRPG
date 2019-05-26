local resX, resY = guiGetScreenSize()
local isPlayerJailed = false
local jailTime = nil
local height = dxGetFontHeight(1.5,"bankgothic")
local whoIn = 0
-- Event when a player gets jailed
addEvent( "onSetPlayerJailed", true )
addEventHandler( "onSetPlayerJailed", root,
	function ( theTime )
		if ( theTime ) then
			if not ( isPlayerJailed ) then
				setTimer ( onCheckPlayerJail, 1000, 1 ) jailTime = theTime isPlayerJailed = true
				exports.NGCdxmsg:createNewDxMessage("You are jailed for " .. math.floor(theTime/60).. " minutes!", 225, 0, 0)
				setElementData(localPlayer,"isPlayerJailed",true,true)
				triggerServerEvent("onPlayerJailed",localPlayer,theTime)
				isPlayerJailed=true
			else
				jailTime = theTime
			end
		end
	end
)

-- Jail check function
function onCheckPlayerJail ()
	if getElementData(localPlayer,"isPlayerEscaped") then return false end
	if ( jailTime <= 0 ) or not ( isPlayerJailed ) then
		triggerServerEvent("onAdminUnjailPlayer", localPlayer, localPlayer )
		isPlayerJailed = false
		exports.NGCdxmsg:createNewDxMessage("You are released from the jail!", 225, 0, 0)
		triggerServerEvent("onPlayerJailReleased",localPlayer)

	else
		jailTime = jailTime -1
		setElementData( localPlayer, "jailTimeRemaining", jailTime )
		setTimer ( onCheckPlayerJail, 1000, 1 )
	end
end

-- Event to unjail
addEvent( "onRemovePlayerJail", true )
addEventHandler( "onRemovePlayerJail", root,
	function ()
		isPlayerJailed = false
	end
)


function getCriminals(index)
	whoIn=index
end
addEvent("countJailed",true)
addEventHandler("countJailed",root,getCriminals)
-- Jail timer

local sx, sy = guiGetScreenSize()

function dxDrawDxText(text,x,y,w,h,r,g,b,a,size,type,area,sc,state1,state2,state3)
	dxDrawText(text,x,y+100,w,h,tocolor(r,g,b,a),size,type,area,sc,state1,state2,state3)
end


function dxDrawDxRectangle(x,y,w,h,r,g,b,a,state1)
	dxDrawRectangle(x,y+100,w,h,tocolor(r,g,b,a),state1)
end


addEventHandler( "onClientRender", root,
	function ()
		if isPlayerJailed then
		--	dxDrawText(getElementData(localPlayer,"jailTimeRemaining").." seconds remaining...",4,resY-(height+3),resX,resY,tocolor(0,0,0,255),1.5, "bankgothic","center","top",false,false,false)
		---	dxDrawText(getElementData(localPlayer,"jailTimeRemaining").." seconds remaining...",0,resY-(height+5),resX,resY,tocolor(255,255,255,255),1.5, "bankgothic","center","top",false,false,false)
		-- Rectangle
			dxDrawDxRectangle(sx*(1111.0/1440),sy*(200.0/900),sx*(300/1440),sy*(150.0/900),0,0,0,100,false)
		-- Totals
			dxDrawDxText("AUR Federal Jail",sx*(1135.0/1440),sy*(220.0/900),sx*(1357.0/1440),sy*(240.0/900),255,255,255,225,1,"default-bold","center","top",false,false,false)

			--dxDrawDxText("Criminals Jailed: "..whoIn,sx*(1125.0/1440),sy*(250.0/900),sx*(1357.0/1440),sy*(240.0/900),255,0,0,225,1.2,"default-bold","left","top",false,false,false)
			dxDrawDxText("Seconds remaining: "..getElementData(localPlayer,"jailTimeRemaining"),sx*(1125.0/1440),sy*(280.0/900),sx*(1357.0/1440),sy*(260.0/900),255,255,255,225,1,"default-bold","left","top",false,false,false)
		end
	end
)




setTimer(function()
	if not getElementData(localPlayer,"isPlayerEscaped") then
		if isPlayerJailed == false then
			local jx,jy,jz = getElementPosition(localPlayer)
			local jx2,jy2,jz2 =  918.3681640625,-2276.8415527344,739.86828613281
			local jailDim = getElementDimension(localPlayer)
			if jailDim == 2 then
				if getDistanceBetweenPoints3D(jx,jy,jz,jx2,jy2,jz2) < 2000 then
					isPlayerJailed = false
					exports.NGCdxmsg:createNewDxMessage("You are released from the jail!", 225, 0, 0)
					triggerServerEvent("onPlayerJailReleased",localPlayer)
					setElementData(localPlayer,"jailTimeRemaining",0,true)
					triggerServerEvent("onAdminUnjailPlayer", localPlayer, localPlayer )
					return
				end
			end
		end
		if getElementData(localPlayer,"jailTimeRemaining") == false then setElementData(localPlayer,"jailTimeRemaining",0,true) end
		if isPlayerJailed == false and getElementData(localPlayer,"jailTimeRemaining") > 0 then
			isPlayerJailed = false
			exports.NGCdxmsg:createNewDxMessage("You are released from the jail!", 225, 0, 0)
			triggerServerEvent("onPlayerJailReleased",localPlayer)
			triggerServerEvent("onAdminUnjailPlayer", localPlayer, localPlayer )
			setElementData(localPlayer,"jailTimeRemaining",0,true)
		end
	end
end,1000,0)

