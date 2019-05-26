--local matrix = "83.194,-44.808,-2.874,25.799,-99.930,-63.433"
local matrix = "62.860,-49.628,-19.551,32.358,-131.514,-68.176"
local objPos = "48.538,-66.619,-30.218,-1.930,5.026,-78.385"
viewing = false

prevID = 2673
prevTXD = "brick_wall"
prevObject = false

function toggleElementManager( state)
	if state then
		viewing = true
	else
		viewing = false
	end
end


addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		if not viewing then return end
		local objData = split( objPos, ",")
		local oX, oY, oZ = objData[1], objData[2], objData[3]
		local matrixData = split( matrix, ",")
		local x, y, z, lx, ly, lz = matrixData[1], matrixData[2], matrixData[3], matrixData[4], matrixData[5], matrixData[6]
		setCameraMatrix( x, y, z, lx, ly, lz)
		prevObject = createObject( prevID, oX, oY, oZ)
		setElementDoubleSided( prevObject, true)
		applyCustomTexture( prevObject, prevTXD)
	end
)

addEventHandler( "onClientPreRender", root,
	function()
		if not viewing then return end
		if isElement( prevObject) then
			local rotX, rotY, rotZ = getElementRotation( prevObject)
			local model = getElementModel( prevObject)
			setElementRotation( prevObject, 0, 90, rotZ+0.25, "default")
		end
	end
)
