
windowPlrCnt = guiCreateWindow(389, 237, 482, 370, "AUR Player Count", false)
guiWindowSetMovable(windowPlrCnt, false)
guiSetAlpha(windowPlrCnt, 1.00)
image1 = guiCreateStaticImage(87, 24, 287, 104, ":AURplayercount/aur.png", false, windowPlrCnt)
gridList = guiCreateGridList(10, 138, 462, 184, false, windowPlrCnt)
guiGridListSetSelectionMode(gridList, 0)
plrstat = guiGridListAddColumn(gridList, "Statistic", 0.6)
plrcount = guiGridListAddColumn(gridList, "Player Count", 0.3)
guiGridListSetSortingEnabled(gridList, false)
 btnClose = guiCreateButton(161, 331, 159, 29, "Close GUI", false, windowPlrCnt)
        guiSetFont(btnClose, "default-bold-small")
        guiSetProperty(btnClose, "NormalTextColour", "FFFFFEFE")  
guiSetVisible(windowPlrCnt, false)
local gridData = {
  {
    id = 1,
    stat = "Locations",
    value = nil
  },
  {
    id = 2,
    stat = "LS Zone",
    value = 0
  },
  {
    id = 3,
    stat = "SF Zone",
    value = 0
  },
  {
    id = 4,
    stat = "LV Zone",
    value = 0
  },
  {
    id = 5,
    stat = "Team Count",
    value = nil
  },
  {
    id = 6,
    stat = "Staff",
    value = 0
  },
  {
    id = 7,
    stat = "Police",
    value = 0
  },
  {
    id = 8,
    stat = "Military Forces",
    value = 0
  },
  {
    id = 9,
    stat = "GIGN",
    value = 0
  },
  {
    id = 10,
    stat = "Unemployed",
    value = 0
  },
  {
    id = 11,
    stat = "Unoccupied",
    value = 0
  },
  {
    id = 12,
    stat = "Emergency Services",
    value = 0
  },
  {
    id = 13,
    stat = "Civilian Employees",
    value = 0
  },
  {
    id = 14,
    stat = "Hits",
    value = 0
  },
  {
    id = 15,
    stat = "Police Force",
    value = 0
  },
  {
    id = 16,
    stat = "Criminals",
    value = 0
  },
  {
    id = 17,
    stat = "Wanted Level",
    value = nil
  },
  {
    id = 18,
    stat = "0 Star",
    value = 0
  },
  {
    id = 19,
    stat = "1 to 6 Stars",
    value = 0
  },
  {
    id = 20,
    stat = "7 to 12 Stars",
    value = 0
  },
  {
    id = 21,
    stat = "13 to 18 Stars",
    value = 0
  },
  {
    id = 22,
    stat = "19 to 24 Stars",
    value = 0
  },
  {
    id = 23,
    stat = "25 to 30 Stars",
    value = 0
  },
  {
    id = 24,
    stat = "30 to 36 Stars",
    value = 0
  },
  {
    id = 25,
    stat = "Cash",
    value = nil
  },
  {
    id = 26,
    stat = "Under $10,000",
    value = 0
  },
  {
    id = 27,
    stat = "$10,000 to $100,000",
    value = 0
  },
  {
    id = 28,
    stat = "$100,000 to $500,000",
    value = 0
  },
  {
    id = 29,
    stat = "$500,000 to $1,000,000",
    value = 0
  },
  {
    id = 30,
    stat = "$1,000,000 to $2,500,000",
    value = 0
  },
  {
    id = 31,
    stat = "$2,500,000 and up",
    value = 0
  },
  {
    id = 32,
    stat = "Play Time",
    value = nil
  },
  {
    id = 33,
    stat = "Under 50 hours",
    value = 0
  },
  {
    id = 34,
    stat = "50 to 100 hours",
    value = 0
  },
  {
    id = 35,
    stat = "100 to 250 hours",
    value = 0
  },
  {
    id = 36,
    stat = "250 to 500 hours",
    value = 0
  },
  {
    id = 37,
    stat = "500 to 1000 hours",
    value = 0
  },
  {
    id = 38,
    stat = "1000 to 1500 hours",
    value = 0
  },
  {
    id = 39,
    stat = "1500 to 2500 hours",
    value = 0
  },
  {
    id = 40,
    stat = "Over 2500 hours",
    value = 0
  },
  {
    id = 41,
    stat = "Civilian Employment",
    value = nil
  },
  {
    id = 42,
    stat = "Bus Driver",
    value = 0
  },
  {
    id = 43,
    stat = "Trucker",
    value = 0
  },
  {
    id = 44,
    stat = "Fisherman",
    value = 0
  },
  {
    id = 45,
    stat = "Hooker",
    value = 0
  },
  {
    id = 46,
    stat = "Taxi Driver",
    value = 0
  },
  {
    id = 47,
    stat = "Mechanic",
    value = 0
  },
  {
    id = 48,
    stat = "Hobo",
    value = 0
  },
  {
    id = 49,
    stat = "Medic",
    value = 0
  },
  {
    id = 50,
    stat = "Pilot",
    value = 0
  },
  {
    id = 51,
    stat = "Serial Killer",
    value = 0
  },
  {
    id = 52,
    stat = "Trucker",
    value = 0
  },
  {
    id = 53,
    stat = "Street Cleaner",
    value = 0
  },
  {
    id = 54,
    stat = "Waste Collector",
    value = 0
  },
  {
    id = 55,
    stat = "Firefighter",
    value = 0
  },
  {
    id = 56,
    stat = "Sea Delivery Man",
    value = 0
  },
  {
    id = 57,
    stat = "Iron Miner",
    value = 0
  },
  {
    id = 58,
    stat = "Farmer",
    value = 0
  },
  {
    id = 59,
    stat = "Pizza Boy",
    value = 0
  },
  {
    id = 60,
    stat = "Fuel Tank Driver",
    value = 0
  },
  {
    id = 61,
    stat = "Official Groups",
    value = nil
  },
  {
    id = 62,
    stat = "SpecialForces",
    value = 0
  },
  {
    id = 63,
    stat = "Full_Of_Pain",
    value = 0
  },
  {
    id = 64,
    stat = "RXnGaming",
    value = 0
  },
  {
    id = 65,
    stat = "SWATTeam",
    value = 0
  },
  {
    id = 66,
    stat = "FBI",
    value = 0
  },
}
for k, v in ipairs(gridData) do
  local stat = gridData[k].stat
  local value = gridData[k].value
  if value == nil then
    local row = guiGridListAddRow(gridList)
    guiGridListSetItemText(gridList, row, plrstat, stat, true, false)
  else
    value = tostring(value)
    local row = guiGridListAddRow(gridList)
    guiGridListSetItemText(gridList, row, plrstat, stat, false, false)
    guiGridListSetItemText(gridList, row, plrcount, value, false, false)
  end
