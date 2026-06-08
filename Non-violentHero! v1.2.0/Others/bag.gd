extends Control

@onready var item: GridContainer = $Panel/Bag/MarginContainer/Item

var num_box_of_bag = 0
var open_bag = false
var items = Global.items
var open_explanation = false
var open_comfirmation = false
var focus_comfirmation = false
var clicked_btn_once = false
var task_list = [
	{
		"text_task1_jp": "洞窟で魔王にさらわれた姫を助け出す。",
		"text_task1_eng": "Rescue the princess from the Demon King in the cave.",
		"text_task1_tra": "去洞穴從魔王手中救出公主。",
		"text_task1_sim": "去洞穴从魔王的手上救出公主。"
	},
	{
		"text_task2_jp": "ドーナツを手に入れる。",
		"text_task2_eng": "Obtain the donut.",
		"text_task2_tra": "得到甜甜圈。",
		"text_task2_sim": "得到甜甜圈。"
	},
	{
		"text_task3_jp": "伝説の衣装を手に入れる。",
		"text_task3_eng": "Acquire the legendary battle suit.",
		"text_task3_tra": "得到傳說中的戰衣。",
		"text_task3_sim": "得到传说中的战衣。"
	},
	{
		"text_task4_jp": "洞窟の入口にいる雑魚たちに、要求されたアイテムを渡す。",
		"text_task4_eng": "Give the requested item to the demons at the cave entrance.",
		"text_task4_tra": "把山洞口的小怪要求的物品交給他們。",
		"text_task4_sim": "把山洞口的小怪要求的物品交给他们。"
	},
	{
		"text_task5_jp": "大道芸人を教会に入れてもらえるよう、シスターを説得する。",
		"text_task5_eng": "Convince the nun to let the busker enter the church.",
		"text_task5_tra": "幫街頭藝人說服修女，讓她進入教堂。",
		"text_task5_sim": "帮街头艺人说服修女，让她进入教堂。"
	},
	{
		"text_task6_jp": "シスターの許可が下りたことを大道芸人に伝える。",
		"text_task6_eng": "Tell the busker that the nun has agreed.",
		"text_task6_tra": "告知街頭藝人修女允許她進入教堂了。",
		"text_task6_sim": "告知街头艺人修女允许她进入教堂了。"
	},
	{
		"text_task7_jp": "教師を手伝い、いじめっ子の親を説得する。",
		"text_task7_eng": "Help the teacher persuade the bully’s parents.",
		"text_task7_tra": "幫助老師說服霸凌人的同學的家長。",
		"text_task7_sim": "帮助老师说服霸凌人的同学的家长。"
	}
]

func fontStyles():
	var font
	if Global.lang_eng:
		font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	elif Global.lang_man or Global.lang_jp:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	elif Global.lang_sim_man:
		font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
	$task/Label.add_theme_font_override("font", font)
	$Comfirmation/Text.add_theme_font_override("font", font)


func newTaskAnimation():
	Global.play_bing_sound = true
	fontStyles()
	if Global.lang_jp:
		$task/Label.text = "新たな任務！"
	elif Global.lang_eng:
		$task/Label.text = "New Task!"
	elif Global.lang_man:
		$task/Label.text = "新任务！"
	elif Global.lang_sim_man:
		$task/Label.text = "新任務！"
	$task.texture = preload("res://Images/items/get_task.png")
	$AnimationPlayer.play("get_task")
	Global.play_new_task_animation = false
	

func completedTaskAnimation():
	Global.play_true_sound = true
	fontStyles()
	if Global.lang_jp:
		$task/Label.text = "任務クリア！"
	if Global.lang_eng:
		$task/Label.text = "Task Completed!"
	elif Global.lang_man:
		$task/Label.text = "任务完成！"
	elif Global.lang_sim_man:
		$task/Label.text = "新任完成！"
	$task.texture = preload("res://Images/items/done_task.png")
	$AnimationPlayer.play("get_task")
	$AnimationPlayer.animation_finished
	Global.play_completed_task_animation = false
	
		
