-- Database Functions
---------------------->>

local ipairs = ipairs
local type = type
local tonumber = tonumber

local database_online
builderdata = {}

addEvent("onDatabaseLoad", true)

-- Cache Builder Data Database
------------------------------->>

function cacheDatabase()
	local result = exports.DENmysql:query("SELECT * FROM `realestate`")
	builderdata["Console"] = {}
	for i,row in ipairs(result) do
		builderdata[row.name] = {}
		for column,value in pairs(row) do
			if (column ~= "name" or column ~= "id") then
				if (not builderdata["Console"][column]) then
					builderdata["Console"][column] = true
				end
				if (value == "true") then value = true end
				if (value == "false") then value = false end
				builderdata[row.name][column] = value
			end
		end
	end
	database_online = true
	outputDebugString("OO")
	triggerEvent("onDatabaseLoad", resourceRoot, "builderdata")
end
addEventHandler("onResourceStart", resourceRoot, cacheDatabase)

-- Builder Zone Exports
------------------->>

function setZoneData(account, key, value)
	if (not database_online) then return false end
	if (not account or not key) then return false end
	--if (isGuestAccount(account) or type(key) ~= "string") then return false end
	
	if (type(key) ~= "string") then return false end

	--local account = getAccountName(account)
	
	if (not builderdata[account]) then
		builderdata[account] = {}
		exports.DENmysql:exec("INSERT INTO `realestate` (name) VALUES(?)", account)
	end

	if (builderdata["Console"] and builderdata["Console"][key] == nil) then
		builderdata["Console"][key] = true
		exports.DENmysql:exec("ALTER TABLE `realestate` ADD `??` text", key)
	end

	builderdata[account][key] = value
	if (value ~= nil) then
		exports.DENmysql:exec("UPDATE `realestate` SET `??`=? WHERE name=?", key, tostring(value), account)
	else
		exports.DENmysql:exec("UPDATE `realestate` SET `??`=NULL WHERE name=?", key, account)
	end
	return true
end

function getZoneData(account, key)
	if (not database_online) then return nil end
	if (not account or not key) then return nil end
	--if (isGuestAccount(account) or type(key) ~= "string") then return nil end
	if (type(key) ~= "string") then return nil end

	--local account = getAccountName(account)
	if (builderdata[account] == nil) then return nil end
	if (builderdata[account][key] == nil) then return nil end

	return tonumber(builderdata[account][key]) or builderdata[account][key]
end
