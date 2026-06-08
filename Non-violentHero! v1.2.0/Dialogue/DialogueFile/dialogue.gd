extends Node2D

var buttonAppear = false
var typingTween : Tween
var typeName = false
var next_dialogue = false
var lose_next_dialogue = false
var dialogue_ready = false
var display_last_option_btn = false
#var back_to_last_question_btn_pressed = false
	
var isTyping = false
var doneTyping = false

var once = true
var in_class_redo = false
var undo_counter = 0

var jp_mention_text = ""
var man_mention_text = ""
var man_sim_mention_text = ""
var eng_mention_text = ""

var jp_name = ""
var man_name = ""
var eng_name = ""
var man_sim_name = ""

var jp_chat = ""
var man_chat = ""
var eng_chat = ""
var man_sim_chat = ""
var option_buttons = []	
var read_file

func _ready() -> void:
	if Global.attack_scene:
		dialogue_ready = false
	else:
		dialogue_ready = true
	
	
func TextStaff(JSONarray):
	if "change_current_character" in JSONarray:
		Global.current_character = JSONarray["change_current_character"]
	if "change" in JSONarray:
		Global.show_last_option_btn = false
		Global.from_ending = false
		GlobalCanvasLayer.change_scene(JSONarray["change"],JSONarray["sceneTransition"])
		_ResetDialogue(JSONarray)
		_CloseDialogue()
	if "close" in JSONarray:
		_ResetDialogue(JSONarray)
	if "clear_script" in JSONarray:
		Global.place = ""
		Global.character_name = ""
	play_text_by_JSON(JSONarray)
	store_name_by_JSON(JSONarray)
	play_by_JSON(JSONarray)	
	play_transition_by_JSON(JSONarray)	
	play_animations_by_JSON(JSONarray)
	background_song(JSONarray)
	done_function_in_JSON(JSONarray)
	steam_ach(JSONarray)
	if "auto_save" in JSONarray:
		SaveFunction.auto_save()
	if "close" in JSONarray:
		_CloseDialogue()
	
	
func _PrintDialogueText(read_file):
	if read_file != null:
		if Global.counter >= 0 and Global.counter < read_file.size():
			var JSONarray = read_file[Global.counter]
			TextStaff(JSONarray)
			if _has_options(JSONarray):
				if Global.last_option_counter != Global.counter:
					Global.updateLivesNumber = true
				Global.last_option_counter = Global.counter
				buttonAppear = true
				_ButtonResponse(read_file)
			
			
func play_text_by_JSON(JSONarray):
	if Global.lang_jp:
		var the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
		$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
		if "jp_name" in JSONarray:
			$CanvasLayer/DialogueText/CharacterName.text = JSONarray["jp_name"]
		if "jp_dialogue" in JSONarray:
			# Print dialogue and play animations
			_TypingEffect(JSONarray["jp_dialogue"],_TypingDialogue)
			$CanvasLayer/DialogueText.show()
		################## mention text
		if "jp_mention" in JSONarray:
			Global.mention_appear = true
			$CanvasLayer/MentionText.text = "[wave][font=res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf]" + JSONarray["jp_mention"] + "[/font][/wave]"
			$CanvasLayer/MentionText.show()
		else:
			Global.mention_appear = false
			$CanvasLayer/MentionText.hide()
	if Global.lang_man:
		var the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
		$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
		if "man_name" in JSONarray:
			$CanvasLayer/DialogueText/CharacterName.text = JSONarray["man_name"]
		if "man_dialogue" in JSONarray:
			# Print dialogue and play animations
			_TypingEffect(JSONarray["man_dialogue"],_TypingDialogue)
			$CanvasLayer/DialogueText.show()
		################## mention text
		if "man_mention" in JSONarray:
			Global.mention_appear = true
			$CanvasLayer/MentionText.text = "[wave][font=res://Dialogue/DialogueTextFile/Cubic_11.ttf]" + JSONarray["man_mention"] + "[/font][/wave]"
			$CanvasLayer/MentionText.show()
		else:
			Global.mention_appear = false
			$CanvasLayer/MentionText.hide()
	if Global.lang_sim_man:
		var the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
		$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
		if "man_sim_name" in JSONarray:
			$CanvasLayer/DialogueText/CharacterName.text = JSONarray["man_sim_name"]
		if "man_sim_dialogue" in JSONarray:
			# Print dialogue and play animations
			_TypingEffect(JSONarray["man_sim_dialogue"],_TypingDialogue)
			$CanvasLayer/DialogueText.show()
		################## mention text
		if "man_sim_mention" in JSONarray:
			Global.mention_appear = true
			$CanvasLayer/MentionText.text = "[wave][font=res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf]" + JSONarray["man_sim_mention"] + "[/font][/wave]"
			$CanvasLayer/MentionText.show()
		else:
			Global.mention_appear = false
			$CanvasLayer/MentionText.hide()
	if Global.lang_eng:
		var the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
		$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
		if "eng_name" in JSONarray:
			$CanvasLayer/DialogueText/CharacterName.text = JSONarray["eng_name"]
		if "eng_dialogue" in JSONarray:
			_TypingEffect(JSONarray["eng_dialogue"],_TypingDialogue)
			$CanvasLayer/DialogueText.show()
		################## mention text
		if "eng_mention" in JSONarray:
			Global.mention_appear = true
			$CanvasLayer/MentionText.text = "[wave][font=res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf]" + JSONarray["eng_mention"] + "[/font][/wave]"
			$CanvasLayer/MentionText.show()
		else:
			Global.mention_appear = false
			$CanvasLayer/MentionText.hide()
	
			
