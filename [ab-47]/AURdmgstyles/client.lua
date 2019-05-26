Lee = dxCreateFont("font.otf",13)
local damage = {}
local fortnite = ""
local px,py,pz,tx,ty,tz,Distance

function FortniteDamage ( attacker, weapon, bodypart, loss)
    --local source = getLocalPlayer ()
    local team_ = getPlayerTeam(localPlayer) or getTeamFromName("Unemployed")
    local team = getTeamName(team_)
    local attackOrigin = false
    --if Ele == attacker then return end
	local Ele = localPlayer
    -- Check if player is in staff team
    --outputDebugString ("Test -1")
	px,py,pz = getCameraMatrix(attacker)
    if (team == "Staff") then
        if (attacker and attacker == localPlayer and attacker ~= source and getElementAlpha(source) > 0) then
            if (wep == 0 or wep == 3) then
                adminslap = adminslap + 1
                if (adminslap > 2) then
                    outputDebugString ("triggerSlapz")
                else
                    outputDebugString ( "adminslap1" )    
                end
            end
    -- Check if the player is arrested or not
            if (getElementData(source, "arrested")) then -- I think it's exports.server:isPlayerWanted (source)
                if (attacker == localPlayer) then
                    outputDebugString ("you can't harm arrested players")
                    return
                end
            end
    -- Damage show
            --outputDebugString ("Test 0")
            --if (source ~= localPlayer ) then
           
                local loss = math.ceil(loss) or 0
                --if (attackOrigin == "player" and wep) then
                    if (attacker ~= localPlayer) then
                        if (not damage[attacker]) then
                            --outputDebugString ("Test 1")
                            addEventHandler("onClientRender",getRootElement(),
                                function()
                                local tx,ty,tz = getElementPosition(localPlayer)
                                Distance = math.sqrt((px-tx)^2 + (py-ty)^2 + (pz-tz)^2)
                                if Distance < 30.0 then
                                    if isLineOfSightClear(px,py,pz,tx,ty,tz,true,false,false,true,false,false,false,source) then
                                        local sx,sy,sz = getPedBonePosition(localPlayer,6)
                                        local x,y = getScreenFromWorldPosition(sx+0.119,sy+0,sz+0.2)
                                        if x then
                                            dxDrawText(" lost "..loss,x,y,x,y,tocolor(255,255,255),0.4+(15-Distance)*0.02,Lee)
                                        end
                                    end
                                end
                            end)
                        end
                    end
                --end
            --end
        end
    else
        if (attacker ~= localPlayer) then
            if (not damage[localPlayer]) then
                            --outputDebugString ("Test 1")
               triggerEvent("attacker.render", attacker, attacker, localPlayer)
            end
        end
    end
end
 
addEventHandler ( "onClientPlayerDamage", root, FortniteDamage )

function render(attacker, localPlayer)
addEventHandler("onClientRender",getRootElement(),
               function()
               local tx,ty,tz = getElementPosition(localPlayer)
               Distance = math.sqrt((px-tx)^2 + (py-ty)^2 + (pz-tz)^2)
                    if Distance < 30.0 then
                        if isLineOfSightClear(px,py,pz,tx,ty,tz,true,false,false,true,false,false,false,localPlayer) then
                        local sx,sy,sz = getPedBonePosition(attacker,6)
                        local x,y = getScreenFromWorldPosition(sx+0.119,sy+0,sz+0.2)
                            if x then
                            local r, g, b = getPlayerNametagColor ( Ele )
                            dxDrawText(" lost "..loss,x,y,x,y,tocolor(r, g, b),0.4+(15-Distance)*0.02,Lee)
                            end
                        end
                    end
                end)
end
addEvent("attacker.render", true)
addEventHandler("attacker.render", root, render)
--[[Lee = dxCreateFont("font.otf",13)
local damage = {}
local damageText = ""
local px,py,pz,tx,ty,tz,dist
px,py,pz = getCameraMatrix()
function FortniteDamage ( attacker, weapon, bodypart, loss)
    --local source = getLocalPlayer ()
    local team_ = getPlayerTeam(localPlayer) or getTeamFromName("Unemployed")
    local team = getTeamName(team_)
    local attackOrigin = false
    -- Check if player is in staff team
	--outputDebugString ("Test -1")
	if (team == "Staff") then
		if (attacker and attacker == localPlayer and attacker ~= source and getElementAlpha(source) > 0) then
			if (wep == 0 or wep == 3) then
				adminslap = adminslap + 1
				if (adminslap > 2) then
					outputDebugString ("triggerSlapz")
				else
					outputDebugString ( "adminslap1" )    
				end
			end
    -- Check if the player is arrested or not
			if (getElementData(source, "arrested")) then -- I think it's exports.server:isPlayerWanted (source)
				if (attacker == localPlayer) then
					outputDebugString ("you can't harm arrested players")
					return
				end
			end
    -- Damage show
			--outputDebugString ("Test 0")
			--if (source == localPlayer ) then
			
				local loss = math.ceil(loss) or 0
				--if (attackOrigin == "player" and wep) then
					if (attacker == localPlayer) then
					
						if (not damage[attacker]) then
							--outputDebugString ("Test 1")
							addEventHandler("onClientRender",getRootElement(),
								function()
								local tx,ty,tz = getElementPosition(attacker)
								Distance = math.sqrt((px-tx)^2 + (py-ty)^2 + (pz-tz)^2)
								if Distance < 30.0 then
									if isLineOfSightClear(px,py,pz,tx,ty,tz,true,false,false,true,false,false,false,source) then
										local sx,sy,sz = getPedBonePosition(attacker,6)
										local x,y = getScreenFromWorldPosition(sx+0.119,sy+0,sz+0.2)
										if x then
											dxDrawText("test",x,y,x,y,tocolor(255,255,255),0.4+(15-Distance)*0.02,"default")
											local health, amount = damage[attacker][1] or 0, damage[attacker][2] or 0
											damage[attacker] = {health + loss, amount + 1}  --- SOON
										else
											damage[attacker] = {loss, 1}
											fortnite = "LOST HP SOMEHOW"
										end
									elseif (attacker == localPlayer) then
										fortnite = "Lost "..loss.." HP"
									end
								elseif (not isElement(attacker)) then
									outputDebugString("iz nout element attackir")
								end
							end)
						end
					end
				--end
			--end
        end
	else
        outputDebugString ("else for team")
    end
end
addEventHandler ( "onClientPlayerDamage", root, FortniteDamage )]]