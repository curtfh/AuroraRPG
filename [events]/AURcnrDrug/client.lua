local resX, resY = guiGetScreenSize()

local isDrawing  = false
local theEvent   = false
local theText    = false
local barProcent = false
local theTimers  = {}

local R1, G1, B1, R2, G2, B2 = false, false, false, false, false, false

function createProgressBar ( dText, dTime, dEvent, DR1, DG1, DB1, DR2, DG2, DB2 )
	if not ( isDrawing ) then
		if ( dTime < 50 ) then return false end
		if not ( DR1 ) then R1 = 0 else R1 = DR1 end
		if not ( DG1 ) then G1 = 100 else G1 = DG1 end
		if not ( DB1 ) then B1 = 100   else B1 = DB1 end
		if not ( DR2 ) then R2 = 225 else R2 = DR2 end
		if not ( DG2 ) then G2 = 225 else G2 = DG2 end
		if not ( DB2 ) then B2 = 225 else B2 = DB2 end

		isDrawing  = true
		theEvent   = dEvent
		theText    = dText
		barProcent = 0

		theTimers[1] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[2] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[3] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[4] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[5] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		return true
	else
		return false
	end
end

function cancelProgressBar ()
	if ( isDrawing ) then
		isDrawing = false
		for i, k in ipairs ( theTimers ) do
			if ( isTimer ( k ) ) then
				killTimer ( k )
			end
		end
		theTimers = {}
		return true
	else
		return false
	end
end

addEventHandler( "onClientRender", root,
	function ()
		if ( isDrawing ) then
			if ( barProcent >= 520 ) then triggerEvent( theEvent, localPlayer ) cancelProgressBar() return end
			dxDrawRectangle((resX / 2) - 270, (resY / 2) - 22, 540, 44, tocolor(0, 0, 0, 150), false)
			dxDrawRectangle((resX / 2) - 265, (resY / 2) - 16, 530, 33, tocolor(0, 0, 0, 250), false)
			dxDrawRectangle((resX / 2) - 261, (resY / 2) - 12, barProcent, 25, tocolor(R1, G1, B1, 255), false)
			dxDrawText( tostring( theText ).." " .. math.floor( barProcent / 5.2 ).."%", (resX / 2) - 145, (resY / 2)-15, (resY / 2) - 1, (resX / 2) - 5, tocolor(R2, G2, B2, 255), 0.8, "bankgothic", "left", "top", false, false, false)
		end
	end
)



exports.customblips:createCustomBlip(2532.74,-1294.1, 14, 14, "drugs.png",1000)

local code = nil
local hcode = nil
local choosenDrug = {
	[1] = "Ritalin",
	[2] = "Cocaine",
	[3] = "LSD",
	[4] = "Weed",
	[5] = "Ecstasy",
	[6] = "Heroine",
}
local clicks = 0
local labJob = false
drugsLab = {
    button = {},
    staticimage = {},
    label = {}
}
LabDeal = {
    button = {},
    staticimage = {},
    label = {}
}

makingLab = {
    button = {},
    staticimage = {},
    label = {},
    radiobutton = {}
}



dealerpanel = {
    button = {},
    window = {},
    edit = {},
    label = {}
}

local codesTemp = {
	[1]={"215469",27}, -- == 27
	[2]={"654897",39}, -- == 39
	[3]={"378452",29}, -- == 29
	[4]={"378462",30}, -- == 30
	[5]={"278413",25}, -- == 25
	[6]={"645397",34}, -- == 34
	[7]={"192637",28}, -- == 28
	[8]={"124356",21}, -- == 21
	[9]={"976483",37}, -- == 37
	[10]={"453621",21},-- == 21
}



