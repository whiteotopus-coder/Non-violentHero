extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.play_no_song = true
	Global.previous_scene = "res://MainMenu/scene.tscn"
	$animation.play("RESET")
	Global.place = "Scene1"
	Global.character_name = "scene1"
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
