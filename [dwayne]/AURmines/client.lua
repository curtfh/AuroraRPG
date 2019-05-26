addEventHandler("onClientPlayerWeaponFire",localPlayer,function(_, _, _, _, _, _,mine)

        if mine and getElementModel(mine) == 1510 then
            triggerServerEvent("destroy",localPlayer,mine)
        end

end)

addEvent("play",true)
addEventHandler("play",localPlayer,
    function ()
        playSound(":CSGmods/Mods/mp3/sound.mp3")
    end )


addEvent("play2",true)
addEventHandler("play2",localPlayer,
    function ()
        playSound(":CSGmods/Mods/mp3/mission.mp3")
    end )
