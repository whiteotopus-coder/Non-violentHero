extends Node2D


var last_lives = 2
var last_lives_for_back_btn = 2
var one_time = false
var first_save = true


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.song_playing = ""
	Global.attack_scene = true
	Global.current_character = "nun"
	Global.previous_scene = "res://Scene/Church/attackchurch.tscn"
	Global.change_language = false
	
	if Global.file_load and Global.current_animation != "":
		$AnimatedSprite2D.play(str(Global.current_animation))

	if not Global.file_load:
		Global.lives = 2
	#Number of whole Hearts
	$CanvasLayer/Heart.setHeart(2)
	
	##################### write in save file ###################################
	Global.save_place_man = "來獲得修女的信任！"
	Global.save_place_sim_man = "来获取修女的信任！"
	Global.save_place_eng = "Get Nun's Trust！"
	Global.save_place_jp = "シスターの信頼を得る！"
	############################################################################
	#dialogue
	
	if not Global.second_nun:
		Global.place = "Map"
		Global.character_name = "Nun_attack"
	else:
		Global.place = "Map"
		Global.character_name = "Nun_attack_2"
	
	if Global.lives <= 0:
		Global.place = "Map"
		Global.character_name = "Nun_game_over"
		one_time = true
		
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()



func _process(_delta):
	
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$CanvasLayer/Name.text = "修女"
	if Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "修女"
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$CanvasLayer/Name.text = "Nun"
	if Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$CanvasLayer/Name.text = "シスター"
	$CanvasLayer/Name.add_theme_font_override("font", the_font)
	
	################################# Layers ##################################
	
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
		
	######################### Heart's Instructions ######################
	
	if Global.lives != last_lives:
		#Global.lives is number of remaining hearts
		$CanvasLayer/Heart.updateHeart(Global.lives)
		last_lives = Global.lives
		Global.heart_once = false
	
	if Global.updateLivesNumber or first_save:
		first_save = false
		Global.updateLivesNumber = false
		last_lives_for_back_btn = Global.lives
		
	if Global.last_option_btn_pressed:
		print("Global.last_option_btn_pressed")
		Global.last_option_btn_pressed = false
		Global.lives = last_lives_for_back_btn
		$CanvasLayer/Heart.updateHeart(Global.lives)
		Global.heart_once = false
		
	if Global.play_false_animation:
		$Camera2D/AnimationPlayer.play("shake")
		Global.play_false_animation = false
	
	if Global.play_quit_animation:
		$Camera2D/AnimationPlayer.play("quit_attack_scene")
		Global.play_quit_animation = false
		
	######################### Dialogue ####################################
		
	if Global.lives <= 0 and not one_time:
		Global.show_last_option_btn = false
		Global.counter = 0  
		Global.counterR = 0
		one_time = true  # 设置为 true，避免再次执行
		Global.place = "Map"
		Global.character_name = "Nun_game_over"
		Global.second_nun = true
		Global.lose_church_game = true
