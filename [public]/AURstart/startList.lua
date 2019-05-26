
local startList = {
	--- Core
	"DENmysql",
	"AURpayments",
	"DENsettings",
	"server",
	"AURloginPanel",
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

	-- Models
	"AURclothShop",
	"AURmodelClothes",
	"AURmodels",

	-- Vehicles
	"DENvehicles",
	"CSGplayervehicles",
	"CSGsignals",
	"NGCPoliceLights",
	"CSGsirens",
	"AURvehiclemisc",
	"DENheli",
	"AURmodshop",
	"NGCtunning",
	"AURcardoor",
	"AURcruise",
	"AURcycleSkills",
	"AURmagnet",
	"AURneon",
	"AURvehiclepaints",
	"AURpassenger",
	"AURpaynspray",
	"AURshamal",
	"AURsiren",
	"AURvehicletune",
	"AURusedvehicleshop",
	"AURvhud",
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
	"AURfire",
	"AURpilot",
	"AURstreetcleaner",
	"CSGtopjobs",
	"DENcriminal",
	"AURmech",
	--"AURmedic",
	"AURfarmer",
	"AURfish",
	"AURgarbage",
	"AURlumber",
	"AURrescuer",
	"AURtaxi",
	"AURtruck",
	--- new things
	"AURbusiness",
	"AURstats",
	"AURvip",
	"AURhijack",
	"AURUSEscort",
	"AURFindTheSlut",
	"AURmaps",
	"AURlvdmarea",
	"AURmapmodels",
	"AURgmusic",
	"AURmarkerWL",
	"AURvehmods",
	"AURstores",
	"AURspecialarea",




	--- Misc
	"CSGLadder",
	"CSGlaser",
	"CSGpeak",
	"CSGprogressbar",
	"AURstaticpedveh",
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
	"AURtransports",
	"NGCpara",
	-- Crims
	"AURcriminalskill",
	"AURccrate",
	"AURcrimboss",
	"AURcriminalMine",

	-- Law
	"NGCbribe",
	"DENlaw",
	"DENpolice",
	"NGClawSkills",
	"NGCpchief",
	"AURlawbarriers",
	"NGCjailBreak",


	-- Events
	"CSGdice",
	"CSGnewturfing2",
	"AURarmordelivery",
	"NGCarmoredEscort",
	"NGCdrugEvent",
	"NGCduel",
	"AURfallout",
	"AURhostages",
	"AURstorerobbery",
	"AURgames",
	"AURcnr",
	"AURtdm",
	"AURgamesDD",
	"AURgamesDM",
	"AURgameshooter",



	-- Weapons & Shops
	"DENweapons",
	"AUR247",
	"AURammunation",
	"AURmines",
	"NGCgym",



	--- Drugs
	"CSGdrugs",
	"AURdrugstore",
	"AURcraft",
	---"NGCdrugplayershop",
	"NGCdrugsEscort",
	"AURdrugsFarmer",

	-- Smith shit
	"AURavAlarm",
	"CSGsmithsDx",
	"NGCMFmisc",
	"NGCMFmisc2",
	"NGCPDbarriers",
	"NGCStaffSteath",
	-- NGC
	"CSGgps",
	"reload",
	"scoreboard",
	"bone_attach",
	"killmessages",
	"NGCheadshot",
	"AURbasehealth",
	"missiontimer",
	"parachute",
	"driveby",
	"slothbot",
	"webbrowser",
	"AURupdates",
	"ajax",
	"country",
	"cpicker",
	"interiors",
	"AURstream",
	"NGCwebS",
	"AURbases",
	"AURspawners",
	"AURteleporters",
	"AURgatez",
	"AURnitro",
	"AURvehicles",
	"AURgroups",
	--"AURwife",


	"AURhydra",
	"AURbillboard",
	"AURmysteryVan",
	"AURmoney",
	"AURvehicleBarriers",
	"AURjailmisc",
	"AURplayerhud",
	"AURwater",
	"AURpoints",
	"AURtrade",
	"AURsamerhitme",
	--"AURsamerwepbinds",
	"AURsamercarInvis",
	"AURquiz",
	"AURdiver",
	"DAWNintmods",
	"AURaghost",
	"AURamisc",
	"AURdivisions",
	"AURrestrictedArea",
	"AURtopCriminal",
	"NGClotto",
	"AURclothesjob",
	"AURmansionraid",


	--Curt's Resources
	"AURcivilinc",
	"AURcurtmisc",
	"AURcurtmisc2",
	"AURachievements",
	"AURachievement_detector",
	"AURcinema",
	"AURconvstore",
	"AURcrafting",
	"AURdynamic_weather",
	"AURillegalraces",
	"AURinfobar",
	"AURjob_miner",
	"AURvotepoll",
	"AURsupporternew",
	"AURdebrand_players",
	"AURcurtanti_cheat",
	"AURautodonations",
	"AURgrenadelauncher",
	"discord",
	"AUR2fa",
	"AURjailbreak",
	"AURadminreports",
	"discord_logs",
	"discord_staff",
	"discord-events_staff",
	"AURhelmet",
	"AURstatistics",
	"AURlanguage",
	"AURtax",
	"AURgrouptags",
	"AURuserpanel",
	"AURsgserver",
	"AURcriminalp",
	"AURroomsquitjoin",
	"AURroom_admin",
	"AURwebadmin",

	--Swagy Resources
	"AURpostman",
	"AURlawfarm",
	"AURdebranded_vehicles",


	--V2
	"USGcnr_spawnersbases",

	--"AURagents",
	"AURanndonor",
	"AURanubhavMisc",
	--"AURarmedvehicle",
	"AURbaseinfo",
	"AURbomb",
	"AURbriefmoney",
	"AURbrowser",
	"AURcases",
	"AURccr",
	"AURchrismoon",
	"AURcivil_groupexp",
	"AURcnrDrug",
	"AURcpicker",
	"AURcurtdev",
	"AURdailyrewards",
	"AURdebrand_vehicles",
	"AURdocumentation",
	"AURdrug_trafficker",
	"AURdymaps",
	"AURfastrope",
	"AURfreeVehicles",
	"AURgamesCSGO",
	"AURgamesDrag",
	"AURgamesTrials",
	"AURgetskin",
	"AURgroupmanager",
	"AURmanagegrp",
	"AURgymtraining",
	"AURhosuerob",
	"AURhydramissiles",
	"AURigsettings",
	"AURinteractions",
	"AURlogins",
	"AURlscounter",
	"AURminerSell",
	"AURmplayer",
	"AURnewplayer",
	"AURnicks",
	"AURpacketloss",
	"AURprogressbar",
	"AURparamaedicj",
	"AURpizzaboy",
	"AURpunishmentg",
	"AURreferrer",
	"AURrepairkits",
	"AURseaturfs",
	"AURsnow",
	"NGCxmas",
	"AURsameruserpanel",
	"AURskillswnd",
	"AURsamerwepbinds",
	"AURsamermisc",
	"AURcivilpayment",
	"AURsamcanims",
	"AURsameremotes",
	"AURvehicleshop",
	"AURfuel",
	"CSGgroups",

	-- Discord related
	"AURgroupChatSyncHooks",
	"AURgroupChatSync",

	"AURdmgstyles",
	"AURunits",
	"AURvehname",
	"AURtaxidriver",
	--"AURsamlag",
	--"AURpremium",
	"AURrpunishments",
	"AURonjoinascivilian",
	"AURmailing",
	"AURdrones",
	"AURhouserob",

	"AURcentralizedDamage",
	"AURignoreCmd",
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
