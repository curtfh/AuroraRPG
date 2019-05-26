local ints = {
	{"floor.png","cj_7_11_tile"}, -- Hospital floor
	{"floor2.png","gun_ceiling1128"}, --- Hospital roof
	{"ground.png","ab_rollmat02"},
	{"wall2.png","drvin_front"},
	{"wall2.png","cj_white_wall2"},
	{"wall2.png","cj_7_11_win"},
	{"wall2.png","drvin_back"},
	{"mobowall.png","cj_tv_screen"}, -- pc
	{"cherryblossom.png","cj_matress2"}, -- bed
	{"doors.png","ws_painted_doors1"},
	{"doors.png","cj_pizza_door"},
	--[[{"LVPD3.jpg","newpolice_sa"},
	{"LVPD2.jpg","vgnbankbld4_256"},
	{"LVPD.jpg","brickvgn1_128"},
	{"LVPD.jpg","vgnbankbld3_256"},
	{"LVPD.jpg","vgnbankbld2_256"},
	{"LVPD.jpg","vgnbankbld1_256"},
	{"crims.jpg","vgsn_emerald"},
	{"crims.jpg","fitzwallvgn1_256"},
	{"BR.jpg","sl_whitewash1"},
	{"BR.jpg","gm_labuld2_b"},]]
}
--http://www.fileconvoy.com/dfl.php?id=gb74e05e2d6b4a3319998199637190b3979189220d
local roads = {
	--- TEST
	-- SF and Vellige and LV
	{"ccarbon","concretedust2_256128"},
	{"ccarbon","greyground256"},
	{"ccarbon","hiwayinsideblend2_256"},
	{"ccarbon","crossing_law2"},
	{"ccarbon","vegastriproad1_256"},
	{"ccarbon","vegasroad2_256"},
	{"carbon","hiwayend_256"},
	{"carbon","vegasroad3_256"},
	{"carbon","vegasdirtyroad2_256"},
	{"carbon","crossing_law3"},
	{"carbon","vegasdirtyroad3_256"},
	{"carbon","vegasdirtyroad1_256"},
	{"ccarbon","hiwayinsideblend3_256"},
	{"ccarbon","hiwayinside_256"},
	{"ccarbon","crossing_law"},
	{"ccarbon","hiwayinside3_256"},
	{"ccarbon","dt_road_stoplinea"},
	{"ccarbon","hiwayinside2_256"},
	{"ccarbon","hiwayinside4_256"},
	{"ccarbon","tar_venturasjoin"},
	{"ccarbon","hiwayinside5_256"},
	{"ccarbon","hiwayoutside_256"},
	{"ccarbon","tar_1linefreewy"},
	{"ccarbon","tar_lineslipway"},
	{"ccarbon","sf_junction3"},
	{"ccarbon","sf_junction5"},
	{"carbon","hiwaymidlle_256"},
	{"carbon","sf_road5"},
	{"carbon","ws_freeway3"},
	{"carbonside","tar_1line256hvblend2"},
	{"carbonside","tar_1line256hv"},
	{"carbon","dirttracksgrass256"},
	{"carbon","cw2_weeroad1"},
	{"carbonside","tar_freewyleft"},
	{"carbonside","tar_1line256hvblenddrt"},
	{"carbonside","tar_1line256hvblenddrtdot"},

	--LS
	{"carbon","cuntroad01_law"},
	{"carbon","roadnew4_256"},
	{"carbon","sl_freew2road1"},
	{"carbon","snpdwargrn1"},
	{"carbon","cos_hiwaymid_256"},
	{"carbon","snpedtest1"},
	{"carbon","dt_road"},
	{"carbon","vegasroad1_256"},
} --
---https://github.com/Epozide/Aurora
local shader = {}
local intsModsEnabled = false
local enabled = false


local intsModsswitch = function (intsModsstate)
	if intsModsstate then
		intsModsEnabled = true
		enabled = true
		enableMods()
		if isTimer(ih) then killTimer(ih) end
	else
		disableMods()
		if isTimer(ih) then killTimer(ih) end
		enabled = false
	end
end

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, intsModsstate )
		if setting == "Mapmods" then
			intsModsswitch( intsModsstate )
		end
	end
)

function checkSettingintsMods()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "Mapmods" )
		intsModsswitch( setting )
	else
		if isTimer(ih) then killTimer(ih) end
		ih = setTimer( checkSettingintsMods, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettingintsMods )

function enableMods()
	for k,v in ipairs(ints) do
		if isElement(shader[k]) then destroyElement ( shader[k] ) end
		shader[k], tec = dxCreateShader( "shader.fx" )
		if shader[k] then
			texture = dxCreateTexture ( v[1] )
			if texture then
				engineApplyShaderToWorldTexture ( shader[k], v[2] )
				dxSetShaderValue ( shader[k], "gTexture", texture )
			end
		end
	end
	outputDebugString("Enable hospital interior mod")
end

function disableMods()
	for k,v in ipairs(ints) do
		if shader[k] then
			if isElement(shader[k]) then destroyElement ( shader[k] ) end
			engineRemoveShaderFromWorldTexture ( shader[v], v[2] )
			destroyElement ( shader[k] )
		end
	end
end


local shader2 = {}
local streetsModsEnabled = false
local enabled2 = false


local streetsModsswitch = function (streetsModsstate)
	if streetsModsstate then
		streetsModsEnabled = true
		enabled2 = true
		enableMods2()
		if isTimer(hds) then killTimer(hds) end
	else
		disableMods2()
		if isTimer(hds) then killTimer(hds) end
		enabled2 = false
	end
end

addEvent( "onPlayerSettingChange", true )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, streetsModsstate )
		if setting == "roads" then
			streetsModsswitch( streetsModsstate )
		end
	end
)

function checkSettingstreetsMods()
	if ( getResourceRootElement( getResourceFromName( "DENsettings" ) ) ) then
		local setting = exports.DENsettings:getPlayerSetting( "roads" )
		streetsModsswitch( setting )
	else
		if isTimer(hds) then killTimer(hds) end
		hds = setTimer( checkSettingstreetsMods, 5000, 1 )
	end
end
addEventHandler( "onClientResourceStart", resourceRoot, checkSettingstreetsMods )

function enableMods2()
	local x = getParts()
	if x < 512 then
		exports.NGCdxmsg:createNewDxMessage("You don't meet this mini game requirements, upgrade your graphic card",255,0,0)
		return false
	end
	for k,v in ipairs(roads) do
		if isElement(shader2[k]) then destroyElement ( shader2[k] ) end
		shader2[k], tec = dxCreateShader( "shader.fx" )
		if shader2[k] then
			texture = dxCreateTexture ( v[1]..".png" )
			if texture then
				engineApplyShaderToWorldTexture ( shader2[k], v[2] )
				dxSetShaderValue ( shader2[k], "gTexture", texture )
			end
		end
	end
	outputDebugString("Enable roads interior mod")
end

function disableMods2()
	for k,v in ipairs(roads) do
		if shader2[k] then
			if isElement(shader2[k]) then destroyElement ( shader2[k] ) end
			engineRemoveShaderFromWorldTexture ( shader2[v], v[2] )
			destroyElement ( shader2[k] )
		end
	end
end


function getParts()
	local mode = dxGetStatus ( )
	return mode.VideoCardRAM
end
