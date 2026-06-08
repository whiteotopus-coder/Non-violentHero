extends CharacterBody2D


###################### front #####################
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		$TextureRect.show()
		$AnimationPlayer.play("play")
		Global.place = "DonutShop"
		Global.character_name = "Donut_Shop_Front"
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		$TextureRect.hide()
		Global.place = ""
		Global.character_name = ""



###################### right #####################
func _on_right_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		$TextureRect.show()
		$AnimationPlayer.play("play")
		Global.place = "DonutShop"
		Global.character_name = "Donut_Shop_Right"
		$animationQ.play("right")

func _on_right_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		$TextureRect.hide()
		Global.place = ""
		Global.character_name = ""
		$animationQ.play("default")



###################### left #####################
func _on_left_body_entered(body: Node2D) -> void:
		Global.hide_esc = true
		$TextureRect.show()
		$AnimationPlayer.play("play")
		Global.place = "DonutShop"
		Global.character_name = "Donut_Shop_Right"
		$animationQ.play("left")

func _on_left_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		$TextureRect.hide()
		Global.place = ""
		Global.character_name = ""
		$animationQ.play("default")
