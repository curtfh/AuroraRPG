-- Table with positions
-- ID 1254 skull , 1242 armor, 1240 heart,

local positionTable = {
	{ 223.19, 1870.11,13.14, 3, "Law",1242 }, -- AAF
	{ 2552.88, 556.23, 12.97, 4, "Criminals", 1242}, -- The Terrorists
	{ 920.85, 1442.35, 23.2, 4, "Criminals", 1242}, -- The Cobras
	{ 2871.72, -322.6, 9.03, 4, "Law", 1242}, -- FBI
	
	--{ 3084.75, -3.98, 21.53, 3,"Law", 1242}, -- Special PoliceForce 
	--{ 3160.13, 2075.45, 14.6, 4, "Criminals", 1240}, -- Special Mafia
	--{ 313.95, 203.29, 5.83, 3, "Law", 1242}, -- Special Assault Team
	--{68, 321, 8.8, 3, "Law", 1242}, -- GIGN2019
	--{ 1934.1, 562.09, 22.27, 4, "Criminals", 1242}, -- DreamChacers
}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------YOU CAN ONLY MODIFY WHAT'S FIGURED UPSIDE-------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local CD={}
-- Table with pickups in
local pickupsTable = {}
local pickupsTable2 = {}

-- Create the pickups
for i=1,#positionTable do
    pickupsTable [ createPickup ( positionTable[i][1], positionTable[i][2], positionTable[i][3], 3, positionTable[i][6], 0 ) ] = { positionTable[i][4], positionTable[i][5] }
	pickupsTable2 = createMarker( positionTable[i][1], positionTable[i][2], positionTable[i][3],"corona",0.8,0,255,0,50)
end

-- On pickup hit
addEventHandler( "onPickupHit", root,
    function ( thePlayer )
        if ( pickupsTable[ source ] ) and not ( isPedInVehicle( thePlayer ) ) and ( getPlayerTeam( thePlayer ) ) then
            if ( pickupsTable[ source ][2] == getTeamName( getPlayerTeam( thePlayer ) ) ) or ( pickupsTable[ source ][2] == "Law" ) and ( exports.DENlaw:isPlayerLawEnforcer( thePlayer ) ) then
                if CD[thePlayer] == nil then CD[thePlayer]=false end
                if CD[thePlayer] == true then
                    exports.NGCdxmsg:createNewDxMessage(thePlayer,"You can't get this pickup at the moment, try again in a few seconds.",0,255,0)
                    cancelEvent()
                    return
                else

                CD[thePlayer]=true
                setTimer(function() CD[thePlayer]=false end,6000,1)
                if pickupsTable[ source ][2] == "Law" and getTeamName(getPlayerTeam(thePlayer)) ~= "Government Agency" then
                    giveWeapon(thePlayer,44,1)
                end
                if ( pickupsTable[ source ][1] == 1 ) then ---- armor
                    setPedArmor( thePlayer, 100 )
                elseif ( pickupsTable[ source ][1]  == 2 ) then --- armor and para
                    setPedArmor( thePlayer, 100 )
                    giveWeapon( thePlayer, 46, 1, true )
                elseif ( pickupsTable[ source ][1]  == 3 ) then --- health,armor and para
                    setPedArmor( thePlayer, 100 )
                    setElementHealth( thePlayer, 200 )
                    giveWeapon( thePlayer, 46, 1, true )
                elseif ( pickupsTable[ source ][1]  == 4 ) then -- health and armor
                    setPedArmor( thePlayer, 100 )
                    setElementHealth( thePlayer, 200 )
                elseif ( pickupsTable[ source ][1]  == 5 ) then --- health
                    setPedArmor( thePlayer, 100 )
                    setElementHealth( thePlayer, 200 )
                elseif ( pickupsTable[ source ][1]  == 6 ) then --- para
                    giveWeapon( thePlayer, 46, 1, true )
                end
                end
            else
                cancelEvent()
            end
        end
    end
)

	