func _physics_process(delta: float) -> void:	
	################################### task list ################################	
	var font	
	if Global.lang_jp:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		_task_list("jp")
		
	if Global.lang_eng:
		font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		_task_list("eng")

	elif Global.lang_man:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		_task_list("tra")
		
	elif Global.lang_sim_man:
		font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		_task_list("sim")
		
	for i in range(7):
		var task_node = $Panel/ScrollContainer/VBoxContainer.get_node("HBoxContainer" + str(i + 1))
		var task = task_node.get_node("Text")
		task.add_theme_font_override("font", font)
		
	if Global.play_new_task_animation:
		newTaskAnimation()
		
	if Global.play_completed_task_animation:
		completedTaskAnimation()

	if not open_bag:
		$Explanation.hide()
		$EatButton.hide()
	

func _task_list(language):
	
	if Global.king_tutorial:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/Text.text = task_list[0]["text_task1_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/box2.hide()
	else:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer1/box2.hide()
	
	if Global.get_task:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/Text.text = task_list[1]["text_task2_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/Text.text = task_list[2]["text_task3_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/box2.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/box2.hide()
		if (Global.task_1_get and not Global.eat_road_side_donut_saved) or Global.task_3_get:#donut
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/box.hide()
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/box2.show()
		if Global.task_2_get:#battle suit
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/box.hide()
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/box2.show()
	else:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer2/box2.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer3/box2.hide()
	
	
	if Global.task_1_get and Global.task_2_get:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/Text.text = task_list[3]["text_task4_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/box2.hide()
		if Global.get_rob:
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/box.hide()
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/box2.show()
	else:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer4/box2.hide()
		
			
	if Global.church_get_task:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/Text.text = task_list[4]["text_task5_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/box2.hide()
		if Global.church_done:
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/box.hide()
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/box2.show()
	else:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer5/box2.hide()
	
	if Global.church_done:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/Text.text = task_list[5]["text_task6_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/box2.hide()
		if Global.move_to_church:
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/box.hide()
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/box2.show()
	else:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer6/box2.hide()
		
		
	if Global.kid_enter_room:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/Text.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/Text.text = task_list[6]["text_task7_" + str(language)]
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/box.show()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/box2.hide()
		if Global.stage1_done:
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/box.hide()
			$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/box2.show()
	else:
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/Text.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/box.hide()
		$Panel/ScrollContainer/VBoxContainer/HBoxContainer7/box2.hide()
	

	
func _ready():
	################################### bag ######################################
	for i in range(9):
		var slot = $Panel/Bag/MarginContainer/Item.get_node("TextureButton" + str(i + 1))
		if not slot:
			continue
			
		if not slot.focus_entered.is_connected(_on_texture_focus_entered.bind(slot)):
			slot.focus_entered.connect(_on_texture_focus_entered.bind(slot))
		if not slot.focus_exited.is_connected(_on_texture_focus_exited.bind(slot)):
			slot.focus_exited.connect(_on_texture_focus_exited.bind(slot))

		var up = i - 3
		var down = i + 3
		var left = i - 1
		var right = i + 1
		
		if up >= 0:
			var up_slot = $Panel/Bag/MarginContainer/Item.get_node("TextureButton" + str(up + 1))
			slot.focus_neighbor_top = up_slot.get_path()
		else:
			slot.focus_neighbor_top = slot.get_path()

		if down < 9:
			var down_slot = $Panel/Bag/MarginContainer/Item.get_node("TextureButton" + str(down + 1))
			slot.focus_neighbor_bottom = down_slot.get_path()
		else:
			slot.focus_neighbor_bottom = slot.get_path()

		if i % 3 != 0:
			var left_slot = $Panel/Bag/MarginContainer/Item.get_node("TextureButton" + str(left + 1))
			slot.focus_neighbor_left = left_slot.get_path()
		else:
			slot.focus_neighbor_left = slot.get_path()

		if i % 3 != 2:
			var right_slot = $Panel/Bag/MarginContainer/Item.get_node("TextureButton" + str(right + 1))
			slot.focus_neighbor_right = right_slot.get_path()
		else:
			slot.focus_neighbor_right = slot.get_path()
	$Panel/Bag/MarginContainer/Item/TextureButton1.grab_focus()


func _get_item(itemdata):
	#get data when recieving items
	Global.items.append(itemdata)
	
func _update_img():
	var run_all_item = item.get_children()
	# 先清空
	for btn in run_all_item:
		btn.texture_normal = null
	# 再重新填入
	for i in range(Global.items.size()):
		var item_data = Global.items[i]
		var img = load(item_data["image"])
		run_all_item[i].texture_normal = img
	
func _on_bagbtn_pressed() -> void:
	open_bag = true
	Global.open_comfirmation = true
	Global.hide_esc = true
	Global.play_button_sound = true
	_update_img()
	var font
	if Global.lang_jp:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$Panel/Task.text = "任務一覧"
		$Panel/BagText.text = "持ち物"
	if Global.lang_eng:
		font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$Panel/Task.text = "Task List"
		$Panel/BagText.text = "Bag"
	if Global.lang_man:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$Panel/Task.text = "任务列表"
		$Panel/BagText.text = "背包"
	if Global.lang_sim_man:
		font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$Panel/Task.text = "任務列表"
		$Panel/BagText.text = "背包"
	$Panel/Task.add_theme_font_override("font", font)
	$Panel/BagText.add_theme_font_override("font", font)
	$AnimationPlayer.play("open_bag")
	$Panel.show()
	await $AnimationPlayer.animation_finished
	#grab focus
	var btn_focus = get_node("Panel/Bag/MarginContainer/Item/TextureButton2/focus")
	btn_focus.show()
	var btn = get_node("Panel/Bag/MarginContainer/Item/TextureButton2")
	btn.grab_focus()

func _on_back_pressed() -> void:
	clicked_btn_once = false
	$EatButton/focus.hide()
	open_bag = false
	$Explanation.hide()
	$BackExp.hide()
	$Comfirmation.hide()
	$EatButton.hide()
	Global.play_button_back_sound = true
	$AnimationPlayer.play("close_bag")
	await $AnimationPlayer.animation_finished
	$Panel.hide()
	$bagbtn.show()
	Global.open_comfirmation = false
	Global.hide_esc = false
	Global.pressed_close_menu = true

			
func _input(event: InputEvent) -> void:
	
	if not Global.openMenu and not open_explanation:
		if not Global.hide_esc:
			if Input.is_action_just_pressed("ui_focus_next") or (Global.attack_scene and Input.is_action_just_pressed("ui_focus_next")):
				if not open_bag:
					_on_bagbtn_pressed()
					$Panel/Bag/MarginContainer/Item/TextureButton1.grab_focus()
		if Input.is_action_just_pressed("ui_cancel"):
			if open_bag and not open_comfirmation and not focus_comfirmation:
				_on_back_pressed()
				get_viewport().gui_release_focus()
	if Input.is_action_just_pressed("ui_cancel") and open_explanation and not open_comfirmation and not focus_comfirmation:
		_on_back_exp_pressed()
	if Input.is_action_just_pressed("ui_cancel") and open_comfirmation:
		_on_no_pressed()
	if Input.is_action_just_pressed("ui_cancel") and focus_comfirmation and not open_comfirmation:
		_escape_eat_button()
		clicked_btn_once = true
	if Input.is_action_just_pressed("Mouse_Left") and clicked_btn_once:
		_escape_eat_button()
		clicked_btn_once = false

func _escape_eat_button():
	var btn_focus = get_node("Panel/Bag/MarginContainer/Item/TextureButton" + str(num_box_of_bag + 1) + "/focus")
	btn_focus.show()
	var btn = get_node("Panel/Bag/MarginContainer/Item/TextureButton" + str(num_box_of_bag + 1))
	btn.grab_focus()
	$EatButton/focus.hide()
	focus_comfirmation = false
		
func _on_back_exp_pressed() -> void:
	open_explanation = false
	clicked_btn_once = false
	Global.play_button_back_sound = true
	$EatButton/focus.hide()
	$BackExp.hide()
	$Comfirmation.hide()
	$Explanation.hide()
	$EatButton.hide()


func _check_btn(x):
	num_box_of_bag = x
	Global.play_button_sound = true
	var item_data = null
	if x >= 0 and x < items.size():
		open_explanation = true
		$Explanation.show()
		$BackExp.show()
		
		item_data = items[x]
		if item_data["name"] == "donut" and clicked_btn_once: 
			focus_comfirmation = true
			$EatButton.grab_focus()
			$EatButton/focus.show()
		elif item_data["name"] == "donut_puffer" and clicked_btn_once:
			focus_comfirmation = true
			$EatButton.grab_focus()
			$EatButton/focus.show()
		
		if not clicked_btn_once:
			$EatButton/focus.hide()
			
		clicked_btn_once = true
		
		if item_data["name"] == "donut":
			$EatButton.show()
		elif item_data["name"] == "donut_puffer":
			$EatButton.show()
		else:
			$EatButton.hide()
			$EatButton/focus.hide()
			clicked_btn_once = false
			
		var img_explanation = load(item_data["img_exp"])
		$Explanation/Img.texture = img_explanation
		var font
		if Global.lang_jp:
			font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			$Explanation/TextOutline/ExplanationText.text = item_data["text_exp_jp"]
		if Global.lang_eng:
			font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
			$Explanation/TextOutline/ExplanationText.text = item_data["text_exp_eng"]
		if Global.lang_man:
			font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
			$Explanation/TextOutline/ExplanationText.text = item_data["text_exp_tra"]
		if Global.lang_sim_man:
			font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
			$Explanation/TextOutline/ExplanationText.text = item_data["text_exp_sim"]
		$Explanation/TextOutline/ExplanationText.add_theme_font_override("font", font)
			
func _on_texture_button_pressed() -> void:
	_check_btn(0)	
func _on_texture_button_2_pressed() -> void:
	_check_btn(1)
func _on_texture_button_3_pressed() -> void:
	_check_btn(2)
func _on_texture_button_4_pressed() -> void:
	_check_btn(3)
func _on_texture_button_5_pressed() -> void:
	_check_btn(4)
func _on_texture_button_6_pressed() -> void:
	_check_btn(5)
func _on_texture_button_7_pressed() -> void:
	_check_btn(6)
func _on_texture_button_8_pressed() -> void:
	_check_btn(7)
func _on_texture_button_9_pressed() -> void:
	_check_btn(8)


func _on_texture_focus_entered(button: TextureButton) -> void:
	if button.has_node("focus"):
		button.get_node("focus").show()
func _on_texture_focus_exited(button: TextureButton) -> void:
	if button.has_node("focus"):
		button.get_node("focus").hide()


func ShowComfirmation():
	$Comfirmation/No.position = Vector2(664.0,376.0)
	$Comfirmation/Yes.show()
	$Comfirmation.show()
	$Panel.hide()
	$Explanation.hide()
	$EatButton.hide()
	$BackExp.hide()
	fontStyles()
	if Global.lang_eng:
		$Comfirmation/Text.text = "Eat it?"
	if Global.lang_jp:
		$Comfirmation/Text.text = "食べる？"
	if Global.lang_sim_man:
		$Comfirmation/Text.text = "吃掉？"
	if Global.lang_man:
		$Comfirmation/Text.text = "吃掉？"
	
		
func _on_eat_button_pressed() -> void:
	open_comfirmation = true
	ShowComfirmation()
	$Comfirmation/No.grab_focus()

func _on_no_pressed() -> void:
	open_comfirmation = false
	$Comfirmation.hide()
	$Panel.show()
	$Explanation.show()
	$EatButton.show()
	$BackExp.show()
	$EatButton.grab_focus()
	$EatButton/focus.show()

func _on_yes_pressed() -> void:
	var item_data = null
	item_data = items[num_box_of_bag]
	print(item_data)
	if item_data["name"] == "donut":
		print("yes")
		Global.eat_road_side_donut = true
		Global.items.erase(item_data)
	if item_data["name"] == "donut_puffer":
		Global.eat_puffer_donut = true
		Global.items.erase(item_data)
	Global.hide_esc = true
	Global.allow_move = false
	_on_no_pressed()
	_update_img()
	_on_back_exp_pressed()
	_on_back_pressed()
		
