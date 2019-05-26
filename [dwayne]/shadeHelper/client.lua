--
-- c_key_auto_repeat.lua
--



-------------------------------------------------------------
-- Keyboard auto-repeat
-------------------------------------------------------------
KeyAutoRepeat = {}
KeyAutoRepeat.repeatDelay = 500					-- Wait before 1st repeat
KeyAutoRepeat.repeatRateInitial = 100			-- Delay between repeats (initial)
KeyAutoRepeat.repeatRateMax = 10				-- Delay between repeats (after key held for repeatRateChangeTime)
KeyAutoRepeat.repeatRateChangeTime = 2700		-- Amount of time to move between repeatRateInitial and repeatRateMax
KeyAutoRepeat.keydownInfo = {}

-- Result event - Same parameters as onClientKey
addEvent( "onClientKeyClick" )

-- Update repeats
function KeyAutoRepeat.pulse()
	for key,info in pairs(KeyAutoRepeat.keydownInfo) do
		local age = getTickCount () - info.downStartTime
		age = age - KeyAutoRepeat.repeatDelay	-- Initial delay
		if age > 0 then
			-- Make rate speed up as the key is held
			local ageAlpha = math.unlerpclamped( 0, age, KeyAutoRepeat.repeatRateChangeTime )
			local dynamicRate = math.lerp( KeyAutoRepeat.repeatRateInitial, ageAlpha, KeyAutoRepeat.repeatRateMax )

			local count = math.floor(age/dynamicRate)	-- Repeat rate
			if count > info.count then
				info.count = count
				triggerEvent("onClientKeyClick", resourceRoot, key )
			end
		end
	end
end
addEventHandler("onClientRender", root, KeyAutoRepeat.pulse )

-- When a key is pressed/release
function KeyAutoRepeat.keyChanged(key,down)
	KeyAutoRepeat.keydownInfo[key] = nil
	if down then
		KeyAutoRepeat.keydownInfo[key] = { downStartTime=getTickCount (), count=0 }
		triggerEvent("onClientKeyClick", resourceRoot, key )
	end
end
addEventHandler("onClientKey", root, KeyAutoRepeat.keyChanged)


-------------------------------------------------------------
-- Math extentions
-------------------------------------------------------------
function math.lerp(from,alpha,to)
    return from + (to-from) * alpha
end

function math.unlerp(from,pos,to)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end

function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.unlerpclamped(from,pos,to)
	return math.clamp(0,math.unlerp(from,pos,to),1)
end

--
-- c_tex_names.lua
--


local tostring = tostring

---------------------------------------
-- Local variables for this file
---------------------------------------
local myShader
local bShowTextureUsage = false
local uiTextureIndex = 1
local m_SelectedTextureName = ""
local scx, scy = guiGetScreenSize ()
local usageInfoList = {}


---------------------------------------
-- Startup
---------------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			return
		end

		-- Create shader
		local tec
		myShader, tec = dxCreateShader ( "tex_names.fx", 1, 0, false, "all" )
	end
)


---------------------------------------
-- Draw visible texture list
---------------------------------------
addEventHandler( "onClientRender", root,
	function()
		usageInfoList = engineGetVisibleTextureNames ()

		local iXStartPos = scx - 200;
		local iYStartPos = 0;
		local iXOffset = 0;
		local iYOffset = 0;

		if bShowTextureUsage then
			for key, textureName in ipairs(usageInfoList) do

				local bSelected = textureName == m_SelectedTextureName;
				local dwColor = bSelected and tocolor(255,220,128) or tocolor(224,224,224,204)

				if bSelected then
					dxDrawText( textureName, iXStartPos + iXOffset + 1, iYStartPos + iYOffset + 1, 0, 0, tocolor(0,0,0) )
				end
				dxDrawText( textureName, iXStartPos + iXOffset, iYStartPos + iYOffset, 0, 0, dwColor )

				iYOffset = iYOffset + 15
				if iYOffset > scy - 15 then
					iYOffset = 0;
					iXOffset = iXOffset - 200;
				end
			end
		end
	end
)


---------------------------------------
-- Handle keyboard events from KeyAutoRepeat
---------------------------------------
addEventHandler("onClientKeyClick", resourceRoot,
	function(key)
		if key == "g" then
			if getElementData(localPlayer,"isPlayerPrime") then
			moveCurrentTextureCaret( -1 )
			end
		elseif key == "h" then
			if getElementData(localPlayer,"isPlayerPrime") then
			moveCurrentTextureCaret( 1 )
			end
		elseif key == "k" then
			if getElementData(localPlayer,"isPlayerPrime") then
			bShowTextureUsage = not bShowTextureUsage
			end
		elseif key == "l" then
			if getElementData(localPlayer,"isPlayerPrime") then
			if m_SelectedTextureName ~= "" then
				setClipboard( m_SelectedTextureName )
				outputChatBox( "'" .. tostring(m_SelectedTextureName) .. "' copied to clipboard", 0, 225, 0 )
			end
			end
		end
	end
)


---------------------------------------
-- Change current texture
---------------------------------------
function moveCurrentTextureCaret( dir )

	if #usageInfoList == 0 then
		return
	end

	-- Validate selection in current texture list, or find closest match
	for key, textureName in ipairs(usageInfoList) do
		if m_SelectedTextureName <= textureName then
			uiTextureIndex = key
			break
		end
	end

	-- Move position in the list
	uiTextureIndex = uiTextureIndex + dir
	uiTextureIndex = ( ( uiTextureIndex - 1 ) % #usageInfoList ) + 1

	-- Change highlighted texture
	engineRemoveShaderFromWorldTexture ( myShader, m_SelectedTextureName )
	m_SelectedTextureName = usageInfoList [ uiTextureIndex ]
	engineApplyShaderToWorldTexture ( myShader, m_SelectedTextureName )

end
