local mySkin = 09
local jobMarkersTable = {}
local peds = {}
local policeDesc = ""
local chooseWhat = ""
local theJobsTable = {
--COPS
    {"Government", "Government", 2348.11,2456.18,14.97,0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285 }, 10, nil, policeDesc, 85 },
    {"Government", "Government", -215.8, 973.69, 19.32, 0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 271.76470947266 },
    {"Government", "Government", -1395.03, 2646.44, 55.85, 0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 136.15838623047 },
    {"Government", "Government", -2161.64, -2385.5, 30.62, 0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 137.83932495117 },
    {"Government", "Government", 1574.700, -1634.300, 13.600, 0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 4.765380859375 },
    {"Government", "Government", 630.84, -569.06, 16.33, 0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 271.76470947266 },
    {"Government", "Government", -1622.52, 686.91, 7.18, 0, 156, 255, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 167.47540283203 },
	
    {"Government", "Government", 228.49, 1923.12, 17.64, 13, 132, 29, 3, { 265, 267, 280, 281, 282, 283, 288, 285}, 10, nil, policeDesc, 180 }, -- MF base
}


 
 
local employmentSkins = {
    ["Junior Officer"] = {71, 285}, -- the skin , Level = 1
    ["Traffic Officer"] = {284, 285}, -- the skin, Level = 2
    ["County Chief"] = {283,288, 285}, -- the skin, Level = 3
    ["Police Officer"] = {280,281,282,283,288, 285}, -- the skin, Level = 4
    ["Police Detective"] = {166, 285}, -- the skin, Level = 5
    ["NSA Agent"] = {165,285}, -- the skin, Level = 6
    ["FBI Agent"] = {166, 228 ,286, 285}, -- the skin, Level = 7
    ["National Task Force"] = {295,228,165,285,286,166}, -- the skin, Level = 8
    ["Advanced Assault Forces"] = {295,228,165,285,286,166},
    --["Military Soldier"] = {287,312,191, 285}, -- the skin, Level = 10
    --["SAPD Officer"] = {285,76, 285}, -- the skin, Level = 9
    }
 
