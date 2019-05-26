blacklist = {}

addEventHandler("onClientResourceStop",resourceRoot,
function()
	setWorldSpecialPropertyEnabled("aircars",false)
end)

state = false
addCommandHandler("vehfly",
function(_, cheat)
	if not (getPlayerTeam(localPlayer) == getTeamFromName("Staff")) then return end
	if state == false then
		newState = true
		state = true
		if cheat == "aircars" then
			newCheat = "aircars"
		elseif cheat == "hovercars" then
			newCheat = "hovercars"
		elseif cheat == "both" then
			setWorldSpecialPropertyEnabled("aircars",true)
			setWorldSpecialPropertyEnabled("hovercars",true)
			return
		else
			exports.NGCdxmsg:createNewDxMessage("Wrong cheat name (aircars or hovercars (OR 'both')",255,0,0)
		end
	elseif state == true then
		newState = false
		state = false
		if cheat == "aircars" then
			newCheat = "aircars"
		elseif cheat == "hovercars" then
			newCheat = "hovercars"
		elseif cheat == "both" then
			setWorldSpecialPropertyEnabled("aircars",true)
			setWorldSpecialPropertyEnabled("hovercars",true)
			return
		else
			exports.NGCdxmsg:createNewDxMessage("Wrong cheat name (aircars or hovercars OR 'both')",255,0,0)
		end
	end
	setWorldSpecialPropertyEnabled("aircars",newState)
end)