GUIEditor = {
    checkbox = {},
    label = {},
    gridlist = {},
    edit = {},
    button = {},
    window = {},
    scrollbar = {},
    combobox = {}
}

local playlists = {
	--{"playlist id", "Name"},
	{1, "Songs"},
	{2, "Radio"},
	{3, "Browse"},
}
local songs = {
	--{"songid", "playlistid", "name", "type", "url", "dateadded"},
}

local browse = {
	{"Justin Bieber Duet with Mariah Carey - All I Want For Christmas Is You", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/fGFNmEOntFA_q0.mp3", "AuroraRPG Holidays"},
	{"Wham! - Last Christmas", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/E8gmARGvPlI_q0.mp3", "AuroraRPG Holidays"},
	{"Mariah Carey - All I Want For Christmas Is You", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/yXQViqx6GMY_q0.mp3", "AuroraRPG Holidays"},
	{"Sia - Snowman", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/J_QGZspO4gg_q0.mp3", "AuroraRPG Holidays"},
	{"Sia - Everyday Is Christmas", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/JPp-oLkQPQQ_q0.mp3", "AuroraRPG Holidays"},
	{"Sia - Santa's Coming For Us", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/V3EYjVPRClU_q0.mp3", "AuroraRPG Holidays"},
	{"Train - Shake up Christmas", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/J-8VCL4uSUc_q0.mp3", "AuroraRPG Holidays"},
	{"Ariana Grande - Santa Tell Me", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/jnXxxKZ57Tw_q0.mp3", "AuroraRPG Holidays"},
	{"Fifth Harmony - All I Want for Christmas Is You", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/9vu4AN2bc-M_q0.mp3", "AuroraRPG Holidays"},
	{"Ariana Grande - Last Christmas", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/ReK9MVrOq0w_q0.mp3", "AuroraRPG Holidays"},
	{"Ariana Grande - Winter Things", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/H_lxXH1xcok_q0.mp3", "AuroraRPG Holidays"},
	{"Ed Sheeran - Perfect Duet (with Beyoncé)", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/817P8W8-mGE_q0.mp3", "AuroraRPG Recommendations"},
	{"Sigma - Find Me ft. Birdy", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/817P8W8-mGE_q0.mp3", "AuroraRPG Recommendations"},
	{"Kygo - Stargazing ft. Justin Jesso", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/hEdvvTF5js4_q0.mp3", "AuroraRPG Recommendations"},
	{"Marshmello ft. Khalid - Silence", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/tk36ovCMsU8_q0.mp3", "AuroraRPG Recommendations"},
	{"Ed Sheeran - Perfect", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/2Vv-BfVoq4g_q0.mp3", "AuroraRPG Recommendations"},
	{"Ed Sheeran - Shape of You", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/JGwWNGJdvx8_q0.mp3", "AuroraRPG Recommendations"},
	{"ZAYN - Dusk Till Dawn ft. Sia", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/tt2k8PGm-TI_q0.mp3", "AuroraRPG Recommendations"},
	{"Dua Lipa - New Rules", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/k2qgadSvNyU_q0.mp3", "AuroraRPG Recommendations"},
	{"Bebe Rexha - Meant to Be (feat. Florida Georgia Line)", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/zDo0H8Fm7d0_q0.mp3", "AuroraRPG Recommendations"},
	{"Sam Smith - Too Good At Goodbyes", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/J_ub7Etch2U_q0.mp3", "AuroraRPG Recommendations"},
	{"Maria Lynn, Koni - Dive In", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/l-8krGtZ8C8_q0.mp3", "AuroraRPG Recommendations"},
	{"Andra & Mara - Sweet Dreams (Radio Killer Remix)", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/e3Qu5C0pcGA_q0.mp3", "AuroraRPG Recommendations"},
	{"Camila Cabello - Havana", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/pz95u3UVpaM_q0.mp3", "AuroraRPG Recommendations"},
	{"Shawn Mendes - There's Nothing Holdin' Me Back", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/dT2owtxkU8k_q0.mp3", "AuroraRPG Recommendations"},
	{"Imagine Dragons - Thunder", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/fKopy74weus_q0.mp3", "AuroraRPG Recommendations"},
	{"Jason Derulo - Tip Toe feat French Montana", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/nNA9ru2Ox5o_q0.mp3", "AuroraRPG Recommendations"},
	{"Echosmith - Get Into My Car", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/2UMfEfUR7wM_q0.mp3", "AuroraRPG Recommendations"},
	{"Andra - Why", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/rhcc1KQlCS4_q0.mp3", "AuroraRPG Recommendations"},
	{"The Chainsmokers & Coldplay - Something Just Like This", "MP3 Link", "https://static-cdn.curtcreation.net/yt-mp3/FM7MFYoylVs_q0.mp3", "AuroraRPG Recommendations"},
}

local radio = {
	{"Power 181", "MP3 Link", "http://listen.181fm.com:8128", "AuroraRPG Recommendations"},
	{"UK TOP 40", "MP3 Link", "http://listen.181fm.com:8070", "AuroraRPG Recommendations"},
	{"OldSchool Hip Hop", "MP3 Link", "http://listen.181fm.com:8068", "AuroraRPG Recommendations"},
	{"The Buzz", "MP3 Link", "http://listen.181fm.com:8126", "AuroraRPG Recommendations"},
	{"90's Country", "MP3 Link", "http://listen.181fm.com:8050", "AuroraRPG Recommendations"},
	{"Highway 181", "MP3 Link", "http://listen.181fm.com:8018", "AuroraRPG Recommendations"},
	{"Energy 98", "MP3 Link", "http://listen.181fm.com:8800", "AuroraRPG Recommendations"},
	{"90's Dance", "MP3 Link", "http://listen.181fm.com:8140", "AuroraRPG Recommendations"},
}

local playing
local volume = 1
local lsid = 0
local panning 
local panning2

addEventHandler("onClientResourceStart", resourceRoot, 
    function()
		if (not fileExists("playlists.json") or not fileExists("songs.json")) then 
			fileClose(fileCreate ("playlists.json"))
			fileClose(fileCreate ("songs.json"))
		end 
		
		local file1 = fileOpen("playlists.json")
		playlists = fromJSON(fileRead(file1, fileGetSize(file1))) or { {1, "Songs"}, {2, "Radio"}, {3, "Browse"}, }
		fileClose(file1) 
		
		local file1 = fileOpen("songs.json")
		songs = fromJSON(fileRead(file1, fileGetSize(file1))) or {}
		fileClose(file1) 
		
		fileDelete ("playlists.json")
		fileDelete ("songs.json")
		fileClose(fileCreate ("playlists.json"))
		fileClose(fileCreate ("songs.json"))
		
		local file1 = fileOpen("playlists.json")
		fileWrite(file1, toJSON(playlists))
		fileClose(file1)
		local file2 = fileOpen("songs.json")
		fileWrite(file2, toJSON(songs))
		fileClose(file2)
		
		local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 816) / 2, (screenH - 495) / 2, 816, 495, "AuroraRPGPG - Music Player", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[1], false)
        GUIEditor.gridlist[1] = guiCreateGridList(9, 23, 172, 360, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "Menu", 0.9)
        for i = 1, 7 do
            guiGridListAddRow(GUIEditor.gridlist[1])
        end
        guiGridListSetItemText(GUIEditor.gridlist[1], 0, 1, "Browse", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 1, 1, "Radio", false, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 2, 1, "", true, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 3, 1, "YOUR LIBRARY", true, false)
        guiGridListSetItemColor(GUIEditor.gridlist[1], 3, 1, 191, 161, 154, 255)
        guiGridListSetItemText(GUIEditor.gridlist[1], 4, 1, "Songs", false, false)
		guiGridListSetItemData (GUIEditor.gridlist[1], 4, 1, 1)
        guiGridListSetItemText(GUIEditor.gridlist[1], 5, 1, "", true, false)
        guiGridListSetItemText(GUIEditor.gridlist[1], 6, 1, "PLAYLIST", true, false)
        guiGridListSetItemColor(GUIEditor.gridlist[1], 6, 1, 191, 161, 154, 255)
		for u, thePlaylist in ipairs(playlists) do
			if (thePlaylist[1] > 3) then
				local newRow = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], newRow, 1, thePlaylist[2], false, false)
				guiGridListSetItemData (GUIEditor.gridlist[1], newRow, 1, thePlaylist[1])
			end
		end
		
        GUIEditor.button[1] = guiCreateButton(9, 393, 172, 38, "New Playlist", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(10, 441, 161, 40, "Now Playing: Nothing", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
        GUIEditor.checkbox[1] = guiCreateCheckBox(253, 445, 65, 15, "Shuffle", false, false, GUIEditor.window[1])
        GUIEditor.checkbox[2] = guiCreateCheckBox(546, 445, 99, 15, "Repeat Track", false, false, GUIEditor.window[1])
        GUIEditor.scrollbar[1] = guiCreateScrollBar(207, 466, 428, 15, true, false, GUIEditor.window[1])
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 0)
        GUIEditor.button[2] = guiCreateButton(395, 443, 68, 17, "Play", false, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(468, 443, 68, 17, "Next", false, GUIEditor.window[1])
        GUIEditor.button[4] = guiCreateButton(322, 443, 68, 17, "Previous", false, GUIEditor.window[1])
        GUIEditor.gridlist[2] = guiCreateGridList(184, 57, 480, 374, false, GUIEditor.window[1])
        guiGridListAddColumn(GUIEditor.gridlist[2], "Title", 0.5)
        guiGridListAddColumn(GUIEditor.gridlist[2], "Date Added", 0.5)
        GUIEditor.label[2] = guiCreateLabel(172, 465, 35, 16, "0:00", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[2], "default-bold-small")
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        GUIEditor.label[3] = guiCreateLabel(639, 465, 35, 16, "-0:00", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[3], "default-bold-small")
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        GUIEditor.label[4] = guiCreateLabel(668, 24, 138, 59, "Add a track\nPlease select your libraries or your playlist to add a song.", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[4], "default-bold-small")
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "left", true)
        GUIEditor.combobox[1] = guiCreateComboBox(670, 108, 136, 100, "MP3 Link", false, GUIEditor.window[1])
        guiComboBoxAddItem(GUIEditor.combobox[1], "MP3 Link")
        guiComboBoxAddItem(GUIEditor.combobox[1], "Youtube Link")
        GUIEditor.label[5] = guiCreateLabel(670, 89, 136, 15, "Choose type:", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[5], "default-bold-small")
        GUIEditor.label[6] = guiCreateLabel(670, 141, 136, 15, "Title:", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[6], "default-bold-small")
        GUIEditor.edit[1] = guiCreateEdit(670, 156, 136, 28, "", false, GUIEditor.window[1])
        GUIEditor.label[7] = guiCreateLabel(670, 203, 136, 15, "Link:", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[7], "default-bold-small")
        GUIEditor.edit[2] = guiCreateEdit(670, 218, 136, 28, "", false, GUIEditor.window[1])
        GUIEditor.button[5] = guiCreateButton(674, 256, 132, 32, "Add Song", false, GUIEditor.window[1])
        GUIEditor.label[8] = guiCreateLabel(670, 288, 136, 15, "__________________________________________________", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[8], "default-bold-small")
        GUIEditor.button[6] = guiCreateButton(674, 313, 132, 32, "Remove Selected Song", false, GUIEditor.window[1])
        GUIEditor.button[7] = guiCreateButton(674, 355, 132, 32, "Remove Selected Playlist", false, GUIEditor.window[1])
        GUIEditor.label[9] = guiCreateLabel(684, 445, 94, 15, "Volume (100%):", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[9], "default-bold-small")
        GUIEditor.scrollbar[2] = guiCreateScrollBar(684, 465, 122, 15, true, false, GUIEditor.window[1])
        guiScrollBarSetScrollPosition(GUIEditor.scrollbar[2], 100.0)
        GUIEditor.label[10] = guiCreateLabel(187, 25, 473, 27, "My Playlist Name", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[10], "default-bold-small")
        guiLabelSetHorizontalAlign(GUIEditor.label[10], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[10], "center")
        GUIEditor.button[8] = guiCreateButton(674, 397, 132, 32, "Close", false, GUIEditor.window[1])    
		
		
        GUIEditor.window[2] = guiCreateWindow((screenW - 453) / 2, (screenH - 171) / 2, 453, 171, "Enter a title", false)
        guiWindowSetSizable(GUIEditor.window[2], false)
		guiSetVisible(GUIEditor.window[2], false)
        GUIEditor.edit[3] = guiCreateEdit(59, 54, 337, 36, "", false, GUIEditor.window[2])
        GUIEditor.button[9] = guiCreateButton(59, 104, 156, 34, "Create", false, GUIEditor.window[2])
        GUIEditor.button[10] = guiCreateButton(240, 104, 156, 34, "Cancel", false, GUIEditor.window[2])    
		guiGridListSetSortingEnabled(GUIEditor.gridlist[1], false)
		guiGridListSetSortingEnabled(GUIEditor.gridlist[2], false)
		
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[8], openGUI, false)
		addEventHandler ("onClientGUIClick", GUIEditor.button[9], function()
			if string.len(guiGetText(GUIEditor.edit[3])) < 0 then 
				exports.NGCdxmsg:createNewDxMessage("Cannot add playlist due to empty playlist name.", 255, 0, 0)
				return 
			end 
			local no = #playlists+1
			playlists[no] = {no, guiGetText(GUIEditor.edit[3])}
			local newRow = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], newRow, 1, guiGetText(GUIEditor.edit[3]), false, false)
			guiGridListSetItemData (GUIEditor.gridlist[1], newRow, 1, no)
			guiSetText(GUIEditor.edit[3], "")
			guiSetVisible(GUIEditor.window[2], false)
			fileDelete ("playlists.json")
			fileDelete ("songs.json")
			fileClose(fileCreate ("playlists.json"))
			fileClose(fileCreate ("songs.json"))
			local file1 = fileOpen("playlists.json")
			fileWrite(file1, toJSON(playlists))
			fileClose(file1)
			local file2 = fileOpen("songs.json")
			fileWrite(file2, toJSON(songs))
			fileClose(file2)
		end, false)
		addEventHandler ("onClientGUIClick", GUIEditor.button[7], function()
			local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
			local pid = guiGridListGetItemData(GUIEditor.gridlist[1], row, 1)
			if (pid == 1) then return false end 
			for i, thePlaylist in ipairs(playlists) do 
				if (thePlaylist[1] == pid) then  
					for u, theSongs in ipairs(songs) do 
						if (theSongs[2] == pid) then 
							songs[u] = {}
							for u, theSongs in ipairs(songs) do 
								if (theSongs[2] == pid) then 
									songs[u] = {}
								end 
							end
						end 
					end 
					 
					table.remove(playlists, i)
					guiGridListRemoveRow (GUIEditor.gridlist[1], row)
					exports.NGCdxmsg:createNewDxMessage("Playlist removed!", 255, 0, 0)
					guiGridListClear(GUIEditor.gridlist[2])
					fileDelete ("playlists.json")
					fileDelete ("songs.json")
					fileClose(fileCreate ("playlists.json"))
					fileClose(fileCreate ("songs.json"))	
					local file1 = fileOpen("playlists.json")
					fileWrite(file1, toJSON(playlists))
					fileClose(file1)
					local file2 = fileOpen("songs.json")
					fileWrite(file2, toJSON(songs))
					fileClose(file2)
				end 
			end 
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[6], function()
			local row = guiGridListGetSelectedItem (GUIEditor.gridlist[2])
			local sid = guiGridListGetItemData(GUIEditor.gridlist[2], row, 1)
			for u, theSongs in ipairs(songs) do 
				if (theSongs[1] == sid) then 
					table.remove(songs, u)
					guiGridListRemoveRow (GUIEditor.gridlist[2], row)
					exports.NGCdxmsg:createNewDxMessage("Song removed!", 255, 0, 0)
					fileDelete ("playlists.json")
					fileDelete ("songs.json")
					fileClose(fileCreate ("playlists.json"))
					fileClose(fileCreate ("songs.json"))
					local file1 = fileOpen("playlists.json")
					fileWrite(file1, toJSON(playlists))
					fileClose(file1)
					local file2 = fileOpen("songs.json")
					fileWrite(file2, toJSON(songs))
					fileClose(file2)
				end 
			end 
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[2], function()
			local row = guiGridListGetSelectedItem (GUIEditor.gridlist[2])
			local sid = guiGridListGetItemData(GUIEditor.gridlist[2], row, 1)
			if (guiGetText(GUIEditor.button[2]) == "Pause") then 
				if (isElement(playing)) then 
					if (not isSoundPaused(playing)) then 
						setSoundPaused(playing, true)
						guiSetText(GUIEditor.button[2], "Play")
					end
				end 
			elseif (guiGetText(GUIEditor.button[2]) == "Play") then 
				local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
				if (not isElement(playing)) then 
					if (row == 0) then 
						for u, theSongs in ipairs(browse) do 
							if (u == sid) then 
								playSoundNow(theSongs[1], theSongs[3], theSongs[2])
								lsid = sid
								guiSetText(GUIEditor.button[2], "Pause")
								return
							end 
						end 
					elseif (row == 1) then 
						for u, theSongs in ipairs(radio) do 
							if (u == sid) then 
								playSoundNow(theSongs[1], theSongs[3], theSongs[2])
								lsid = sid
								guiSetText(GUIEditor.button[2], "Pause")
								return
							end 
						end 
					else
						for u, theSongs in ipairs(songs) do 
							if (theSongs[1] == sid) then 
								playSoundNow(theSongs[3], theSongs[5], theSongs[4])
								lsid = sid
								guiSetText(GUIEditor.button[2], "Pause")
								return
							end 
						end 
					end 
				else
					if (isSoundPaused(playing)) then 
						setSoundPaused(playing, false)
						guiSetText(GUIEditor.button[2], "Pause")
					else
						local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
						if (row == 0) then 
							for u, theSongs in ipairs(browse) do 
								if (u == sid) then 
									playSoundNow(theSongs[1], theSongs[3], theSongs[2])
									lsid = sid
									guiSetText(GUIEditor.button[2], "Pause")
									return
								end 
							end 
						elseif (row == 1) then 
							for u, theSongs in ipairs(radio) do 
								if (u == sid) then 
									playSoundNow(theSongs[1], theSongs[3], theSongs[2])
									lsid = sid
									guiSetText(GUIEditor.button[2], "Pause")
									return
								end 
							end 
						else
							for u, theSongs in ipairs(songs) do 
								if (theSongs[1] == sid) then 
									playSoundNow(theSongs[3], theSongs[5], theSongs[4])
									lsid = sid
									guiSetText(GUIEditor.button[2], "Pause")
									return
								end 
							end 
						end 
					end 
				end
			end 
			
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[5], function()
			if (string.len(guiGetText(GUIEditor.edit[1])) < 0 or string.len(guiGetText(GUIEditor.edit[2])) < 0) then 
				exports.NGCdxmsg:createNewDxMessage("Cannot add song due to missing fields.", 255, 0, 0)
				return 
			end 
			local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
			if (row == 0 or row == 1) then return false end 
			local pid = guiGridListGetItemData(GUIEditor.gridlist[1], row, 1)
			local no = #songs+1
			local realTime = getRealTime(  ) 
			local date2 = realTime.monthday.."/"..((realTime.month)+1).."/"..(realTime.year)+1900 
			songs[no] = {no, pid, guiGetText(GUIEditor.edit[1]), guiGetText(GUIEditor.combobox[1]), guiGetText(GUIEditor.edit[2]), date2}
			local newRow = guiGridListAddRow(GUIEditor.gridlist[2])
			guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 1, guiGetText(GUIEditor.edit[1]), false, false)
			guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 2, date2, false, false)
			guiGridListSetItemData (GUIEditor.gridlist[2], newRow, 1, no)
			exports.NGCdxmsg:createNewDxMessage("Song added!", 0, 255, 0)
			fileDelete ("playlists.json")
			fileDelete ("songs.json")
			fileClose(fileCreate ("playlists.json"))
			fileClose(fileCreate ("songs.json"))
			local file1 = fileOpen("playlists.json")
			fileWrite(file1, toJSON(playlists))
			fileClose(file1)
			local file2 = fileOpen("songs.json")
			fileWrite(file2, toJSON(songs))
			fileClose(file2)
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[3], function()
			nextSong()
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[4], function()
			previousSong()
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.button[1], function()
			guiSetVisible(GUIEditor.window[2], true)
			guiBringToFront(GUIEditor.window[2])
		end, false)
		addEventHandler ("onClientGUIClick", GUIEditor.button[10], function()
			guiSetVisible(GUIEditor.window[2], false)
		end, false)
		
		addEventHandler( "onClientGUIClick", GUIEditor.gridlist[1], function( btn ) 
			if btn ~= 'left' then return false end 
			local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
			guiGridListClear(GUIEditor.gridlist[2])
			guiSetText(GUIEditor.label[10], guiGridListGetItemText(GUIEditor.gridlist[1], row, 1))
			if row >= 0 and col >= 0 then 
				if (row == 0) then 
					for u, theSongs in ipairs(browse) do 
						local newRow = guiGridListAddRow(GUIEditor.gridlist[2])
						guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 1, theSongs[1], false, false)
						guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 2, theSongs[4], false, false)
						guiGridListSetItemData (GUIEditor.gridlist[2], newRow, 1, u)
					end 
				elseif (row == 1) then  
					for u, theSongs in ipairs(radio) do 
						local newRow = guiGridListAddRow(GUIEditor.gridlist[2])
						guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 1, theSongs[1], false, false)
						guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 2, theSongs[4], false, false)
						guiGridListSetItemData (GUIEditor.gridlist[2], newRow, 1, u)
					end 
				else 
					for i, thePlaylist in ipairs(playlists) do 
						local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
						local pid = guiGridListGetItemData(GUIEditor.gridlist[1], row, 1)
						if (pid == thePlaylist[1]) then 
							for u, theSongs in ipairs(songs) do 
								if thePlaylist[1] == theSongs[2] then 
									local newRow = guiGridListAddRow(GUIEditor.gridlist[2])
									guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 1, theSongs[3], false, false)
									guiGridListSetItemText(GUIEditor.gridlist[2], newRow, 2, theSongs[6], false, false)
									guiGridListSetItemData (GUIEditor.gridlist[2], newRow, 1, theSongs[1])
								end 
							end 
						end
					end 
				end 
			end 
		end, false ) 
		
		addEventHandler( "onClientGUIClick", GUIEditor.gridlist[2], function( btn ) 
			if btn ~= 'left' then return false end 
			local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
			local sid = guiGridListGetItemData(GUIEditor.gridlist[2], row, 1)
			guiSetText(GUIEditor.button[2], "Play")
		end, false ) 
		
		
		addEventHandler("onClientGUIScroll", GUIEditor.scrollbar[2], function()
			if (playing) then 
				setSoundVolume(playing, (guiScrollBarGetScrollPosition(GUIEditor.scrollbar[2])/100)*(1))
				guiSetText(GUIEditor.label[9], "Volume ("..guiScrollBarGetScrollPosition(GUIEditor.scrollbar[2]).."%):")
				volume = (guiScrollBarGetScrollPosition(GUIEditor.scrollbar[2])/100)*(1)
			end
		end, false)
		
		addEventHandler ("onClientGUIClick", GUIEditor.checkbox[2], function()
			if (GUIEditor.checkbox[2] == true) then 
				
			end 
		end, false)
    end
)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end


function nextSong ()
	if (isElement(playing)) then stopSound(playing) end
	local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
	local pid = guiGridListGetItemData(GUIEditor.gridlist[1], row, 1)
	
	if (row == 0) then 
		for u, theSongs in ipairs(browse) do 
			if (u >= lsid+1) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
		for u, theSongs in ipairs(browse) do 
			if (u == lsid) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
	elseif (row == 1) then 
		for u, theSongs in ipairs(radio) do 
			if (u >= lsid+1) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
		for u, theSongs in ipairs(radio) do 
			if (u == lsid) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
	else
		for u, theSongs in ipairs(songs) do 
			if (theSongs[2] == pid and theSongs[1] >= lsid+1) then 
				playSoundNow(theSongs[3], theSongs[5], theSongs[4])
				lsid = theSongs[1]
				return true
			end 
		end 
		for u, theSongs in ipairs(songs) do 
			if (theSongs[1] == lsid) then 
				playSoundNow(theSongs[3], theSongs[5], theSongs[4])
				lsid = theSongs[1]
				return true
			end 
		end 
	end
	
end 

function previousSong ()
	if (isElement(playing)) then stopSound(playing) end
	local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
	local pid = guiGridListGetItemData(GUIEditor.gridlist[1], row, 1)
	
	if (row == 0) then 
		for u, theSongs in ipairs(browse) do 
			if (u <= lsid+1) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
		for u, theSongs in ipairs(browse) do 
			if (u == lsid) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
	elseif (row == 1) then 
		for u, theSongs in ipairs(radio) do 
			if (u <= lsid+1) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
		for u, theSongs in ipairs(radio) do 
			if (u == lsid) then 
				playSoundNow(theSongs[1], theSongs[3], theSongs[2])
				lsid = u
				return true
			end 
		end 
	else 
		for u, theSongs in ipairs(songs) do 
			if (theSongs[2] == pid and theSongs[1] <= lsid-1) then 
				playSoundNow(theSongs[3], theSongs[5], theSongs[4])
				lsid = theSongs[1]
				return true
			end 
		end 
		for u, theSongs in ipairs(songs) do 
			if (theSongs[1] == lsid) then 
				playSoundNow(theSongs[3], theSongs[5], theSongs[4])
				return true
			end 
		end 
	end
end 

function onPlrStreamStop (r)
	if (r == "finished") then 
		destroyElement(playing)
		if (isTimer(panning)) then 
			killTimer(panning)
		end 
		if (guiCheckBoxGetSelected(GUIEditor.checkbox[2]) == true) then 
			local row = guiGridListGetSelectedItem (GUIEditor.gridlist[2])
			local row2 = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
			if (row2 == 2) then 
				for u, theSongs in ipairs(browse) do 
					if (u == lsid) then 
						playSoundNow(theSongs[1], theSongs[3], theSongs[2])
					end 
				end 
			elseif (row2 == 3) then 
				for u, theSongs in ipairs(radio) do 
					if (u == lsid) then 
						playSoundNow(theSongs[1], theSongs[3], theSongs[2])
					end 
				end 
			else
				for u, theSongs in ipairs(songs) do 
					if (theSongs[1] == lsid) then 
						stopSound(playing)
						destroyElement(playing)
						guiSetText(GUIEditor.label[2], "0:00")
						guiSetText(GUIEditor.label[3], "0:00")
						guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 0)
						playSoundNow(theSongs[3], theSongs[5], theSongs[4])
					end 
				end 
			end 
			
			return 
		end 
		if (guiCheckBoxGetSelected(GUIEditor.checkbox[1]) == true) then 
			local row = guiGridListGetSelectedItem (GUIEditor.gridlist[1])
			local pid = guiGridListGetItemData(GUIEditor.gridlist[1], row, 1)
			stopSound(playing)					
			guiSetText(GUIEditor.label[2], "0:00")
			guiSetText(GUIEditor.label[3], "0:00")
			local shuffle = {}
			for u, theSongs in ipairs(songs) do 
				if (theSongs[2] == pid) then 
					table.insert(shuffle, theSongs[1])
				end 
			end 
			local index = math.random(1,#shuffle)
			playSoundNow(songs[index][3], songs[index][5], songs[index][4])
			return 
		end 
		stopSound(playing)
		exports.AURstickynote:displayText("mplayer", "text", "", 15, 165, 0)
		guiSetText(GUIEditor.label[2], "0:00")
		guiSetText(GUIEditor.label[3], "0:00")
		guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 0)
		nextSong()
	elseif (r == "destroyed") then 
		destroyElement(playing)
		exports.AURstickynote:displayText("mplayer", "text", "", 15, 165, 0)
		if (isTimer(panning)) then 
			killTimer(panning)
		end 
		guiSetText(GUIEditor.label[2], "0:00")
		guiSetText(GUIEditor.label[3], "0:00")
		guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], 0)
	end 
end

local titleg = ""

function playSoundNow (title, url, mtype)
	if (isElement(playing)) then stopSound(playing) end
	if (mtype == "MP3 Link") then 
		playing = playSound(url, false, false)
		setSoundVolume(playing, volume)
		guiSetText(GUIEditor.label[1], "Now Playing:\n"..title)
		exports.NGCdxmsg:createNewDxMessage("Now playing: "..title, 0, 255, 0)
		titleg = title
	elseif (mtype == "Youtube Link") then 
		playing = playSound("https://yt-mp3.curtcreation.net/api/?play&id="..url, false, false)
		setSoundVolume(playing, volume)
		guiSetText(GUIEditor.label[1], "Now Playing:\n"..title)
		exports.NGCdxmsg:createNewDxMessage("Now playing: "..title, 0, 255, 0)
		titleg = title
	end 
end 
addEventHandler ("onClientSoundStopped", resourceRoot, onPlrStreamStop)

function onSoundStarted ( reason )
    if (reason == "play") then
        panning = setTimer(function()
			if (not isElement(playing)) then 
				killTimer(panning)
				return
			end 
			local row2 = guiGridListGetSelectedItem (GUIEditor.gridlist[1])			
			if (row2 == 1) then 
				local tTags = getSoundMetaTags (playing) 
				if tTags then 
					for tag, value in pairs (tTags) do 
						titleg = string.format('%s', value)
					end 
				end 
			end
			guiSetText(GUIEditor.label[2], round(getSoundPosition(playing)/60)..":"..string.format("%02d",round((getSoundPosition(playing)/60)%1*60)))
			exports.AURstickynote:displayText("mplayer", "text", "Now Playing: "..titleg.." ("..round(getSoundPosition(playing)/60)..":"..string.format("%02d",round((getSoundPosition(playing)/60)%1*60))..")", 15, 165, 0)
			guiSetText(GUIEditor.label[3], "-"..round((getSoundLength(playing)/60)-(getSoundPosition(playing)/60))..":"..((round(getSoundLength(playing)-getSoundPosition(playing)))/60)%1*60)
		end, 1000, 0)
		panning2 = setTimer(function()
			if (not isElement(playing)) then 
				killTimer(panning2)
				return
			end 
			if (type(getSoundPosition(playing)) == "number" and type(getSoundLength(playing))) then 
				local calc = (getSoundPosition(playing)/getSoundLength(playing))*100
				if (calc > 5) then 
					guiScrollBarSetScrollPosition(GUIEditor.scrollbar[1], calc)
				end
			end
			
		end, 4000, 0) 
    end 
end
addEventHandler ("onClientSoundStarted", resourceRoot, onSoundStarted)


local showCursorHandler
function openGUI ()
	if (guiGetVisible(GUIEditor.window[1])) == false then 
		guiSetVisible(GUIEditor.window[1], true)
		showCursor(true)
		showCursorHandler = setTimer(function()
			if (not isCursorShowing()) then 
				showCursor(true)
			end 
		end, 500, 0)
	else 
		guiSetVisible(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[2], false)
		if isTimer(showCursorHandler) then 
			killTimer(showCursorHandler)
		end 
		showCursor(false)
	end 
end 
addCommandHandler("mplayer", openGUI)