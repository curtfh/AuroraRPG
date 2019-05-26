x,y,z,fwp,bl = false,false,false,false,false
function mf(p)
    if not isElement(fwp) and x then destroyElement(bl) fwp,x,y,z,bl = false,false,false,false,false end
     if not x then
        x,y,z = getElementPosition(p)
        fwp = p
        outputChatBox("You have set the position, type in /fireworks again if you want to launch them!", p,0 ,255, 0)
     elseif fwp == p then
        triggerClientEvent("makeFireworks", root, p,x,y,z)
        setTimer(destroyElement,10000,1,bl)
        bl,fwp,x,y,z = false,false,false,false,false
     end
end
addCommandHandler("fireworks", mf)