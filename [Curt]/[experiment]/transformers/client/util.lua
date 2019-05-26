addEvent('onClientCall', true)
addEventHandler('onClientCall', root,
	function(fnName, ...)
		if _G[fnName] then
			_G[fnName](...)
		end
	end
)

local _blowVehicle = blowVehicle
function blowVehicle(vehicle)
	_blowVehicle(vehicle)
	local x, y, z = getElementPosition(vehicle)
	createExplosion(x, y, z, 2)
end

function nextFrame(fn, ...)
	local args = { ... }
	local function handler()
		fn(unpack(args))
		removeEventHandler('onClientRender', root, handler)
	end
	addEventHandler('onClientRender', root,	handler)
end

function setPedDucked(ped, toggle)
	if isPedDucked(ped) == toggle then
		return
	end
	setPedControlState(ped, 'crouch', true)
	nextFrame(setPedControlState, ped, 'crouch', false)
end