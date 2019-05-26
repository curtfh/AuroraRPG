--local floorID = 932
local floorID = 704
local offset = 75
local createLOD = true

locations = {
	{ 2882.056, 714.373, 8.569, "7,11"},
}
ground = {}

function generateMap()
	for k, loc in pairs (locations) do
		local x, y, z = loc[1], loc[2], loc[3]
		local eX, eY = x+(offset/2), y+(offset/2)
		local dist = getDistanceBetweenPoints2D( x, y, eX, eY)
		local gridData = split( loc[4], ",")
		local columns = gridData[1]
		local rows = gridData[2]
		for index = 1, columns do
			for sIndex = 1, rows do
				if createLOD then
					local lod = createObject( floorID, (index*offset)+x, (-sIndex*offset)-y, z, 0, 0, 0, true)
				end
				local object = createObject( floorID, (index*offset)+(x), (-sIndex*offset)-y, z, 0, 0, 0, false)
				--createRadarArea( (index*offset)+x, (-sIndex*offset)-y, dist+(offset/3), dist+(offset/3), 25, 25, 25, 175)
				setElementDoubleSided( object, true)
				setElementFrozen( object, true)
				setObjectMass( object, 12000)
				setObjectBreakable( object, false)
				table.insert( ground, {object})
			end
		end
	end
end

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		col_floors = engineLoadCOL ( "floor.col" )
		engineReplaceCOL ( col_floors, floorID )

		txd_floors = engineLoadTXD ( "floor.txd" )
		engineImportTXD ( txd_floors, floorID )

		dff_floors = engineLoadDFF ( "floor.dff", 0 )
		engineReplaceModel ( dff_floors, floorID )

		generateMap()
	end
)
