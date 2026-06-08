extends Node2D

var press_one_key = false
var show_mirror = false
var mirror_area = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "警察局厠所"
	Global.save_place_sim_man = "警局厕所"
	Global.save_place_eng = "Police Station Washroom"
	Global.save_place_jp = "警察署のトイレ"
	############################################################################
	
	Global.play_no_song = true
	Global.from_load = false
	Global.file_load = false
	Global.attack_scene = false
	Global.last_scene_name = "police_washroom"
	Global.previous_scene = "res://SceneTransTscn/police_washroom.tscn"
	Global.startChat_for_non_attack = false
	Global.startChat = false
	Global.stage_2_corridor = false
	Global.toilet_police = true
	
func _process(_delta):
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("Mouse_Left"):
		_show_mirror()
	if Input.is_action_pressed("ui_cancel"):
		esc_mirror()
		
func _show_mirror():
	if mirror_area and not press_one_key:
		Global.allow_move = true
		var mirror_img = preload("res://Images/mirror/hero_police.png")
		$Control/CanvasLayer/mirror.texture = mirror_img
		var if_have_photo = false
		for item in Global.items:
			if (item.has("name") and item["name"] == "photo_washroom_police"):
				if_have_photo = true
		if not if_have_photo:
			Global.play_bing_sound = true
			var itemData: Dictionary
			itemData = {
				"name":"photo_washroom_police",
				"image":"res://Images/items/photo4.png",
				"img_exp":"res://Images/mirror/hero_police.png",
				"text_exp_eng":"A handsome image of the hero that mysteriously appeared in the police station bathroom.",
				"text_exp_tra":"在警局的廁所裡找到的勇者帥照。",
				"text_exp_sim":"在警局的厕所里找到的勇者帅照。",
				"text_exp_jp":"警察署のトイレに現れた謎の勇者のかっこいい写真。"
			}
			$Control/CanvasLayer/bag._get_item(itemData)
			$Control/AnimationPlayer.play("mirror2")
			check_all_img_exist()
		else:
			$Control/AnimationPlayer.play("mirror")
		Global.open_comfirmation = true
		$Control/CanvasLayer/ESC.show()
		$Control/CanvasLayer/mirror.show()
		press_one_key = true

func esc_mirror():
	if mirror_area:
		$Control/AnimationPlayer.play("mirror_back")
		await $Control/AnimationPlayer.animation_finished
		press_one_key = false
		Global.open_comfirmation = false
		$Control/CanvasLayer/ESC.hide()
		$Control/CanvasLayer/mirror.hide()
		Global.allow_move = false
		
func _on_mirror_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		mirror_area = true
		$AnimationPlayer.play("mirror")
		$TextureRect.show()

func _on_mirror_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		mirror_area = false
		$TextureRect.hide()
		
func check_all_img_exist():
	var required_photos = [
		"photo_washroom",
		"photo_washroom_donut",
		"photo_washroom_otaku",
		"photo_washroom_police"
	]
	var collected = []
	for item in Global.items:
		if item.has("name") and item["name"] in required_photos:
			if item["name"] not in collected:
				collected.append(item["name"])
	if collected.size() == required_photos.size():
		Global.all_img_collect = true
