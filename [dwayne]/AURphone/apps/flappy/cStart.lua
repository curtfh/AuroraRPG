-- #######################################
-- ## Project: MTA FlappyBird			##
-- ## Name: Script.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

local flappy = false;

--[[

]]

addEventHandler("onClientResourceStart", root, function()
	apps[18][8] = openFlap
	apps[18][9] = closeflap
end)

function closeflap()
apps[18][7] = false
flappyBirdGame:Destructor();
end

function openFlap()
apps[18][7] = true
flappyBirdGame	= FlappyBirdGame:New();
end

