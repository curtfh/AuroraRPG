GUIEditor = {
    button = {},
    window = {},
    memo = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 720) / 2, (screenH - 316) / 2, 720, 316, "AuroraRPG Statement", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.memo[1] = guiCreateMemo(10, 22, 700, 255, "Hi,\nOur current administration had decided to shutdown AuroraRPG due to lack of support and motivation on the server. \nThe forum will be archieved and will be set to read only. \nYou can still chat with us at https://discord.gg/vHtChHW\nWe thank you all for staying with us! We hope you enjoyed to play AuroraRPG.\nThank you donators for keeping donating money to keep the server alive in the past months.\nDonators: Darkmeijer, Dioxide, Shruum, Smile^, prokid, redmercy, sonny, Tnohra, reda1x1\nThank you staffs, Samer, Curt, Frankin, Dioxide, Joseph, Revan, Paschi, Rapp, Cold, and DaJebne.\nThank you honorables, Dennis, Sensei, Epozide, Noki, Ameer, Jocke, Priyen, Smith, Ab-47, Darkness, Frenky, Angax, and Smiler.\nWe are asking you all to upload your memories at photos.aurorarpg.com\n\nArchived Forum: aurorarpg.com/archived Thank you all!", false, GUIEditor.window[1])
        guiMemoSetReadOnly(GUIEditor.memo[1], true)
        GUIEditor.button[1] = guiCreateButton(272, 284, 172, 22, "Disconnect", false, GUIEditor.window[1])    
		showCursor(true)
		setTimer(function()
			if (isCursorShowing() == false) then 
				showCursor(true)
			end 
		end, 500, 0)
		addEventHandler("onClientGUIClick", GUIEditor.button[1], function()
			triggerServerEvent ("AURDISCONNECTNOW", getLocalPlayer())
		end, false)
    end
)