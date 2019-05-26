local skinShops = {
-- LS shops
{1447.08,-1126.32,23.93,0,0},
{2244.72,-1679.73,15.47,0,0},
{443.15,-1503.66,22.45,0,0},
{491.03,-1379.86,16.39,0,0},
---lv
{1669.47,1735.46,10.81,0,0},
{2785.6,2459.91,11.06,0,0},
{2811.46,2439.6,11.06,0,0},
-- SF
-- SF shops
{204.01, -43.9, 1001.8, 1, 1, 2.8921813964844},
{207.9, -101.35, 1005.25, 15, 6, 357.28359985352},
{161.38, -84, 1001.8, 18, 2, 356.77270507812},
{207.33, -10.34, 1001.21, 5, 10, 356.77270507812},
}

function fireUpClothesStores()
	for i=1,#skinShops do
		local x,y,z,int,dimension = unpack(skinShops[i])
		local marker = createMarker(x,y,z-1,"cylinder",2,200,150,0,150)
		setElementInterior(marker, int)
		setElementDimension(marker, dimension)
		addEventHandler("onMarkerHit", marker, playerHitsClothesStore)
	end
	setTimer(function()
	for k,v in ipairs(getElementsByType("player")) do
		local id = exports.server:getPlayerAccountID(v)
		if id then
			local data = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",id)
			checkSkin(v,data.skin)
		end
	end
	end,5000,1)
end
addEventHandler("onResourceStart", resourceRoot, fireUpClothesStores)

function playerHitsClothesStore(player, MD)
	if (MD and getElementType(player) == "player") then
		triggerClientEvent(player, "showClothesGUI", player, ClothesTable)
		setElementData(player,"skinShopTempSkin",tonumber(getElementModel(player)))
	end
end


function playerBuysSkin(client, skin,price,falseClient)
	if (getPlayerMoney(client) >= price*exports.AURtax:getCurrentTax()) then
		takePlayerMoney(client, price*exports.AURtax:getCurrentTax())
		exports.NGCdxmsg:createNewDxMessage( client, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
		if getPlayerTeam(client) and getTeamName(getPlayerTeam(client)) == "Unemployed" or getTeamName(getPlayerTeam(client)) == "Criminals" or getTeamName(getPlayerTeam(client)) == "Unoccupied" then
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You have bought a skin for $"..price, 255, 255, 0)
			local pAccountID = exports.server:getPlayerAccountID(client)
			exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skin,pAccountID)
			setElementModel(client, tonumber(skin))
			if skin == 0 then
				local playerID = exports.server:getPlayerAccountID( client )
				local playerData = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE id=? LIMIT 1", playerID )
				if ( playerData ) then
					local CJCLOTTable = fromJSON( tostring( playerData.cjskin ) )
					if CJCLOTTable then
						for theType, index in pairs( CJCLOTTable ) do
							local texture, model = getClothesByTypeIndex ( theType, index )
							addPedClothes ( client, texture, model, theType )
						end
					end
					return true
				else
					return false
				end
			end
		else
			local pAccountID = exports.server:getPlayerAccountID(client)
			exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skin,pAccountID)
			if not falseClient then
				exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You have bought a skin for $"..price, 255, 255, 0)
				exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: To see your new skin go off duty", 255, 255, 0)

				setElementModel(client, tonumber(getElementData(client,"skinShopTempSkin")) or 0)
			end

		end
	else
		exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You don't have enough money to buy skin.", 255, 255, 0)
	end
end
addEvent("buyNewSkin", true)
addEventHandler("buyNewSkin", root, playerBuysSkin)

addEvent("setTempSkin",true)
addEventHandler("setTempSkin",root,
function (client)
	setElementModel(client, tonumber(getElementData(client,"skinShopTempSkin")))
end)