func _TypingDialogue(character):
	$CanvasLayer/DialogueText/DialogueText.text += character
	var ignore_characters = ["！"," ", ".", ",","、", "…","!", "?", ";", ":", "~", "-","，","！","。","？"]
	# 标点符号额外停顿
	var extra_pause = 0.0
	match character:
		".","！","!","！","。","…":
			extra_pause = 0.05 
		",", ";", ":","，","、":
			extra_pause = 0.2  # 短暂停顿
		"？","?", "~", "-":
			extra_pause = 0.4  # 语气更强，稍微停顿更久
	# 如果不是标点符号，就播放 bibi bobo 音效
	if character not in ignore_characters:
		play_text_sound()
	# 停顿，模拟打字的节奏
	await get_tree().create_timer(0.05 + extra_pause).timeout


func _TypingEngDialogue(character):
	$CanvasLayer/DialogueText/DialogueText.text += character
	if character == " ":
		return  # 只在單詞內觸發，不要每個字母都發音
	play_text_sound()

var pitch_scale = {
	"demon_king": {"low_pitch": 0.3, "high_pitch": 0.5,"delay":0.08},
	"king": {"low_pitch": 0.4, "high_pitch": 0.6,"delay":0.08},
	"nun": {"low_pitch": 1.1, "high_pitch": 1.3,"delay":0.12},
	"kid": {"low_pitch": 1.4, "high_pitch": 1.6,"delay":0.075},
	"carrot": {"low_pitch": 0.6, "high_pitch": 0.8,"delay":0.07},
	"mummy": {"low_pitch": 0.9, "high_pitch": 1.0,"delay":0.08},
	"otaku": {"low_pitch": 0.5, "high_pitch": 0.7,"delay":0.075},
	"pink": {"low_pitch": 0.9, "high_pitch": 1.1,"delay":0.08},
	"busker": {"low_pitch": 0.8, "high_pitch": 1.1,"delay":0.07},
	"right": {"low_pitch": 0.5, "high_pitch": 0.7,"delay":0.07},
	"setting": {"low_pitch": 1, "high_pitch": 1,"delay":0.07},
	"police": {"low_pitch": 0.5, "high_pitch": 0.7,"delay":0.08}
}

@onready var audio_player = $AudioStreamPlayer

func play_text_sound():
	audio_player.volume_db = Global.volume
	audio_player.stream = preload("res://Sound/talk.WAV")
	if pitch_scale.has(Global.current_character):
		var range = pitch_scale[Global.current_character]
		audio_player.pitch_scale = randf_range(range.low_pitch, range.high_pitch)
	audio_player.play()


func _TypingEffect(typing, x):
	dialogue_ready = true
	isTyping = true
	$CanvasLayer/DialogueText/NextIndicator.hide()
	typingTween = get_tree().create_tween()
	$CanvasLayer/DialogueText/DialogueText.text = ""
	var punctuation_delay = {  # 设定不同标点的停顿时间
		"…": 0.05,
		".": 0.05,
		",": 0.2,
		"，": 0.2,
		"、": 0.2,
		"!":0.05,
		"。":0.05,
		"！":0.05,
		"？":0.05,
		"?": 0.4,
		";": 0.2,
		":": 0.2,
		"~": 0.4,
		"-": 0.4
	}
	for character in typing:
		var delay = 0.05  # 默认的打字间隔
		# 如果是当前角色，调整打字速度
		if pitch_scale.has(Global.current_character):
			var range = pitch_scale[Global.current_character]
			delay = range.delay
		# 额外处理标点符号的停顿
		if punctuation_delay.has(character):
			delay += punctuation_delay[character]  # 额外增加停顿
		typingTween.tween_callback(x.bind(character)).set_delay(delay)
	typingTween.tween_callback(Callable(self, "_on_typing_done"))


func _on_typing_done():
	isTyping = false
	doneTyping = true
	$CanvasLayer/DialogueText/NextIndicator.show()
	$CanvasLayer/DialogueText/NextIndicator/AnimationPlayer.play("next_indicator")
		
		
			
func _ButtonResponse(read_file):
	Global.optionAppear = true
	var JSONarray = read_file[Global.counter]
	Global.show_last_option_btn = false
	if not "have_unclock_option" in JSONarray:
		ShowButtonName(JSONarray,read_file,0)
	elif "have_unclock_option" in JSONarray:
		if Global.show_last_option:
			ShowButtonName(JSONarray,read_file,0)
		else:
			ShowButtonName(JSONarray,read_file,1)
		
			
