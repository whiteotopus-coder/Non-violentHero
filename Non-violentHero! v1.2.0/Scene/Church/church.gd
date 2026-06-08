extends Node2D

var in_cross_area = false
var if_have_cross = false
var once = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/OnTheMove.ogg":
		Global.play_town_song = true	
	Global.from_load = false
	Global.last_scene_name = "church"
	Global.attack_scene = false
	Global.hide_get_task = false
	Global.startChat = false
	Global.counter = 0
	Global.place = ""
	Global.character_name = ""
	Global.lives = 2
	Global.current_character = "nun"
	
	##################### write in save file ###################################
	
	Global.save_place_man = "教堂"	
	Global.save_place_sim_man = "教堂"
	Global.save_place_eng = "Church"
	Global.save_place_jp = "教会"
		
	############################################################################
			
	Global.previous_scene = "res://SceneTransTscn/church.tscn"
	Global.startChat_for_non_attack = false
	if Global.move_to_church:
		$Drum.show()
		$Busker.show()
		$Busker/CollisionShape2D.disabled = false
		$Drum/CollisionShape2D.disabled = false
		$nun/AnimatedSprite2D.play("nun_black")
	else:
		$Drum.hide()
		$Busker.hide()
		$Busker/CollisionShape2D.disabled = true
		$Drum/CollisionShape2D.disabled =  true
		

func _process(delta):
	
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.show_last_option_nun:
		Global.show_last_option = true
	else:
		Global.show_last_option = false
		
	for item in Global.items:
		if (item.has("name") and item["name"] == "cross"):
			if_have_cross = true
			
	if not if_have_cross:
		$furniture.set_cell(Vector2i(4,-7), 0, Vector2i(1,3))
		$furniture.set_cell(Vector2i(4,-6), 0, Vector2i(2,3))
	else:
		$furniture.set_cell(Vector2i(4, -7), -1)
		$furniture.set_cell(Vector2i(4,-6), 0, Vector2i(5,4))


func _input(event: InputEvent) -> void:
	if in_cross_area and Global.move_to_church:
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left") :

			if not if_have_cross and not once:
				$Dialogue/CanvasLayer/ForTask.texture = preload("res://Images/items/cross_exp.png")
				$Dialogue/CanvasLayer/AnimationPlayer.play("task")
				var itemData: Dictionary
				itemData = {
					"name":"cross",
					"image":"res://Images/items/cross.png",
					"img_exp":"res://Images/items/cross_exp.png",
					"text_exp_eng":"The Cross.",
					"text_exp_tra":"聖潔的十字架。",
					"text_exp_sim":"圣洁的十字架。",
					"text_exp_jp":"神聖な十字架。"
				}
				$Control/CanvasLayer/bag._get_item(itemData)
				Global.place = "Map"
				Global.character_name = "Nun_get_cross"
			else:
				if Global.place == "" and  Global.character_name == "":
					Global.place = "Map"
					Global.character_name = "Nun_after_get_cross"
			var dialogue_node = get_node("Dialogue")
			if dialogue_node and not once:
				dialogue_node.PressFKey()
				once = true
	
	
func _on_cross_body_entered(body: Node2D) -> void:
	if body.name == "Player" and Global.move_to_church:
		once = false
		in_cross_area = true
		$chat.show()
		$AnimationPlayer.play("cross")

func _on_cross_body_exited(body: Node2D) -> void:
	if body.name == "Player" and Global.move_to_church:
		in_cross_area = false
		$chat.hide()
