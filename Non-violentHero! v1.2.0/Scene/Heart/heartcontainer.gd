extends HBoxContainer

@onready var heartclass = preload("res://Scene/Heart/heart.tscn")
# Called when the node enters the scene tree for the first time.
var first_set = false



func setHeart(num: int):
	# 添加新的心節點
	for i in range(num):
		var heart = heartclass.instantiate()
		add_child(heart) 
		#print(num)

func removeHeart(num: int):
	# 添加新的心節點
	for i in range(num):
		var hearts = get_child(get_child_count()-1)
		remove_child(hearts)
		hearts.queue_free()
		

func clear_heart():
	for child in get_children():
		remove_child(child)
		child.queue_free()
		
		
func update(num: int):
	var heart_ani = heartclass.instantiate()
	var hearts = get_children()
	var heart_count = hearts.size()
	for i in range(heart_count):
		if i < num:
			hearts[i].first_update(true)
		else:
			hearts[i].first_update(false)
			
	
func updateHeart(num: int):
	var hearts = get_children()
	var heart_count = hearts.size()
	var first_broken = true
	for i in range(heart_count):
		if i < num:
			#Red heart
			if i == (num-1) and first_set:
				hearts[i].update(true, false, true)
				first_set = false
			else:
				hearts[i].update(true, false, false)
		else:
			if first_broken:
				#Play broke the heart animation
				hearts[i].update(false, true, false)
				first_broken = false
			else:
				#Broken heart
				hearts[i].update(false, false, false)
				


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):pass
	#if Global.heart_increase_once:
		#set_heart_increase_once(1)
		#Global.heart_increase_once = false



#func set_heart_increase_once(num: int):
	# 添加新的心節點
	#if num == 5:
		#Global.demon_love = true
	#if get_children().size() <= 4 and get_children().size() >= 0 :
		#for i in range(num):
			#var heart_increase_once = heartclass.instantiate()
			#add_child(heart_increase_once)
			
