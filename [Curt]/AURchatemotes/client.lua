local registered_emoji = {}

function refreshTable ()
	local file = fileOpen("emojis.json")
	registered_emoji = fromJSON(fileRead(file, fileGetSize(file)))
	fileClose(file) 
end 

addEventHandler("onClientResourceStart",rroot,function()
	refreshTable()
end,false)

local root = getRootElement() 
local rroot = getResourceRootElement() 
local sx,sy = guiGetScreenSize() 
local chatbox = getChatboxLayout() 
local y = chatbox["chat_scale"][2] 
local lineas = chatbox["chat_lines"] 
local font = "default" 
  
if chatbox["chat_font"] == 1 then 
    font = "clear" 
elseif chatbox["chat_font"] == 2 then 
    font = "default-bold" 
elseif chatbox["chat_font"] == 3 then 
    font = "arial" 
end 


addEventHandler("onClientChatMessage",root,function(txt)
	for k,v in ipairs(getElementsByType("gui-staticimage",rroot)) do 
        local gx,gy = guiGetPosition(v,true) 
        if string.len(txt) > 100 then 
            guiSetPosition(v, gx,gy-0.025,true) 
        else 
            guiSetPosition(v, gx,gy-0.025,true) 
        end 
        if gy <= 0.01 then 
            destroyElement(v) 
        end 
    end 
    txt = string.gsub(txt,"#%x%x%x%x%x%x","") 
    local len = 0 
    if string.len(txt) > 48 then 
        return 
    end 
	for i=1, #registered_emoji do
		if string.find(txt,registered_emoji[i][1]) then 
			local text = string.gsub(txt,registered_emoji[i][1],"") 
			local len = dxGetTextWidth(text,chatbox["chat_scale"][1],font) 
			local lfin = convertirRelativo(len) 
			outputDebugString("LEN="..tostring(len).." LFIN="..tostring(lfin)) 
			local img = guiCreateStaticImage(0.01875+lfin,0.02+(0.025*(lineas-1)),0.02,0.025,"emojis/"..registered_emoji[i][2],true) 
		end 
	end
end)

function convertirRelativo(x)
	local rx = x/sx
	return rx
end