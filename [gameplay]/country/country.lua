--[[**********************************
*
*	Multi Theft Auto - Admin Panel
*
*	admin_ip2c.lua
*
*	Original File by lil_Toady
*
**************************************]]





local tonumber = tonumber
local setmetatable = setmetatable

local CountryCodes =
{
	["AC"]="Ascension Island",
	["AD"]="Andorra",
	["AE"]="United Arab Emirates",
	["AF"]="Afghanistan",
	["AG"]="Antigua And Barbuda",
	["AI"]="Anguilla",
	["AL"]="Albania",
	["AM"]="Armenia",
	["AN"]="Netherlands Antilles",
	["AO"]="Angola",
	["AQ"]="Antarctica",
	["AR"]="Argentina",
	["AS"]="American Samoa",
	["AT"]="Austria",
	["AU"]="Australia",
	["AW"]="Aruba",
	["AX"]="Aland Islands",
	["AZ"]="Azerbaijan",
	["BA"]="Bosnia And Herzegovina",
	["BB"]="Barbados",
	["BD"]="Bangladesh",
	["BE"]="Belgium",
	["BF"]="Burkina Faso",
	["BG"]="Bulgaria",
	["BH"]="Bahrain",
	["BI"]="Burundi",
	["BJ"]="Benin",
	["BM"]="Bermuda",
	["BN"]="Brunei Darussalam",
	["BO"]="Bolivia",
	["BR"]="Brazil",
	["BS"]="Bahamas",
	["BT"]="Bhutan",
	["BV"]="Bouvet Island",
	["BW"]="Botswana",
	["BY"]="Belarus",
	["BZ"]="Belize",
	["CA"]="Canada",
	["CC"]="Cocos (Keeling) Islands",
	["CD"]="Congo, The Democratic Republic Of The",
	["CF"]="Central African Republic",
	["CG"]="Congo",
	["CH"]="Switzerland",
	["CI"]="Cote D'ivoire",
	["CK"]="Cook Islands",
	["CL"]="Chile",
	["CM"]="Cameroon",
	["CN"]="China",
	["CO"]="Colombia",
	["CR"]="Costa Rica",
	["CS"]="Serbia and Montenegro",
	["CU"]="Cuba",
	["CV"]="Cape Verde",
	["CX"]="Christmas Island",
	["CY"]="Cyprus",
	["CZ"]="Czech Republic",
	["DE"]="Germany",
	["DJ"]="Djibouti",
	["DK"]="Denmark",
	["DM"]="Dominica",
	["DO"]="Dominican Republic",
	["DZ"]="Algeria",
	["EC"]="Ecuador",
	["EE"]="Estonia",
	["EG"]="Egypt",
	["EH"]="Western Sahara",
	["ER"]="Eritrea",
	["ES"]="Spain",
	["ET"]="Ethiopia",
	["EU"]="Europe",
	["FI"]="Finland",
	["FO"]="Faroe Islands",
	["FR"]="France",
	["GA"]="Gabon",
	["GB"]="United Kingdom",
	["GD"]="Grenada",
	["GL"]="Greenland",
	["GM"]="Gambia",
	["GW"]="Guinea-Bissau",
	["GY"]="Guyana",
	["HU"]="Hungary",
	["ID"]="Indonesia",
	["IE"]="Ireland",
	["IL"]="Israel",
	["IN"]="India",
	["IQ"]="Iraq",
	["IS"]="Iceland",
	["IT"]="Italy",
	["JA"]="Japan",
	["JM"]="Jamaica",
	["JP"]="Japan",
	["KW"]="Kuwait",
	["LT"]="Lithuania",
	["LU"]="Luxembourg",
	["LV"]="Latvia",
	["LY"]="Libyan Arab Jamahiriya",
	["MC"]="Monaco",
	["MG"]="Madagascar",
	["MH"]="Marshall Islands",
	["MIL"]="United States",
	["MT"]="Malta",
	["NG"]="Nigeria",
	["NL"]="Netherlands",
	["NO"]="Norway",
	["NR"]="Nauru",
	["PA"]="Panama",
	["PE"]="Peru",
	["PH"]="Philippines",
	["PK"]="Pakistan",
	["PL"]="Poland",
	["PR"]="Puerto Rico",
	["PS"]="Palestinian Territory, Occupied",
	["PT"]="Portugal",
	["QA"]="Qatar",
	["RE"]="Reunion",
	["RO"]="Romania",
	["RU"]="Russian Federation",
	["RW"]="Rwanda",
	["SE"]="Sweden",
	["SJ"]="Svalbard And Jan Mayen",
	["SL"]="Sierra Leone",
	["SO"]="Somalia",
	["SY"]="Syrian Arab Republic",
	["TD"]="Chad",
	["TO"]="Tonga",
	["TV"]="Tuvalu",
	["UA"]="Ukraine",
	["UK"]="United Kingdom",
	["UM"]="United States Minor Outlying Islands",
	["US"]="United States",
	["VN"]="Vietnam",
	["WF"]="Wallis And Futuna",
	["WS"]="Samoa",
	["YE"]="Yemen",
	["YT"]="Mayotte",
	["YU"]="Yugoslavia",
	["ZA"]="South Africa",
	["ZZ"]="None"
}

