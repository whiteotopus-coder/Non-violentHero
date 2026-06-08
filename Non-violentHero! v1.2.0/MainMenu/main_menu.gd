extends Control

var lang_value = 0
var screen_value = 0
var cbtn_focus = false
var open_scene = false
var lang_focus = false
var screen_focus = false
var font

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load_ending()
	Global.load_setting()
	Global.reset_var()
	Global.from_menu = true
	Global.openMenu = false
	if not Global.from_ending:
		Global.play_menu_song = true
	$QuitComfirmation.hide()
	$Panel/btn_center.grab_focus()

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
	$Setting/VBoxContainer/Volume/TextureRect/sliderVolume.value = volume_value
	$Setting/VBoxContainer/VolumeMusic/TextureRect/sliderVolume.value = volume_music
	
	#################### Save Ending #################
	Global.save_ending()
	#################### Language #################
	if Global.lang_eng:
		lang_value = 0
		font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	if Global.lang_man:
		lang_value = 1
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	if Global.lang_sim_man:
		lang_value = 2
		font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
	if Global.lang_jp:
		lang_value = 3
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
	


func _process(_delta):
	
	if Global.lang_eng:
		font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
	if Global.lang_man or Global.lang_jp or Global.lang_sim_man:
		font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		
	#################### Button at the bottom #################
	if Global.button_value == 0:
		
		$Panel/btn_center.texture_normal = load("res://Images/menu_ui/setting_button.png")
		$Panel/btn_center.texture_hover = load("res://Images/menu_ui/setting_hover.png")
		$Panel/btn_center.texture_pressed = load("res://Images/menu_ui/setting_clicked.png")
		
		if Global.lang_sim_man:
			$Panel/Label.text = "设定"
		if Global.lang_man:
			$Panel/Label.text = "設定"
		if Global.lang_eng:
			$Panel/Label.text = "Setting"
		if Global.lang_jp:
			$Panel/Label.text = "設定"
		$Panel/Label.add_theme_font_override("font", font)
		
	if Global.button_value == 1:
		
		$Panel/btn_center.texture_normal = load("res://Images/menu_ui/load_button.png")
		$Panel/btn_center.texture_hover = load("res://Images/menu_ui/load_button_hover.png")
		$Panel/btn_center.texture_pressed = load("res://Images/menu_ui/load_button_clicked.png")

		if Global.lang_sim_man:
			$Panel/Label.text = "读档"
		if Global.lang_man:
			$Panel/Label.text = "讀檔"
		if Global.lang_eng:
			$Panel/Label.text = "Load File"
		if Global.lang_jp:
			$Panel/Label.text = "ロード"
		$Panel/Label.add_theme_font_override("font", font)
		
	if Global.button_value == 2:
		
		$Panel/btn_center.texture_normal = load("res://Images/menu_ui/credit_button.png")
		$Panel/btn_center.texture_hover = load("res://Images/menu_ui/credit_button_hover.png")
		$Panel/btn_center.texture_pressed = load("res://Images/menu_ui/credit_button_clicked.png")

		if Global.lang_sim_man:
			$Panel/Label.text = "制作"
		if Global.lang_man:
			$Panel/Label.text = "製作"
		if Global.lang_eng:
			$Panel/Label.text = "Credit"
		if Global.lang_jp:
			$Panel/Label.text = "クレジット"
		$Panel/Label.add_theme_font_override("font", font)
		
	if Global.button_value == 3:
		
		$Panel/btn_center.texture_normal = load("res://Images/menu_ui/ending_btn.png")
		$Panel/btn_center.texture_hover = load("res://Images/menu_ui/ending_btn_hover.png")
		$Panel/btn_center.texture_pressed = load("res://Images/menu_ui/ending_btn_clicked.png")

		if Global.lang_sim_man:
			$Panel/Label.text = "结局"
		if Global.lang_man:
			$Panel/Label.text = "結局"
		if Global.lang_eng:
			$Panel/Label.text = "Ending"
		if Global.lang_jp:
			$Panel/Label.text = "エンディング"
		$Panel/Label.add_theme_font_override("font", font)
		
	if Global.button_value == 4:
		
		$Panel/btn_center.texture_normal = load("res://Images/menu_ui/exit_btn.png")
		$Panel/btn_center.texture_hover = load("res://Images/menu_ui/exit_btn_hover.png")
		$Panel/btn_center.texture_pressed = load("res://Images/menu_ui/exit_btn_clicked.png")

		if Global.lang_sim_man:
			$Panel/Label.text = "退出"
		if Global.lang_man:
			$Panel/Label.text = "退出"
		if Global.lang_eng:
			$Panel/Label.text = "Quit"
		if Global.lang_jp:
			$Panel/Label.text = "終了"
		$Panel/Label.add_theme_font_override("font", font)

	#################### Screen #################
	if screen_value == 0:
		if Global.lang_sim_man:
			$Setting/VBoxContainer/Screen/Screen.text = "全屏模式"
		if Global.lang_man:
			$Setting/VBoxContainer/Screen/Screen.text = "全屏模式"
		if Global.lang_eng:
			$Setting/VBoxContainer/Screen/Screen.text = "Full Screen"
		if Global.lang_jp:
			$Setting/VBoxContainer/Screen/Screen.text = "フルスクリーン"
	if screen_value == 1:
		if Global.lang_sim_man:
			$Setting/VBoxContainer/Screen/Screen.text = "窗口模式"
		if Global.lang_man:
			$Setting/VBoxContainer/Screen/Screen.text = "窗口模式"
		if Global.lang_eng:
			$Setting/VBoxContainer/Screen/Screen.text = "Windowed"
		if Global.lang_jp:
			$Setting/VBoxContainer/Screen/Screen.text = "ウィンドウモード"
	
	#################### Quit Information #################

	if Global.lang_jp:
		$Credit/VBoxContainer.add_theme_constant_override("separation", 3)
		$Panel/GameTitle.stretch_mode = 3
		$Panel/GameTitle.texture = load("res://Images/name/mandarin.png")
		$Setting/VBoxContainer/Language/Language.text = "日本語"
		$Panel/Start/start.text = "スタート"
		$QuitComfirmation/Label.text = "ゲームを終了しますか？"
		$Credit/VBoxContainer/GameDesign.text = "ゲームデザイン"
		$Credit/VBoxContainer/Name1.text = "白爪"
		$Credit/VBoxContainer/Programming.text = "プログラム・グラフィック・アニメーション"
		$Credit/VBoxContainer/Name2.text = "白爪"
		$Credit/VBoxContainer/Music.text = "音楽"
		$Credit/VBoxContainer/Font.text = "フォント"
		$Credit/VBoxContainer/GoogleFont.text = "Cubic 11"
		$Credit/VBoxContainer/SoundEffects.text = "一部の効果音はPixabayより使用"
	if Global.lang_sim_man:
		$Credit/VBoxContainer.add_theme_constant_override("separation", 5)
		$Panel/GameTitle.stretch_mode = 3
		$Panel/GameTitle.texture = load("res://Images/name/mandarin.png")
		$Setting/VBoxContainer/Language/Language.text = "简体中文"
		$Panel/Start/start.text = "开始"
		$QuitComfirmation/Label.text = "确定要退出游戏吗？"
		$Credit/VBoxContainer/GameDesign.text = "游戏设计"
		$Credit/VBoxContainer/Name1.text = "白爪"
		$Credit/VBoxContainer/Programming.text = "程序 & 美术 & 动画"
		$Credit/VBoxContainer/Name2.text = "白爪"
		$Credit/VBoxContainer/Music.text = "音乐"
		$Credit/VBoxContainer/Font.text = "字体"
		$Credit/VBoxContainer/GoogleFont.text = "Fusion Pixel Font"
		$Credit/VBoxContainer/SoundEffects.text = "部分音效来自Pixabay"
	if Global.lang_man:
		$Credit/VBoxContainer.add_theme_constant_override("separation", 5)
		$Panel/GameTitle.stretch_mode = 3
		$Panel/GameTitle.texture = load("res://Images/name/tradi_man.png")
		$Setting/VBoxContainer/Language/Language.text = "繁體中文"
		$Panel/Start/start.text = "開始"
		$QuitComfirmation/Label.text = "確定要退出游戲嗎？"
		$Credit/VBoxContainer/GameDesign.text = "游戲設計"
		$Credit/VBoxContainer/Name1.text = "白爪"
		$Credit/VBoxContainer/Programming.text = "程序 & 美術 & 動畫"
		$Credit/VBoxContainer/Name2.text = "白爪"
		$Credit/VBoxContainer/Music.text = "音樂"
		$Credit/VBoxContainer/Font.text = "字體"
		$Credit/VBoxContainer/GoogleFont.text = "Cubic 11"
		$Credit/VBoxContainer/SoundEffects.text = "部分音效來自Pixabay"
	if Global.lang_eng:
		$Credit/VBoxContainer.add_theme_constant_override("separation", 4)
		$Panel/GameTitle.stretch_mode = 6
		$Panel/GameTitle.texture = load("res://Images/name/english.png")
		$Setting/VBoxContainer/Language/Language.text = "English"
		$Panel/Start/start.text = "Start"
		$QuitComfirmation/Label.text = "Are you sure you want to quit this game?"
		$Credit/VBoxContainer/GameDesign.text = "Game Design"
		$Credit/VBoxContainer/Name1.text = "Wito"
		$Credit/VBoxContainer/Programming.text = "Programming & Art & Animation"
		$Credit/VBoxContainer/Name2.text = "Wito"
		$Credit/VBoxContainer/Music.text = "Music"
		$Credit/VBoxContainer/Font.text = "Font"
		$Credit/VBoxContainer/GoogleFont.text = "Pixelify Sans"
		$Credit/VBoxContainer/SoundEffects.text = "Sound effects from Pixabay"
	$Credit/VBoxContainer/MuscicName1.text = "happy musical tune by RibhavAgrawal from Pixabay"
	$Credit/VBoxContainer/MuscicName2.text = "Invasion March-Star Wars Style Cinematic Music by Luis_Humanoide from Pixabay"
	$Credit/VBoxContainer/MuscicName3.text = "Music composed by Bert Cole"
	$Credit/VBoxContainer/MuscicName4.text = "bitbybitsound.com"
	$Panel/Start/start.add_theme_font_override("font", font)
	$QuitComfirmation/Label.add_theme_font_override("font", font)
	$Credit/VBoxContainer/GameDesign.add_theme_font_override("font", font)
	$Credit/VBoxContainer/Name1.add_theme_font_override("font", font)
	$Credit/VBoxContainer/Programming.add_theme_font_override("font", font)
	$Credit/VBoxContainer/Name2.add_theme_font_override("font", font)
	$Credit/VBoxContainer/Music.add_theme_font_override("font", font)
	$Credit/VBoxContainer/MuscicName1.add_theme_font_override("font", font)
	$Credit/VBoxContainer/MuscicName2.add_theme_font_override("font", font)
	$Credit/VBoxContainer/MuscicName3.add_theme_font_override("font", font)
	$Credit/VBoxContainer/MuscicName4.add_theme_font_override("font", font)
	$Credit/VBoxContainer/Font.add_theme_font_override("font", font)
	$Credit/VBoxContainer/GoogleFont.add_theme_font_override("font", font)
	$Credit/VBoxContainer/MuscicName4.add_theme_font_override("font", font)
	$Setting/VBoxContainer/Screen/Screen.add_theme_font_override("font", font)
	$Setting/VBoxContainer/Language/Language.add_theme_font_override("font", font)
	$Credit/VBoxContainer/SoundEffects.add_theme_font_override("font", font)
	
