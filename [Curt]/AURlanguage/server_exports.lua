function getTranslate (theString, language, player)
	local theTable = exports.DENmysql:query("SELECT * FROM translations")
	
	if (language == true) then 
		language = getElementData(player, "localizationData")
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
	exports.DENmysql:exec("INSERT INTO translations SET type=?, linkedTo=?, language=?, string=?, date=?, contributor=?, contributor_name=?, version=?, responsible=?", "ORIGINAL", 0, "ORIGINAL", theString, "SERVER", "AURORARPG", "AuroraRPG", 1, "None")
	return theString
end 

function insertNonExistsingString (wat, theString)
	local theTable = exports.DENmysql:query("SELECT * FROM translations")
	for i=1, #theTable do 
		if (string.lower(string.gsub(theTable[i].string, "%s+", "")) == string.lower(string.gsub(theString, "%s+", "")) and theTable[i].language == "ORIGINAL" and theTable[i].contributor == "AURORARPG" and theTable[i].type == "ORIGINAL") then 			
			return true
		end 
	end 
	exports.DENmysql:exec("INSERT INTO translations SET type=?, linkedTo=?, language=?, string=?, date=?, contributor=?, contributor_name=?, version=?, responsible=?", "ORIGINAL", 0, "ORIGINAL", theString, "SERVER", "AURORARPG", "AuroraRPG", 1, "None")
end 
addEvent("AURlanguage.insertNonExistsingString", true)
addEventHandler("AURlanguage.insertNonExistsingString", resourceRoot, insertNonExistsingString)

function getExportTable (player)
	local theTable = exports.DENmysql:query("SELECT * FROM translations")
	triggerClientEvent(player, "AURlanguage.updateExportTable", player, theTable)
end
addEvent("AURlanguage.getExportTable", true)
addEventHandler("AURlanguage.getExportTable", resourceRoot, getExportTable)

function getLanguage (player)
	return getElementData(player, "localizationData")
end 