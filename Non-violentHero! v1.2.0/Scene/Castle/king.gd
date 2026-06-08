extends CharacterBody2D



@export var speed = 100
@export var limit = 10
@export var endPoint: Marker2D

var startPos
var endPos
# 如果國王不動
# 記錄前一個國王的位置數據的
var previous_length = 0.0


func _ready():
	if endPoint:
		startPos = position
		endPos = endPoint.global_position
	else:
		#print("Error: endPoint is not assigned!")
		endPos = position  # Fallback to current position or handle appropriately

	
func updateVelocity():
	var moveDirection = endPos - position
	var current_length = moveDirection.length()
	
	previous_length = current_length

	if moveDirection.length() < limit:
		Global.hideking = true
		moveDirection = Vector2(0, 0)
		
	velocity = moveDirection.normalized()*speed


	
func _physics_process(_delta):
	if Global.king_go:
		$AnimatedSprite2D.play("king_walk")
		updateVelocity()
		move_and_slide()
	if Global.king_cave_move:
		updateVelocityCave()
		move_and_slide()


func updateVelocityCave():
	var moveDirection = endPos - position
	if endPos == null:
		return
	if moveDirection.length() < limit:
		moveDirection = Vector2(0, 0)
	velocity = moveDirection.normalized() * speed
