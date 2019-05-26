function setTheirTeams()
    setPlayerTeam(source, getTeamFromName("Civilian Workers"))
    setElementData(source, "Occupation", "Not logged in")
end
addEventHandler ( "onPlayerJoin", getRootElement(), setTheirTeams )