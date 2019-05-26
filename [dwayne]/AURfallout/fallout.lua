
--------------
---OPTIONS----
--------------
rows = 10         --Default:10  Number of rows to put on the board
columns = 10       --Default:8   Number of columns to put on the board
winningBoards = 3 --Default:3   Number of boards that will not fall. Must be higher than board count!
callSpeedA = 250  --Default:250 Call speed when 30 or more boards exist
callSpeedB = 500  --Default:500 Call speed when 29 to 15 boards exist
callSpeedC = 750  --Default:750 Call speed when 15 or less boards exist
--------------
---/OPTIONS---
--------------

board = {}
timing = {}
tableSize = rows * columns
newTournament = true --Setup scoreboard and podium scores
players = getElementsByType ( "player" )
gameOver = false

allowed = false
allowed2 = false
---------------------------------------------------------------------------------------------
--                                     START FALLING BOARD SCRIPT                          --
---------------------------------------------------------------------------------------------

function triggerClientFall ( fallingPiece )
    if gameOver == false then --Stop timer setting when winner is declared, avoid board recretaion problems
		triggerClientEvent ( "clientShakePieces", getRootElement(), fallingPiece )
		local x, y = getElementPosition ( fallingPiece )
	    local rx, ry, rz = math.random( 0, 360 ), math.random( 0, 360 ), math.random( 0, 360 )
		if rx < 245 then rx = -(rx + 245) end --Make the falling pieces with big random spins
		if ry < 245 then ry = -(ry + 245) end
		if rz < 245 then rz = -(rz + 245) end
		timing = setTimer ( moveObject, 2500, 1, fallingPiece, 10000, x, y, -100, rx, ry, rz )
	    timing = setTimer ( destroyElement, 8000, 1, fallingPiece )
	end
end

function breakAwayPieces ()
	tableSize = table.maxn (board)
	if tableSize ~= winningBoards then
		chosenBoard = math.random ( 1, tableSize )
		triggerClientFall ( board[chosenBoard] ) --becomes fallingPiece parameter
		if tableSize >= 40 then
			callSpeed = callSpeedA
		elseif ( tableSize <= 29 ) and ( tableSize > 15 ) then
			callSpeed = callSpeedB
		elseif tableSize < 15 then
			callSpeed = callSpeedC
		end
		table.remove ( board, chosenBoard ) --Adjust table to get rid of used board
		timing = setTimer ( breakAwayPieces, callSpeed, 1 )
	end
end
---------------------------------------------------------------------------------------------
--                                     /END FALLING BOARD SCRIPT                           --
---------------------------------------------------------------------------------------------



function newGameCountdown ()
	if countdown > 0 then
		timing = setTimer ( newGameCountdown, 2000, 1 )
		countdown = countdown - 1
		--playSoundFrontEnd(root, 44)
	else
		--playSoundFrontEnd(root, 45)
		--Erase countdown for displaying 'get ready' next game prior to countdown
		gameOver = false
		breakAwayPieces () --Game starts, boards fall
	end
end


addEvent("createfallout",true)
function createBoard () --MOVE BOARD CREATION TO CLIENTSIDE
	--Create boards. Platform #1 is at SW Corner
	local staff = exports.CSGstaff:isPlayerEventManager(source)
	if getTeamName(getPlayerTeam(source)) ~= "Staff" then return false end
    if ( staff ) then
		if allowed2 == false then
		outputChatBox("[Fallout EVENT] Created above all saint hospital area", source, 255, 0, 0)
		cleanupOldGame ()
		winnerCount = 0 --Reset tournament winners each newGame if no tourney winner
		count = 1 --Reset count for storing new board creation identities
		players = getElementsByType ( "player" ) --Update players table
		setElementPosition(source,1199.79, -1297.3, 242.41)
		setElementInterior(source,0)
		setElementDimension(source,1000)
		for i = 1,rows do --Nested to create rows and columns
			for j = 1, columns do
				board[count] = createObject ( 1697, 1174.7 + 4.466064 * j, -1323.19 + 5.362793 * i, 241.24, math.deg( 0.555 ), 0, 0 )
				setElementDimension(board[count],1000)
				count = count + 1
			end
		end
		allowed = true
		end
	end
end
addEventHandler("createfallout",root,createBoard)


addEvent("destroyfallout",true)
function cleanupOldGame ()
	local staff = exports.CSGstaff:isPlayerEventManager(source)
	if getTeamName(getPlayerTeam(source)) ~= "Staff" then return false end
    if ( staff ) then
	for k,v in ipairs(board) do
		if isElement(v) then destroyElement(v) end
	end
		if isTimer(timing) then killTimer(timing) end
	timing = {}
	board = {}
	allowed = false
	allowed2 = false
	end
end
addEventHandler("destroyfallout",root,cleanupOldGame)

addEvent("shakefallout",true)
function newGame ()
	local staff = exports.CSGstaff:isPlayerEventManager(source)
	if getTeamName(getPlayerTeam(source)) ~= "Staff" then return false end
    if ( staff ) then
		if allowed == true then
			allowed = false
			allowed2 = true
			winnerCount = 0 --Reset tournament winners each newGame if no tourney winner
			count = 1 --Reset count for storing new board creation identities
			players = getElementsByType ( "player" ) --Update players table
			countdown = 3 --Set here for first game only
			timing = setTimer ( newGameCountdown, 3000, 1 )
			outputChatBox("[EVENT] : Fallout Event Started", root, 255, 255, 0)
		end
	end
end
addEventHandler("shakefallout",root,newGame)


addCommandHandler("fallout",function(player)
	local staff = exports.CSGstaff:isPlayerEventManager(player)
    if ( staff ) then
		triggerClientEvent(player,"showFallout",player)
	end
end)

