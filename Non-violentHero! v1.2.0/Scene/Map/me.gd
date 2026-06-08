extends CharacterBody2D

var once = false
var in_area = false


func _process(delta: float) -> void:
	if Global.current_me_texture == "me_default" and not once and Global.saved_me and not Global.task_3_get:
		Global.place = "Map"
		Global.character_name = "me_saved"
		once = true
	
	if in_area:
		Global.hide_esc = true
		
	if Global.cup_water:
		$TextureRect.texture = load("res://Images/UI/prompt.png")
	else:
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		
		
			
func _on_talkarea_body_entered(body):
	if body.name == "Player":
		print("cannnnnnn")
		in_area = true
		Global.current_character = "pink"
		$TextureRect.show()
		$TextureRect/AnimationPlayer.play("play_me")
		#if not Global.cup_water:
		if Global.church_done and not Global.stage2_done:
			Global.place = "Map"
			Global.character_name = "me_chat"
		if not Global.church_done or Global.teacher_leave_class or Global.teacher_stalker:
			Global.place = "Map"
			Global.character_name = "Me"
		if Global.stage2_done and not Global.saved_me:
			Global.place = "Map"
			Global.character_name = "me_dry"
		if Global.saved_me:
			Global.place = "Map"
			Global.character_name = "me_saved"
		


func _on_talkarea_body_exited(body):
	if body.name == "Player":
		once = false
		in_area = false
		Global.hide_esc = false
		Global.current_character = ""
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
		Global.current_character = ""
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")
