extends Control

var endings = ["Ending1", "Ending2", "Ending3", "Ending4", "Ending5", "Ending6", "Ending7", "Ending8", "Ending9", "Ending10", "Ending11", "Ending12", "Ending13"]
var titles_eng = {
	"Ending1": "Ending 1: Three Strikes and You're Out",
	"Ending2": "Ending 2: Eternal Love",
	"Ending3": "Ending 3: A Budding Romance",
	"Ending4": "Ending 4: The Grave of Love",
	"Ending5": "Ending 5: Infinity free carrot juice",
	"Ending6": "Ending 6: Homeless together",
	"Ending7": "Ending 7: Rest in food",
	"Ending8": "Ending 8: Heroes Not Required",
	"Ending9": "Ending 9: The Unstoppable Princess",
	"Ending10": "Ending 10: Love in Green",
	"Ending11": "Ending 11: Non-violent Hero",
	"Ending12": "Ending 12: Violent Hero",
	"Ending13": "Ending 13: Life is precious. "
}

var titles_jp = {
	"Ending1": "エンディング1： 三度の猶予もここまで",
	"Ending2": "エンディング2： 愛に包まれて",
	"Ending3": "エンディング3： 両想い",
	"Ending4": "エンディング4： 愛へ続く墓",
	"Ending5": "エンディング5： 無限供給大根汁",
	"Ending6": "エンディング6： 路頭に迷うことになった",
	"Ending7": "エンディング7： 満腹の旅立ち",
	"Ending8": "エンディング8： 余計な勇者",
	"Ending9": "エンディング9： 手に負えない姫",
	"Ending10": "エンディング10： 緑の愛",
	"Ending11": "エンディング11：非暴力系勇者",
	"Ending12": "エンディング12：暴力系勇者",
	"Ending13": "エンディング13：命はかけがえのないもの。もう一度、自分にチャンスを。"
}

var titles_man = {
	"Ending1": "結局一： 事不過三",
	"Ending2": "結局二： 永浴愛河",
	"Ending3": "結局三： 兩情相悅",
	"Ending4": "結局四： 通往愛情的墳墓",
	"Ending5": "結局五： 無限蘿蔔水",
	"Ending6": "結局六： 流浪街頭",
	"Ending7": "结局七： 吃飽好上路",
	"Ending8": "結局八：不需要勇者的世界",
	"Ending9": "结局九: 惹不起的公主",
	"Ending10": "结局十: 青色的戀愛",
	"Ending11": "结局十一: 非暴力系勇者",
	"Ending12": "结局十二: 暴力系勇者",
	"Ending13": "结局十三: 生命誠可貴，請再給自己第二次機會。"
}

