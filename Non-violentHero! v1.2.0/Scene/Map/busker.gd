extends CharacterBody2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		if not Global.move_to_church and not Global.last_scene_name == "church":
			if not Global.get_task:
				Global.place = "Map"
				Global.character_name = "Busker_before"
			else:
				if not Global.stage1_done:
					Global.place = "Map"
					Global.character_name = "Busker_get_task"
					if Global.church_done:
						Global.place = "Map"
						Global.character_name = "Busker_done"
				else:
					Global.place = "Map"
					Global.character_name = "Busker_get_task_carrot"
					if Global.church_done:
						Global.place = "Map"
						Global.character_name = "Busker_done_carrot"
				
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_busker")



func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")
