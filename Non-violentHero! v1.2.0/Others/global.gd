extends Node

var isScene = false
var chatArea = false
var openMenu = false
var change_scene = false
var allow_move = false
var open_comfirmation = false
var hide_esc = false
		
var stage_2_position = false
var stage_2_corridor = false
var stage_2_met = false
var stage_2_corridor_done = false
var stage_2_room_done= false
var show_last_option = false

var in_class_1 = false
var in_class_2 = false
var in_stair = false
var in_washroom = false
var stage_1_position = false
var in_stage_1 = false
var toilet_otaku = false
var toilet_police = false
var setposition = false
var pos_to_chair_police = false
var play_ending_one = false
var play_ending_two = false
var play_ending_three = false
var play_ending_four = false
var play_ending_five = false
var play_ending_six = false
var play_ending_seven = false
var play_ending_eight = false
var play_ending_nine = false
var play_ending_ten = false
var play_ending_eleven = false
var play_ending_twelve = false
var play_ending_thirteen = false

var hide_get_task = false

var player = false
var hideking = false

var play_false_animation = false
var play_quit_animation = false
var play_tutorial_animation = false
var interaction = false
var ani_heart = false
var heart_once = true
var heart_increase_once = false

var from_menu = false

#給國王的，出了城堡不要講頭上的話了
var in_castle = false

var npcchat = false

var new_savefile_mark = false
var mention_appear = false
var last_option_btn_pressed = false
var updateLivesNumber = false
var show_last_option_btn = false
var last_option_counter = 0
var place = ""
var character_name = ""
var item = ""
var battle_name = ""
var last_scene_name: String = ""
var change_language = false
var attack_scene = false

var loadgame = false
var savegame = false
var volume = 5
var volume_music = 5

#被記錄的全部
var lives = 3
var lives_opp = 3
var current_lives_opp = 0
var counter = 0
var counterR = 0
var optionI = 0
var num_water = 3
var from_load = false
var lose_carrot_game = false
var lose_church_game = false
var lose_demon_game = false

var out_from_door = false
var play_door_sound = false
var play_punch_sound = false
var play_bed_sound = false
var play_button_sound = false
var play_button_back_sound = false
var play_true_sound = false
var play_wrong_sound = false
var play_bing_sound = false
var play_pick_chat_sound = false
var play_victory_sound = false
var play_lose_sound = false
var play_new_task_animation = false
var play_completed_task_animation = false

var play_town_song = false
var play_indoor_song = false
var play_comedy_song = false
var play_menu_song = false
var play_school_song = false
var play_cave_song = false
var play_no_song = false
var play_battle_song = false
var play_happy_song = false
var play_war_song = false
var from_ending = false
var wait = false
var pressed_close_menu = false
var garrett_house = false
var from_donut_washroom = false
var door_area = false

var saved_me = false
var cup_water = false
var me_dry = false
var check_demonnpc_donut_count = false
var demon_npc_died = false
var pink_otopus_bed_dirty = false
var close_mark = false
var dirty = false
var for_the_next = false
var change_for_green = false
var show_kid = false
var show_otaku = false
var king_cave_move = false
var move = false
var move_king = false
var princess_leave = false
var princess_move = false
var give_map = false

var slot_0_name = ""
var slot_1_name = ""
var slot_2_name = ""
var slot_3_name = ""
var slot_4_name = ""
var slot_5_name = ""
var slot_6_name = ""
var slot_7_name = ""
var slot_8_name = ""
var slot_9_name = ""
var slot_10_name = ""

var slot_0_date = ""
var slot_1_date = ""
var slot_2_date = ""
var slot_3_date = ""
var slot_4_date = ""
var slot_5_date = ""
var slot_6_date = ""
var slot_7_date = ""
var slot_8_date = ""
var slot_9_date = ""
var slot_10_date = ""

var save_place_man = ""
var save_place_sim_man = ""
var save_place_eng = ""
var save_place_jp = ""
var date = ""

