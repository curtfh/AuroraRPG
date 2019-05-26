-- Tables
local groupBlips = {}
local allianceBlips = {}
local playerBlips = {}

-- Stuff that handles the group blips and tags
local enableGroupTags = false
local enableGroupBlips = true
local enableAllianceBlips = exports.densettings:getPlayerSetting("allianceblips")

addEvent( "onClientSwitchGroupBlips" )
addEventHandler( "onClientSwitchGroupBlips", localPlayer,
	function ( state )
		enableGroupBlips = state
	end
)

addEvent( "onClientSwitchGroupTags" )
addEventHandler( "onClientSwitchGroupTags", localPlayer,
	function ( state )
		enableGroupTags = state
	end
)

-- Create a blip for whenever a player joins
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ),
	function ()
		for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
			if not ( playerBlips[thePlayer] ) then
				playerBlips[thePlayer] = createBlipAttachedTo( thePlayer, 0, 2, 0, 0, 0, 500 )
				setBlipVisibleDistance( playerBlips[thePlayer], 99999999 )
			end
		end
	end
)

addEventHandler( "onClientPlayerJoin", root,
	function()
		if not ( playerBlips[source] ) then
			playerBlips[source] = createBlipAttachedTo( source, 0, 2, 0, 0, 0, 500 )
			setBlipVisibleDistance( playerBlips[source], 99999999 )
		end
	end
)



local settings = {"radar","allianceblips"}
function setAS( theSetting,value )
		if ( theSetting == "radar" ) then
			if value == false then
				for k,v in pairs(playerBlips) do
					setBlipVisibleDistance( v, 500 )
				end
			else
				for k,v in pairs(playerBlips) do
					setBlipVisibleDistance( v, 99999999 )
				end
			end
		elseif theSetting == "allianceblips" then
			enableAllianceBlips = value
			onAllianceBlipsSettingChange()
		end
	end
function checkSetting()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		for k,v in ipairs(settings) do
			local setting = exports.DENsettings:getPlayerSetting(v)
			setAS(v,setting)
		end
	else
		setTimer( checkSetting, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSetting )
setTimer( checkSetting, 5000, 0 )


function onAllianceBlipsSettingChange()
	local myAlliance = getElementData(localPlayer,"alliance")
	if myAlliance then
		--exports.AURgroups:alliances_getAllianceSettings(myAlliance)
	end
	--outputDebugString("onAllianceBlipsSettingChange:enableAllianceBlips: "..tostring(enableAllianceBlips))
end
addEvent("alliances_receiveAllianceSettings",true)
function receiveAllianceSettings(settings)
	if settings.forceBlips then
		enableAllianceBlips = true
		outputDebugString("receiveAllianceSettings:enableAllianceBlips: "..tostring(enableAllianceBlips))
	end
end
addEventHandler("alliances_receiveAllianceSettings",root,receiveAllianceSettings)
onAllianceBlipsSettingChange()


