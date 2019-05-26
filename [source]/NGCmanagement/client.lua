stuck = {}

frozen = false
tag = false
lagX, lagY, lagZ = 0, 0, 0
count = 0
lastByte = 0
ping = {}

function holdOn()
	local text = guiGetText(source)
	local x, y = guiGetSize ( source, false )
	if ( string.len( tostring( text ) ) ) > x  then
		guiSetText(source,"")
		exports.NGCdxmsg:createNewDxMessage("You can't spam this edit box for more than ("..x.." characters)",255,0,0)
	end
end


function setMax()
	for k,v in ipairs(getElementsByType("gui-edit")) do
		local x, y = guiGetSize ( v, false )
		guiEditSetMaxLength(v,x)
		removeEventHandler( "onClientGUIChanged", v, holdOn, false )
		addEventHandler( "onClientGUIChanged", v, holdOn, false )
	end
end
setMax()
setTimer(setMax,60000,0)
--addEventHandler("onClientResourceStart",root,setMax)





errorMessages = {

    ["highping"] = {"You're lagging due Ping (your ping above 700)!"},

    ["lowfps"] = {"You're lagging due FPS (your FPS less than 5)!"},

	["packet"] = {"You're lagging due Huge packet loss!"},

	["hell"] = {"You are lagging like hell (Huge packet loss)"},

	["frozen"] = {"Warning: Packet Loss Detected"},

}

lastPacketAmount = 0


function isPlayerLagging() --- important checks dont touch dick head

    if (not isElement(localPlayer)) then return end

    if getPlayerPing(localPlayer) >= 700 then

        return false, errorMessages["highping"][1]

    end

	if tonumber(getElementData(localPlayer,"FPS")) <= 3 then

        return false, errorMessages["lowfps"][1]

    end
	if frozen then
		return false, errorMessages["frozen"][1]
	end
	local network = getNetworkStats(localPlayer)
	if (network["packetsReceived"] > lastPacketAmount) then
		lastPacketAmount = network["packetsReceived"]
	else --Packets are the same. Check ResendBuffer
		if (network["messagesInResendBuffer"] >= 15) then
			return false, errorMessages["hell"][1]
		end
	end
	--[[if stuck then

        return false, errorMessages["packet"][1]

    end]]

    return true

end


function dxDrawBorderedText ( text, wh, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	if not wh then wh = 1.5 end
	dxDrawText ( text, x - wh, y - wh, w - wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true) -- black
	dxDrawText ( text, x + wh, y - wh, w + wh, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y + wh, w - wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y + wh, w + wh, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x - wh, y, w - wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x + wh, y, w + wh, h, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y - wh, w, h - wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y + wh, w, h + wh, tocolor ( 0, 0, 0, a ), scale, font, alignX, alignY, clip, wordBreak, false, true)
	dxDrawText ( text, x, y, w, h, clr, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end


function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawBorderedText(
        tostring( text ),
		1.0,
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( right/resolutionX )*sWidth,
        ( bottom/resolutionY)*sHeight,
        color,
		( sWidth/resolutionX )*scale,
        mixed_font,
        alignX,
        alignY,
        clip,
        wordBreak,
        postGUI
    )
end

local screenW, screenH = guiGetScreenSize()
--[[
function createText()
	--if screenW > 800 then ts = 1 else ts = 1 end
	if getElementData(localPlayer,"isPlayerLoss") then
		--dxDrawRelativeText( "You have Network problem (Packetloss)", 400,680,1156.0,274.0,tocolor(255,0,0,255),te,"default-bold","center","top",false,false,false )
		dxDrawBorderedText("WARNING: High packet loss detected", 1.75, (screenW - 504) / 2, (screenH - 250) / 1.05, ((screenW - 504) / 2) + 504, ( (screenH - 44) / 1.05) + 44, tocolor(255,0,0, 255), 0.9, "default-bold", "center", "center", false, false, true, false, false)
	end
end
addEventHandler("onClientRender",root,createText)]]

setTimer(
	function()
			local loss = getNetworkStats(localPlayer)["packetlossLastSecond"]
			local resend = getNetworkStats(localPlayer)["messagesInResendBuffer"]
			local bSent = getNetworkStats(localPlayer)["bytesSent"]
			if loss > 50 and resend > 0 then
				frozen = true
				tag = true
			else
				frozen = false
				tag = false
				count = 0
			end
			lastByte = bSent
		--end
	end, 500, 0
)
--[[
function handleInterrupt( status, ticks )
	if (status == 0) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago" )
		triggerServerEvent("setPacketLoss",localPlayer,true)
		if getElementData(localPlayer,"isPlayerLoss") ~= true then
			stuck = true
			setElementData(localPlayer,"isPlayerLoss",true)
		end
	elseif (status == 1) then
		--outputDebugString( "(packets from server) interruption began " .. ticks .. " ticks ago and has just ended" )
		triggerServerEvent("setPacketLoss",localPlayer,false)
		if getElementData(localPlayer,"isPlayerLoss") == true then
			stuck = false
			setElementData(localPlayer,"isPlayerLoss",false)
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)
]]

function handleInterrupt( status, ticks )
	triggerServerEvent("checkClientPacket",localPlayer,status,ticks)
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)
