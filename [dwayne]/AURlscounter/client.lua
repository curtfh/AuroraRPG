setElementData(localPlayer, "TurfStat1", false)
setElementData(localPlayer, "TurfStat2", false)


function AbsoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/1280)
    local y = math.floor(Y*rY/768)
    return x, y
end


local x, y = guiGetScreenSize()

font = 1.25

if x == 800 then
	font = 0.98
elseif x == 1024 then
	font = 1.05
elseif x == 1152 then
	font = 1.1
elseif x == 1280 then
	font = 1.1
elseif x == 1360 then
	font = 1.25
elseif x == 1440 then
	font = 1.27
end

local lawTeams = {
	"Government",
	"Military Forces",
}

function isLaw( thePlayer )
	if ( isElement( thePlayer ) ) and ( getElementType ( thePlayer ) == "player" ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end

addEventHandler("onClientRender", root,
function()
	if getPlayerTeam(localPlayer) then
		if not isLaw(localPlayer) and getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals" then return false end
		local Team1 = getElementData(localPlayer, "TurfStat1")
		local Team2 = getElementData(localPlayer, "TurfStat2")
		if Team1 or Team2 then
			local playerTeam = getPlayerTeam(localPlayer)
			if playerTeam then
				local team = getTeamName(playerTeam)
				x,y=AbsoluteToRelativ2(985,200)
				x2,y2=AbsoluteToRelativ2(245, 30)
				dxDrawRectangle(x,y,x2,y2, tocolor(0,0,0, 155), false )
				x,y=AbsoluteToRelativ2(985,235)
				x2,y2=AbsoluteToRelativ2(245, 120)
				dxDrawRectangle(x,y,x2,y2, tocolor(0,0,0, 155), false )
				x,y=AbsoluteToRelativ2(1002,285)
				x2,y2=AbsoluteToRelativ2(212, 21)
				dxDrawRectangle(x,y,x2,y2, tocolor(50,50,50, 155), false )
				x1,y1=AbsoluteToRelativ2(1020, 205)
				x2,y2=AbsoluteToRelativ2(1000, 310)
				dxDrawBorderedText("Aurora ~ Territories", x1, y1, x*0.99, y*0.97, tocolor(255,255,255, 255), font, "default-bold")

				if Team1 then
					if not Team2 then
						if Team1[3] == "LAW" then
							x1,y1=AbsoluteToRelativ2(1050, 315)
							x2,y2=AbsoluteToRelativ2(1000, 310)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "law.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText(Team1[1], x1, y1, x*0.99, y*0.97, tocolor(Team1[2][1], Team1[2][2], Team1[2][3], 255), font, "default-bold")
							x1,y1=AbsoluteToRelativ2(1050, 255)
							x2,y2=AbsoluteToRelativ2(1000, 250)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText("Criminals: 0%", x1, y1, x*0.99, y*0.97, tocolor(255,255,255, 185), font, "default-bold")
							x,y=AbsoluteToRelativ2(1002,285)
							x2,y2=AbsoluteToRelativ2(212, 21)
							dxDrawRectangle(x,y,x2*(Team1[4]/100),y2, tocolor(0,100,200, 155), false )
						elseif Team1[3] == "Criminals" then
							x1,y1=AbsoluteToRelativ2(1050, 315)
							x2,y2=AbsoluteToRelativ2(1000, 310)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "crim.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText(Team1[1], x1, y1, x*0.99, y*0.97, tocolor(Team1[2][1], Team1[2][2], Team1[2][3], 255), font, "default-bold")
							x2,y2=AbsoluteToRelativ2(1000, 250)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText("LAW: 0%", x1, y1, x*0.99, y*0.97, tocolor(255,255,255, 185), font, "default-bold")
							x,y=AbsoluteToRelativ2(1002,285)
							x2,y2=AbsoluteToRelativ2(212, 21)
							dxDrawRectangle(x,y,x2*(Team1[4]/100),y2, tocolor(225,0,50, 155), false )
						end
					elseif Team2 then
						if Team1[3] == "LAW" then
							if team == "Criminals" then
								x1,y1=AbsoluteToRelativ2(1050, 315)
								x2,y2=AbsoluteToRelativ2(1000, 310)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team1[1], x1, y1, x*0.99, y*0.97, tocolor(Team1[2][1], Team1[2][2], Team1[2][3], 255), font, "default-bold")
								x1,y1=AbsoluteToRelativ2(1050, 255)
								x2,y2=AbsoluteToRelativ2(1000, 250)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "crim.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
								x,y=AbsoluteToRelativ2(1002,285)
								x2,y2=AbsoluteToRelativ2(212, 21)
								dxDrawRectangle(x,y,x2*(Team2[4]/100),y2, tocolor(225,0,50, 155), false )
							else
								x1,y1=AbsoluteToRelativ2(1050, 315)
								x2,y2=AbsoluteToRelativ2(1000, 310)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "law.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team1[1], x1, y1, x*0.99, y*0.97, tocolor(Team1[2][1], Team1[2][2], Team1[2][3], 255), font, "default-bold")
								x1,y1=AbsoluteToRelativ2(1050, 255)
								x2,y2=AbsoluteToRelativ2(1000, 250)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
								x,y=AbsoluteToRelativ2(1002,285)
								x2,y2=AbsoluteToRelativ2(212, 21)
								dxDrawRectangle(x,y,x2*(Team1[4]/100),y2, tocolor(0,100,200, 155), false )
							end
						elseif Team1[3] == "Criminals" then
							if team ~= "Criminals" then
								x1,y1=AbsoluteToRelativ2(1050, 315)
								x2,y2=AbsoluteToRelativ2(1000, 310)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team1[1], x1, y1, x*0.99, y*0.97, tocolor(Team1[2][1], Team1[2][2], Team1[2][3], 255), font, "default-bold")
								x1,y1=AbsoluteToRelativ2(1050, 255)
								x2,y2=AbsoluteToRelativ2(1000, 250)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "law.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
								x,y=AbsoluteToRelativ2(1002,285)
								x2,y2=AbsoluteToRelativ2(212, 21)
								dxDrawRectangle(x,y,x2*(Team2[4]/100),y2, tocolor(0,100,200, 155), false )
							else
								x1,y1=AbsoluteToRelativ2(1050, 315)
								x2,y2=AbsoluteToRelativ2(1000, 310)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "crim.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team1[1], x1, y1, x*0.99, y*0.97, tocolor(Team1[2][1], Team1[2][2], Team1[2][3], 255), font, "default-bold")
								x1,y1=AbsoluteToRelativ2(1050, 255)
								x2,y2=AbsoluteToRelativ2(1000, 250)
								x3,y3=AbsoluteToRelativ2(30, 30)
								dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
								dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
								x,y=AbsoluteToRelativ2(1002,285)
								x2,y2=AbsoluteToRelativ2(212, 21)
								dxDrawRectangle(x,y,x2*(Team1[4]/100),y2, tocolor(225,0,50, 155), false )
							end
						end
					end
				end
				if Team2 then
					if not Team1 then
						if Team2[3] == "LAW" then
							x1,y1=AbsoluteToRelativ2(1050, 255)
							x2,y2=AbsoluteToRelativ2(1000, 250)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "law.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
							x1,y1=AbsoluteToRelativ2(1050, 315)
							x2,y2=AbsoluteToRelativ2(1000, 310)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText("Criminals: 0%", x1, y1, x*0.99, y*0.97, tocolor(255,255,255, 185), font, "default-bold")
							x,y=AbsoluteToRelativ2(1002,285)
							x2,y2=AbsoluteToRelativ2(212, 21)
							dxDrawRectangle(x,y,x2*(Team2[4]/100),y2, tocolor(0,100,200, 155), false )
						elseif Team2[3] == "Criminals" then
							x1,y1=AbsoluteToRelativ2(1050, 255)
							x2,y2=AbsoluteToRelativ2(1000, 250)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "crim.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
							x1,y1=AbsoluteToRelativ2(1050, 315)
							x2,y2=AbsoluteToRelativ2(1000, 310)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "noone.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText("LAW: 0%", x1, y1, x*0.99, y*0.97, tocolor(255,255,255, 185), font, "default-bold")
							x,y=AbsoluteToRelativ2(1002,285)
							x2,y2=AbsoluteToRelativ2(212, 21)
							dxDrawRectangle(x,y,x2*(Team2[4]/100),y2, tocolor(225,0,50, 155), false )
						end
					elseif Team2 then
						if Team2[3] == "LAW" then
							x1,y1=AbsoluteToRelativ2(1050, 255)
							x2,y2=AbsoluteToRelativ2(1000, 250)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "law.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
							x,y=AbsoluteToRelativ2(1002,285)
							x2,y2=AbsoluteToRelativ2(212, 21)
							dxDrawRectangle(x,y,x2*(Team2[4]/100),y2, tocolor(0,100,200, 155), false )
						elseif Team2[3] == "Criminals" then
							x1,y1=AbsoluteToRelativ2(1050, 255)
							x2,y2=AbsoluteToRelativ2(1000, 250)
							x3,y3=AbsoluteToRelativ2(30, 30)
							dxDrawImage(x2,y2,x3,y3, "crim.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
							dxDrawBorderedText(Team2[1], x1, y1, x*0.99, y*0.97, tocolor(Team2[2][1], Team2[2][2], Team2[2][3], 255), font, "default-bold")
							x,y=AbsoluteToRelativ2(1002,285)
							x2,y2=AbsoluteToRelativ2(212, 21)
							dxDrawRectangle(x,y,x2*(Team2[4]/100),y2, tocolor(225,0,50, 155), false )
						end
					end
				end
				x,y=AbsoluteToRelativ2(1140, 286)
				x2,y2=AbsoluteToRelativ2(1140, 304)
				dxDrawLine(x,y,x2,y2, tocolor(255, 255, 0, 255), 2, false )
				x,y=AbsoluteToRelativ2(1100, 286)
				x2,y2=AbsoluteToRelativ2(1100, 304)
				dxDrawLine(x,y,x2,y2, tocolor(255, 255, 255, 255), 2, false )
			end
		end
	end
end)

function dxDrawBorderedText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI,theAlpha )
	if not theAlpha then theAlpha = 255 end
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false ) -- black
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, theAlpha ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end
