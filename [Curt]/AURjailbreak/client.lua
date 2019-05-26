local escapeMaraker
local sound

GUIEditor = {
    label = {},
    button = {},
    window = {},
    gridlist = {},
    combobox = {}
}

function openGUI ()
	if (isElement(GUIEditor.window[1])) then 
		destroyElement(GUIEditor.window[1])
		showCursor(false)
		return
	end 
	GUIEditor.window[1] = guiCreateWindow(0.37, 0.40, 0.28, 0.15, "AuroraRPG - Prison Break", true)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(0.03, 0.26, 0.94, 0.26, "Are you sure you want to escape?\nEscaping from the prison will be dangerious.", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
	GUIEditor.button[1] = guiCreateButton(0.10, 0.61, 0.32, 0.25, "Yes", true, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(0.57, 0.61, 0.32, 0.25, "No", true, GUIEditor.window[1])   
	showCursor(true)
	addEventHandler("onClientGUIClick", GUIEditor.button[2], openGUI, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[1], trigEscape, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[1], openGUI, false)
end 

function trigEscape ()
	triggerServerEvent ("AURjailbreak.triggerPlayerEscape", resourceRoot, getLocalPlayer())
end 

function MarkerHit(hitPlayer, matchingDimension)
	if (hitPlayer == getLocalPlayer()) then 
		if (getElementDimension(getLocalPlayer()) == 2) then 
			if (getPlayerWantedLevel() == 0) then 
				exports.NGCdxmsg:createNewDxMessage("You cannot escape from admin jail.",255, 0, 0)
				return
			end
			if (getElementData(getLocalPlayer(), "wantedPoints") >= 29) then 
				local x, y, z = getElementPosition(hitPlayer)
				local ax, ay, az = getElementPosition(source)
				if ( z-3 < az ) and ( z+3 > az ) then
					openGUI()
				end
			else
				exports.NGCdxmsg:createNewDxMessage("You must have 30+ wanted points.",255, 0, 0)
			end
		end
	end
end

function makeAlarm ()
	if (isElement(sound)) then return false end
	sound = playSound3D ("alarm.mp3", 891.59, -2372.36, 13.27, false)
	setSoundMinDistance(sound, 100)
	setSoundMaxDistance(sound, 400)
end 
addEvent("AURjailbreak.setAlarm", true)
addEventHandler("AURjailbreak.setAlarm", localPlayer, makeAlarm)

function loadAllContent()
	if (isElement(escapeMaraker)) then 
		destroyElement(escapeMaraker)
		return
	end 
	escapeMaraker = createMarker (771.22, -2453.39, 909.1, "cylinder", 2, 255, 0, 0)
	setElementDimension(escapeMaraker, 2)
	addEventHandler ("onClientMarkerHit", escapeMaraker, MarkerHit)
end 
loadAllContent()

fileDelete("client.lua")