var lang_jp = false
var lang_man = false
var lang_eng = true
var lang_sim_man = false
var full_screen = false

var task_1_get = false
var task_2_get = false
var task_3_get = false

var eat_road_side_donut = false
var eat_puffer_donut = false
var eat_road_side_donut_saved = false
var add_heart = false
var player_position: Vector2 = Vector2.ZERO
var second_nun = false
var startChat = false
var entered_house1 = false
var church_done = false
var stage1_done =  false
var stage2_done =  false
var cave_done = false
var pink_otopus_bed = false
var put_cross = false
var pink_closet = false
var pink_otopus_book = false
var church_get_task = false
var get_task = false
var church_request = false
var move_to_church =  false
var get_rob = false
var show_last_option_nun = false
var show_last_option_otaku = false
var show_last_option_kid = false
var kid_enter_room = false
var teacher_leave_class = false
var teacher_back_done = false
var cave_entrance_done = false
var entered_class_2 = false
var teacher_stalker = false
var i_am_student = false
var new_student = false
var carrot_leave_room = false
var mom_win = false
var all_img_collect = false
var once_stage1 = false
var previous_scene = ""
var demon_love = false
var demon_green = false
var demon_marry = false
var marry_queen = false
var food_ending = false
var police_ending = false
var get_out_otaku = false
var get_out_teacher = false
var princess_angry = false
var run_otaku = false
var optionAppear = false
var buttonSelected = false
var king_tutorial = false
var stage_2_3_options = false
var king_go = false
var feed_you = false
var bites = 1
var food_num = 0
var button_value = 0
var tutorial_value = int(0)
var from_door = false
var win_btn_game = false
var lose_btn_game = false
var song_playing = ""
var current_animation = ""
var current_animation_kid = ""
var transition = ""

var file_load_for_song = false
var startChat_for_non_attack = false
var reset_button_time = false
var file_load = false
var current_character = ""
var current_me_texture = ""
var emotion = ""
var items = []

# must make it remain same after quit
var ending1 = false
var ending2 = false
var ending3 = false
var ending4 = false
var ending5 = false
var ending6 = false
var ending7 = false
var ending8 = false
var ending9 = false
var ending10 = false
var ending11 = false
var ending12 = false
var ending13 = false

