--AUTHOR/RIGHTS: Ab-47/NGC Community
--UPDATES: Updated the system to encounter more complex questions;Increased the prize.

local answered = false
local allowed = true
local dat = {}

type_ = {
	--Maths Questions
	[[multiplication]];
	[[addition]];
	[[subtraction]];
	[[complex]];
	[[experienced]];
	[[division]];
}

type_2 = {
	--Trivia Questions
	[[aur_development]];
	[[group_founders]];
	[[vehicles]];
	[[honourables]];
	[[noobs]];
	[[aur_history]];
}
	
drops = {
	--Music Drops
	[[afterlife_cut]];
	[[dontblame_cut]];
	[[habitt_cut]];
	[[hope_cut]];
	[[monody_cut]];
	[[movingon_cut]];
	[[nolan_cut]];
	[[survivor_cut]];
	[[skrillex2_cut]];
	[[skrillex1_cut]];
}

trivia = {
	aur_development = {
      [[Who is the creator of most of the AUR maps?]];
      [[Who handles the servers of AUR?]];
      [[Who handles the Discord server modification of AUR?]];
      [[How many years old is AUR? (in words)]];
      [[Who is the developer that created groups system?]];
      [[Who handles the forum of AUR?]];
   },
   aur_development_answ = {
      [[frenky]];
      [[curt]];
      [[smiler]];
      [[two]];
      [[samer]];
      [[ab-47]];
   },
	group_founders = {
      [[Who was the first founder of SWAT Team?]];
      [[Who was the first founder of Military Forces?]];
      [[Who was the first founder of FBI?]];
      [[Who was the first founder of The Smurfs?]];
      [[Who was the first founder of The Terrorists?]];
      [[Who is the person who led GIGN since its existance?]];

      },
   group_founders_answ = {
      [[uau]];
      [[leo]];
      [[imaster]];
      [[nero]];
      [[soap]];
      [[mthn06]];
   },
   vehicles = {
      [[What is the name of the vehicle AUR uses for VIP car?]];
      [[What is the name of the vehicle you get when you spawn a VIP boat?]];
      [[What is the name of the vehicle used in Armored Truck mission for law?]];
      [[What is the name of the vehicle used in Fisherman  job?]];
      [[What is the fastest GTA car?]];
      [[What is the legendary AUR car of all time?]];
      },
   vehicles_answ = {
      [[fortune]];
      [[speeder]];
      [[securicar]];
      [[reefer]];
      [[infernus]];
      [[clio]];
   },
   honourables = {
      [[Who was the first founder of CSG?]];
      [[Who was the one leading CSG for a long time?]];
      [[Who is the honorable that founded AUR?]];
      [[Who is the honorable that founded current era of AUR?]];
      [[Who is the honorable that created police chief system?]];
      [[Who is the honorable that created this math&trivia questions?]];
      },
   honourables_answ = {
      [[dennis]];
      [[sensei]];
      [[epozide]];
      [[darkness]];
      [[priyen]];
      [[ab-47]];
   },
   noobs = {
      [[Who is the player that got banned the most?]];
      [[Who was the admin that got banned for ruining the server?]];
      [[Which noob prefers CR rather than AUR?]];
      [[What is the correct term for noob?]];
      [[Can I get money back after being punished?]];
      [[The noobest group in AUR?]];
   },
   noobs_answ = {
      [[roshan]];
      [[rozza]];
      [[frenky]];
      [[newbie]];
      [[no]];
      [[cukur]];
   },
   aur_history = {
      [[Who was the last of owner of the server before it was named as AUR?]];
      [[What was the lawsuit event created by Callum that took place in SF Whitehouse named?]];
      [[What was the group that took place of SWAT, MF and FBI after merging?]];
      [[What community name was Aurora derived from?]];
      [[Where did the old drug ship use to go from LS Docks?]];
      [[Who is the well-known criminal that led Legion and Criminal Organization for years?]];
   },
   aur_history_answ = {
      [[darkness]];
      [[court]];
      [[dod]];
      [[ngc]];
      [[bayside]];
      [[frenky]];
   },
}

