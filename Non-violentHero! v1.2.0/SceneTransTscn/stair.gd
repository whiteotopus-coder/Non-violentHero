extends Node2D



func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "樓梯口"
	Global.save_place_eng = "Stair"
	Global.save_place_sim_man = "楼梯口"
	Global.save_place_jp = "階段前"
	############################################################################
	
	Global.play_no_song = false
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/stair.tscn"
	Global.counter = 0
	Global.startChat = false
	Global.startChat_for_non_attack = false
	Global.last_scene_name = "stair"
	Global.in_stair = true
	
	if Global.in_washroom:
		$Player.position = $washroom.position
		Global.in_washroom = false
		
		
		
func _process(_delta):
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
