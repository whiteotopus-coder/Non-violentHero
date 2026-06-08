extends Node2D

var door_area = false
var trash_area = false
var sleep_trashcan = false
var once = false
var first = true


var in_me_area = false
var in_area = false
var input_pressed = false
var beach = false
var give_water = false
var JSONarray

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_sim_man = "小镇"
	Global.save_place_man = "小鎮"
	Global.save_place_eng = "Town"
	Global.save_place_jp = "町"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	if Global.song_playing != "res://BackgroundMusic/OnTheMove.ogg":
		Global.play_town_song = true	
	Global.last_scene_name = "tilemap"
	Global.attack_scene = false
	Global.king_go = false
	Global.previous_scene = "res://SceneTransTscn/tilemap.tscn"
	Global.for_the_next = false
	Global.hide_get_task = false
	Global.counter = 0  
	Global.counterR = 0
	Global.place = ""
	Global.character_name = ""
	Global.startChat = false
	Global.show_last_option = false
	Global.startChat_for_non_attack = false
	Global.win_btn_game = false
	Global.lose_btn_game = false
	Global.file_load = false
	$TextureRect.hide()
	$Carrot/areaTalk/areaTalk.disabled = true
	$Carrot/right/right.disabled = true
	$Carrot/left/left.disabled = true
	$me2.hide()
	$me2/CollisionShape2D.disabled = true
	$me2/talkarea/talkarea.disabled = true
	if Global.church_done:
		$king.show()
		$king/CollisionShape2D.disabled = false
		$KingOutside/KingOutside.disabled = true
		$king2/CollisionShape2D.disabled = true
		$king2.hide()
	else:
		$king.hide()
		$king/CollisionShape2D.disabled = true
	
	if Global.stage2_done:
		$me.hide()
		$me/CollisionShape2D.disabled = true
		$me/talkarea/talkarea.disabled = true
		$king.hide()
		$king/CollisionShape2D.disabled = true
		$KingOutside/KingOutside.disabled = true
		$king2/CollisionShape2D.disabled = true
		$king2.hide()
		$me2/animationQ.play("me_sleep")
		$me2.show()
		$me2/CollisionShape2D.disabled = false
		$me2/talkarea/talkarea.disabled = false
		$me2/animationQ.play(Global.current_me_texture)
	
	if Global.teacher_leave_class or Global.teacher_stalker:
		$king.hide()
		$king/CollisionShape2D.disabled = true
		$KingOutside/KingOutside.disabled = true
		$king2.hide()
		$king2/CollisionShape2D.disabled = true
		
	if not Global.stage1_done or Global.move_to_church:
		Global.place = ""
		Global.character_name = ""
		$Carrot.hide()
		$Carrot/CollisionShape2D.disabled = true
	else:
		$Carrot.show()
		$Carrot/CollisionShape2D.disabled = false
		$Carrot/AnimatedSprite2D.play("side")
		$Busker/AniBusker.play("no")
	
	if Global.cave_entrance_done:
		$DemonNpc.position = $entrance_after.position
		$DemonNpc/AnimatedSprite2D2.play("lose")
		$DemonNpc/AnimatedSprite2D.play("lose")
				
####################################### Door Animation ############################################
		
