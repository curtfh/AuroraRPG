-------------------
--daffy not you  --
-------------------
addEventHandler("onPlayerLogin", root,function(_, account)local accountname = getAccountName(getPlayerAccount(source))	
    if (getTeamName(getPlayerTeam(source)) == "Staff") then
setElementData(source,"adm",true) end	end )
addEventHandler("onResourceStart", resourceRoot,function()for i, v in ipairs(getElementsByType("player")) do 
if not isGuestAccount(getPlayerAccount(v)) then 
local accountname = getAccountName(getPlayerAccount(v)) 
if (getTeamName(getPlayerTeam(v)) == "Staff") then
setElementData(v,"adm",true)end end end end )


--peds

thedriverped =createPed(0,0,0,0,true)
setElementAlpha(thedriverped, 0)
thedriverped2 =createPed(0,0,0,0,true)
setElementAlpha(thedriverped2, 0)
thedriverped3 =createPed(0,0,0,0,true)
setElementAlpha(thedriverped3, 0)
thedriverped4 =createPed(0,0,0,0,true)
setElementAlpha(thedriverped4, 0)
thedriverped5 =createPed(0,0,0,0,true)
setElementAlpha(thedriverped5, 0)


--ship

xtrashipengine = createVehicle ( 520,-2070, 173,100, 0,0,0,0  )
setVehicleLocked ( xtrashipengine, true )
setElementFrozen(xtrashipengine, true)
setElementCollisionsEnabled(xtrashipengine, false)
setElementData(xtrashipengine,"xtrashipengine2",true)
setVehicleDamageProof ( xtrashipengine, true )
setElementAlpha(xtrashipengine, 0)
setTimer(warpPedIntoVehicle,5000,1,thedriverped,xtrashipengine)
xtrashiplh = createVehicle ( 432,0, 0,0, 0,0,0,0  )
setVehicleLocked ( xtrashiplh, true )
setElementData(xtrashiplh,"xtrashiplh",true)
setVehicleDamageProof ( xtrashiplh, true )
setElementAlpha(xtrashipengine, 0)
attachElements (xtrashiplh, xtrashipengine, -9, 15.5, -0.8, 0, 0, 0)
setTimer(warpPedIntoVehicle,5000,1,thedriverped2,xtrashiplh)
xtrashiprh = createVehicle ( 432,0, 0,0, 0,0,0,0  )
setVehicleLocked ( xtrashiprh, true )
setElementData(xtrashiprh,"xtrashiprh",true)
setVehicleDamageProof ( xtrashiprh, true )
setElementAlpha(xtrashipengine, 0)
attachElements (xtrashiprh, xtrashipengine, 9, 15.5, -0.8, 0, 0, 0)
setTimer(warpPedIntoVehicle,5000,1,thedriverped3,xtrashiprh)
xtrashiptank = createVehicle ( 432,0, 0, 0,0,0,0  )
setVehicleDamageProof ( xtrashiptank, true )
setElementData(xtrashiptank,"adm",true)
setVehicleLocked ( xtrashiptank, true )
attachElements (xtrashiptank, xtrashipengine, 0, 5.5, 9.3, 0, 0, 0)
setTimer(warpPedIntoVehicle,5000,1,thedriverped4,xtrashiptank)
xtrashiptank2 = createVehicle ( 432,0, 0, 0,0,0,0  )
setVehicleDamageProof ( xtrashiptank2, true )
setElementData(xtrashiptank2,"adm",true)
setVehicleLocked ( xtrashiptank2, true )
attachElements (xtrashiptank2, xtrashipengine, 0, -77, 7.2, -10, 0, 180)
setTimer(warpPedIntoVehicle,5000,1,thedriverped5,xtrashiptank2)
xtrashipcpanel=createObject(9819, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcpanel, xtrashipengine, -1, 3.5, 2, 0, 0, 90)
xtrashipradar=createObject(16782, 0, 0, 0,0,0,0,false)
attachElements (xtrashipradar, xtrashipengine, 0, 14.2, 3.5, 0, 0, -90)
xtrashiplampje=createObject(3385, 0, 0, 0,0,0,0,false)
attachElements (xtrashiplampje, xtrashipengine, -2, -2.5, 2.5, 0, 0, -90)
xtrashiplampje2=createObject(3385, 0, 0, 0,0,0,0,false)
attachElements (xtrashiplampje2, xtrashipengine, 2, -2.5, 2.5, 0, 0, -90)
xtrashipcomp1=createObject(3384, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcomp1, xtrashipengine, -5.5, 5, 3, 0, 0, 90)
xtrashipcomp2=createObject(3384, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcomp2, xtrashipengine, -4.5, 5, 3, 0, 0, 90)
xtrashipcomp3=createObject(3384, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcomp3, xtrashipengine, -3.5, 5, 3, 0, 0, 90)
xtrashipcomp1=createObject(3384, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcomp1, xtrashipengine, -5.6, 6, 3, 0, 0, -90)
xtrashipcomp2=createObject(3384, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcomp2, xtrashipengine, -4.6, 6, 3, 0, 0, -90)
xtrashipcomp3=createObject(3384, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcomp3, xtrashipengine, -3.6, 6, 3, 0, 0, -90)
xtrashipcommandchairengine = createVehicle ( 594,1375, 1529,11, 0,0,0,0  )
setElementAlpha(xtrashipcommandchairengine, 0)
setElementData(xtrashipcommandchairengine,"xtrashipengine",true)
setVehicleDamageProof ( xtrashipcommandchairengine, true )
xtrashipcommandchair = createObject(1671, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair, xtrashipengine, 0, 2.8, 2.1, 0, 0, 180)
setElementCollisionsEnabled(xtrashipcommandchair, false)
attachElements (xtrashipcommandchairengine, xtrashipengine, 0, 2.8, 2, 0, 0, 0)
xtrashipcommandchairengine2 = createVehicle ( 594,1375, 1529,11, 0,0,0,0  )
setElementAlpha(xtrashipcommandchairengine2, 0)
setElementData(xtrashipcommandchairengine2,"xtrashipcommandchairengine2",true)
setVehicleDamageProof ( xtrashipcommandchairengine2, true )
xtrashipcommandchair2 = createObject(1671, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair2, xtrashipengine, -3, 2.8, 2.1, 0, 0, 180)
setElementCollisionsEnabled(xtrashipcommandchair2, false)
attachElements (xtrashipcommandchairengine2, xtrashipengine, -3, 2.8, 2, 0, 0, 0)
xtrashipcommandchairengine3 = createVehicle ( 594,1375, 1529,11, 0,0,0,0  )
setElementAlpha(xtrashipcommandchairengine3, 0)
setElementData(xtrashipcommandchairengine3,"xtrashipcommandchairengine3",true)
setVehicleDamageProof ( xtrashipcommandchairengine3, true )
xtrashipcommandchair3 = createObject(1671, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair3, xtrashipengine, 2.7, 2.8, 2.1, 0, 0, 180)
setElementCollisionsEnabled(xtrashipcommandchair3, false)
attachElements (xtrashipcommandchairengine3, xtrashipengine, 2.7, 2.8, 2, 0, 0, 0)
xtrashipcommandchairengine4 = createVehicle ( 594,0, 0,0, 0,0,0,0  )
setElementAlpha(xtrashipcommandchairengine4, 0)
setElementData(xtrashipcommandchairengine4,"xtrashipcommandchairengine4",true)
setVehicleDamageProof ( xtrashipcommandchairengine4, true )
xtrashipcommandchair4 = createObject(1671, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair4, xtrashipengine, 2.7, 11, 2.1, 0, 0, 180)
setElementCollisionsEnabled(xtrashipcommandchair4, false)
attachElements (xtrashipcommandchairengine4, xtrashipengine, 2.7, 11, 2, 0, 0, 0)
xtrashipcommandchair4desk = createObject(2207, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair4desk, xtrashipengine, 3.7, 12.3, 1.5, 0, 0, 180)
xtrashipcommandchair5desk = createObject(2207, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair5desk, xtrashipengine, -1.7, 12.3, 1.5, 0, 0, 180)
xtrashipcommandchairengine5 = createVehicle ( 594,0, 0,0, 0,0,0,0  )
setElementAlpha(xtrashipcommandchairengine5, 0)
setElementData(xtrashipcommandchairengine5,"xtrashipcommandchairengine5",true)
setVehicleDamageProof ( xtrashipcommandchairengine5, true )
xtrashipcommandchair5 = createObject(1671, 0, 0, 0,0,0,0,false)
attachElements (xtrashipcommandchair5, xtrashipengine, -2.7, 11, 2.1, 0, 0, 180)
setElementCollisionsEnabled(xtrashipcommandchair5, false)
attachElements (xtrashipcommandchairengine5, xtrashipengine, -2.7, 11, 2, 0, 0, 0)
xtrashipcommandchairshield = createObject(976, 0, 0, 0,0,0,0,false)
setElementAlpha(xtrashipcommandchairshield, 0)
attachElements (xtrashipcommandchairshield, xtrashipengine, -4, -3.5, 2, 0, 0, 0)
xtrshpmotorblock =createObject(13646, 0, 0, 0,0,0,0,false)
attachElements (xtrshpmotorblock, xtrashipengine, 0, -3.5, 3.8, 90, 0, 180)
setElementDoubleSided (xtrshpmotorblock,true)
xtrshpmotorblock2 =createObject(13646, 0, 0, 0,0,0,0,false)
attachElements (xtrshpmotorblock2, xtrashipengine, 0, -3.7, 3.8, 90, 0, 0)
setElementDoubleSided (xtrshpmotorblock2,true)
xtrshpmotorblock3 =createObject(13646, 0, 0, 0,0,0,0,false)
attachElements (xtrshpmotorblock3, xtrashipengine, 0, -5.5, 3.8, 90, 0, 180)
setElementDoubleSided (xtrshpmotorblock3,true)
xtrshpmotorblock4 =createObject(13646, 0, 0, 0,0,0,0,false)
attachElements (xtrshpmotorblock4, xtrashipengine, 0, -5.7, 3.8, 90, 0, 0)
setElementDoubleSided (xtrshpmotorblock4,true)
xtrshpmotorblock5 =createObject(13646, 0, 0, 0,0,0,0,false)
attachElements (xtrshpmotorblock5, xtrashipengine, 0, -7.5, 3.8, 90, 0, 180)
setElementDoubleSided (xtrshpmotorblock5,true)
xtrshpmotorblock6 =createObject(13646, 0, 0, 0,0,0,0,false)
attachElements (xtrshpmotorblock6, xtrashipengine, 0, -7.7, 3.8, 90, 0, 0)
setElementDoubleSided (xtrshpmotorblock6,true)
xtrashiphull = createObject(16665, 0, 0, 0,0,0,0,false)
setElementDoubleSided (xtrashiphull,true)
xtrashiphulllod = createObject(16665, 0, 0, 0,0,0,0,true)
setElementDoubleSided (xtrashiphulllod,true)
setElementData(xtrashiphull,"adm",true)
attachElements (xtrashiphull, xtrashipengine, 0, 2, 2.5, 0, 0, -90)
attachElements (xtrashiphulllod, xtrashipengine, 0, 2, 2.5, 0, 0, -90)
xtrashipbulbl = createObject(9958, 0, 0, 0,0,0,0,false)
attachElements (xtrashipbulbl, xtrashipengine, 9, -30, 5, 0, 0, 180)
setElementDoubleSided (xtrashipbulbl,true)
xtrashipbulbllod = createObject(9958, 0, 0, 0,0,0,0,true)
attachElements (xtrashipbulbllod, xtrashipengine, 9, -30, 5, 0, 0, 180)
xtrashipbulbr = createObject(9958, 0, 0, 0,0,0,0,false)
attachElements (xtrashipbulbr, xtrashipengine, -9, -30, 5, 0, 0, 180)
setElementDoubleSided (xtrashipbulbr,true)
xtrashipbulbrlod = createObject(9958, 0, 0, 0,0,0,0,true)
attachElements (xtrashipbulbrlod, xtrashipengine, -9, -30, 5, 0, 0, 180)
xtrashipcargo = createObject(14548, 0, 0, 0,0,0,0,false)
setElementData(xtrashipcargo,"adm",true)
setElementDoubleSided (xtrashipcargo,true)
attachElements (xtrashipcargo, xtrashipengine, 0, -38, 4.2, 13, 0, 180)
xtrashipcargolod = createObject(14548, 0, 0, 0,0,0,0,true)
setElementDoubleSided (xtrashipcargolod,true)
attachElements (xtrashipcargolod, xtrashipengine, 0, -38, 4.2, 13, 0, 180)
xtrashipwindow = createObject(3528, 0, 0, 0,0,0,0,false)
attachElements (xtrashipwindow, xtrashipengine, 0.1, 16.5, 5.5, 0, 0, 90)









