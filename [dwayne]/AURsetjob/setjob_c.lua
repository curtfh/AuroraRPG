 local x, y = guiGetScreenSize()



    local theJobsTable = {

    --[ID] = { "occ", "team", skin, wep,r,g,b },

    [0] = { "Criminal", "Criminals", nil, nil,255,0,0 },

    [1] = { "SWAT Officer","SWAT Team", 293, 3,0,0,255 },

    [2] = { "Military Forces","Military Forces", 287, 3,0,150,0 },

    [3] = { "Government","Government", 280, 3,0,100,200 },

    [4] = { "Paramedic", "Paramedics", 274, 41,0,250,250 },

    [5] = { "Firefighter", "Civilian Workers", 277, nil,255,255,0 },

    [6] = { "Fisherman", "Civilian Workers", 35, nil, 255,255,0 },

    [7] = { "Bus Driver", "Civilian Workers", 253, nil, 255,255,0 },

    [8] = { "Trucker", "Civilian Workers", 15, nil, 255,255,0 },

    [9] = { "Mechanic", "Civilian Workers", 305, nil ,255,255,0 },

    [10] = { "Pilot", "Civilian Workers", 61, nil, 255,255,0 },

    [11] = { "Farmer", "Civilian Workers", 159, nil ,255,255,0 },

    [12] = { "Trash Collector","Civilian Workers", 16, nil ,255,255,0 },

    [13] = { "News Reporter", "Civilian Workers", 59, nil, 255,255,0 },

    [14] = { "Rescuer Man", "Civilian Workers", 45, nil ,255,255,0 },

    [15] = { "Lumberjack","Civilian Workers",27, nil ,255,255,0 },

    [16] = { "Limo Driver", "Civilian Workers", 61, nil, 255,255,0 },
	
	[17] = { "Postman", "Civilian Workers", 255, nil, 255,255,0 },
	
	[18] = { "Miner", "Civilian Workers", 27, nil, 255,255,0 },
	
	[19] = { "Firefighter", "Civilian Workers", 279, nil, 255,255,0 },



    }







    local setjobWindow = guiCreateWindow((x / 2) - (700 / 2), (y / 2) - (400 / 2), 680, 416, "Aurora ~ Employes", false)



    local jobsgrid = guiCreateGridList(350, 67, 300, 266, false, setjobWindow)

    local grid = guiCreateGridList(10, 67, 330, 266, false, setjobWindow)

    local gridCol1 = guiGridListAddColumn(grid, "Player", 0.5)

    local gridCol2 = guiGridListAddColumn(grid, "Occupation", 0.4)

    local column1 = guiGridListAddColumn(jobsgrid,"Occupation",0.4)

    local column2 = guiGridListAddColumn(jobsgrid,"Team",0.5)

    local set_Job = guiCreateButton(30, 350, 83, 36, "Set", false, setjobWindow)

    local set_Job2 = guiCreateButton(120, 350, 83, 36, "Kick", false, setjobWindow)

    local cancel = guiCreateButton(570, 350, 83, 36, "Close", false, setjobWindow)





    guiWindowSetMovable (setjobWindow, true)

    guiWindowSetSizable (setjobWindow, false)

    guiSetVisible (setjobWindow, false)





    for i=0,#theJobsTable do

            local occupation, team,r, g, b = theJobsTable[i][1], theJobsTable[i][2],theJobsTable[i][5],theJobsTable[i][6],theJobsTable[i][7]

            local row = guiGridListAddRow ( jobsgrid )

            guiGridListSetItemText ( jobsgrid, row, column1, occupation, false, false )

            guiGridListSetItemText ( jobsgrid, row, column2, team, false, false )

            guiGridListSetItemData ( jobsgrid, row, column1, i)

            guiGridListSetItemColor (jobsgrid,row,column1,r,g,b )

            guiGridListSetItemColor (jobsgrid,row,column2,r,g,b )

    end



    function togglesetjobWindow ()

            if (getPlayerTeam(localPlayer)) and (getTeamName (getPlayerTeam ( localPlayer )) == "Staff") then

                    if (guiGetVisible(setjobWindow)) then

                            guiSetVisible(setjobWindow, false)

                            showCursor(false)

                    else

                            guiSetVisible(setjobWindow, true)

                            showCursor(true)

                            addInGrid()

                    end

            end

    end

    addCommandHandler("setjob", togglesetjobWindow, false)



    function closeWindow ()

            guiSetVisible(setjobWindow, false)

            showCursor(false)

    end

    addEventHandler("onClientGUIClick", cancel, closeWindow, false)



    function addInGrid()

            guiGridListClear(grid)

        for key, player in ipairs(getElementsByType("player")) do

                     if getElementData(player,"isPlayerLoggedin") == true then

                            local name = getPlayerName(player)

                            local row = guiGridListAddRow(grid)

                            local r,g,b = getTeamColor(getPlayerTeam(player))

                            guiGridListSetItemText(grid, row, gridCol1, getPlayerName(player), false, false)

                            guiGridListSetItemColor (grid, row, gridCol1, r,g,b )

                            local occ = getElementData(player,"Occupation")

                            if occ then

                            guiGridListSetItemText(grid, row, gridCol2, occ, true, true)

                            end

                    end

            end

    end





    function setJob() -- check

            local row, column = guiGridListGetSelectedItem ( jobsgrid )

            if ( row ) and ( column ) then

                    local jobsID = guiGridListGetItemData ( jobsgrid, row, column )

                    if ( jobsID ) then

                            local occupation = theJobsTable[jobsID][1]

                            local team = theJobsTable[jobsID][2]

                            local skin = theJobsTable[jobsID][3]

                            local wep = theJobsTable[jobsID][4]

                            local co = guiGridListGetSelectedItem ( grid )

                            local name = guiGridListGetItemText ( grid, co, 1 )

                            if name then

                                    local target = getPlayerFromName(name)

                                    if target and getElementType(target) == "player" then

                                            exports.NGCdxmsg:createNewDxMessage("You have successfully changed "..getPlayerName(target).." job from "..getElementData(target,"Occupation").." to "..occupation, 0, 255, 0)

											if occupation == "Criminal" then

                                            triggerServerEvent("crimchangeJob", localPlayer, target)

											else

                                            triggerServerEvent("changeJob", localPlayer, target, occupation, team, skin,wep)

											end

                                            setTimer(addInGrid,1000,1)

                                    end

                            end

                    end

            end

    end

    addEventHandler("onClientGUIClick", set_Job, setJob, false)



    function kickJob() -- check

            local occupation = "Unemployed"

            local co = guiGridListGetSelectedItem ( grid )

            local name = guiGridListGetItemText ( grid, co, 1 )

            if name then

                    local target = getPlayerFromName(name)

                    if target and getElementType(target) == "player" then

                            exports.NGCdxmsg:createNewDxMessage("You have successfully kicked "..getPlayerName(target).." from his job", 0, 255, 0)

                            triggerServerEvent("kickPedFromJob", localPlayer, target, occupation)

                            setTimer(addInGrid,1000,1)

                    end

            end

    end

    addEventHandler("onClientGUIClick", set_Job2, kickJob, false)



    addEventHandler( "onClientPlayerQuit", root,function()

            addInGrid()

    end)

    addEventHandler ( "onClientPlayerChangeNick", root,function()

            addInGrid()

    end)
