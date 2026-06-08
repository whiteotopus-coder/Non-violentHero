extends Node2D


var last_lives = 3
var last_lives_opp = 8
var last_lives_for_back_btn = 3
var last_lives_opp_for_back_btn = 8
var first_save = true
var one_time = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Global.buttonSelected = true
	#Global.from_load = true
	#Global.counter = 3
	#Global.counterR = 0
	#Global.optionI = 0
	
	Global.song_playing = ""
	Global.attack_scene = true
	Global.change_language = false
	Global.previous_scene = "res://Scene/Stage1/attackstage_1.tscn"
	Global.current_character = "carrot"
	Global.play_quit_animation = false
	
	if Global.file_load and Global.current_animation != "":
		$AnimatedSprite2D.play(str(Global.current_animation))
	if Global.file_load and Global.current_animation_kid != "":
		$Kid.play(str(Global.current_animation_kid))
		
	if Global.file_load and  Global.transition != "":
		var transition = Global.transition
		match transition:
			"kid":
				$AnimatedSprite2D.material.set("shader_parameter/shadow_enabled", true)
				$AnimatedSprite2D.material.set("shader_parameter/shadow_strength", 0.4)
				$Kid.material.set("shader_parameter/shadow_enabled", false)
			"carrot":
				$Kid.material.set("shader_parameter/shadow_enabled", true)
				$Kid.material.set("shader_parameter/shadow_strength", 0.4)
				$AnimatedSprite2D.material.set("shader_parameter/shadow_enabled", false)
				
	if not Global.file_load and not Global.win_btn_game and not Global.lose_btn_game:
		Global.lives = 3
		Global.lives_opp = 8
	#Number of whole Hearts
	$CanvasLayer/Heart.setHeart(3)
	$CanvasLayer/HeartOpp.setHeart(8)
	$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
	
	##################### write in save file ###################################
	Global.save_place_man = "和羅太太的唇槍舌戰！"
	Global.save_place_sim_man = "和罗太太的唇枪舌战！"
	Global.save_place_eng = "Fight with Mrs. Karen Garrett！"
	Global.save_place_jp = "クレーマー母との口論！"
	############################################################################
	
	#dialogue
	Global.place = "Map"
	Global.character_name = "Carrot_attack"
	
	if Global.win_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Carrot_lose"
	if Global.lose_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Carrot_win"
		
	if Global.lives <= 0:
		Global.place = "Map"
		Global.character_name = "Carrot_win"
		one_time = true  
		
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()
		
			
			
func _process(_delta):
	
	######################### Display Name ###########################
	
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$CanvasLayer/Name.text = "罗太太"
	if Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "羅太太"
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$CanvasLayer/Name.text = "Mrs. Karen Garrett"
	if Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "クレーマー母"
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
	else:pass
		#print("after btn game")
		
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
		#Global.lives is number of remaining hearts
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
	
	if Global.lives <= 0 and not one_time:
		Global.show_last_option_btn = false
		one_time = true 
		Global.lose_carrot_game = true
		Global.place = "Map"
		Global.character_name = "Carrot_win"
		
	######################### Animation Effect ###############################
	
	if Global.play_false_animation:
		$Camera2D/AnimationPlayer.play("shake")
		Global.play_false_animation = false
		
	if Global.play_quit_animation:
		Global.hide_esc = false
		$Camera2D/AnimationPlayer.play("quit_attack_scene")
		Global.play_quit_animation = false
