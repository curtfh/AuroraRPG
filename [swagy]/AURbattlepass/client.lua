local screenW, screenH = guiGetScreenSize()
local font = dxCreateFont("files/font.ttf", 23, true, "cleartype_natural")
local positions = {
	
	["items"] = {0,0},
	["items2"] = {-screenW, 0},
	["battlepass"] = {screenW * 0.2430, screenH * 0.1862},
}


addEventHandler("onClientRender", root,
    function()
    	if not (getElementData(localPlayer, "showBattlePass")) then return false end
    	positions["items"][1] = positions["items"][1] + 2
    	if (positions["items"][1] == screenW) then
    		positions["items"][1] = -screenW
    	end
    	positions["items2"][1] = positions["items2"][1] + 2
    	if (positions["items2"][1] == screenW) then
    		positions["items2"][1] = -screenW
    	end
    	dxDrawImage(positions["items"][1], 0, screenW, screenH, ":AURbattlepass/images/items.png", 0, 0, 0, tocolor(255, 255, 255, 230), true)
    	dxDrawImage(positions["items2"][1], 0, screenW, screenH, ":AURbattlepass/images/items.png", 0, 0, 0, tocolor(255, 255, 255, 230), true)
    	dxDrawRectangle(0, 0, screenW, screenH, tocolor(0,0,0,180), true)
        dxDrawImage(screenW * 0.2410, screenH * 0.1842, screenW * 0.1135, screenH * 0.1940, ":AURbattlepass/images/pass.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Aurora RPG - Battle Pass\n- Season 1 - ", (screenW * 0.3741) - 1, (screenH * 0.1862) - 1, (screenW * 0.7511) - 1, (screenH * 0.3880) - 1, tocolor(0, 0, 0, 255), 2.00, font, "center", "center", false, false, true, false, false)
        dxDrawText("Aurora RPG - Battle Pass\n- Season 1 - ", (screenW * 0.3741) + 1, (screenH * 0.1862) - 1, (screenW * 0.7511) + 1, (screenH * 0.3880) - 1, tocolor(0, 0, 0, 255), 2.00, font, "center", "center", false, false, true, false, false)
        dxDrawText("Aurora RPG - Battle Pass\n- Season 1 - ", (screenW * 0.3741) - 1, (screenH * 0.1862) + 1, (screenW * 0.7511) - 1, (screenH * 0.3880) + 1, tocolor(0, 0, 0, 255), 2.00, font, "center", "center", false, false, true, false, false)
        dxDrawText("Aurora RPG - Battle Pass\n- Season 1 - ", (screenW * 0.3741) + 1, (screenH * 0.1862) + 1, (screenW * 0.7511) + 1, (screenH * 0.3880) + 1, tocolor(0, 0, 0, 255), 2.00, font, "center", "center", false, false, true, false, false)
        dxDrawText("Aurora RPG - Battle Pass\n- Season 1 - ", screenW * 0.3741, screenH * 0.1862, screenW * 0.7511, screenH * 0.3880, tocolor(66, 110, 244, 255), 2.00, font, "center", "center", false, false, true, false, false)
        dxDrawImage(screenW * 0.6816, screenH * 0.2839, screenW * 0.2592, screenH * 0.7031, ":AURbattlepass/images/player.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
    end
)


function toggleBattlePass (cmd)

	setElementData(localPlayer, "showBattlePass",not getElementData(localPlayer, "showBattlePass"))
    showCursor(getElementData(localPlayer, "showBattlePass"))
end
addCommandHandler("showpass", toggleBattlePass)