function centerWindows ( theWindow )
	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(theWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(theWindow,x,y,false)
end

pedsTable = {
	{2012.26,-1410.67,16.99,173}, --- LS hos jef
	{1181.19,-1318.97,13.58,265}, --- LS hos
	{1631.18,1840.98,10.58,170}, --- LV hos

}

addEventHandler("onClientResourceStart",resourceRoot,function()


	setElementData(localPlayer,"DFR",false)




	for k,v in ipairs(pedsTable) do
		local thePed = createPed(182,v[1],v[2],v[3])
		local shopmarker = createMarker(v[1],v[2],v[3],"cylinder",2,0,220,0,100)
		addEventHandler("onClientMarkerLeave",shopmarker,dealerMarkerClose)
		addEventHandler("onClientMarkerHit",shopmarker,dealerMarker)
		setPedRotation(thePed,v[4])
		setElementFrozen(thePed,true)
		setElementData(thePed,"jobPed",true)
		setElementData(thePed,"jobName","(Heist)\nRecipment dealer")
		setElementData(thePed,"jobColor",{0, 220, 0})
		setElementData(thePed, "showModelPed", true )
	end





	dealerpanel.window[1] = guiCreateWindow(304, 157, 209, 266, "Aurora ~ Recipment Shop", false)
	guiWindowSetSizable(dealerpanel.window[1], false)
	guiSetAlpha(dealerpanel.window[1], 0.88)
	guiSetVisible(dealerpanel.window[1],false)
	dealerpanel.label[1] = guiCreateLabel(10, 15, 191, 98, "Exchange your recipments with drugs\nRecipments exchanges : each recipment 3 hits of drugs types", false, dealerpanel.window[1])
	guiSetFont(dealerpanel.label[1], "default-bold-small")
	guiLabelSetColor(dealerpanel.label[1], 255, 57, 57)
	guiLabelSetHorizontalAlign(dealerpanel.label[1], "center", true)
	guiLabelSetVerticalAlign(dealerpanel.label[1], "center")
	dealerpanel.edit[1] = guiCreateEdit(9, 178, 89, 37, "1", false, dealerpanel.window[1])
	dealerpanel.button[1] = guiCreateButton(105, 182, 96, 33, "Exchange", false, dealerpanel.window[1])
	dealerpanel.button[2] = guiCreateButton(9, 222, 192, 34, "Close", false, dealerpanel.window[1])
	dealerpanel.label[2] = guiCreateLabel(9, 127, 190, 45, "Recipment Shop", false, dealerpanel.window[1])
	guiSetFont(dealerpanel.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(dealerpanel.label[2], "center", false)
	guiLabelSetVerticalAlign(dealerpanel.label[2], "center")
	dealerpanel.label[3] = guiCreateLabel(9, 90, 190, 35, "Amount", false, dealerpanel.window[1])
	guiSetFont(dealerpanel.label[3], "default-bold-small")
	guiLabelSetHorizontalAlign(dealerpanel.label[3], "center", false)
	guiLabelSetVerticalAlign(dealerpanel.label[3], "center")


	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(dealerpanel.window[1],false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(dealerpanel.window[1],x,y,false)




	drugsLab.staticimage[1] = guiCreateWindow(64, 106, 550,400, "Aurora ~ Drugs Machine", false)
	guiWindowSetSizable(drugsLab.staticimage[1], false)
	guiSetVisible(drugsLab.staticimage[1],false)
	guiSetAlpha(drugsLab.staticimage[1], 1.00)
	centerWindows(drugsLab.staticimage[1])

	drugsLab.staticimage[2] = guiCreateStaticImage(37, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[3] = guiCreateStaticImage(143, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[4] = guiCreateStaticImage(250, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[5] = guiCreateStaticImage(358, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[6] = guiCreateStaticImage(453, 27, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[7] = guiCreateStaticImage(92, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[8] = guiCreateStaticImage(199, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[9] = guiCreateStaticImage(307, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.staticimage[10] = guiCreateStaticImage(409, 134, 61, 60, "dot1.png", false, drugsLab.staticimage[1])
	drugsLab.button[1] = guiCreateButton(37, 317, 146, 33, "Hack", false, drugsLab.staticimage[1])
	guiSetProperty(drugsLab.button[1], "NormalTextColour", "FFAAAAAA")
	drugsLab.button[2] = guiCreateButton(368, 316, 146, 33, "Close", false, drugsLab.staticimage[1])
	guiSetProperty(drugsLab.button[2], "NormalTextColour", "FFAAAAAA")
	drugsLab.label[11] = guiCreateLabel(209, 312, 125, 33, "Code:", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[11], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[11], "center", false)
	guiLabelSetVerticalAlign(drugsLab.label[11], "center")
	drugsLab.label[1] = guiCreateLabel(57, 252, 461, 42, "Enter the correct code to rob the recipment", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[1], "sa-header")
	drugsLab.label[2] = guiCreateLabel(32, 101, 76, 19, "1", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[2], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[2], "center", false)
	drugsLab.label[3] = guiCreateLabel(138, 101, 76, 19, "2", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[3], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[3], "center", false)
	drugsLab.label[4] = guiCreateLabel(245, 101, 76, 19, "3", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[4], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[4], "center", false)
	drugsLab.label[5] = guiCreateLabel(353, 101, 76, 19, "4", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[5], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[5], "center", false)
	drugsLab.label[6] = guiCreateLabel(448, 101, 76, 19, "5", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[6], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[6], "center", false)
	drugsLab.label[7] = guiCreateLabel(87, 204, 76, 19, "6", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[7], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[7], "center", false)
	drugsLab.label[8] = guiCreateLabel(194, 204, 76, 19, "7", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[8], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[8], "center", false)
	drugsLab.label[9] = guiCreateLabel(302, 204, 76, 19, "8", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[9], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[9], "center", false)
	drugsLab.label[10] = guiCreateLabel(404, 204, 76, 19, "9", false, drugsLab.staticimage[1])
	guiSetFont(drugsLab.label[10], "default-bold-small")
	guiLabelSetHorizontalAlign(drugsLab.label[10], "center", false)
	for i=2,10 do
		addEventHandler("onClientGUIClick",drugsLab.staticimage[i],testCode,false)
	end
	addEventHandler("onClientGUIClick",drugsLab.button[1],makeDrugs,false)
	addEventHandler("onClientGUIClick",drugsLab.button[2],closeLab,false)

	addEventHandler( "onClientGUIChanged", dealerpanel.edit[1], removeLetters )
end)


addEventHandler("onClientGUIClick",root,function()
	if source == dealerpanel.button[2] then
		guiSetVisible(dealerpanel.window[1],false)
		showCursor(false)
	elseif source == dealerpanel.button[1] then
		local can,mssg = exports.NGCmanagement:isPlayerLagging()
		if can then
			local drugamount = guiGetText(dealerpanel.edit[1])
			local drug = tonumber(drugamount) * 3
			local points = tonumber(drugamount)
			if drug then
				if drug > 0 then
					if getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
						triggerServerEvent("exchangeRecipmentPoints",localPlayer,points,drug)
					end
				end
			end
		else
			exports.NGCdxmsg:createNewDxMessage(mssg,255,0,0)
		end
	end
end)

function removeLetters(element)
	local txts2 = guiGetText(element)
	local removed = string.gsub(txts2, "[^0-9]", "")
	if (removed ~= txts2) then
		guiSetText(element, removed)
	end
	local txts = guiGetText(element)
	if ( txts ~= "" and tonumber( txts ) ) then
		guiSetText( dealerpanel.label[2], "Drugs: "..(tonumber(txts)*3).." Hits")
	end
	if  string.len( tostring( guiGetText(element) ) ) > 4 then
		guiSetText(element, 1)
		guiSetText( dealerpanel.label[2],"Drugs: 3 Hits")
	end
end


addEvent("callHeistPoint",true)
addEventHandler("callHeistPoint",root,function(gg)
	guiSetText(dealerpanel.label[3],"Your Heist points:"..gg)
end)


function dealerMarker(hitElement,matchingDimension)
	if hitElement == localPlayer then
		if matchingDimension then
			if not isPedInVehicle(localPlayer) then
				local px,py,pz = getElementPosition ( localPlayer )
				local mx, my, mz = getElementPosition ( source )
				if ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
					if getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
						if getElementData(localPlayer,"drugsOpen") then
							forceHide()
							msg("Please close Drugs panel")
						end
						if getElementData(localPlayer,"isPlayerTrading") then
							forceHide()
							msg("Please close Dealer exchange system")
						end
						triggerServerEvent("queryHeistPoint",localPlayer)
						guiSetText(dealerpanel.label[2],"Recipment Shop")
						guiSetVisible(dealerpanel.window[1],true)
						showCursor(true)
					end
				end
			end
		end
	end
end

function dealerMarkerClose(hitElement,matchingDimension)
	if hitElement == localPlayer then
		if dealerpanel.window[1] and isElement(dealerpanel.window[1]) then
			if dealerpanel.window[1] and isElement(dealerpanel.window[1]) and guiGetVisible(dealerpanel.window[1]) then
				guiSetVisible(dealerpanel.window[1],false)
				showCursor(false)
			end
		end
	end
end

addEvent("addTheCode",true)
addEventHandler("addTheCode",root,function()
	if getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
		guiSetText(drugsLab.label[1],"Enter the correct code to rob the recipment")
		createProgressBar( "Installing virus to hack ...", 50, "installVirus" )
	else
		guiSetText(drugsLab.label[1],"Enter the correct code to defuse this machine")
		createProgressBar( "Defusing machine ...", 50, "installVirus" )
	end
end)

addEvent("installVirus",true)
addEventHandler("installVirus",root,function()
	if getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
		guiSetText(drugsLab.label[1],"Enter the correct code to rob the recipment")
	else
		guiSetText(drugsLab.label[1],"Enter the correct code to defuse this machine")
	end
	for i=2,10 do
		guiStaticImageLoadImage(drugsLab.staticimage[i],"dot1.png")
		guiSetEnabled(drugsLab.staticimage[i],true)
	end
	guiSetVisible(drugsLab.staticimage[1],true)
	local data = math.random(1,#codesTemp)
	code = codesTemp[data][2]
	outputDebugString(code)
	hcode = 0
	clicks = 0
	guiSetText(drugsLab.label[11],"Code:"..codesTemp[data][1])
	showCursor(true)
end)

addEvent("failDFR",true)
addEventHandler("failDFR",root,function()
	cancelProgressBar()
	guiSetVisible(drugsLab.staticimage[1],false)
	showCursor(false)
end)


function closeLab()
	guiSetVisible(drugsLab.staticimage[1],false)
	showCursor(false)
	triggerServerEvent("failDFRob",localPlayer)
	cancelProgressBar()
end


function makeDrugs()
	if code ~= nil then
		if tonumber(code) == tonumber(hcode) then
			guiSetVisible(drugsLab.staticimage[1],false)
			showCursor(false)
			labJob = true
			local num = math.random(1,6)
			exports.NGCdxmsg:createNewDxMessage("You have the recipment of "..choosenDrug[num],255,255,0)
			triggerServerEvent("lockDownMarker",localPlayer,choosenDrug[num])
		end
	end
end

function testCode()
	if not guiGetEnabled(source) then return false end
	if source == drugsLab.staticimage[2] then
		hcode = hcode + 1
		clicks = clicks+1
	elseif source == drugsLab.staticimage[3] then
		hcode = hcode + 2
		clicks = clicks+1
	elseif source == drugsLab.staticimage[4] then
		hcode = hcode + 3
		clicks = clicks+1
	elseif source == drugsLab.staticimage[5] then
		hcode = hcode + 4
		clicks = clicks+1
	elseif source == drugsLab.staticimage[6] then
		hcode = hcode + 5
		clicks = clicks+1
	elseif source == drugsLab.staticimage[7] then
		hcode = hcode + 6
		clicks = clicks+1
	elseif source == drugsLab.staticimage[8] then
		hcode = hcode + 7
		clicks = clicks+1
	elseif source == drugsLab.staticimage[9] then
		hcode = hcode + 8
		clicks = clicks+1
	elseif source == drugsLab.staticimage[10] then
		hcode = hcode + 9
		clicks = clicks+1
	end
	guiStaticImageLoadImage(source,"dot2.png")
	guiSetEnabled(source,false)
	if clicks > 6 then
		guiSetVisible(drugsLab.staticimage[1],false)
		showCursor(false)
		labJob = false
		msg("You have entered more than 6 charachters.You have failed!")
	end
end


local sxW,syW = guiGetScreenSize()
local sx, sy = guiGetScreenSize()
local lawCount = 0
local crimCount = 0
local CopsKills = {}
local CriminalsKills = {}


function dxDrawRelativeText( text,posX,posY,right,bottom,color,scale,mixed_font,alignX,alignY,clip,wordBreak,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawText(
        tostring( text ),
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


function dxDrawRelativeRectangle( posX, posY, width, height,color,postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawRectangle(
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( width/resolutionX )*sWidth,
        ( height/resolutionY )*sHeight,
        color,
        postGUI
    )
end

function dxDrawRelativeLine( posX, posY, width, height,color, size, postGUI )
    local resolutionX = 1366
    local resolutionY = 768
    local sWidth,sHeight = guiGetScreenSize( )
    return dxDrawLine(
        ( posX/resolutionX )*sWidth,
        ( posY/resolutionY )*sHeight,
        ( width/resolutionX )*sWidth,
        ( height/resolutionY )*sHeight,
		color,
        size,
        postGUI
    )
end


addEventHandler( "onClientProjectileCreation", root,
function ( creator )
	if ( getElementData ( localPlayer, "DFR" ) ) then
		if ( getProjectileType( source ) == 16 ) or ( getProjectileType( source ) == 17 ) or ( getProjectileType( source ) == 18 ) or ( getProjectileType( source ) == 39 ) then
			if ( creator == localPlayer ) then
				-------
			end
			destroyElement( source )
		end
	end
end
)

addEventHandler("onClientExplosion", root,
function(x, y, z, theType)
	if (getElementData(localPlayer, "DFR")) then
		cancelEvent()
	end
end)



-- Insert into top list when player kills a player
addEventHandler( "onClientPlayerWasted", root,
	function ( theKiller, weapon, bodypart )
		if ( theKiller and isElement(theKiller) and getElementType(theKiller) == "player" ) then
			if ( getElementData( theKiller, "DFR" ) ) then
				if not getPlayerTeam(theKiller) then return false end
				if getTeamName(getPlayerTeam(theKiller)) == "Criminals" and ( exports.DENlaw:isLaw(source) ) then
					if ( CriminalsKills[theKiller] ) then
						CriminalsKills[theKiller] = CriminalsKills[theKiller] +1
					else
						CriminalsKills[theKiller] = 1
					end
				elseif ( exports.DENlaw:isLaw(theKiller) and getTeamName(getPlayerTeam(source)) == "Criminals" )  then
					if ( CopsKills[theKiller] ) then
						CopsKills[theKiller] = CopsKills[theKiller] +1
					else
						CopsKills[theKiller] = 1
					end
				end
			end
		end
	end
)

-- Get the top killers
function TopKills()
	local C1, C2, C3, C4, C5,C6,C7,C8, L1, L2, L3, L4, L5,L6,L7,L8 = "None", "None", "None", "None", "None", "None", "None", "None", "None", "None","None", "None", "None", "None", "None", "None"

	--table.sort( CopsKills )
	--table.sort( CriminalsKills )
	    table.sort(CriminalsKills, function(a, b) return a[1] > b[1] end)
	    table.sort(CopsKills, function(a, b) return a[1] > b[1] end)

	local i1 = 1

	for thePlayer, theKills in pairs ( CopsKills ) do
		if ( isElement( thePlayer ) ) then
			if ( i1 > 10 ) then
				break;
			else
				if ( i1 == 1 ) then
					L1 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 2 ) then
					L2 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 3 ) then
					L3 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 4 ) then
					L4 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 5 ) then
					L5 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 6 ) then
					L6 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 7 ) then
					L7 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 8 ) then
					L8 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				--[[elseif ( i1 == 9 ) then
					L9 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 10 ) then
					L10 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1]]
				end
			end
		else
			CopsKills[thePlayer] = {}
		end
	end

	local i2 = 1

	for thePlayer, theKills in pairs ( CriminalsKills ) do
		if ( isElement( thePlayer ) ) then
			if ( i2 > 10 ) then
				break;
			else
				if ( i2 == 1 ) then
					C1 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 2 ) then
					C2 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 3 ) then
					C3 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 4 ) then
					C4 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 5 ) then
					C5 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 6 ) then
					C6 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 7 ) then
					C7 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 8 ) then
					C8 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				--[[elseif ( i2 == 9 ) then
					C9 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 10 ) then
					C10 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1]]
				end
			end
		else
			CriminalsKills[thePlayer] = {}
		end
	end

	return C1, C2, C3, C4, C5,C6,C7,C8, L1, L2, L3, L4, L5,L6,L7,L8
