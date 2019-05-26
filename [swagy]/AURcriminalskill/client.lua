local x, y = guiGetScreenSize()

window = guiCreateWindow((x / 2) - (520 / 2), (y / 2) - (400 / 2), 551, 426, "AUR ~ Criminal Specialties", false)
guiWindowSetSizable(window, false)
grid = guiCreateGridList(20,50,600,250,false,window)
local column1 = guiGridListAddColumn( grid, "Type:", 0.22 )
local column2 = guiGridListAddColumn( grid, "Required Score:", 0.15 )
local column3 = guiGridListAddColumn( grid, "Information:", 0.9 )
btn = guiCreateLabel(150,340,250,35, "Choose skill from the list (Click to confirm).",false, window)
btnexit = guiCreateButton(220,380,90,35, "Close",false, window)
guiSetVisible(window,false)
guiSetFont(btn,"default-bold-small")
guiLabelSetColor(btn,255,255,0)

function setCrimSkills()
	guiSetVisible( window, true )
end

function removeCrimSkills()
	guiSetVisible( window, false )
end


addEventHandler( "onClientGUIClick", btnexit,
	function()
		if source == btnexit then
			showCursor(false)
			removeCrimSkills()
		end
	end
, false )



local elements = {
	{lbljob1,lbljob1desc,imgjob1},
	{lbljob2,lbljob2desc,imgjob2},
	{lbljob3,lbljob3desc,imgjob3},
	{lbljob4,lbljob4desc,imgjob4},
	{lbljob5,lbljob5desc,imgjob5},
	{lbljob6,lbljob6desc,imgjob6},
}
--2662.03,639.59,15.06,184
local poses = {
	{1404.45, -1300.74, 12.55,270},
	{1686.65,1214.43,9,272},
	{-2160.15, 649.58, 51.36,305},
	{2130.81, 2377.9, 9.82, 176 },
	{1879.65, 508.33, 22, 90 }, --DreamChasers
	{2567.68, 489.47, 13, 270 }, --The Terrorists

}--
--
local data = {
		{ "Petty Criminal", "The Regular Criminal is more successful in criminal activities then civilians.", 0 },--done
--		{ "Pick Pocket","Specialized thieves. Pickpockets rob less, but are much more successful.", 20 },--done
		--{ "Con Artist","Specialized thieves. Con artists are less successful, but rob much more.", 300 },--done
		--{ "Burglar", "Burglars are thieves. They are More successful at store robberies than others.", 550 },--done
		--{ "Drug Smuggler", "The drug smugglers are favourites at the drug factory. They craft drugs faster.", 800},--done
		{ "Smooth Talker ", "The smooth talker is has a way with words. Less trouble with the law", 500 },--done
		{ "Bomb Expert","The Bomb Expert has available to use bomb by /cmine ($5000)", 1000 },
		{ "Capo", "The right hand man to the Don.", 2500 },--done
		{ "Don of LV", "The Don of LV rules LV's streets. Reputation, faster and better turfing.", 5000 },--done
		{ "Assassin", "Assassin has no rules because my shot will kill the target!.", 20000 },--done
		--{ "Gas Mask", "Gas mask helps you to avoid tear gas affect", 5000 },--done
		-- Removed butcher as it fucked with the knife too much
		-- Assassin was removed due to its ability with the sniper
}

function monitorAbuse()
	local job = getElementData( localPlayer, "Rank" )
	local score = tonumber( getElementData( localPlayer, "playerScore" ) )
	if getPlayerTeam(localPlayer) then
		if getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals" or getTeamName( getPlayerTeam( localPlayer ) ) == "HolyCrap" then
			local team = getTeamName( getPlayerTeam( localPlayer ) )

			-- Make sure they aren't using restricted skills
			--if job == "Assassin" then
				--setElementData( localPlayer, "Rank", "Petty Criminal" )
			if job == "Butcher" then
				setElementData( localPlayer, "Rank", "Butcher" )
			end

			--[[
			if job == "Pick Pocket" and score < 20 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Con Artist" and score < 100 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Burglar" and score < 150 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Drug Smuggler" and score < 200 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Smooth Talker" and score < 250 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Bomb Expert" and score < 450 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Capo" and score < 650 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			elseif job == "Don of LV" and score < 800 then
				setElementData( localPlayer, "Rank", "Petty Criminal" )
			end
			--]]

			-- We make sure their matches what the skill requires (26/01/15 update by Noki)
			for index, skills in ipairs( data ) do
				if ( job == skills[1] ) then
					if ( score < skills[3] )then
						setElementData( localPlayer, "Rank", "Petty Criminal" )
					end
				end
			end
		end
	end
end
setTimer( monitorAbuse, 10000, 0 )

currPage = 1
function hitMarker(p)
	if p ~= localPlayer then return end
	if isPedInVehicle(p) == true then
		exports.NGCdxmsg:createNewDxMessage( "Exit your vehicle first before entering the marker", 255, 0, 0 )
		return
	else
		if getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals" and getTeamName(getPlayerTeam(localPlayer)) ~= "HolyCrap" then exports.NGCdxmsg:createNewDxMessage( "This marker is for criminals only!", 255, 255, 0 ) return end
		local mx, my, mz = getElementPosition(source) -- marker
        local hx, hy, hz = getElementPosition(p) -- hitelement ( player/vehicle etc. )
        if hz < mz+2 then
		exports.NGCdxmsg:createNewDxMessage( "Welcome to AUR Criminal Specialities Shop", 0, 255, 0 )
		guiSetVisible(window,true)
		setCrimSkills()
		showCursor(true)
		updateGUI(currPage)
	end
	end