local employments = {
{name="Junior Officer",level=1,arrest=0,arrestpoints=0,assists=0,turfstaken=0,info="Has no specialties except the LSPD cruiser as vehicle."},
    {name="Traffic Officer",level=2,arrest=25,arrestpoints=500,turfstaken=0,info="Able to: use a police bike and LSPD cruiser. Able to use speed cameras."},
    {name="County Chief",level=3,arrest=50,arrestpoints=2000,turfstaken=0,info="Able to spawn a Police Rancher and some off-road vehicles."},
    {name="Police Officer",level=4,arrest=100,arrestpoints=4000,turfstaken=0,info="Able to spawn PD cars."},
    {name="Police Detective",level=5,arrest=250,arrestpoints=5000,turfstaken=250,info="Gets faster cars than a police officer, such as Cheetah and Jester."},
    {name="NSA Agent",level=6,arrest=300,arrestpoints=6000,turfstaken=500,info="Able to spawn Police detective's car, plus Buffalo and Police Maverick."},
    {name="FBI Agent",level=7,arrest=500,arrestpoints=7000,turfstaken=750,info="Able to spawn FBI Truck, FBI Rancher, PD cars, Buffalo, Bullet, Maverick."},
    {name="National Task Force",level=8,arrest=700,arrestpoints=8000,turfstaken=1000,info="National Task Force units have access to a big variety of vehicles."},
    {name="Advanced Assault Forces",level=9,arrest=0,arrestpoints=0,turfstaken=0,info="Official Advanced Assault Forces duty.", group = "Advanced Assault Forces"},
    --{name="SAPD Officer",level=9,arrest=1200,arrestpoints=35000,assists=110,turfstaken=2500,cnr=150,info="Able to spawn Enforcer, PD cars, turismo, super-gt, maverick, raindance. SAPD Officers have a shield and a base where they can take armor and spawn their vehicles."},
    --{name="Military Soldier",level=10,arrest=2500,arrestpoints=80000,assists=200,turfstaken=5000,cnr=250,info="Access to every vehicle and specialties stated before, have a huge base."},
}
--arrest=0,arrestpoints=0,assists=0,turfstaken=0,cnr=0--name,level,arrest,arrestpoints,assists,turfstaken,cnr
local theSkins = {
[1] = {71},
[2] = {284},
[3] = {283},
[4] = {288},
[5] = {280},
[6] = {281},
[7] = {282},
[8] = {166},
[9] = {165},
[10] = {228},
[11] = {295},
[12] = {285},
}
function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end
--[[addEventHandler("onClientRender",getRootElement(),function ()
    for i,v in ipairs(getElementsByType("ped")) do
        if getElementData(v,"jobPed") then
            if getElementDimension(localPlayer) > 0 then return end
            local name = getElementData(v,"jobName")
            if ( not name ) then return end
            local x,y,z = getElementPosition(v)
            local x2,y2,z2 = getElementPosition(localPlayer)
            local cx,cy,cz = getCameraMatrix()
            if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 25 then
                local px,py = getScreenFromWorldPosition(x,y,z+1.3,0.06)
                if px then
                    if z2 <= z+4 then
                        local width = dxGetTextWidth(name,1,"sans")
                        local r,g,b = unpack(getElementData(v,"jobColor"))
                        dxDrawBorderedText(name, px, py, px, py, tocolor(r, g, b, 255), 2, "sans", "center", "center", false, false)
                    end
                end
            end
        end
    end
end)]]--
Gov = {
tab = {},
tabpanel = {},
label = {},
button = {},
window = {},
gridlist = {},
combobox = {}
}
Gov.window[1] = guiCreateWindow(58, 34, 695, 532, "AUR ~ Law Jobs", false)
guiWindowSetSizable(Gov.window[1], false)
guiSetVisible(Gov.window[1],false)
Gov.tabpanel[1] = guiCreateTabPanel(10, 65, 675, 457, false, Gov.window[1])
Gov.tab[1] = guiCreateTab("Information", Gov.tabpanel[1])
Gov.label[1] = guiCreateLabel(4, 10, 661, 22, "________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________", false, Gov.tab[1])
guiSetFont(Gov.label[1], "default-bold-small")
Gov.label[2] = guiCreateLabel(4, 51, 661, 16, "________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________", false, Gov.tab[1])
guiSetFont(Gov.label[2], "default-bold-small")
Gov.label[3] = guiCreateLabel(4, 22, 307, 39, "* Information about your duty", false, Gov.tab[1])
guiSetFont(Gov.label[3], "default-bold-small")
guiLabelSetVerticalAlign(Gov.label[3], "center")
Gov.gridlist[1] = guiCreateGridList(4, 77, 661, 345, false, Gov.tab[1])
guiGridListAddColumn(Gov.gridlist[1], "Arrests", 0.13)
guiGridListAddColumn(Gov.gridlist[1], "Arrest Points", 0.13)
guiGridListAddColumn(Gov.gridlist[1], "Assists", 0.11)
guiGridListAddColumn(Gov.gridlist[1], "Radio Turfs Taken", 0.18)
guiGridListAddColumn(Gov.gridlist[1], "Armoured truck escorts", 0.18)
guiGridListAddColumn(Gov.gridlist[1], "Police chief", 0.11)---guiGridListAddColumn(Gov.gridlist[1], "Law Rank", 0.13)
Gov.tab[2] = guiCreateTab("Employ", Gov.tabpanel[1])
Gov.button[1] = guiCreateButton(504, 353, 165, 25, "Take Job", false, Gov.tab[2])
guiSetProperty(Gov.button[1], "NormalTextColour", "FFFFFFFF")
Gov.gridlist[2] = guiCreateGridList(10, 69, 260, 351, false, Gov.tab[2])
guiGridListAddColumn(Gov.gridlist[2], "Occupation", 0.5)
guiGridListAddColumn(Gov.gridlist[2], "Level", 0.4)
Gov.label[16] = guiCreateLabel(316, 10, 343, 35, "Job requirements", false, Gov.tab[2])
guiLabelSetColor(Gov.label[16], 241, 185, 12)
guiLabelSetHorizontalAlign(Gov.label[16], "center", false)
Gov.label[11] = guiCreateLabel(31, 10, 213, 35, "Employ As", false, Gov.tab[2])
guiLabelSetColor(Gov.label[11], 241, 185, 12)
guiLabelSetHorizontalAlign(Gov.label[11], "center", false)
Gov.label[12] = guiCreateLabel(309, 62, 199, 22, "Arrest : N.A", false, Gov.tab[2])
guiSetFont(Gov.label[12], "default-bold-small")
Gov.label[13] = guiCreateLabel(309, 94, 199, 22, "Arrest Points: N.A", false, Gov.tab[2])
guiSetFont(Gov.label[13], "default-bold-small")--Gov.label[4] = guiCreateLabel(309, 126, 199, 22, "Assists: N.A", false, Gov.tab[2])--guiSetFont(Gov.label[4], "default-bold-small")
Gov.label[5] = guiCreateLabel(309, 126, 199, 22, "Radio Turfs Taken: N.A", false, Gov.tab[2])
guiSetFont(Gov.label[5], "default-bold-small")--Gov.label[6] = guiCreateLabel(309, 190, 199, 22, "CNR Participation: N.A", false, Gov.tab[2])--guiSetFont(Gov.label[6], "default-bold-small")
Gov.label[14] = guiCreateLabel(309, 220, 360, 65, "Specialties: ", false, Gov.tab[2])
guiSetFont(Gov.label[14], "default-bold-small")
guiLabelSetHorizontalAlign(Gov.label[14], "left", true)
Gov.label[7] = guiCreateLabel(280, 290, 389, 17, "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, Gov.tab[2])
Gov.label[8] = guiCreateLabel(280, 45, 389, 17, "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, Gov.tab[2])
Gov.label[9] = guiCreateLabel(10, 45, 260, 14, "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------", false, Gov.tab[2])
Gov.label[10] = guiCreateLabel(309, 313, 364, 30, "Choose Skin", false, Gov.tab[2])
guiLabelSetColor(Gov.label[10], 241, 185, 12)
guiLabelSetHorizontalAlign(Gov.label[10], "center", false)
Gov.combobox[1] = guiCreateComboBox(299, 353, 199, 80, "", false, Gov.tab[2])
--Gov.combobox[1] = guiCreateComboBox(299, 353, 199, 74, "Choose Skin", false, Gov.tab[2])
Gov.label[15] = guiCreateLabel(139, 30, 384, 35, "Welcome to Government Department", false, Gov.window[1])
guiLabelSetHorizontalAlign(Gov.label[15], "center", false)
guiLabelSetVerticalAlign(Gov.label[15], "center")
Gov.button[2] = guiCreateButton(533, 30, 152, 35, "Close", false, Gov.window[1])
guiSetProperty(Gov.button[2], "NormalTextColour", "FFAAAAAA")
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(Gov.window[1],false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(Gov.window[1],x,y,false)
addEventHandler("onClientGUIClick",root,function()
    if source == Gov.button[2] then
        guiSetVisible(Gov.window[1],false)
        showCursor(false)
    end
end)
function playerData(key)
    local data = exports.DENstats:getPlayerAccountData(localPlayer,key)
    if data == nil or data == false then data = 0 end
    return tonumber(data)
end
addEventHandler ( 'onClientGUIClick', root, function ( btn )
    if ( source == Gov.gridlist[2] ) then
        local row, col = guiGridListGetSelectedItem ( Gov.gridlist[2] )
        if ( row ~= -1 and col ~= 0 ) then
            local name = guiGridListGetItemText(Gov.gridlist[2], guiGridListGetSelectedItem(Gov.gridlist[2]), 1)
            for k,v in ipairs(employments) do
                if name == v.name then
                    chooseWhat = name
                    guiSetText(Gov.label[12],"Arrests: "..v.arrest)
                    guiSetText(Gov.label[13],"Arrest points: "..v.arrestpoints)
                    --guiSetText(Gov.label[4],"Assists: "..v.assists)
                    guiSetText(Gov.label[5],"Radio turfs taken: "..v.turfstaken)
                    --guiSetText(Gov.label[6],"Armoured truck escorts: "..v.cnr)
                    guiSetText(Gov.label[14],"Specialties: "..v.info)
                    guiComboBoxClear ( Gov.combobox[1] )
                    for k, v in pairs(employmentSkins) do
                        if k == name then
                            for index,value in ipairs(v) do
                                guiComboBoxAddItem(Gov.combobox[1],value)
                            end
                        end
                    end
                end
            end
        else
            guiSetText(Gov.label[12],"Arrests: N.A")
            guiSetText(Gov.label[13],"Arrest points: N.A")
            --guiSetText(Gov.label[4],"Assists: N.A")
            guiSetText(Gov.label[5],"Radio turfs taken: N.A")
            --guiSetText(Gov.label[6],"Armoured truck escorts: N.A")
            guiSetText(Gov.label[14],"Specialties: N.A")
            guiSetText(Gov.combobox[1],"")
            guiComboBoxClear ( Gov.combobox[1] )
            chooseWhat = ""
        end
    elseif source == Gov.button[1] then
        --local row, col = guiGridListGetSelectedItem ( Gov.gridlist[2] )
        --if ( row ~= -1 and col ~= 0 ) then
        if (chooseWhat ~= "") then
            --local name = guiGridListGetItemText(Gov.gridlist[2], guiGridListGetSelectedItem(Gov.gridlist[2]), 1)
            local name = chooseWhat
            for k,v in ipairs(employments) do
                if name == v.name then --- printing data
                    if (v.group) and (v.group ~= getElementData(localPlayer, "Group")) then return exports.NGCdxmsg:createNewDxMessage("You need to be a part of AAF to take this job!",255,0,0) end
                    local item = guiComboBoxGetSelected(Gov.combobox[1])
                    local skin = guiComboBoxGetItemText(Gov.combobox[1], item)
                    if not skin or skin == "" then
                        exports.NGCdxmsg:createNewDxMessage("Please take a class skin first!",255,0,0)
                        return  else
                    end
                    -- Keys : arrests,arrestpoints,tazerassists,radioTurfsTakenAsCop,armoredtrucks
                    local job = v.name
                    local jobSkin = skin
                    --local whoTable = {v.arrest,v.arrestpoints,v.assists,v.turfstaken,v.cnr}
                    triggerServerEvent("onPlayerTakeGovernmentJob",localPlayer,job,jobSkin,v.arrest,v.arrestpoints,v.turfstaken)
                end
            end
        else
            exports.NGCdxmsg:createNewDxMessage("Please choose your class first!",255,0,0)
        end
    end
end)--name,level,arrest,arrestpoints,assists,turfstaken,cnr
 
function onClientJobMarkerHit( hitElement, matchingDimension )
    if not matchingDimension then return false end
    local px,py,pz = getElementPosition ( hitElement )
    local mx, my, mz = getElementPosition ( source )
    local markerNumber = getElementData( source, "jobMarkerNumber" )
    if ( hitElement == localPlayer ) and ( pz-1.5 < mz ) and ( pz+1.5 > mz ) then
        if not isPedInVehicle(localPlayer) then
            if not ( getPedOccupiedVehicle (localPlayer) ) then
                local pts = theJobsTable[markerNumber][11]
                if pts >=10 then pts=math.floor(pts/10) end
                if getPlayerWantedLevel() >= pts then
                    exports.NGCdxmsg:createNewDxMessage( "Your wantedlevel is too high to take this job!", 225, 0, 0 )
                else
                    theHitMarker = source
                    setElementData ( localPlayer, "skinBeforeEnter", getElementModel ( localPlayer ), false )
                    triggerServerEvent("returnGovernmentData",localPlayer)
                    guiSetVisible( Gov.window[1], true )
                    showCursor( true )
                    setElementFrozen(localPlayer,true)
                    timer =  setTimer(function() check() end,5000,0)
                end
            end
        end
    end
end
function check()
    if guiGetVisible(Gov.window[1]) then
        showCursor(true)
    else
        if isTimer(timer) then killTimer(timer) setElementFrozen(localPlayer,false) end
    end
end
----name,level,arrest,arrestpoints,assists,turfstaken,cnr
function loadJobs(arrests,arrestspoints,assists,turfstaken,atescort)
    guiComboBoxClear ( Gov.combobox[1] )
    guiGridListClear( Gov.gridlist[1] )
    guiGridListClear( Gov.gridlist[2] )
    for k, v in ipairs ( employments ) do
    local name,level = v.name,v.level
    local row = guiGridListAddRow ( Gov.gridlist[2] )
    guiGridListSetItemText ( Gov.gridlist[2], row, 1, name, false, false )
    guiGridListSetItemText ( Gov.gridlist[2], row, 2, level, false, false )
    end
    --local arrests = playerData("arrests") --local arrestspoints =  playerData("arrestpoints") --local assists =  playerData("tazerassists")   --local turfstaken =  playerData("radioTurfsTakenAsCop")    --local atescort =  playerData("armoredtrucks")
    local pchief = getElementData(localPlayer,"polc")
    if pchief then polc = "Police Chief" else polc = "None" end
    local row = guiGridListAddRow ( Gov.gridlist[1] )
    guiGridListSetItemText ( Gov.gridlist[1], row, 1, arrests, true,true )
    guiGridListSetItemText ( Gov.gridlist[1], row, 2, arrestspoints, true, true )
    guiGridListSetItemText ( Gov.gridlist[1], row, 3, assists, true, true )
    guiGridListSetItemText ( Gov.gridlist[1], row, 4, turfstaken, true, true )
    guiGridListSetItemText ( Gov.gridlist[1], row, 5, atescort, true, true )
    guiGridListSetItemText ( Gov.gridlist[1], row, 6, polc, true, true )
end
addEvent("callBackGovernment",true)
addEventHandler("callBackGovernment",root,function(tazerassists,arrests,arrestpoints,rt,at)
    loadJobs(arrests,arrestpoints,tazerassists,rt,at)
end)
 
for i=1,#theJobsTable do
    local x, y, z = theJobsTable[i][3], theJobsTable[i][4], theJobsTable[i][5]
    local r, g, b = theJobsTable[i][6], theJobsTable[i][7], theJobsTable[i][8]
    jobMarkersTable[i] = createMarker( x, y, z -1, "cylinder", 2.0, r, g, b, 150)
    setElementData( jobMarkersTable[i], "jobMarkerNumber", i )
    local theSkin = theJobsTable[i][10][math.random(1,#theJobsTable[i][10])]
    local thePed = createPed ( theSkin, x, y, z )   table.insert(peds,thePed)
    setElementData(thePed,"jobPed",true)
    setElementData(thePed,"jobName",theJobsTable[i][1])
    setElementData(thePed,"jobColor",{r, g, b})
    setElementFrozen ( thePed, true )
    setPedRotation ( thePed, theJobsTable[i][14] )
    setElementData( thePed, "showModelPed", true )
    addEventHandler( "onClientMarkerHit", jobMarkersTable[i], onClientJobMarkerHit )
    local gblip = createBlip ( x, y,z, 56, 0, 0, 0, 255 )
    setBlipVisibleDistance(gblip, getBlipVisibleDistance(gblip) / 50)
end
setTimer(function()
    mySkin = mySkin + 1
    if mySkin > 11 then mySkin = 1 end
    for k,v in ipairs(peds) do
        setElementModel(v,theSkins[mySkin][1])
    end
end,5000,0)