sv = exports.server

function onStart()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS houseOfReps (accName TEXT, repOcc TEXT)")
	repsTeam = createTeam("House of Representatives", 75, 0, 130)
	executeSQLQuery("INSERT INTO houseOfReps VALUES (?,?)", "samer61", "Speaker of The House")
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function isPlayerRep(p)
	local accName = sv:getPlayerAccountName(p)
	local result = executeSQLQuery("SELECT * FROM houseOfReps WHERE accName=?", accName)
	if (#result > 0) then 
		return true
	else
		return false
	end
end

function isPlayerSpeaker(p)
	local accName = sv:getPlayerAccountName(p)
	local result = executeSQLQuery("SELECT * FROM houseOfReps WHERE accName=?", accName)
	if (result[1]["repOcc"] == "Speaker of The House") then 
		return true
	else
		return false
	end
end

function getRepOcc(p)
	local accName = sv:getPlayerAccountName(p)
	local result = executeSQLQuery("SELECT * FROM houseOfReps WHERE accName=?", accName)
	if (#result > 0) then 
		return result[1]["repOcc"]
	else
		return false
	end
end

function getOnlineReps()
	local repTable = {}
	for k, v in ipairs (getElementsByType("player")) do
		if (isPlayerRep(v)) then
			table.insert(repTable, v)
		end
	end
	return repTable
end

function goOnDuty(p, cmd)
	if (isPlayerRep(p)) then
		setPlayerTeam(p, getTeamFromName("House of Representatives"))
		setElementData(p, "Occupation", getRepOcc(p))
		outputChatBox("You are now on your representative duty.", p, 0, 255, 0)
	else
		outputChatBox("You're not a representative.", p, 255, 0, 0)
	end
end
addCommandHandler("repduty", goOnDuty)

function callForSession(p, cmd, ...)
	if (isPlayerSpeaker(p)) then
		local title = table.concat({...}," ")
		if (string.len(title) < 2) then return false end
		outputChatBox("The Speaker of the House "..getPlayerName(p).." has called for a congress session about "..title..".", root, 0, 255, 0)
	end
end
addCommandHandler("session", callForSession)