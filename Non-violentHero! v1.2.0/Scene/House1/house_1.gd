extends Node2D

var bed = false
var closet = false
var book = false
var in_area = false

var once = true
var JSONarray
var input_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "粉章魚的家"
	Global.save_place_eng = "Pink Octopus's House"	
	Global.save_place_sim_man = "粉章鱼的家"
	Global.save_place_jp = "ピンクタコの家"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/MerchCity.ogg":
		Global.play_indoor_song = false
		
	if Global.pink_otopus_bed_dirty:
		$deco1.set_cell(Vector2i(19,1), 7, Vector2i(1,8))
	$deco1.set_cell(Vector2i(9,1), 7, Vector2i(3,2))
	Global.from_load = false
	Global.attack_scene = false
	Global.last_scene_name = "house_1"
	Global.previous_scene = "res://SceneTransTscn/house_1.tscn"
	Global.startChat_for_non_attack = false
	Global.player = true
	Global.current_character = "pink"
	if Global.entered_house1:
		Global.place = "Map"
		Global.character_name = "Pink_after"
	else:
		Global.place = "Map"
		Global.character_name = "Pink"
		Steam.setAchievement("ach_rude_hero")
		Steam.storeStats()
	if Global.from_load or Global.file_load:
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false
	else:
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			dialogue_node.PressFKey()
	Global.entered_house1 = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if in_area:
		Global.hide_esc = true
	#else:
		#Global.hide_esc = false
		
	ComfirmationAction()
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
	
	if $Player.pressed_yes:
		ItemInteraction()
		Actions()
		$Player.pressed_yes = false
	if $Player.pressed_no:
		$Dialogue.current_pressed_key = ""
		$Dialogue.can_press = true
		$Player.pressed_no = false
		
	if Global.pink_otopus_bed and Global.pink_closet and Global.pink_otopus_book:
		Steam.setAchievement("ach_pink_octopus_house")
		Steam.storeStats()
		
				
func _input(_event):
	if in_area and Input.is_action_pressed("ui_accept") or in_area and Input.is_action_pressed("Mouse_Left"):
		input_pressed = true
		
func ComfirmationAction():
	if input_pressed:
		if not Global.interaction:
			$Player/CanvasLayer/Comfirmation.show()
			$Player/CanvasLayer.layer = 2
			if not $Player.pressed:
				$Player/CanvasLayer/Comfirmation/Yes.grab_focus()
				$Player.pressed = true
			Global.open_comfirmation = true
			Global.startChat_for_non_attack = true
		
		var read_file = Global._ReadInteractFile()
		if read_file != null:
			JSONarray = read_file[0]
			var the_font
			if Global.lang_jp:
				the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
				if "text_jp" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_jp"]
			if Global.lang_man:
				the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
				if "text_man" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_man"]
			if Global.lang_sim_man:
				the_font = preload("res://Dialogue/DialogueTextFile/ZCOOLXiaoWei-Regular.ttf")
				if "text_sim_man" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_sim_man"]
			if Global.lang_eng:
				the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
				if "text_eng" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_eng"]
			$Player/CanvasLayer/Comfirmation/text.add_theme_font_override("font", the_font)
		if Global.close_mark:
			once = true
			Global.interaction = false
			Global.close_mark = false
			if bed:
				$TextureRect.show()
				$IndicatorAni.play("play_bed")
			if closet:
				$TextureRect.show()
				$IndicatorAni.play("play_closet")
			if book:
				$TextureRect.show()
				$IndicatorAni.play("play_book")
		input_pressed = false


func ItemInteraction():
	if bed:
		Global.pink_otopus_bed = true
		Global.play_bed_sound = true
		if Global.dirty:
			$deco1.set_cell(Vector2i(19,1), 7, Vector2i(1,8))
			Global.place = "Map"
			Global.character_name = "Pink_bed_dirty"
			Global.pink_otopus_bed_dirty = true
			Steam.setAchievement("ach_rude_dirty_hero")
			Steam.storeStats()
		else:
			Global.place = "Map"
			Global.character_name = "Pink_bed"
		var dialogue_node = get_node("Dialogue")
		if dialogue_node and once:
			once = false
			dialogue_node.PressFKey()
	if closet:
		Global.place = "Map"
		Global.character_name = "Pink_closet"
		Global.pink_closet = true
		var dialogue_node = get_node("Dialogue")
		if dialogue_node and once:
			once = false
			dialogue_node.PressFKey()
		$deco1.set_cell(Vector2i(9,1), 7, Vector2i(1,3))
	if book:
		Global.place = "Map"
		Global.character_name = "Pink_book"
		Global.pink_otopus_book = true
		var dialogue_node = get_node("Dialogue")
		if dialogue_node and once:
			once = false
			dialogue_node.PressFKey()


func Actions():
	if JSONarray != null:
		if "action" in JSONarray:
			var target_node_path = JSONarray["action"]
			var target_node = get_node_or_null(target_node_path)  # 使用 get_node_or_null 以防节点不存在
			if target_node:
				$Player.position = target_node.position  # 更新玩家位置
			else:
				print("Node not found: ", target_node_path)
		if "ani_player" in JSONarray:
			$Player/AnimatedSprite2D.play(JSONarray["ani_player"])
		$Player/CanvasLayer/Comfirmation.hide()
		$TextureRect.hide()
				

func _on_king_outside_body_exited(body):
	if body.name == "Player":
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false


func _on_bed_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		bed = true
		in_area = true
		Global.place = "house1"
		Global.item = "bed"
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect.show()
		$IndicatorAni.play("play_bed")
		$Pink/animationQ.play("back")
func _on_bed_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		bed = false
		PlayerExited()

func _on_closet_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_area = true
		closet = true
		Global.place = "house1"
		Global.item = "closet"
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect.show()
		$IndicatorAni.play("play_closet")
		$Pink/animationQ.play("back")
func _on_closet_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		closet = false
		$deco1.set_cell(Vector2i(9,1), 7, Vector2i(3,2))
		PlayerExited()

func _on_book_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_area = true
		book = true
		Global.place = "house1"
		Global.item = "book"
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect.show()
		$IndicatorAni.play("play_book")
		$Pink/animationQ.play("side")
func _on_book_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		book = false
		PlayerExited()

func PlayerExited():
	once = true
	in_area = false
	Global.place = ""
	Global.item = ""
	$TextureRect.hide()
	$IndicatorAni.play("RESET")
	Global.hide_esc = false
	Global.interaction = false
	Global.close_mark = false