var titles_sim_man = {
	"Ending1": "结局一： 事不过三",
	"Ending2": "结局二： 永浴爱河",
	"Ending3": "结局三： 两情相悦",
	"Ending4": "结局四： 通往爱情的坟墓",
	"Ending5": "结局五： 无限供应萝卜水",
	"Ending6": "结局六： 流浪街头",
	"Ending7": "结局七： 吃饱好上路",
	"Ending8": "结局八： 多余的勇者",
	"Ending9": "结局九： 惹不起的公主",
	"Ending10": "结局十: 青色的恋爱",
	"Ending11": "结局十一: 非暴力系勇者",
	"Ending12": "结局十二: 暴力系勇者",
	"Ending13": "结局十三: 生命诚可贵，请再给自己第二次机会。"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$LoadGame/ScrollContainer/GridContainer/Ending1.grab_focus()
	
	Global.from_ending = true
	
	if not Global.from_menu:
		Global.play_menu_song = true
	
	Global.load_ending()
	Global.play_ending_one = false
	Global.play_ending_two = false
	Global.play_ending_three = false
	Global.play_ending_four = false
	Global.play_ending_five = false
	Global.play_ending_six = false
	Global.play_ending_seven = false
	Global.play_ending_eight = false
	Global.play_ending_nine = false
	Global.play_ending_ten = false
	Global.play_ending_eleven = false
	Global.play_ending_twelve = false
	Global.play_ending_thirteen = false
	
	##################### Font #####################
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
	if Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	if Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	if Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	##################### Ending #####################
	for ending in endings:
		#拿array里面Ending后面不是有个数字嘛，这边的6就是这个数字的位置号码
		var ending_var = "ending" + ending.substr(6)
		var label = $LoadGame/ScrollContainer/GridContainer.get_node(ending).get_node(ending)
		var button = $LoadGame/ScrollContainer/GridContainer.get_node(ending)
		var pic = $LoadGame/ScrollContainer/GridContainer.get_node(ending).get_node("TextureRect")
			
		if not Global.get(ending_var):
			button.disabled = true
			if Global.lang_man:
				label.text = ""
			if Global.lang_eng:
				label.text = ""
			if Global.lang_sim_man:
				label.text = ""
			if Global.lang_jp:
				label.text = ""
			pic.texture = load("res://Images/ending/ending_disable.png")
		else:
			button.disabled = false
			if Global.lang_man:
				label.text = titles_man[ending]
			if Global.lang_jp:
				label.text = titles_jp[ending]
			if Global.lang_eng:
				label.text = titles_eng[ending]
			if Global.lang_sim_man:
				label.text =  titles_sim_man[ending]
			pic.texture = load("res://Images/ending/ending" + ending.substr(6) + ".png")
		label.add_theme_font_override("font", the_font)



func _on_back_pressed():
	if not Global.change_scene:
		Global.play_button_back_sound = true
		$AnimationPlayer.play("quit")
		await $AnimationPlayer.animation_finished
		GlobalCanvasLayer.change_scene("res://MainMenu/main_menu.tscn","faded")



func _on_ending_1_pressed():
	if not Global.change_scene:
		Global.play_ending_one = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")
	
func _on_ending_2_pressed():
	if not Global.change_scene:
		Global.play_ending_two = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_3_pressed():
	if not Global.change_scene:
		Global.play_ending_three = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_4_pressed():
	if not Global.change_scene:
		Global.play_ending_four = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_5_pressed():
	if not Global.change_scene:
		Global.play_ending_five = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_6_pressed():
	if not Global.change_scene:
		Global.play_ending_six = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_7_pressed():
	if not Global.change_scene:
		Global.play_ending_seven = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_8_pressed() -> void:
	if not Global.change_scene:
		Global.play_ending_eight = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_9_pressed() -> void:
	if not Global.change_scene:
		Global.play_ending_nine = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")

func _on_ending_10_pressed() -> void:
	if not Global.change_scene:
		Global.play_ending_ten = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")
		
func _on_ending_11_pressed() -> void:
	if not Global.change_scene:
		Global.play_ending_eleven = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")
		
func _on_ending_12_pressed() -> void:
	if not Global.change_scene:
		Global.play_ending_twelve = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")
	
func _on_ending_13_pressed() -> void:
	if not Global.change_scene:
		Global.play_ending_thirteen = true
		GlobalCanvasLayer.change_scene("res://SceneTransTscn/ending/show_ending.tscn","dissolve")
	
func _on_ending_1_mouse_entered() -> void:
	Global.play_pick_chat_sound = true



func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_back_pressed()
		


################ Change scroll pos y when focus ############################
func _on_ending_1_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 0

func _on_ending_2_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 0

func _on_ending_3_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 210.0

func _on_ending_4_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 210.0

func _on_ending_5_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 580

func _on_ending_6_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 580

func _on_ending_7_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 910

func _on_ending_8_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 910

func _on_ending_9_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 1240

func _on_ending_10_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 1240

func _on_ending_11_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 1570

func _on_ending_12_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 1570

func _on_ending_13_focus_entered() -> void:
	$LoadGame/ScrollContainer.scroll_vertical = 1770
