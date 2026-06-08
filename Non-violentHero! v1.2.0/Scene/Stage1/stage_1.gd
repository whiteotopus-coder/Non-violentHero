extends Node2D

				
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "學校走廊"
	Global.save_place_sim_man = "学校走廊"
	Global.save_place_eng = "School Corridor"
	Global.save_place_jp = "学校の廊下"
	############################################################################

	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/BustlingStreets.ogg":
		Global.play_school_song = true
	Global.last_scene_name = "stage_1"
	Global.previous_scene = "res://SceneTransTscn/stage_1.tscn"
	
	Global.in_stage_1 = false
	Global.from_load = false
	Global.attack_scene = false
	Global.startChat = false
	Global.startChat_for_non_attack = false
	Global.counter = 0
	Global.place = ""
	Global.character_name = ""
	if Global.stage_1_position:
		$Player.position = $class.position
		Global.stage_1_position = false
	if Global.in_class_1:
		$Player.position = $returnA.position
		Global.in_class_1 = false
	if Global.in_class_2:
		$Player.position = $returnB.position
		Global.in_class_2 = false
	if Global.in_stair:
		$Player.position = $returnC.position
		Global.in_stair = false
	$RandomKid/AnimatedSprite2D.play("stalk")


func _process(_delta):


	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.kid_enter_room and not Global.wait:
		$RandomKid/CollisionShape2D.disabled = true
		$RandomKid/Area2D/CollisionShape2D.disabled = true
		$RandomKid.hide()
		
	if Global.show_last_option_kid:
		Global.show_last_option = true
	else:
		Global.show_last_option = false