func ShowButtonName(JSONarray, read_file, x):
	var options_size = JSONarray["options"].size() - x
	var first_btn = true
	for i in range(options_size):
		# 如果 stage1_full_complete 為 false，隱藏倒數第二個選項
		if "the_last_option" in JSONarray:
			if not Global.all_img_collect and i == options_size - 1:
				continue 
		var button = Button.new()
		
		if Global.attack_scene:
			button.custom_minimum_size = Vector2(300, 200)
		else:
			button.custom_minimum_size = Vector2(600, 60)
		
		button.set_meta("index", i)
		option_buttons.append(button)
		
		var label = Label.new()
		var the_font
		if Global.lang_man:
			the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			label.text = JSONarray["options"][i]["man_option"]
		if Global.lang_eng:
			the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
			label.text = JSONarray["options"][i]["eng_option"]
		if Global.lang_sim_man:
			the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
			label.text = JSONarray["options"][i]["man_sim_option"]
		if Global.lang_jp:
			the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			label.text = JSONarray["options"][i]["jp_option"]
		
		label.add_theme_font_override("font", the_font)
		label.add_theme_font_size_override("font_size", 19)
		label.add_theme_color_override("font_color", Color(0, 0, 0))
		
		var options = $CanvasLayer/Options
		if Global.attack_scene:
			var theme_res = preload("res://Others/option.tres")
			options.theme = theme_res
			options.columns = 2
			options.add_theme_constant_override("h_separation", 350)
			options.add_theme_constant_override("v_separation", 5)
			label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			label.custom_minimum_size = Vector2(230, 0)
			label.position = Vector2(37, -52)
			label.set_anchors_preset(Control.PRESET_CENTER_LEFT)
			button.add_child(label)  # 把 Label 放進 Button
			options.add_child(button)
		else:
			var theme_res = preload("res://Others/opt.tres")
			options.theme = theme_res
			options.columns = 1
			options.add_theme_constant_override("h_separation", 0)
			options.add_theme_constant_override("v_separation", 0)
			label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			label.custom_minimum_size = Vector2(500, 0)
			label.position = Vector2(50, -16)
			label.set_anchors_preset(Control.PRESET_CENTER_LEFT)
			button.add_child(label)  # 把 Label 放進 Button
			options.add_child(button)
			
		if first_btn:
			button.grab_focus()
			first_btn = false
		button.connect("pressed", Callable(self, "_SelectBtn").bind(i, read_file))  # 綁定事件


func _SelectBtn(i,read_file):
	# 当选项按钮被按下时执行
	if not isTyping and not doneTyping:
		if not "hide_last_option_btn" in read_file[Global.counter]:
			Global.show_last_option_btn = true
		Global.play_pick_chat_sound = true
		buttonAppear = false
		Global.buttonSelected = true
		Global.optionI = i
		Global.counterR = 0
		for child in $CanvasLayer/Options.get_children():
			child.queue_free()
		#直接套打字机效果
		_RespondStaff(read_file)
		
	
func _RespondStaff(read_file):
	var response_array = read_file[Global.counter]["options"][Global.optionI]["response"]
	var array_size = response_array.size()
	if Global.counterR < array_size:
		var current_response = response_array[Global.counterR]
		TextStaff(current_response)
					

func _CounterInc():
	if not Global.optionAppear and not buttonAppear and not Global.buttonSelected and not next_dialogue:
		#print("CounterInc1")
		Global.counter += 1
		
	if next_dialogue:# and not back_to_last_question_btn_pressed:
		#print("CounterInc2: counter b4: ", Global.counter)
		Global.counter += 1
		#print("CounterInc2: counter after: ", Global.counter)
		Global.counterR = 0
		Global.buttonSelected = false
		Global.optionAppear = false
		next_dialogue = false
		if in_class_redo:
			Global.counter = undo_counter
			in_class_redo = false
			
	if lose_next_dialogue:
		#print("lose_next_dialogue")
		Global.counter = 0  
		Global.counterR = 0
		Global.buttonSelected = false
		Global.optionAppear = false
		Global.lose_carrot_game = false
		Global.lose_demon_game = false
		Global.lose_church_game = false
		lose_next_dialogue = false
	
	_CheckDemonnpcDonutCount()
			
	if Global.buttonSelected:
		Global.counterR += 1
		#back_to_last_question_btn_pressed = false
	
func _CheckDemonnpcDonutCount():
	if Global.check_demonnpc_donut_count:
		if Global.task_1_get and Global.task_3_get:
			Global.place = "Map"
			Global.character_name = "DemonNpc_attack_both_donut"
			Global.counter = 0  
			Global.counterR = 0
		if (not Global.task_1_get and Global.task_3_get) or (Global.eat_road_side_donut_saved):
			Global.place = "Map"
			Global.character_name = "DemonNpc_attack_new_donut"
			Global.counter = 0  
			Global.counterR = 0
		read_file = Global._ReadFile()
		Global.check_demonnpc_donut_count = false	
					
func _has_options(JSONarray):
	return "options" in JSONarray and JSONarray["options"].size() > 0
	
	
var can_press = true
var current_pressed_key = ""

func _input(_event):
	if not isTyping:
		if Global.show_last_option_btn and Global.attack_scene:
			if Input.is_action_just_pressed("ui_undo"):
				_on_texture_button_pressed()
	if not Global.change_scene and not Global.open_comfirmation and dialogue_ready:
		if current_pressed_key == "":
			if Global.from_load and Global.attack_scene:
				#print("chat1")
				can_press = false
				current_pressed_key = "auto"
				PressFKey()
			if Input.is_action_just_pressed("ui_accept") and not Global.openMenu and can_press:		
				#print("chat2")
				can_press = false
				current_pressed_key = "ui_accept"	
				PressFKey()
			elif Input.is_action_just_pressed("Mouse_Left") and not Global.openMenu and can_press:
				var mouse_pos = get_viewport().get_mouse_position()
				if (mouse_pos.y > 100 and mouse_pos.x < 1060):
					#print("chat3")
					can_press = false
					current_pressed_key = "Mouse_Left"
					PressFKey()
		elif current_pressed_key == "Mouse_Left" and Input.is_action_just_released("Mouse_Left"):
			current_pressed_key = ""
			can_press = true
		elif current_pressed_key == "ui_accept" and Input.is_action_just_released("ui_accept"):
			current_pressed_key = ""
			can_press = true
		elif current_pressed_key == "auto":
			current_pressed_key = ""
			can_press = true
		
				