func reset_var(): 
	isScene = false
	chatArea = false
	openMenu = false
	change_scene = false
	allow_move = false
	open_comfirmation = false

	isScene = false
	chatArea = false
					
	stage_2_position = false
	stage_2_corridor = false
	stage_2_met = false
	stage_2_corridor_done = false
	stage_2_room_done= false
	show_last_option = false

	in_class_1 = false
	in_class_2 = false
	in_stair = false
	in_washroom = false
	stage_1_position = false
	in_stage_1 = false
	toilet_otaku = false
	toilet_police = false
	setposition = false
	pos_to_chair_police = false
	play_ending_one = false
	play_ending_two = false
	play_ending_three = false
	play_ending_four = false
	play_ending_five = false
	play_ending_six = false
	play_ending_seven = false
	play_ending_eight = false
	play_ending_nine = false
	play_ending_ten = false
	play_ending_eleven = false
	play_ending_twelve = false
	play_ending_thirteen = false

	hide_get_task = false
	player = false
	hideking = false
	play_false_animation = false
	play_quit_animation = false
	play_tutorial_animation = false
	interaction = false
	ani_heart = false
	heart_once = true
	heart_increase_once = false
	from_menu = false
	in_castle = false
	npcchat = false
	
	saved_me = false
	cup_water = false
	me_dry = false
	check_demonnpc_donut_count = false
	demon_npc_died = false
	new_savefile_mark = false
	mention_appear = false
	last_option_btn_pressed = false
	updateLivesNumber = false
	show_last_option_btn = false
	last_option_counter = 0
	place = ""
	character_name = ""
	item = ""
	battle_name = ""
	last_scene_name = ""
	change_language = false
	attack_scene = false
	loadgame = false
	savegame = false

	#被記錄的全部
	lives = 3
	lives_opp = 3
	current_lives_opp = 0
	counter = 0
	counterR = 0
	optionI = 0
	num_water = 3
	from_load = false
	lose_carrot_game = false
	lose_church_game = false
	lose_demon_game = false
	out_from_door = false
	
	play_school_song = false
	play_indoor_song = false
	play_town_song = false
	play_comedy_song = false
	play_menu_song = false
	play_no_song = false
	play_battle_song = false
	play_happy_song = false
	play_war_song = false
	from_ending = false
	
	play_new_task_animation = false
	play_completed_task_animation = false
	
	pink_otopus_bed_dirty = false
	close_mark = false
	dirty = false
	for_the_next = false
	change_for_green = false
	show_kid = false
	show_otaku = false
	king_cave_move = false
	move = false
	move_king = false
	princess_leave = false
	princess_move = false
	give_map = false

	save_place_man = ""
	save_place_sim_man = ""
	save_place_eng = ""
	save_place_jp = ""

	task_1_get = false
	task_2_get = false
	task_3_get = false

	eat_road_side_donut = false
	eat_puffer_donut = false
	eat_road_side_donut_saved = false
	add_heart = false
	player_position = Vector2.ZERO
	second_nun = false
	startChat = false
	entered_house1 = false
	church_done = false
	stage1_done =  false
	stage2_done =  false
	cave_done = false
	put_cross = false
	pink_otopus_bed = false
	pink_closet = false
	pink_otopus_book = false
	church_get_task = false
	get_task = false
	church_request = false
	move_to_church =  false
	get_rob = false
	show_last_option_nun = false
	show_last_option_otaku = false
	show_last_option_kid = false
	kid_enter_room = false
	teacher_leave_class = false
	teacher_back_done = false
	cave_entrance_done = false
	entered_class_2 = false
	teacher_stalker = false
	i_am_student = false
	new_student = false
	carrot_leave_room = false
	mom_win = false
	all_img_collect = false
	once_stage1 = false
	previous_scene = ""
	demon_love = false
	demon_green = false
	demon_marry = false
	marry_queen = false
	food_ending = false
	police_ending = false
	get_out_otaku = false
	get_out_teacher = false
	princess_angry = false
	run_otaku = false
	optionAppear = false
	buttonSelected = false
	king_tutorial = false
	stage_2_3_options = false
	king_go = false
	feed_you = false
	dirty = false
	bites = 1
	food_num = 0
	button_value = 0
	tutorial_value = int(0)
	from_door = false
	win_btn_game = false
	lose_btn_game = false
	song_playing = ""
	current_animation = ""
	current_animation_kid = ""
	transition = ""

	file_load_for_song = false
	startChat_for_non_attack = false
	reset_button_time = false
	file_load = false
	current_character = ""
	current_me_texture = ""
	emotion = ""
	items = []

############################################# Steam ###############################

var AppID = "3808010"

func _init():
	OS.set_environment("SteamAppID", AppID)
	OS.set_environment("SteamGameID", AppID)
	

func _ready():
	if !Steam.steamInit():
		#print("Failed to initialize Steam.")
		return

	var id = Steam.getSteamID()
		
###################################################### Others ##########################
	
	
func save_volume(x,value):
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var file_path = save_path + "/settings.json"
	
	var data = load_settings()  # 讀取現有的設定
	data[x] = value  # 更新音量
	# 存回檔案
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))
	


func save_setting():
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var file_path = save_path + "/settings.json"
	
	var data = load_settings()  # 讀取現有的設定
	# 更新語言設定
	data["lang_man"] = lang_man
	data["lang_eng"] = lang_eng
	data["lang_jp"] = lang_jp
	data["lang_sim_man"] = lang_sim_man
	data["full_screen"] = full_screen
	# 存回檔案
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))



