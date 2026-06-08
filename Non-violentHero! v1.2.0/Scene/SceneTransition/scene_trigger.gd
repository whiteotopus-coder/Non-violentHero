class_name SceneTrigger
extends Area2D


@export var connected_scene: String
@export var need_press: String
var scene_folder = "res://SceneTransTscn/"
var in_door_area = false
var once = false

func _on_body_entered(body):
	if body.name == "Player":  # 确保只有玩家触发
		# 记录当前出口名称到全局变量
		in_door_area = true
		once = false
		$TextureRect.show()
		Global.hide_esc = true
		Global.door_area = true



func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		reset_var()
		Global.hide_esc = false
		Global.door_area = false



func reset_var():
	Global.out_from_door = false
	in_door_area = false
	$TextureRect.hide()



func _process(_delta):
	
	if need_press == "yes":
		Global.out_from_door = false
	if need_press == "no":
		Global.out_from_door = true
	
	if (Input.is_action_pressed("Mouse_Left") and in_door_area) or (Input.is_action_pressed("ui_accept") and in_door_area) or (Global.out_from_door and in_door_area):  # 确保只有玩家触发
		# 记录当前出口名称到全局变量	
		Global.player_position = Vector2(0,0)
		Global.from_door = true
		Global.from_load = false
		#print("change_scene: ",Global.player_position)
			
		if connected_scene != "tilemap":
			Global.last_scene_name = connected_scene
			Global.previous_scene = Global.last_scene_name
			if not once:
				#print("from tilemap to other scene")
				Global.play_door_sound = true
				Global.startChat = true
				Global.file_load = false
				once = true
				reset_var()
		if connected_scene != "cave":
			var full_path = scene_folder + connected_scene + ".tscn"
			Global.previous_scene = full_path
			if not once:
				#print("from other scene to tilemap")
				Global.play_door_sound = true
				Global.startChat = true
				Global.file_load = false
				once = true
				reset_var()
			GlobalCanvasLayer.change_scene(full_path, "faded")
		elif Global.cave_entrance_done:
			var full_path = scene_folder + connected_scene + ".tscn"
			Global.previous_scene = full_path
			if not once:
				Global.play_door_sound = true
				Global.startChat = true
				Global.file_load = false
				once = true
				reset_var()
			GlobalCanvasLayer.change_scene(full_path, "faded")