func PressFKey():
	
	print("Global.character_name ",Global.character_name,Global.counter)
	
	read_file = Global._ReadFile()
	if read_file != null:
		if Global.lose_carrot_game or Global.lose_demon_game or Global.lose_church_game:
			lose_next_dialogue = true
		
		if doneTyping:
			_CounterInc()
			doneTyping = false

		if Global.counter >= 0 and Global.counter < read_file.size():
			Global.startChat = true
			Global.startChat_for_non_attack = true
			Global.hide_esc = true
			Global.allow_move = false
			
			########################## Normal Dialogue ############################
		
			## For save file
			if Global.from_load and not Global.buttonSelected:
				_PrintDialogueText(read_file)
				Global.from_load = false
			
			var JSONarray = read_file[Global.counter]
			
			if isTyping and not Global.optionAppear and not Global.buttonSelected:#and not Global.from_load
				_PrintAllNormalDialogue(JSONarray)	
				#print("isTyping and no options")	
			else:
				if Global.optionAppear and isTyping and not Global.buttonSelected:
					print("has optionAppear and no button selected")
					_PrintAllNormalDialogue(JSONarray)
				if not Global.optionAppear and not isTyping and not Global.buttonSelected:
					#print("no has optionAppear no button selected")
					_PrintDialogueText(read_file)
					if Global.counter >= (read_file.size()-1):
						#print("reset at here")
						_ResetDialogue(JSONarray)
						
			########################## RespondStaff ############################
			if isTyping and _has_options(JSONarray) and Global.buttonSelected:
				if not "hide_last_option_btn" in JSONarray:
					Global.show_last_option_btn = true
				#print("has options")
				_PrintAllResponse(JSONarray)
				Global.from_load = false
				if Global.counterR >= (JSONarray["options"][Global.optionI]["response"].size() - 1):
					next_dialogue = true
			elif not isTyping and _has_options(JSONarray) and Global.buttonSelected:
				if not "hide_last_option_btn" in JSONarray:
					Global.show_last_option_btn = true
				#print("has button selected")
				_RespondStaff(read_file)
				Global.from_load = false
				if Global.counterR >= (JSONarray["options"][Global.optionI]["response"].size() - 1):
					next_dialogue = true
					
			
					
func _PrintAllNormalDialogue(JSONarray):
	if Global.lang_man:
		if "man_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["man_dialogue"])
	if Global.lang_jp:
		if "jp_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["jp_dialogue"])
	if Global.lang_sim_man:
		if "man_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["man_sim_dialogue"])
	if Global.lang_eng:
		if "eng_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["eng_dialogue"])
	
func _PrintAllResponse(JSONarray):
	if Global.lang_jp:
		if "jp_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["options"][Global.optionI]["response"][Global.counterR]["jp_dialogue"])
	if Global.lang_man:
		if "man_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["options"][Global.optionI]["response"][Global.counterR]["man_dialogue"])
	if Global.lang_sim_man:
		if "man_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["options"][Global.optionI]["response"][Global.counterR]["man_sim_dialogue"])		
	if Global.lang_eng:
		if "eng_dialogue" in JSONarray:
			_PrintAllDialogueText(JSONarray["options"][Global.optionI]["response"][Global.counterR]["eng_dialogue"])	

func _ResetDialogue(JSONarray):
	Global.show_last_option_btn = false
	var current_num = Global._ReadNum()  # 获取当前 num
	#print(current_num + " before")
	current_num = str(int(current_num) + 1)  # num 加 1
	#print(current_num + " after")
	var readMaxNum = Global._ReadMaxNum()
	
	if int(current_num) >  int(readMaxNum):
		current_num = str(readMaxNum)
	Global._WriteNum(current_num)

func _CloseDialogue():	
	Global.counter = 0  
	Global.counterR = 0
	Global.optionAppear = false
	Global.buttonSelected = false
	Global.startChat = false
	Global.allow_move = true
	Global.close_mark = true
	Global.hide_esc = false
	$CanvasLayer/DialogueText.hide()
	#Global.interaction = false
	
func _PrintAllDialogueText(x):
	if typingTween:
		typingTween.kill() 
	$CanvasLayer/DialogueText/DialogueText.text = x
	_on_typing_done()
	


