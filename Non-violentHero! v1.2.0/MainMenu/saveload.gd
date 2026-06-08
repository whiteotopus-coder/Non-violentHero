extends Control

var save_file_path = OS.get_environment("APPDATA") + "/Non-violentHero"

var SAVE_FILE_0 = save_file_path + "/save_file0.json"
var SAVE_FILE_1 = save_file_path + "/save_file1.json"
var SAVE_FILE_2 = save_file_path + "/save_file2.json"
var SAVE_FILE_3 = save_file_path + "/save_file3.json"
var SAVE_FILE_4 = save_file_path + "/save_file4.json"
var SAVE_FILE_5 = save_file_path + "/save_file5.json"
var SAVE_FILE_6 = save_file_path + "/save_file6.json"
var SAVE_FILE_7 = save_file_path + "/save_file7.json"
var SAVE_FILE_8 = save_file_path + "/save_file8.json"
var SAVE_FILE_9 = save_file_path + "/save_file9.json"
var SAVE_FILE_10 = save_file_path + "/save_file10.json"

var save_slots = [SAVE_FILE_0, SAVE_FILE_1, SAVE_FILE_2, SAVE_FILE_3, SAVE_FILE_4, SAVE_FILE_5, SAVE_FILE_6, SAVE_FILE_7, SAVE_FILE_8, SAVE_FILE_9, SAVE_FILE_10]

var save_clicked = false
var waiting_done = false
var up = false
var down = false

func _ready():
	$DeleteComfirmation.hide()
	$LoadGame/ScrollContainer/VBoxContainer/Control/Slot0.grab_focus()
	
	for i in range(11):
		var file_path = save_slots[i]
		var place_name = load_save_file_display_data(file_path,"place")
		Global.set("slot_" + str(i) + "_name", place_name)
		var date_name = load_save_file_display_data(file_path,"date")
		Global.set("slot_" + str(i) + "_date", date_name)
		
	update_slot_labels()
	$AnimationPlayer.play("default")
	await $AnimationPlayer.animation_finished
	waiting_done = true
	


func update_slot_labels():
	for i in range(11):
		# 获取 SlotX 节点
		var slot = $LoadGame/ScrollContainer/VBoxContainer/Control.get_node("Slot" + str(i))
		if slot:
			# 直接从存档文件读取任务状态
			var file_path = save_slots[i]
			# 获取 place_name
			var place_name = Global.get("slot_" + str(i) + "_name")
			var date_name = Global.get("slot_" + str(i) + "_date")
			# 更新文本
			
			var the_font
			if Global.lang_sim_man:
				the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
			if Global.lang_man or Global.lang_jp:
				the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			if Global.lang_eng:
				the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
					
			if slot.has_node("place"):
				slot.get_node("place").text = place_name
				slot.get_node("place").add_theme_font_override("font", the_font)
			
			if slot.has_node("save_date"):
				slot.get_node("save_date").text = date_name
				slot.get_node("save_date").add_theme_font_override("font", the_font)
				
			if slot.has_node("num"):
				slot.get_node("num").text = str(i)
				
		
	
				
func process_slot(file_path, slot_index):
	if waiting_done:
		if not Global.change_scene:
			if Global.savegame:
				$save_function.save_game(file_path, slot_index)
				slot_num_btn = slot_index
			if Global.loadgame:
				$save_function.load_game(file_path)

	
func _on_slot_0_pressed():
	if waiting_done:
		if not Global.change_scene:
			if Global.loadgame:
				$save_function.load_game(SAVE_FILE_0)
	
func _on_slot_1_pressed():
	process_slot(SAVE_FILE_1, 1)
	
func _on_slot_2_pressed():
	process_slot(SAVE_FILE_2, 2)

func _on_slot_3_pressed():
	process_slot(SAVE_FILE_3, 3)

func _on_slot_4_pressed():
	process_slot(SAVE_FILE_4, 4)

func _on_slot_5_pressed():
	process_slot(SAVE_FILE_5, 5)

func _on_slot_6_pressed() -> void:
	process_slot(SAVE_FILE_6, 6)

func _on_slot_7_pressed() -> void:
	process_slot(SAVE_FILE_7, 7)

func _on_slot_8_pressed() -> void:
	process_slot(SAVE_FILE_8, 8)

func _on_slot_9_pressed() -> void:
	process_slot(SAVE_FILE_9, 9)

func _on_slot_10_pressed() -> void:
	process_slot(SAVE_FILE_10, 10)


