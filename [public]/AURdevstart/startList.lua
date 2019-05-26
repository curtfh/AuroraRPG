
local startList = {
	--- Core
	"DENmysql",
	"AURpayments",
	"DENsettings",
	"server",
	--"AURmstyles", Disabled for 20% CPU Usage
	"customblips",
	"NGCmanagement",
	"CSGlogging",
	"CSGaccounts",
	"runcode",
	"ipb",
	"DENstats",
	"NGCanticheat",
	"AURspawn",
	"CSGserverstate",
	"NGCafkmode",
	"AURhouses",
	"CSGplayers",
	"AURlevels",
	"AURcircle",
	-- Gamemode
	"NGCdxmsg",
	"NGCnote",
	"CSGwanted",
	"AURsamgroups",
	"CSGpriyenmisc",
	"CSGscore",
	"AURbankATM",
	"DENblips",
	"DENchatsystem",
	"AURphone",
	"NGCsafeZone",
	"AURammucol",
	"AURstickynote",

	-- Admins
	"CSGadmin",
	"CSGstaff",
	"CSGviewstuff",
	"Capitol",
	"DENpunishments",
	"NGCdevTools",
	"AURevents",
	"NGCjudiciary",
	"AURofflinepunishment",
	"AURsetjob",
	"AURshowDrugs",
	"NGCstaffmisc",
	"AURsuperman",
	"NGCmusic",

	--- Jobs
	"NGCjobsinteriors",
	"DENjob",
	"NGCgovernment",
	"CSGranks",
	"CSGtopjobs",
	--- new things
	"AURstats",


	--- Misc
	"CSGLadder",
	"CSGlaser",
	"CSGpeak",
	"CSGprogressbar",
	--"AURweather",
	"DENmaps",
	"AURmisc",
	"DENpeds",
	"DENvending",
	"AURabmath",
	"AURanimations",
	"AURhdradar",
	"AURmedkit",
	"AURshowTimeAndDate",
	"AURnadespam",
	"AURcustomtitles",


	-- transports
	"NGCpara",

	-- Law
	"DENlaw",
	"DENpolice",


	-- Weapons & Shops
	"DENweapons",


	-- Smith shit
	"NGCStaffSteath",
	-- NGC
	"reload",
	"scoreboard",
	"bone_attach",
	"killmessages",
	"NGCheadshot",
	"missiontimer",
	"parachute",
	"driveby",
	"slothbot",
	"webbrowser",
	"ajax",
	"country",
	"cpicker",
	"interiors",


	"AURmoney",
	"AURplayerhud",


	--Curt's Resources
	"AURcivilinc",
	"AURcurtmisc",
	"AURcurtmisc2",
	"AURinfobar",
	"AURsupporternew",
	"AURlanguage",
	"AURtax",
	"AURwebadmin",


	"AURantidm",
	"AURanubhavMisc",
	"AURccr",
	"AURcivil_groupexp",
	"AURcpicker",
	"AURcurtdev",
	"AURdocumentation",
	"AURfastrope",
	"AURgetskin",
	"AURigsettings",
	"AURinteractions",
	"AURlogins",
	"AURlscounter",
	"AURmplayer",
	"AURnewplayer",
	"AURprogressbar",
	"AURvehicleshop",
	"AURfuel",
	"CSGgroups",

	"AURunits",
	"AURonjoinascivilian",
}

function startServer()
	startResource(getResourceFromName("DENsettings"), true)
	for i,resName in ipairs(startList) do
		local resource = getResourceFromName(resName)
		if (resource) then
			startResource(resource, true)
		else
			outputDebugString("Resource '"..resName.."' not found, skipping...")
		end
	end

end
addEventHandler("onResourceStart", resourceRoot, startServer)


--[[
function onServerStart()
	startResource(getResourceFromName("DENsettings"), true)
	local file2 = fileOpen("startups.json")
	local tab = fromJSON(fileRead(file2, fileGetSize(file2)))
	outputDebugString(fileRead(file2, fileGetSize(file2)))
	fileClose(file2)

	for i,resName in ipairs(tab) do
		local resource = getResourceFromName(resName)
		if (resource) then
			startResource(resource, true)
		else
			outputDebugString("Resource '"..resName.."' not found, skipping...")
		end
	end

end
addEventHandler("onResourceStart", resourceRoot, onServerStart)

function updateResourceList()
	local resourceTable = getResources()
	local listResStartup = {}
	for resourceKey, resourceValue in ipairs(resourceTable) do
		local name = getResourceName(resourceValue)
		if (getResourceState(resourceValue) == "running") then
			table.insert(listResStartup, name)
		end
	end
	outputDebugString("Updated Resource Startup.")
	local file1 = fileOpen("startups.json")
	fileWrite(file1, toJSON(listResStartup))
	fileClose(file1)
end
addCommandHandler("updateresurcesstartlist", updateResourceList)]]--
