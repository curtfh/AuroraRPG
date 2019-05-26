function clientCall(player, fnName, ...)
	triggerClientEvent(player, 'onClientCall', player, fnName, ...)
end
