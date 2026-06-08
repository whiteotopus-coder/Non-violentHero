extends Node2D

var in_area = false
var in_chair_area = false
var in_chair2_area = false
var in_chair3_area = false

var once = false
var once_chat = false
var once_chat_for_chair = false

var change_position = false
var change_position_chair = false
var change_position_chair2 = false
var change_position_chair3 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "B班"
	Global.save_place_sim_man = "B班"
	Global.save_place_eng = "Classroom B"
	Global.save_place_jp = "Bクラス"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.previous_scene = "res://SceneTransTscn/stage_1_Secondclass.tscn"
	Global.attack_scene = false
	Global.startChat_for_non_attack = false
	Global.in_class_2 = true
	Global.startChat = false
	Global.counter = 0
	Global.place = ""
	Global.character_name = ""
	
	$KidA/AnimatedSprite2D.play("A_back_side")
	$KidB/AnimatedSprite2D.play("B_back_side")
	$KidC/AnimatedSprite2D.play("C_back")
	$KidD/AnimatedSprite2D.play("D_back")
	
	if Global.entered_class_2:
		Global.place = "Map"
		Global.character_name = "InClassRoomSecondTime"
	else:
		Global.place = "Map"
		Global.character_name = "InClassRoomFirstTime"
		
	if Global.from_load:
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false
		Global.from_load = false
	else:		
		if not once_chat:
			var dialogue_node = get_node("Dialogue")
			if dialogue_node:
				dialogue_node.PressFKey()
				once_chat = true
				Global.entered_class_2 = true



func _showDialogue():
	var dialogue_node = get_node("Dialogue")
	if dialogue_node and not once:
		dialogue_node.PressFKey()
		once = true
	
	
func _process(delta):


	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Input.is_action_pressed("ui_accept") and not Global.open_comfirmation and not Global.open_comfirmation  or Input.is_action_pressed("Mouse_Left") and not Global.open_comfirmation:
		if in_area and not once_chat_for_chair:
			Table()
			once_chat_for_chair = true
		if in_chair_area and not once_chat_for_chair:
			Chair()
			once_chat_for_chair = true
		if in_chair2_area and not once_chat_for_chair:
			Chair2()
			once_chat_for_chair = true
		if in_chair3_area and not once_chat_for_chair:
			Chair3()
			once_chat_for_chair = true
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")  or Input.is_action_pressed("ui_up")  or Input.is_action_pressed("ui_down"):
		change_position = false
		change_position_chair = false
		change_position_chair2 = false
		change_position_chair3 = false
		once_chat_for_chair = false
		once = false
	if change_position:
		$Player.position = $TeachersTable.position
		$Player/AnimatedSprite2D.play("idle_down")
		if $Player.position == $TeachersTable.position:
			$TextureRect.hide()
	if change_position_chair:
		$Player.position = $ChairPos.position
		$Player/AnimatedSprite2D.play("idle_down")
		if $Player.position == $ChairPos.position:
			$TextureRect.hide()
	if change_position_chair2:
		$Player.position = $ChairPos2.position
		$Player/AnimatedSprite2D.play("idle_up")
		if $Player.position == $ChairPos2.position:
			$TextureRect.hide()
	if change_position_chair3:
		$Player.position = $ChairPos3.position
		$Player/AnimatedSprite2D.play("idle_up")
		if $Player.position == $ChairPos3.position:
			$TextureRect.hide()


func Table():
	Global.place = "Map"
	Global.character_name = "InClassRoom"
	change_position = true
	_showDialogue()
	

func Chair():
	Global.place = "Map"
	Global.character_name = "InClassRoomChair"
	change_position_chair = true
	_showDialogue()
		
		
func Chair2():
	Global.place = "Map"
	Global.character_name = "InClassRoomChair2"
	change_position_chair2 = true
	_showDialogue()
	
	
func Chair3():
	Global.place = "Map"
	Global.character_name = "InClassRoomChair3"
	change_position_chair3 = true
	_showDialogue()
	
	
##################### in area ###################################
func _on_in_front_of_students_body_entered(body):
	if body.name == "Player":
		Global.place = "Map"
		Global.character_name = "InFrontOfStudents"
		$KidB/AnimatedSprite2D.play("B_back_side")
		$Player/AnimatedSprite2D.play("idle_down")
		_showDialogue()


func _on_in_front_of_students_2_body_entered(body):
	if body.name == "Player":
		Global.place = "Map"
		Global.character_name = "InFrontOfStudents2"
		$Player/AnimatedSprite2D.play("idle_down")
		$KidB/AnimatedSprite2D.play("B_back")
		_showDialogue()


func _on_middle_body_entered(body):
	if body.name == "Player":
		Global.place = "Map"
		Global.character_name = "InMiddle"
		$Player/AnimatedSprite2D.play("idle_up")
		_showDialogue()


##################### in chair area ###################################
func _on_teachers_table_area_area_entered(area):
	in_area = true
	$TextureRect.show()
	$TextureRect.texture = load("res://Images/UI/prompt.png")
	$TextureRect/AnimationPlayer.play("chair_teacher")
	
	
func _on_chair_area_entered(area):
	in_chair_area = true
	$TextureRect.show()
	$TextureRect.texture = load("res://Images/UI/prompt.png")
	$TextureRect/AnimationPlayer.play("chair_board")
	
	
func _on_chair_2_body_entered(body):
	if body.name == "Player":
		in_chair2_area = true
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("chair_left")
	

func _on_chair_3_body_entered(body):
	if body.name == "Player":
		in_chair3_area = true
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/prompt.png")
		$TextureRect/AnimationPlayer.play("chair_lonely")


##################### exited area ###################################
func _on_middle_body_exited(body):
	once = false


func _on_in_front_of_students_body_exited(body):
	once = false
	

func _on_in_front_of_students_2_body_exited(body):
	once = false

##################### exited chair area ###################################
func _on_teachers_table_area_area_exited(area):
	Global.place = ""
	Global.character_name = ""
	in_area = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	

func _on_chair_area_exited(area):
	Global.place = ""
	Global.character_name = ""
	in_chair_area = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	
	
func _on_chair_2_body_exited(body):
	Global.place = ""
	Global.character_name = ""
	in_chair2_area = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	
	
func _on_chair_3_body_exited(body):
	Global.place = ""
	Global.character_name = ""
	in_chair3_area = false
	$TextureRect.hide()
	$TextureRect/AnimationPlayer.play("RESET")
	$KidC/AnimatedSprite2D.play("C_back")
