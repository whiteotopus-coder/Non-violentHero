extends Node2D

var once = false
var Otaku_door_area = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "肥宅家二樓"
	Global.save_place_sim_man = "肥宅家二楼"
	Global.save_place_eng = "Otaku's House 2nd floor"
	Global.save_place_jp = "オタクの家の2階"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/MerchCity.ogg":
		Global.play_indoor_song = true
	Global.from_load = false
	Global.file_load = false
	Global.previous_scene = "res://SceneTransTscn/stage_2_corridor.tscn"
	Global.attack_scene = false
	Global.startChat_for_non_attack = false
	#確保選擇了上樓的選項
	Global.stage_2_met = true
	#給媽咪的animation的
	Global.stage_2_corridor = true
	
	if Global.stage_2_position:
		$Player.position = $stage_2_corridor.position
	if not Global.stage_2_position:
		Global.stage_2_position = true
		
	#進肥宅門前的話
	if not Global.stage_2_corridor_done:
		Global.current_character = "aunty"
		Global.place = "Map"
		Global.character_name = "Mummy_stage2_corridor"
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			Global.counter = 0  
			Global.counterR = 0
			dialogue_node.PressFKey()
			Global.stage_2_position = false
		
	if Global.stage_2_corridor_done:
		$mummy.hide()
		Global.startChat = false
		$mummy/CollisionShape2D.disabled = true

			
func _process(_delta):

	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left") and Otaku_door_area:
		if not once:
			var dialogue_node = get_node("Dialogue")
			if dialogue_node:
				dialogue_node.PressFKey()
				once = true



func _on_beforein_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if not Global.stage_2_room_done:
			Otaku_door_area = true
			Global.current_character = "otaku"
			Global.place = "Map"
			Global.character_name = "Otaku_stage2_corridor"
		else:
			Otaku_door_area = true
			Global.current_character = "otaku"
			Global.place = "Map"
			Global.character_name = "Otaku_corridor_after"
		$TextureRect.show()
		
func _on_beforein_body_exited(body):
	if body.name == "Player":
		$TextureRect.hide()
		Global.place = ""
		Global.character_name = ""
