extends Control

var lang_value = 0
var lang_focus = false
var screen_value = 0
var screen_focus = false
var opened = false
var font 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$CanvasLayer/Panel.hide()
	$CanvasLayer/Panel/VBoxContainer.hide()
	$CanvasLayer/QuitComfirmation.hide()
	$CanvasLayer/tutobtn.hide()
	
	Global.load_setting()
	#################### Language #################
	if Global.lang_eng:
		lang_value = 0
	if Global.lang_man:
		lang_value = 1
	if Global.lang_sim_man:
		lang_value = 2
	if Global.lang_jp:
		lang_value = 3
	#################### Setting #################
	#Screen
	if Global.full_screen:
		screen_value = 0
	else:
		screen_value = 1
		
	#Volume
	var volume_value = Global.volume
	var volume_music = Global.volume_music
	
	

	if Global.volume <= -10:
		volume_value = lerp(0, 10, (-80-Global.volume)/-70)
	else:
		volume_value = lerp(10, 100, (-10-Global.volume)/-20)
	if Global.volume_music <= -10:
		volume_music = lerp(0, 10, (-80-Global.volume_music)/-70)
	else:
		volume_music = lerp(10, 100, (-10-Global.volume_music)/-10)
	$CanvasLayer/Panel/VBoxContainer/Volume/TextureRect/sliderVolume.value = volume_value
	$CanvasLayer/Panel/VBoxContainer/VolumeMusic/TextureRect/sliderVolumeMusic.value = volume_music

	
var block_space_until = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Global.attack_scene:
		if Global.openMenu or $CanvasLayer/bag.open_bag:
			Global.hide_esc = true
		else:
			Global.hide_esc = false
		
	if Global.lang_eng:
		font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	if Global.lang_man or Global.lang_jp:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	if Global.lang_sim_man:
		font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
		
	if Global.hide_esc:
		$CanvasLayer/button.hide()
		$CanvasLayer/bag/bagbtn.hide()
	else:
		$CanvasLayer/button.show()
		$CanvasLayer/bag/bagbtn.show()
		
	if $CanvasLayer/Tutorial.close:
		$CanvasLayer/Tutorial.close = false
		if Global.openMenu:
			$CanvasLayer/tutobtn.grab_focus()
	
	#################### Screen #################
	if screen_value == 0:
		Global.full_screen = true
		if Global.lang_sim_man:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "全屏模式"
		if Global.lang_man:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "全屏模式"
		if Global.lang_eng:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "Full Screen"
		if Global.lang_jp:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "フルスクリーン"
	if screen_value == 1:
		Global.full_screen = false
		if Global.lang_sim_man:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "窗口模式"
		if Global.lang_man:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "窗口模式"
		if Global.lang_eng:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "Windowed"
		if Global.lang_jp:
			$CanvasLayer/Panel/VBoxContainer/Screen/Screen.text = "ウィンドウモード"
		
	if Global.lang_jp:
		$CanvasLayer/Panel/VBoxContainer/Mainmenu.text = "タイトルへ戻る"
		$CanvasLayer/Panel/VBoxContainer/Language/Language.text = "日本語"
		$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/Label.text = "終了"
		$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/Label.text = "セーブ"
		$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/Label.text = "ロード"
		$CanvasLayer/QuitComfirmation/Label.text = "ゲームを終了しますか？未保存のデータは失われます。"
		$CanvasLayer/MenuComfirm/Label.bbcode_text = "タイトルに戻りますか？[color=#9d0000]未保存のデータは失われます。[/color]"
		$CanvasLayer/ESC/Label.text = "写真を手に入れた！"
	if Global.lang_sim_man:
		$CanvasLayer/Panel/VBoxContainer/Mainmenu.text = "回到首页"
		$CanvasLayer/Panel/VBoxContainer/Language/Language.text = "简体中文"
		$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/Label.text = "退出"
		$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/Label.text = "存档"
		$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/Label.text = "读取"
		$CanvasLayer/QuitComfirmation/Label.text = "确定要退出游戏吗？没有储存的档案将会消失。"
		$CanvasLayer/MenuComfirm/Label.bbcode_text = "确定要回到首页吗？[color=#9d0000]没有储存的档案将会消失。[/color]"
		$CanvasLayer/ESC/Label.text = "獲得照片！"
	if Global.lang_man:
		$CanvasLayer/Panel/VBoxContainer/Mainmenu.text = "回到首頁"
		$CanvasLayer/Panel/VBoxContainer/Language/Language.text = "繁體中文"
		$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/Label.text = "退出"
		$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/Label.text = "儲存"
		$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/Label.text = "讀取"
		$CanvasLayer/QuitComfirmation/Label.text = "確定要退出游戲嗎？沒有儲存的檔案將會消失。"
		$CanvasLayer/MenuComfirm/Label.bbcode_text = "確定要回到首頁嗎？[color=#9d0000]沒有儲存的檔案將會消失。[/color]"
		$CanvasLayer/ESC/Label.text = "获得照片！"
	if Global.lang_eng:
		$CanvasLayer/Panel/VBoxContainer/Mainmenu.text = "Main Menu"
		$CanvasLayer/Panel/VBoxContainer/Language/Language.text = "English"
		$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/Label.text = "QuitGame"
		$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/Label.text = "SaveGame"
		$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/Label.text = "LoadGame"
		$CanvasLayer/QuitComfirmation/Label.text = "Are you sure you want to quit this game? Unsaved data will be lost."
		$CanvasLayer/MenuComfirm/Label.bbcode_text = "Are you sure you want to back to the main menu? [color=#9d0000]Unsaved data will be lost.[/color]"
		$CanvasLayer/ESC/Label.text = "Get!!"
	$CanvasLayer/Panel/VBoxContainer/Mainmenu.add_theme_font_override("font", font)
	$CanvasLayer/Panel/VBoxContainer/Language/Language.add_theme_font_override("font", font)
	$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/Label.add_theme_font_override("font", font)
	$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/Label.add_theme_font_override("font", font)
	$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/Label.add_theme_font_override("font", font)
	$CanvasLayer/QuitComfirmation/Label.add_theme_font_override("font", font)
	$CanvasLayer/Panel/VBoxContainer/Screen/Screen.add_theme_font_override("font", font)
	$CanvasLayer/ESC/Label.add_theme_font_override("font", font)
			