func load_save_file_display_data(file_path,type):
	if not FileAccess.file_exists(file_path):
		#print("Save file not found:", file_path)
		return ""
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		var encrypted = file.get_as_text()
		var save_json = Marshalls.base64_to_raw(encrypted).get_string_from_utf8()
		file.close()
		#print("Loaded file content from", file_path, ":", save_json)  # 调试用

		var parse_result = JSON.parse_string(save_json)
		if parse_result == null or parse_result.size() == 0:
			#print("JSON parsing failed or empty:", file_path)
			return ""
		
		var loaded_data = parse_result[0]
		##################### place ###################
		if type == "place":
			if Global.lang_jp:
				if loaded_data.get("save_place_jp", "") != "":
					return loaded_data["save_place_jp"]
				if "save_place_man" in loaded_data:
					print("Found place:", loaded_data["save_place_man"])
					var map = {
						"空空的國王城堡（連椅子都沒有）": "何もない王様の城（椅子すらない）",
						"國王的挑戰！": "王の挑戦！",
						"用語言的力量征服魔王！": "言葉の力で魔王を打ち倒せ！",
						"教堂": "教会",
						"來獲得修女的信任！": "シスターの信頼を得る！",
						"粉章魚的家": "ピンクタコの家",
						"警察局": "警察署",
						"小鎮": "町",
						"和看門的小怪戰鬥！": "門番の雑魚との戦い！",
						"學校走廊": "学校の廊下",
						"和羅凯伦女士的唇槍舌戰！": "クレーマー母との口論！",
						"肥宅家": "オタクの家",
						"和肥宅的戰鬥！": "オタクとの戦い！",
						"厕所": "トイレ",
						"厠所": "トイレ",
						"樓梯口": "階段前",
						"肥宅家厕所": "オタクの家のトイレ",
						"肥宅家厠所": "オタクの家のトイレ",
						"肥宅房間": "オタクの部屋",
						"肥宅家二樓": "オタクの家の2階",
						"B班": "Bクラス",
						"A班": "Aクラス",
						"教師辦公室": "職員室",
						"警察局厕所": "警察署のトイレ",
						"警察局厠所": "警察署のトイレ",
						"羅太太家": "クレーマー母",
						"甜甜圈後厨": "ドーナツ屋の厨房",
						"甜甜圈店": "ドーナツ屋",
						"洞穴": "洞窟"
					}
					if map.has(loaded_data["save_place_man"]):
						loaded_data["save_place_jp"] = map[loaded_data["save_place_man"]]
					else:
						print("❗未匹配:", loaded_data["save_place_man"])
					return loaded_data.get("save_place_jp", "")
			if Global.lang_sim_man:
				if "save_place_sim_man" in loaded_data:
					return loaded_data["save_place_sim_man"]
			if Global.lang_man:
				if "save_place_man" in loaded_data:
					return loaded_data["save_place_man"]
			if Global.lang_eng:
				if "save_place_eng" in loaded_data:
					#print("Found place:", loaded_data["save_place"])
					return loaded_data["save_place_eng"]
	
		##################### date ###################
		if type == "date":
			if "date" in loaded_data:
				return loaded_data["date"]
	
	print("No key found in save file:", file_path)
	return ""
	
	
########################### delete function ###############################

func delete_save(file_path, slot_index):
	if FileAccess.file_exists(file_path):
		var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
		# 先打開父資料夾
		var dir := DirAccess.open(OS.get_environment("APPDATA"))
		if dir:
			# 建立 Non-violentHero 資料夾（遞歸）
			dir.make_dir_recursive("Non-violentHero")
		# 刪除檔案
		var dir2 := DirAccess.open(save_path)
		if dir2:
			var error = dir2.remove_absolute(file_path)
			if error == OK:
				print("Deleted save file:", file_path)
			else:
				print("Failed to delete file:", file_path, "Error code:", error)

		# 清空 Global 里的存档名称
		match slot_index:
			0: Global.slot_0_name = ""
			1: Global.slot_1_name = ""
			2: Global.slot_2_name = ""
			3: Global.slot_3_name = ""
			4: Global.slot_4_name = ""
			5: Global.slot_5_name = ""
			6: Global.slot_6_name = ""
			7: Global.slot_7_name = ""
			8: Global.slot_8_name = ""
			9: Global.slot_9_name = ""
			10: Global.slot_10_name = ""
			
		match slot_index:
			0: Global.slot_0_date = ""
			1: Global.slot_1_date = ""
			2: Global.slot_2_date = ""
			3: Global.slot_3_date = ""
			4: Global.slot_4_date = ""
			5: Global.slot_5_date = ""
			6: Global.slot_6_date = ""
			7: Global.slot_7_date = ""
			8: Global.slot_8_date = ""
			9: Global.slot_9_date = ""
			10: Global.slot_10_date = ""

		# 更新 UI
		update_slot_labels()
	else:
		print("No save file found to delete at:", file_path)


############################# delete button ######################################

var slot_num = 0
var slot_num_btn = 0

