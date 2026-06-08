extends CharacterBody2D


func _on_area_2d_body_entered(body):
	if not Global.previous_scene == "res://SceneTransTscn/cave.tscn":
		if body.name == "Player":
			Global.hide_esc = true
			Global.current_character = "otaku"
			if Global.stage2_done:
				Global.place = "Map"
				Global.character_name = "Otaku_after"
			else:
				Global.place = "Map"
				Global.character_name = "Otaku_chat"
			if Global.mom_win and not Global.stage2_done:
				Global.place = "Map"
				Global.character_name = "Otaku_help"
			$TextureRect.show()
			$TextureRect.texture = load("res://Images/UI/chat-box.png")
			$TextureRect/AnimationPlayer.play("play_otaku")


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
		Global.current_character = ""
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")
