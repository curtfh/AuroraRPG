local theLanguageTable = {}

addEventHandler( "onClientResourceStart", getRootElement(), function ()
	setElementData(getLocalPlayer(), "localizationData", getLocalization()["name"])
	triggerServerEvent ("AURlanguage.getExportTable", resourceRoot, getLocalPlayer())
end)

function updateExportTable(theTable) 
	theLanguageTable = theTable
end 
addEvent("AURlanguage.updateExportTable", true)
addEventHandler("AURlanguage.updateExportTable", localPlayer, updateExportTable)

function getTranslate (theString, language)
	local theTable = theLanguageTable
	
	if (language == true) then 
		language = getLocalization()["name"]
	end 
	
	for i=1, #theTable do 
		if (string.lower(string.gsub(theTable[i].string, "%s+", "")) == string.lower(string.gsub(theString, "%s+", "")) and theTable[i].language == "ORIGINAL" and theTable[i].contributor == "AURORARPG" and theTable[i].type == "ORIGINAL") then 
			
			for z=1, #theTable do 
				if (theTable[z].language == language and theTable[z].linkedTo == theTable[i].id and theTable[z].contributor ~= "AURORARPG" and theTable[z].type == "new") then 
					return theTable[z].string
				end 
			end 
			return theTable[i].string
		end 
	end 
	triggerServerEvent ("AURlanguage.insertNonExistsingString", resourceRoot, getLocalPlayer(), theString)
	triggerServerEvent ("AURlanguage.getExportTable", resourceRoot, getLocalPlayer())
	return theString
end 

function getLanguage ()
	return getLocalization()["name"]
end 

if (fileExists("client_exports.lua")) then fileDelete("client_exports.lua") end