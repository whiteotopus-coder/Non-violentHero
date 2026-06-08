extends Node2D

var in_area = false
var in_chair_area = false
var change_position = false
var change_position_chair = false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	##################### write in save file ###################################
	Global.save_place_man = "警察局"
	Global.save_place_eng = "Police Office"
	Global.save_place_sim_man = "警察局"
	Global.save_place_jp = "警察署"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/OnTheMove.ogg":
		Global.play_town_song = true	
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/house_2.tscn"
	Global.counter = 0
	Global.startChat = false
	Global.startChat_for_non_attack = false
	Global.last_scene_name = "house_2"
	$PolicemanSleep/policeman_animation.play("sleepman")
	$PolicemanSerious/policeman_animation.play("policeman")
	$PolicemanFishing/policeman_animation.play("fishing")
	
	if Global.toilet_police:
		Global.savegame = false
		Global.loadgame = false
		$Player.global_position = $toilet.global_position
		Global.toilet_police = false
			
	################## for king ##################
	if not Global.teacher_leave_class and not Global.teacher_stalker:
		$king/CollisionShape2D.disabled = true
		$king.hide()
	else:
		$king/CollisionShape2D.disabled = false
		$king.show()
		Steam.setAchievement("ach_to_police_station")
		Steam.storeStats()
	
	SaveFunction.auto_save()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	#if not Global.pos_to_chair_police:
		#if Global.savegame or Global.loadgame:
			#Global.player_position = $Player.global_position
	
	if Global.pos_to_chair_police:
		change_position_chair = true
		$Player.position = $ChairPos.position
		$Player/AnimatedSprite2D.play("idle_down")
		if $Player.position == $ChairPos.position:
			$TextureRect.hide()
		Global.pos_to_chair_police = false
		
			
	################## sit if in chair area and pressed f key ##################
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left"):
		if in_area and not in_chair_area:
			change_position = true
		if in_chair_area and not in_area:
			change_position_chair = true
			
	################## cancel changed position and animations if player move #############
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")  or Input.is_action_pressed("ui_up")  or Input.is_action_pressed("ui_down"):
		change_position = false
		change_position_chair = false
		
	################## Change Position And Animations #############
	if change_position:
		$Player.position = $ChairBack.position
		$Player/AnimatedSprite2D.play("idle_up")
		if $Player.position == $ChairBack.position:
			$TextureRect.hide()
	if change_position_chair:
		$Player.position = $ChairPos.position
		$Player/AnimatedSprite2D.play("idle_down")
		if $Player.position == $ChairPos.position:
			$TextureRect.hide()
	

############################## King Area #######################

func _on_king_area_body_entered(body):
	if body.name == "Player":
		if Global.teacher_leave_class:
			Global.place = "PoliceCentre"
			Global.character_name = "King_Teacher"
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_king")
			$TextureRect.show()
		if Global.teacher_stalker:
			Global.place = "PoliceCentre"
			Global.character_name = "King_Stalker"
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_king")
			$TextureRect.show()
		

############################## Chair Area #######################

func _on_chair_body_entered(body):
	if body.name == "Player":
		in_chair_area = true
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("play_chaira")
		$TextureRect.show()


func _on_chair_b_body_entered(body):
	if body.name == "Player":
		in_area = true
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("play_chairb")
		$TextureRect.show()

############################## Police Man #######################

func _on_donut_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.place = "PoliceCentre"
		Global.character_name = "P_Donut"
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_donut")
		$TextureRect.show()


func _on_seriousman_body_entered(body):
	if body.name == "Player":
		Global.place = "PoliceCentre"
		Global.character_name = "P_seriousman"
		if Global.teacher_leave_class:
			Global.place = "PoliceCentre"
			Global.character_name = "P_Teacher"
		if Global.teacher_stalker:
			Global.place = "PoliceCentre"
			Global.character_name = "P_Stalker"
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_police")
		$TextureRect.show()
		$PolicemanSerious/policeman_animation.play("police_side")


func _on_sleepman_body_entered(body):
	if body.name == "Player":
		Global.place = "PoliceCentre"
		Global.character_name = "P_sleepingman"
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_sleep")
		$TextureRect.show()
		$PolicemanSerious/policeman_animation.play("police_side")


func _on_fishingman_body_entered(body):
	if body.name == "Player":
		Global.place = "PoliceCentre"
		Global.character_name = "P_fishingman"
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_fishing_p")
		$TextureRect.show()
		$PolicemanSerious/policeman_animation.play("policeman")
	
############################## Exit Funtion #######################

func _on_area_body_exited(_body):
	Global.place = ""
	Global.character_name = ""
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	
func _on_chair_body_exited(_body):
	in_chair_area = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	
func _on_chair_b_body_exited(body):
	if body.name == "Player":
		in_area = false
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")
	
