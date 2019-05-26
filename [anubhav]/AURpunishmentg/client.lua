screenW, screenH = guiGetScreenSize()
gui = {}

gui[1] = guiCreateButton(0.34, 0.73, 0.31, 0.03, "", true)
guiSetAlpha(gui[1], 0.00)
gui[2] = guiCreateGridList(0.34, 0.28, 0.32, 0.44, true)
guiGridListAddColumn(gui[2], "Rule name", 0.5)
guiGridListAddColumn(gui[2], "Punishment", 0.35)
guiGridListAddRow(gui[2], "Deathmatching ", " 10M Jail")
guiGridListAddRow(gui[2], "Respecting Staff Members/Players ", " 1H Jail/mute")
guiGridListAddRow(gui[2], "Abusing/Exploiting Bugs ", " 30")
guiGridListAddRow(gui[2], "Insulting/Flaming/Provoking ", " 20M mute")
guiGridListAddRow(gui[2], "Armed Vehicles Rule ", " Removal of AV")
guiGridListAddRow(gui[2], "Advertising ", " Never ending ban")
guiGridListAddRow(gui[2], "Misusing Support Channel ", " 15M Mute")
guiGridListAddRow(gui[2], "Avoiding IG Situation ", " 20M Jail")
guiGridListAddRow(gui[2], "Nonenglish", "15M Mute")
guiGridListAddRow(gui[2], "Misusing Advert ", " 10M mute")
guiGridListAddRow(gui[2], "Spamming ", " 20M Mute")
guiGridListAddRow(gui[2], "Account Misuage ", " Perm Ban")
guiGridListAddRow(gui[2], "Trolling ", " 30M Mute/Jail")
guiGridListAddRow(gui[2], "HeliTurfing ", " 20M Jail")
guiGridListAddRow(gui[2], "Camping ", " 20M Jail")
guiGridListAddRow(gui[2], "Blackmailing ", " 25M Mute")
guiGridListAddRow(gui[2], "Illegal Programs ", " 30M Mute or 7D Ban")
guiGridListAddRow(gui[2], "Nicknames ", " 30M Mute")
guiGridListAddRow(gui[2], "Misusing report system/advertising outside /advert ", " 15M Mute")
guiGridListAddRow(gui[2], "Behaviour ", " 30M Mute")

function dxPG()
	dxDrawRectangle(screenW * 0.3328, screenH * 0.2208, screenW * 0.3344, screenH * 0.5583, tocolor(0, 0, 0, 179), false)
	dxDrawRectangle(screenW * 0.3328, screenH * 0.2208, screenW * 0.3344, screenH * 0.0444, tocolor(0, 0, 0, 179), false)
	dxDrawText("AuroraRPG ~ Punishment Guidelines", screenW * 0.3320, screenH * 0.2208, screenW * 0.6672, screenH * 0.2653, tocolor(255, 255, 255, 255), 1.30, "default-bold", "center", "center", false, false, false, false, false)
	dxDrawRectangle(screenW * 0.3422, screenH * 0.7292, screenW * 0.3141, screenH * 0.0292, tocolor(0, 0, 0, 179), false)
	dxDrawText("Close", screenW * 0.3422, screenH * 0.7306, screenW * 0.6563, screenH * 0.7583, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "center", false, false, false, false, false)
end

for i, v in ipairs(gui) do
	guiSetVisible(v, false)
end

function toggle()
	if (not exports.CSGstaff:isPlayerStaff(localPlayer)) then
		return false 
	end
	local vis = (not guiGetVisible(gui[1]))
	for i, v in ipairs(gui) do
		guiSetVisible(v, vis)
	end
	showCursor(vis)
	if (vis) then
		addEventHandler("onClientRender", root, dxPG)
	else
		removeEventHandler("onClientRender", root, dxPG)
	end
end
addCommandHandler("pg", toggle)
addEventHandler("onClientGUIClick", gui[1], toggle, false)