extends CharacterBody2D

@export var speed = 300
@export var limit = 10
@export var endPoint: Marker2D

var startPos
var endPos
var moveDirection = Vector2()


func _ready():
	startPos = position
	if endPoint == null:
		push_error("endPoint is not set. Please assign a Marker2D node in the Inspector.")
		endPos = position  # 预防崩溃
	else:
		endPos = endPoint.global_position


func updateVelocity():
	if endPos == null:
		return
	
	moveDirection = endPos - position  # 计算方向
	if moveDirection.length() > limit:  # 只要没到终点，就继续移动
		velocity = moveDirection.normalized() * speed
	else:
		velocity = Vector2(0, 0)  # 停止移动


func _process(delta):
	if Global.princess_move:
		updateVelocity()
		move_and_slide()  # 让角色实际移动
