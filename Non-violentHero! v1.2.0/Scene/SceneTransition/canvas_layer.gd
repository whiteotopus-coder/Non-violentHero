extends CanvasLayer

var scene_path: String = ""
var progress := [0.0]
var scene_load_status := ResourceLoader.THREAD_LOAD_IN_PROGRESS
var is_loading := false
var visual_progress := 0.0  # 给玩家看的进度
var real_progress := 0.0
var x

func change_scene(path: String, x = "") -> void:
	Global.change_scene = true
	$VBoxContainer/AnimatedSprite2D.show()
	$dissolve_rect.show()
	#$Label.show()
	$TextureProgressBar.show()
	$AnimationPlayer.play(x)
	$VBoxContainer/AnimatedSprite2D.play("default")
	scene_path = path
	is_loading = true
	visual_progress = 0.0
	real_progress = 0.0
	progress = [0.0]
	scene_load_status = ResourceLoader.THREAD_LOAD_IN_PROGRESS
	$TextureProgressBar.value = 0  # 重设进度条
	$Label.text = "0%"            # 重设文字
	ResourceLoader.load_threaded_request(scene_path)

	
func _process(_delta):
	if !is_loading:
		return
		
	scene_load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	real_progress = progress[0]

	# 用 lerp 讓 visual_progress 緩慢追上 real_progress
	visual_progress = lerp(visual_progress, real_progress, 0.1)
	$Label.text = str(floor(visual_progress * 100)) + "%"
	$TextureProgressBar.value = visual_progress * 100
	
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED and visual_progress >= 0.99:
		var new_scene = ResourceLoader.load_threaded_get(scene_path)
		get_tree().change_scene_to_packed(new_scene)
		$AnimationPlayer.play_backwards("dissolve")
		#$Label.hide()
		$TextureProgressBar.hide()
		$VBoxContainer/AnimatedSprite2D.hide()
		$TextureProgressBar.value = 0
		is_loading = false
		Global.change_scene = false
