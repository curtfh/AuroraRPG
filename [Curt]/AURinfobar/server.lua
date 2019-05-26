--[[
Server Name: AuroraRPG
Resource Name: AURinformation
Version: 1.0
Developer/s: Curt
]]--

local messages = {
	{"Press F1 to view Aurora's Extensive Documentation."},
	{"You can trade your items by pressing F10."},
	{"Join our community forums aurorarpg.com."},
	{"To know the illegal race time. Type /iracetime."},
	{"You can report a player by doing /report & to take a screenshot report type /rsc."},
	{"Donate now to have all exclusive features of the server. For more info aurorarpg.com."},
	{"You can adjust the server's settings. By typing this command /settings."},
	{"Follow our server rules or else you'll be in a big trouble."},
	{"Is your game lagging? You can adjust somethings on your server graphic setting at /settings."},
	{"Don't you know you can jail break in jail? Well you can as a criminal!"},
	{"You can see server's statistics on aurorarpg.com."},
}

function postMessages ()
	local randomPick = math.random(#messages)
	
	for i=1, #getElementsByType("player") do 
		exports.NGCdxmsg:createNewDxMessage(getElementsByType("player")[i], exports.AURlanguage:getTranslate(messages[randomPick][1], true, getElementsByType("player")[i]), 244, 116, 66)
	end
end 
postMessages()
setTimer(postMessages, 120000, 0)