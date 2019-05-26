local running = false
local quizAnswer = ""
local quizPrice = 0


function speakercommand(thePlayer)
	if exports.CSGstaff:isPlayerStaff(thePlayer) then
        triggerClientEvent ( thePlayer, "openQuizGUI", thePlayer )
	end
end
addCommandHandler ("quiz", speakercommand)


function startQuiz(player, question, answer, price, timer, time)
    if (running == true) then
        outputChatBox("There is already a quiz going on.", player, 255, 0, 0)
    return end
    running = true
    quizAnswer = answer
    quizPrice = tonumber(price) or tonumber(0)
    local quizMaster = getPlayerName(player)


    outputChatBox("(QUIZ) "..quizMaster..": #FFFFFF"..question, root, 255, 0, 0, true)
    outputChatBox("Use /answ <answer> to give the right answer.", root, 255, 0, 0)
    triggerClientEvent("deleteAnswers", root)
    if (timer) then
        ttime = time * 1000
        quizTimer = setTimer(timesUp, ttime, 1)
    end
end
addEvent("startQuiz", true)
addEventHandler("startQuiz", root, startQuiz)


function timesUp()
    if (running == false) then return end
    outputChatBox("(QUIZ)#FFFFFF Time's up, the right answer was: "..quizAnswer, root, 220, 0, 0, true)
    running = false
end

function stopQuiz(player)
   	 running = false
	 exports.NGCdxmsg:createNewDxMessage("You've stopped the quiz",player,0,255,0)
	 outputChatBox("Quiz is removed",root,255,0,0)
end
addEvent("stopQuiz", true)
addEventHandler("stopQuiz", root, stopQuiz)


function answerQuiz(player, cmd, a, b, c, d, e, f, g, h, i)
    if (running == false) then return end
    if (not a) then return end

    if (i) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f.." "..g.." "..h.." "..i
    elseif (h) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f.." "..g.." "..h
    elseif (g) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f.." "..g
    elseif (f) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f
    elseif (e) then
        answer = a.." "..b.." "..c.." "..d.." "..e
    elseif (d) then
        answer = a.." "..b.." "..c.." "..d
    elseif (c) then
        answer = a.." "..b.." "..c
    elseif (b) then
        answer = a.." "..b
    elseif (a) then
        answer = a
    end

    local playerName = getPlayerName(player)
    triggerClientEvent("addAnswer", root, playerName, answer)

    if (string.lower(quizAnswer) == string.lower(answer)) then
        local playerName = getPlayerName(player)
        outputChatBox(playerName.." has answered the question", root, 255, 0, 0)
        outputChatBox("The right answer was: #FFFFFF"..answer, root, 200, 0, 0, true)
        running = false
        if (isTimer(quizTimer)) then
            killTimer(quizTimer)
        end    
        if (quizPrice == 0) then return end

    end
end
addCommandHandler("answ", answerQuiz)
addCommandHandler("quiz", answerQuiz)
