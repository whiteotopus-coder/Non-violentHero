extends CharacterBody2D


@export var speed = 800
@export var limit = 10
@export var endPoint: Marker2D


var startPos
var endPos
var moveDirection = Vector2()


func _ready():
	startPos = position
	if endPoint == null:
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


func updateAnimation():
	var animationString = "back"
	if not Global.mom_win:
		if velocity.y > 0:
			animationString = "default"
		if moveDirection.length() < limit:
			animationString = "default"
	else:
		animationString = "angry"
	$AniMummy.play(animationString)


func _physics_process(_delta):
	if not Global.stage_2_met:
		updateVelocity()
		move_and_slide()
	if not Global.stage_2_corridor:
		updateAnimation()
