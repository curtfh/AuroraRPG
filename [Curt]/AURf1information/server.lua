local storedData = {}
local fileSystem = {}

function loadDataToServerMemory ()
	local file = fileOpen("database.json")
	fileSystem = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file)
	for i=1, #fileSystem do 
		local dsc = #storedData+1
		storedData[dsc][1] = fileSystem[i][1]
		if fileExists("articles/"..i..".html") then 
			local fileR = fileOpen("articles/"..i..".html")
			storedData[dsc][2] = fileRead(fileR, fileGetSize("articles/"..i..".html"))
		else
			storedData[dsc][2] = "Document cannot be load."
		end 
	end 
end 

function getDataList()
	triggerClientEvent(client, "AURf1information.update", client, storedData)
end 
addEvent ("AURf1information.getDataList", true)
addEventHandler ("AURf1information.getDataList", resourceRoot, getDataList)


function saveData(id, context)
	storedData[id][2] = context
	local file = fileOpen("articles/"..id..".html")
	fileWrite(file, context)
	fileClose(file)
end 
addEvent ("AURf1information.saveData", true)
addEventHandler ("AURf1information.saveData", resourceRoot, saveData)

function addData(title, context)
	local id = #storedData + 1
	storedData[id][1] = title
	local file = fileCreate("articles/"..id..".html")
	fileWrite(file, context)
	fileClose(file)
	
	fileSystem[#fileSystem+1][1] = title
	local file = fileCreate("database.json")
	fileWrite(file, toJSON(fileSystem))
	fileClose(file)
end 
addEvent ("AURf1information.saveData", true)
addEventHandler ("AURf1information.saveData", resourceRoot, saveData)