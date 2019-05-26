local questions = 
{
	[1] = {"In which year did the US get its independence?", {"1776"}},
	[2] = {"Who is the current president of the US?", {"Trump", "Donald Trump", "Donald J.Trump", "Donald"}},
	[3] = {"What luxury British automobile brand was purchased by by Tata motors in 2008?", {"Jaguar"}},
	[4] = {"The companies HP, Microsoft and Apple were all started in a what?", {"Garage"}},
	[5] = {"Who is the current supreme leader of North Korea?", {"Kim Jong Un", "Kim Jong-Un"}},
	[6] = {"Who was the second president of the United States?", {"John Adams"}},
	[7] = {"What color do you get when you mix yellow and blue?", {"Green"}},
	[8] = {"Who played the fictional anti hero Deadpool in the 2016 movie?", {"Ryan Reynolds", "Reynolds", "Ryan"}},
	[9] = {"Who was awarded the first United States patent for the telephone?", {"Alexander Graham Bell", "Bell", "Alexander Bell", "Graham Bell"}},
	[10] = {"In What state was President Barack Obama born?", {"Hawaii"}},
	[11] = {"In computer science, what does 'GUI' stand for?", {"Graphical user interface"}},
}

isQuestion = false
hasAnwered = {}
local trivia_time = 1000*60*10

function noneAnswered()
	isQuestion = false
	for k, v in ipairs(getElementsByType("player")) do
		if (exports.server:isPlayerLoggedIn(v)) then
			outputChatBox("#FF0000[TRIVIA] #ffffffNo one has answered the question, the correct answer was #D68910"..toAnsw[1]..".", v, 0, 0, 0, true)
		end
	end
	setTimer(getQuestion, trivia_time, 1)
end

function getQuestion()
	local i = math.random(1,#questions)
	toAnsw = questions[i][2]
	award = math.floor(math.random(1000,5000))
	isQuestion = true
	for k, v in ipairs(getElementsByType("player")) do
		if (exports.server:isPlayerLoggedIn(v)) then
			outputChatBox("#FF0000[TRIVIA] #D68910"..questions[i][1].." #ffffffAnswer the question for $"..exports.server:convertNumber(award).." in thirty seconds! (use /tansw <answer> to participate).", v, 0, 0, 0, true)
		end
	end
	noAnswerTime = setTimer(noneAnswered, 30*1000, 1)
	hasAnwered = {}
end

setTimer(getQuestion, trivia_time, 1)

function isCorrectAnswer(answ)
	for k, v in ipairs(toAnsw) do
		if (string.lower(answ) == string.lower(v)) then
			return true, v
		end
	end
	return false
end

addCommandHandler("tansw",	function(plr, cmd, ...)
	if (isQuestion) then
		if not (hasAnwered[plr]) then
			local text = table.concat({...}, " ")
			if (isCorrectAnswer(text)) then
				local bool, answer = isCorrectAnswer(text)
				for k, v in ipairs(getElementsByType("player")) do
					if (exports.server:isPlayerLoggedIn(v)) then
						outputChatBox("#FF0000[TRIVIA] #ffffff"..getPlayerName(plr).." answered with the right answer which is #D68910"..answer..".", v, 0, 0, 0, true)
						outputChatBox("#FF0000[TRIVIA] #ffffff"..getPlayerName(plr).." won $"..exports.server:convertNumber(award)..".", v, 0, 0, 0, true)
					end
				end
				exports.AURpayments:addMoney(plr, award, "Custom", "Misc", 0, "AURsamtrivia Won trivia")
				killTimer(noAnswerTime)
				setTimer(getQuestion, trivia_time, 1)
				isQuestion = false
			else
				outputChatBox("#FF0000[TRIVIA] #ffffffWrong answer.", plr, 0, 0, 0, true)
				hasAnwered[plr] = true
			end
		else
			outputChatBox("#FF0000[TRIVIA] #ffffffYou can no longer participate in this question.", plr, 0, 0, 0, true)
		end
	else
		outputChatBox("#FF0000[TRIVIA] #ffffffThere is no trivia going on right now.", plr, 0, 0, 0, true)
	end
end)
	