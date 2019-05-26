text = ""
blip=false
col = {}
addEvent("onShowMoney",true)
addEventHandler("onShowMoney",root,
	function ()
		playSound("sound.ogg")

	end
)

addEvent("addArmorCol",true)
addEventHandler("addArmorCol",root,function(my)
	col = my
end)


addEventHandler( "onClientProjectileCreation", root,
function ( creator )
	if col and isElement(col) then
		if isElementWithinColShape(localPlayer,col) then
			if getElementDimension(localPlayer) == 0 then
				if ( getProjectileType( source ) == 16 ) or ( getProjectileType( source ) == 17 ) or ( getProjectileType( source ) == 18 ) or ( getProjectileType( source ) == 39 ) then

					if ( creator == localPlayer ) then
						-------
					end

					destroyElement( source )
				end
			end
		end
	end
end
)


addEventHandler("onClientExplosion", root,
function(x, y, z, theType)
	if getElementDimension(localPlayer) == 0 then
		if col and isElement(col) then
			if isElementWithinColShape(localPlayer,col) then
				cancelEvent()
			end
		end
	end
end)
