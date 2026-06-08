extends Node2D

var one_time = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Player/AnimatedSprite2D.animation = "idle_up"
	$Dialogue.dialogue_ready = true
	Global.attack_scene = false
	Global.startChat = false
	Global.counter = 0
	Global.place = "Map"
	Global.character_name = "Demon"
	Global.previous_scene = "res://SceneTransTscn/cave.tscn"
	
	##################### write in save file ###################################
	Global.save_place_man = "洞穴"
	Global.save_place_eng = "Cave"
	Global.save_place_sim_man = "洞穴"
	Global.save_place_jp = "洞窟"
	############################################################################
	
	Global.counter = 0  
	Global.counterR = 0
	Global.place = "Map"
	Global.character_name = "Demon"
	Global.play_cave_song = true
	
	#Global.cave_done = true
	#Global.all_img_collect = true
	
	$Player.position = Vector2(0,0)
	if Global.cave_done:
		Global.place = "Map"
		Global.character_name = "Demon_over"
		Global.play_no_song = true
		
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()


func _process(delta):
	
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.move_king:
		$king.show()
		$king/CollisionShape2D.disabled = false
	else:
		$king.hide()
		$king/CollisionShape2D.disabled = true
	
	if not Global.princess_leave:
		$Princess.show()
		$Princess/CollisionShape2D.disabled = false
	else:
		$Princess.hide()
		$Princess/CollisionShape2D.disabled = true
	
	if Global.show_otaku:
		$otaku.show()
	else:
		$otaku.hide()
