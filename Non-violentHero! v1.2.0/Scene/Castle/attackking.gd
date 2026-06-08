extends Node2D


var last_lives = 3
var last_lives_opp = 8
var last_lives_for_back_btn = 3
var last_lives_opp_for_back_btn = 8
var first_save = true


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.song_playing = ""
	Global.change_language = false
	Global.attack_scene = true
	Global.current_character = "king"
	Global.previous_scene = "res://Scene/Castle/attackking.tscn"
	
	if Global.file_load and Global.current_animation != "":
		$AnimatedSprite2D.play(str(Global.current_animation))
		
	if not Global.file_load and not Global.win_btn_game and not Global.lose_btn_game:
		Global.lives = 3
		Global.lives_opp = 8
	
	#Number of whole Hearts
	$CanvasLayer/Heart.setHeart(3)
	$CanvasLayer/HeartOpp.setHeart(8)
	$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
	
	Global.hide_get_task = true
	
	
	##################### write in save file ###################################
	Global.save_place_man = "國王的挑戰！"
	Global.save_place_sim_man = "国王的挑战！"
	Global.save_place_eng = "King's Challenge!"
	Global.save_place_jp = "王の挑戦！"
	############################################################################
	
	######################### Dialogue ###############################
	
	Global.place = "Map"
	Global.character_name = "King_attack"
	if Global.win_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "King_lose"
	if Global.lose_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "King_win"
		
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()
		
		
		
func _process(_delta):
	
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$CanvasLayer/Name.text = "国王"
	if Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "國王"
	if Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "王様"
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$CanvasLayer/Name.text = "King"
	$CanvasLayer/Name.add_theme_font_override("font", the_font)
		
	################################# Layers ##################################
	
	if not Global.win_btn_game and not Global.lose_btn_game:
		if Global.openMenu:
			$Control/CanvasLayer.layer = 2
			$Dialogue/CanvasLayer.layer = 1
			$CanvasLayer.layer = 1
		else:
			$Control/CanvasLayer.layer = 1
			$Dialogue/CanvasLayer.layer = 2
			$CanvasLayer.layer = 3
			if Global.open_comfirmation:
				$Control/CanvasLayer.layer = 4
		
		
		######################### Heart's Instructions ###############################

	#only call updateHeart function if the lives number change
	#then change the Global.lives to last live number
	#renew the Global.heart_once(var to make sure broke animation only play once)
	if Global.lives != last_lives:
		#Global.lives is number of remaining hearts
		$CanvasLayer/Heart.updateHeart(Global.lives)
		last_lives = Global.lives
		Global.heart_once = false
		
	if Global.updateLivesNumber or first_save:
		first_save = false
		Global.updateLivesNumber = false
		last_lives_for_back_btn = Global.lives
		last_lives_opp_for_back_btn = Global.lives_opp
		
	if Global.last_option_btn_pressed:
		print("Global.last_option_btn_pressed")
		$CanvasLayer/TextureRect.hide()
		Global.tutorial_value = 0
		Global.last_option_btn_pressed = false
		Global.lives = last_lives_for_back_btn
		Global.lives_opp = last_lives_opp_for_back_btn
		$CanvasLayer/Heart.updateHeart(Global.lives)
		$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
		Global.heart_once = false

	if Global.lives_opp != last_lives_opp:
		$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
		last_lives_opp = Global.lives_opp
		Global.heart_once = false
		
	######################### Animation Effect ##############################
	
	if Global.play_false_animation:
		$Camera2D/AnimationPlayer.play("shake")
		Global.play_false_animation = false
	
	if Global.play_tutorial_animation:
		if Global.tutorial_value <= int(3):
			if Global.tutorial_value == 0:
				Global.file_load = false
			if Global.file_load:
				Global.tutorial_value -= 1
				Global.file_load = false
			$CanvasLayer/TextureRect.show()
			$CanvasLayer/TextureRect.modulate.a = 0
			$AnimationPlayer.play("tuto_" + str(Global.tutorial_value))
			Global.tutorial_value += 1
		Global.play_tutorial_animation = false
	
	if Global.play_quit_animation:
		Global.hide_esc = false
		$Camera2D/AnimationPlayer.play("quit_attack_scene")
		Global.play_quit_animation = false