func _on_back_pressed():
	Global.play_button_back_sound = true
	$CanvasLayer/button.show()
	$AnimationPlayer.play("close")
	await $AnimationPlayer.animation_finished
	Global.openMenu = false
	$CanvasLayer/Panel.hide()
	$CanvasLayer/tutobtn.hide()
	$CanvasLayer/bag/bagbtn.show()
	Global.pressed_close_menu = true
	Global.save_setting()
	Global.hide_esc = false
	Global.allow_move = true



func _on_button_pressed():
	Global.allow_move = false
	Global.hide_esc = true
	$CanvasLayer/bag/bagbtn.hide()
	$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame.grab_focus()
	Global.openMenu = true
	Global.play_button_sound = true
	$CanvasLayer/Panel.show()
	$CanvasLayer/Panel/VBoxContainer.show()
	$AnimationPlayer.play("open")


func _input(_event):
	if not $CanvasLayer/Tutorial.open_tuto:
		if Input.is_action_just_pressed("ui_cancel") or Input.is_action_just_pressed("ui_openmenu"):
			if not Global.open_comfirmation:
				if Global.openMenu:
					#print("controller: back")
					_on_back_pressed()
		if Input.is_action_just_pressed("ui_openmenu"):
			if not Global.hide_esc:
				#print("controller: pressed!")
				_on_button_pressed()

			
	if lang_focus and Input.is_action_just_pressed("ui_right"):
		_on_right_pressed()
	if lang_focus and Input.is_action_just_pressed("ui_left"):
		_on_left_pressed()
		
	if screen_focus and Input.is_action_just_pressed("ui_right"):
		_on_right_s_pressed()
	if screen_focus and Input.is_action_just_pressed("ui_left"):
		_on_left_s_pressed()


