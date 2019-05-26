addEvent("makeFireworks", true)
targets = { }
function createFireworks(element,x,y,z)
    math.randomseed(getTickCount()+x+y+z)
    for i=1,20 do
        targets[i] = createObject(1212,x+math.random(-50,50),y+math.random(-50,50),z+50)
        setTimer(setElementAlpha,100,1,targets[i],0)
        setTimer(destroyElement,40000,1,targets[i])
        setTimer(moveObject,4000,1,targets[i],5000,x+math.random(-50,50),y+math.random(-50,50),z+50,0,0,0,"SineCurve")
    end
    
     setTimer(function()
        for i=1,20 do
            setTimer(createProjectile,175*i,1,element,20,x,y,z+0.5,1.0,targets[i],90,0,0,0,0,0.001,2780)
        end
        end,1000,2)
        
end
addEventHandler("makeFireworks", root, createFireworks)