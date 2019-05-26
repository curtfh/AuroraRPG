local markers = {}

local poses = {
   {1569.63, -1634.14, 13.55,352},
   { 2347.94, 2452.33, 14.97,79},
   {-1622.93, 690.29, 7.18,44},

	--MF
    {230.21, 1923, 17, 175},
	
	--ssg
    --{2858.74,-86.83,43.98,270},
	--SWAT
    --{-321.41,1538.59,75.59,353},

}

local data = {

        {"Regular Officer","The regular officer has no extra perks or bonuses.",0,0},--done
        --{"Drug Squad","The Drug Squad can find more drugs easily, extra points at DS",50,10},--drug event
		{"The Mechanic","Has additional materials in his law vehicle. Eg. more pylons, barriers.",100,30},--den vehicles and csg veh inv
        {"Explosives Unit","Specializes in the field of explosives, ++ Damage! Also /lmine usage!",300,75},--csgwanted
        {"Bomb Squad","Specialized personnel which take less damage from explosives.",350,100},--csgwanted
        {"The Tank","Access to reinforced / tougher law vehicles. Look for license plate 'Re-enfor to identify.",400,100},--csg law skills

		{"Support Unit","Specialized Medics for the law, has some medical equipment",500,50},--den medic
		{"Task Force","Task Force units have stronger influence on radio tower locations then normal police.",1000,150}, --csg new turfing
		{"High Speed Unit","Access to Law Vehicles with optimized, faster engines and greater efficency.", 2000,200},
		{"Riot Squad","The final backup. They have the strongest influence, best at regulating the Lawinals of NGC.",3000,175}, --csg new turfing
		--{"Range Unit","Access to Law Sniper Rifle Extra damage weapon",5000,500},

}



currPage = 1

local x, y = guiGetScreenSize()

local window = guiCreateWindow((x / 2) - (520 / 2), (y / 2) - (400 / 2), 551, 426, "AuroraRPG ~ Law Specialties", false)
guiWindowSetSizable(window, false)
local grid = guiCreateGridList(20,50,600,250,false,window)
local column1 = guiGridListAddColumn( grid, "Type:", 0.22 )
local column2 = guiGridListAddColumn( grid, "Required Score:", 0.15 )
local column2 = guiGridListAddColumn( grid, "Required Arrest:", 0.15 )
local column3 = guiGridListAddColumn( grid, "Information:", 1 )
local btn2 = guiCreateLabel(150,340,250,35, "Choose skill from the list (click to confirm).",false, window)
local btn2exit2 = guiCreateButton(220,380,90,35, "Close",false, window)
guiSetVisible(window,false)
guiSetFont(btn2,"default-bold-small")
guiLabelSetColor(btn2,0,155,250)

function setLawSkills()
	guiSetVisible( window, true )
end

function removeLawSkills()
	guiSetVisible( window, false )
end


addEventHandler( "onClientGUIClick", btn2exit2,
	function()
		if source == btn2exit2 then
			showCursor(false)
			removeLawSkills()
		end
	end
, false )



function monitorAbuse()
	local job = getElementData( localPlayer, "skill" )
	local score = tonumber( getElementData( localPlayer, "playerScore" ) )
	if getPlayerTeam(localPlayer) then
		if exports.DENlaw:isLaw(localPlayer) then
			-- Make sure they aren't using restricted skills

			for index, skills in ipairs( data ) do
				if ( job == skills[1] ) then
					if ( score < skills[3] ) then
						setElementData( localPlayer, "Rank", "Regular Officer" )
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
    local px, py, pz = getElementPosition( localPlayer )
    local mx, my, mz = getElementPosition( source )
    if ( math.abs( pz-mz ) > 2 ) then
        return
    end
    if isPedInVehicle( p ) == true then
        exports.NGCdxmsg:createNewDxMessage( "Exit your vehicle before entering the marker", 255, 0, 0 )
        return
    else
        if not exports.DENlaw:isLaw( p ) then exports.NGCdxmsg:createNewDxMessage( "This marker restricted to law enforcement only!", 255, 255, 0) return end
        if poses[markers[source]].group ~= nil then
            if getElementData(p,"Group") ~= poses[markers[source]].group then
                exports.NGCdxmsg:createNewDxMessage( "This law skills marker is restricted to "..poses[markers[source]].group.." only", 255, 255, 0 )
                return
            end
        end
        exports.NGCdxmsg:createNewDxMessage( "Welcome to AUR's Law Specialities Shop", 255, 255, 255 )
        guiSetVisible( window, true )
        showCursor( true )
		updateGUI()
    end
