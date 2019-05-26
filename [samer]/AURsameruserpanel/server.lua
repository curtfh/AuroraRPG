function StaffPanel(plr)
	local res = exports.DENmysql:query("SELECT * FROM staff ORDER BY rank DESC")
	triggerClientEvent(plr, "AURuserpanel.drawStaffPanel", plr, res)
end
addEvent("AURuserpanel.StaffPanel", true)
addEventHandler("AURuserpanel.StaffPanel", root, StaffPanel)

function LoginsPanel(plr)
	local theAccount = exports.server:getPlayerAccountName (plr)
	local res = exports.DENmysql:query("SELECT * FROM logins WHERE accountname=? ORDER BY datum DESC LIMIT 10", theAccount)
	triggerClientEvent(plr, "AURuserpanel.drawLoginsPanel", plr, res)
end
addEvent("AURuserpanel.LoginsPanel", true)
addEventHandler("AURuserpanel.LoginsPanel", root, LoginsPanel)

function requestStaff(plr)
	for k, v in ipairs(exports.CSGstaff:getOnlineAdmins()) do
		outputChatBox(""..getPlayerName(plr).." is requesting staff assistance, warp to assist him.", v, 0, 255, 0)
	end
end
addEvent("AURuserpanel.requestStaff", true)
addEventHandler("AURuserpanel.requestStaff", root, requestStaff)

function SkillsWnd(plr)
	executeCommandHandler("skills", plr)
end
addEvent("AURuserpanel.drawSkillsWnd", true)
addEventHandler("AURuserpanel.drawSkillsWnd", root, SkillsWnd)