func _input(event: InputEvent) -> void:
	if in_area and Input.is_action_pressed("ui_accept") or in_area and Input.is_action_pressed("Mouse_Left"):
		input_pressed = true
		
	if (Input.is_action_pressed("ui_accept") and Global.cup_water) or (Input.is_action_pressed("Mouse_Left") and Global.cup_water):
		print("浇水")
		if Global.current_me_texture == "me_cook3":
			Global.num_water = 3
		if Global.current_me_texture == "me_cook2":
			Global.num_water = 2
		if Global.current_me_texture == "me_cook1":
			Global.num_water = 1
		if Global.current_me_texture == "me_default":
			Global.num_water = -1
		input_pressed = false
		Global.interaction = false
		Global.cup_water = false
		give_water = true
		if in_me_area and Global.me_dry:
			print(Global.num_water)
			if not Global.saved_me:
				Global.num_water = Global.num_water - 1
			if Global.num_water <= 0:
				print("Global.saved_me")
				Global.saved_me = true
				$me2/animationQ.play("me_default")
				Global.current_me_texture = "me_default"
			if Global.num_water >= 1:
				$me2/animationQ.play("me_cook" + str(Global.num_water))
				Global.current_me_texture = "me_cook" + str(Global.num_water)
		#浇水的画面
		#吧作者的图画改成有水的
		
	if event.is_action_pressed("ui_accept"):
		if door_area:
			var anim = "default"
			var total_frames = 5  # 动画总帧数
			$door.show()
			Global.play_door_sound = true
			if $door.frame == total_frames - 1:
				$deco.set_cell(Vector2i(8,5), -1)
				$door.play_backwards(anim)
				await $door.animation_finished
				$deco.set_cell(Vector2i(7,5), 22, Vector2i(5,4))
				$door.hide()
			elif $door.frame == 0: 
				$deco.set_cell(Vector2i(7,5), -1)
				$door.play(anim)
				await $door.animation_finished
				$deco.set_cell(Vector2i(8,5), 22, Vector2i(6,5))
				$door.hide()
		if trash_area:
			if sleep_trashcan:
				sleep_trashcan =false
			else:
				if once:
					$Player/AnimatedSprite2D.play("lay_down")
					$Player.position = $Marker2D.position
					$buildling.set_cell(Vector2i(53,-14), 7, Vector2i(13,9))
					once = false
					Global.place = "Map"
					Global.character_name = "DemonNpcTrashBinAfter"
					var dialogue_node = get_node("Dialogue")
					if dialogue_node:
						dialogue_node.PressFKey()
					sleep_trashcan = true
					$TextureRect.hide()
		
###################################################################################

func _process(_delta):
	
	var update_volume = Global.volume
	
	$EnviromentAudio/WaterFall.volume_db = update_volume
	$EnviromentAudio/SmallWaterFallUp.volume_db = update_volume
	$EnviromentAudio/SmallWaterFallBottom.volume_db = update_volume
	$EnviromentAudio/BridgeRiver.volume_db = update_volume
	$EnviromentAudio/River.volume_db = update_volume
	$EnviromentAudio/Drain.volume_db = update_volume
	$EnviromentAudio/TinyFountain.volume_db = update_volume
	$EnviromentAudio/BeachSound.volume_db = update_volume
	$EnviromentAudio/DrainMiddle.volume_db = update_volume
	$EnviromentAudio/Seaside.volume_db = update_volume
	$EnviromentAudio/SeasideBottom.volume_db = update_volume
	$EnviromentAudio/SeasideOnTop.volume_db = update_volume
	
	if Global.stage1_done:
		$garrett_house/garrett_house.disabled = false
	else:
		$garrett_house/garrett_house.disabled = true
		
	if Global.setposition:
		$Player.position = $after.position
		Global.setposition = false
			

	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
	
		
	if Global.move_to_church and not Global.wait:
		$Busker.hide()
		$Drum.hide()		
		$Carrot.hide()
		$Busker/Area2D/CollisionShape2D.disabled = true
		$Busker/CollisionShape2D.disabled = true
		$Drum/CollisionShape2D.disabled = true
		$Carrot/CollisionShape2D.disabled = true
		
	if Global.task_3_get:
		var if_have_donut = false
		for item in Global.items:
			if (item.has("name") and item["name"] == "donut_puffer"):
				if_have_donut = true
		if not if_have_donut:
			var itemData: Dictionary
			itemData = {
				"name":"donut_puffer",
				"image":"res://Images/items/task3.png",
				"img_exp":"res://Images/UI/donut2.png",
				"text_exp_eng":"A pufferfish sea salt flavored donut gifted by the creator.",
				"text_exp_tra":"作者送的河豚海鹽口味甜甜圈。",
				"text_exp_sim":"作者送的河豚海盐口味甜甜圈。",
				"text_exp_jp":"作者からもらったフグ塩味のドーナツ。"
			}
			$Control/CanvasLayer/bag._get_item(itemData)
			
	############## water ##############
	if in_area:
		Global.hide_esc = true
		
	ComfirmationAction()
	
	if $Player.pressed_yes:
		ItemInteraction()
		$Player.pressed_yes = false
	if $Player.pressed_no:
		$Dialogue.current_pressed_key = ""
		$Dialogue.can_press = true
		$Player.pressed_no = false

