extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D


func _on_area_talk_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		Global.current_character = "carrot"
		if not Global.stage1_done:
			Global.place = "Map"
			Global.character_name = "Carrot"
			$TextureRect.show()
			$AnimationPlayer.play("chatbox")
		if Global.garrett_house:
			Global.place = "GarrettHouse"
			Global.character_name = "Carrot_house"
			$TextureRect.show()
			$AnimationPlayer.play("chatbox")


func _on_right_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		if Global.garrett_house:
			$AnimatedSprite2D.play("right")
		if Global.put_cross:
			$AnimatedSprite2D.play("sleep")


func _on_left_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		if Global.garrett_house:
			$AnimatedSprite2D.play("left")
		if Global.put_cross:
			$AnimatedSprite2D.play("sleep")


func _on_area_talk_body_exited(body):
	if body.name == "Player": 
		Global.hide_esc = false
		Global.current_character = ""
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
		$TextureRect.hide()
		if Global.garrett_house:
			$AnimatedSprite2D.play("default")