end
function clearGridData()
  for k, v in ipairs(gridData) do
    local value = gridData[k].value
    if value ~= nil then
      gridData[k].value = 0
    end
  end
end
function setGUIData(command)
  clearGridData()
  for k, player in ipairs(getElementsByType("player")) do
    local zone = getElementData(player, "z")
    if zone then
      if zone == "LS" then
        gridData[2].value = gridData[2].value + 1
      elseif zone == "SF" then
        gridData[3].value = gridData[3].value + 1
      elseif zone == "LV" then
        gridData[4].value = gridData[4].value + 1
      end
    end
    local teaam = getPlayerTeam(player)
    if teaam then
      local team = getTeamName(teaam)
      if team == "Staff" then
        gridData[6].value = gridData[6].value + 1
      elseif team == "Government" then
        gridData[7].value = gridData[7].value + 1
      elseif team == "Armed Forces" then
        gridData[8].value = gridData[8].value + 1
      elseif team == "SWAT Team" then
        gridData[9].value = gridData[9].value + 1
      elseif team == "Unemployed" then
        gridData[10].value = gridData[10].value + 1
      elseif team == "Unoccupied" then
        gridData[11].value = gridData[11].value + 1
      elseif team == "Emergency Services" then
        gridData[12].value = gridData[12].value + 1
      elseif team == "Civilian Workers" then
        gridData[13].value = gridData[13].value + 1
      elseif team == "Gangsters" then
        gridData[14].value = gridData[14].value + 1
      elseif team == "Police Service" then
        gridData[15].value = gridData[15].value + 1
      elseif team == "Criminals" then
        gridData[16].value = gridData[16].value + 1
      end
    end
    local wanted = tonumber(getElementData(player, "CSTpolice.wantedStars")) or 0
    if wanted then
      if wanted == 0 then
        gridData[18].value = gridData[18].value + 1
      elseif wanted <= 6 then
        gridData[19].value = gridData[19].value + 1
      elseif wanted <= 12 and wanted > 6 then
        gridData[20].value = gridData[20].value + 1
      elseif wanted <= 18 and wanted > 12 then
        gridData[21].value = gridData[21].value + 1
      elseif wanted <= 24 and wanted > 18 then
        gridData[22].value = gridData[22].value + 1
      elseif wanted <= 30 and wanted > 24 then
        gridData[23].value = gridData[23].value + 1
      elseif wanted <= 36 and wanted > 30 then
        gridData[24].value = gridData[24].value + 1
      end
    end
    local cash = getElementData(player,"c")
    if cash then
      cash = tonumber(cash)
      if cash < 10000 then
        gridData[26].value = gridData[26].value + 1
      elseif cash >= 10000 and cash < 100000 then
        gridData[27].value = gridData[27].value + 1
      elseif cash >= 100000 and cash < 500000 then
        gridData[28].value = gridData[28].value + 1
      elseif cash >= 500000 and cash < 1000000 then
        gridData[29].value = gridData[29].value + 1
      elseif cash >= 1000000 and cash < 2500000 then
        gridData[30].value = gridData[30].value + 1
      elseif cash >= 2500000 then
        gridData[31].value = gridData[31].value + 1
      end
    end
    local playtime = getElementData(player, "CSTmisc.playTime") or "N/A"
    local playtime = string.gsub(playtime, "[a-z, A-Z]", "")
    local playtime = tonumber(playtime)
    if playtime then
      if playtime < 50 then
        gridData[33].value = gridData[33].value + 1
      elseif playtime >= 50 and playtime < 100 then
        gridData[34].value = gridData[34].value + 1
      elseif playtime >= 100 and playtime < 250 then
        gridData[35].value = gridData[35].value + 1
      elseif playtime >= 250 and playtime < 500 then
        gridData[36].value = gridData[36].value + 1
      elseif playtime >= 500 and playtime < 1000 then
        gridData[37].value = gridData[37].value + 1
      elseif playtime >= 1000 and playtime < 1500 then
        gridData[38].value = gridData[38].value + 1
      elseif playtime >= 1500 and playtime < 2500 then
        gridData[39].value = gridData[39].value + 1
      elseif playtime >= 2500 then
        gridData[40].value = gridData[40].value + 1
      end
    end
    local job = getElementData(player, "Occupation")
    if job then
      if job == "Bus Driver" then
        gridData[42].value = gridData[42].value + 1
      elseif job == "Trucker" then
        gridData[43].value = gridData[43].value + 1
      elseif job == "Fisherman" then
        gridData[44].value = gridData[44].value + 1
      elseif job == "Hooker" then
        gridData[45].value = gridData[45].value + 1
      elseif job == "Taxi Driver" then
        gridData[46].value = gridData[46].value + 1
      elseif job == "Mechanic" then
        gridData[47].value = gridData[47].value + 1
      elseif job == "Hobo" then
        gridData[48].value = gridData[48].value + 1
      elseif job == "Medic" then
        gridData[49].value = gridData[49].value + 1
      elseif job == "Pilot" then
        gridData[50].value = gridData[50].value + 1
      elseif job == "Taxi Driver" then
        gridData[51].value = gridData[51].value + 1
      elseif job == "Trucker" then
        gridData[52].value = gridData[52].value + 1
      elseif job == "Street Cleaner" then
        gridData[53].value = gridData[53].value + 1
      elseif job == "Waste Collector" then
        gridData[54].value = gridData[54].value + 1
      elseif job == "Firefighter" then
        gridData[55].value = gridData[55].value + 1
      elseif job == "Sea Delivery Man" then
        gridData[56].value = gridData[56].value + 1
      elseif job == "Iron Miner" then
        gridData[57].value = gridData[57].value + 1
      elseif job == "Farmer" then
        gridData[58].value = gridData[58].value + 1
      elseif job == "Pizza Boy" then
        gridData[59].value = gridData[59].value + 1
      elseif job == "Fuel Tank Driver" then
        gridData[60].value = gridData[60].value + 1
      elseif job == "SpecialForces" then
        gridData[62].value = gridData[62].value + 1
      elseif job == "Full_Of_Pain" then
        gridData[63].value = gridData[63].value + 1
      elseif job == "RXnGaming" then
        gridData[64].value = gridData[64].value + 1
      elseif job == "SWATTeam" then
        gridData[65].value = gridData[65].value + 1
      elseif job == "FBI" then
        gridData[66].value = gridData[65].value + 1
      end
    end
    guiGridListClear(gridList)
    for k, v in ipairs(gridData) do
      local stat = gridData[k].stat
      local value = gridData[k].value
      if value == nil then
        local row = guiGridListAddRow(gridList)
        guiGridListSetItemText(gridList, row, plrstat, stat, true, false)
      else
        value = tostring(value)
        local row = guiGridListAddRow(gridList)
        guiGridListSetItemText(gridList, row, plrstat, stat, false, false)
        guiGridListSetItemText(gridList, row, plrcount, value, false, false)
      end
    end
    guiSetVisible(windowPlrCnt, true)
    showCursor(true)
  end
end
addCommandHandler("playercount", setGUIData)
function closeGUI(button, state)
  if button == "left" and state == "up" and source ~= windowPlrCnt then
    guiSetVisible(windowPlrCnt, false)
    showCursor(false)
  end
end
addEventHandler("onClientGUIClick", btnClose, closeGUI)