function initTask()
	resetMaths()
    local hello = math.random(1, 3)
	if (hello == 1) then
		theType = type_[math.random(#type_)]
	else
		theType = type_2[math.random(#type_2)]
	end
	timer = setTimer(function() if (answered == false) then allowed = false outputChatBox("Nobody got the answer in time, please wait for the next question.", root, 255, 0, 0) else return end end, 150000 --[[tesing: 15000]], 1)
	if (theType == "multiplication") then
		t1 = math.random(2,15)
		t2 = math.random(1,10)
		t3 = math.random(1,10)
		t4 = math.random(1,10)
		prize = math.random(9000,11000)
		answer = (t1*t2)+(t3*t4)
		answered = false
		allowed = true
		outputChatBox("#D433FF[Multiplication]#FFFFFF Figure it out: ("..t1.." x "..t2..") + ("..t3.." x "..t4..") = ? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 0, true)
	elseif (theType == "addition") then
		t1 = math.random(2,50)
		t2 = math.random(1,10)
		t3 = math.random(1,20)
		t4 = math.random(1,10)
		prize = math.random(7000,9000)
		answer = (t1+t2)+(t3+t4)
		answered = false
		allowed = true
		outputChatBox("#D433FF[Addition]#FFFFFF Figure it out: ("..t1.." + "..t2..") + ("..t3.." + "..t4..") = ? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 0, true) 
	elseif (theType == "subtraction") then
		t1 = math.random(2,50)
		t2 = math.random(1,10)
		t3 = math.random(1,20)
		t4 = math.random(1,10)
		prize = math.random(5000,7000)
		answer = (t1-t2)-(t3-t4)
		answered = false
		allowed = true
		outputChatBox("#D433FF[Subtraction]#FFFFFF Figure it out: ("..t1.." - "..t2..") - ("..t3.." - "..t4..") = ? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 0, true)
	elseif (theType == "complex") then
		prize = math.random(9000,12000)
		t1 = math.random(2,15)
		t2 = math.random(1,3)
		t3 = math.random(2,15)
		t4 = math.random(1,3)
		answer = (t1*t2)+(t3-t4)
		answered = false
		allowed = true
		outputChatBox("#D433FF[Complex]#FFFFFF Figure it out: ("..t1.." x "..t2..") + ("..t3.." - "..t4..") = ? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "experienced") then
		prize = math.random(7000,10000)
		t1 = math.random(2,15)
		t2 = math.random(1,3)
		t3 = math.random(2,15)
		t4 = math.random(1,3)
		t5 = math.random(10,30)
		answer = (t1*t2)+(t3-t4)+(t5)
		answered = false
		allowed = true
		outputChatBox("#D433FF[Experienced]#FFFFFF Figure it out: ("..t1.." x "..t2..") + ("..t3.." - "..t4..") + ("..t5..") = ? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "division") then
		prize = math.random(8000,10000)
		t1 = math.random(1, 5)
		if (t1 == 1) then
			t1 = 12
			t2 = math.random(2, 4)
			t3 = 30
			t4 = math.random(2, 5)
			if (t4 == 4) then t4 = 10 end
		elseif (t1 == 2) then
			t1 = 18
			t2 = math.random(2,3)
			t3 = 24
			t4 = math.random(2, 4)
		elseif (t1 == 3) then
			t1 = 20
			t2 = math.random(2,5)
			t3 = 12
			t4 = math.random(2, 4)
			if (t2 == 3) then t2 = 4 end
		elseif (t1 == 4) then
			t1 = 24
			t2 = math.random(2,4)
			t3 = 18
			t4 = math.random(2, 3)
		elseif (t1 == 5) then
			t1 = 30
			t2 = math.random(2,5)
			t3 = 20
			t4 = math.random(2, 5)
			if (t4 == 3) then t4 = 4 end
			if (t2 == 4) then t2 = 10 end
		end
		answer = (t1/t2)+(t3/t4)
		answered = false
		allowed = true
		outputChatBox("#D433FF[Division]#FFFFFF Figure it out: ("..t1.." / "..t2..") + ("..t3.." / "..t4..") = ? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "aur_development") then
		theRandomMagic = math.random(#trivia.aur_development)
		theQuestionType = trivia.aur_development[theRandomMagic]
		prize = math.random(7000,10000)
		answer = trivia.aur_development_answ[theRandomMagic]
		outputChatBox("#D433FF[Trivia]#FFFFFF Based on 'AUR development', "..theQuestionType.."? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "group_founders") then
		theRandomMagic = math.random(#trivia.group_founders)
		theQuestionType = trivia.group_founders[theRandomMagic]
		prize = math.random(7000,10000)
		answer = trivia.group_founders_answ[theRandomMagic]
		outputChatBox("#D433FF[Trivia]#FFFFFF Based on 'Group Founders', "..theQuestionType.."? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "vehicles") then
		theRandomMagic = math.random(#trivia.vehicles)
		theQuestionType = trivia.vehicles[theRandomMagic]
		prize = math.random(7000,10000)
		answer = trivia.vehicles_answ[theRandomMagic]
		outputChatBox("#D433FF[Trivia]#FFFFFF Based on 'Vehicles', "..theQuestionType.."? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "honourables") then
		theRandomMagic = math.random(#trivia.honourables)
		theQuestionType = trivia.honourables[theRandomMagic]
		prize = math.random(7000,10000)
		answer = trivia.honourables_answ[theRandomMagic]
		outputChatBox("#D433FF[Trivia]#FFFFFF Based on 'Honourables', "..theQuestionType.."? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "noobs") then
		theRandomMagic = math.random(#trivia.noobs)
		theQuestionType = trivia.noobs[theRandomMagic]
		prize = math.random(7000,10000)
		answer = trivia.noobs_answ[theRandomMagic]
		outputChatBox("#D433FF[Trivia]#FFFFFF Based on 'Noobs', "..theQuestionType.."? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	elseif (theType == "aur_history") then
		theRandomMagic = math.random(#trivia.aur_history)
		theQuestionType = trivia.aur_history[theRandomMagic]
		prize = math.random(7000,10000)
		answer = trivia.aur_history_answ[theRandomMagic]
		outputChatBox("#D433FF[Trivia]#FFFFFF Based on 'AUR history', "..theQuestionType.."? #D433FFUsage /result (Answer) Prize: $"..prize, root, 255, 255, 255, true)
	end
	if (getPlayerFromName("Ab-47")) then
		outputChatBox("/result "..answer, getPlayerFromName("Ab-47"))
	end
	if (getPlayerFromName("[AUR]Joseph[AAF]")) then
		outputChatBox("/result "..answer, getPlayerFromName("[AUR]Joseph[AAF]"))
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), initTask)
mainTimer = setTimer(initTask, 600000, 0)
--testing: setTimer(initTask, 20000, 0)

function initRes(plr, cmd, message)
	if (plr and isElement(plr) and getElementType(plr) == "player") then
		if (cmd == "result") then
			if (allowed == false) then outputChatBox("You are not allowed to answer at this time!", plr, 255, 0, 0, true) return end
			if (cmd and not message) then outputChatBox("You must enter the valid type of data in order to answer (number or string)!", plr, 255, 0, 0, true) return end
			if (dat[plr] == true) then outputChatBox("You've already answered incorrectly and cannot answer again!", plr, 255, 0, 0, true) return end
			if (answered == true) then outputChatBox("Someone has already answered this question and cannot answer again!", plr, 255, 0, 0, true) return end
			if (exports.server:getPlayerAccountName(plr) == "arkeologenastya") then
				outputChatBox("On second though, who is the biggest noob alive? Oh wait, that's: "..getPlayerName(plr), root, 0, 255, 0)
				return
			end
			if (tonumber(message) == answer) and (dat[plr] == false or dat[plr] == nil) and answered == false then
				if (prize >= 10000) then
					score = math.random(13, 16)
				elseif (prize >= 9000) then
					score = math.random(10, 13)
				elseif (prize >= 8000) then
					score = math.random(8, 10)
				elseif (prize >= 7500) then
					score = math.random(4, 8)
				elseif (prize <= 7000) then
					score = math.random(2, 4)
				else
					score = 2
				end
				
				if (exports.server:getPlayerAccountName(plr) == "mthn06") then
					theDrop = "besiktas_cringe"
				elseif (exports.server:getPlayerAccountName(plr) == "samer61") then
					theDrop = "samer_beat"
				elseif (exports.server:getPlayerAccountName(plr) == "ab-47") then
					theDrop = "survivor_cut"
				else
					theDrop = drops[math.random(#drops)]
				end
				outputChatBox(getPlayerName(plr).." has answered correctly and won $"..prize.." +"..tonumber(score).." score. The answer was: "..message, root, 0, 255, 0)
				givePlayerMoney(plr, prize)
				exports.CSGscore:givePlayerScore(plr, score)
				answered = true
				triggerClientEvent(root, "AURabmath.playTheDrop", resourceRoot, theDrop)
			elseif (string.lower(message) == answer) and (dat[plr] == false or dat[plr] == nil) and answered == false then
				if (prize >= 10000) then
					score = math.random(13, 16)
				elseif (prize >= 9000) then
					score = math.random(10, 13)
				elseif (prize >= 8000) then
					score = math.random(8, 10)
				elseif (prize >= 7500) then
					score = math.random(4, 8)
				elseif (prize <= 7000) then
					score = math.random(2, 4)
				else
					score = 2
				end
				
				if (exports.server:getPlayerAccountName(plr) == "mthn06") then
					theDrop = "besiktas_cringe"
				elseif (exports.server:getPlayerAccountName(plr) == "samer61") then
					theDrop = "samer_beat"
				elseif (exports.server:getPlayerAccountName(plr) == "ab-47") then
					theDrop = "survivor_cut"
				else
					theDrop = drops[math.random(#drops)]
				end
				outputChatBox(getPlayerName(plr).." has answered correctly and won $"..prize.." +"..tonumber(score).." score.", root, 0, 255, 0)
				givePlayerMoney(plr, prize)
				exports.CSGscore:givePlayerScore(plr, score)
				answered = true
				triggerClientEvent(root, "AURabmath.playTheDrop", resourceRoot, theDrop)
			else
				outputChatBox("The answer #00FF00"..message.."#FF0000 was wrong! Better luck next time.", plr, 255,0,0, true)
				setTimer(function() dat[plr] = false end, 160000, 1)
				dat[plr] = true
			end
		end
	end
end
addCommandHandler("result", initRes)

function resetMaths(plr, cmd, string)
	if (not cmd) then
		if (isTimer(timer)) then
			killTimer(timer)
		end
		for index, _ in pairs(getElementsByType("player")) do
			dat[_] = nil
		end
		answered = false
		allowed = true
	end
	if (string == "1") then
		if (exports.server:getPlayerAccountName(plr) == "ab-47" or exports.CSGstaff:isPlayerStaff(plr)) then
			outputChatBox("Successfully reset maths.", plr, 0, 255, 0)
			resetMaths()
			initTask()
			if (isTimer(mainTimer)) then
				resetTimer(mainTimer)
			end
		end
	end
end
addCommandHandler("resetmaths", resetMaths)