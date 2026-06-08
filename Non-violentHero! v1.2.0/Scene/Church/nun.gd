extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
var once = true

var fake_player = CharacterBody2D.new()

func _on_area_talk_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		$AnimatedSprite2D.play("nun")
		Global.current_character = "nun"
		if Global.church_done:
			Global.place = "Map"
			Global.character_name = "Nun_done"
		else:
			Global.place = "Map"
			Global.character_name = "Nun"
		if Global.church_get_task and not Global.church_request:
			Global.place = "Map"
			Global.character_name = "Nun_get_task"
		if Global.church_request and not Global.move_to_church and not Global.church_done:
			if once:
				Global.counter = 0  
				Global.counterR = 0
				once = false
			Global.place = "Map"
			Global.character_name = "Nun_get_task_request"
		if Global.move_to_church:
			Global.place = "Map"
			Global.character_name = "Nun_moved_to_church"
			$AnimatedSprite2D.play("nun_black")
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_nun")
		

func _process(delta: float) -> void:
	if not Global.church_done:
		if Global.church_request:
			fake_player.name = "Player"
			_on_area_talk_body_entered(fake_player)
	
func _on_area_talk_body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.current_character = ""
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
		$TextureRect.hide()

func _on_left_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		$AnimatedSprite2D.play("nun_left")
		Global.place = ""
		Global.character_name = ""

func _on_right_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		$AnimatedSprite2D.play("nun_right")
		Global.place = ""
		Global.character_name = ""