func load_settings():
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var file_path = save_path + "/settings.json"
	
	# 確保檔案存在
	if not FileAccess.file_exists(file_path):
		return {}  # 檔案不存在則回傳空字典
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	# 解析 JSON，如果解析失敗則回傳空字典
	var json = JSON.new()
	var error = json.parse(content)
	if error != OK:
		#print("Failed to parse settings.json")
		return {}
	
	return json.get_data()



func load_setting():
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var dst_path = save_path + "/settings.json"
	
	if not FileAccess.file_exists(dst_path):
		return  # 如果文件不存在，就不加载
	var file = FileAccess.open(dst_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	if data and "volume" in data:
		var volume = data["volume"]
		Global.volume = volume
	if data and "volume_music" in data:
		var volume_music = data["volume_music"]
		Global.volume_music = volume_music
	if data and "lang_man" in data:
		Global.lang_man = data["lang_man"]
	if data and "lang_jp" in data:
		Global.lang_jp = data["lang_jp"]
	if data and "lang_eng" in data:
		Global.lang_eng = data["lang_eng"]
	if data and "lang_sim_man" in data:
		Global.lang_sim_man = data["lang_sim_man"]
	if data and "full_screen" in data:
		Global.full_screen = data["full_screen"]


		
func save_ending():
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var save_save_path = save_path + "/save.json"
	
	var file = FileAccess.open(save_save_path, FileAccess.WRITE)
	var data = {
		"ending1": ending1,
		"ending2": ending2,
		"ending3": ending3,
		"ending4": ending4,
		"ending5": ending5,
		"ending6": ending6,
		"ending7": ending7,
		"ending8": ending8,
		"ending9": ending9,
		"ending10": ending10,
		"ending11": ending11,
		"ending12": ending12,
		"ending13": ending13,
	}

	# JSON 转字符串
	var json_string = JSON.stringify(data)
	# 转 UTF-8 buffer 再转 Base64
	var encrypted = Marshalls.raw_to_base64(json_string.to_utf8_buffer())
	
	file.store_string(encrypted)
	file.close()



func load_ending():
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var save_save_path = save_path + "/save.json"
	
	if not FileAccess.file_exists(save_save_path):
		return
	
	var file = FileAccess.open(save_save_path, FileAccess.READ)
	var encrypted = file.get_as_text() # 读取 Base64
	file.close()
	
	# Base64 解码 → UTF-8 字符串
	var decoded = Marshalls.base64_to_raw(encrypted).get_string_from_utf8()
	var data = JSON.parse_string(decoded)

	if data:
		ending1 = data.get("ending1", ending1)
		ending2 = data.get("ending2", ending2)
		ending3 = data.get("ending3", ending3)
		ending4 = data.get("ending4", ending4)
		ending5 = data.get("ending5", ending5)
		ending6 = data.get("ending6", ending6)
		ending7 = data.get("ending7", ending7)
		ending8 = data.get("ending8", ending8)
		ending9 = data.get("ending9", ending9)
		ending10 = data.get("ending10", ending10)
		ending11 = data.get("ending11", ending11)
		ending12 = data.get("ending12", ending12)
		ending13 = data.get("ending13", ending13)
		


func changeScene(stage_path,x,y):
	var stage = stage_path.instantiate()
	get_tree().get_root().add_child(stage)
	stage.get_node("player").position = Vector2(x,y)
	


func _Read(dialoguePath):
	var file = FileAccess.open(dialoguePath, FileAccess.READ)
	if file:
		var dialogueJSON = file.get_as_text()
		file.close()
		var parse_result = JSON.parse_string(dialogueJSON)
		return parse_result		
	else:
		return null

func _ReadInfoFile():
	var dialoguePath = "res://Dialogue/Info/Info.json"
	var data = _Read(dialoguePath)
	#if data == null:
		#print("Error: Failed to read Info.json.")
	return data

func _ReadLoadGameInfoFile():
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var dst_path = save_path + "/Info.json"
	
	var file = FileAccess.open(dst_path, FileAccess.READ)
	# 如果user文件不存在，就从res复制过去
	if file == null:
		var srcPath = "res://Dialogue/Info/Info.json"
		var srcFile = FileAccess.open(srcPath, FileAccess.READ)
		if srcFile:
			var content = srcFile.get_as_text()
			srcFile.close()
			var dstFile = FileAccess.open(dst_path, FileAccess.WRITE)
			dstFile.store_string(content)
			dstFile.close()
			#print("Created Info.json in user:// from res://Dialogue/Info/Info.json")
	# 现在读user版本
	var data = _Read(dst_path)
	return data

func _CreateNewInfoFile():
	var src_path = "res://Dialogue/Info/Info.json"
	
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var dst_path = save_path + "/Info.json"
	
	# 打开来源文件
	var src_file = FileAccess.open(src_path, FileAccess.READ)
	if src_file == null:
		#print("Error: Cannot open source Info.json in res://Dialogue/Info/")
		return null
	# 读取内容
	var content = src_file.get_as_text()
	src_file.close()
	# 无论 user:// 是否已经存在 -> 直接覆盖写入
	var dst_file = FileAccess.open(dst_path, FileAccess.WRITE)
	if dst_file == null:
		#print("Error: Cannot open user://Info.json for writing.")
		return null
	dst_file.store_string(content)
	dst_file.close()
	#print("Copied and overwritten Info.json to user://")
	# 读取复制后的内容
	return _Read(dst_path)

func _ReadFile():
	var dialoguePath = "res://Dialogue/DialogueTextFile/"  + str(Global.place) + "/" + str(Global.character_name) + "/" + str(_ReadNum()) + ".json"
	return _Read(dialoguePath)

func _ReadInteractFile():
	var dialoguePath = "res://Dialogue/DialogueTextFile/Interact/" + str(Global.place) + "/" + str(Global.item) + ".json"
	return _Read(dialoguePath)
	
func _ReadNum():
	var infoData = _ReadLoadGameInfoFile()[0]
	if infoData != null and typeof(infoData) == TYPE_DICTIONARY:
		# 檢查字典中是否存在對應角色的數據
		if character_name in infoData:
			var num = int(infoData[character_name])
			var max_num = int(infoData["max_" + character_name])
			
			if num > max_num:
				num = max_num 
			return str(num)  # 返回字符串格式的 num
	return null  # 如果數據無效或角色不存在，返回 null

func _ReadMaxNum():
	var infoData = _ReadInfoFile()[0]
	# 確保 infoData 是有效的字典
	if infoData != null and typeof(infoData) == TYPE_DICTIONARY:
		# 檢查字典中是否存在對應角色的數據
		if character_name in infoData:
			var max_num = int(infoData["max_" + character_name])
			return str(max_num)  # 返回字符串格式的 num

func _WriteNum(x):
	# 读取最大值并限制
	var max_num = _ReadMaxNum()
	if max_num != null and int(x) > int(max_num):
		x = str(max_num)

	# 读取当前的 Info.json 数据
	var infoDataArray = _ReadLoadGameInfoFile()
	if infoDataArray == null or infoDataArray.size() == 0:
		return

	var infoData = infoDataArray[0]  # 提取第一个字典

	# 检查角色名称是否有效
	if character_name == "" or character_name == null:
		return

	# 确认角色是否存在于字典中
	if character_name in infoData:
		infoData[character_name] = x  # 更新角色数据
	else:
		return

	# 将更新后的数据转为 JSON 写回文件
	infoDataArray[0] = infoData  # 更新数组中的字典
	var json_data = JSON.stringify(infoDataArray, "\t")  # 格式化 JSON
	
	var save_path = OS.get_environment("APPDATA") + "/Non-violentHero"
	# 建立資料夾
	var dir := DirAccess.open(OS.get_environment("APPDATA"))
	if dir:
		dir.make_dir_recursive("Non-violentHero")
	var dialoguePath = save_path + "/Info.json"
	
	var file = FileAccess.open(dialoguePath, FileAccess.WRITE)
	if file:
		file.store_string(json_data)
		file.close()
		print("Info.json updated successfully.")
