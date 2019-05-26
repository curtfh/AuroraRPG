-- #######################################
-- ## Project: MTA FlappyBird			##
-- ## Name: FlappyBirdGame.lua			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

FlappyBirdGame = {};
FlappyBirdGame.__index = FlappyBirdGame;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function FlappyBirdGame:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// CreateNewTube		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FlappyBirdGame:CreateNewTube()

	-- Tube oben und Unten erstellen
	for i = 1, 2, 1 do

		local gX				= self.sx+self.gX;
		local randTubeLength	= math.random(100, 250)

		local obenTube 			= Tube:New(true, gX, randTubeLength*1.25)

		local untenTube 		= Tube:New(false, gX, randTubeLength)

		self.tubes[gX] = {obenTube, untenTube};

		setTimer(function()
			table.remove(self.tubes, gX)
		end, 3000, 1)
	end
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FlappyBirdGame:Render()
	-- Render
	dxSetRenderTarget(self.renderTarget, true);

	local iTimeDone	= getTickCount()-self.startTick


	-- Background
	if(self.background == 1) then
		dxDrawImageSection(0, 0, self.sx, self.sy, 0, 0, self.sx, self.sy, self.imageTexture)
	else
		dxDrawImageSection(0, 0, self.sx, self.sy, 292, 0, self.sx, self.sy, self.imageTexture)
	end
	-- Tubes --

	for gX, tubePaar in pairs(self.tubes) do
		local untenTube, obenTube	= tubePaar[1], tubePaar[2];

		self.lastX	= gX-self.gX;
		local iY1, iY2 = self.sy-untenTube.iLength, 0-obenTube.iLength;


		dxDrawImageSection(gX-self.gX, self.sy-untenTube.iLength, untenTube.sizeX, untenTube.sizeY, untenTube.u, untenTube.v, untenTube.w, untenTube.h, self.imageTexture)
		dxDrawImageSection(gX-self.gX, 0-obenTube.iLength, obenTube.sizeX, obenTube.sizeY, obenTube.u, obenTube.v, obenTube.w, obenTube.h, self.imageTexture)


		if(self.flappy:IsInRoehre(gX-self.gX, iY1, iY2)) then
			self.flappy:Die()
		end


		self.flappy:IsInRoehre(self.lastX, nil, nil, true)
	end



	-- Der Busch oder was das ist
	for i = 0, 1, 1 do
		dxDrawImageSection(((self.sx*i)-iTimeDone/10)-i, self.sy-93, 336, 93, 584, 0, 336, 93, self.imageTexture)
	end

	if(self.moving == true) then
		self.gX	= ((getTickCount()-self.defaultStartTick)/10)
	end

	-- Flappy
	if(self.flappyUI.startmenuAEnabled ~= true) then
		dxDrawImageSection(self.flappy.sx, self.flappy.sy, self.flappy.sizeX, self.flappy.sizeY, 230, 757, self.flappy.sizeX, self.flappy.sizeY, self.imageTexture, self.flappy.rotation)
	end
	if(iTimeDone >= 2880 or self.moving == false) then
		self.startTick = getTickCount();
	end

--	dxDrawText("X: "..self.flappy.sx..", Y: "..math.floor(self.flappy.sy).."\ngX: "..self.gX, 00, 00, 50, 50, tocolor(0, 0, 0, 255), 1, "default-bold")

	-- Umrandung --
	dxDrawLine(0, 0, self.sx, 0, tocolor(0, 0, 0, 255), 3);
	dxDrawLine(0, 0, 0, self.sy, tocolor(0, 0, 0, 255), 3);
	dxDrawLine(self.sx, 0, self.sx, self.sy, tocolor(0, 0, 0, 255), 5);

	dxDrawLine(self.sx, self.sy, -self.sx, self.sy, tocolor(0, 0, 0, 255), 5);


	-- Main Menu --
	self.flappyUI:RenderStartMenu();

	if(self.flappy.dead == true) then
		self.flappyUI:RenderDeadMenu();
	else
		self.flappyUI:RenderScore();
	end

	-- Render Target nil setzen
	dxSetRenderTarget(nil);

	-- Das RenderTarget zeichnen
	dxDrawImage(BGX,BGY, BGWidth,BGHeight, self.renderTarget,nil,nil,nil,true);


	-- Calculate Flappy

	self.flappy:Calculate();

	-- Create Tubes

	if(getTickCount()-self.tubeTick > 2000) then

		if(self.moving == true and self.flappy.ready == true) then
			self:CreateNewTube();


		end
		self.tubeTick = getTickCount();

	end
end

-- ///////////////////////////////
-- ///// Reset		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FlappyBirdGame:Reset()
	self.flappy:Reset();
	self.flappyUI:Reset()

	self.startTick		= getTickCount();
	self.tubeTick		= getTickCount();

	self.defaultStartTick = getTickCount();

	self.tubes			= {}

	self.gX				= 0;

	self.moving 		= true;
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FlappyBirdGame:Constructor(...)

	-- Klassenvariablen --
	self.sx, self.sy	= 288, 540;

	self.aesx, self.aesy = BGX+5.3*BGWidth,BGY+1.5*BGHeight

	self.gX				= 0;

	self.renderTarget	= dxCreateRenderTarget(self.sx, self.sy, false)
	self.imageTexture	= dxCreateTexture("apps/flappy/images/atlas.png", "argb", true, "clamp" );

	self.flappy			= Flappy:New(self.sx, self.sy);
	self.flappyUI		= FlappyUI:New(self.sx, self.sy, self.imageTexture);

	self.startTick		= getTickCount();
	self.tubeTick		= getTickCount();
	self.background		= math.random(1, 2);


	self.defaultStartTick = getTickCount();

	self.tubes			= {}

	-- Moving?
	self.moving			= true;
	showCursor(true)

	-- Methoden --
	self.renderFunc		= function(...) self:Render(...) end;


	-- Events --

	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	--logger:OutputInfo("[CALLING] FlappyBirdGame: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FlappyBirdGame:Destructor()
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc)
	if isElement(self.renderTarget) then destroyElement(self.renderTarget) end
	if isElement(self.imageTexture) then destroyElement(self.imageTexture); end
	unbindKey("mouse1", "down", self.flappy.clickFlappyFunc)
	--unbindKey("mouse2", "down", self.flappy.Destructor)
	--- Garbage collector, do your thing!
	self = nil;
end
-- EVENT HANDLER --
