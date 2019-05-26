local theTable = {
--x, y, z, business_id, type, about, earning phour, timeleft, sell?, restricted_to
{1028.73, -1031.27, 31.99, "Pay 'n  Spray", 3000, 0,  false, nil},
}

local markers = {}

function spawnTable ()
	for i=1, #v do 
		destroyElement (markers[i])
		table.remove(markers, i)
	end 
	for i=1, #theTable do 
		local theMarker
		theMarker = createMarker(theTable[i][1], theTable[i][2], theTable[i][3]-1, "cylinder", 2, 255, 255, 0)
		setElementData(theMarker, "AURbusiness_store.type", theTable[i][4])
		setElementData(theMarker, "AURbusiness_store.earnph", theTable[i][5])
		setElementData(theMarker, "AURbusiness_store.timeleft", theTable[i][6])
		setElementData(theMarker, "AURbusiness_store.sell", theTable[i][7])
		setElementData(theMarker, "AURbusiness_store.restriction", theTable[i][8])
		markers[#markers+1] = theMarker
	end 
end

function getTimeLeft ()
end