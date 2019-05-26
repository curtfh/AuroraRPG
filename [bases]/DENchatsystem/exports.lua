local crims = 04
local MF = 03
local cops = 12
local civils = 08
local medics = 11
local SWAT = 10
local unoccupied = 07 --off duty
local unemployed = 06
local staff = 14
local co = 06

function getColorForIRC(player)
	if (team(player,"Criminals") == true) then
		return crims
	elseif (exports.DENlaw:isLaw(player)) then
		return cops
	elseif (team(player,"Civilian Workers") == true) then
		return civils
	elseif (team(player,"Paramedics") == true) then
		return medics
	elseif (team(player,"Unoccupied") == true) then
		return unoccupied
	elseif (team(player,"Unemployed") == true) then
		return unemployed
	elseif (team(player,"Staff") == true) then
		return staff
	else
		return 15 --default color for those who are not in a team
	end
end

function team(player,team)
	if (getPlayerTeam(player) == getTeamFromName(team)) then
		return true
	else
		return false
	end
end

function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
