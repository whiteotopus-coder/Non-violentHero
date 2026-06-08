extends Node2D

var in_food_area = false
var once = true
var outside = false
var once_player = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "肥宅家"
	Global.save_place_sim_man = "肥宅家"
	Global.save_place_eng = "Otaku's House"
	Global.save_place_jp = "オタクの家"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/MerchCity.ogg":
		Global.play_indoor_song = true
	Global.from_load = false
	Global.file_load = false
	Global.attack_scene = false
	Global.last_scene_name = "stage_2"
	Global.previous_scene = "res://SceneTransTscn/stage_2.tscn"
	Global.startChat_for_non_attack = false
	Global.startChat = false
	Global.stage_2_corridor = false
	outside = true
	
	if Global.toilet_otaku:
		$Player.position = $toilet.position
		Global.toilet_otaku = false
	
	if Global.stage_2_position:
		$Player.position = $stage_2.position
		Global.stage_2_position = false
		
	#第一次進來才過來講話
	if not Global.stage_2_met:
		if Global.stage_2_3_options:
			Global.current_character = "aunty"
			Global.place = "Map"
			Global.character_name = "Mummy_stage2_3_options"
		else:
			Global.current_character = "aunty"
			Global.place = "Map"
			Global.character_name = "Mummy_stage2"
			Global.stage_2_3_options = true
		$Player/AnimatedSprite2D.play("idle_up")
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			dialogue_node.PressFKey()
	
	if Global.show_last_option_otaku:
		Global.show_last_option = true
		
	if Global.bites == 1:
		$food.frame = 0
	if Global.bites == 2:
		$food.frame = 1		
	if Global.bites == 3:
		$food.frame = 2
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.feed_you:
		$food.show()
		
		if in_food_area:
			Global.startChat_for_non_attack = true
		
		if in_food_area and Input.is_action_pressed("ui_accept") or in_food_area and Input.is_action_pressed("Mouse_Left"):
			
			if Global.bites == 1:
				Global.place = "Map"
				Global.character_name = "Mummy_food_1"
				outside = false
				var dialogue_node = get_node("Dialogue")
				if dialogue_node and once:
					dialogue_node.PressFKey()
					once = false
				if Global.food_num == 0:
					$food.frame = 3
				if Global.food_num == 1:
					$food.frame = 1
					
			if Global.bites == 2:
				Global.place = "Map"
				Global.character_name = "Mummy_food_2"
				if outside:
					var dialogue_node = get_node("Dialogue")
					if dialogue_node:
						dialogue_node.PressFKey()
				outside = false
				if Global.food_num == 2:
					$food.frame = 3
				if Global.food_num == 3:
					$food.frame = 2
					
			if Global.bites == 3:
				Global.place = "Map"
				Global.character_name = "Mummy_food_3"
				if outside:
					var dialogue_node = get_node("Dialogue")
					if dialogue_node:
						dialogue_node.PressFKey()
				outside = false
				if Global.food_num == 4:
					$food.frame = 3
					if once_player:
						$Player/AnimatedSprite2D.play("die")
						once_player = false
			
func _on_mummyarea_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		Global.current_character = "aunty"
		Global.place = "Map"
		Global.character_name = "Mummy"
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("mummy")

func _on_mummyarea_body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.place = ""
		Global.character_name = ""
		Global.current_character = ""
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")



func _on_foodarea_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		in_food_area = true
		Global.current_character = "aunty"
		if Global.feed_you:
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/prompt.png")
			$TextureRect/AnimationPlayer.play("food")
	
func _on_foodarea_body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.startChat_for_non_attack = false
		in_food_area = false
		outside = true
		Global.place = ""
		Global.character_name = ""
		Global.current_character = ""
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")