#############################################################	
#############################################################
	
	
func store_name_by_JSON(JSONarray):
	if "jp_mention" in JSONarray:
		jp_mention_text = "[wave][font=res://Dialogue/DialogueTextFile/Cubic_11.ttf]" + JSONarray["jp_mention"] + "[/font][/wave]"
	if "man_mention" in JSONarray:
		man_mention_text = "[wave][font=res://Dialogue/DialogueTextFile/Cubic_11.ttf]" + JSONarray["man_mention"] + "[/font][/wave]"
	if "man_sim_mention" in JSONarray:
		man_sim_mention_text = "[wave][font=res://Dialogue/DialogueTextFile/Cubic_11.ttf]" + JSONarray["man_sim_mention"] + "[/font][/wave]"
	if "eng_mention" in JSONarray:
		eng_mention_text = "[wave][font=res://Dialogue/DialogueTextFile/Cubic_11.ttf]" + JSONarray["eng_mention"] + "[/font][/wave]"
	if "man_name" in JSONarray:
		man_name = JSONarray["man_name"]
	if "eng_name" in JSONarray:
		eng_name = JSONarray["eng_name"]
	if "man_sim_name" in JSONarray:
		man_sim_name = JSONarray["man_sim_name"]
	if "jp_name" in JSONarray:
		jp_name = JSONarray["jp_name"]
	if "man_dialogue" in JSONarray:
		man_chat = JSONarray["man_dialogue"]
	if "eng_dialogue" in JSONarray:			
		eng_chat = JSONarray["eng_dialogue"]
	if "man_sim_dialogue" in JSONarray:
		man_sim_chat = JSONarray["man_sim_dialogue"]
	if "jp_dialogue" in JSONarray:
		jp_chat = JSONarray["jp_dialogue"]
	
func play_by_JSON(JSONarray):
	if "avatar" in JSONarray:
		$CanvasLayer/DialogueText/CharacterName/avatar.show()
		$CanvasLayer/DialogueText/CharacterName/avatar.play(JSONarray["avatar"])
	else:
		$CanvasLayer/DialogueText/CharacterName/avatar.hide()
	
	#只有king attack那邊用到
	if "show_last_option_btn" in JSONarray:
			display_last_option_btn = true
			Global.show_last_option_btn = true
	else:
		display_last_option_btn = false
		
	if "give_map" in JSONarray:
		$CanvasLayer/ForTask.texture = preload("res://Images/items/map.png")
		$CanvasLayer/AnimationPlayer.play("task")
		Global.give_map = true
	if "get_task" in JSONarray:
		Global.get_task = true
		Global.play_new_task_animation = true
	if "full_lives" in JSONarray:
		Global.lives = int(JSONarray["full_lives"])
	if "full_lives_opp" in JSONarray:
		Global.lives_opp = int(JSONarray["full_lives_opp"])
	if "for_the_next" in JSONarray:
		Global.for_the_next = true
	if "dirty" in JSONarray:
		Global.dirty = true
	if "mom_win" in JSONarray:
		Global.mom_win = false
	if "feed_you" in JSONarray:
		Global.feed_you = true
	if "back_pos" in JSONarray:
		Global.last_scene_name = JSONarray["back_pos"]
	if "bites" in JSONarray:
		Global.bites += 1
	if "food_num" in JSONarray:
		Global.food_num += 1
	if "stage_2_corridor_done" in JSONarray:
		Global.stage_2_corridor_done = true
	if "stage_2_room_done" in JSONarray:
		Global.stage_2_room_done = true
	if "carrot_leave_room" in JSONarray:
		Global.carrot_leave_room = true		
	if "play_tutorial_animation" in JSONarray:
		Global.play_tutorial_animation = true
	if "startChat_for_non_attack" in JSONarray:
		Global.startChat_for_non_attack = false
	if "play_quit_animation" in JSONarray:
		Global.play_quit_animation = true
	if "in_class_redo" in JSONarray:
		undo_counter = int(JSONarray["in_class_redo"])
		in_class_redo = true
	if "demon_love" in JSONarray:
		Global.demon_love = true
	if "food_ending" in JSONarray:
		Global.food_ending = true
	if "add_heart" in JSONarray:
		Global.add_heart = true
	if "demon_green" in JSONarray:
		Global.demon_green = true
	if "demon_marry" in JSONarray:
		Global.demon_marry = true
	if "me_dry" in JSONarray:
		Global.me_dry = true
	if "check_demonnpc_donut_count" in JSONarray:
		Global.check_demonnpc_donut_count = true
	if "move_true" in JSONarray:
		Global.move = true
	if "move_king" in JSONarray:
		Global.move_king = true
	if "police_ending" in JSONarray:
		Global.police_ending = true
	if "princess_leave" in JSONarray:
		Global.princess_leave = true
	if "princess_move" in JSONarray:
		Global.princess_move = true
	if "show_kid" in JSONarray:
		Global.show_kid = true
	if "king_cave_move" in JSONarray:
		Global.king_cave_move = true
	if "show_otaku" in JSONarray:
		Global.show_otaku = true	
	if "get_out_otaku" in JSONarray:
		Global.get_out_otaku = true
	if "get_out_teacher" in JSONarray:
		Global.get_out_teacher = true	
	if "run_otaku" in JSONarray:
		Global.run_otaku = true
	if "princess_angry" in JSONarray:
		Global.princess_angry = true
	if "marry_queen" in JSONarray:
		Global.marry_queen = true
	if "play_false_animation" in JSONarray:
		Global.play_false_animation = true
	if "play_punch_sound" in JSONarray:
		Global.play_punch_sound = true
	if "restore_health" in JSONarray:
		Global.restore_health = true
	if "show_last_option_nun" in JSONarray:
		Global.show_last_option_nun = true
	if "show_last_option_otaku" in JSONarray:
		Global.show_last_option_otaku = true
	if "show_last_option_kid" in JSONarray:
		Global.show_last_option_kid = true
	if "kid_enter_room" in JSONarray:
		Global.kid_enter_room = true
		Global.play_new_task_animation = true
	if "teacher_leave_class" in JSONarray:
		Global.teacher_leave_class = true
	if "teacher_stalker" in JSONarray:
		Global.teacher_stalker = true
	if "i_am_student" in JSONarray:
		Global.i_am_student = true
	if "new_student" in JSONarray:
		Global.new_student = true
	if not Global.from_load:
		if "false" in JSONarray:
			Global.lives -= 1
			Global.heart_once = true
			Global.play_false_animation = true
			Global.play_punch_sound = true
		if "false_opp" in JSONarray:
			Global.lives_opp -= 1
			Global.heart_once = true
			Global.play_false_animation = true
			Global.play_punch_sound = true
	