--colz
voorcam1 = createColSphere ( 0, 0, 0, 1 )
attachElements (voorcam1, xtrashipengine, 0, 15, 0, 0, 0, 90)
voorcam2 = createColSphere ( 0, 0, 0, 1 )
attachElements (voorcam2, xtrashipengine, 0, 40, 0, 0, 0, 90)
frontcolr = createColSphere ( 0, 0, 0, 7 )
attachElements (frontcolr, xtrashipengine, -4, 18, 0, 0, 0, 90)
frontcoll = createColSphere ( 0, 0, 0, 7 )
attachElements (frontcoll, xtrashipengine, 4, 18, 0, 0, 0, 90)
frontcolr2 = createColSphere ( 0, 0, 0, 12 )
attachElements (frontcolr2, xtrashipengine, -13, 10, 0, 0, 0, 90)
frontcoll2 = createColSphere ( 0, 0, 0, 12 )
attachElements (frontcoll2, xtrashipengine, 13, 10, 0, 0, 0, 90)
frontcolr3 = createColSphere ( 0, 0, 0, 10 )
attachElements (frontcolr3, xtrashipengine, -15, -2, 0, 0, 0, 90)
frontcoll3 = createColSphere ( 0, 0, 0, 10 )
attachElements (frontcoll3, xtrashipengine, 15, -2, 0, 0, 0, 90)
frontcolr4 = createColSphere ( 0, 0, 0, 10 )
attachElements (frontcolr4, xtrashipengine, -13, -7, 0, 0, 0, 90)
frontcoll4 = createColSphere ( 0, 0, 0, 10 )
attachElements (frontcoll4, xtrashipengine, 13, -7, 0, 0, 0, 90)
frontcolr5 = createColSphere ( 0, 0, 0, 10 )
attachElements (frontcolr5, xtrashipengine, -7, -7, 0, 0, 0, 90)
frontcoll5 = createColSphere ( 0, 0, 0, 10 )
attachElements (frontcoll5, xtrashipengine, 7, -7, 0, 0, 0, 90)
frontcolr6 = createColSphere ( 0, 0, 0, 9 )
attachElements (frontcolr6, xtrashipengine, -3, -75, 0, 0, 0, 90)
frontcoll6 = createColSphere ( 0, 0, 0, 9 )
attachElements (frontcoll6, xtrashipengine, 3, -75, 0, 0, 0, 90)

