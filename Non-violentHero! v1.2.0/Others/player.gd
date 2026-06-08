class_name Player extends CharacterBody2D

const speed = 160.0
@onready var animations = $AnimatedSprite2D
@onready var tilemap := get_node("../ground")
@onready var audio = $AudioStreamPlayer
@export var endPoint: Marker2D
@export var limit = 10

var startPos
var endPos
var moveDirection = Vector2()

var lastDirection = "down"
var target_position: Vector2
var move_steps = 0  # 记录已移动的步数
var max_steps = 20   # 总共要移动 5 格

var last_step_time := 0.0
var cooldown_time := 0.28
var left_foot = true
var done_load_tilemap = false
var has_set_position = false

var pressed_yes = false
var pressed_no = false
var pressed = false
var in_area = false
var shift_pressed = false

var sound_grass = [	
	preload("res://Sound/grass.MP3"),
	preload("res://Sound/grass1.MP3"),
	preload("res://Sound/grass2.MP3"),
]

var sound_stone = [
	preload("res://Sound/stone.MP3"),
	preload("res://Sound/stone1.MP3"),
	preload("res://Sound/stone2.MP3"),
]

var sound_wood = [
	preload("res://Sound/wood.MP3"),
	preload("res://Sound/wood0.MP3"),
	preload("res://Sound/wood1.MP3"),
]

func on_frame_changed():
	if $AnimatedSprite2D.animation == "yuck" or $AnimatedSprite2D.animation == "eat_die":
		if $AnimatedSprite2D.frame == 0 or $AnimatedSprite2D.frame == 2 or $AnimatedSprite2D.frame == 4 or $AnimatedSprite2D.frame == 6:
			audio.stream = preload("res://Sound/munch.mp3")
			audio.play()
	if $AnimatedSprite2D.animation == "yuck":
		if $AnimatedSprite2D.frame == 9:
			audio.stream = preload("res://Sound/mistake.wav")
			audio.play()
	if $AnimatedSprite2D.animation == "eat_die":
		if $AnimatedSprite2D.frame == 9:
			audio.stream = preload("res://Sound/munch.mp3")
			audio.play()
		if $AnimatedSprite2D.frame == 13:
			audio.stream = preload("res://Sound/bed_sound.MP3")
			audio.play()
	
func _ready():
	$AnimatedSprite2D.frame_changed.connect(on_frame_changed)
	
	$CanvasLayer/Panel.modulate = Color(1,1,1,0)
	$CanvasLayer/Panel.show()
	await get_tree().create_timer(0.35).timeout
	done_load_tilemap = true
	$CanvasLayer/Comfirmation.hide()
	
	startPos = position
	if endPoint == null:
		endPos = position  # 预防崩溃
	else:
		endPos = endPoint.global_position
	
	
func handleInput():
	# Get direction from input (ignoring whether there is movement)
	if not Global.eat_road_side_donut and not Global.eat_puffer_donut:
		var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		if Input.is_action_pressed("ui_run") and not Global.cup_water:
			velocity = moveDirection * speed * 1.6
			shift_pressed = true
			#$AnimatedSprite2D.speed_scale = 1.6
		else:
			velocity = moveDirection * speed
			shift_pressed = false
			#$AnimatedSprite2D.speed_scale = 1.0
		# Update lastDirection based on input, even if moveDirection is (0,0)
		if Input.is_action_pressed("ui_left"):
			lastDirection = "left"
			$CanvasLayer/Comfirmation.hide()
			Global.startChat_for_non_attack = false
		elif Input.is_action_pressed("ui_right"):
			lastDirection = "right"
			$CanvasLayer/Comfirmation.hide()
			Global.startChat_for_non_attack = false
		elif Input.is_action_pressed("ui_up"):
			lastDirection = "up"
			$CanvasLayer/Comfirmation.hide()
			Global.startChat_for_non_attack = false
		elif Input.is_action_pressed("ui_down"):
			lastDirection = "down"
			$CanvasLayer/Comfirmation.hide()
			Global.startChat_for_non_attack = false
			

	