end


addEventHandler( "onClientPlayerWasted", localPlayer,
	function( )
		guiSetVisible( window, false )
		showCursor( false )
	end
)

for k,v in pairs( poses ) do
    local x, y, z = v[1],v[2],v[3]
    local m = createMarker( x, y, z-1, "cylinder", 2, 0, 100, 200, 75 )
    addEventHandler( "onClientMarkerHit",m, hitMarker )
    local ped = createPed(281,x,y,z,v[4])
    if v.skin ~= nil then setElementModel( ped,v.skin ) end
	setElementData(ped,"jobPed",true)
	setElementData(ped,"jobName","Law Skills")
	setElementData(ped,"jobColor",{0, 150, 200})
    setElementFrozen( ped, true )
    markers[m] = k
    setElementData( ped, "showModelPed", true, true )
end



function updateGUI(pg)
	guiGridListClear( grid )
	for i=1,#data do
		local rank, req, info, arr = data[i][1], data[i][3], data[i][2], data[i][4]
			local row = guiGridListAddRow(grid)
				guiGridListSetItemText(grid,row,1,rank,false,false)
					guiGridListSetItemText(grid,row,2,req,false,false)
						guiGridListSetItemText(grid,row,3,arr,false,false)
						guiGridListSetItemText(grid,row,4,info,false,false)
							guiGridListSetItemData(grid,row,1,rank)
						guiGridListSetItemData(grid,row,2,req)
	         		guiGridListSetItemData(grid,row,3,arr)
	         		guiGridListSetItemData(grid,row,4,info)
				if exports.server:isPlayerLoggedIn(localPlayer) then
				if req and tonumber(req) and arr and tonumber(arr) then
					if tonumber(getElementData(localPlayer,"playerScore")) >= tonumber(req) and tonumber(exports.denstats:getPlayerAccountData(localPlayer,"arrests") or 0) >= tonumber(arr) then
			 			guiGridListSetItemColor(grid,row,1,0,150,255)
             				guiGridListSetItemColor(grid,row,2,0,150,255)
             			guiGridListSetItemColor(grid,row,3,0,150,255)
             			guiGridListSetItemColor(grid,row,4,0,150,255)
			 		else
             			guiGridListSetItemColor(grid,row,1,255,0,0)
             				guiGridListSetItemColor(grid,row,2,255,0,0)
             			guiGridListSetItemColor(grid,row,3,255,0,0)
             			guiGridListSetItemColor(grid,row,4,255,0,0)
						end
					end
			 	end
		if getElementData(localPlayer,"skill") == rank then
			guiGridListSetItemColor(grid,row,1,0,255,0)
			guiGridListSetItemColor(grid,row,2,0,255,0)
			guiGridListSetItemColor(grid,row,3,0,255,0)
			guiGridListSetItemColor(grid,row,4,0,255,0)
		end
	end
end
---exports.denstats:getPlayerAccountData
antiSpam = false
function click()
if source == grid then
    local row = guiGridListGetSelectedItem(grid)
	    if row ~= nil and row ~= false and row ~= -1 then
            local id = guiGridListGetItemData(grid,row,2)

            local myscore = tonumber(getElementData(localPlayer,"playerScore"))
			for k,v in pairs(data) do
			if v[3] == id then
				if exports.denstats:getPlayerAccountData(localPlayer,"arrests") < v[4] then
					exports.NGCdxmsg:createNewDxMessage("You don't have enough arrests to become a "..v[1]..". You need "..v[4].." or more.",255,255,0)
					return
				end
					if myscore >= v[3] then
						triggerServerEvent("NGClawskills.changed",localPlayer,data[k][1])
					else
						exports.NGCdxmsg:createNewDxMessage("You don't have enough score to become a "..v[1]..". You need "..v[3].." or more.",255,255,0)
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


addEvent("NGClawskills.updateGUI",true)
addEventHandler("NGClawskills.updateGUI",localPlayer,function() updateGUI(currPage) end)
