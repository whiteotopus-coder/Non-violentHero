extends Node2D

var call_update_slot_labels = false
var play_animation_quit = false
var play_success_animation = false

func save_game(file_path, slot_index):
	
	Global.new_savefile_mark = true
	
	var t = Time.get_datetime_dict_from_system()
	Global.date = "%04d-%02d-%02d   %02d:%02d:%02d" % [
		t.year, t.month, t.day,
		t.hour, t.minute, t.second
	]
	var game_state = {
		"new_savefile_mark": Global.new_savefile_mark,
		"dirty": Global.dirty,
		"stage_1_position": Global.stage_1_position,
		"in_class_1": Global.in_class_1,
		"in_class_2": Global.in_class_2,
		"counter": Global.counter,
		"counterR": Global.counterR,
		"saved_me": Global.saved_me,
		"cup_water": Global.cup_water,
		"last_option_counter": Global.last_option_counter,
		"mention_appear": Global.mention_appear,
		"show_last_option_btn": Global.show_last_option_btn,
		"give_map": Global.give_map,
		"second_nun": Global.second_nun,
		"task_1_get": Global.task_1_get,
		"task_2_get": Global.task_2_get,
		"task_3_get": Global.task_3_get,
		"eat_road_side_donut_saved": Global.eat_road_side_donut_saved,
		"entered_house1": Global.entered_house1,
		"church_done": Global.church_done,
		"stage1_done": Global.stage1_done,
		"stage2_done": Global.stage2_done,
		"church_get_task": Global.church_get_task,
		"get_task": Global.get_task,
		"church_request": Global.church_request,
		"hideking": Global.hideking,
		"move_to_church": Global.move_to_church,
		"get_rob": Global.get_rob,
		"show_last_option": Global.show_last_option,
		"show_last_option_nun": Global.show_last_option_nun,
		"show_last_option_kid": Global.show_last_option_kid,
		"show_last_option_otaku": Global.show_last_option_otaku,
		"kid_enter_room": Global.kid_enter_room,
		"teacher_leave_class": Global.teacher_leave_class,
		"teacher_back_done": Global.teacher_back_done,
		"cave_entrance_done": Global.cave_entrance_done,
		"entered_class_2": Global.entered_class_2,
		"teacher_stalker": Global.teacher_stalker,
		"i_am_student": Global.i_am_student,
		"new_student": Global.new_student,
		"carrot_leave_room": Global.carrot_leave_room,
		"previous_scene": Global.previous_scene,
		"save_place_jp": Global.save_place_jp,
		"save_place_eng": Global.save_place_eng,
		"save_place_man": Global.save_place_man,
		"save_place_sim_man": Global.save_place_sim_man,
		"date": Global.date,
		"mom_win": Global.mom_win,
		"all_img_collect": Global.all_img_collect,
		"demon_love": Global.demon_love,
		"demon_green": Global.demon_green,
		"marry_queen": Global.marry_queen,
		"optionI": Global.optionI,
		"startChat": Global.startChat,
		"optionAppear": Global.optionAppear,
		"buttonSelected": Global.buttonSelected,
		"garrett_house": Global.garrett_house,
		"king_tutorial": Global.king_tutorial,
		"king_go": Global.king_go,
		"feed_you": Global.feed_you,
		"in_stage_1": Global.in_stage_1,
		"toilet_otaku": Global.toilet_otaku,
		"toilet_police": Global.toilet_police,
		"in_stair": Global.in_stair,
		"bites": Global.bites,
		"food_num": Global.food_num,
		"me_dry": Global.me_dry,
		"check_demonnpc_donut_count": Global.check_demonnpc_donut_count,
		"lives": Global.lives,
		"lives_opp": Global.lives_opp,
		"current_lives_opp": Global.current_lives_opp,
		"current_character": Global.current_character,
		"current_me_texture": Global.current_me_texture,
		"button_value": Global.button_value,
		"stage_2_3_options": Global.stage_2_3_options,
		"stage_2_met": Global.stage_2_met,
		"win_btn_game": Global.win_btn_game,
		"lose_btn_game": Global.lose_btn_game,
		"tutorial_value": Global.tutorial_value,
		"stage_2_position": Global.stage_2_position,
		"stage_2_corridor_done": Global.stage_2_corridor_done,
		"pink_otopus_bed_dirty": Global.pink_otopus_bed_dirty,
		"stage_2_room_done": Global.stage_2_room_done,
		"player_position": [Global.player_position.x, Global.player_position.y],
		"demon_marry": Global.demon_marry,
		"song_playing": Global.song_playing,
		"stage_2_corridor": Global.stage_2_corridor,
		"current_animation": Global.current_animation,
		"current_animation_kid": Global.current_animation_kid,
		"transition": Global.transition,
		"pink_otopus_bed": Global.pink_otopus_bed,
		"demon_npc_died": Global.demon_npc_died,
		"pink_closet": Global.pink_closet,
		"pink_otopus_book": Global.pink_otopus_book,
		"put_cross": Global.put_cross,
		"items": Global.items,
		"once_stage1": Global.once_stage1,
		"num_water": Global.num_water
	}
	
	
	var info_data = Global._ReadLoadGameInfoFile()[0]
	
	game_state["info_data"] = info_data
	
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify([game_state], "\t")
		var encrypted = Marshalls.raw_to_base64(json_string.to_utf8_buffer())
		file.store_string(encrypted)
		file.close()
		print("Game saved successfully!")
		#visual feedback
		play_success_animation = true

		if Global.lang_jp:
			match slot_index:
				0: Global.slot_0_name = Global.save_place_jp
				1: Global.slot_1_name = Global.save_place_jp
				2: Global.slot_2_name = Global.save_place_jp
				3: Global.slot_3_name = Global.save_place_jp
				4: Global.slot_4_name = Global.save_place_jp
				5: Global.slot_5_name = Global.save_place_jp
				6: Global.slot_6_name = Global.save_place_jp
				7: Global.slot_7_name = Global.save_place_jp
				8: Global.slot_8_name = Global.save_place_jp
				9: Global.slot_9_name = Global.save_place_jp
				10: Global.slot_10_name = Global.save_place_jp
		if Global.lang_eng:
			match slot_index:
				0: Global.slot_0_name = Global.save_place_eng
				1: Global.slot_1_name = Global.save_place_eng
				2: Global.slot_2_name = Global.save_place_eng
				3: Global.slot_3_name = Global.save_place_eng
				4: Global.slot_4_name = Global.save_place_eng
				5: Global.slot_5_name = Global.save_place_eng
				6: Global.slot_6_name = Global.save_place_eng
				7: Global.slot_7_name = Global.save_place_eng
				8: Global.slot_8_name = Global.save_place_eng
				9: Global.slot_9_name = Global.save_place_eng
				10: Global.slot_10_name = Global.save_place_eng
		if Global.lang_man:
			match slot_index:
				0: Global.slot_0_name = Global.save_place_man
				1: Global.slot_1_name = Global.save_place_man
				2: Global.slot_2_name = Global.save_place_man
				3: Global.slot_3_name = Global.save_place_man
				4: Global.slot_4_name = Global.save_place_man
				5: Global.slot_5_name = Global.save_place_man
				6: Global.slot_6_name = Global.save_place_man
				7: Global.slot_7_name = Global.save_place_man
				8: Global.slot_8_name = Global.save_place_man
				9: Global.slot_9_name = Global.save_place_man
				10: Global.slot_10_name = Global.save_place_man
		if Global.lang_sim_man:
			match slot_index:
				0: Global.slot_0_name = Global.save_place_sim_man
				1: Global.slot_1_name = Global.save_place_sim_man
				2: Global.slot_2_name = Global.save_place_sim_man
				3: Global.slot_3_name = Global.save_place_sim_man
				4: Global.slot_4_name = Global.save_place_sim_man
				5: Global.slot_5_name = Global.save_place_sim_man
				6: Global.slot_6_name = Global.save_place_sim_man
				7: Global.slot_7_name = Global.save_place_sim_man
				8: Global.slot_8_name = Global.save_place_sim_man
				9: Global.slot_9_name = Global.save_place_sim_man
				10: Global.slot_10_name = Global.save_place_sim_man
		
		match slot_index:
			0: Global.slot_0_date = Global.date
			1: Global.slot_1_date = Global.date
			2: Global.slot_2_date = Global.date
			3: Global.slot_3_date = Global.date
			4: Global.slot_4_date = Global.date
			5: Global.slot_5_date = Global.date
			6: Global.slot_6_date = Global.date
			7: Global.slot_7_date = Global.date
			8: Global.slot_8_date = Global.date
			9: Global.slot_9_date = Global.date
			10: Global.slot_10_date = Global.date
		# 更新 UI
		Global.from_menu = false
		Global.from_door = false
		Global.from_ending = false
		#update_slot_labels()
		call_update_slot_labels = true
		
	else:
		print("Error saving game!")



