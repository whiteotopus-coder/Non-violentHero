extends Node

@onready var arrow = preload("res://Others/contain_arrow.tscn") 
@onready var timer = $Timer

var last_lives = Global.lives
var last_lives_opp = Global.lives_opp
var win_handled = false
var lose_handled = false
var once = true

func _ready():

	if Global.current_character == "king":
		$AnimatedSprite2D.animation = "king_happy"
	if Global.current_character == "otaku":
		$AnimatedSprite2D.animation = "otaku_happy"
	if Global.current_character == "carrot":
		$AnimatedSprite2D.animation = "carrot_happy"
	if Global.current_character == "demon_king":
		$AnimatedSprite2D.animation = "demon_king_happy"
				
	#Battle Scene
	var battle_start_texture
	if Global.lang_jp:
		battle_start_texture = preload("res://Images/scene/jp.png")
	if Global.lang_man:
		battle_start_texture = preload("res://Images/scene/tra_man.png")
	if Global.lang_eng:
		battle_start_texture = preload("res://Images/scene/eng.png")
	if Global.lang_sim_man:
		battle_start_texture = preload("res://Images/scene/man.png")
	$BattleStart.texture = battle_start_texture
		
	$Attack.play("default")
	await $Attack.animation_finished
	#Arrow
	$Attack.play("default_set")
		
	if Global.current_character == "king":
		$CanvasLayer/ArrowContainer.generate_key_sequence(3)
	elif Global.current_character == "demon_king":
		$CanvasLayer/ArrowContainer.generate_key_sequence(6)
	else:
		$CanvasLayer/ArrowContainer.generate_key_sequence(5)
		
	#Timer
	$TextureProgressBar.value = 300
	timer.timeout.connect(count_down)  # 正确的绑定方式
	timer.start()
	#Number of whole Hearts
	$CanvasLayer/Heart.setHeart(3)
	if Global.current_character == "king":
		$CanvasLayer/HeartOpp.setHeart(8)
	elif Global.current_character == "demon_king":
		$CanvasLayer/HeartOpp.setHeart(Global.current_lives_opp)
	else:
		$CanvasLayer/HeartOpp.setHeart(8)
	$CanvasLayer/Heart.updateHeart(Global.lives)
	$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)



func _input(event):
	if not (event is InputEventKey and event.pressed):
		return

	var action := ""
	if Input.is_action_just_pressed("ui_up"):
		action = "ui_up"
	elif Input.is_action_just_pressed("ui_down"):
		action = "ui_down"
	elif Input.is_action_just_pressed("ui_left"):
		action = "ui_left"
	elif Input.is_action_just_pressed("ui_right"):
		action = "ui_right"
	else:
		return

	if Global.current_character == "king":
		$CanvasLayer/ArrowContainer.check_input(action, 3)
	elif Global.current_character == "demon_king":
		$CanvasLayer/ArrowContainer.check_input(action, 6)
	else:
		$CanvasLayer/ArrowContainer.check_input(action, 5)

	

func sound_for_first_ani():
	Global.play_bing_sound = true
	
	
	
func count_down():
	if $TextureProgressBar.value != 0:
		$TextureProgressBar.value -= 1
	if $TextureProgressBar.value <= 0:
		Global.play_wrong_sound = true
		if Global.current_character == "king":
			$CanvasLayer/ArrowContainer.generate_key_sequence(3)
		elif Global.current_character == "demon_king":
			$CanvasLayer/ArrowContainer.generate_key_sequence(6)
		else:
			$CanvasLayer/ArrowContainer.generate_key_sequence(5)
		$CanvasLayer/ArrowContainer.check_false_counter()
		$TextureProgressBar.value = 300
		


func handle_win() -> void:
	Global.play_victory_sound = true
	if Global.lang_man or Global.lang_jp:
		$WinOrLose.play("win_man")
	if Global.lang_eng:
		$WinOrLose.play("win_eng")
	if Global.lang_sim_man:
		$WinOrLose.play("win")
	await $WinOrLose.animation_finished
	get_tree().change_scene_to_file(Global.previous_scene)

func handle_lose() -> void:
	Global.play_lose_sound = true
	if Global.lang_man or Global.lang_jp:
		$WinOrLose.play("lose_man")
	if Global.lang_eng:
		$WinOrLose.play("lose_eng")
	if Global.lang_sim_man:
		$WinOrLose.play("lose")
	await $WinOrLose.animation_finished
	get_tree().change_scene_to_file(Global.previous_scene)
	
	

func _process(_delta):

	################################# Animation and change scene ##################

	if Global.win_btn_game and not win_handled:
		win_handled = true
		handle_win()

	if Global.lose_btn_game and not lose_handled:
		lose_handled = true
		handle_lose()
		
	################################# Timer ##################
	
	if Global.reset_button_time:
		$TextureProgressBar.value = 300
		Global.reset_button_time = false
		
	####################### Heart's Instructions ###########################

	#only call updateHeart function if the lives number change
	#then change the Global.lives to last live number
	#renew the Global.heart_once(var to make sure broke animation only play once)		
	if Global.lives != last_lives:
		#Global.lives is number of remaining hearts
		$CanvasLayer/Heart.updateHeart(Global.lives)
		last_lives = Global.lives
		$AnimatedSprite2D.play(Global.current_character + "_happy")
		$AnimationPlayer.play("mistake")
		$Attack.play("mistake")
		
		Global.place = "attack"
		Global.item = Global.current_character + "_mistake"
		$CanvasLayer/WordAttack.PressFKey()
		await get_tree().create_timer(1).timeout
		
		Global.place = "attack"
		Global.item = Global.current_character
		$CanvasLayer/WordAttack.PressFKey()
		
		Global.heart_once = false
		
	if Global.lives_opp != last_lives_opp:
		$CanvasLayer/HeartOpp.updateHeart(Global.lives_opp)
		last_lives_opp = Global.lives_opp
		$AnimatedSprite2D.play(Global.current_character + "_shock")
		$AnimationPlayer.play("shake")
		$Attack.play("attack")
		Global.play_bing_sound = true
		
		Global.place = "attack"
		Global.item = Global.current_character
		$CanvasLayer/WordAttack.PressFKey()
		
		Global.heart_once = false
