
rules = {
    label = {},
    window = {},
    staticimage = {},
    edit = {},
    gridlist = {},
    button = {},
    memo = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        rules.window[1] = guiCreateWindow((screenW - 695) / 2, (screenH - 625) / 2, 695, 625, "AuroraRPG - Community Rules", false)
        guiWindowSetSizable(rules.window[1], false)
        guiSetVisible( rules.window[1], false )
        guiWindowSetMovable( rules.window[1], false )

        rules.label[1] = guiCreateLabel(181, 149, 324, 16, "You have been forced to read the rules by : ", false, rules.window[1])
        rules.staticimage[1] = guiCreateStaticImage(15, 25, 657, 124, ":AURforceRules/logo.png", false, rules.window[1])
        rules.memo[1] = guiCreateMemo(15, 194, 667, 403, "", false, rules.window[1])
        rules.label[2] = guiCreateLabel(181, 169, 324, 15, "Time Left :", false, rules.window[1])
        rules.label[3] = guiCreateLabel(640, 602, 42, 13, "@Ashford", false, rules.window[1])  
        guiMemoSetReadOnly( rules.memo[1], true )  

        rules.window[2] = guiCreateWindow((screenW - 425) / 2, (screenH - 529) / 2, 425, 529, "AuroraRPG - Force Rules", false)
        guiWindowSetSizable(rules.window[2], false)
        guiSetVisible( rules.window[2], false )
        guiWindowSetMovable( rules.window[2], false )

        local rules_file = fileOpen( "rules/en.txt", true )
        local rules_content = fileRead( rules_file, 5000 )
        guiSetText( rules.memo[1], rules_content )



        rules.gridlist[1] = guiCreateGridList(16, 80, 211, 430, false, rules.window[2])
        guiGridListAddColumn(rules.gridlist[1], "PlayerName", 0.9)
        rules.edit[1] = GuiEdit(16, 53, 211, 22, "Playername...", false, rules.window[2])
        rules.label[4] = guiCreateLabel(19, 30, 208, 18, "Search for players...", false, rules.window[2])
        rules.edit[2] = GuiEdit(237, 80, 172, 28, "", false, rules.window[2])
        rules.label[5] = guiCreateLabel(238, 57, 171, 18, "Duration(Minutes)", false, rules.window[2])
        rules.button[1] = GuiButton(238, 118, 172, 26, "Force rules", false, rules.window[2])
        rules.button[2] = GuiButton(238, 154, 172, 26, "Unforce rules", false, rules.window[2])  
        rules.button[3] = GuiButton(237, 484, 172, 26, "Close", false, rules.window[2])
        
        for i=1, #rules.label do 
            if ( i == 3 ) then 
                guiSetFont( rules.label[i], "default-small" ) 
            else    
                guiSetFont( rules.label[i], "default-bold-small")
                guiLabelSetHorizontalAlign(rules.label[i], "center", false)
                guiLabelSetVerticalAlign(rules.label[i], "center")
            end
        end
    end
)





addEventHandler("onClientGUIChanged", root,
    function()
        if ( source == rules.edit[1] ) then 
            guiGridListClear( rules.gridlist[1] ) 
            for _, thePlayer in pairs( Element.getAllByType("player") ) do
                if string.find( string.lower( thePlayer.name ), string.lower( guiGetText( rules.edit[1] ) ) ) then 
                    local row = guiGridListAddRow( rules.gridlist[1] ) 
                    guiGridListSetItemText( rules.gridlist[1], row, 1, thePlayer.name, false, false )
                    if ( thePlayer.team ) then 
                        guiGridListSetItemColor( rules.gridlist[1], row, 1, thePlayer.team:getColor() )
                    else
                        guiGridListSetItemColor( rules.gridlist[1], row, 1, 255, 0, 0 ) 
                    end
                end
            end
        end
    end
)

addEvent("rules:showGUI", true )
addEventHandler("rules:showGUI", root, 
    function ()
        if ( guiGetVisible( rules.window[2] ) ) then return end
        guiSetVisible( rules.window[2], true )
        showCursor( true )
        reloadList()
    end
)


