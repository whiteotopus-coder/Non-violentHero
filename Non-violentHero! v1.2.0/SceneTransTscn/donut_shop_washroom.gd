extends Node2D

var once = true
var press_one_key = false
var show_mirror = false
var mirror_area = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "甜甜圈後厨"
	Global.save_place_eng = "Donut Shop"
	Global.save_place_sim_man = "甜甜圈店后厨"
	Global.save_place_jp = "ドーナツ屋の厨房"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.play_no_song = true
	Global.from_donut_washroom = true
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/donut_shop_washroom.tscn"
	Global.counter = 0
	Global.startChat = false
	Global.startChat_for_non_attack = false
	Global.last_scene_name = "donut_shop_washroom"

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
		Global.startChat_for_non_attack = true
		Global.openMenu = true
		Global.allow_move = true
		var mirror_img = preload("res://Images/mirror/hero_donut_shop.png")
		$Control/CanvasLayer/mirror.texture = mirror_img
		var if_have_photo = false
		for item in Global.items:
			if (item.has("name") and item["name"] == "photo_washroom_donut"):
				if_have_photo = true
		if not if_have_photo:
			Global.play_bing_sound = true
			var itemData: Dictionary
			itemData = {
				"name":"photo_washroom_donut",
				"image":"res://Images/items/photo.png",
				"img_exp":"res://Images/mirror/hero_donut_shop.png",
				"text_exp_eng":"A handsome portrait of the hero, mysteriously obtained from the donut shop washroom.",
				"text_exp_tra":"甜甜圈店的洗手間出現的勇者的帥氣照片。",
				"text_exp_sim":"从甜甜圈店的洗手间出现的勇者的帅气照片。",
				"text_exp_jp":"ドーナツ屋のトイレに現れた謎の勇者のかっこいい写真。"
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
		Global.startChat_for_non_attack = false
		Global.openMenu = false
		Global.allow_move = false
		
func _on_mirror_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		mirror_area = true
		$AnimationPlayer.play("mirror")
		$TextureRect.show()
		Global.hide_esc = true

func _on_mirror_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		mirror_area = false
		$TextureRect.hide()
		Global.hide_esc = false
		
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
