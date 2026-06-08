extends Node2D

var last_lives = 3
var last_lives_opp = 5
var one_time = false
var once = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Global.song_playing = ""
	Global.change_language = false
	Global.attack_scene = true
	Global.lives = 3
	if not Global.file_load:
		Global.lives_opp = 5
	#Number of whole Hearts
	$CanvasLayer/Heart.setHeart(3)
	$CanvasLayer/HeartOpp.setHeart(5)
	Global.hide_get_task = true
	
	if Global.file_load and Global.current_animation != "":
		$AnimatedSprite2D.play(str(Global.current_animation))
		
	Global.previous_scene = "res://Scene/Map/attack_entrance.tscn"
		
	##################### write in save file ##################################
	Global.save_place_man = "和看門的小怪戰鬥！"
	Global.save_place_sim_man = "和看门的小怪战斗！"
	Global.save_place_eng = "Fight the Demons！"
	Global.save_place_jp = "門番の雑魚との戦い！"
	###########################################################################
	#dialogue	
	Global.place = "Map"
	Global.character_name = "DemonNpc_attack"
		
	var dialogue_node = get_node("Dialogue")
	if dialogue_node and not once:
		dialogue_node.PressFKey()
		once = true
	
	
	

func _process(_delta):
	
	Global.show_last_option_btn = false
	$Dialogue/CanvasLayer/BackToLastQuestion.hide()
	
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
		
	######################### Display Name ####################################

	if not Global.for_the_next:
		if Global.lang_man:
			$CanvasLayer/Name.text = "左邊小怪"
		if Global.lang_sim_man:
			$CanvasLayer/Name.text = "左边小怪"
		if Global.lang_eng:
			$CanvasLayer/Name.text = "Demon Left"
		if Global.lang_jp:
			$CanvasLayer/Name.text = "左の雑魚"
	else:
		if Global.lang_man:
			$CanvasLayer/Name.text = "右邊小怪"
		if Global.lang_sim_man:
			$CanvasLayer/Name.text = "右边小怪"
		if Global.lang_eng:
			$CanvasLayer/Name.text = "Demon Right"
		if Global.lang_jp:
			$CanvasLayer/Name.text = "右の雑魚"
	
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
	if Global.lang_man or Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	$CanvasLayer/Name.add_theme_font_override("font", the_font)
			
	######################### Heart's Instructions ######################
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
	
	##################### Heart's Instructions ############################
	
	if Global.play_false_animation:
		$Camera2D/AnimationPlayer.play("shake")
		Global.play_false_animation = false
	
	######################### Dialogue ####################################
	
	if Global.play_quit_animation:
		Global.hide_esc = false
		$Camera2D/AnimationPlayer.play("quit_attack_scene")
		Global.play_quit_animation = false
