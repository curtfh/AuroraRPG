local currentBlockNameSelected = "fortnite"
local IFP = engineLoadIFP( "Animations/dancing.ifp", currentBlockNameSelected )
local isLocalPlayerAnimating = false
local sound = {}
local allowedKeys = {
	["mouse1"] = true,
	["t"] = true,
	["y"] = true,
	["u"] = true,
	["F8"] = true,
	["enter"] = true,
	["~"] = true
}

addCommandHandler("fortnite", function(cmd, animName)
	if (not IFP) then return false end
	setPedAnimation ( localPlayer, false )
	isLocalPlayerAnimating = false
	triggerServerEvent ( "onCustomAnimationSet", resourceRoot, localPlayer, false, false )
	
	setPedAnimation ( localPlayer, currentBlockNameSelected, animName )
	triggerServerEvent ("onCustomAnimationSet", resourceRoot, localPlayer, currentBlockNameSelected, animName )
	isLocalPlayerAnimating = true
end)

addCommandHandler("stopfortnite", function()
	setPedAnimation ( localPlayer, false )
	isLocalPlayerAnimating = false
	triggerServerEvent ( "onCustomAnimationSet", resourceRoot, localPlayer, false, false )
end)

addEventHandler("onClientKey", root,
	function(btn, press)
		if (press) then
			if not (allowedKeys[btn]) then
				local block, name = getPedAnimation(localPlayer)
				if (block == currentBlockNameSelected) then
					setPedAnimation ( localPlayer, false )
					isLocalPlayerAnimating = false
					triggerServerEvent ( "onCustomAnimationSet", resourceRoot, localPlayer, false, false )
				end
			end
		end
	end
)

addEvent ("onClientCustomAnimationSet", true )
addEventHandler ("onClientCustomAnimationSet", root,
    function ( player, blockName, animationName )
        if blockName == false then 
            setPedAnimation ( player, false )
			if (sound[player]) then
				stopSound(sound[player])
				sound[player] = nil
			end
        else
			setPedAnimation ( player, blockName, animationName )
			--if (fileExists("sounds/"..animationName..".mp3")) then
				--local x, y, z = getElementPosition(player)
				--sound[player] = playSound3D("sounds/"..animationName..".mp3", x, y, z, true)
				--setElementDimension(sound[player], getElementDimension(localPlayer))
				--setElementInterior(sound[player], getElementInterior(localPlayer))
			--end
		end
    end 
)

setTimer ( 
    function ()
        if isLocalPlayerAnimating then 
            if not getPedAnimation (localPlayer) then
				isLocalPlayerAnimating = false
				triggerServerEvent ( "onCustomAnimationSet", resourceRoot, localPlayer, false, false )
			end
        end
    end, 100, 0
)

if (fileExists("client.lua")) then
	fileDelete("client.lua")
end