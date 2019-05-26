Boards = {
	{"homies_*"},
	{"didersachs01"},
	{"bobo_2"},
	{"eris_*"},
	{"heat_02"},
	{"sunbillb03"},
	{"base5_1"},
	{"cokopops_2"},
	{"bobobillboard1"},
	{"prolaps02"},
	{"victim_bboard"},
	{"pizza_wellstacked"},
	{"ws_suburbansign"},
	{"prolaps01_small"},
	{"hardon_1"},
	{"247sign1"},
	{"gaulle_3"},
	{"semi3dirty"},
}


local LawSkins = {
	{"ad1"},
	{"ad2"},
	{"ad3"},
	{"ad4"},
	{"ad5"},
	{"ad6"},
	{"ad7"},
	{"ad8"},
	{"ad9"},
	{"ad10"},
	{"ad11"},
	{"ad12"},

}

local shaders = {}
local texts = {}
local texts2 = {}
local proTimer = {}
local dupdate = {}
effectID = 1
randomTexture = math.random(1,12)
function loadBillboards()
	randomTexture = math.random(1,12)
	hit = 0
	cn = 0
	effectID = 1
	effectProgress = 0
    for i=1,#LawSkins do
		if fileExists(":AURbillboard/res/Textures/"..LawSkins[i][1]..".png") then
			hit = hit + 1
		end
	end
		if hit == 12 then
			outputDebugString("12 hits")
			if shaders and isElement(shaders) then return false end
			shaders, tec = dxCreateShader ( "texreplace.fx" )
			texts = dxCreateTexture ( "res/Textures/ad1.png" )
			dxSetShaderValue ( shaders, "texture1",texts )
			dxSetShaderValue ( shaders, "texture2",texts)
			for k=1,#Boards do
				engineApplyShaderToWorldTexture ( shaders, Boards[k][1] )
				engineApplyShaderToWorldTexture ( shaders, Boards[k][1].."lod" )
			end
			--addEventHandler("onClientPreRender",root,update)
			if isTimer(proTimer) then return false end
			proTimer = setTimer(function()
				--for i=1,12 do
					if shaders then
						if texts and isElement(texts) then destroyElement(texts) end
						if texts2 and isElement(texts2) then destroyElement(texts2) end
						texts = nil
						texts2 = nil
						effectProgress = 0
						effectID = math.random(1,3)
						cn = cn+1
						cn2 = cn+1
						if cn > 12 then
							cn = 1
						end
						if cn2 >= 12 then
							cn2 = 2
						end
						texts = dxCreateTexture ( "res/Textures/ad"..tostring(cn)..".png" )
						texts2 = dxCreateTexture ( "res/Textures/ad"..tostring(cn2)..".png" )
						if texts then
							dxSetShaderValue ( shaders, "texture1", texts )
							dxSetShaderValue ( shaders, "texture2", texts2 )
							--[[texts2[cn] = dxCreateTexture ( "res/Textures/ad"..tostring(cn)..".png" )
							if texts2[cn] then
								dxSetShaderValue ( shaders[i], "texture2", texts2[cn] )
							end]]
						end
					end
				--end
			end,15000,0)
			if isTimer(dupdate) then return false end
			dupdate = setTimer(update,50,0)
		end
   -- end
end

function update()
	--for i=1,12 do
		if shaders and texts then
			effectProgress = effectProgress + 1
			if (effectProgress > 100) then
				effectProgress = 100
			end
			dxSetShaderValue ( shaders,"effectProgress", effectProgress)
			dxSetShaderValue ( shaders,"effectID",tonumber(effectID))
			--dxSetShaderValue ( shaders[i],"texture1",texts[currentAD])
			--dxSetShaderValue ( shaders[i],"texture2",texts[nextAD])
		end
	--end
end


function disloadBillboards()
	---for i=1,#LawSkins do
		if shaders then
			for k=1,#Boards do
				if shaders and isElement(shaders) then
					engineRemoveShaderFromWorldTexture ( shaders, Boards[k][1] )
					engineRemoveShaderFromWorldTexture ( shaders, Boards[k][1].."lod" )
				end
			end
			shaders = nil
			texts = nil
			texts2 = nil
			if isElement(shaders) then destroyElement(shaders) end
		end
	---end
	if isTimer(proTimer) then
		killTimer(proTimer)
	end
	if isTimer(dupdate) then
		killTimer(dupdate)
	end
end



function hudswitch(t)
	if t == true then
		loadBillboards()
	else
		disloadBillboards()
	end
end


addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, hudstate )
		if setting == "billboards" then
			hudswitch( hudstate )
		end
	end
)


function checkSettinghud()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "billboards" )
		hudswitch( setting )
	else
		setTimer( checkSettinghud, 10000, 1 )
	end
	for k,v in ipairs(LawSkins) do
		downloadFile ( "res/Textures/"..v[1]..".png" )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettinghud )

