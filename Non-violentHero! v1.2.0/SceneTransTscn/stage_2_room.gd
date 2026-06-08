extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "肥宅房間"
	Global.save_place_sim_man = "肥宅房间"
	Global.save_place_eng = "Otaku's Room"
	Global.save_place_jp = "オタクの部屋"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.from_load = false
	Global.play_no_song = true
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/stage_2_room.tscn"
	Global.startChat_for_non_attack = false
	Global.hide_get_task = false
	Global.stage_2_corridor = false
	Global.stage_2_position = true
	Global.place = ""
	Global.character_name = ""
	Global.startChat = false
	Global.file_load = false
	$chatbox.hide()
	#Global.player_position = Vector2(0, 0)

	
	if Global.mom_win:
		$mummy.show()
		$mummy/CollisionShape2D.disabled = false
		$Player.position = $AfterAttack.position
	else:
		$mummy.hide()
		$mummy/CollisionShape2D.disabled = true
	
	
	
func _process(_delta):
	
	if Global.setposition:
		#$Player.position = $AfterAttack.position
		Global.setposition = false

	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.show_last_option_otaku:
		Global.show_last_option = true
	else:
		Global.show_last_option = false
		
	if Global.task_2_get:
		var if_have_battle_suit = false
		for item in Global.items:
			if (item.has("name") and item["name"] == "battle_suit"):
				if_have_battle_suit = true
		if not if_have_battle_suit:
			var itemData: Dictionary
			itemData = {
				"name":"battle_suit",
				"image":"res://Images/items/task1.png",
				"img_exp":"res://Images/UI/t-shirt.png",
				"text_exp_eng":"The legendary battle suit gave by Otaku.",
				"text_exp_tra":"肥宅給的傳説中的戰衣。",
				"text_exp_sim":"肥宅给的传说中的战衣。",
				"text_exp_jp":"オタクにもらった伝説の衣装。"
			}
			$Control/CanvasLayer/bag._get_item(itemData)
		




func _on_mom_body_exited(_body):
	Global.place = ""
	Global.character_name = ""
	$chatbox.hide()


func _on_mom_body_entered(body):
	if body.name == "Player":
		if Global.mom_win:
			Global.current_character = "aunty"
			Global.place = "Map"
			Global.character_name = "Mon_win"
			$chatbox.show()
			$AnimationPlayer.play("mummy_chatbox")
