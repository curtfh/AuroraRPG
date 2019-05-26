

-- the efect settings
local colorizePed = {}
local specularPower = 1.3
local effectMaxDistance = 10
local isPostAura = true

-- don't touch
local scx, scy = guiGetScreenSize ()
local myRT = nil
local myShader = nil
local isMRTEnabled = false
local wallShader = {}
local PWTimerUpdate = 110
effectOn = false
pwEffectEnabled = false

function enablePedWall(isMRT)
	if isMRT and isPostAura then
		myRT = dxCreateRenderTarget(scx, scy, true)
		myShader = dxCreateShader("fx/post_edge.fx")
		if not myRT or not myShader then
			isMRTEnabled = false
			return
		else
			dxSetShaderValue(myShader, "sTex0", myRT)
			dxSetShaderValue(myShader, "sRes", scx, scy)
			isMRTEnabled = true
		end
	else
		isMRTEnabled = false
	end
	effectOn = true
	pwEffectEnabled = true
	enablePedWallTimer(isMRTEnabled)
end

function disablePedWall()
	pwEffectEnabled = false
	effectOn = false
	disablePedWallTimer()
	if isElement(myRT) then
		destroyElement(myRT)
	end
	isMRT = false
end

function createWallEffectForPlayer(thisPlayer, isMRT)
    if not wallShader[thisPlayer] then
		if isMRT then
			wallShader[thisPlayer] = dxCreateShader("fx/ped_wall_mrt.fx", 1, 0, true, "ped")
		--	outputDebugString("MRT pass")
		else
			wallShader[thisPlayer] = dxCreateShader("fx/ped_wall.fx", 1, 0, true, "ped")
		--	outputDebugString("MRT fail")
		end
		if not wallShader[thisPlayer] then return false
		else
			if myRT then
				dxSetShaderValue (wallShader[thisPlayer], "secondRT", myRT)
			end
			local r,g,b = getTeamColor(getPlayerTeam(thisPlayer))
			colorizePed[thisPlayer] = {r,g,b,255}
			dxSetShaderValue(wallShader[thisPlayer], "sColorizePed",colorizePed[thisPlayer])
			dxSetShaderValue(wallShader[thisPlayer], "sSpecularPower",specularPower)
			engineApplyShaderToWorldTexture ( wallShader[thisPlayer], "*" , thisPlayer )
			engineRemoveShaderFromWorldTexture(wallShader[thisPlayer],"muzzle_texture*", thisPlayer)
			--if getElementAlpha(thisPlayer)==255 then setElementAlpha(thisPlayer, 254) end
			return true
		end
    end
end


function destroyShaderForPlayer(thisPlayer)
    if wallShader[thisPlayer] then
		engineRemoveShaderFromWorldTexture(wallShader[thisPlayer], "*" , thisPlayer)
		destroyElement(wallShader[thisPlayer])
		wallShader[thisPlayer] = nil
	end
end

function enablePedWallTimer(isMRT)
	if PWenTimer then
		return
	end
	PWenTimer = setTimer(	function()
		--if pwEffectEnabled then
			for index,thisPlayer in ipairs(getElementsByType("player")) do
				if isElementStreamedIn(thisPlayer) and thisPlayer~=localPlayer then
						local hx,hy,hz = getElementPosition(thisPlayer)
						local cx,cy,cz = getCameraMatrix()
						local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
						local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, thisPlayer)
						if (dist<effectMaxDistance ) and not isItClear and effectOn then
							createWallEffectForPlayer(thisPlayer, isMRT)
						end
						if (dist>effectMaxDistance ) or  isItClear or not effectOn then
							destroyShaderForPlayer(thisPlayer)
						end
				end
				if not isElementStreamedIn(thisPlayer) then destroyShaderForPlayer(thisPlayer) end
			end
		--end
	end
	,PWTimerUpdate,0 )
end

function disablePedWallTimer()
	if PWenTimer then
		for index,thisPlayer in ipairs(getElementsByType("player")) do
			destroyShaderForPlayer(thisPlayer)
		end
		if isTimer(PWenTimer) then killTimer( PWenTimer ) end
		PWenTimer = nil
	end
end

addEventHandler( "onClientPreRender", root,
    function()
		if not pwEffectEnabled or not isMRTEnabled then return end
		-- Clear secondary render target
		dxSetRenderTarget( myRT, true )
		dxSetRenderTarget()
    end
, true, "high" )

addEventHandler( "onClientHUDRender", root,
    function()
		if not pwEffectEnabled or not isMRTEnabled then return end
		-- Show contents of secondary render target
		dxDrawImage( 0, 0, scx, scy, myShader )
    end
)
