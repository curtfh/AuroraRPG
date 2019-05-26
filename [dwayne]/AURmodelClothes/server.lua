local CJTable = {}



addEvent( "onPayClothesCJ", true )
addEventHandler( "onPayClothesCJ", root,
function ( id,txd,dff,price,strings )
	addPedClothes ( source, txd, dff, id )
	exports.NGCmanagement:RPM(source,price,"NGC model clothes CJ")
	triggerEvent("onChangeClothesCJ",source,strings)
end
)

function reWearClothes(player,t)
	if t then
		for i=0,17 do
			removePedClothes(player,i)
		end
		for int, index in ipairs(t) do
			if (index.txd ~= "") then
				local texture, model = getClothesByTypeIndex ( index.txd, index.dff )
				if ( texture ) then
					addPedClothes ( player, index.txd, index.dff, index.id )
				end
			end
		end
	end
end

addEvent( "onChangeClothesCJ", true )
addEventHandler( "onChangeClothesCJ",getRootElement(),function (DString,tbl)
	local playerID = exports.server:getPlayerAccountID( source )
	local updateMySQL = exports.DENmysql:exec( "UPDATE accounts SET cjskin=? WHERE id=?",DString, playerID )
	reWearClothes(source,tbl)
end)
tim = {}
addEventHandler("onElementModelChange", root,function()
	if source then
		if getElementType(source) == "player" then
			if exports.server:isPlayerLoggedIn(source) then
				if getElementModel(source) == 0 then
					if isTimer(tim[source]) then killTimer(tim[source]) end
					tim[source] = setTimer(function(p)
						for i=0,17,1 do
							removePedClothes(p,i)
						end
						local t = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",exports.server:getPlayerAccountID(p))
						if t then
							local CJCLOTTable = fromJSON( tostring( t.cjskin ) )
							if CJCLOTTable then
								for theType, index in pairs( CJCLOTTable ) do
									local texture, model = getClothesByTypeIndex ( theType, index )
									addPedClothes ( p, texture, model, theType )
								end
							else
								addPedClothes(p,"vest","vest",0)
								addPedClothes(p,"jeansdenim","jeans",2)
							end
						else
							addPedClothes(p,"vest","vest",0)
							addPedClothes(p,"jeansdenim","jeans",2)
						end
					end,1000,1,source)
				end
			end
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			if getElementModel(v) == 0 then
				if isTimer(tim[v]) then killTimer(tim[v]) end
				tim[v] = setTimer(function(p)
					for i=0,17,1 do
						removePedClothes(p,i)
					end
					local t = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",exports.server:getPlayerAccountID(p))
					if t then
						local CJCLOTTable = fromJSON( tostring( t.cjskin ) )
						if CJCLOTTable then
							for theType, index in pairs( CJCLOTTable ) do
								local texture, model = getClothesByTypeIndex ( theType, index )
								addPedClothes ( p, texture, model, theType )
							end
						else
							addPedClothes(p,"vest","vest",0)
							addPedClothes(p,"jeansdenim","jeans",2)
						end
					else
						addPedClothes(p,"vest","vest",0)
						addPedClothes(p,"jeansdenim","jeans",2)
					end
				end,1000,1,v)
			end
		end
	end
end)

function loadValidClothes(player)
	if getElementModel(player) == 0 then
		if isTimer(tim[player]) then killTimer(tim[player]) end
		tim[player] = setTimer(function(p)
			for i=0,17,1 do
				removePedClothes(p,i)
			end
			local t = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",exports.server:getPlayerAccountID(p))
			if t then
				local CJCLOTTable = fromJSON( tostring( t.cjskin ) )
				if CJCLOTTable then
					for theType, index in pairs( CJCLOTTable ) do
						local texture, model = getClothesByTypeIndex ( theType, index )
						addPedClothes ( p, texture, model, theType )
					end
				else
					addPedClothes(p,"vest","vest",0)
					addPedClothes(p,"jeansdenim","jeans",2)
				end
			else
				addPedClothes(p,"vest","vest",0)
				addPedClothes(p,"jeansdenim","jeans",2)
			end
		end,1000,1,player)
	end
end

addEventHandler("onServerPlayerLogin",root,function()
	loadValidClothes(source)
end)

addEventHandler("onPlayerSpawn",root,function()
	loadValidClothes(source)
end)