####################################### Area ############################################

##################### king ############
func _on_king_outside_body_entered(body):
	if body.name == "Player":
		Global.hide_esc = true
		Global.place = "Map"
		Global.character_name = "King_outside"
		$AnimationPlayer.play("play_king")
		$TextureRect.show()


##################### door ############
func _on_door_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		door_area = true
		$AnimationPlayer.play("door")
		$TextureRect.show()

func _on_door_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = false
		door_area = false
		$AnimationPlayer.play("RESET")
		$TextureRect.hide()

	
##################### trash bin ############
func _on_trash_bin_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.hide_esc = true
		$AnimationPlayer.play("play_trashbin")
		$TextureRect.show()
		if not Global.cave_entrance_done:
			Global.place = "Map"
			Global.character_name = "DemonNpcTrashBin"
			$DemonNpc/AnimatedSprite2D.play("left")
		else:
			once = true
			trash_area = true

##################### exited ############
func _body_exited(body):
	if body.name == "Player":
		Global.hide_esc = false
		Global.current_character = ""
		Global.place = ""
		Global.character_name = ""
		Global.current_character = ""
		Global.startChat = false
		$TextureRect.hide()
		trash_area = false
		$buildling.set_cell(Vector2i(53,-14), 7, Vector2i(12,0))



######################### water ###############################################
		
func ComfirmationAction():
	if input_pressed and not Global.cup_water:
		if not Global.interaction:
			$Player/CanvasLayer/Comfirmation.show()
			$Player/CanvasLayer.layer = 2
			if not $Player.pressed:
				$Player/CanvasLayer/Comfirmation/Yes.grab_focus()
				$Player.pressed = true
			Global.open_comfirmation = true
			Global.startChat_for_non_attack = true
		
		var read_file = Global._ReadInteractFile()
		if read_file != null:
			JSONarray = read_file[0]
			var the_font
			if Global.lang_jp:
				the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
				if "text_jp" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_jp"]
			if Global.lang_man:
				the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
				if "text_man" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_man"]
			if Global.lang_sim_man:
				the_font = preload("res://Dialogue/DialogueTextFile/ZCOOLXiaoWei-Regular.ttf")
				if "text_sim_man" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_sim_man"]
			if Global.lang_eng:
				the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
				if "text_eng" in JSONarray:
					$Player/CanvasLayer/Comfirmation/text.text = JSONarray["text_eng"]
			$Player/CanvasLayer/Comfirmation/text.add_theme_font_override("font", the_font)
		if Global.close_mark:
			first = true
			Global.interaction = false
			Global.close_mark = false
		input_pressed = false

func ItemInteraction():
	if beach:
		Global.cup_water = true



func _on_beach_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("inarea")
		in_area = true
		beach = true
		Global.place = "tilemap"
		Global.item = "water"
		
func _on_beach_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		print("exited")
		beach = false
		first = true
		in_area = false
		Global.place = ""
		Global.item = ""
		Global.hide_esc = false
		Global.interaction = false
		Global.close_mark = false
		
############################## me water ##################

func _on_me_at_beach_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_me_area = true

func _on_me_at_beach_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_me_area = false
		first = true
		Global.place = ""
		Global.item = ""
		Global.character_name = ""
		Global.hide_esc = false
		Global.interaction = false
		Global.close_mark = false