local aCountries = {}
local makeCor

function getPlayerCountry ( player )
	if not ( isElement( player ) ) then return false end
	local country = getIpCountry ( getPlayerIP ( player ) )
	if ( country ) and ( CountryCodes[ country ] ) then
		return country, CountryCodes[ country ]
	else
		return country
	end
end

function getIpCountry ( ip )
	if not loadIPGroupsIsReady() then return false end
	local ip_group = tonumber ( gettok ( ip, 1, 46 ) )
	local ip_code = ( gettok ( ip, 2, 46 ) * 65536 ) + ( gettok ( ip, 3, 46 ) * 256 ) + ( gettok ( ip, 4, 46 ) )
	if ( not aCountries[ip_group] ) then
		return false
	end
	for id, group in ipairs ( aCountries[ip_group] ) do
		local buffer = ByteBuffer:new( group )
		local rstart = buffer:readInt24()
		if ip_code >= rstart then
			local rend = buffer:readInt24()
			if ip_code <= rend then
				local rcountry = buffer:readBytes( 2 )
				return rcountry ~= "ZZ" and rcountry
			end
		end
	end
	return false
end

-- Returns false if aCountries is not ready
function loadIPGroupsIsReady ()
	if ( get ( "*useip2c" ) == "false" ) then return false end
	if ( #aCountries == 0 and not makeCor) then
    	makeCor = coroutine.create(loadIPGroupsWorker)
    	coroutine.resume(makeCor)
	end
	return makeCor == nil
end
setTimer( loadIPGroupsIsReady, 1000, 1 )

-- Load all IP groups
function loadIPGroupsWorker ()
	unrelPosReset()

	local readFilename = "IpToCountryCompact.csv";
	local hReadFile = fileOpen( readFilename, true )
	if not hReadFile then
		outputHere ( "Cannot read " .. readFilename )
		return
	end

	local buffer = ""
	local tick = getTickCount()
	while true do
		local endpos = string.find(buffer, "\n")

		if makeCor and ( getTickCount() > tick + 50 ) then
			-- Execution exceeded 50ms so pause and resume in 50ms
			setTimer(function()
				local status = coroutine.status(makeCor)
				if (status == "suspended") then
					coroutine.resume(makeCor)
				elseif (status == "dead") then
					makeCor = nil
				end
			end, 50, 1)
			coroutine.yield()
			tick = getTickCount()
		end

		-- If can't find CR, try to load more from the file
		if not endpos then
			if fileIsEOF( hReadFile ) then
				break
			end
			buffer = buffer .. fileRead( hReadFile, 500 )
		end

		if endpos then
			-- Process line
			local line = string.sub(buffer, 1, endpos - 1)
			buffer = string.sub(buffer, endpos + 1)

			local parts = split( line, string.byte(',') )
			if #parts > 2 then
				local rstart = tonumber(parts[1])
				local rend = tonumber(parts[2])
				local rcountry = parts[3]

				-- Relative to absolute numbers
				rstart = unrelRange ( rstart )
				rend = unrelRange ( rend )

				-- Top byte is group
				local group = math.floor( rstart / 0x1000000 )

				-- Remove top byte from ranges
				rstart = rstart - group * 0x1000000
				rend = rend - group * 0x1000000

				if not aCountries[group] then
					aCountries[group] = {}
				end
				local count = #aCountries[group] + 1

				-- Add country/IP range to aCountries
				local buffer = ByteBuffer:new()
				buffer:writeInt24( rstart )
				buffer:writeInt24( rend )
				buffer:writeBytes( rcountry, 2 )
				aCountries[group][count] = buffer.data
			end
		end
	end
	fileClose(hReadFile)
	makeCor = nil
	collectgarbage("collect")

	-- Update currently connected players
	for user,info in pairs( aPlayers ) do
		info["country"] = getPlayerCountry ( user )

		-- Send info to all admins
		for id, admin in ipairs(getElementsByType("player")) do
			if ( hasObjectPermissionTo ( admin, "general.adminpanel" ) ) then
				triggerClientEvent ( admin, "aClientPlayerJoin", user, false, false, false, false, false, aPlayers[user]["country"] )
			end
		end
	end

	return true
end

-- For squeezing data together
ByteBuffer = {
	new = function(self, indata)
		local newItem = { data = indata or "", readPos = 1 }
		return setmetatable(newItem, { __index = ByteBuffer })
	end,

	Copy = function(self)
		return ByteBuffer:new(self.data)
	end,

	-- Write
	writeInt24 = function(self,value)
		local b0 = math.floor(value / 1) % 256
		local b1 = math.floor(value / 256) % 256
		local b2 = math.floor(value / 65536) % 256
		self.data = self.data .. string.char(b0,b1,b2)
	end,

	writeBytes = function(self, chars, count)
		self.data = self.data .. string.sub(chars,1,count)
	end,

	-- Read
	readInt24 = function(self,value)
		local b0,b1,b2 = string.byte(self.data, self.readPos, self.readPos+2)
		self.readPos = self.readPos + 3
		return b0 + b1 * 256 + b2 * 65536
	end,

	readBytes = function(self, count)
		self.readPos = self.readPos + count
		return string.sub(self.data, self.readPos - count, self.readPos - 1)
	end,
}

-- Make a stream of absolute numbers relative to each other
local relPos = 0
function relPosReset()
	relPos = 0
end

function relRange( v )
	local rel = v - relPos
	relPos = v
	return rel
end

-- Make a stream of relative numbers absolute
local unrelPos = 0
function unrelPosReset()
	unrelPos = 0
end

function unrelRange( v )
	local unrel = v + unrelPos
	unrelPos = unrel
	return unrel
end

-- IP2C logging
function outputHere( msg )
	--outputServerLog ( msg )
	outputChatBox ( msg )
end

addEventHandler ( "onPlayerJoin", root,
	function ()
	-- Set the country flag of the player
		local code, country = exports.Country:getPlayerCountry( source )
		if ( code ) and ( code ~= "" ) and ( code ~= " " ) then
			setElementData( source, "Loc", ":Country/flags/" .. code .. ".png" )
			setElementData( source, "Country", code )
		else
			setElementData( source, "Loc", "Unknown" )
		end
		if (getPlayerSerial(source) == "438021E20C4EA1186ACE94C07E945C12") then
			setElementData( source, "Loc", ":Country/flags/lb.png" )
			setElementData( source, "Country", "LB" )
		end
if (getPlayerSerial(source) == "2B5A195F201402F0A599D98E209C0683") then
			setElementData( source, "Loc", ":Country/flags/lb.png" )
			setElementData( source, "Country", "LB" )
		end
	end
)
