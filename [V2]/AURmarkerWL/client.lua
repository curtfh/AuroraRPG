local fonts = { [ "default" ] = true, [ "default-bold" ] = true,[ "clear" ] = true,[ "arial" ] = true,[ "sans" ] = true,
	  [ "pricedown" ] = true, [ "bankgothic" ] = true,[ "diploma" ] = true,[ "beckett" ] = true
}
addEvent("dxDraw3DText", true)
function dxDraw3DText( text, x, y, z, scale, font, r, g, b, maxDistance )
	-- checking required arguments
	assert( type( text ) == "string", "Bad argument @ dxDraw3DText" )
	assert( type( x ) == "number", "Bad argument @ dxDraw3DText" )
	assert( type( y ) == "number", "Bad argument @ dxDraw3DText" )
	assert( type( z ) == "number", "Bad argument @ dxDraw3DText" )
	-- checking optional arguments
	if not scale or type( scale ) ~= "number" or scale <= 0 then
		scale = 2
	end
	if not font or type( font ) ~= "string" or not fonts[ font ] then
		font = "default"
	end
	if not r or type( r ) ~= "number" or r < 0 or r > 255 then
		r = 255
	end
	if not g or type( g ) ~= "number" or g < 0 or g > 255 then
		g = 255
	end
	if not b or type( b ) ~= "number" or b < 0 or b > 255 then
		b = 255
	end
	if not maxDistance or type( maxDistance ) ~= "number" or maxDistance <= 1 then
		maxDistance = 12
	end
	local textElement = createElement( "text" )
	-- checking if the element was created
	if textElement then 
		-- setting the element datas
		setElementData( textElement, "text", text )
		setElementData( textElement, "x", x )
		setElementData( textElement, "y", y )
		setElementData( textElement, "z", z )
		setElementData( textElement, "scale", scale )
		setElementData( textElement, "font", font )
		setElementData( textElement, "rgba", { r, g, b, 255 } )
		setElementData( textElement, "maxDistance", maxDistance )
		-- returning the text element
		return textElement
	end
	-- returning false in case of errors
	return false
end
addEventHandler("dxDraw3DText", root, dxDraw3DText)

dxDraw3DText( "Enter for LS Game,get wanted level and kill all cops!", 1874.4189453125, -1381.4033203125, 17.54733180999, 1, "pricedown", 255, 255, 255, 30 )

addEventHandler( "onClientRender", root,
	function( )
		local texts = getElementsByType( "text" )
		if #texts > 0 then
			local pX, pY, pZ = getElementPosition( localPlayer )
			for i = 1, #texts do
				local text = getElementData( texts[i], "text" )
				local tX, tY, tZ = getElementData( texts[i], "x" ), getElementData( texts[i], "y" ), getElementData( texts[i], "z" )
				local font = getElementData( texts[i], "font" )
				local scale = getElementData( texts[i], "scale" )
				local color = getElementData( texts[i], "rgba" )
				local maxDistance = getElementData( texts[i], "maxDistance" )
				if not text or not tX or not tY or not tZ then
					return
				end
				if not font then font = "default" end
				if not scale then scale = 2 end
				if not color or type( color ) ~= "table" then
					color = { 255, 255, 255, 255 }
				end
				if not maxDistance then maxDistance = 12 end
				local distance = getDistanceBetweenPoints3D( pX, pY, pZ, tX, tY, tZ )
				if distance <= maxDistance then
					local x, y = getScreenFromWorldPosition( tX, tY, tZ )
					if x and y then
						dxDrawText( text, x, y, _, _, tocolor( color[1], color[2], color[3], color[4] ), scale, font, "center", "center" )
					end
				end
			end
		end
	end
)

