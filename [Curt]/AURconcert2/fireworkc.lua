---------------------
-- Fireworks Truck -- -- Makes a truck that launches Fireworks :D
--------- by --------
------- KWKSND ------ -- Makes Multi Theft Auto more fun :D
---------------------

-- settings --
	number = 300 -- number of fireworks to launch (default = 150)
	height = 1.5 -- this is the velocity of the shell when launched (default = 1.8)
	randomness = 0.20 -- how far off vertical the fireworks can launch (default = 0.30)
	maxsize = 25 -- (default = 25) acual size of marker would be maxsize * 5 
-- settings ^^

rocket1 = createObject(3790,552.39044, -1844.40198, 5.23749)
rocket2 = createObject(3790,586.62476, -1845.64758, 5.4270)
rocket3 = createObject(3790,569.55695, -1841.80493, 5.22498)
rocket4 = createObject(3790,578.78687, -1841.70349, 5.43255)
rocket5 = createObject(3790,560.06189, -1841.40784, 5.2755)

rocket6 = createObject(3790,595.77832, -1864.11743, 4.7845)
rocket7 = createObject(3790,634.03088, -1888.38269, 3.85701)
rocket8 = createObject(3790,625.60706, -1913.41235, 1.61732)
rocket9 = createObject(3790,541.56476, -1906.77087, 1.16409)
rocket10 = createObject(3790,541.81946, -1871.05371, 4.06307)

rocket11 = createObject(3790,526.87378, -1927.09546, 2.34531)
rocket12 = createObject(3790,610.48254, -1927.46167, 2.34531)
rocket13 = createObject(3790,527.00500, -1945.12817, 2.34531)
rocket14 = createObject(3790,610.19055, -1945.59399, 2.34531)
rocket15 = createObject(3790,526.78748, -1963.24011, 2.34531)
rocket16 = createObject(3790,611.01678, -1963.14612, 2.34531)
rocket17 = createObject(3790,527.00140, -1981.22937, 2.34531)
rocket18 = createObject(3790,610.08118, -1980.99414, 2.3453)
rocket19 = createObject(3790,528.15509, -1998.76025, 2.34531)
rocket20 = createObject(3790,608.49518, -1998.98230, 2.34531)
rocket21 = createObject(3790,568.79846, -2000.96704, 7.69805)

resetdelay = number * 200
inuse = 0
function CreateFireworks()
	if inuse == 0 then
		inuse = 1
		step = 0
		setTimer (function()
			delay = math.random(350,750)
			setTimer (function()
				if step > 21 then
					step = 0
				end
				step = step + 1
				if step == 1 then
					rkt = rocket1
				elseif step == 2 then
					rkt = rocket2
				elseif step == 3 then
					rkt = rocket3
				elseif step == 4 then
					rkt = rocket4
				elseif step == 5 then
					rkt = rocket5
				elseif step == 6 then
					rkt = rocket6
				elseif step == 7 then
					rkt = rocket7
				elseif step == 8 then
					rkt = rocket8
				elseif step == 9 then
					rkt = rocket9
				elseif step == 10 then
					rkt = rocket10
				elseif step == 11 then
					rkt = rocket11
				elseif step == 12 then
					rkt = rocket12
				elseif step == 13 then
					rkt = rocket13
				elseif step == 14 then
					rkt = rocket14
				elseif step == 15 then
					rkt = rocket15
				elseif step == 16 then
					rkt = rocket16
				elseif step == 17 then
					rkt = rocket17
				elseif step == 18 then
					rkt = rocket18
				elseif step == 19 then
					rkt = rocket19
				elseif step == 20 then
					rkt = rocket20
				elseif step == 21 then
					rkt = rocket21
				end
				setElementAlpha(rkt,0)
				setTimer (function(rkta)
					setElementAlpha(rkta,255)
				end,2000,1,rkt)
				local fx,fy,fz = getElementPosition(rkt)
				fz = fz + 1.5
				local shell = createVehicle (594,fx,fy,fz)
				if isElement(shell) then
					setElementAlpha(shell,0)
					local rocket = createObject(3790,0,0,0)
					attachElements(rocket,shell,0,0,1,0,90,0)
					setObjectScale ( rocket, 0.4)
					local flair = createMarker (fx,fy,fz,"corona",1,255, 255, 255, 255)
					attachElements(flair,shell)
					local smoke = createObject(2780,0,0,0)
					setElementCollidableWith (smoke,shell,false)
					setElementAlpha(smoke,0)
					attachElements (smoke,shell)
					local sound = playSound3D("sfx/Bottle_Rocket.mp3",0,0,0,false)
					attachElements ( sound, shell)
					setSoundMaxDistance(sound, 100)
					setSoundMinDistance(sound, 10)
					setSoundVolume(sound,0.5)
					setSoundSpeed (sound,math.random(1,2))
					setTimer (setElementVelocity , 50, math.random(1,3), shell, math.random(-1,1)*randomness, math.random(-1,1)*randomness,height)
					setTimer (function(shell,flair,smoke,rocket)
						local ex,ey,ez = getElementPosition(shell)
						createExplosion(ex,ey,ez,11)
						setMarkerColor(flair,math.random(0,255),math.random(0,255),math.random(0,255),255)
						sizetime=math.random(7,maxsize)
						setTimer (function(shell,flair,smoke,rocket)
							if isElement(flair)then
								local size = getMarkerSize(flair)
								setMarkerSize(flair,size+2)
							end
							setTimer (function(shella,flaira,smokea,rocketa)
								if isElement(flaira)then
									destroyElement(flaira)
								end
								if isElement(shella) then
									destroyElement(shella)
								end
								if isElement(smokea) then
									destroyElement(smokea)
								end
								if isElement(rocketa) then
									destroyElement(rocketa)
								end
							end,sizetime*100,1,shell,flair,smoke,rocket)
						end,100,sizetime,shell,flair,smoke,rocket)
					end,1400,1,shell,flair,smoke,rocket)
				end
			end,delay,1)
		end,200,number)
		setTimer (function()
			inuse = 0
		end,resetdelay,1)
	end
end
addEvent("ClientCreateFireworks",true)
addEventHandler( "ClientCreateFireworks", getRootElement (), CreateFireworks)
