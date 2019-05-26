LawSkins = {
	--{"hallo2",220}, -- halloweeen skins
	--{"hallo3",221}, -- halloweeen skins



	-- VIP player
	{"avatar",229}, -- avatar
	{"batman",223}, -- veer
	{"troll",139}, -- Smiler
	{"ghost", 290}, --VIP ghost
	{"robber", 297}, --VIP robber
	{"Chloe", 183}, --VIP girl
	{"bmost", 41}, --HITMAN


	-- Criminal Groups
--- N/A
	{"prime", 221},

	-- LAW Groups
--- N/A


	-- Staff,Government,Civ Skins (DONT TOUCH)

	{"thief",68},
	{"Diver",49},
	{"cia",165},
	--{"army",287},
	{"taskforce",295},
	{"detective",166},

	-- Weapons and Misc
	{"health",1240},
	{"minigun",362},
	{"taser",347},
	{"bat",336},
	{"jetpack",370},

	--- vehicles
	{"pdm",497}, -- police maverick
	{"hydra",520},
	{"admiral",445},
	{"ambulance",416},
	{"banshee",429},
	{"barracks",433},
	{"buffalo",402},
	{"comet",480},
	{"merit",551},
	{"sabre",475},
	{"sentinel",405},
	{"solair",458},
	{"sultan",560},
	{"turismo",451},
	{"zr-350",477},
	{"patriot",470},
	--{"copcarlv",598},
	{"copcarru",599},
	{"copcarsf",597},
	{"copcarvg",598},
	{"copcarla",596},
	{"enforcer",427},
	{"fbiranch",490},
	{"copbike",523},	
	{"stretch",409},
	{"helmet",2050}, -- Helmet
	{"rcraider",465}, -- rc
	{"at400",592}, -- rc
	{"fcr900",521}, -- motorbike
	{"bf400",581}, -- motorbike
	{"drone_",593}, -- drone
	--{"infernus",411},
	-- {"filename",id},
}

local mods = {}
local txdFile = {}
local dffFile = {}

function normalSkin(skin)
	for k,v in ipairs(LawSkins) do
		if v[2] == tonumber(skin) then
			return false
		end
	end
	return true
end


function onThisResourceStart ( )
	for k,v in ipairs(LawSkins) do
		downloadFile ( "models/"..v[1]..".dff" )
	end
end
addEventHandler ( "onClientResourceStart", resourceRoot, onThisResourceStart )

function onDownloadFinish ( file, success )
    if ( source == resourceRoot ) then                            -- if the file relates to this resource
        if ( success ) then
			for k,v in ipairs(LawSkins) do
				if file == "models/"..v[1]..".dff" then
					if fileExists(":AURmodels/models/"..v[1]..".dff") then
						loadMyMods(v[1],":AURmodels/models/"..v[1]..".dff",":AURmodels/models/"..v[1]..".txd",v[2],v[1])
					else
						print(v[1]..".dff doesn't exist")
					end
				elseif file == "models/"..v[1]..".txd" then
					if fileExists(":AURmodels/models/"..v[1]..".dff") and fileExists(":AURmodels/models/"..v[1]..".txd") then
						loadSkins(v[1],v[2])
					else
						print(v[1]..".txd doesn't exist")
					end
				end
            end
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )

function loadMyMods(name,dff,txd,id,wh)
	downloadFile ( "models/"..name..".txd" )
end

function loadSkins(name,id)
	mods[name] = {
		{name,id}
	}
	replaceMods(name)
end

function replaceMods(name)
	for k,v in ipairs(mods[name]) do
		if fileExists(":AURmodels/models/"..v[1]..".txd") then
			txd = engineLoadTXD(":AURmodels/models/"..v[1]..".txd")
			if txd and txd ~= false then
				engineImportTXD(txd,v[2])
			end
		end
		if fileExists(":AURmodels/models/"..v[1]..".dff") and fileExists(":AURmodels/models/"..v[1]..".txd") then
			if fileExists(":AURmodels/models/"..v[1]..".dff") then
				dff = engineLoadDFF(":AURmodels/models/"..v[1]..".dff",v[2])
				if txd and txd ~= false then
					if dff and dff ~= false then
						if v[2] then
							engineReplaceModel(dff,v[2])
							--outputDebugString(v[1].." model has been loaded")
						end
					end
				end
			end
		end
	end
end
