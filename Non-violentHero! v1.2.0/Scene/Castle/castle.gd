extends Node2D

var chat = false
var if_have_map = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "空空的國王城堡（連椅子都沒有）"
	Global.save_place_eng = "Empty King's Castle"	
	Global.save_place_sim_man = "空空的国王城堡（连椅子都沒有）"
	Global.save_place_jp = "何もない王様の城（椅子すらない）"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.file_load = false
	Global.startChat = false
	Global.in_castle = true
	Global.place = "" 
	Global.character_name = ""
	Global.last_scene_name = "castle"
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/castle.tscn"
	Global.startChat_for_non_attack = false
	Global.player = true
	
	for item in Global.items:
			if item.has("name") and item["name"] == "map":
				if_have_map = true
				
	if Global.king_tutorial and not if_have_map:
		$Control/CanvasLayer/Tutorial.hide()
		Global.place = "Map"
		Global.character_name = "King_attack_2"
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			dialogue_node.PressFKey()
		chat = true
	
	if not Global.king_tutorial and not Global.from_load:
		SaveFunction.auto_save()
		$Control/CanvasLayer/Tutorial.show()
		$Control/CanvasLayer/Tutorial/Right.grab_focus()
		$Control/CanvasLayer/Tutorial.open_tuto = true
		Global.open_comfirmation = true
	
	if Global.from_load:
		Global.from_load = false
	
	if Global.setposition:
		$Player.position = $AfterAttack.position
		Global.setposition = false
		$Player/AnimatedSprite2D.play("idle_up")
		
	

func _on_area_2d_area_entered(_area):
	if not chat and not Global.hideking and not Global.king_tutorial:
		Global.place = "Map"
		Global.character_name = "King"
		var dialogue_node = get_node("Dialogue")
		if dialogue_node:
			dialogue_node.PressFKey()
		chat = true
		


func _on_area_2d_area_exited(_area):
	if not Global.church_done:
		Global.startChat = false
		Global.place = ""
		Global.character_name = ""
	
	
func _process(_delta):
	
	#if Global.setposition:
		#print("set_pos")
		#$Player.position = $AfterAttack.position
		#Global.setposition = false

	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.hideking:
		$king.hide()
		$king/CollisionShape2D.disabled = true
		chat = true
	
	if Global.give_map:
		for item in Global.items:
			if (item.has("name") and item["name"] == "map"):
				if_have_map = true
		if not if_have_map:
			Global.play_bing_sound = true
			var itemData: Dictionary
			itemData = {
				"name":"map",
				"image":"res://Images/items/small_map.png",
				"img_exp":"res://Images/items/map.png",
				"text_exp_eng":"A map personally drawn by the King!\n(You can’t zoom in on it because the King doesn’t want you to see his drawing too clearly. That would be way too embarrassing and intimate!\nIt’s definitely NOT because the developer was too lazy to add a zoom feature.)",
				"text_exp_tra":"國王親手畫的地圖！\n（不可以放大來看，是因爲國王不想讓你把他的畫看得太清楚，那樣太赤裸了，太害羞了！絕對不是因爲作者懶得加放大的功能哦！）\n",
				"text_exp_sim":"国王亲手画的地图！\n（不能放大查看，是因为国王不想让你把他的画看得太清楚，那样实在太赤裸、太害羞了！绝对不是因为作者懒得加放大功能哦！）\n",
				"text_exp_jp":"王様が自ら描いた地図！\n（拡大できないのは、王様が自分の絵をじっくり見られたくないからだ！あまりにも丸見えで、ちょっと恥ずかしいらしい！決して作者がズーム機能の実装をサボったわけではない！）\n"
			}
			$Control/CanvasLayer/bag._get_item(itemData)



func _on_b_4_chat_body_entered(body):
	if not chat and not Global.king_tutorial:
		if body.name == "Player":
			Global.hide_esc = true
			Global.place = "Map"
			Global.character_name = "King_call"
			$Player.position = $backpos.position
			var dialogue_node = get_node("Dialogue")
			if dialogue_node:
				dialogue_node.PressFKey()
			
			

func _on_scene_trigger_body_entered(_body):
	Global.hide_esc = true
	Global.in_castle = false