############################## Start Button ######################

func _on_start_pressed():
	if not Global.change_scene:
		Global._CreateNewInfoFile()
		Global.from_ending = false
		Global.from_menu = false
		Global.play_button_sound = true
		GlobalCanvasLayer.change_scene("res://MainMenu/scene.tscn","dissolve")


func _on_start_mouse_entered() -> void:
	$Panel/Start.position = Vector2(64, 185)
	
func _on_start_mouse_exited() -> void:
	$Panel/Start.position = Vector2(64, 184)


################################################################

func _on_back_pressed():
	$Setting.hide()
	$Credit.hide()
	$AnimationPlayer.play("default_main")
	Global.play_button_back_sound = true
	$Panel/btn_center.grab_focus()


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
		
		
	
func _on_h_slider_value_changed(value):
	
	if value <= 10:
		Global.volume = lerp(-80.0, -10.0, value / 10.0)
	else:
		Global.volume = lerp(-10.0, 10.0, (value - 10.0) / 90.0)
	Global.save_volume("volume",Global.volume)



func _on_slider_volume_value_changed(value: float) -> void:
	
	if value <= 10:
		Global.volume_music = lerp(-80.0, -10.0, value / 10.0)
	else:
		Global.volume_music = lerp(-10.0, 0.0, (value - 10.0) / 90.0)
	Global.save_volume("volume_music",Global.volume_music)
	
	
