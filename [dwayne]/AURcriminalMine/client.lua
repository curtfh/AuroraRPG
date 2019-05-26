addEventHandler("onClientPlayerWeaponFire",localPlayer,function(_, _, _, _, _, _,mine)

        if mine and getElementModel(mine) == 1510 then
            triggerServerEvent("destroyCrim",localPlayer,mine)
        end

end)

addEvent("playCrim",true)
addEventHandler("playCrim",localPlayer,
    function ()
        playSound("sound.mp3")
    end )


addEvent("play2Crim",true)
addEventHandler("play2Crim",localPlayer,
    function ()
        playSound("mission.mp3")
    end )
