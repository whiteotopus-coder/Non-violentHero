extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		if not Global.get_task and not Global.in_stage_1:
			Global.place = "Map"
			Global.character_name = "RK_inschool"
		else:
			Global.place = "Map"
			Global.character_name = "RK_inschool_gt"
		if Global.in_stage_1 and not Global.stage1_done:
			Global.place = "Map"
			Global.character_name = "RK_inschool_in"
		if Global.stage1_done:
			Global.place = "Map"
			Global.character_name = "RK_inschool_done"
		if Global.task_1_get:
			Global.place = "Map"
			Global.character_name = "RK_inschool_after"
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_kid")



func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")
		
		
		if not Global.kid_enter_room:
			$AnimatedSprite2D.play("stalk")
		else:
			$AnimatedSprite2D.play("default")
