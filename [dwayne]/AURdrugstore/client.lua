
------------------------------------------------------------------------------------
--  For NGC Server
--  Verson 1.0.0
--  CSGsmithsDrugStore/client (client-side)
--  Drug Store Script
--  [CSG]Smith
------------------------------------------------------------------------------------

crash = {{{{{{{{ {}, {}, {} }}}}}}}}
CSG_DrugStore = guiCreateWindow(376,59,551,500,"AUR ~ Drug Store",false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(CSG_DrugStore,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(CSG_DrugStore,x,y,false)
	CSG_DrugStore_img_ritalin = guiCreateStaticImage(40,50,110,86,"Images/ritalin.png",false,CSG_DrugStore)
	CSG_DrugStore_combo_ritalin = guiCreateComboBox(30,173,58,120,"100",false,CSG_DrugStore)
		guiComboBoxAddItem ( CSG_DrugStore_combo_ritalin, "100")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ritalin, "500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ritalin, "1000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ritalin, "1500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ritalin, "2000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ritalin, "3000")
	CSG_DrugStore_btn_ritalin = guiCreateButton(90,174,62,22,"Buy",false,CSG_DrugStore)
	CSG_DrugStore_lbl_ritalin = guiCreateLabel(64,135,54,20,"RITALIN",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_ritalin,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_ritalin,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_ritalin,"center",false)
		guiSetFont(CSG_DrugStore_lbl_ritalin,"default-bold-small")
	CSG_DrugStore_lbl_ritalinp = guiCreateLabel(62,153,54,20,"$ 100",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_ritalinp,0,255,0)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_ritalinp,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_ritalinp,"center",false)
		guiSetFont(CSG_DrugStore_lbl_ritalinp,"default-bold-small")

	CSG_DrugStore_img_weed = guiCreateStaticImage(227,50,110,86,"Images/weed.png",false,CSG_DrugStore)
	CSG_DrugStore_combo_weed = guiCreateComboBox(217,173,58,120,"100",false,CSG_DrugStore)
		guiComboBoxAddItem ( CSG_DrugStore_combo_weed, "100")
		guiComboBoxAddItem ( CSG_DrugStore_combo_weed, "500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_weed, "1000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_weed, "1500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_weed, "2000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_weed, "3000")
	CSG_DrugStore_btn_weed = guiCreateButton(277,174,62,22,"Buy",false,CSG_DrugStore)
	CSG_DrugStore_lbl_weed = guiCreateLabel(249,135,54,20,"WEED",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_weed,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_weed,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_weed,"center",false)
		guiSetFont(CSG_DrugStore_lbl_weed,"default-bold-small")
	CSG_DrugStore_lbl_weedp = guiCreateLabel(249,153,54,20,"$ 100",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_weedp,0,255,0)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_weedp,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_weedp,"center",false)
		guiSetFont(CSG_DrugStore_lbl_weedp,"default-bold-small")

	CSG_DrugStore_img_lsd = guiCreateStaticImage(414,50,110,86,"Images/lsd.png",false,CSG_DrugStore)
	CSG_DrugStore_combo_lsd = guiCreateComboBox(404,173,58,120,"100",false,CSG_DrugStore)
		guiComboBoxAddItem ( CSG_DrugStore_combo_lsd, "100")
		guiComboBoxAddItem ( CSG_DrugStore_combo_lsd, "500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_lsd, "1000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_lsd, "1500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_lsd, "2000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_lsd, "3000")
	CSG_DrugStore_btn_lsd = guiCreateButton(464,174,62,22,"Buy",false,CSG_DrugStore)
	CSG_DrugStore_lbl_lsd = guiCreateLabel(440,135,54,20,"LSD",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_lsd,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_lsd,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_lsd,"center",false)
		guiSetFont(CSG_DrugStore_lbl_lsd,"default-bold-small")
	CSG_DrugStore_lbl_lsdp = guiCreateLabel(440,153,54,20,"$ 100",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_lsdp,0,255,0)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_lsdp,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_lsdp,"center",false)
		guiSetFont(CSG_DrugStore_lbl_lsdp,"default-bold-small")

	CSG_DrugStore_img_cocaine = guiCreateStaticImage(40,264,110,86,"Images/cocaine.png",false,CSG_DrugStore)
	CSG_DrugStore_combo_cocaine = guiCreateComboBox(30,388,58,120,"100",false,CSG_DrugStore)
		guiComboBoxAddItem ( CSG_DrugStore_combo_cocaine, "100")
		guiComboBoxAddItem ( CSG_DrugStore_combo_cocaine, "500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_cocaine, "1000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_cocaine, "1500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_cocaine, "2000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_cocaine, "3000")
	CSG_DrugStore_btn_cocaine = guiCreateButton(88,388,62,24,"Buy",false,CSG_DrugStore)
	CSG_DrugStore_lbl_cocaine = guiCreateLabel(64,349,54,20,"COCAINE",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_cocaine,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_cocaine,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_cocaine,"center",false)
		guiSetFont(CSG_DrugStore_lbl_cocaine,"default-bold-small")
	CSG_DrugStore_lbl_cocainep = guiCreateLabel(62,367,54,20,"$ 100",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_cocainep,0,255,0)
		guiLabelSetVerticalAlign(CSG_DrugStore_lbl_cocainep,"center")
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_cocainep,"center",false)
		guiSetFont(CSG_DrugStore_lbl_cocainep,"default-bold-small")

	CSG_DrugStore_img_ecstasy = guiCreateStaticImage(227,264,110,86,"Images/ecstasy.png",false,CSG_DrugStore)
	CSG_DrugStore_combo_ecstasy = guiCreateComboBox(217,388,58,120,"100",false,CSG_DrugStore)
		guiComboBoxAddItem ( CSG_DrugStore_combo_ecstasy, "100")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ecstasy, "500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ecstasy, "1000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ecstasy, "1500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ecstasy, "2000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_ecstasy, "3000")
	CSG_DrugStore_btn_ecstasy = guiCreateButton(277,388,62,24,"Buy",false,CSG_DrugStore)
	CSG_DrugStore_lbl_ecstatsy = guiCreateLabel(249,349,54,20,"ECSTASY",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_ecstatsy,255,255,255)
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_ecstatsy,"center",false)
		guiSetFont(CSG_DrugStore_lbl_ecstatsy,"default-bold-small")
	CSG_DrugStore_lbl_ecstatsyp = guiCreateLabel(249,367,54,20,"$ 100",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_ecstatsyp,0,255,0)
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_ecstatsyp,"center",false)
		guiSetFont(CSG_DrugStore_lbl_ecstatsyp,"default-bold-small")

	CSG_DrugStore_img_heroine = guiCreateStaticImage(414,264,110,86,"Images/heroine.png",false,CSG_DrugStore)
	CSG_DrugStore_combo_heroine = guiCreateComboBox(404,388,58,120,"100",false,CSG_DrugStore)
		guiComboBoxAddItem ( CSG_DrugStore_combo_heroine, "100")
		guiComboBoxAddItem ( CSG_DrugStore_combo_heroine, "500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_heroine, "1000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_heroine, "1500")
		guiComboBoxAddItem ( CSG_DrugStore_combo_heroine, "2000")
		guiComboBoxAddItem ( CSG_DrugStore_combo_heroine, "3000")
	CSG_DrugStore_btn_heroine = guiCreateButton(464,388,62,20,"Buy",false,CSG_DrugStore)
	CSG_DrugStore_lbl_heroine = guiCreateLabel(440,349,54,26,"HEROINE",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_heroine,255,255,255)
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_heroine,"center",false)
		guiSetFont(CSG_DrugStore_lbl_heroine,"default-bold-small")
	CSG_DrugStore_lbl_heroinep = guiCreateLabel(440,367,54,20,"$ 100",false,CSG_DrugStore)
		guiLabelSetColor(CSG_DrugStore_lbl_heroinep,0,255,0)
		guiLabelSetHorizontalAlign(CSG_DrugStore_lbl_heroinep,"center",false)
		guiSetFont(CSG_DrugStore_lbl_heroinep,"default-bold-small")

	CSG_DrugStore_btn_info = guiCreateButton(215.5,442,121,20,"Informations",false,CSG_DrugStore)
	CSG_DrugStore_btn_close = guiCreateButton(215.5,467,121,23,"Close Window",false,CSG_DrugStore)
