function isDev(p)
	return exports.CSGstaff:isPlayerDeveloper(p)
end

function compiledFileDoStuff(data, res, p, plr, rawName)
	if (fileExists(res.."c")) then
		fileDelete(res.."c")
	end

	local file = fileCreate(res.."c")
	fileWrite(file, data)
	fileFlush(file)
	fileClose(file)
	outputChatBox("Compiled "..rawName.." sucessfully! :)", plr, 25, 255, 25)
end

function compileFile(filePath, p, player, r)
	if (not fileExists(filePath)) then
		return outputChatBox("File does not exist", plr, 255, 25, 25)
	end
	local file = fileOpen(filePath)
	fetchRemote("http://luac.mtasa.com/?compile=1&debug=0&obfuscate=2", 
		function(data, info)
			compiledFileDoStuff(data, filePath, p, player, r)
		end
	, fileRead(file, fileGetSize(file)), true) 
	fileClose(file)
end

function fileCompiles(plr, _, res)
	if (not isDev(plr)) then
		return false 
	end
	if (not getResourceFromName(res)) then
		outputChatBox("Wrong resource name :(", plr, 255, 25, 25)
		return false 
	end
	local resource = getResourceFromName(res)
	if (getResourceState(resource) == "starting" or getResourceState(resource) == "running") then
		outputChatBox("Stop the resource before trying to compile it!", plr, 255, 25, 25)
		return false 
	end
	local xmlPath = ":"..res.."/meta.xml"
	local xml = xmlLoadFile(xmlPath)
	if (not xml) then
		outputChatBox("Failed to open META.XML find scripts", plr, 255, 25, 25)
		return false 
	end
	local metaNodes = xmlNodeGetChildren(xml) 
	for i=1, #metaNodes do
		local node = metaNodes[i]
		if (xmlNodeGetName(node) == "script") then
			local scriptName = xmlNodeGetAttribute(node, "src")
			local scriptType = xmlNodeGetAttribute(node, "type")
			local spli = split(scriptName, ".")
			if (spli[2] ~= "luac" and scriptType == "client") then
				compileFile(":"..res.."/"..scriptName, xmlPath, plr, scriptName)
			end
		end
	end
	xmlUnloadFile(xml)
end
addCommandHandler("compile", fileCompiles)

function fileCompiles(plr, _, res)
	if (not isDev(plr)) then
		return false 
	end
	if (not getResourceFromName(res)) then
		outputChatBox("Wrong resource name :(", plr, 255, 25, 25)
		return false 
	end
	compileFile(":"..res.."/".."client.lua", "", plr, "client.lua")
end
addCommandHandler("compile_client", fileCompiles)
