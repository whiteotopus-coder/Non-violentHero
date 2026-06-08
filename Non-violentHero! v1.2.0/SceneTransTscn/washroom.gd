extends Node2D

var once = true
var press_one_key = false
var opentab = false
var opentab2 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	##################### write in save file ###################################
	Global.save_place_man = "厠所"
	Global.save_place_sim_man = "厕所"
	Global.save_place_eng =  "Washroom"
	Global.save_place_jp = "トイレ"
	############################################################################
	Global.play_no_song = true
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/washroom.tscn"
	Global.for_the_next = false
	Global.hide_get_task = false
	Global.startChat_for_non_attack = false
	Global.counter = 0  
	Global.counterR = 0
	Global.place = ""
	Global.character_name = ""
	Global.stage_1_position = true
	Global.file_load = false
	Global.startChat = false
	Global.in_washroom = true
		
func _process(delta: float) -> void:

	
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

func _play_mirror(x):
	$Control/CanvasLayer/ESC.show()
	$Control/CanvasLayer/mirror.show()
	$Control/AnimationPlayer.play(str(x))
	
func _show_mirror():
	if opentab and not press_one_key:
		var mirror_img = preload("res://Images/mirror/hero_normal.png")
		$Control/CanvasLayer/mirror.texture = mirror_img
		_play_mirror("mirror")
		Global.open_comfirmation = true
		press_one_key = true
	if opentab2 and not press_one_key:
		var mirror_img = preload("res://Images/mirror/hero_school.png")
		$Control/CanvasLayer/mirror.texture = mirror_img
		var if_have_photo = false
		for item in Global.items:
			if (item.has("name") and item["name"] == "photo_washroom"):
				if_have_photo = true
		if not if_have_photo:
			Global.play_bing_sound = true
			var itemData: Dictionary
			itemData = {
				"name":"photo_washroom",
				"image":"res://Images/items/photo2.png",
				"img_exp":"res://Images/mirror/hero_school.png",
				"text_exp_eng":"A mysterious, handsome image of the hero that somehow appeared in the girls’ restroom at school.",
				"text_exp_tra":"學校的女廁所出現的勇者帥氣影像。",
				"text_exp_sim":"在学校的女厕所出现的勇者帅气影像。",
				"text_exp_jp":"学校の女子トイレに現れた謎の勇者のかっこいい写真。"
			}
			$Control/CanvasLayer/bag._get_item(itemData)
			_play_mirror("mirror2")
			check_all_img_exist()
		else:
			_play_mirror("mirror")
		Global.open_comfirmation = true
		press_one_key = true

func esc_mirror():
	if opentab or opentab2:
		$Control/AnimationPlayer.play("mirror_back")
		await $Control/AnimationPlayer.animation_finished
		press_one_key = false
		Global.open_comfirmation = false
		$Control/CanvasLayer/ESC.hide()
		$Control/CanvasLayer/mirror.hide()
		
func _on_tab_1_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_enter("opentab2","tab1")
func _on_tab_1_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_exited("opentab2")

func _on_tab_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_enter("opentab","tab2")
func _on_tab_2_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_exited("opentab")

func _on_tab_3_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_enter("opentab","tab3")
func _on_tab_3_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_exited("opentab")
	
func _on_tab_4_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_enter("opentab","tab4")
func _on_tab_4_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		_tab_body_exited("opentab")
		
func _tab_body_enter(var_name: String, animation_name: String) -> void:
	Global.hide_esc = true
	Global.allow_move = true
	$TextureRect.show()
	set(var_name, true)
	$AnimationPlayer.play(animation_name)

func _tab_body_exited(var_name: String) -> void:
	Global.hide_esc = false
	press_one_key = false
	Global.allow_move = false
	$TextureRect.hide()
	set(var_name, false)
	
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