func _on_load_game_pressed():
	Global.savegame = false
	Global.loadgame = true
	Global.play_button_sound = true
	GlobalCanvasLayer.change_scene("res://MainMenu/saveload.tscn","faded")



func _on_save_game_pressed():
	Global.savegame = true
	Global.loadgame = false
	Global.play_button_sound = true
	GlobalCanvasLayer.change_scene("res://MainMenu/saveload.tscn","faded")


############################ In Setting #############################

func _on_right_pressed():
	Global.play_button_sound = true
	if lang_value == 3:
		lang_value -= 3
	else:
		lang_value += 1
	if lang_value == 0:
		Global.lang_man = false
		Global.lang_eng = true
		Global.lang_sim_man = false
		Global.lang_jp = false
	if lang_value == 1:
		Global.lang_man = true
		Global.lang_eng = false
		Global.lang_sim_man = false
		Global.lang_jp = false
	if lang_value == 2:
		Global.lang_man = false
		Global.lang_eng = false
		Global.lang_sim_man = true
		Global.lang_jp = false
	if lang_value == 3:
		Global.lang_man = false
		Global.lang_eng = false
		Global.lang_sim_man = false
		Global.lang_jp = true
	Global.change_language = true
	Global.save_setting()
		
func _on_left_pressed():
	Global.play_button_sound = true
	if lang_value == 0:
		lang_value += 3
	else:
		lang_value -= 1
	if lang_value == 0:
		Global.lang_man = false
		Global.lang_eng = true
		Global.lang_sim_man = false
		Global.lang_jp = false
	if lang_value == 1:
		Global.lang_man = true
		Global.lang_eng = false
		Global.lang_sim_man = false
		Global.lang_jp = false
	if lang_value == 2:
		Global.lang_man = false
		Global.lang_eng = false
		Global.lang_sim_man = true
		Global.lang_jp = false
	if lang_value == 3:
		Global.lang_man = false
		Global.lang_eng = false
		Global.lang_sim_man = false
		Global.lang_jp = true
	Global.change_language = true
	Global.save_setting()
	
	
############################ In Screen #############################

func _on_left_s_pressed() -> void:
	Global.play_button_sound = true
	if screen_value == 1:
		screen_value -= 1
		Global.full_screen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		screen_value += 1
		Global.full_screen = false
		var icon = preload("res://Images/UI/icon/icon.png")
		DisplayServer.set_icon(icon)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	Global.save_setting()

func _on_right_s_pressed() -> void:
	Global.play_button_sound = true
	if screen_value == 0:
		screen_value += 1	
		Global.full_screen = false
		var icon = preload("res://Images/UI/icon/icon.png")
		DisplayServer.set_icon(icon)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		screen_value -= 1
		Global.full_screen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	Global.save_setting()
		
		
		
func _on_slider_volume_value_changed(value):
	if value <= 10:
		Global.volume = lerp(-80, -10, value / 10)
	else:
		Global.volume = lerp(-10, 10, (value - 10) / 90)
	Global.save_volume("volume",Global.volume)
	#print(Global.volume)


func _on_slider_volume_music_value_changed(value: float) -> void:
	if value <= 10:
		Global.volume_music = lerp(-80, -10, value / 10)
	else:
		Global.volume_music = lerp(-10, 0, (value - 10) / 90)
	Global.save_volume("volume_music",Global.volume_music)
	

############################ Quit #############################

func _on_quitgame_pressed():
	$AnimationPlayer.play("quit_comfirmation")
	$CanvasLayer/QuitComfirmation/No.grab_focus()
	$CanvasLayer/QuitComfirmation.show()
	Global.open_comfirmation = true

func _on_yes_pressed():
	Global.play_button_sound = true
	get_tree().quit()

