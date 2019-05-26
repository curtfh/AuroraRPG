function addPaintjob(commandName,paintjobID)
	me = getLocalPlayer()
if getElementData(me, "isPlayerVIP") then
if isPedInVehicle ( me ) then
	triggerServerEvent ( "addPJ", resourceRoot, tonumber(paintjobID), me )
	else
	outputChatBox("You need to be VIP to use this command",me,255,255,255)
	end
	
end
end
addCommandHandler ("paintjob",addPaintjob)

function addPaintjob2(paintjobID,player)
if paintjobID == 1 then
	myTexture = dxCreateTexture( "paintjob1.png" )
	elseif paintjobID == 2 then
	myTexture = dxCreateTexture( "paintjob2.png" )
	elseif paintjobID == 3 then
	myTexture = dxCreateTexture( "paintjob3.png" )
	elseif paintjobID == 4 then
	myTexture = dxCreateTexture( "paintjob4.png" )
	elseif paintjobID == 5 then
	myTexture = dxCreateTexture( "paintjob5.png" )
	else
	if player == getLocalPlayer() then
	outputChatBox ("There is no such paintjob ID!")
	return
	end
	end
	engineRemoveShaderFromWorldTexture ( shader_cars, "vehiclegrunge256", getPedOccupiedVehicle(player) )
	shader_cars, tec = dxCreateShader ( "shader.fx" )
	engineApplyShaderToWorldTexture ( shader_cars, "vehiclegrunge256", getPedOccupiedVehicle(player) )
	dxSetShaderValue ( shader_cars, "TX0", myTexture ) 
end
addEvent( "addPJ2", true )
addEventHandler( "addPJ2", getLocalPlayer(), addPaintjob2 )

function removePaintjob2(player)
if 	engineApplyShaderToWorldTexture ( shader_cars, "vehiclegrunge256", getPedOccupiedVehicle(player) ) then
	me = getLocalPlayer()
	engineRemoveShaderFromWorldTexture ( shader_cars, "vehiclegrunge256", getPedOccupiedVehicle(player) )
	removePaintjob2(player)
	end
end
addEvent( "removePJ2", true )
addEventHandler( "removePJ2", getLocalPlayer(), removePaintjob2 )

function removePaintjob()
triggerServerEvent ( "removePJ", resourceRoot, getLocalPlayer() )
end
addCommandHandler ("removepaintjob",removePaintjob)