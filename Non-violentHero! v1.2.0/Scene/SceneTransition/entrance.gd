extends Node2D

@onready var entrance_markers: Node2D = $"."
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	position_player()

# Places the player at the correct marker based on the last scene.
func position_player() -> void:
	# 从全局变量获取上一个场景名称
	var last_scene = Global.last_scene_name
	
	# 如果 last_scene 为空，直接返回
	if last_scene.is_empty():
		#print("No last scene, skipping player positioning.")
		return
	
	# 查找与 last_scene 名称匹配的 Marker2D
	for entrance in entrance_markers.get_children():
		if entrance is Marker2D and entrance.name == last_scene:
			#print("Found matching entrance:", entrance.name)
			player.global_position = entrance.global_position
			return  # 找到后立即退出循环
	
	# 如果没有找到匹配的 Marker2D
	#print("No matching entrance found for:", last_scene)
