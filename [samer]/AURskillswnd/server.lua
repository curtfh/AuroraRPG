addEvent("onServerPlayerLogin", true)

function openStatsPanel(plr)
	local skillsTab = {pistol = getPedStat(plr, 69), sil = getPedStat(plr, 70), deg = getPedStat(plr, 71), shot = getPedStat(plr, 72), sawned = getPedStat(plr, 73), spaz = getPedStat(plr, 74), uzi = getPedStat(plr, 75), mp5 = getPedStat(plr, 76), ak = getPedStat(plr, 77), m4 = getPedStat(plr, 78), sniper = getPedStat(plr, 79)}
	triggerClientEvent(plr, "AURskills.drawSkillsWnd", plr, skillsTab)
end
addEvent("AURskills.drawSkillsWndFromUserpanel", true)
addEventHandler("AURskills.drawSkillsWndFromUserpanel", root, openStatsPanel)
addCommandHandler("skills", openStatsPanel)