func load_game(file_path):
	Global.play_button_sound = true
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		print("Error: Failed to open save file at path:", file_path)
		return

	var encrypted = file.get_as_text()
	var save_json = Marshalls.base64_to_raw(encrypted).get_string_from_utf8()
	file.close()
	
	var parse_result = JSON.parse_string(save_json)
	if parse_result == null or not parse_result is Array or parse_result.size() == 0:
		print("Error: Failed to parse JSON. Content:", save_json)
		return
		
	var loaded_data = parse_result[0]
	if not (loaded_data is Dictionary):
		print("Error: Loaded data is not a Dictionary! Data:", loaded_data)
		return
	
	#print(loaded_data)
	
	# 更新 Global 变量	Global.lang_man = loaded_data.get("lang_man", false)
	Global.new_savefile_mark = loaded_data.get("new_savefile_mark", false)
	Global.once_stage1 = loaded_data.get("once_stage1", false)
	Global.stage_1_position = loaded_data.get("stage_1_position", false)
	Global.in_class_1 = loaded_data.get("in_class_1", false)
	Global.in_class_2 = loaded_data.get("in_class_2", false)
	Global.second_nun = loaded_data.get("second_nun", false)
	Global.task_1_get = loaded_data.get("task_1_get", false)
	Global.task_2_get = loaded_data.get("task_2_get", false)
	Global.task_3_get = loaded_data.get("task_3_get", false)
	Global.entered_house1 = loaded_data.get("entered_house1", false)
	Global.church_done = loaded_data.get("church_done", false)
	Global.stage1_done = loaded_data.get("stage1_done", false)
	Global.stage2_done = loaded_data.get("stage2_done", false)
	Global.eat_road_side_donut_saved = loaded_data.get("eat_road_side_donut_saved", false)
	Global.mention_appear = loaded_data.get("mention_appear", false)  
	Global.garrett_house = loaded_data.get("garrett_house", false)  
	Global.in_stair = loaded_data.get("in_stair", false)  
	Global.in_washroom = loaded_data.get("in_washroom", false)  
	Global.church_get_task = loaded_data.get("church_get_task", false)  
	Global.hideking = loaded_data.get("hideking", false)
	Global.get_task = loaded_data.get("get_task", false)  
	Global.church_request = loaded_data.get("church_request", false)  
	Global.give_map = loaded_data.get("give_map", false)  
	Global.move_to_church = loaded_data.get("move_to_church", false)  
	Global.get_rob = loaded_data.get("get_rob", false)  
	Global.show_last_option = loaded_data.get("show_last_option", false)  
	Global.stage_2_corridor = loaded_data.get("stage_2_corridor", false)   
	Global.stage_2_room_done = loaded_data.get("stage_2_room_done", false)  
	Global.show_last_option_btn = loaded_data.get("show_last_option_btn", false)  
	Global.show_last_option_nun = loaded_data.get("show_last_option_nun", false)  
	Global.show_last_option_kid = loaded_data.get("show_last_option_kid", false)  
	Global.show_last_option_otaku = loaded_data.get("show_last_option_otaku", false)  
	Global.kid_enter_room = loaded_data.get("kid_enter_room", false)  
	Global.in_stage_1 = loaded_data.get("in_stage_1", false)  
	Global.toilet_otaku = loaded_data.get("toilet_otaku", false)
	Global.toilet_police = loaded_data.get("toilet_police", false)
	Global.teacher_leave_class = loaded_data.get("teacher_leave_class", false)  
	Global.teacher_back_done = loaded_data.get("teacher_back_done", false)  
	Global.cave_entrance_done = loaded_data.get("cave_entrance_done", false)  
	Global.entered_class_2 = loaded_data.get("entered_class_2", false)  
	Global.teacher_stalker = loaded_data.get("teacher_stalker", false)  
	Global.i_am_student = loaded_data.get("i_am_student", false)  
	Global.new_student = loaded_data.get("new_student", false)  
	Global.carrot_leave_room = loaded_data.get("carrot_leave_room", false)
	Global.mom_win = loaded_data.get("mom_win", false)
	Global.stage_2_position = loaded_data.get("stage_2_positionn", false)
	Global.stage_2_corridor_done = loaded_data.get("stage_2_corridor_done", false)
	Global.pink_otopus_bed_dirty = loaded_data.get("pink_otopus_bed_dirty", false)
	Global.current_character = loaded_data.get("current_character", "")
	Global.current_me_texture = loaded_data.get("current_me_texture", "")
	Global.previous_scene = loaded_data.get("previous_scene", "")
	Global.dirty = loaded_data.get("dirty", "")
	Global.save_place_man = loaded_data.get("save_place_man", "")
	Global.save_place_jp = loaded_data.get("save_place_jp", "") 
	Global.save_place_sim_man = loaded_data.get("save_place_sim_man", "")
	Global.save_place_eng = loaded_data.get("save_place_eng", "")
	Global.date = loaded_data.get("date", "") 
	Global.song_playing = loaded_data.get("song_playing", "")
	Global.current_animation = loaded_data.get("current_animation", "")
	Global.current_animation_kid = loaded_data.get("current_animation_kid", "")
	Global.put_cross = loaded_data.get("put_cross", "")
	Global.transition = loaded_data.get("transition", "")
	Global.all_img_collect = loaded_data.get("all_img_collect", false)  
	Global.demon_love = loaded_data.get("demon_love", false)
	Global.demon_green = loaded_data.get("demon_green", false)
	Global.demon_marry = loaded_data.get("demon_marry", false)
	Global.me_dry = loaded_data.get("me_dry", false)
	Global.check_demonnpc_donut_count = loaded_data.get("check_demonnpc_donut_count", false)
	Global.marry_queen = loaded_data.get("marry_queen", false)
	Global.pink_otopus_bed = loaded_data.get("pink_otopus_bed", false)
	Global.pink_closet = loaded_data.get("pink_closet", false)
	Global.pink_otopus_book = loaded_data.get("pink_otopus_book", false)
	Global.counter = int(loaded_data.get("counter", 0))
	Global.counterR = int(loaded_data.get("counterR", 0))
	Global.last_option_counter = int(loaded_data.get("last_option_counter", 0))
	Global.optionI = int(loaded_data.get("optionI", 0))
	Global.num_water = int(loaded_data.get("num_water", 0))
	Global.startChat = loaded_data.get("startChat", false)
	Global.optionAppear = loaded_data.get("optionAppear", false)
	Global.buttonSelected = loaded_data.get("buttonSelected", false)
	Global.stage_2_3_options = loaded_data.get("stage_2_3_options", false)
	Global.stage_2_met = loaded_data.get("stage_2_met", false)
	Global.king_tutorial = loaded_data.get("king_tutorial", false)
	Global.king_go = loaded_data.get("king_go", false)
	Global.feed_you = loaded_data.get("feed_you", false)
	Global.bites = int(loaded_data.get("bites", 0))
	Global.food_num = int(loaded_data.get("food_num", 0)) 
	Global.lives = int(loaded_data.get("lives", 0)) 
	Global.lives_opp = int(loaded_data.get("lives_opp", 0)) 
	Global.current_lives_opp = int(loaded_data.get("current_lives_opp", 0)) 
	Global.button_value = int(loaded_data.get("button_value", 0))
	Global.cup_water = loaded_data.get("cup_water", false)
	Global.saved_me = loaded_data.get("saved_me", false)
	Global.win_btn_game = loaded_data.get("win_btn_game", false)
	Global.lose_btn_game = loaded_data.get("lose_btn_game", false)
	Global.demon_npc_died = loaded_data.get("demon_npc_died", false)
	Global.tutorial_value = int(loaded_data.get("tutorial_value", 0)) 
	var pos_array = loaded_data.get("player_position", [0, 0])
	Global.player_position = Vector2(pos_array[0], pos_array[1])
	
	var items = loaded_data.get("items", {})
	for item in items:
		if item.get("name") == "map":
			item["text_exp_jp"] = "王様が自ら描いた地図！\n（拡大できないのは、王様が自分の絵をじっくり見られたくないからだ！あまりにも丸見えで、ちょっと恥ずかしいらしい！決して作者がズーム機能の実装をサボったわけではない！）\n"
		if item.get("name") == "cross":
			item["text_exp_jp"] = "神聖な十字架。"
		if item.get("name") == "photo_washroom":
			item["text_exp_jp"] = "学校の女子トイレに現れた謎の勇者のかっこいい写真。"
		if item.get("name") == "photo_washroom_otaku":
			item["text_exp_jp"] = "とあるオタクの家のトイレに現れた謎の勇者のかっこいい写真。"
		if item.get("name") == "battle_suit":
			item["text_exp_jp"] = "オタクにもらった伝説の衣装。"
		if item.get("name") == "donut":
			item["text_exp_jp"] = "子どもが地面から拾ったドーナツ。"
		if item.get("name") == "photo_washroom_police":
			item["text_exp_jp"] = "警察署のトイレに現れた謎の勇者のかっこいい写真。"
		if item.get("name") == "photo_washroom_donut":
			item["text_exp_jp"] = "ドーナツ屋のトイレに現れた謎の勇者のかっこいい写真。"	
	Global.items = items
	
	# 读取 Info.json
	var info_data = Global._ReadLoadGameInfoFile()
	var original_info = {}
	if info_data and info_data.size() > 0:
		original_info = info_data[0]  # 确保 info_data[0] 存在
	else:
		print("Warning: Info.json is empty or failed to load.")

	# 合并 info_data
	if "info_data" in loaded_data:
		var loaded_info_data = loaded_data["info_data"]
		if loaded_info_data is Dictionary:
			for key in loaded_info_data.keys():
				original_info[key] = loaded_info_data[key]
	
	if not Global.new_savefile_mark:
		original_info["Pink_bed_dirty"] = "1"
		original_info["max_Pink_bed_dirty"] = "2"
		original_info["DemonNpc_attack_new_donut"] = "1"
		original_info["max_DemonNpc_attack_new_donut"] = "1"
		original_info["DemonNpc_attack_both_donut"] = "1"
		original_info["max_DemonNpc_attack_both_donut"] = "1"
		original_info["me_dry"] = "1"
		original_info["max_me_dry"] = "5"
		original_info["me_saved"] = "1"
		original_info["max_me_saved"] = "3"
		original_info["ending12"] = "1"
		original_info["max_ending12"] = "1"
		original_info["ending13"] = "1"
		original_info["max_ending13"] = "1"
	
	#print(original_info)
	
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	# 你的存檔路徑
	var save_info_path = save_path + "/Info.json"

	# 同步到 user://Dialogue/Info/Info.json
	var dialogue_file_write = FileAccess.open(save_info_path, FileAccess.WRITE)
	dialogue_file_write.store_string(JSON.stringify([original_info], "\t"))
	dialogue_file_write.close()
	
	Global.file_load_for_song = true
	Global.from_load = true
	Global.openMenu = false
	Global.file_load = true
	Global.from_menu = false
	Global.from_door = false
	Global.from_ending = false
	Global.hide_esc = false
	# 切换场景
	#$AnimationPlayer.play("quit")
	#await $AnimationPlayer.animation_finished
	play_animation_quit = true
	
	if Global.previous_scene != "":
		GlobalCanvasLayer.change_scene(Global.previous_scene, "faded")
	else:
		print("Warning: No previous scene found, cannot change scene.")

			
var save_file_path = OS.get_environment("APPDATA") + "/Non-violentHero"
var SAVE_FILE_0 = save_file_path + "/save_file0.json"
			
func auto_save():
	save_game(SAVE_FILE_0, 0)