func play_transition_by_JSON(JSONarray):
	if JSONarray.has("transition"):
		var transition = JSONarray["transition"]
		match transition:
			"kid":
				$"../AnimatedSprite2D".material.set("shader_parameter/shadow_enabled", true)
				$"../AnimatedSprite2D".material.set("shader_parameter/shadow_strength", 0.4)
				$"../Kid".material.set("shader_parameter/shadow_enabled", false)
				Global.transition = transition
			"carrot":
				$"../Kid".material.set("shader_parameter/shadow_enabled", true)
				$"../Kid".material.set("shader_parameter/shadow_strength", 0.4)
				$"../AnimatedSprite2D".material.set("shader_parameter/shadow_enabled", false)
				Global.transition = transition
				
func play_animations_by_JSON(JSONarray):
	if "animation" in JSONarray:
		if JSONarray["animation"] == "ending11_2":
			$"../AnimatedSprite2D".play(JSONarray["animation"])
			await $"../AnimatedSprite2D".animation_finished
			$"../AnimatedSprite2D".play("ending11_3")
		else:
			$"../AnimatedSprite2D".play(JSONarray["animation"])
			Global.current_animation = str(JSONarray["animation"])
	if "animation_banner" in JSONarray:
		$"../AnimationPlayer3".play(JSONarray["animation_banner"])
	if "animation_kid" in JSONarray:
		$"../Kid".play(JSONarray["animation_kid"])
		Global.current_animation_kid = str(JSONarray["animation_kid"])
	if "ani_mummy" in JSONarray:
		$"../mummy/AniMummy".play(JSONarray["ani_mummy"])
	if "ani_scene" in JSONarray:
		$"../scene_animation".play(JSONarray["ani_scene"])
	if "ani_king" in JSONarray:
		$"../king/AnimatedSprite2D".play(JSONarray["ani_king"])
	if "ani_princess" in JSONarray:
		$"../Princess/AniPrincess".play(JSONarray["ani_princess"])
	if "ani_demon" in JSONarray:
		$"../demon/AniDemon".play(JSONarray["ani_demon"])
	if "ani_char" in JSONarray:
		$"../char".play(JSONarray["ani_char"])
	if "ani_ending" in JSONarray:
		$"../Background".play(JSONarray["ani_ending"])
	if "aniBusker" in JSONarray:
		$"../Busker/AniBusker".play(JSONarray["aniBusker"])
	if "ani_effect" in JSONarray:
		$CanvasLayer/AnimationPlayer.play(JSONarray["ani_effect"])
	if "animateQMe" in JSONarray:
		if Global.stage2_done:
			$"../me2/animationQ".play(JSONarray["animateQMe"])
			Global.current_me_texture = JSONarray["animateQMe"]
		else:
			$"../me/animationQ".play(JSONarray["animateQMe"])
	if "animateQPink" in JSONarray:
		$"../Pink/animationQ".play(JSONarray["animateQPink"])
	if "ani_chatbox" in JSONarray:
		$CanvasLayer/AnimationDialogue.play(JSONarray["ani_chatbox"])
	if "ani_otaku" in JSONarray:
		$"../otaku/AnimatedSprite2D".play(JSONarray["ani_otaku"])
	if "ani_kid" in JSONarray:
		$"../RandomKid/AnimatedSprite2D".play(JSONarray["ani_kid"])
	if "ani_teacher" in JSONarray:
		$"../Teacher/AnimatedSprite2D".play(JSONarray["ani_teacher"])
	if "ani_kidB" in JSONarray:
		$"../KidB/AnimatedSprite2D".play(JSONarray["ani_kidB"])
	if "ani_kidC" in JSONarray:
		$"../KidC/AnimatedSprite2D".play(JSONarray["ani_kidC"])
	if "ani_kidD" in JSONarray:
		$"../KidD/AnimatedSprite2D".play(JSONarray["ani_kidD"])
	if "ani_player" in JSONarray:
		Global.wait = true
		$"../Player/Camera2D/AnimationPlayer".play(JSONarray["ani_player"])
		await $"../Player/Camera2D/AnimationPlayer".animation_finished
		$"../Player/Camera2D/AnimationPlayer".play_backwards(JSONarray["ani_player"])
		Global.wait = false
	if "ani_left" in JSONarray:
		$"../DemonNpc/AnimatedSprite2D".play(JSONarray["ani_left"])
	if "ani_right" in JSONarray:
		$"../DemonNpc/AnimatedSprite2D2".play(JSONarray["ani_right"])
	if "ani_police" in JSONarray:
		$"../PolicemanSerious/policeman_animation".play(JSONarray["ani_police"])
	
