--Prevent imposters
function scanForTag(old,new)
	if type(string.find(string.lower(new),"ech0",1,true)) == "number" or type(string.find(string.lower(new),"Ech0",1,true)) == "number" or type(string.find(string.lower(new),"Echo",1,true)) == "number" or type(string.find(string.lower(new),"echo",1,true)) == "number" or type(string.find(string.lower(new),"[NGC]Echo",1,true)) == "number" then
		if getPlayerSerial(source) ~= "C1E82E476F66DC6380696ED1EB810343" then
			outputChatBox(old.." has been kicked for using Echo nickname",root,255,255,255)
			for k,v in ipairs(getElementsByType("player")) do
				exports.killmessages:outputMessage(new.." is an imposter Echo. Renamed to "..old, v, 255, 0, 0)
			end
			setPlayerName(source,old)
			kickPlayer(source,"Dont use this nickname")
			cancelEvent()
		end
	end
end
addEventHandler("onPlayerChangeNick",root,scanForTag)

addEvent("onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,function ( userID )
	if getPlayerSerial(source) ~= "C1E82E476F66DC6380696ED1EB810343" then
		local new = getPlayerName(source)
		if type(string.find(string.lower(new),"Echo",1,true)) == "number" or type(string.find(string.lower(new),"echo",1,true)) == "number" or type(string.find(string.lower(new),"[NGC]echo",1,true)) == "number" or type(string.find(string.lower(new),"[NGC]Echo",1,true)) == "number" then
			local old = getPlayerName(source)
			setPlayerName(source,"Asshole"..math.random(255).."")
			local newx = getPlayerName(source)
			outputChatBox(getPlayerName(source).." has been kicked for using Echo nickname",root,255,255,255)
			for k,v in pairs(getElementsByType("player")) do
				exports.killmessages:outputMessage(old.." is an imposter. Renamed to "..newx.."", v, 255, 0, 0)
			end
			kickPlayer(source,"Dont use this nickname")
        end
    end
end)
----------------------------------------------------------------------------------------------------
--Prevent imposters
function scanForTag2(old,new)
	if type(string.find(string.lower(new),"King",1,true)) == "number" or type(string.find(string.lower(new),"king",1,true)) == "number" or type(string.find(string.lower(new),"king",1,true)) == "number" or type(string.find(string.lower(new),"echo",1,true)) == "number" or type(string.find(string.lower(new),"king",1,true)) == "number" then
		if getPlayerSerial(source) ~= "13550092DD54615EBB67DB1F628B1EF4" then
			for k,v in ipairs(getElementsByType("player")) do
				exports.killmessages:outputMessage(new.." is an imposter King Veer. Renamed to "..old, v, 255, 0, 0)
			end
			setPlayerName(source,"imposter"..math.random(255).."")
			cancelEvent()
			kickPlayer(source,"Dont use this nickname")
		end
	end
end
addEventHandler("onPlayerChangeNick",root,scanForTag2)

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		if getPlayerSerial(v) ~= "13550092DD54615EBB67DB1F628B1EF4" then
			local new = getPlayerName(v)
			if type(string.find(string.lower(new),"king",1,true)) == "number" or type(string.find(string.lower(new),"king",1,true)) == "number" or type(string.find(string.lower(new),"king",1,true)) == "number" or type(string.find(string.lower(new),"king",1,true)) == "number" then
				local old = getPlayerName(v)
				setPlayerName(v,"imposter"..math.random(255).."")
				local newx = getPlayerName(v)
				exports.killmessages:outputMessage(old.." is an imposter king veer. Renamed to "..newx.."", v, 255, 0, 0)
			end
		end
    end
