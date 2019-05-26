addEvent ( "playTheSound", true )
addEventHandler ( "playTheSound", localPlayer,
    function ( )
        sound = playSound ( "headshot.mp3", false )
        setSoundVolume ( sound, 1 )
    end
)