############################ Main Button #############################

func _on_right_btn_pressed():
	Global.play_button_sound = true
	if Global.button_value == 4:
		Global.button_value -= 4
	else:
		Global.button_value += 1
		
	

func _on_left_btn_pressed():
	Global.play_button_sound = true
	if Global.button_value == 0:
		Global.button_value += 4
	else:
		Global.button_value -= 1
	


func _on_btn_center_pressed():
	if not Global.change_scene:
		Global.play_button_sound = true
		if Global.button_value == 0:
			$Setting.show()
			$AnimationPlayer.play("setting")
			$Setting/VBoxContainer/Language/Language.grab_focus()
			open_scene = true
		if Global.button_value == 1:
			Global.loadgame = true
			GlobalCanvasLayer.change_scene("res://MainMenu/saveload.tscn","dissolve")
		if Global.button_value == 2:
			$Credit.show()
			$AnimationPlayer.play("credit")
			$Credit/Back.grab_focus()
			$Credit/Back.release_focus()
			open_scene = true
		if Global.button_value == 3:
			GlobalCanvasLayer.change_scene("res://MainMenu/ending.tscn","dissolve")
		if Global.button_value == 4:
			$AnimationPlayer.play("comfirmation")
			$QuitComfirmation.show()
			$QuitComfirmation/Yes.grab_focus()