end


addEvent("countDFR",true)
addEventHandler("countDFR",root,function(law,rob)
	crimCount = rob
	lawCount = law
end)
isEventFinished = false
addEvent("drawDFRTime",true)
addEventHandler("drawDFRTime",root,function(tim)
	myTime = setTimer(function() isEventFinished = true end,tim,1)
end)



-- When player does /banktime
function onCalculateBanktime ( theTime )
	if ( theTime >= 60000 ) then
		local plural = ""
		if ( math.floor((theTime/1000)/60) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)/60) .. " minute" .. plural)
	else
		local plural = ""
		if ( math.floor((theTime/1000)) >= 2 ) then
			plural = "s"
		end

		return tostring(math.floor((theTime/1000)) .. " second" .. plural)
	end
end


addEventHandler("onClientRender",root,function()
	if getElementData(localPlayer,"DFR") then
		dxDrawRelativeRectangle(1000,209.0,350,348.0,tocolor(0,0,0,190),false)
		dxDrawRelativeRectangle(1000,555.0,350,148.0,tocolor(0,0,0,190),false)

			dxDrawRelativeText("Criminals: "..crimCount.."",1020,260,1156.0,274.0,tocolor(255,0,0,230),2,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("1) "..C1,1020,310,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("2) "..C2,1020,340,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("3) "..C3,1020,370,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("4) "..C4,1020,400,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("5) "..C5,1020,430,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("6) "..C6,1020,460,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("7) "..C7,1020,490,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("8) "..C8,1020,520,1156.0,274.0,tocolor(255,0,0,230),0.9,"default-bold","left","top",false,false,false)


			dxDrawRelativeText("Cops: "..lawCount.."",1200,260,1156.0,274.0,tocolor(0,100,250,230),2,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("1) "..L1,1200,310,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("2) "..L2,1200,340,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("3) "..L3,1200,370,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("4) "..L4,1200,400,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("5) "..L5,1200,430,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("6) "..L6,1200,460,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("7) "..L7,1200,490,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
			dxDrawRelativeText("8) "..L8,1200,520,1156.0,274.0,tocolor(0,100,250,230),0.9,"default-bold","left","top",false,false,false)
		if isEventFinished == true then
			dxDrawRelativeText("Escape from the event",1020,220,1156.0,274.0,tocolor(255,0,0,230),2,"default-bold","left","top",false,false,false)
		else
			C1, C2, C3, C4, C5,C6,C7,C8, L1, L2, L3, L4, L5,L6,L7,L8 = TopKills()
			if myTime and isTimer(myTime) then
				local timeLeft, timeExLeft, timeExMax = getTimerDetails(myTime)
				if timeLeft and tonumber(timeLeft) > 0 then
					dxDrawRelativeText("Timed out: "..onCalculateBanktime ( math.floor( timeLeft ) ).."",1020,220,1156.0,274.0,tocolor(255,0,0,230),2,"default-bold","left","top",false,false,false)
				end
			end

			dxDrawRelativeLine(1350, 250, 1000, 250,tocolor(255,255,255,255),1.0,false)
			dxDrawRelativeLine(1350, 550, 1000, 550,tocolor(255,255,255,255),1.0,false)
			dxDrawRelativeLine(1350, 300, 1000, 300,tocolor(255,255,255,255),1.0,false)
			dxDrawRelativeLine(1178, 253, 1178, 550,tocolor(255,255,255,255),1.0,false)
			for k,v in ipairs(getElementsByType("marker",resourceRoot)) do
				local se = getElementData(v,"robTeam")
				local id = getElementData(v,"id")
				if se then
					if se == "Law" then
						r,g,b = 0,100,255
					elseif se == "Criminals" then
						r,g,b = 255,0,0
					else
						r,g,b = 255,255,255
					end
					if se == "none" then
						dxDrawRelativeText("None has rob/defuse the machine",1020,550+id*18,1156.0,274.0,tocolor(r,g,b,255),1.5,"default-bold","left","top",false,false,false)
					else
						if se == "Law" then
							dxDrawRelativeText("Law units have defused the machine",1020,550+id*18,1156.0,274.0,tocolor(r,g,b,255),1.3,"default-bold","left","top",false,false,false)
						else
							dxDrawRelativeText("Criminals have robbed the machine",1020,550+id*18,1156.0,274.0,tocolor(r,g,b,255),1.3,"default-bold","left","top",false,false,false)
						end
					end
				end
			end
		end
	end
end)



local cmds = {
[1]="reconnect",
[2]="quit",
[3]="connect",
[4]="disconnect",
[5]="exit",
}

function unbindTheBindedKey()
	local key = getKeyBoundToCommand("reconnect")
	local key2 = getKeyBoundToCommand("quit")
	local key3 = getKeyBoundToCommand("connect")
	local key4 = getKeyBoundToCommand("disconnect")
	local key5 = getKeyBoundToCommand("exit")
--	local key6 = getKeyBoundToCommand("takehit")
	local key7 = getKeyBoundToCommand("dropkit")
	if key or key2 or key3 or key4 or key5  or key7 then
		if key then
			theKey = "Reconnect/Disconnect"
		elseif key2 then
			theKey = "Reconnect/Disconnect"
		elseif key3 then
			theKey = "Reconnect/Disconnect"
		elseif key4 then
			theKey = "Reconnect/Disconnect"
		elseif key5 then
			theKey = "Reconnect/Disconnect"
	--	elseif key6 then
	--		theKey = "takehit"
		elseif key7 then
			theKey = "dropkit"
		end
		if disabled then return end
		disabled = true
	else
		if not disabled then return end
		disabled = false
	end
end
setTimer(unbindTheBindedKey,500,0)
stuck = false
function handleInterrupt( status, ticks )
	if (status == 0) then
		if getElementData(localPlayer,"isPlayerLoss") ~= true then
			stuck = true
			setElementData(localPlayer,"isPlayerLoss",true)
		end
	elseif (status == 1) then
		triggerServerEvent("setPacketLoss",localPlayer,false)
		if getElementData(localPlayer,"isPlayerLoss") == true then
			stuck = false
			setElementData(localPlayer,"isPlayerLoss",false)
		end
	end
end
addEventHandler( "onClientPlayerNetworkStatus", root, handleInterrupt)
lastPacketAmount = 0
setTimer(function()
	if guiGetVisible(dealerpanel.window[1]) then
		if stuck == true then
			forceHide()
			msg("You are lagging due Huge Network Loss you can't open Dealer exchange system")
		end
		if getPlayerPing(localPlayer) >= 600 then
			forceHide()
			msg("You are lagging due PING you can't open Dealer exchange system")
		end
		if getElementDimension(localPlayer) == exports.server:getPlayerAccountID(localPlayer) then
			forceHide()
			msg("You can't open Dealer exchange system in house or afk zone!")
		end
		if tonumber(getElementData(localPlayer,"FPS") or 5) < 5 then
			forceHide()
			msg("You are lagging due FPS you can't open Dealer exchange system")
		end
		if getElementInterior(localPlayer) ~= 0 then
			forceHide()
			msg("Please be in the real world instead of interiors and other dims")
		end
		if getElementData(localPlayer,"drugsOpen") then
			forceHide()
			msg("Please close Drugs panel")
		end
		if getElementData(localPlayer,"isPlayerTrading") then
			forceHide()
			msg("Please close Dealer exchange system")
		end
		if disabled then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while bounded ("..theKey..")",255,0,0)
		end
		if isConsoleActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while Console window is open",255,0,0)
		end
		if isChatBoxInputActive() then
			forceHide()
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while Chat input box is open",255,0,0)
		end
		if isMainMenuActive() then
			forceHide()
			msg("Please close MTA Main Menu")
			exports.NGCdxmsg:createNewDxMessage("You can't use Dealer exchange system while MTA Main Menu is open",255,0,0)
		end
		local network = getNetworkStats(localPlayer)
		if (network["packetsReceived"] > lastPacketAmount) then
			lastPacketAmount = network["packetsReceived"]
		else --Packets are the same. Check ResendBuffer
			if (network["messagesInResendBuffer"] >= 15) then
				forceHide()
				msg("You are lagging like hell (Huge packet loss)")
			end
		end
		if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
			for k,v in ipairs(getElementsByType("gui-window")) do
				if v ~= dealerpanel.window[1] then
					if guiGetVisible(v) and guiGetVisible(dealerpanel.window[1]) then
						forceHide()
						msg("Please close any panel open!")
					end
				end
			end
		end
	end
end,50,0)

function msg(s)
	if s then
		exports.NGCdxmsg:createNewDxMessage(s,255,0,0)
	else
		exports.NGCdxmsg:createNewDxMessage("You are lagging : You can't open Dealer exchange system at the moment!",255,0,0)
	end
end

function forceHide()
	guiSetVisible(dealerpanel.window[1],false)
	showCursor(false)
end

function handleMinimize()
	if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
		forceHide()
    end
end
addEventHandler( "onClientMinimize", root, handleMinimize )

function playerPressedKey(button, press)
	if getKeyState( "latl" ) == true or getKeyState( "escape" ) == true or getKeyState( "ralt" ) == true then
		if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
			forceHide()
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

function handleRestore( didClearRenderTargets )
    if didClearRenderTargets then
		if dealerpanel.window[1] and guiGetVisible(dealerpanel.window[1]) then
			forceHide()
		end
    end
end
addEventHandler("onClientRestore",root,handleRestore)
