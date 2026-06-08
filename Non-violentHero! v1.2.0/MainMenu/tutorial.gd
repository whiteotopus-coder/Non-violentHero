extends Control

var close = false
var open_tuto = false

var num_tuto = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	num_tuto = 1
	$tutorial2.hide()
	$tutorial3.hide()
	$tutorial1.show()
	$Right.show()
	$Left.hide()
	$menu_yes.hide()
	Global.startChat = true
	$AnimationPlayer.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var the_font
	if Global.lang_sim_man:
		the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		$tutorial1/text1.text = "按"
		$tutorial1/text2.text = "或"
		$tutorial1/text3.text = "来和环境互动，比如开启对话和转换场景。"
		$tutorial2/text1.text = "按"
		$tutorial2/text2.text = "来让角色移动。"
		$tutorial2/text3.text = "或"
		$tutorial2/text4.text = "*按住 Shift 键奔跑*"
		$tutorial3/text1.text = "按住奔跑"
		$tutorial3/text2.text = "打开背包"
		$tutorial3/text3.text = "互动"
		$tutorial3/text4.text = "关闭物品"
		$tutorial3/text5.text = "打开菜单"
	elif Global.lang_man:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$tutorial1/text1.text = "按"
		$tutorial1/text2.text = "或"
		$tutorial1/text3.text = "來和環境互動，比如開啓動畫和轉換場景。"
		$tutorial2/text4.text = "*按住 Shift 鍵奔跑*"
		$tutorial2/text1.text = "按"
		$tutorial2/text2.text = "來讓角色移動。"
		$tutorial2/text3.text = "或"
		$tutorial3/text1.text = "按住奔跑"
		$tutorial3/text2.text = "打開背包"
		$tutorial3/text3.text = "互動"
		$tutorial3/text4.text = "關閉物品"
		$tutorial3/text5.text = "開啟選單"	
	elif Global.lang_jp:
		the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		$tutorial1/text1.text = ""
		$tutorial1/text2.text = "または"
		$tutorial1/text3.text = "周囲とやり取りする"
		$tutorial2/text4.text = "※Shiftキーを押しながら走る"
		$tutorial2/text1.text = ""
		$tutorial2/text2.text = "キャラクターを移動する"
		$tutorial2/text3.text = "または"
		$tutorial3/text1.text = "走る"
		$tutorial3/text2.text = "インベントリ"
		$tutorial3/text3.text = "調べる"
		$tutorial3/text4.text = "閉じる"
		$tutorial3/text5.text = "メニュー"
	elif Global.lang_eng:
		the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		$tutorial1/text1.text = "Press"
		$tutorial1/text2.text = "or"
		$tutorial1/text3.text = "to do interaction like start the chat and open the door."
		$tutorial2/text1.text = "Press"
		$tutorial2/text2.text = "to move the character"
		$tutorial2/text3.text = "or"
		$tutorial2/text4.text = "*Hold shift to run.*"
		$tutorial3/text1.text = "Hold to Run"
		$tutorial3/text2.text = "Open Inventory"
		$tutorial3/text3.text = "Interact"
		$tutorial3/text4.text = "Close Item"
		$tutorial3/text5.text = "Open Menu"
	$tutorial1/text1.add_theme_font_override("font", the_font)
	$tutorial1/text2.add_theme_font_override("font", the_font)
	$tutorial1/text3.add_theme_font_override("font", the_font)
	$tutorial2/text4.add_theme_font_override("font", the_font)
	$tutorial2/text1.add_theme_font_override("font", the_font)
	$tutorial2/text2.add_theme_font_override("font", the_font)
	$tutorial2/text3.add_theme_font_override("font", the_font)
	$tutorial3/text1.add_theme_font_override("font", the_font)
	$tutorial3/text2.add_theme_font_override("font", the_font)
	$tutorial3/text3.add_theme_font_override("font", the_font)
	$tutorial3/text4.add_theme_font_override("font", the_font)
	$tutorial3/text5.add_theme_font_override("font", the_font)
	
	if open_tuto and Input.is_action_just_pressed("ui_right"):
		_on_right_pressed()
	if open_tuto and Input.is_action_just_pressed("ui_left"):
		_on_left_pressed()
	
	
	
func _on_right_pressed():
	Global.play_button_sound = true
	if num_tuto <= 2:
		num_tuto += 1
	if num_tuto == 2:
		$Left.position.x = 786.0
		$menu_yes.hide()
		$tutorial2.show()
		$tutorial3.hide()
		$tutorial1.hide()
		$Right.show()
		$Left.show()
		$Right.grab_focus()
	if num_tuto == 3:
		$Left.position.x = 855.0
		$tutorial3.show()
		$tutorial2.hide()
		$Right.hide()
		$Left.show()
		$menu_yes.show()
		$Left.grab_focus()

func _on_left_pressed():
	Global.play_button_sound = true
	if num_tuto >= 2:
		num_tuto -= 1
	if num_tuto == 1:
		$Left.position.x = 855.0
		$tutorial2.hide()
		$tutorial1.show()
		$Right.show()
		$Left.hide()
		$menu_yes.hide()
		$Right.grab_focus()
	if num_tuto == 2:
		$Left.position.x = 786.0
		$menu_yes.hide()
		$tutorial2.show()
		$tutorial1.hide()
		$tutorial3.hide()
		$Right.show()
		$Left.show()
		$Left.grab_focus()



func _on_menu_yes_pressed():
	Global.play_button_sound = true
	$AnimationPlayer.play("quit")
	await $AnimationPlayer.animation_finished
	$".".hide()
	_on_left_pressed()
	close = true
	open_tuto = false
	Global.open_comfirmation = false
	Global.startChat = false