func play_sound():
	$AudioStreamPlayer.volume_db = Global.volume
	var now = Time.get_ticks_msec() / 1000.0
	
	if now - last_step_time < cooldown_time:
		return
	last_step_time = now

	var tile_pos = tilemap.local_to_map(global_position + Vector2(0, 8))
	var tile_data = tilemap.get_cell_tile_data(tile_pos)
	
	var step_type = tile_data.get_custom_data("step_sound")
	var sound_array := []
	match step_type:
		"grass":
			sound_array = sound_grass
		"stone":
			sound_array = sound_stone
		"wood":
			sound_array = sound_wood

	if sound_array.size() > 0:
		var sound
		if left_foot:
			sound = sound_array[0]
		else:
			var x = 1 + randi() % (sound_array.size()-1)
			sound = sound_array[x]
		audio.stream = sound
		audio.play()
		
		if left_foot:
			left_foot = false
		else:
			left_foot = true

	
func updateAnimation():
	if not Global.eat_road_side_donut and not Global.eat_puffer_donut:
		if velocity.length() == 0:
			audio.stop()
			if lastDirection == "up" and Global.dirty:
				if Global.cup_water:
					animations.play("idle_" + lastDirection + "_dirty_water")
				else:
					animations.play("idle_" + lastDirection + "_dirty")
			else:
				if Global.cup_water:
					animations.play("idle_" + lastDirection + "_water")
				else:
					animations.play("idle_" + lastDirection)
		else:
			play_sound()
			if shift_pressed and not Global.cup_water:
				if lastDirection == "up" and Global.dirty:
					animations.play("run_" + lastDirection + "_dirty")
				else:
					animations.play("run_" + lastDirection)
			else:
				if lastDirection == "up" and Global.dirty:
					if Global.cup_water:
						animations.play("walk_" + lastDirection + "_dirty_water")
					else:
						animations.play("walk_" + lastDirection + "_dirty")
						
				else:
					if Global.cup_water:
						animations.play("walk_" + lastDirection + "_water")
					else:
						animations.play("walk_" + lastDirection)
						
	if Global.eat_road_side_donut:
		Global.hide_esc = true
		animations.play("yuck")
		await animations.animation_finished
		Global.eat_road_side_donut = false
		Global.eat_road_side_donut_saved = true
		Global.hide_esc = false
		Steam.setAchievement("ach_eat_donut_hero")
		Steam.storeStats()
			
	elif Global.eat_puffer_donut:
		animations.play("eat_die")
		await animations.animation_finished
		Global.play_ending_thirteen = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _physics_process(delta):
	if Global.move:
		updateVelocity()
		move_and_slide()
	else:
		if not has_set_position and not Global.from_door and not Global.setposition:
			if Global.player_position != Vector2.ZERO:
				global_position = Global.player_position
			has_set_position = true
			
		if move_steps > 0:
			var move_amount = speed * delta
			var direction = (target_position - global_position).normalized()
			var distance_to_target = global_position.distance_to(target_position)

			if move_amount >= distance_to_target:
				global_position = target_position
				move_steps -= 1
				# 播脚步声：每走一格播一次
				#play_sound()
			else:
				global_position += direction * move_amount
		
		if not Global.open_comfirmation and not Global.change_scene:
			if not Global.startChat and done_load_tilemap and not Global.openMenu or Global.allow_move:
				handleInput()
				move_and_slide()
				updateAnimation()
	
	
func updateVelocity():
	if endPos == null:
		return
	moveDirection = endPos - position  # 计算方向
	if moveDirection.length() > limit:  # 只要没到终点，就继续移动
		velocity = moveDirection.normalized() * speed
	else:
		Global.move = false
		velocity = Vector2(0, 0)  # 停止移动
		
		
func _on_yes_pressed():
	pressed_yes = true
	pressed = false
	in_area = false
	$CanvasLayer.layer = 0
	$CanvasLayer/Comfirmation.hide()
	Global.open_comfirmation = false
	Global.interaction = true


func _on_no_pressed():
	pressed_no = true
	pressed = false
	in_area = false
	$CanvasLayer/Comfirmation.hide()
	$CanvasLayer.layer = 0
	Global.interaction = false
	Global.open_comfirmation = false


func _on_yes_mouse_entered() -> void:
	Global.play_pick_chat_sound = true
