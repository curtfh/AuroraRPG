addEvent("eEdit.submitPlayerElement",true)
addEventHandler("eEdit.submitPlayerElement",root,
	function(player,part)
		if player then
			local tab = getAllElementData(player)
			if part then
				triggerClientEvent(source,"eEdit.receiveElementData",source,tab,part)
			else
				triggerClientEvent(source,"eEdit.receiveElementData",source,tab)
			end
		end
	end
)
addEventHandler("onPlayerLogin",root,
	function(_,new)
		if isObjectInACLGroup("user."..getAccountName(new), aclGetGroup("Admin")) then
			triggerClientEvent(source,"eEdit.onClientVerified",source)
		end
	end
)

addEventHandler("onPlayerLogout",root,
	function()
		triggerClientEvent(source,"eEdit.destroyElements",source)
	end
)

addEvent("eEdit.checkPermission",true)
addEventHandler("eEdit.checkPermission",root,
	function()
		for i,v in ipairs(getElementsByType"player") do
			if getElementData(v,"isPlayerPrime") then
				triggerClientEvent(v,"eEdit.onClientVerified",root)
			end
		end
	end
)