end)
----------------------------------------------------------------------------------------------------
--Prevent imposters
function scanForTag3(old,new)
	if type(string.find(string.lower(new),"Nixon",1,true)) == "number" or type(string.find(string.lower(new),"nixon",1,true)) == "number" or type(string.find(string.lower(new),"Nix",1,true)) == "number" or type(string.find(string.lower(new),"nix",1,true)) == "number" or type(string.find(string.lower(new),"Nixoff",1,true)) == "number" or type(string.find(string.lower(new),"nixoff",1,true)) == "number" or type(string.find(string.lower(new),"Nix0ff",1,true)) == "number" or type(string.find(string.lower(new),"Nix0ff",1,true)) == "number" or type(string.find(string.lower(new),"[AUR]Nixon",1,true)) == "number" or type(string.find(string.lower(new),"[AUR]Nixon-",1,true)) == "number" or type(string.find(string.lower(new),"N!x",1,true)) == "number" then
		if getPlayerSerial(source) ~= "74CEA43F17A0B7FF363BF640B4154291" then
			outputChatBox(old.." has been kicked for using Nixon nickname",root,255,255,255)
			for k,v in ipairs(getElementsByType("player")) do
				exports.killmessages:outputMessage(new.." is an imposter Nixon. Renamed to "..old, v, 255, 0, 0)
			end
			setPlayerName(source,old)
			kickPlayer(source,"Dont use this nickname")
			cancelEvent()
		end
	end
end
addEventHandler("onPlayerChangeNick",root,scanForTag3)

addEvent("onServerPlayerLogin" )
addEventHandler( "onServerPlayerLogin", root,function ( userID )
	if getPlayerSerial(source) ~= "74CEA43F17A0B7FF363BF640B4154291" then
		local new = getPlayerName(source)
			if type(string.find(string.lower(new),"Nixon",1,true)) == "number" or type(string.find(string.lower(new),"nixon",1,true)) == "number" or type(string.find(string.lower(new),"Nix",1,true)) == "number" or type(string.find(string.lower(new),"nix",1,true)) == "number" or type(string.find(string.lower(new),"Nixoff",1,true)) == "number" or type(string.find(string.lower(new),"nixoff",1,true)) == "number" or type(string.find(string.lower(new),"Nix0ff",1,true)) == "number" or type(string.find(string.lower(new),"Nix0ff",1,true)) == "number" or type(string.find(string.lower(new),"[AUR]Nixon",1,true)) == "number" or type(string.find(string.lower(new),"[AUR]Nixon-",1,true)) == "number" or type(string.find(string.lower(new),"N!x",1,true)) == "number" then
			local old = getPlayerName(source)
			setPlayerName(source,"Asshole"..math.random(255).."")
			local newx = getPlayerName(source)
			outputChatBox(getPlayerName(source).." has been kicked for using Nixon nickname",root,255,255,255)
			for k,v in pairs(getElementsByType("player")) do
				exports.killmessages:outputMessage(old.." is an imposter. Renamed to "..newx.."", v, 255, 0, 0)
			end
			kickPlayer(source,"Dont use this nickname")
        end
    end
end)

addEventHandler("onResourceStart",resourceRoot,function()
	for k,v in ipairs(getElementsByType("player")) do
		if getPlayerSerial(v) ~= "74CEA43F17A0B7FF363BF640B4154291" then
			local new = getPlayerName(v)
			if type(string.find(string.lower(new),"Nixon",1,true)) == "number" or type(string.find(string.lower(new),"nixon",1,true)) == "number" or type(string.find(string.lower(new),"Nix",1,true)) == "number" or type(string.find(string.lower(new),"nix",1,true)) == "number" or type(string.find(string.lower(new),"Nixoff",1,true)) == "number" or type(string.find(string.lower(new),"nixoff",1,true)) == "number" or type(string.find(string.lower(new),"Nix0ff",1,true)) == "number" or type(string.find(string.lower(new),"Nix0ff",1,true)) == "number" or type(string.find(string.lower(new),"[AUR]Nixon",1,true)) == "number" or type(string.find(string.lower(new),"[AUR]Nixon-",1,true)) == "number" or type(string.find(string.lower(new),"N!x",1,true)) == "number" then
				local old = getPlayerName(v)
				setPlayerName(v,"imposter"..math.random(255).."")
				local newx = getPlayerName(v)
				exports.killmessages:outputMessage(old.." is an imposter Nixon. Renamed to "..newx.."", v, 255, 0, 0)
			end
		end
    end
end)
----------------------------------------------------------------------------------------------------