function reloadList()
    guiGridListClear( rules.gridlist[1] ) 
    for _, onlinePlayers in pairs( Element.getAllByType("player") ) do 
        local row = guiGridListAddRow( rules.gridlist[1] ) 
        guiGridListSetItemText( rules.gridlist[1], row, 1, onlinePlayers.name, false, false )
        if ( onlinePlayers.team ) then 
            guiGridListSetItemColor( rules.gridlist[1], row, 1, onlinePlayers.team:getColor() )
        else
            guiGridListSetItemColor( rules.gridlist[1], row, 1, 255, 0, 0 ) 
        end
    end
end

addEventHandler("onClientGUIClick", root, 
    function()
        if ( source == rules.button[1] ) then 
            forceRules()
        elseif ( source == rules.button[2] ) then 
            unforceRules()
        elseif ( source == rules.button[3] ) then 
            hideGUI()
        end
    end
)





function forceRules()
    local selectedRow = guiGridListGetSelectedItem( rules.gridlist[1] ) 
    if ( selectedRow == nil or selectedRow == -1 ) then 
        outputChatBox("You didn't select a player.", 255, 0, 0 ) 
    else
        local thePlayer = Player( guiGridListGetItemText( rules.gridlist[1], selectedRow, 1 ) )
        local duration = guiGetText( rules.edit[2] ) 
        local theAdmin = localPlayer.name
        if not ( duration:match('^%d+$') ) then 
            outputChatBox("Duration is invalid.", 255, 0, 0 )
        elseif ( duration:match("^%s*$") ) then 
            outputChatBox("Duration field can't be empty.", 255, 0, 0 )
        else
            triggerServerEvent("rules:forcerules", localPlayer, theAdmin, thePlayer, duration )
        end
    end
end



function unforceRules()
    local selectedRow = guiGridListGetSelectedItem( rules.gridlist[1] ) 
    if ( selectedRow == nil or selectedRow == -1 ) then 
        outputChatBox("You didn't select a player.", 255, 0, 0 ) 
    else
        local thePlayer = Player( guiGridListGetItemText( rules.gridlist[1], selectedRow, 1 ) )
        if ( thePlayer ) then 
            triggerServerEvent("rules:unforcerules", localPlayer, thePlayer )
        end
    end
end



function hideGUI()
    if ( not guiGetVisible( rules.window[2] ) ) then return end 
    guiSetVisible( rules.window[2], false ) 
    if isCursorShowing() then showCursor( false ) end 
end

isPlayerReading = false
forceDuration = nil
theStaff = nil

addEvent("rules:showrules", true )
addEventHandler("rules:showrules", root, 
    function( theAdmin, duration )
        if ( not isPlayerReading ) then 
            Timer( checkForce, 1000, 1 ) 
            isPlayerReading = true 
            forceDuration = ( duration * 60000 ) / 1000
            theStaff = theAdmin
        else
            forceDuration = ( duration * 60000 ) / 1000
            theAdmin = nil
        end
    end
)


function checkForce()
    if ( not isPlayerReading or forceDuration <= 0 ) then
        triggerServerEvent("rules:unforcerules", localPlayer, localPlayer )
        if ( guiGetVisible( rules.window[1] ) ) then
            guiSetVisible( rules.window[1], false )
            if isCursorShowing() then showCursor( false ) end
        end
        isPlayerReading = false
    else
        forceDuration = forceDuration - 1
        if ( not guiGetVisible( rules.window[1] ) ) then guiSetVisible( rules.window[1], true ) showCursor( true ) end
        guiSetText( rules.label[1], "You have been forced to read the rules by : "..theStaff )
        guiSetText( rules.label[2], "Time Left : "..forceDuration.." seconds" )
        localPlayer:setData("forceDuration", forceDuration )
        Timer( checkForce, 1000, 1 )
    end
end

addEvent("rules:removeforce", true )
addEventHandler("rules:removeforce", root,
    function()
        isPlayerReading = false 
        forceDuration = nil
    end
)