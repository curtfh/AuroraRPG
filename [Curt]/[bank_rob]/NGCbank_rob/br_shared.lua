
colors = {}
setmetatable(colors, 
	{__newindex = function (self, key, value)
		rawset(self, key, {r = value[1], g = value[2], b = value[3], value[1], value[2], value[3]})
	end}
)
colors.critical = {255,0,0}
colors.notice = {0,255,0}
colors.normal = {0,255,255}
colors.cops = {0, 100, 255}
colors.criminals = {195, 0, 0}
colors.public = {255,255,0}

----------------- DEBUG STUFF
debugON = false
debugLVL = false -- false -> all, true -> error, number -> specified lvl or error
function d(...)
	if( not debugON) then return end
	arg = {...}
	lvl = 3
	if (arg[1] == 3 or arg[1] == 2 or arg[1] == 1 or arg[1] == 0) then
		lvl = arg[1]
		table.remove(arg, 1)
	end
	if (debugLVL == true and lvl ~= 1) or (debugLVL ~= false and debugLVL < lvl) then return end
	dbgMsg = ""
	for _,v in pairs(arg) do
		dbgMsg = dbgMsg .. " " .. tostring(v)
	end
	outputDebugString(dbgMsg, lvl)
end
d("THIS RESOURCE IS SPAMMING DEBUG, BECAUSE debugON IS SET!!!")
----------------- DEBUG END

function o (...)
	d("o", ...)
	exports.NGCdxmsg:createNewDxMessage(...)
end


_defaults = {}
function _defaults:hold(key,t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	self[key] = t2
end

function _defaults:get(key)
	local t = {}
	for k,v in pairs(self[key]) do
		t[k] = v
	end
	return t
end

--[[
	Checks for the element and down a table tree if neccessary.
	Especialy checks on entrances!
]]
function is(object, tree, _)
	--d("is()",object,tree,_)
	if tree == object then --d("was equal","tree",tree,"object",object) 
		return true
	elseif tree == nil and not _ then
		--d("no tree")
		return is(object, entrance)
	elseif type(tree) == "table" then
		--d("was table")
		if(tree[object]) then return tree[object] end
		for k,v in pairs(tree) do
			--d("key",k,"val",v)
			if is(object, v, true) then
				--d("was true")
				return true
			end
		end
		return false
	elseif entrance[tree] then
		return is(object,entrance[tree], true)
	else return false end
end