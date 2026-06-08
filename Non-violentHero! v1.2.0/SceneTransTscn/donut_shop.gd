extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	##################### write in save file ###################################
	Global.save_place_man = "甜甜圈店"
	Global.save_place_eng = "Donut Shop"
	Global.save_place_sim_man = "甜甜圈店"
	Global.save_place_jp = "ドーナツ屋"
	############################################################################

	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/MerchCity.ogg":
		Global.play_indoor_song = true
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/donut_shop.tscn"
	Global.counter = 0
	Global.startChat = false
	Global.startChat_for_non_attack = false
	Global.last_scene_name = "donut_shop"
	
	if Global.from_donut_washroom:
		$Player.position = $washroom.position
		Global.from_donut_washroom = false
	
	

		
func _process(_delta):
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