func background_song(JSONarray):
	if "background_song" in JSONarray:
		if JSONarray["background_song"] == "menu":
			Global.play_menu_song = true
		if JSONarray["background_song"] == "no":
			Global.play_no_song = true
		if JSONarray["background_song"] == "battle":
			Global.play_battle_song = true
		if JSONarray["background_song"] == "war":
			Global.play_war_song = true
		if JSONarray["background_song"] == "happy":
			Global.play_happy_song = true
		if JSONarray["background_song"] == "comedy":
			Global.play_comedy_song = true
		if JSONarray["background_song"] == "calm":
			Global.play_indoor_song = true

func done_function_in_JSON(JSONarray):
	if "done" in JSONarray:
		if JSONarray["done"] == "change_for_green":
			Global.change_for_green = true
		if JSONarray["done"] == "cave_done":
			Global.cave_done = true
		if JSONarray["done"] == "check_ending":
			Global.check_ending = true
		if JSONarray["done"] == "king_tutorial":
			Global.king_tutorial = true
		if JSONarray["done"] == "king_go":
			Global.king_go = true
			Global.play_new_task_animation = true
		if JSONarray["done"] == "stage_2_3_options":
			Global.stage_2_3_options = true
		if JSONarray["done"] == "church_done":
			Global.church_done = true
			Global.play_completed_task_animation = true
		if JSONarray["done"] == "big_mon_done":
			Global.big_mon_done = true
		if JSONarray["done"] == "w_1_done":
			Global.w_1_done = true
		if JSONarray["done"] == "stage1_done":
			Global.stage1_done = true
			Global.play_completed_task_animation = true
		if JSONarray["done"] == "stage2_done":
			Global.stage2_done = true
		if JSONarray["done"] == "task_1_get":
			$CanvasLayer/ForTask.texture = preload("res://Images/UI/donut.png")
			$CanvasLayer/AnimationPlayer.play("task")
			Global.task_1_get = true
			Global.play_completed_task_animation = true
		if JSONarray["done"] == "task_2_get":
			$CanvasLayer/ForTask.texture = preload("res://Images/UI/t-shirt.png")
			$CanvasLayer/AnimationPlayer.play("task")
			Global.task_2_get = true
			Global.play_completed_task_animation = true
		if JSONarray["done"] == "task_3_get":
			$CanvasLayer/ForTask.texture = preload("res://Images/UI/donut2.png")
			$CanvasLayer/AnimationPlayer.play("task")
			Global.task_3_get = true
			Global.play_completed_task_animation = true
		if JSONarray["done"] == "photo_queen":
			$CanvasLayer/ForTask.texture = preload("res://Images/mirror/hero_school.png")
			$CanvasLayer/AnimationPlayer.play("photo")
		if JSONarray["done"] == "photo_hero":
			$CanvasLayer/ForTask.texture = preload("res://Images/mirror/hero_photo.png")
			$CanvasLayer/AnimationPlayer.play("photo")
		if JSONarray["done"] == "photo_queen_back":
			$CanvasLayer/AnimationPlayer.play("photo_back")
		if JSONarray["done"] == "photo_hero_back":
			$CanvasLayer/AnimationPlayer.play("photo_back")
		if JSONarray["done"] == "demon_npc_died":
			Global.demon_npc_died = true
		if JSONarray["done"] == "setposition":
			Global.setposition = true
		if JSONarray["done"] == "cave_entrance_done":
			Global.cave_entrance_done = true
		if JSONarray["done"] == "get_rob":
			Global.get_rob = true
			for item in Global.items:
				if item["name"] == "battle_suit":
					Global.items.erase(item)
				if item["name"] == "donut":
					Global.items.erase(item)
				if item["name"] == "donut_puffer":
					Global.items.erase(item)
		if JSONarray["done"] == "church_get_task":
			if not Global.church_get_task:
				Global.play_new_task_animation = true
			Global.church_get_task = true
		if JSONarray["done"] == "church_request":
			Global.church_request = true
		if JSONarray["done"] == "move_to_church":
			Global.move_to_church = true
			Global.play_completed_task_animation = true
		if JSONarray["done"] == "pos_to_chair_police":
			Global.pos_to_chair_police = true
		if JSONarray["done"] == "ending1":
			Global.ending1 = true
			Steam.setAchievement("ach_imout")
			Global.save_ending()
		if JSONarray["done"] == "ending2":
			Global.ending2 = true
			Steam.setAchievement("ach_demon_king_love")
			Global.save_ending()
		if JSONarray["done"] == "ending3":
			Global.ending3 = true
			Steam.setAchievement("ach_marry_demon_king")
			Global.save_ending()
		if JSONarray["done"] == "ending4":
			Global.ending4 = true
			Steam.setAchievement("ach_underword_wedding")
			Global.save_ending()
		if JSONarray["done"] == "ending5":
			Global.ending5 = true
			Steam.setAchievement("ach_carrot_social_death")
			Global.save_ending()
		if JSONarray["done"] == "ending6":
			Global.ending6 = true
			Steam.setAchievement("ach_homeless")
			Global.save_ending()
		if JSONarray["done"] == "ending7":
			Global.ending7 = true
			Steam.setAchievement("ach_overeating")
			Global.save_ending()
		if JSONarray["done"] == "ending8":
			Global.ending8 = true
			Steam.setAchievement("ach_call_police")
			Global.save_ending()
		if JSONarray["done"] == "ending9":
			Global.ending9 = true
			Steam.setAchievement("ach_ate_by_princess")
			Global.save_ending()
		if JSONarray["done"] == "ending10":
			Global.ending10 = true
			Steam.setAchievement("ach_green_love")
			Global.save_ending()
		if JSONarray["done"] == "ending11":
			Global.ending11 = true
			Steam.setAchievement("ach_non_violent_hero")
			Global.save_ending()
		if JSONarray["done"] == "ending12":
			Global.ending12 = true
			Steam.setAchievement("ach_violent_hero")
			Global.save_ending()
		if JSONarray["done"] == "ending13":
			Global.ending13 = true
			Steam.setAchievement("ach_puffer_donut_hero")
			Global.save_ending()

