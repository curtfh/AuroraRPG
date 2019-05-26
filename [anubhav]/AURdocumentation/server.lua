--[[
________________________________________________
AuroraRPG - aurorarpg.com

This resource is property of AuroraRPG.

Author: Anubhav Agarwal
All Rights Reserved 2017
________________________________________________
]]--

--connect = dbConnect("sqlite", "db.db")
--dbExec(connect, "CREATE TABLE IF NOT EXISTS documents(category TEXT, document TEXT, info TEXT)") -- since we use MySQL, change TEXT to LONGTEXT for info

function does_category_exist(category)
	--local db = dbPoll(dbQuery(connect, "SELECT * FROM documents WHERE category = ?", category), -1)
	local db = exports.DENmysql:query("SELECT * FROM documents WHERE category = ?", category)

	return (#db == 0 and false or true)
end

function does_document_exist(document)
	--local db = dbPoll(dbQuery(connect, "SELECT * FROM documents WHERE document = ?", document), -1)
	local db = exports.DENmysql:query("SELECT * FROM documents WHERE document = ?", document)
	return (#db == 0 and false or true)
end

function get_db()
	--return dbPoll(dbQuery(connect, "SELECT * FROM documents"), -1)
	return exports.DENmysql:query("SELECT * FROM documents")
end

function get_organized_db()
	local db = get_db()
	local organized_db = {}

	if (#db == 0) then 
		return {}
	end 

	for i, v in ipairs(db) do 
		if (organized_db[v['category']]) then 
			table.insert(organized_db[v['category']], {['document'] = v['document'],['info'] = v['info']})
		else
			organized_db[v['category']] = {{['document'] = v['document'],['info'] = v['info']}}
		end
	end

	return organized_db
end

function add_document(category, document, info)
	--return dbExec(connect, "INSERT INTO documents(category, document, info) VALUES(?,?,?)", category, document, info)
	return exports.DENmysql:exec("INSERT INTO documents(category, document, info) VALUES(?,?,?)", category, document, info)
end

function sendClient()
	triggerClientEvent(source, "AURnewRules.login", resourceRoot, get_organized_db(), false, exports.CSGstaff:isPlayerStaff(source))
end
addEvent("onServerPlayerLogin", true)
addEventHandler("onServerPlayerLogin", resourceRoot, sendClient)

--[[for i, v in ipairs(getElementsByType("player")) do
	if (exports.server:isPlayerLoggedIn(v)) then
		triggerClientEvent(v, "AURnewRules.login", v, get_organized_db(), false, exports.CSGstaff:isPlayerStaff(v))
	end
end]]--

function dataForkIntoClient()
	triggerClientEvent(client, "AURnewRules.login", resourceRoot, get_organized_db(), false, exports.CSGstaff:isPlayerStaff(client))
end
addEvent("AURnewRules.dataForkIntoClient", true)
addEventHandler("AURnewRules.dataForkIntoClient", resourceRoot, dataForkIntoClient)

function setDocumentData(document, info)
	if (exports.CSGstaff:isPlayerStaff(client)) then 
		--dbExec(connect, "UPDATE documents SET info=? WHERE document=? ", info, document)
		exports.DENmysql:exec("UPDATE documents SET info=? WHERE document=? ", info, document)
		triggerClientEvent(client, "AURnewRules.login", client, get_organized_db(), true)
		exports.CSGlogging:createAdminLogRow(client, getPlayerName(client).." has updated the following document: "..document)
	end
end
addEvent("AURnewRules.changeDocument", true)
addEventHandler("AURnewRules.changeDocument", resourceRoot, setDocumentData)

function openAdminPanel(p)
	if (exports.CSGstaff:isPlayerStaff(p)) then 
		triggerClientEvent(p, "AURnewRules.openAddPanel", p, get_organized_db())
	end
end
addCommandHandler("openarp", openAdminPanel)

function openADP(p)
	if (exports.CSGstaff:isPlayerStaff(p) and exports.CSGstaff:getPlayerAdminLevel(p) > 3) then 
		triggerClientEvent(p, "AURnewRules.openDeletePanel", p, get_organized_db())
	end
end
addCommandHandler("openadp", openADP)

function addCategoryDoc(category, doc, info)
	if (exports.CSGstaff:isPlayerStaff(client)) then 
		add_document(category, doc, info)
		triggerClientEvent(root, "AURnewRules.login", resourceRoot, get_organized_db(), true)
		exports.CSGlogging:createAdminLogRow(client, getPlayerName(client).." has added a document: "..doc.." to "..category)
  	end
end
addEvent("AURnewRules.adminAddCategory", true)
addEventHandler("AURnewRules.adminAddCategory", resourceRoot, addCategoryDoc)

function removeDocument(doc)
	if (exports.CSGstaff:isPlayerStaff(p) and exports.CSGstaff:getPlayerAdminLevel(p) > 3) then 
		--dbExec(connect, "DELETE FROM documents WHERE document=?", doc)
		exports.DENmysql:exec("DELETE FROM documents WHERE document=?", doc)
		exports.CSGlogging:createAdminLogRow(client, getPlayerName(client).." has removed a docoument: "..doc)
		triggerClientEvent(root, "AURnewRules.login", resourceRoot, get_organized_db(), true)
	end
end
addEvent("AURnewRules.adminDeleteDocument", true)
addEventHandler("AURnewRules.adminDeleteDocument", resourceRoot, removeDocument)

function removeCategory(cat)
	if (exports.CSGstaff:isPlayerStaff(p) and exports.CSGstaff:getPlayerAdminLevel(p) > 3) then 
		--dbExec(connect, "DELETE FROM documents WHERE category=?", cat)
		exports.DENmysql:exec("DELETE FROM documents WHERE category=?", cat)
		triggerClientEvent(root, "AURnewRules.login", resourceRoot, get_organized_db(), true)
		exports.CSGlogging:createAdminLogRow(client, getPlayerName(client).." has removed a category: "..cat)
	end
end
addEvent("AURnewRules.adminDeleteCategory", true)
addEventHandler("AURnewRules.adminDeleteCategory", resourceRoot, removeCategory)

--[[function openAllDocuments(player)
	if (exports.server:isPlayerLoggedIn(player)) then
		triggerClientEvent(player, "AURnewRules.gui", player)
	end
end
addCommandHandler("documentation", openAllDocuments)]]--