extends CharacterBody2D




func _ready():
	pass
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		if not Global.cave_entrance_done:
			$AnimatedSprite2D.play("default")
			$AnimatedSprite2D2.play("default")
			if not Global.task_1_get or not Global.task_2_get or not Global.task_3_get:
				Global.place = "Map"
				Global.character_name = "DemonNpc"
			if (Global.task_1_get and not Global.task_2_get and not Global.eat_road_side_donut_saved) or (Global.task_3_get and not Global.task_2_get and not Global.eat_road_side_donut_saved):
				Global.place = "Map"
				Global.character_name = "DemonNpcGetDonut"
			if (not Global.task_1_get and Global.task_2_get) or (not Global.task_3_get and Global.task_2_get):
				Global.place = "Map"
				Global.character_name = "DemonNpcGetClothe"
			if (Global.task_1_get and Global.task_2_get and not Global.eat_road_side_donut_saved) or (Global.task_3_get and Global.task_2_get):
				Global.place = "Map"
				Global.character_name = "DemonNpcGetBoth"
		else:
			Global.place = "Map"
			Global.character_name = "DemonNpc_done"
		$TextureRect.show()
		$TextureRect.texture = load("res://Images/UI/chat-box.png")
		$TextureRect/AnimationPlayer.play("play_demon")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		Global.place = ""
		Global.character_name = ""
		Global.startChat = false
		$TextureRect.hide()
		$TextureRect/AnimationPlayer.play("RESET")



func _on_right_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if not Global.cave_entrance_done:
			$AnimatedSprite2D2.play("right")

func _on_right_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if not Global.cave_entrance_done:
			$AnimatedSprite2D2.play("default")
