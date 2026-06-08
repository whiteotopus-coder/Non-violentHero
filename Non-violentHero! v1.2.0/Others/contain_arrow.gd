extends HBoxContainer

@onready var arrow_key = preload("res://Others/arrow_key.tscn")  # 预加载箭头场景
@onready var arrow_container = $"."  # 获取 HBoxContainer

var block_input = false
var key_sequence: Array = []  # 存储随机方向键
var player_input: Array = []  # 存储玩家的输入
var key_options := ["ui_up", "ui_down", "ui_left", "ui_right"]
var arrow_sprites: Array = []  # 存储所有箭头的 Sprite2D


func generate_key_sequence(max_keys):
	
	key_sequence.clear()
	player_input.clear()
	arrow_sprites.clear()
	# 清空旧的箭头
	for child in arrow_container.get_children():
		child.modulate.a = 0
		child.queue_free()

	# 生成随机方向键
	for i in range(max_keys):
		var random_action = key_options.pick_random()
		var random_key = key_options[randi() % key_options.size()]
		key_sequence.append(random_action)
		
		#print("random_action ",random_action)
		#print("random_key ",random_key)
		#print("key_sequence ",key_sequence)
		
		var arrow_texture = arrow_key.instantiate()
		arrow_texture.set_texture(random_action) # 你自己内部映射图
		arrow_container.add_child(arrow_texture)
		arrow_sprites.append(arrow_texture)
		arrow_texture.modulate.a = 0  # 先隐藏箭头
		await get_tree().process_frame  # 等待一帧，让 HBoxContainer 布局完成
	await get_tree().process_frame  # 等待一帧，让 HBoxContainer 布局完成
	
	# 逐个显示箭头
	for arrow in arrow_sprites:
		arrow.modulate.a = 1



func check_input(input_key,max_keys):
	if not Global.win_btn_game and not Global.lose_btn_game:
		if key_sequence.is_empty():  # 确保 key_sequence 不为空
			return
			
		var index = player_input.size()  # 当前玩家输入的索引（按顺序匹配）
		
		if not block_input:
			#wsad
			if input_key == key_sequence[index]:  # 按对了
				Global.play_true_sound = true
				arrow_sprites[index].update("2")  # 变成绿色
				player_input.append(input_key)  # 记录玩家输入
				
				if player_input.size() == key_sequence.size():  # 如果全部输入完毕
					block_input = true
					await get_tree().create_timer(0.3).timeout  # 等待 2 秒
					generate_key_sequence(max_keys)  # 重新开始新一轮
					check_true_counter()
					block_input = false
					Global.reset_button_time = true
					
			else:  # 按错了
				Global.play_wrong_sound = true
				block_input = true
				arrow_sprites[index].update("3") # 变成红色
				await get_tree().create_timer(0.5).timeout  # 等待 1.5 秒
				generate_key_sequence(max_keys)  # 重新生成随机按键
				check_false_counter()
				block_input = false
				Global.reset_button_time = true
			


func check_true_counter():
	if Global.lives_opp >= 0:
		Global.lives_opp -= 1
		Global.heart_once = true
	if Global.lives_opp <= 0:
		#print('YOU WIN')
		Global.win_btn_game = true



func check_false_counter():
	if Global.lives >= 0:
		Global.lives -= 1
		Global.heart_once = true
	if Global.lives <= 0:
		#print('YOU LOSE')
		Global.lose_btn_game = true
		
