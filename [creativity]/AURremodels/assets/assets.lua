local location = "assets/models/"
allIDs = {}

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		for name, category in pairs ( objectTable) do
			for i, object in pairs ( category) do
				local id = object[1]
				local model = object[4][1]
				local txd = object[4][2]
				--outputDebugString( "Loaded Custom Model '"..model.."' with Texture '"..txd.."' on ID:"..id)
				table.insert( allIDs, {id})

				collision = engineLoadCOL( location..model..".col")
				engineReplaceCOL( collision, id)

				texture = engineLoadTXD( location..txd..".txd")
				engineImportTXD( texture, id)

				model = engineLoadDFF( location..model..".dff", 0)
				engineReplaceModel( model, id)
			end
		end
	end
)