addEvent("buyVIPSkin",true)
addEventHandler("buyVIPSkin",root,
function (client,skin,price)
	if getElementData(client,"isPlayerVIP") == true then
	if getPlayerMoney(client) >= price*exports.AURtax:getCurrentTax() then
		takePlayerMoney(client,price*exports.AURtax:getCurrentTax())
		exports.NGCdxmsg:createNewDxMessage( client, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
		if getPlayerTeam(client) and getTeamName(getPlayerTeam(client)) == "Unemployed" or getTeamName(getPlayerTeam(client)) == "Criminals" or getTeamName(getPlayerTeam(client)) == "Unoccupied" then
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You have bought a skin for $"..price, 255, 255, 0)
			local pAccountID = exports.server:getPlayerAccountID(client)
			exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skin,pAccountID)
			setElementModel(client, tonumber(skin))
		else
			local pAccountID = exports.server:getPlayerAccountID(client)
			exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skin,pAccountID)
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You have bought a skin for $"..price, 255, 255, 0)
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: To see your new skin go off duty", 255, 255, 0)
			setElementModel(client, tonumber(getElementData(client,"skinShopTempSkin")))
		end
	else
		exports.NGCdxmsg:createNewDxMessage(client,"You don't have enough money to buy this skin")
	end
	else
		exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: Sorry you are not VIP member!!",255,0,0)
	end
end)

addEvent("buyLimitedSkin",true)
addEventHandler("buyLimitedSkin",root,
function (client,skin,price)
	if getPlayerMoney(client) >= price*exports.AURtax:getCurrentTax() then
		takePlayerMoney(client,price*exports.AURtax:getCurrentTax())
		exports.NGCdxmsg:createNewDxMessage( client, "Transaction Alert: "..exports.AURtax:getCurrentTax().."% has taken from your money due to taxes.", 225, 0, 0 )
		if getPlayerTeam(client) and getTeamName(getPlayerTeam(client)) == "Unemployed" or getTeamName(getPlayerTeam(client)) == "Criminals" or getTeamName(getPlayerTeam(client)) == "Unoccupied" then
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You have bought a skin for $"..price, 255, 255, 0)
			local pAccountID = exports.server:getPlayerAccountID(client)
			exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skin,pAccountID)
			setElementModel(client, tonumber(skin))
		else
			local pAccountID = exports.server:getPlayerAccountID(client)
			exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skin,pAccountID)
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: You have bought a skin for $"..price, 255, 255, 0)
			exports.NGCdxmsg:createNewDxMessage(client,"Skin shop: To see your new skin go off duty", 255, 255, 0)
			setElementModel(client, tonumber(getElementData(client,"skinShopTempSkin")))
		end
	else
		exports.NGCdxmsg:createNewDxMessage(client,"You don't have enough money to buy this skin")
	end
end)

addEvent("loadSkinXML",true)
addEventHandler("loadSkinXML",root,function(mode)
	local table = {}
	local node = xmlLoadFile ( "skins.xml" )
	if ( node ) then
		local groups = 0
		while ( xmlFindChild ( node, "group", groups ) ~= false ) do
			local group = xmlFindChild ( node, "group", groups )
			local groupn = xmlNodeGetAttribute ( group, "name" )
			table[groupn] = {}
			local skins = 0
			while ( xmlFindChild ( group, "skin", skins ) ~= false ) do
				local skin = xmlFindChild ( group, "skin", skins )
				local id = #table[groupn] + 1
				table[groupn][id] = {}
				table[groupn][id]["model"] = xmlNodeGetAttribute ( skin, "model" )
				table[groupn][id]["name"] = xmlNodeGetAttribute ( skin, "name" )
				skins = skins + 1
			end
			groups = groups + 1
		end
		xmlUnloadFile ( node )
	end
	triggerClientEvent(source,"reloadSkinXML",source,table,mode)
end)


addEventHandler("onServerPlayerLogin",root,function()
	local id = exports.server:getPlayerAccountID(source)
	local data = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",id)
	checkSkin(source,data.skin)
end)

function checkSkin(p,myid)
	triggerClientEvent(p,"checkBlockedSkin",p,myid)
end

addEvent("onSetBlockSkin",true)
addEventHandler("onSetBlockSkin",root,function(id,blocked)
	if blocked == true then
		if exports.server:getPlayerAccountName(source) == "hana2" then
			return false
		end
		playerBuysSkin(source,0,100,true)
		exports.NGCdxmsg:createNewDxMessage(source,"We have caught custom skin saved into your account, resetting to CJ",255,0,0)
	end
end)