-- The actual blip stuff
setTimer(
	function ()
		local myGroup = getElementData(localPlayer,"Group")
		local myAlliance = getElementData(localPlayer,"alliance")
		for thePlayer, theBlip in pairs( playerBlips ) do
			if ( isElement( thePlayer ) ) and ( thePlayer ~= localPlayer ) then
				if ( getPlayerTeam( thePlayer ) ) then
					local theirGroup = getElementData(thePlayer,"Group")
					local r,g,b = getPlayerNametagColor(thePlayer)
					setBlipColor(theBlip,r,g,b,255)
					local theirAlliance = getElementData(thePlayer,"alliance")
					--if ( enableGroupBlips ) then
					if (exports.server:isPlayerLoggedIn(thePlayer)) then
						if ( myGroup ) and ( theirGroup ) and (myGroup ~= "None") then
							if ( myGroup == theirGroup ) and (getElementAlpha(thePlayer) > 0) then
								if not ( groupBlips[thePlayer] ) then
									groupBlips[thePlayer] = createBlipAttachedTo ( thePlayer, 60, 0, 0, 0, 0, 0, 0, 500 )
									setBlipVisibleDistance( groupBlips[thePlayer], 99999999 )
								end
							elseif (myGroup ~= theirGroup) then
								if ( isElement( groupBlips[thePlayer] ) ) then
									destroyElement( groupBlips[thePlayer] )
									groupBlips[thePlayer] = nil
								end								
							end
						end
					else
						if ( isElement( groupBlips[thePlayer] ) ) then
							destroyElement( groupBlips[thePlayer] )
							groupBlips[thePlayer] = nil
						end
					end
					local shouldHaveAllianceBlip = false
					if ( enableAllianceBlips ) then
						if ( myGroup ) and ( theirGroup ) then
							if ( myGroup ~= theirGroup ) then
								if ( myAlliance and theirAlliance ) and ( myAlliance == theirAlliance ) then
									shouldHaveAllianceBlip = true
									if not ( allianceBlips[thePlayer] ) then
										allianceBlips[thePlayer] = createBlipAttachedTo ( thePlayer, 62, 0, 0, 0, 0, 0, 0, 500 )
										setBlipVisibleDistance( allianceBlips[thePlayer], 99999999 )
									end
								end
							end
						end
					end
					if (getElementAlpha(thePlayer) == 0) and isElement(groupBlips[thePlayer]) then
						destroyElement( groupBlips[thePlayer] )
						groupBlips[thePlayer] = nil
					end
					if not ( shouldHaveAllianceBlip ) or not ( enableAllianceBlips ) then
						if ( isElement( allianceBlips[thePlayer] ) ) then
							destroyElement( allianceBlips[thePlayer] )
							allianceBlips[thePlayer] = nil
						end
					end
		--			outputDebugString("shouldHaveAllianceBlip: "..tostring(shouldHaveAllianceBlip))

					if ( enableGroupTags ) then
						if ( getElementData( localPlayer, "Group" ) ~= "None" ) and ( getElementData( thePlayer, "Group" ) ~= "None" ) then
							if ( getElementData( localPlayer, "Group" ) == getElementData( thePlayer, "Group" ) ) then
								setPlayerNametagColor ( thePlayer, 142, 56, 142 )
							end
						end
					else
						local r,g,b = getTeamColor( getPlayerTeam( thePlayer ) )
						local gr = getElementData(thePlayer,"Group")
						if exports.AURgroups:isGroup(thePlayer,gr,"crim") then
							r,g,b = exports.AURgroups:getGroupColor(gr)
						end
						if exports.AURgroups:isGroup(thePlayer,gr,"law") then
							r,g,b = exports.AURgroups:getGroupColor(gr)
						end
						if getPlayerTeam(thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "CS:GO" then
							if getElementData(thePlayer,"CS:GO Team") == "Counter-Terrorists" then
								r,g,b = 0,150,200
							elseif getElementData(thePlayer,"CS:GO Team") == "Terrorists" then
								r,g,b = 255,0,0
							end
						end
						setPlayerNametagColor ( thePlayer, r,g,b )
					end

					local r,g,b = getTeamColor( getPlayerTeam( thePlayer ) )
					local gr = getElementData(thePlayer,"Group")
					if exports.AURgroups:isGroup(thePlayer,gr,"crim") then
						r,g,b = exports.AURgroups:getGroupColor(gr)
					end
					if exports.AURgroups:isGroup(thePlayer,gr,"law") then
						r,g,b = exports.AURgroups:getGroupColor(gr)
					end
					if getPlayerTeam(thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "CS:GO" then
						if getElementData(thePlayer,"CS:GO Team") == "Counter-Terrorists" then
							r,g,b = 0,150,200
						elseif getElementData(thePlayer,"CS:GO Team") == "Terrorists" then
							r,g,b = 255,0,0
						end
					end
					setBlipColor(theBlip,r,g,b,255)




					local gr = getElementData(thePlayer,"Group")
					if exports.AURgroups:isGroup(thePlayer,gr,"crim") then
						r,g,b = exports.AURgroups:getGroupColor(gr)
					end
					if exports.AURgroups:isGroup(thePlayer,gr,"law") then
						r,g,b = exports.AURgroups:getGroupColor(gr)
					end

					if getPlayerTeam(thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "CS:GO" then
						if getElementData(thePlayer,"CS:GO Team") == "Counter-Terrorists" then
							r,g,b = 0,150,200
						elseif getElementData(thePlayer,"CS:GO Team") == "Terrorists" then
							r,g,b = 255,0,0
						end
					end
					if ( getElementAlpha( thePlayer ) == 0 ) then

						setBlipColor( theBlip, 225, 225, 225, 0 )



					else

						local R, G, B = getTeamColor( getPlayerTeam( thePlayer ) )


						local gr = getElementData(thePlayer,"Group")
						if exports.AURgroups:isGroup(thePlayer,gr,"crim") then
							R,G,B = exports.AURgroups:getGroupColor(gr)
						end
						if exports.AURgroups:isGroup(thePlayer,gr,"law") then
							R,G,B = exports.AURgroups:getGroupColor(gr)
						end
						if getPlayerTeam(thePlayer) and getTeamName(getPlayerTeam(thePlayer)) == "CS:GO" then
							if getElementData(thePlayer,"CS:GO Team") == "Counter-Terrorists" then
								R,G,B = 0,150,200
							elseif getElementData(thePlayer,"CS:GO Team") == "Terrorists" then
								R,G,B = 255,0,0
							end
						end
						setBlipColor( theBlip, R, G, B, 225 )
						if getElementData(resourceRoot,"hideandseek") == true then
							if getElementDimension(theBlip) == 2000 then
								setBlipColor(theBlip,R,G,B,0)
							else
								setBlipColor(theBlip,R,G,B,225)
							end
						end
						if exports.AURaghost:isPlayerInGhostMode(thePlayer) then
							setBlipColor(theBlip, R, G, B, 0)
						else
							setBlipColor(theBlip, R, G, B, 255)
						end
					end


				end
			end
		end
	end
,1000,0)

addEventHandler("onClientPlayerQuit",root,
	function ()
		if ( isElement( groupBlips[source] ) ) then
			destroyElement( groupBlips[source] )
			groupBlips[source] = nil
		end
		if ( isElement( allianceBlips[source] ) ) then
			destroyElement( allianceBlips[source] )
			allianceBlips[source] = nil
		end
		if ( isElement( playerBlips[source] ) ) then
			destroyElement( playerBlips[source] )
			playerBlips[source] = nil
		end
	end
)

addEvent( "deleteGroupBlip", true )
addEventHandler( "deleteGroupBlip", root,
	function ( thePlayer )
		if ( isElement( groupBlips[thePlayer] ) ) then
			destroyElement( groupBlips[thePlayer] )
			groupBlips[thePlayer] = nil
		end
	end
)


local ms = false
addEventHandler("onClientRender",root,function()
	if getElementDimension(localPlayer) == 2000 then
		if getElementData(resourceRoot,"hideandseek") == true then
			if getPlayerTeam(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) ~= "Staff" then
				if getElementDimension(localPlayer) == 2000 then
					toggleControl("aim_weapon",false)
					toggleControl("fire",false)
					ms = true
				end
			end
		end
	end
end)

addEventHandler("onClientPlayerWasted",root,function()
	if ms == true then
		toggleControl("aim_weapon",true)
		toggleControl("fire",true)
		ms = false
	end
end)
