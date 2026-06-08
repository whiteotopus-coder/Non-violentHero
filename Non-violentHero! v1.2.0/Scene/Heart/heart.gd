extends Panel

@onready var sprite_2d = $HeartSprite
@onready var animation_heart = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
	
func update(x: bool, active: bool, setheart: bool ):
	if x:
		sprite_2d.frame = 0
	else:
		sprite_2d.frame = 18
		
	if setheart:
		animation_heart.play("add")
		await animation_heart.animation_finished
		Global.heart_once = false
			
	if active and Global.heart_once:
		animation_heart.play("broke")
		await animation_heart.animation_finished
		Global.heart_once = false
		
		
		
func first_update(x: bool):
	if x:
		sprite_2d.frame = 0
	else:
		sprite_2d.frame = 18
