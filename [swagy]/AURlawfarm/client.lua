local elems = {}
local elemsByDist = {}

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

local dx,dy = guiGetScreenSize() 
 aimX ,aimY = dx*0.54 , dy*0.3971 

function aimbot ()

	if not (getElementData(localPlayer, "aimbot_on")) then return false end
	if getPedTask(localPlayer, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
		if not (isElement(elemsByDist[elems[1]])) then return false end
		local setToX,setToY = 0,0 
    	local hx, hy, hz = getPedBonePosition(elemsByDist[elems[1]], 8) 
   		 local sx,sy = getScreenFromWorldPosition(hx,hy,hz) 
     
     	setToX = math.abs(dx/2-(aimX)) 
     	setToY = math.abs(dy/2-aimY) 
      
     	local a1,a2,a3 = getPedBonePosition(elemsByDist[elems[1]], 8) 
     	local a4,a5,a6 = getElementPosition(elemsByDist[elems[1]]) 
     	local b1,b2,b3 = getElementPosition(localPlayer) 
     	local dist = getDistanceBetweenPoints3D(a1,a2,a3,b1,b2,b3) 
     	setToX,setToY  = getWorldFromScreenPosition(sx-setToX,sy+setToY,dist) 
     	_,_,setToX1 = getWorldFromScreenPosition(dx/2,dy/2,dist/2) 
     	_,_,setToX2 = getWorldFromScreenPosition(aimX,aimY,dist/2) 
     	setToX3 = (setToX2 - setToX1)  
		setCameraTarget(setToX,setToY,b3-setToX3+0.2 +(a6-b3))
	end
end
addEventHandler("onClientRender", root, aimbot)

function getNearestElement ()

	--if not (getElementData(localPlayer, "aimbot_on")) then return false end
	local plrs = getElementsByType"player"
	table.remove(plrs,1)
	for k,v in ipairs (plrs) do
		--if (v == localPlayer) then return false end
		local x,y,z = getElementPosition(localPlayer)
		local ex, ey, ez = getElementPosition(v)
		local distance = getDistanceBetweenPoints2D(x,y, ex, ey)
		--if (distance > 1200) then return false end
		elemsByDist[distance] = v
		table.insert(elems, distance)
		table.sort(elems)
	end
end
bindKey("mouse2", "down", getNearestElement)

