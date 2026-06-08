extends Node2D


var last_lives = 3
var last_lives_opp = 3
var last_lives_for_back_btn = 3
var last_lives_opp_for_back_btn = 8
var one_time = false
var once = false
var once_lose = false



# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.song_playing = ""
	Global.change_language = false
	Global.attack_scene = true
	Global.current_character = "demon_king"
	Global.previous_scene = "res://Scene/Cave/attackcave.tscn"
	
	if Global.file_load and Global.current_animation != "":
		$AnimatedSprite2D.play(str(Global.current_animation))
		
	if not Global.file_load and not Global.win_btn_game and not Global.lose_btn_game:
		Global.lives = 3
		Global.lives_opp = 3
		Global.current_lives_opp = 3
	
	#Number of whole Hearts
	if Global.file_load or Global.win_btn_game or Global.lose_btn_game:
		$CanvasLayer/Heart.setHeart(3)
		$CanvasLayer/HeartOpp.setHeart(Global.current_lives_opp)
		$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
	else:
		$CanvasLayer/Heart.setHeart(3)
		$CanvasLayer/HeartOpp.setHeart(3)
		
	#Global.hide_get_task = true
	
	
	##################### write in save file ###################################
	Global.save_place_man = "用語言的力量征服魔王！"
	Global.save_place_sim_man = "用语言的力量征服魔王！"
	Global.save_place_eng = "Fight the Demon King!"
	Global.save_place_jp = "言葉の力で魔王を打ち倒せ！"
	############################################################################
	
	######################### Dialogue ###############################
	
	Global.place = "Map"
	Global.character_name = "Demon_attack"
	
	if Global.win_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Demon_lose"
	if Global.lose_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Demon_win"
		
	if Global.lives == 0:
		Global.place = "Map"
		Global.character_name = "Demon_win"
		once_lose = true
		
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()
		
		

func _process(_delta):
	
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$CanvasLayer/Name.text = "魔王"
	if Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "魔王"
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$CanvasLayer/Name.text = "Demon King"
	if Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "魔王"
	$CanvasLayer/Name.add_theme_font_override("font", the_font)
	
	################################# Layers ##################################
	
	if not Global.win_btn_game and not Global.lose_btn_game and not once_lose:
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
	#else:
		#print("after btn game")
	
	if Global.add_heart:
		$CanvasLayer/HeartOpp.first_set = true
		$CanvasLayer/HeartOpp.setHeart(1)
		Global.lives_opp += 1
		Global.current_lives_opp += 1
		Global.add_heart = false
		Global.play_true_sound = true
	
	######################### Heart's Instructions ####################

	#only call updateHeart function if the lives number change
	#then change the Global.lives to last live number
	#renew the Global.heart_once(var to make sure broke animation only play once)
	if Global.lives != last_lives:
		#Global.lives is number of remaining hearts
		$CanvasLayer/Heart.updateHeart(Global.lives)
		last_lives = Global.lives
		Global.heart_once = false
		
	if Global.lives_opp != last_lives_opp:
		$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
		last_lives_opp = Global.lives_opp
		Global.heart_once = false
	
	if Global.updateLivesNumber:
		Global.updateLivesNumber = false
		last_lives_for_back_btn = Global.lives
		last_lives_opp_for_back_btn = Global.lives_opp
		
	if Global.last_option_btn_pressed:
		print("Global.last_option_btn_pressed")
		Global.last_option_btn_pressed = false
		$CanvasLayer/HeartOpp.removeHeart(Global.lives_opp - last_lives_opp_for_back_btn)
		Global.lives = last_lives_for_back_btn
		Global.lives_opp = last_lives_opp_for_back_btn
		$CanvasLayer/Heart.updateHeart(Global.lives)
		$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
		Global.heart_once = false
		
	if Global.lives == 0 and !once_lose:
		Global.show_last_option_btn = false
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Demon_win"
		once_lose = true
		Global.lose_demon_game = true
		
	######################### Animation Effect ##############################
	
	if Global.play_false_animation and not Global.file_load:
		$Camera2D/AnimationPlayer.play("shake")
		Global.play_false_animation = false
		
	if Global.play_quit_animation:
		Global.hide_esc = false
		$Camera2D/AnimationPlayer.play("quit_attack_scene")
		Global.play_quit_animation = false
