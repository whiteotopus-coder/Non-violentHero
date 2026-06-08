extends Node2D


var last_lives = 3
var last_lives_opp = 8
var last_lives_for_back_btn = 3
var last_lives_opp_for_back_btn = 8
var first_save = true
var one_time = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.song_playing = ""
	Global.change_language = false
	Global.attack_scene = true
	Global.previous_scene = "res://Scene/Stage2/attackstage2.tscn"
	Global.current_character = "otaku"
	
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
	Global.save_place_man = "和肥宅的戰鬥！"
	Global.save_place_sim_man = "和肥宅的战斗！"
	Global.save_place_eng = "A Battle with Otaku!"
	Global.save_place_jp = "オタクとの戦い！"
	############################################################################
	
	#dialogue
	if not Global.mom_win:
		Global.place = "Map"
		Global.character_name = "Otaku_attack"
	else:
		Global.place = "Map"
		Global.character_name = "Otaku_attack_after"
		
	if Global.win_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Otaku_lose"
	if Global.lose_btn_game:
		$Control.queue_free()
		Global.counterR = 0
		Global.counter = 0
		Global.place = "Map"
		Global.character_name = "Otaku_win"
		
	if Global.lives <= 0 and not Global.win_btn_game and not Global.lose_btn_game:		
		one_time = true  
		Global.place = "Map"
		Global.character_name = "Otaku_game_over"
	
	print("Global.character_name: ",Global.character_name)
	
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()



func _process(_delta):
	
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
	#else:
		#print("after btn game")
		
	######################### Display Name ###########################
	
	if not Global.for_the_next:
		if Global.lang_sim_man:
			$CanvasLayer/Name.text = "肥宅"
		if Global.lang_man:
			$CanvasLayer/Name.text = "肥宅"
		if Global.lang_eng:
			$CanvasLayer/Name.text = "Otaku"
		if Global.lang_jp:
			$CanvasLayer/Name.text = "オタク"
	else:
		if Global.lang_sim_man:
			$CanvasLayer/Name.text = "肥宅妈咪"
		if Global.lang_man:
			$CanvasLayer/Name.text = "肥宅媽咪"
		if Global.lang_eng:
			$CanvasLayer/Name.text = "Otaku's Mummy"
		if Global.lang_jp:
			$CanvasLayer/Name.text = "オタクの母"
			
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
	if Global.lang_man or Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	$CanvasLayer/Name.add_theme_font_override("font", the_font)
	
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
		
	if Global.lives == 0:
		Global.mom_win = true
		
	######################### Animation Effect ########################
	
	if Global.play_false_animation:
		$Camera2D/AnimationPlayer.play("shake")
		Global.play_false_animation = false
	
	if Global.play_quit_animation:
		Global.hide_esc = false
		$Camera2D/AnimationPlayer.play("quit_attack_scene")
		Global.play_quit_animation = false
		
	######################### Dialogue ###############################
	
	if Global.lives <= 0 and not one_time and not Global.win_btn_game and not Global.lose_btn_game:
		Global.show_last_option_btn = false
		one_time = true  
		Global.counter = 0  
		Global.counterR = 0
		Global.place = "Map"
		Global.character_name = "Otaku_game_over"
	
