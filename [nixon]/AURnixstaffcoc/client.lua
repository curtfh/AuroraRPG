function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end 

stuff = {
    label = {},
    window = {},
    staticimage = {},
    memo = {}
}
showCursor(false)
addEventHandler("onClientResourceStart", resourceRoot, function()
        window = guiCreateWindow(71, 10, 902, 741, "AuroraRPG ~ Staff code of conduct", false)
		guiWindowSetSizable(window, false)
        centerWindow (window)
        guiSetVisible(window, false)

        label1 = guiCreateLabel(59, 140, 882, 84, "Hello Community Members, through this panel you can read staff code of conduct incase if any staff member broke anyone of these rules!", false, window)
        guiSetFont(label1, "default-bold-small")
        guiLabelSetHorizontalAlign(label1, "left", true)
        memo = guiCreateMemo(9, 197, 883, 534, "0. There must be 3+ staff members online if the online players count is 30+\n1. You're not allowed to spend your time playing other servers, dedicate yourself and efforts in aurora in order to remain as Aurora staff member.\n2. You must always act professional and mature.\n3. You must always answer a question in the support chat if you know the answer.\n4. You're expected to spend a high amount of time focusing on your work, you're obliged to be on duty when there is 15+ players on duty, even if there is other staffs on duty.\n5. If you're the only staff online you must be on staff duty.\n6. You must never ask for a promotion, your time will come, don't worry.\n7. Don't spam the AUR chat.\n8. You must always obey the server and forum rules.\n9. You are not allowed to be a staff or a supporter on another server.\n10. If required, you're expected to be able to work with staff as a team.\n11. Trolling another player or making fun of him when he's asking a question will result in a kick.\n12. Do not spam the supporter chat.\n13. Don't annoy any other staff, just because you're taking a break, doesn't mean they do.\n14. As a Staff your first priority is to help other players.\n15. You are not allowed to misuse or abuse your administrative powers given, in any way.\n16. You are not allowed to jail/mute another supporter/staff unless it is REALLY needed.\n17. No loopholes in the Code of Conduct.\n18. You are not a better person or a player because you're a Staff.\n19. You are not allowed to share any information from the ingame staff chat or the staff board to any non-staff.\n20. Do not warp to any other admin unless asked to or given permission to upon asking them.\n21. Your powers are not for personal gain! Do not use any powers \"just for fun\".\n22. You are allowed to argue with another staff, but on a MATURE LEVEL ONLY!\n23. If you're a Board Moderator on a forum board, you're expected to add that as one of your daily duties.\n24. If you're a Board Moderator on General Discussion Board, you are still not allowed to edit the Staff / Special Duties Roster. Only L3 to L6 are allowed to do this.\n25. If you warp to another staff and they ask you to leave, you must leave and are not allowed to just go invisible and stay. Exceptions for a higher staff rank than you (if you want them to leave, ask nicely).\n26. Don't use CAPS LOCK in the admin or supporter chat.\n27. Don't enter staff job if you're wanted.\n28. You are allowed to chat in the admin chat, but don't say for example \"ORLY?\" \"GTFO\" and so on.\n29. If you accidentally enter staff job while wanted, do not adminjail yourself!\n30. You're not allowed to remove [AUR] staff, because new player know that you can help by this tag.\n31. You are not allowed to ignore staff duty if someone called for a help you have to help him instantly and if you were AFK you have to put [AUR]Nick[AFK] or Any AFK Tag\n32. You should always warn a person verbally for breaking a server rule and only punish instantly if they proceed to break the rules.\n33. You MUST be on duty unless players are less than 10.\n34. You're not allowed to discuss a head staff's decision, unless you have a valid proof to argue.", false, window)
        guiMemoSetReadOnly(memo, true)
        label2 = guiCreateLabel(38, 165, 844, 32, "Also if you have been punished unfairly by a staff member, don't report him for that but head to the Punishment Appeal section and fullfill the format with your information instead!", false, window)
        guiSetFont(label2, "default-bold-small")
        guiLabelSetHorizontalAlign(label2, "left", true)    
		image = guiCreateStaticImage(9, 24, 883, 106, "disc.png", false, window)
            end
)

addCommandHandler("coc",function()
    if localPlayer then
	  if ( guiGetVisible( window, true ) ) then
		guiSetVisible ( window, false )
		showCursor( false )
	else
	guiSetVisible( window, true )
	showCursor( true )
	end
  end
 end)