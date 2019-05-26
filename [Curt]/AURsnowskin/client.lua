addEventHandler ( "onClientResourceStart", getResourceRootElement ( getThisResource() ),
	function ()
		txd = engineLoadTXD ( "snegovik.txd" )
		engineImportTXD ( txd, 310 )
		dff = engineLoadDFF ( "snegovik.dff" )
		engineReplaceModel ( dff, 310 )
	end
)