func steam_ach(JSONarray):
	if "ach_too_easy" in JSONarray:
		Steam.setAchievement("ach_too_easy")
	if "ach_smug_king" in JSONarray:
		Steam.setAchievement("ach_smug_king")
	if "ach_clean_chair" in JSONarray:
		Steam.setAchievement("ach_clean_chair")
	if "ach_class_in_session" in JSONarray:
		Steam.setAchievement("ach_class_in_session")
	if "ach_love_teacher" in JSONarray:
		Steam.setAchievement("ach_love_teacher")
	if "ach_takeover_class" in JSONarray:
		Steam.setAchievement("ach_takeover_class")
	if "ach_im_student" in JSONarray:
		Steam.setAchievement("ach_im_student")
	Steam.storeStats()
		
		
			

	
func _on_save_pressed():
	Global.isSave = true
	get_tree().change_scene_to_file("res://SaveFile/loadfile.tscn")

func _on_load_pressed():
	Global.isLoad = true
	get_tree().change_scene_to_file("res://SaveFile/loadfile.tscn")

func _process(_delta):
	if not isTyping:
		if Global.show_last_option_btn and Global.attack_scene:
			$CanvasLayer/BackToLastQuestion.show()
	else:
		$CanvasLayer/BackToLastQuestion.hide()
	
	if Global.change_language and Global.attack_scene:
		if Global.lang_jp:
			print("jp")
			var the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.text = jp_name
			$CanvasLayer/DialogueText/DialogueText.text = jp_chat
			$CanvasLayer/DialogueText.show()
			if Global.mention_appear:
				$CanvasLayer/MentionText.show()
				$CanvasLayer/MentionText.text = jp_mention_text
		if Global.lang_man:
			print("man")
			var the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.text = man_name
			$CanvasLayer/DialogueText/DialogueText.text = man_chat
			$CanvasLayer/DialogueText.show()
			if Global.mention_appear:
				$CanvasLayer/MentionText.show()
				$CanvasLayer/MentionText.text = man_mention_text
		if Global.lang_sim_man:
			print("sim_man")
			var the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
			$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.text = man_sim_name
			$CanvasLayer/DialogueText/DialogueText.text = man_sim_chat
			$CanvasLayer/DialogueText.show()
			if Global.mention_appear:
				$CanvasLayer/MentionText.show()
				$CanvasLayer/MentionText.text = man_sim_mention_text
		if Global.lang_eng:
			print("eng")
			var the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
			$CanvasLayer/DialogueText/DialogueText.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.add_theme_font_override("font", the_font)
			$CanvasLayer/DialogueText/CharacterName.text = eng_name
			$CanvasLayer/DialogueText/DialogueText.text = eng_chat
			$CanvasLayer/DialogueText.show()
			if Global.mention_appear:
				$CanvasLayer/MentionText.show()
				$CanvasLayer/MentionText.text = eng_mention_text
		UpdateOptionLanguage()
		Global.change_language = false
		
	if Global.attack_scene:
		if Global.from_load or Global.pressed_close_menu:
			GrabButtonHover()


func GrabButtonHover():
	for button in option_buttons:
		if !is_instance_valid(button):
			continue
		button.grab_focus()
		Global.pressed_close_menu = false
		return
	
	
func UpdateOptionLanguage():
	if read_file != null:
		if Global.counter >= 0 and Global.counter < read_file.size():
			var JSONarray = read_file[Global.counter]
			for button in option_buttons:
				if !is_instance_valid(button):
					continue
				var index = button.get_meta("index")
				var label = button.get_child(0)
				var the_font
				if Global.lang_eng:
					the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
					label.text = JSONarray["options"][index]["eng_option"]
				elif Global.lang_man:
					the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
					label.text = JSONarray["options"][index]["man_option"]
				elif Global.lang_sim_man:
					the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
					label.text = JSONarray["options"][index]["man_sim_option"]
				elif Global.lang_jp:
					the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
					label.text = JSONarray["options"][index]["jp_option"]
				label.add_theme_font_override("font", the_font)


func _on_texture_button_pressed() -> void:
	#dialogue_ready = false
	if not display_last_option_btn:
		in_class_redo = false
		next_dialogue = false
		Global.buttonSelected = false
		#back_to_last_question_btn_pressed = true
		Global.last_option_btn_pressed = true
		Global.show_last_option_btn = false
		Global.counter = Global.last_option_counter
		Global.counterR = 0
		if read_file != null:
			if Global.counter >= 0 and Global.counter < read_file.size():
				var JSONarray = read_file[Global.counter]
				_PrintDialogueText(read_file)
