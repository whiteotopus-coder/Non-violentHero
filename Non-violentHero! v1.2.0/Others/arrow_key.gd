extends Panel


var key_images := {
	"ui_up": preload("res://Images/UI/key/arrow_up.png"),
	"ui_down": preload("res://Images/UI/key/arrow_down.png"),
	"ui_left": preload("res://Images/UI/key/arrow_left.png"),
	"ui_right": preload("res://Images/UI/key/arrow_right.png")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func set_texture(action: String) -> void:
	$Sprite2D.texture = key_images[action]

		
		
func update(num):
	if num == "2":
		$Sprite2D/AnimationPlayer.play("shake_true")
		$Sprite2D.frame = 1
	if num == "3":
		$Sprite2D/AnimationPlayer.play("shake")
		$Sprite2D.frame = 2
