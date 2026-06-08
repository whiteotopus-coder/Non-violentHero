extends Node2D

var once = true
# Called when the node enters the scene tree for the first time.
func _ready():
	
	##################### write in save file ###################################
	Global.save_place_man = "教師辦公室"
	Global.save_place_sim_man = "老师办公室"
	Global.save_place_eng =  "Teacher's Office"
	Global.save_place_jp = "職員室"
	############################################################################
	
	$Dialogue.dialogue_ready = true
	Global.garrett_house = false
	Global.from_load = false
	Global.attack_scene = false
	Global.previous_scene = "res://SceneTransTscn/stage_1_class.tscn"
	Global.for_the_next = false
	Global.hide_get_task = false
	Global.startChat_for_non_attack = false
	Global.counter = 0  
	Global.counterR = 0
	Global.place = ""
	Global.character_name = ""
	Global.in_stage_1 = true
	Global.stage_1_position = true
	Global.file_load = false
	Global.startChat = false
	
	$CarrotKid/AnimatedSprite2D.play("carrot_in_office")
	$Teacher/AnimatedSprite2D.play("back")
	if not Global.setposition and Global.task_1_get:
		$Teacher.position = $for_teacher.position
		$Teacher/AnimatedSprite2D.play("default")
	if Global.stage1_done:	
		Global.place = "Map"
		Global.character_name = "Carrot_done"
		var dialogue_node = get_node("Dialogue")
		if dialogue_node and not Global.once_stage1:
			dialogue_node.PressFKey()
			Global.once_stage1 = true
	if Global.carrot_leave_room:
		Global.place = ""
		Global.character_name = ""
		$CarrotKid.hide()
		$CarrotKid/CollisionShape2D.disabled = true
		$Carrot.hide()
		$Carrot/CollisionShape2D.disabled = true
		$Teacher/AnimatedSprite2D.play("sigh")
		$Carrot/areaTalk/areaTalk.disabled = true
		$Carrot/right/right.disabled = true
		$Carrot/left/left.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#print(Global.stage1_done)
		
	if Global.setposition:
		$Player.position = $AfterAttack.position
		Global.setposition = false
		
	
	if Global.savegame or Global.loadgame:
		Global.player_position = $Player.global_position
		if not Global.openMenu:
			Global.savegame = false
			Global.loadgame = false
		
	if Global.task_1_get:
		var if_have_donut = false
		for item in Global.items:
			if (item.has("name") and item["name"] == "donut"):
				if_have_donut = true
		if not if_have_donut:
			var itemData: Dictionary
			itemData = {
				"name":"donut",
				"image":"res://Images/items/task2.png",
				"img_exp":"res://Images/UI/donut.png",
				"text_exp_eng":"The donut picked up from the road by the kid.",
				"text_exp_tra":"小孩送的地上撿的甜甜圈。",
				"text_exp_sim":"小孩送的地上捡的甜甜圈。",
				"text_exp_jp":"子どもが地面から拾ったドーナツ。"
			}
			$Control/CanvasLayer/bag._get_item(itemData)
		
