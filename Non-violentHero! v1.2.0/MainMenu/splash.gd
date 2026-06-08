extends Control

var once = true

func animation(animation):
	$AnimationPlayer.play(animation)
	await $AnimationPlayer.animation_finished
	
	

func _ready():
	Global.load_setting()
	#Screen
	if Global.full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	await animation("default")
	GlobalCanvasLayer.change_scene("res://MainMenu/main_menu.tscn","dissolve")



func _input(_event):
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left"):
		if once:
			once = false
			GlobalCanvasLayer.change_scene("res://MainMenu/main_menu.tscn","dissolve")
			
