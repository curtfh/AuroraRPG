addEventHandler ( "onClientResourceStart" , resourceRoot ,
	function ( )
		shader , technique = dxCreateShader ( "repshader.fx" )
		if shader and technique then
			mTexture = dxCreateTexture ( "moon.png" )
			dxSetShaderValue ( shader , "CustomMoon" , mTexture )
			engineApplyShaderToWorldTexture ( shader , "coronamoon" )
		end
	end
)