end

addEventHandler( "onClientPlayerWasted", localPlayer,
	function()
		guiSetVisible( window, false )
		showCursor( false )
	end
)

for k,v in pairs( poses ) do
	local x,y,z = v[1],v[2],v[3]
	local m = createMarker( x,y,z, "cylinder", 2, 255, 0, 0, 0 )
	addEventHandler( "onClientMarkerHit", m, hitMarker )
	local ped = createPed( 2, x, y, z+1, v[4] )
	setElementFrozen( ped, true )
	setElementData( ped, "showModelPed", true, true)
end

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
addEventHandler("onClientRender",getRootElement(),function ()
	for i,v in ipairs(getElementsByType("ped",resourceRoot)) do
		if v then
			if getElementDimension(localPlayer) > 0 then return end
			local name = "Criminal skills"
			if ( not name ) then return end
			local x,y,z = getElementPosition(v)
			local x2,y2,z2 = getElementPosition(localPlayer)
			local cx,cy,cz = getCameraMatrix()
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 25 then
				local px,py = getScreenFromWorldPosition(x,y,z+1.8,0.06)
				if px then
					if z2 <= z+4 then
						local width = dxGetTextWidth(name,1,"sans")
						local r,g,b = 255,65,65
						dxDrawBorderedText(name, px, py, px, py, tocolor(r, g, b, 255), 2, "sans", "center", "center", false, false)
					end
				end
			end
		end
	end
end)

function createCriminalSkill(x,y,z,rot)
	if x and y and z then
		local m = createMarker( x,y,z, "cylinder", 2, 255, 0, 0, 0 )
		addEventHandler( "onClientMarkerHit", m, hitMarker )
		local ped = createPed( 2, x, y, z+1, rot )
		setElementFrozen( ped, true )
		setElementData( ped, "showModelPed", true, true)
	end
end


function updateGUI(pg)
	guiGridListClear( grid )
	for i=1,#data do
		local rank, req, info = data[i][1], data[i][3], data[i][2]
			local row = guiGridListAddRow(grid)
				guiGridListSetItemText(grid,row,1,rank,false,false)
					guiGridListSetItemText(grid,row,2,req,false,false)
						guiGridListSetItemText(grid,row,3,info,false,false)
							guiGridListSetItemData(grid,row,1,rank)
						guiGridListSetItemData(grid,row,2,req)
	         		guiGridListSetItemData(grid,row,3,info)
				if req then
					if tonumber(getElementData(localPlayer,"playerScore")) >= tonumber(req) then
			 			guiGridListSetItemColor(grid,row,1,255,200,0)
             				guiGridListSetItemColor(grid,row,2,255,200,0)
             			guiGridListSetItemColor(grid,row,3,255,200,0)
			 		else
             			guiGridListSetItemColor(grid,row,1,255,0,0)
             				guiGridListSetItemColor(grid,row,2,255,0,0)
             			guiGridListSetItemColor(grid,row,3,255,0,0)
					end
			 	end
			if getElementData(localPlayer,"Rank") == rank then
				guiGridListSetItemColor(grid,row,1,0,255,0)
				guiGridListSetItemColor(grid,row,2,0,255,0)
			guiGridListSetItemColor(grid,row,3,0,255,0)
		end
	end
end
antiSpam = false
function click()
--[[
	for k,v in pairs(elements) do
		if source == v[3] then
			updateGUI(currPage)
			myscore=tonumber(getElementData(localPlayer,"playerScore"))
			if myscore >= data[currPage][k][4] then
				triggerServerEvent("CSGcriminalskills.changed",localPlayer,data[currPage][k][1])
			else
				exports.NGCdxmsg:createNewDxMessage("You don't have enough score to become a "..data[currPage][k][1]..". You need "..data[currPage][k][4].." or more.",0,255,0)
				return
			end
		end
	end

	elseif source == btnforward then
		if currPage+1 < 3 then
			currPage=currPage+1
			updateGUI(currPage)
		end
	elseif source == btnprevious then
		if currPage-1 > 0 then
			currPage=currPage-1
			updateGUI(currPage)
		end
	end
	]]
if source == grid then
    local row = guiGridListGetSelectedItem(grid)
	    if row ~= nil and row ~= false and row ~= -1 then
            local id = guiGridListGetItemData(grid,row,2)

            local myscore = tonumber(getElementData(localPlayer,"playerScore"))
			for k,v in pairs(data) do
			if v[3] == id then
			if myscore >= v[3] then
				triggerServerEvent("CSGcriminalskills.changed",localPlayer,data[k][1])
			else
				exports.NGCdxmsg:createNewDxMessage("You don't have enough score to become a "..v[1]..". You need "..v[3].." or more.",0,255,0)
				return
			end
			end
			end
        else
			exports.NGCdxmsg:createNewDxMessage( "You didn't select any skill!", 255, 255, 0 )
		end
	end
end
addEventHandler( "onClientGUIClick", root, click )

addEvent("CSGcriminalskills.updateGUI",true)
addEventHandler("CSGcriminalskills.updateGUI",localPlayer,function() updateGUI(currPage) end)
