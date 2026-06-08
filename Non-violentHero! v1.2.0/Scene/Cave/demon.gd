extends CharacterBody2D


@export var speed = 150
@export var limit = 10
@export var endPoint: Marker2D


var startPos
var endPos
var moveDirection = Vector2()



func _ready():
	startPos = position
	if endPoint == null:
		push_error("endPoint is not set. Please assign a Marker2D node in the Inspector.")
		endPos = position  # 设置默认值，避免后续操作崩溃
	else:
		endPos = endPoint.global_position



func updateVelocity():
	if endPos == null:
		return
	moveDirection = endPos - position
	if moveDirection.length() < limit:
		moveDirection = Vector2(0, 0)
	velocity = moveDirection.normalized() * speed



func _physics_process(delta):
		updateVelocity()
		move_and_slide()
