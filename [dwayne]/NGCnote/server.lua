
function addNote(id, text, player, r, g, b, timer)
	if (type(id) ~= "string") then return false end
	triggerClientEvent(player, "addNote", player, id, text, r, g, b, timer)
	return true
end