############################ Quit #############################

func _on_yes_pressed():
	if not Global.change_scene:
		Global.play_button_sound = true
		get_tree().quit()



func _on_no_pressed():
	$AnimationPlayer.play("cancel_comfirmation")
	await $AnimationPlayer.animation_finished
	$QuitComfirmation.hide()
	$Panel/btn_center.grab_focus()



func _on_left_mouse_entered() -> void:
	Global.play_pick_chat_sound = true


########################### Focus Button ############################

# For center
func _on_btn_center_focus_entered() -> void:
	$Panel/focus_btn_center.show()
	cbtn_focus = true


func _on_btn_center_focus_exited() -> void:
	$Panel/focus_btn_center.hide()
	cbtn_focus = false


# For music volume slider
func _on_slider_volume_music_focus_entered() -> void:
	$Setting/VBoxContainer/VolumeMusic/TextureRect/focus.show()
func _on_slider_volume_music_focus_exited() -> void:
	$Setting/VBoxContainer/VolumeMusic/TextureRect/focus.hide()
# For volume slider
func _on_slider_volume_focus_entered() -> void:
	$Setting/VBoxContainer/Volume/TextureRect/focus.show()
func _on_slider_volume_focus_exited() -> void:
	$Setting/VBoxContainer/Volume/TextureRect/focus.hide()


func _input(event):
	if Input.is_action_just_pressed("ui_cancel") and open_scene:
		_on_back_pressed()
		open_scene = false
	
	if cbtn_focus and Input.is_action_just_pressed("ui_right"):
		_on_right_btn_pressed()
	if cbtn_focus and Input.is_action_just_pressed("ui_left"):
		_on_left_btn_pressed()
	
	if lang_focus and Input.is_action_just_pressed("ui_right"):
		_on_right_pressed()
	if lang_focus and Input.is_action_just_pressed("ui_left"):
		_on_left_pressed()
	
	if screen_focus and Input.is_action_just_pressed("ui_right"):
		_on_right_s_pressed()
	if screen_focus and Input.is_action_just_pressed("ui_left"):
		_on_left_s_pressed()



func _on_language_focus_entered() -> void:
	lang_focus = true
	$Setting/VBoxContainer/Language/focus.show()
func _on_language_focus_exited() -> void:
	lang_focus = false
	$Setting/VBoxContainer/Language/focus.hide()
	
	
func _on_screen_focus_entered() -> void:
	screen_focus = true
	$Setting/VBoxContainer/Screen/focus.show()
func _on_screen_focus_exited() -> void:
	screen_focus = false
	$Setting/VBoxContainer/Screen/focus.hide()


func _on_ig_pressed() -> void:
	OS.shell_open("https://www.instagram.com/witooo.0/?igsh=MTJsMjRla3VlcTJyag%3D%3D&utm_source=qr")

func _on_x_pressed() -> void:
	OS.shell_open("https://x.com/witoo_0")

func _on_youtube_pressed() -> void:
	OS.shell_open("https://www.youtube.com/@witooo.0")