guiSetAlpha(CSG_DrugStore,0.9)
guiWindowSetSizable(CSG_DrugStore,false)
guiSetVisible(CSG_DrugStore,false)
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
CSG_DrugStore_Info = guiCreateWindow(942,62,312,371,"Drugs Information",false)
	CSG_DrugStore_Info_ritalin = guiCreateLabel(17,30,80,24,"Ritalin",false,CSG_DrugStore_Info)
		guiLabelSetColor(CSG_DrugStore_Info_ritalin,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Info_ritalin,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Info_ritalin,"left",false)
		guiSetFont(CSG_DrugStore_Info_ritalin,"default-bold-small")

		CSG_DrugStore_Info_ritalin_info = guiCreateLabel(69,30,226,44,"By taking this drug you are able to move faster than normal.",false,CSG_DrugStore_Info)
			guiLabelSetColor(CSG_DrugStore_Info_ritalin_info,255,255,255)
			guiLabelSetVerticalAlign(CSG_DrugStore_Info_ritalin_info,"top")
			guiLabelSetHorizontalAlign(CSG_DrugStore_Info_ritalin_info,"left",true)

	CSG_DrugStore_Info_weed = guiCreateLabel(18,80,83,27,"Weed",false,CSG_DrugStore_Info)
		guiLabelSetColor(CSG_DrugStore_Info_weed,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Info_weed,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Info_weed,"left",false)
		guiSetFont(CSG_DrugStore_Info_weed,"default-bold-small")

		CSG_DrugStore_Info_weed_info = guiCreateLabel(69,79,226,36,"By taking this drug you will move slowly, jump higher etc.",false,CSG_DrugStore_Info)
			guiLabelSetColor(CSG_DrugStore_Info_weed_info,255,255,255)
			guiLabelSetVerticalAlign(CSG_DrugStore_Info_weed_info,"top")
			guiLabelSetHorizontalAlign(CSG_DrugStore_Info_weed_info,"left",true)

	CSG_DrugStore_Info_lsd = guiCreateLabel(19,130,83,27,"Lsd",false,CSG_DrugStore_Info)
		guiLabelSetColor(CSG_DrugStore_Info_lsd,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Info_lsd,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Info_lsd,"left",false)
		guiSetFont(CSG_DrugStore_Info_lsd,"default-bold-small")

		CSG_DrugStore_Info_lsd_info = guiCreateLabel(71,128,229,47,"By taking this drug you will get some special effect in-game (Client Side Only!).",false,CSG_DrugStore_Info)
			guiLabelSetColor(CSG_DrugStore_Info_lsd_info,255,255,255)
			guiLabelSetVerticalAlign(CSG_DrugStore_Info_lsd_info,"top")
			guiLabelSetHorizontalAlign(CSG_DrugStore_Info_lsd_info,"left",true)

	CSG_DrugStore_Info_cocaine = guiCreateLabel(21,179,83,27,"Cocaine",false,CSG_DrugStore_Info)
		guiLabelSetColor(CSG_DrugStore_Info_cocaine,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Info_cocaine,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Info_cocaine,"left",false)
		guiSetFont(CSG_DrugStore_Info_cocaine,"default-bold-small")

		CSG_DrugStore_Info_cocaine_info = guiCreateLabel(72,178,223,26,"You take randomly one of aviable drugs.",false,CSG_DrugStore_Info)
			guiLabelSetColor(CSG_DrugStore_Info_cocaine_info,255,255,255)
			guiLabelSetVerticalAlign(CSG_DrugStore_Info_cocaine_info,"top")
			guiLabelSetHorizontalAlign(CSG_DrugStore_Info_cocaine_info,"left",false)

	CSG_DrugStore_Info_ecstasy = guiCreateLabel(21,218,83,27,"Ecstasy",false,CSG_DrugStore_Info)
		guiLabelSetColor(CSG_DrugStore_Info_ecstasy,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Info_ecstasy,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Info_ecstasy,"left",false)
		guiSetFont(CSG_DrugStore_Info_ecstasy,"default-bold-small")

		CSG_DrugStore_Info_ecstasy_info = guiCreateLabel(71,220,230,53,"By taking this drug will increase your health bar from 100% to 200%.",false,CSG_DrugStore_Info)
			guiLabelSetColor(CSG_DrugStore_Info_ecstasy_info,255,255,255)
			guiLabelSetVerticalAlign(CSG_DrugStore_Info_ecstasy_info,"top")
			guiLabelSetHorizontalAlign(CSG_DrugStore_Info_ecstasy_info,"left",true)

	CSG_DrugStore_Info_heroine = guiCreateLabel(22,271,83,27,"Heroine",false,CSG_DrugStore_Info)
		guiLabelSetColor(CSG_DrugStore_Info_heroine,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Info_heroine,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Info_heroine,"left",false)
		guiSetFont(CSG_DrugStore_Info_heroine,"default-bold-small")

		CSG_DrugStore_Info_heroine_info = guiCreateLabel(70,273,230,53,"By taking this drug you will get x2 lower demages than normal. This won't take effect while you have armor.",false,CSG_DrugStore_Info)
			guiLabelSetColor(CSG_DrugStore_Info_heroine_info,255,255,255)
			guiLabelSetVerticalAlign(CSG_DrugStore_Info_heroine_info,"top")
			guiLabelSetHorizontalAlign(CSG_DrugStore_Info_heroine_info,"left",true)
