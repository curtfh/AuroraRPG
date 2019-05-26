-- Copyright (c) 2017, Alberto Alonso
--
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without modification,
-- are permitted provided that the following conditions are met:
--
--     * Redistributions of source code must retain the above copyright notice, this
--       list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above copyright notice, this
--       list of conditions and the following disclaimer in the documentation and/or other
--       materials provided with the distribution.
--     * Neither the name of the superman script nor the names of its contributors may be used
--       to endorse or promote products derived from this software without specific prior
--       written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
-- CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
-- EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
-- PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
-- LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
-- NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
local Superman = {}

-- Static global values
local rootElement = getRootElement()
local thisResource = getThisResource()

-- Resource events
addEvent("supermaneve:start", true)
addEvent("supermaneve:stop", true)

--
-- Start/stop functions
--
function Superman.Start()
  local self = Superman

  addEventHandler("supermaneve:start", rootElement, self.clientStart)
  addEventHandler("supermaneve:stop", rootElement, self.clientStop)
  addEventHandler("onPlayerVehicleEnter",rootElement,self.enterVehicle)
end
addEventHandler("onResourceStart", getResourceRootElement(thisResource), Superman.Start, false)

function Superman.clientStart()
  setElementData(client, "supermaneve:flying", true)
end

function Superman.clientStop()
  setElementData(client, "supermaneve:flying", false)
end

-- Fix the notorious "Airkill" bug (would happen when you 'aim' the victim with knife when you get a chance first, like before they jump up, keep yourself in the 'slash' anim, then use /superman bind
-- and complete the stealthkill action with left mouse button. This will result in victim just having their head sliced off while standing (or flying) in the air using superman.
-- The action of 'targetting'/'aiming' them first, can also be done while they are in the air, assisted by lag (switch) that allows the green/color HP tag above their head to appear quickly enough to target.
-- So the glitcher wouldn't always need to first stalk their victim around in order to abusively kill them.
function cancelAirkill()
    if getElementData(source,"supermaneve:flying") or getElementData(source,"supermaneve:takingOff") then
        cancelEvent()
    end
end
addEventHandler("onPlayerStealthKill", getRootElement(),cancelAirkill)

-- Fix for players glitching other players' vehicles by warping into them while superman is active, causing them to flinch into air and get stuck.
function Superman.enterVehicle()
	if getElementData(source,"supermaneve:flying") or getElementData(source,"supermaneve:takingOff") then
		removePedFromVehicle(source)
		local x,y,z = getElementPosition(source)
		setElementPosition(source,x,y,z)
	end
end