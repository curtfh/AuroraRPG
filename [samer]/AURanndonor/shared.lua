function convertTextToSpeech(text, broadcastTo)
    -- Ensure first argument is valid
    assert(type(text) == "string", "Bad argument 1 @ convertTextToSpeech [ string expected, got " .. type(text) .. "]")
    assert(#text <= 100, "Bad argument 1 @ convertTextToSpeech [ too long string; 100 characters maximum ]")
    if triggerClientEvent then -- Is this function called serverside?
        -- Ensure second and third arguments are valid
        assert(broadcastTo == nil or type(broadcastTo) == "table" or isElement(broadcastTo), "Bad argument 2 @ convertTextToSpeech [ table/element expected, got " .. type(broadcastTo) .. "]")
        -- Tell the client to play the speech
        return triggerClientEvent(broadcastTo or root, "playTTS", root, text)
    else -- This function is executed clientside
        return playTTS(text)
    end
end