CSG_DrugStore_Info_btnclose = guiCreateButton(78,342,142,20,"Close",false,CSG_DrugStore_Info)
guiWindowSetSizable(CSG_DrugStore_Info,false)
guiWindowSetSizable(CSG_DrugStore_Info,false)
guiSetVisible(CSG_DrugStore_Info,false)
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
CSG_DrugStore_Settings = guiCreateWindow(21,200,339,232,"NGC ~ Drug Store Settings",false)
	CSG_DrugStore_Settings_lbl_ritalin = guiCreateLabel(2,40,60,14,"Ritalin",false,CSG_DrugStore_Settings)
		guiLabelSetColor(CSG_DrugStore_Settings_lbl_ritalin,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Settings_lbl_ritalin,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Settings_lbl_ritalin,"right",false)
		guiSetFont(CSG_DrugStore_Settings_lbl_ritalin,"default-bold-small")

		CSG_DrugStore_Settings_lbl_ritalinp = guiCreateLabel(90,40,40,14,"$ 120 /",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_ritalinp,0,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_ritalinp,"default-bold-small")
		CSG_DrugStore_Settings_lbl_ritalin_prize = guiCreateLabel(140,40,40,14,"$ 100",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_ritalin_prize,255,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_ritalin_prize,"default-bold-small")

	CSG_DrugStore_Settings_lbl_weed = guiCreateLabel(2,62,60,14,"WEED",false,CSG_DrugStore_Settings)
		guiLabelSetColor(CSG_DrugStore_Settings_lbl_weed,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Settings_lbl_weed,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Settings_lbl_weed,"right",false)
		guiSetFont(CSG_DrugStore_Settings_lbl_weed,"default-bold-small")

		CSG_DrugStore_Settings_lbl_weedp = guiCreateLabel(90,62,40,14,"$ 160 /",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_weedp,0,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_weedp,"default-bold-small")
		CSG_DrugStore_Settings_lbl_weed_prize = guiCreateLabel(140,62,40,14,"$ 100",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_weed_prize,255,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_weed_prize,"default-bold-small")

	CSG_DrugStore_Settings_lbl_lsd = guiCreateLabel(2,84,60,14,"LSD",false,CSG_DrugStore_Settings)
		guiLabelSetColor(CSG_DrugStore_Settings_lbl_lsd,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Settings_lbl_lsd,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Settings_lbl_lsd,"right",false)
		guiSetFont(CSG_DrugStore_Settings_lbl_lsd,"default-bold-small")

		CSG_DrugStore_Settings_lbl_lsdp = guiCreateLabel(95,84,40,14,"$ 80 /",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_lsdp,0,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_lsdp,"default-bold-small")
		CSG_DrugStore_Settings_lbl_lsd_prize = guiCreateLabel(140,84,40,14,"$ 100",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_lsd_prize,255,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_lsd_prize,"default-bold-small")

	CSG_DrugStore_Settings_lbl_cocaine = guiCreateLabel(2,106,60,14,"Cocaine",false,CSG_DrugStore_Settings)
		guiLabelSetColor(CSG_DrugStore_Settings_lbl_cocaine,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Settings_lbl_cocaine,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Settings_lbl_cocaine,"right",false)
		guiSetFont(CSG_DrugStore_Settings_lbl_cocaine,"default-bold-small")

		CSG_DrugStore_Settings_lbl_cocainep = guiCreateLabel(95,106,40,14,"$ 90 /",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_cocainep,0,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_cocainep,"default-bold-small")
		CSG_DrugStore_Settings_lbl_cocaine_prize = guiCreateLabel(140,106,40,14,"$ 100",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_cocaine_prize,255,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_cocaine_prize,"default-bold-small")

	CSG_DrugStore_Settings_lbl_ecstasy = guiCreateLabel(2,128,60,14,"Ecstasy",false,CSG_DrugStore_Settings)
		guiLabelSetColor(CSG_DrugStore_Settings_lbl_ecstasy,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Settings_lbl_ecstasy,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Settings_lbl_ecstasy,"right",false)
		guiSetFont(CSG_DrugStore_Settings_lbl_ecstasy,"default-bold-small")

		CSG_DrugStore_Settings_lbl_ecstasyp = guiCreateLabel(90,128,40,14,"$ 100 /",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_ecstasyp,0,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_ecstasyp,"default-bold-small")
		CSG_DrugStore_Settings_lbl_ecstasy_prize = guiCreateLabel(140,128,40,14,"$ 100",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_ecstasy_prize,255,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_ecstasy_prize,"default-bold-small")

	CSG_DrugStore_Settings_lbl_heroine = guiCreateLabel(2,150,60,14,"Heroine",false,CSG_DrugStore_Settings)
		guiLabelSetColor(CSG_DrugStore_Settings_lbl_heroine,255,255,255)
		guiLabelSetVerticalAlign(CSG_DrugStore_Settings_lbl_heroine,"top")
		guiLabelSetHorizontalAlign(CSG_DrugStore_Settings_lbl_heroine,"right",false)
		guiSetFont(CSG_DrugStore_Settings_lbl_heroine,"default-bold-small")

		CSG_DrugStore_Settings_lbl_heroinep = guiCreateLabel(90,150,40,14,"$ 110 /",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_heroinep,0,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_heroinep,"default-bold-small")
		CSG_DrugStore_Settings_lbl_heroine_prize = guiCreateLabel(140,150,40,14,"$ 100",false,CSG_DrugStore_Settings)
			guiLabelSetColor(CSG_DrugStore_Settings_lbl_heroine_prize,255,255,0)
			guiSetFont(CSG_DrugStore_Settings_lbl_heroine_prize,"default-bold-small")

	CSG_DrugStore_Settings_edit_ritalin = guiCreateEdit(195,40,55,18,"",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_edit_weed = guiCreateEdit(195,62,55,18,"",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_edit_lsd = guiCreateEdit(195,84,55,18,"",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_edit_cocaine = guiCreateEdit(195,106,55,18,"",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_edit_ecstasy = guiCreateEdit(195,128,55,18,"",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_edit_heroine = guiCreateEdit(195,150,55,18,"",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_ritalin = guiCreateButton(255,40,60,18,"Set",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_weed = guiCreateButton(255,62,60,18,"Set",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_lsd = guiCreateButton(255,84,60,18,"Set",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_cocaine = guiCreateButton(255,106,60,18,"Set",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_ecstasy = guiCreateButton(255,128,60,18,"Set",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_heroine = guiCreateButton(255,150,60,18,"Set",false,CSG_DrugStore_Settings)
	CSG_DrugStore_Settings_btn_close = guiCreateButton(93,196,158,21,"Close",false,CSG_DrugStore_Settings)

guiWindowSetSizable(CSG_DrugStore_Settings,false)
guiWindowSetSizable(CSG_DrugStore_Settings,false)
guiSetVisible(CSG_DrugStore_Settings,false)

function setPrizeData(ritalin,weed,lsd,cocaine,ecstasy,heroine)
	guiSetText ( CSG_DrugStore_lbl_ritalinp, "$ "..ritalin )
	guiSetText ( CSG_DrugStore_lbl_weedp,  "$ "..weed )
	guiSetText ( CSG_DrugStore_lbl_lsdp,  "$ "..lsd )
	guiSetText ( CSG_DrugStore_lbl_cocainep,  "$ "..cocaine )
	guiSetText ( CSG_DrugStore_lbl_ecstatsyp,  "$ "..ecstasy )
	guiSetText ( CSG_DrugStore_lbl_heroinep,  "$ "..heroine )

	guiSetText ( CSG_DrugStore_Settings_lbl_ritalin_prize, "$ "..ritalin )
	guiSetText ( CSG_DrugStore_Settings_lbl_weed_prize,  "$ "..weed )
	guiSetText ( CSG_DrugStore_Settings_lbl_lsd_prize,  "$ "..lsd )
	guiSetText ( CSG_DrugStore_Settings_lbl_cocaine_prize,  "$ "..cocaine )
	guiSetText ( CSG_DrugStore_Settings_lbl_ecstasy_prize,  "$ "..ecstasy )
	guiSetText ( CSG_DrugStore_Settings_lbl_heroine_prize,  "$ "..heroine )
end


function close_all_windows( thePlayer )
    guiSetVisible(CSG_DrugStore, false)
	showCursor(false)
end
addEvent( "close_all_windows", true )
addEventHandler( "close_all_windows", getRootElement(), close_all_windows )
------------------------------------------------------------------------------------
function DrugStoreShop ( ritalin,weed,lsd,cocaine,ecstasy,heroine )
    guiSetVisible(CSG_DrugStore, not guiGetVisible(CSG_DrugStore))
	showCursor(not isCursorShowing())
	setPrizeData(ritalin,weed,lsd,cocaine,ecstasy,heroine)
end
addEvent( "DrugStoreShop", true )
addEventHandler( "DrugStoreShop", getRootElement(), DrugStoreShop )

function refreshDrugPrizes ( ritalin,weed,lsd,cocaine,ecstasy,heroine )
	setPrizeData(ritalin,weed,lsd,cocaine,ecstasy,heroine)
end
addEvent( "refreshDrugPrizes", true )
addEventHandler( "refreshDrugPrizes", getRootElement(), refreshDrugPrizes )


function DrugStoreShop_Settings ( ritalin,weed,lsd,cocaine,ecstasy,heroine )
    guiSetVisible(CSG_DrugStore_Settings, not guiGetVisible(CSG_DrugStore_Settings))
	showCursor(not isCursorShowing())
	setPrizeData(ritalin,weed,lsd,cocaine,ecstasy,heroine)
end
addEvent( "DrugStoreShop_Settings", true )
addEventHandler( "DrugStoreShop_Settings", getRootElement(), DrugStoreShop_Settings )


addEventHandler( "onClientGUIClick", getRootElement(),
function()
	if source == CSG_DrugStore_btn_close then
		guiSetVisible(CSG_DrugStore, false)
		showCursor(false)
		if (guiGetVisible(CSG_DrugStore_Info) == true) then
			guiSetVisible(CSG_DrugStore_Info, false)
		end
	elseif source == CSG_DrugStore_Settings_btn_close then
		guiSetVisible(CSG_DrugStore_Settings, false)
		showCursor(false)
	elseif source == CSG_DrugStore_Info_btnclose then
		guiSetVisible(CSG_DrugStore_Info, false)
	elseif source == CSG_DrugStore_btn_info then
		guiSetVisible(CSG_DrugStore_Info, not guiGetVisible(CSG_DrugStore_Info))
	elseif source == CSG_DrugStore_btn_ritalin then
		local hits = guiComboBoxGetItemText(CSG_DrugStore_combo_ritalin, guiComboBoxGetSelected(CSG_DrugStore_combo_ritalin))
		triggerServerEvent ( "dStoreTrigger", localPlayer, localPlayer,"Ritalin",hits )
	elseif source == CSG_DrugStore_btn_weed then
		hits = guiComboBoxGetItemText(CSG_DrugStore_combo_weed, guiComboBoxGetSelected(CSG_DrugStore_combo_weed))
		triggerServerEvent ( "dStoreTrigger", localPlayer, localPlayer,"Weed",hits )
	elseif source == CSG_DrugStore_btn_lsd then
		hits = guiComboBoxGetItemText(CSG_DrugStore_combo_lsd, guiComboBoxGetSelected(CSG_DrugStore_combo_lsd))
		triggerServerEvent ( "dStoreTrigger", localPlayer, localPlayer,"Lsd",hits )
	elseif source == CSG_DrugStore_btn_cocaine then
		hits = guiComboBoxGetItemText(CSG_DrugStore_combo_cocaine, guiComboBoxGetSelected(CSG_DrugStore_combo_cocaine))
		triggerServerEvent ( "dStoreTrigger", localPlayer, localPlayer,"Cocaine",hits )
	elseif source == CSG_DrugStore_btn_ecstasy then
		hits = guiComboBoxGetItemText(CSG_DrugStore_combo_ecstasy, guiComboBoxGetSelected(CSG_DrugStore_combo_ecstasy))
		triggerServerEvent ( "dStoreTrigger", localPlayer, localPlayer,"Ecstasy",hits )
	elseif source == CSG_DrugStore_btn_heroine then
		hits = guiComboBoxGetItemText(CSG_DrugStore_combo_heroine, guiComboBoxGetSelected(CSG_DrugStore_combo_heroine))
		triggerServerEvent ( "dStoreTrigger", localPlayer, localPlayer,"Heroine",hits )
	elseif source == CSG_DrugStore_Settings_btn_ritalin then
		if (guiGetText(CSG_DrugStore_Settings_edit_ritalin) ~= "") then
			text = guiGetText(CSG_DrugStore_Settings_edit_ritalin)
			triggerServerEvent ( "updateDrugPrize", getRootElement(),"Ritalin",text )
		else
			outputChatBox("You have to fill the editBox to be able to set the prize!",localPlayer,240,0,0,true)
		end
	elseif source == CSG_DrugStore_Settings_btn_weed then
		if (guiGetText(CSG_DrugStore_Settings_edit_weed) ~= "") then
			text = guiGetText(CSG_DrugStore_Settings_edit_weed)
			triggerServerEvent ( "updateDrugPrize", getRootElement(),"Weed",text )
		else
			outputChatBox("You have to fill the editBox to be able to set the prize!",localPlayer,240,0,0,true)
		end
	elseif source == CSG_DrugStore_Settings_btn_lsd then
		if (guiGetText(CSG_DrugStore_Settings_edit_lsd) ~= "") then
			text = guiGetText(CSG_DrugStore_Settings_edit_lsd)
			triggerServerEvent ( "updateDrugPrize", getRootElement(),"Lsd",text )
		else
			outputChatBox("You have to fill the editBox to be able to set the prize!",localPlayer,240,0,0,true)
		end
	elseif source == CSG_DrugStore_Settings_btn_cocaine then
		if (guiGetText(CSG_DrugStore_Settings_edit_cocaine) ~= "") then
			text = guiGetText(CSG_DrugStore_Settings_edit_cocaine)
			triggerServerEvent ( "updateDrugPrize", getRootElement(),"Cocaine",text )
		else
			outputChatBox("You have to fill the editBox to be able to set the prize!",localPlayer,240,0,0,true)
		end
	elseif source == CSG_DrugStore_Settings_btn_ecstasy then
		if (guiGetText(CSG_DrugStore_Settings_edit_ecstasy) ~= "") then
			text = guiGetText(CSG_DrugStore_Settings_edit_ecstasy)
			triggerServerEvent ( "updateDrugPrize", getRootElement(),"Ecstasy",text )
		else
			outputChatBox("You have to fill the editBox to be able to set the prize!",localPlayer,240,0,0,true)
		end
	elseif source == CSG_DrugStore_Settings_btn_heroine then
		if (guiGetText(CSG_DrugStore_Settings_edit_heroine) ~= "") then
			text = guiGetText(CSG_DrugStore_Settings_edit_heroine)
			triggerServerEvent ( "updateDrugPrize", getRootElement(),"Heroine",text )
		else
			outputChatBox("You have to fill the editBox to be able to set the prize!",localPlayer,240,0,0,true)
		end
	end
end)


--blip = createBlip(-1939.5102539063,2382.2556152344,49.4921875,49)
--setBlipVisibleDistance(blip, getBlipVisibleDistance(blip) / 100)
--[[
local tostring = tostring

---------------------------------------
-- Local variables for this file
---------------------------------------
local myShader
local bShowTextureUsage = false
local uiTextureIndex = 1
local m_SelectedTextureName = ""
local scx, scy = guiGetScreenSize ()
local usageInfoList = {}


---------------------------------------
-- Startup
---------------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			return
		end

		-- Create shader
		local tec
		myShader, tec = dxCreateShader ( "tex_names.fx", 1, 0, false, "all" )
	end
)


---------------------------------------
-- Draw visible texture list
---------------------------------------
addEventHandler( "onClientRender", root,
	function()
		usageInfoList = engineGetVisibleTextureNames ()

		local iXStartPos = scx - 200;
		local iYStartPos = 0;
		local iXOffset = 0;
		local iYOffset = 0;

		if bShowTextureUsage then
			for key, textureName in ipairs(usageInfoList) do

				local bSelected = textureName == m_SelectedTextureName;
				local dwColor = bSelected and tocolor(255,220,128) or tocolor(224,224,224,204)

				if bSelected then
					dxDrawText( textureName, iXStartPos + iXOffset + 1, iYStartPos + iYOffset + 1, 0, 0, tocolor(0,0,0) )
				end
				dxDrawText( textureName, iXStartPos + iXOffset, iYStartPos + iYOffset, 0, 0, dwColor )

				iYOffset = iYOffset + 15
				if iYOffset > scy - 15 then
					iYOffset = 0;
					iXOffset = iXOffset - 200;
				end
			end
		end
	end
)


---------------------------------------
-- Handle keyboard events from KeyAutoRepeat
--
-- c_key_auto_repeat.lua
--



-------------------------------------------------------------
-- Keyboard auto-repeat
-------------------------------------------------------------
KeyAutoRepeat = {}
KeyAutoRepeat.repeatDelay = 500					-- Wait before 1st repeat
KeyAutoRepeat.repeatRateInitial = 100			-- Delay between repeats (initial)
KeyAutoRepeat.repeatRateMax = 10				-- Delay between repeats (after key held for repeatRateChangeTime)
KeyAutoRepeat.repeatRateChangeTime = 2700		-- Amount of time to move between repeatRateInitial and repeatRateMax
KeyAutoRepeat.keydownInfo = {}

-- Result event - Same parameters as onClientKey
addEvent( "onClientKeyClick" )

-- Update repeats
function KeyAutoRepeat.pulse()
	for key,info in pairs(KeyAutoRepeat.keydownInfo) do
		local age = getTickCount () - info.downStartTime
		age = age - KeyAutoRepeat.repeatDelay	-- Initial delay
		if age > 0 then
			-- Make rate speed up as the key is held
			local ageAlpha = math.unlerpclamped( 0, age, KeyAutoRepeat.repeatRateChangeTime )
			local dynamicRate = math.lerp( KeyAutoRepeat.repeatRateInitial, ageAlpha, KeyAutoRepeat.repeatRateMax )

			local count = math.floor(age/dynamicRate)	-- Repeat rate
			if count > info.count then
				info.count = count
				triggerEvent("onClientKeyClick", resourceRoot, key )
			end
		end
	end
end
addEventHandler("onClientRender", root, KeyAutoRepeat.pulse )

-- When a key is pressed/release
function KeyAutoRepeat.keyChanged(key,down)
	KeyAutoRepeat.keydownInfo[key] = nil
	if down then
		KeyAutoRepeat.keydownInfo[key] = { downStartTime=getTickCount (), count=0 }
		triggerEvent("onClientKeyClick", resourceRoot, key )
	end
end
addEventHandler("onClientKey", root, KeyAutoRepeat.keyChanged)


-------------------------------------------------------------
-- Math extentions
-------------------------------------------------------------
function math.lerp(from,alpha,to)
    return from + (to-from) * alpha
end

function math.unlerp(from,pos,to)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end

function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.unlerpclamped(from,pos,to)
	return math.clamp(0,math.unlerp(from,pos,to),1)
end

---------------------------------------
addEventHandler("onClientKeyClick", resourceRoot,
	function(key)
		if key == "g" then
			if not getElementData(localPlayer,"isPlayerPrime") then return false end
			moveCurrentTextureCaret( -1 )
		elseif key == "h" then
			if not getElementData(localPlayer,"isPlayerPrime") then return false end
			moveCurrentTextureCaret( 1 )
		elseif key == "k" then
			if not getElementData(localPlayer,"isPlayerPrime") then return false end
			bShowTextureUsage = not bShowTextureUsage
		elseif key == "l" then
			if not getElementData(localPlayer,"isPlayerPrime") then return false end
			if m_SelectedTextureName ~= "" then
				setClipboard( m_SelectedTextureName )
				outputChatBox( "'" .. tostring(m_SelectedTextureName) .. "' copied to clipboard", 0, 225, 0 )
			end
		end
	end
)


---------------------------------------
-- Change current texture
---------------------------------------
function moveCurrentTextureCaret( dir )

	if #usageInfoList == 0 then
		return
	end

	-- Validate selection in current texture list, or find closest match
	for key, textureName in ipairs(usageInfoList) do
		if m_SelectedTextureName <= textureName then
			uiTextureIndex = key
			break
		end
	end

	-- Move position in the list
	uiTextureIndex = uiTextureIndex + dir
	uiTextureIndex = ( ( uiTextureIndex - 1 ) % #usageInfoList ) + 1

	-- Change highlighted texture
	engineRemoveShaderFromWorldTexture ( myShader, m_SelectedTextureName )
	m_SelectedTextureName = usageInfoList [ uiTextureIndex ]
	engineApplyShaderToWorldTexture ( myShader, m_SelectedTextureName )

end]]


shader = {}
texture = {}

local mt = {
"des_dinerwall",
"washapartwall1_256",
"wallwhtwind256",
}

addEventHandler("onClientResourceStart",resourceRoot,function()
	for k,v in ipairs(mt) do
		shader[v], tec = dxCreateShader( "shader.fx" )
		if shader[v] then
			texture[v] = dxCreateTexture ( "drug.jpg" )
			if texture[v] then
				engineApplyShaderToWorldTexture ( shader[v],v )
				dxSetShaderValue ( shader[v], "gTexture", texture[v] )
			end
		end
	end
	exports.customblips:createCustomBlip(-1939.5102539063,2382, 14, 14, "drugs.png",9999)
end)