func _process(_delta: float) -> void:
	
	if $save_function.play_success_animation:
		$AnimationPlayer.play("success" + str(slot_num_btn))
		$save_function.play_success_animation = false
		
	if $save_function.play_animation_quit:
		$AnimationPlayer.play("quit")
		await $AnimationPlayer.animation_finished
		$save_function.play_animation_quit = false
	
	if $save_function.call_update_slot_labels:
		update_slot_labels()
		$save_function.call_update_slot_labels = false
		
	var the_font
	if Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$DeleteComfirmation/Label.text = "このデータを削除しますか？"
		$LoadGame/ScrollContainer/VBoxContainer/Control/Slot0/Label.text = "オートセーブ"
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$LoadGame/ScrollContainer/VBoxContainer/Control/Slot0/Label.text = "自动存档"
		$DeleteComfirmation/Label.text = "确定删除此档案？"
	if Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$DeleteComfirmation/Label.text = "確定刪除此檔案？"
		$LoadGame/ScrollContainer/VBoxContainer/Control/Slot0/Label.text = "自動存檔"
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$DeleteComfirmation/Label.text = "Are you sure you want to delete this save slot?"
		$LoadGame/ScrollContainer/VBoxContainer/Control/Slot0/Label.text = "Auto save"
	$DeleteComfirmation/Label.add_theme_font_override("font", the_font)
	$LoadGame/ScrollContainer/VBoxContainer/Control/Slot0/Label.add_theme_font_override("font", the_font)

		
func _on_delete_1_pressed():
	if Global.slot_1_name != "":
		slot_num = 1	
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()
	
func _on_delete_2_pressed():
	if Global.slot_2_name != "":
		slot_num = 2
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_3_pressed():
	if Global.slot_3_name != "":
		slot_num = 3
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_4_pressed():
	if Global.slot_4_name != "":
		slot_num = 4
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_5_pressed():
	if Global.slot_5_name != "":
		slot_num = 5
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()
	
func _on_delete_6_pressed() -> void:
	if Global.slot_6_name != "":
		slot_num = 6
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_7_pressed() -> void:
	if Global.slot_7_name != "":
		slot_num = 7
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_8_pressed() -> void:
	if Global.slot_8_name != "":
		slot_num = 8
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_9_pressed() -> void:
	if Global.slot_9_name != "":
		slot_num = 9
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_delete_10_pressed() -> void:
	if Global.slot_10_name != "":
		slot_num = 10
		$AnimationPlayer.play("delete_comfirmation")
		$DeleteComfirmation/No.grab_focus()

func _on_yes_pressed() -> void:
	Global.play_button_sound = true
	if slot_num == 1:
		delete_save(SAVE_FILE_1, slot_num)
	if slot_num == 2:
		delete_save(SAVE_FILE_2, slot_num)
	if slot_num == 3:
		delete_save(SAVE_FILE_3, slot_num)
	if slot_num == 4:
		delete_save(SAVE_FILE_4, slot_num)
	if slot_num == 5:
		delete_save(SAVE_FILE_5, slot_num)
	if slot_num == 6:
		delete_save(SAVE_FILE_6, slot_num)
	if slot_num == 7:
		delete_save(SAVE_FILE_7, slot_num)
	if slot_num == 8:
		delete_save(SAVE_FILE_8, slot_num)
	if slot_num == 9:
		delete_save(SAVE_FILE_9, slot_num)
	if slot_num == 10:
		delete_save(SAVE_FILE_10, slot_num)
	$LoadGame/ScrollContainer/VBoxContainer/Control.get_node("Slot" + str(slot_num)).grab_focus()
	slot_num = 0
	$AnimationPlayer.play("quit_delete_comfirmation")
	
	
func _on_no_pressed() -> void:
	$AnimationPlayer.play("quit_delete_comfirmation")
	$LoadGame/ScrollContainer/VBoxContainer/Control.get_node("Slot" + str(slot_num)).grab_focus()
	slot_num = 0


########################### back button ############

func _on_back_pressed():
	if not Global.change_scene:
		Global.hide_esc = false
		#因为按了存档，然后再按回去的话会一直
		#帮忙加一个数据的Globalcounter
		#减一来解决这个问题。
		Global.from_load = true
			#if Global.counterR >= 0:
				#Global.counterR -= 1
		#if not Global.optionAppear:
			#Global.counter -= 1
		Global.file_load = true
		Global.from_door = false
		Global.from_ending = true
		
		Global.openMenu = false
		Global.savegame = false
		Global.loadgame = false
		Global.play_button_back_sound = true
		
		$AnimationPlayer.play("quit")
		await $AnimationPlayer.animation_finished
		
		#print("Global.from_load:",Global.from_load)
		if Global.from_menu:
			GlobalCanvasLayer.change_scene("res://MainMenu/main_menu.tscn","faded")
		else:
			GlobalCanvasLayer.change_scene(Global.previous_scene,"faded")
	


func _on_slot_1_mouse_entered() -> void:
	Global.play_pick_chat_sound = true



func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_pressed()

func _on_slot_0_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 0

func _on_slot_1_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 0

func _on_slot_2_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 265

func _on_slot_3_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 530

func _on_slot_4_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 795

func _on_slot_5_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 1060

func _on_slot_6_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 1316

func _on_slot_7_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 1572
	
func _on_slot_8_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 1846

func _on_slot_9_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 2111

func _on_slot_10_focus_entered() -> void:
	_on_slot_1_mouse_entered()
	$LoadGame/ScrollContainer.scroll_vertical = 2211
