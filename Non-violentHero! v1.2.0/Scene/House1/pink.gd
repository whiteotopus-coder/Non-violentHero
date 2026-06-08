extends CharacterBody2D

############################ chat ##############################
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		Global.place = "Map"
		Global.character_name = "Pink_chat"
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$AnimationPlayer.play("play_pink")
		$animationQ.play("default")
		
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false
		$TextureRect.hide()
		$AnimationPlayer.play("RESET")
		
		
############################ back ##############################
func _on_back_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		Global.place = "Map"
		Global.character_name = "Pink_chat"
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$AnimationPlayer.play("play_pink")
		$animationQ.play("back")

func _on_back_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false
		$TextureRect.hide()
		$AnimationPlayer.play("RESET")
