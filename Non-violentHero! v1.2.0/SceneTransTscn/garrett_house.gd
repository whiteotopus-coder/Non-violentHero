extends Node2D

var in_cross_area = false
var cross = false
var current_pressed_key = ""
var if_have_cross = false

# Called when the node enters the scene tree for the first time.
func _ready():
	##################### write in save file ###################################
	Global.save_place_man = "羅太太家"
	Global.save_place_eng = "Mrs. Karen Garrett House"
	Global.save_place_sim_man = "罗太太家"
	Global.save_place_jp = "クレーマー母の家"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.play_no_song = false
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/garrett_house.tscn"
	Global.counter = 0
	Global.startChat = false
	Global.startChat_for_non_attack = false
	Global.last_scene_name = "garrett_house"
	Global.garrett_house = true
	$Control/CanvasLayer.layer = 2
	$Dialogue/CanvasLayer.layer = 3
	if Global.put_cross:
		$grave.set_cell(Vector2i(14,-1), 0, Vector2i(6,4))
		$Carrot.position = $PosCarrot.position
		$Carrot/areaTalk/areaTalk.disabled = true
		$Carrot/AnimatedSprite2D.play("sleep")
		Steam.setAchievement("ach_cross")
		Steam.storeStats()
	else:
		$grave.set_cell(Vector2i(14,-1), -1)
	for item in Global.items:
		if (item.has("name") and item["name"] == "cross"):
			if_have_cross = true
			
func _ForInteract(x):
	var read_file = Global._ReadInteractFile()
	if read_file != null:
		var JSONarray = read_file[0]
		$Player/CanvasLayer/Comfirmation.show()
		await get_tree().process_frame
		$Player/CanvasLayer/Comfirmation/Yes.grab_focus()
		$Player/CanvasLayer.layer = 3
		$Player.in_area = true
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
		Global.open_comfirmation = true
							
func _process(_delta):
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
	if Global.interaction:
		$grave.set_cell(Vector2i(14,-1), 0, Vector2i(6,4))
		Global.place = "Map"
		Global.character_name = "Carrot_grave"
		Global.put_cross = true
		for item in Global.items:
			if item.has("name") and item["name"] == "cross":
				Global.items.erase(item)
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			dialogue_node.PressFKey()
		Global.startChat_for_non_attack = true
		Global.openMenu = false
		Global.interaction = false
		Global.allow_move = false

func _on_grave_body_entered(body: Node2D) -> void:
	if not Global.put_cross:
		if if_have_cross:
			in_cross_area = true
			Global.place = "carrot_house"
			Global.item = "cross"
			$Chat.show()
			$AnimationPlayer.play("grave")
			Global.startChat_for_non_attack = true
			Global.openMenu = true
			Global.allow_move = true

func _on_grave_body_exited(body: Node2D) -> void:
	in_cross_area = false
	$Player.in_area = false
	Global.place = ""
	Global.character_name = ""
	Global.startChat_for_non_attack = false
	Global.openMenu = false
	Global.allow_move = false
	$Chat.hide()
	$Player.can_press = true


func _input(event: InputEvent) -> void:
	if in_cross_area and not Global.put_cross and $Player.can_press:
		
		if Input.is_action_pressed("ui_accept"):	
			$Player.can_press = false
			current_pressed_key = "ui_accept"
			_ForInteract(cross)
		if Input.is_action_pressed("Mouse_Left"):		
			$Player.can_press = false
			current_pressed_key = "Mouse_Left"
			_ForInteract(cross)
			
		if current_pressed_key == "ui_accept" and Input.is_action_just_released("ui_accept"):
			current_pressed_key = ""
			$Player.can_press = true
		elif current_pressed_key == "Mouse_Left" and Input.is_action_just_released("Mouse_Left"):
			current_pressed_key = ""
			$Player.can_press = true
