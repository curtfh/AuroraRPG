local playerAnimations = {  }
local playerSounds = {  }
addEvent("onCustomAnimationSet", true )

local SetAnimation -- function

addEventHandler ( "onPlayerJoin", root,
    function ( )
        playerAnimations [ source ] = {}
		playerSounds [ source ] = {}
    end
)

for _, player in pairs ( getElementsByType ("player") ) do 
    playerAnimations [ player ] = {}
	playerSounds [ player ] = {}
end

addEvent ("onCustomAnimationStop", true )
addEventHandler ("onCustomAnimationStop", root,
    function ( player )
        SetAnimation ( player, false )
    end 
)

addEventHandler ("onCustomAnimationSet", resourceRoot,
    function ( player, blockName, animationName )
        SetAnimation ( player, blockName, animationName )
        triggerClientEvent ( root, "onClientCustomAnimationSet", root, player, blockName, animationName ) 
    end 
)

function SetAnimation ( player, blockName, animationName )
    if not playerAnimations[ player ] then playerAnimations[ player ] = {} end 
	if not playerSounds[player] then playerSounds[player] = {} end
    if blockName == false then
        playerAnimations[ player ].current = nil
		playerSounds[player].current = nil
    else
        playerAnimations[ player ].current = { blockName, animationName }
		playerSounds[player].current = { animationName..".mp3" }
    end 
end 