func _on_no_pressed():
	$AnimationPlayer.play("cancel_comfirmation")
	await $AnimationPlayer.animation_finished
	if Global.openMenu:
		$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame.grab_focus()
	$CanvasLayer/QuitComfirmation.hide()
	Global.open_comfirmation = false
	if not Global.openMenu:
		$AnimationPlayer.play("RESET")



############################ Menu #############################

func _on_mainmenu_pressed():
	Global.open_comfirmation = true
	#################### Setting #################
	Global.load_setting()
	
	var volume_value = Global.volume
	var volume_music = Global.volume_music
	if Global.volume <= -10:
		volume_value = lerp(0, 10, (-80-Global.volume)/-70)
	else:
		volume_value = lerp(10, 100, (-10-Global.volume)/-10)
	if Global.volume_music <= -10:
		volume_music = lerp(0, 10, (-80-Global.volume_music)/-70)
	else:
		volume_music = lerp(10, 100, (-10-Global.volume_music)/-10)
	$CanvasLayer/Panel/VBoxContainer/Volume/TextureRect/sliderVolume.value = volume_value
	$CanvasLayer/Panel/VBoxContainer/VolumeMusic/TextureRect/sliderVolumeMusic.value = volume_music
	
	#################### Open menu #################
	$AnimationPlayer.play("menu_open")
	$CanvasLayer/MenuComfirm.show()
	$CanvasLayer/MenuComfirm/menu_no.grab_focus()

func _on_menu_yes_pressed():
	Global.play_button_sound = true
	Global.allow_move = true
	$AnimationPlayer.play("cofirm_back_to_main_menu")
	await $AnimationPlayer.animation_finished
	GlobalCanvasLayer.change_scene("res://MainMenu/main_menu.tscn","faded")

func _on_menu_no_pressed():
	$AnimationPlayer.play("menu_close")
	await $AnimationPlayer.animation_finished
	if Global.openMenu:
		$CanvasLayer/Panel/VBoxContainer/Mainmenu.grab_focus()
	$CanvasLayer/MenuComfirm.hide()
	Global.open_comfirmation = false
	if not Global.openMenu:
		$AnimationPlayer.play("RESET")

func _on_tutobtn_pressed():
	Global.allow_move = false
	Global.open_comfirmation = true
	$CanvasLayer/Tutorial/AnimationPlayer.play("default")
	$CanvasLayer/Tutorial._ready()
	$CanvasLayer/Tutorial.show()
	$CanvasLayer/Tutorial.open_tuto = true
	$CanvasLayer/Tutorial/Right.grab_focus()

func _on_menu_yes_mouse_entered() -> void:
	Global.play_pick_chat_sound = true



######################### Focus ##########################
#volume music
func _on_slider_volume_music_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/VolumeMusic/TextureRect/focus.show()
func _on_slider_volume_music_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/VolumeMusic/TextureRect/focus.hide()

#volume
func _on_slider_volume_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/Volume/TextureRect/focus.show()
func _on_slider_volume_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/Volume/TextureRect/focus.hide()

#menu
func _on_mainmenu_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/Mainmenu/focus.show()
func _on_mainmenu_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/Mainmenu/focus.hide()

#language
func _on_language_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/Language/Language/focus.show()
	lang_focus = true
func _on_language_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/Language/Language/focus.hide()
	lang_focus = false


func _on_load_game_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/focus.show()
func _on_load_game_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/Buttons/LoadGame/focus.hide()


func _on_save_game_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/focus.show()
func _on_save_game_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/Buttons/SaveGame/focus.hide()


func _on_quitgame_focus_entered() -> void:
	$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/focus.show()
func _on_quitgame_focus_exited() -> void:
	$CanvasLayer/Panel/VBoxContainer/Buttons/Quitgame/focus.hide()

	
func _on_screen_focus_entered() -> void:
	screen_focus = true
	$CanvasLayer/Panel/VBoxContainer/Screen/focus.show()
func _on_screen_focus_exited() -> void:
	screen_focus = false
	$CanvasLayer/Panel/VBoxContainer/Screen/focus.hide()
