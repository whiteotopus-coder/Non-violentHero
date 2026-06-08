extends Node2D

var once_chat = false
var teacher_back = false
var in_area_a = false
var in_area_b = false
var in_area_c = false
var chair_a = false
var chair_b = false
var chair_c = false
var once_animation = true
var once = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "A班"
	Global.save_place_sim_man = "A班"
	Global.save_place_eng = "Classroom A"
	Global.save_place_jp = "Aクラス"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.file_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/stage_1_Firstclass.tscn"
	Global.startChat_for_non_attack = false
	Global.in_class_1 = true
	Global.startChat = false
	Global.counter = 0
	Global.place = ""
	Global.character_name = ""
	$KidA/AnimatedSprite2D.play("A_back")
	$KidB/AnimatedSprite2D.play("B_back")
	$KidC/AnimatedSprite2D.play("C_back")
	$KidD/AnimatedSprite2D.play("D_back")
	$KidD/AnimatedSprite2D.play("D_back")
	$Teacher/AnimatedSprite2D.play("class_1")
	
	if Global.teacher_back_done or Global.teacher_stalker:
		Global.place = "Map"
		Global.character_name = "TeacherAfter"
		Global.in_class_1 = false
	else:
		Global.place = "Map"
		Global.character_name = "InFirstClass_once"
		
	if Global.i_am_student or Global.new_student:
		Global.place = "Map"
		Global.character_name = "InClassAsStudent"
	
	if Global.from_load:
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false
		Global.from_load = false
	else:		
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			dialogue_node.PressFKey()
				
	if Global.carrot_leave_room:
		$Carrot.show()
		$Carrot/AnimatedSprite2D.play("carrot")
	else:
		$Carrot.hide()
		
		
		
func _on_area_2d_area_entered(_area):
	if Global.teacher_leave_class and not Global.teacher_back_done:
		teacher_back = true



func _process(_delta):
	
	if Global.startChat:
		$TextureRect.hide()
	
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.teacher_leave_class:
		if not Global.teacher_back_done and not Global.wait:
			$Teacher/CollisionShape2D.disabled = true
			$Teacher.hide()
	if Global.teacher_stalker:
		Global.in_class_1 = false
	if teacher_back:
		Global.startChat = true
		if once_animation:
			$Player/Camera2D/AnimationPlayer.play("change_scene")
			await $Player/Camera2D/AnimationPlayer.animation_finished
			once_animation = false
		$Teacher/CollisionShape2D.disabled = false
		$Teacher.position = $TeacherBack.position
		Global.place = "Map"
		Global.character_name = "TeacherClassBack"
		$Teacher.show()
		if once:
			$Player/Camera2D/AnimationPlayer.play_backwards("change_scene")
			once = false
		Global.in_class_1 = false
		Global.teacher_back_done = true
		if Global.from_load:
			Global.place = ""
			Global.character_name = ""
			Global.startChat = false
		else:
			if not once_chat:
				var dialogue_node = get_node("Dialogue")
				if dialogue_node:
					dialogue_node.PressFKey()
					once_chat = true
				
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left"):
		if in_area_a:
			chair_a = true
			if chair_a:
				$Player.position = $A.position
				$Player/AnimatedSprite2D.play("idle_up")
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")  or Input.is_action_pressed("ui_up")  or Input.is_action_pressed("ui_down"):
		chair_a = false
		chair_b = false
		chair_c = false
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left"):
		if in_area_a:
			chair_a = true
		if in_area_b:
			chair_b = true
		if in_area_c:
			chair_c = true
	if chair_a:
		$Player.position = $A.position
		$Player/AnimatedSprite2D.play("idle_up")
	if chair_b:
		$Player.position = $B.position
		$Player/AnimatedSprite2D.play("idle_up")
	if chair_c:
		$Player.position = $C.position
		$Player/AnimatedSprite2D.play("idle_up")


##################### only show when player said as a student/new student ###################################
func _on_student_a_area_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if Global.i_am_student:
			Global.place = "Map"
			Global.character_name = "StudentAStudent"
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_stu_a")
		if Global.new_student:
			Global.place = "Map"
			Global.character_name = "StudentANewStudent"
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_stu_a")
		


func _on_student_a_area_body_exited(_body):
	Global.hide_esc = false
	Global.place = ""
	Global.character_name = ""
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	


func _on_student_b_area_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if Global.i_am_student:
			Global.place = "Map"
			Global.character_name = "StudentBStudent"
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_stu_b")
		if Global.new_student:
			Global.place = "Map"
			Global.character_name = "StudentBNewStudent"
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_stu_b")



func _on_student_b_area_body_exited(_body):
	Global.hide_esc = false
	Global.place = ""
	Global.character_name = ""
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	

##################### teacher area ###################################
func _on_teacher_area_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if not Global.i_am_student and not Global.new_student:
			if not Global.teacher_leave_class:
				Global.place = "Map"
				Global.character_name = "TeacherClass_1"
				$TextureRect.show()
				$TextureRect.texture = load("res://Images/UI/chat-box.png")
				$TextureRect/AnimationPlayer.play("play_tea")



func _on_teacher_area_body_exited(_body):
	Global.hide_esc = false
	Global.place = ""
	Global.character_name = ""
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	
	
##################### chair area D ###################################
func _on_student_c_area_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if Global.carrot_leave_room:
			Global.place = "Map"
			Global.character_name = "StudentCStudentAfter"
		else:	
			Global.place = "Map"
			Global.character_name = "StudentCStudent"
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("play_chaird")



func _on_student_c_area_body_exited(_body):
	Global.hide_esc = false
	Global.place = ""
	Global.character_name = ""
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")


##################### chair area A ###################################
func _on_aarea_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		in_area_a = true
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("play_chaira")



func _on_aarea_body_exited(_body):
	Global.hide_esc = false
	in_area_a = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")


##################### chair area B ###################################
func _on_barea_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		in_area_b = true
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("play_chairb")



func _on_barea_body_exited(_body):
	Global.hide_esc = false
	in_area_b = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")


##################### chair area C ###################################
func _on_carea_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		in_area_c = true
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("play_chairc")



func _on_carea_body_exited(_body):
	Global.hide_esc = false
	in_area_c = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")


##################### front area ###################################
func _on_in_front_of_table_a_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if Global.teacher_leave_class:
			$Player/AnimatedSprite2D.play("idle_down")
			Global.place = "Map"
			Global.character_name = "InFrontAsTeacher"
			if not once_chat:
				Global.counter = 0
				var dialogue_node = get_node("Dialogue")
				if dialogue_node:
					dialogue_node.PressFKey()
					once_chat = true



func _on_in_front_of_table_a_body_exited(_body):
	Global.hide_esc = false
	Global.place = ""
	Global.character_name = ""
	once_chat = false



func _on_in_front_of_table_b_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if Global.teacher_leave_class:
			$Player/AnimatedSprite2D.play("idle_down")
			Global.place = "Map"
			Global.character_name = "InFrontAsTeacher"
			if not once_chat:
				Global.counter = 0
				var dialogue_node = get_node("Dialogue")
				if dialogue_node:
					dialogue_node.PressFKey()
					once_chat = true
			
					

func _on_in_front_of_table_b_body_exited(_body):
	Global.hide_esc = false
	Global.place = ""
	Global.character_name = ""
	once_chat = false