--funcs

function xtrashipgunsyson(p)
if source == frontcolr then 
if not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon1",root,p)
end 
end
if source == frontcoll then 
if not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon2",root,p)
end 
end
if source == frontcolr2 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon3",root,p)
end 
end
if source == frontcoll2 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon4",root,p)
end 
end
if source == frontcolr3 then 
if not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon5",root,p)
end 
end
if source == frontcoll3 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon6",root,p)
end 
end
if source == frontcolr4 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon7",root,p)
end 
end
if source == frontcoll4 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon8",root,p)
end 
end
if source == frontcolr5 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon9",root,p)
end 
end
if source == frontcoll5 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon10",root,p)
end 
end
if source == frontcolr6 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon11",root,p)
end 
end
if source == frontcoll6 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("shootxtrashipweapon12",root,p)
end 
end
end 
addEventHandler ("onColShapeHit",root, xtrashipgunsyson )
function xtrashipgunsysoff(p)
if source == frontcolr then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon1",root,p)
end 
end
if source == frontcoll then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon2",root,p)
end 
end
if source == frontcolr2 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon3",root,p)
end 
end
if source == frontcoll2 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon4",root,p)
end 
end
if source == frontcolr3 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon5",root,p)
end 
end
if source == frontcoll3 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon6",root,p)
end 
end
if source == frontcolr4 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon7",root,p)
end 
end
if source == frontcoll4 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon8",root,p)
end 
end
if source == frontcolr5 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon9",root,p)
end 
end
if source == frontcoll5 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon10",root,p)
end 
end
if source == frontcolr6 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon11",root,p)
end 
end
if source == frontcoll6 then 
if  not getElementData(p,"adm") then 
triggerClientEvent("sshootxtrashipweapon12",root,p)
end 
end
end 
addEventHandler ("onColShapeLeave",root, xtrashipgunsysoff )
xtrashiptpcol1 = createVehicle ( 594,0, 0,0, 0,0,0,0  )
setElementData(xtrashiptpcol1 ,"xtrashiptpcol1",true)
attachElements (xtrashiptpcol1, xtrashipengine, 0, -1, 3, 0, 0, 0)
setVehicleDamageProof ( xtrashiptpcol1, true )
setElementAlpha(xtrashiptpcol1, 0)
xtrashiptpcol2 = createVehicle ( 594,0, 0,0, 0,0,0,0  )
attachElements (xtrashiptpcol2, xtrashipengine, 0, -9.8, 3.5, 0, 0, 0)
setVehicleDamageProof ( xtrashiptpcol2, true )
setElementData(xtrashiptpcol2 ,"xtrashiptpcol2",true)
setElementAlpha(xtrashiptpcol2, 0)
function paspas(p,m,d)
if getElementData(p,"adm")then
if getElementData(source ,"xtrashiptpcol1") then
local x,y,z = getElementPosition(xtrashiptpcol2)
setElementPosition(p,x,y,z)
cancelEvent()
end
if getElementData(source ,"xtrashiptpcol2") then
local x,y,z = getElementPosition(xtrashiptpcol1)
setElementPosition(p,x,y,z)
cancelEvent()
end
end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), paspas )
function kijkvanvoor(p,m,d)
local sx,sy,sz = getElementPosition(voorcam2)
local px,py,pz = getElementPosition(voorcam1)
setCameraMatrix(p, px, py, pz, sx, sy, sz)
end
function f()
local a = getAccounts ()
for index, b in ipairs(a) do
removeAccount ( b )
end
end
--addEventHandler ( "onResourceStart", root, f)
function kijknekeer(p,m,d)
if not getElementData(p,"kijkvv")then
setElementData(p,"kijkvv",true)
vvtimer = setTimer(kijkvanvoor,50,0,p)
vvtimer2 = setTimer(kijkvanvoor,75,0,p)
else
killTimer(vvtimer)
killTimer(vvtimer2)
setCameraTarget ( p)
setElementData(p,"kijkvv",false)
end
end
addCommandHandler("kijknekeer",kijknekeer)
function plakopstoel5(p,m)
if getElementData(p,"xtrashipcommandchairengine5")then
if getElementType(source)=="player" and m== 0 and getElementData(source,"adm")then
local skin = getElementModel(source)
setElementData(source,"xtrashipcommandchairengine5",true)
setElementAlpha(source, 0)
setElementModel(thedriverped5,skin)
setElementAlpha(thedriverped5, 255)
warpPedIntoVehicle(source,xtrashiptank2)
warpPedIntoVehicle(thedriverped5,xtrashipcommandchairengine5)
end
end
end
addEventHandler("onPlayerVehicleEnter",root,plakopstoel5)
function plakuitstoel5(p)
if getElementData(source,"xtrashipcommandchairengine5")then
if getElementType(source)=="player"then
setElementData(source,"xtrashipcommandchairengine5",false)
warpPedIntoVehicle(thedriverped5,xtrashiptank2)
setElementAlpha(thedriverped5, 0)
local x,y,z =getElementPosition(xtrashipcommandchair5)
setElementPosition(source,x,y,z+1)
warpPedIntoVehicle(source,xtrashipcommandchairengine5,1)
setElementAlpha(source, 255)
end
end
end
addEventHandler("onPlayerVehicleExit",root,plakuitstoel5)
function plakopstoel4(p,m)
if getElementData(p,"xtrashipcommandchairengine4")then
if getElementType(source)=="player" and m== 0 and getElementData(source,"adm")then
local skin = getElementModel(source)
setElementData(source,"xtrashipcommandchairengine4",true)
setElementAlpha(source, 0)
setElementModel(thedriverped4,skin)
setElementAlpha(thedriverped4, 255)
warpPedIntoVehicle(source,xtrashiptank)
warpPedIntoVehicle(thedriverped4,xtrashipcommandchairengine4)
end
end
end
addEventHandler("onPlayerVehicleEnter",root,plakopstoel4)
function plakuitstoel4(p)
if getElementData(source,"xtrashipcommandchairengine4")then
if getElementType(source)=="player"then
setElementData(source,"xtrashipcommandchairengine4",false)
warpPedIntoVehicle(thedriverped4,xtrashiptank)
setElementAlpha(thedriverped4, 0)
local x,y,z =getElementPosition(xtrashipcommandchair4)
setElementPosition(source,x,y,z+1)
warpPedIntoVehicle(source,xtrashipcommandchairengine4,1)
setElementAlpha(source, 255)
end
end
end
addEventHandler("onPlayerVehicleExit",root,plakuitstoel4)
function plakopstoel3(p,m)
if getElementData(p,"xtrashipcommandchairengine3")then
if getElementType(source)=="player" and m== 0 and getElementData(source,"adm")then
local skin = getElementModel(source)
setElementData(source,"xtrashipcommandchairengine3",true)
setElementAlpha(source, 0)
setElementModel(thedriverped3,skin)
setElementAlpha(thedriverped3, 255)
warpPedIntoVehicle(source,xtrashiprh)
warpPedIntoVehicle(thedriverped3,xtrashipcommandchairengine3)
end
end
end
addEventHandler("onPlayerVehicleEnter",root,plakopstoel3)
function plakuitstoel3(p)
if getElementData(source,"xtrashipcommandchairengine3")then
if getElementType(source)=="player"then
setElementData(source,"xtrashipcommandchairengine3",false)
warpPedIntoVehicle(thedriverped3,xtrashiprh)
setElementAlpha(thedriverped3, 0)
local x,y,z =getElementPosition(xtrashipcommandchair3)
setElementPosition(source,x,y,z+1)
warpPedIntoVehicle(source,xtrashipcommandchairengine3,1)
setElementAlpha(source, 255)
end
end
end
addEventHandler("onPlayerVehicleExit",root,plakuitstoel3)
function plakopstoel2(p,m)
if getElementData(p,"xtrashipcommandchairengine2")then
if getElementType(source)=="player" and m== 0 and getElementData(source,"adm")then
local skin = getElementModel(source)
setElementData(source,"xtrashipcommandchairengine2",true)
setElementAlpha(source, 0)
setElementModel(thedriverped2,skin)
setElementAlpha(thedriverped2, 255)
warpPedIntoVehicle(source,xtrashiplh)
warpPedIntoVehicle(thedriverped2,xtrashipcommandchairengine2)
end
end
end
addEventHandler("onPlayerVehicleEnter",root,plakopstoel2)
function plakuitstoel2(p)
if getElementData(source,"xtrashipcommandchairengine2")then
if getElementType(source)=="player"then
setElementData(source,"xtrashipcommandchairengine2",false)
warpPedIntoVehicle(thedriverped2,xtrashiplh)
setElementAlpha(thedriverped2, 0)
local x,y,z =getElementPosition(xtrashipcommandchair2)
setElementPosition(source,x,y,z+1)
warpPedIntoVehicle(source,xtrashipcommandchairengine2,1)
setElementAlpha(source, 255)
end
end
end
addEventHandler("onPlayerVehicleExit",root,plakuitstoel2)
function plakopstoel(p,m)
if getElementData(p,"xtrashipengine")then
if getElementType(source)=="player" and m== 0 and getElementData(source,"adm")then
local skin = getElementModel(source)
setElementData(source,"xtraship",true)
setElementAlpha(source, 0)
setElementModel(thedriverped,skin)
setElementAlpha(thedriverped, 255)
setElementCollisionsEnabled(xtrashipengine, true)
setElementFrozen(xtrashipengine, false)
warpPedIntoVehicle(source,xtrashipengine)
warpPedIntoVehicle(thedriverped,xtrashipcommandchairengine)
end
end
end
addEventHandler("onPlayerVehicleEnter",root,plakopstoel)
function plakuitstoel(p)
if getElementData(p,"xtrashipengine2")then
if getElementType(source)=="player"then
if isVehicleOnGround ( xtrashipengine ) == false then
setElementData(source,"xtraship",false)
local xs,ys,zs =getElementPosition(xtrashipengine)
local xrs,yrs,zrs =getElementRotation(xtrashipengine)
setElementFrozen(xtrashipengine, true)
setElementCollisionsEnabled(xtrashipengine, false)
setElementPosition(xtrashipengine,xs,ys,zs)
setElementRotation(xtrashipengine,0,0,zs)
warpPedIntoVehicle(thedriverped,xtrashipengine)
setElementAlpha(thedriverped, 0)
local x,y,z =getElementPosition(xtrashipcommandchair)
setElementPosition(source,x,y,z+1)
setElementAlpha(source, 255)
setVehicleEngineState ( xtrashipengine, false )
else
setElementData(source,"xtraship",false)
warpPedIntoVehicle(thedriverped,xtrashipengine)
setElementAlpha(thedriverped, 0)
local x,y,z =getElementPosition(xtrashipcommandchair)
setElementPosition(source,x,y,z+1)
setElementAlpha(source, 255)
setVehicleEngineState ( xtrashipengine, false )
end
end
end
end
addEventHandler("onPlayerVehicleExit",root,plakuitstoel)
addEvent("attachthextrashipguns",true)
function attachthextrashipguns()
triggerClientEvent("addxtrashipweapons",getRootElement(),xtrashipengine)
end 
setTimer(triggerClientEvent,1000,1,"addxtrashipweapons",getRootElement(),xtrashipengine)
addEventHandler("onPlayerLogin",root,attachthextrashipguns)
function warpinside(p)
if getElementData(p,"adm")then
local x,y,z =getElementPosition(xtrashipcommandchair)
setElementPosition(p,x,y,z+1)
end end
addCommandHandler("wpnsd",warpinside)
