extends Control

var show_btn := false
	
var check := [
	{"ending": "ending1",  "state": func(): return Global.ending1},
	{"ending": "ending2",  "state": func(): return Global.ending2},
	{"ending": "ending3",  "state": func(): return Global.ending3},
	{"ending": "ending4",  "state": func(): return Global.ending4},
	{"ending": "ending5",  "state": func(): return Global.ending5},
	{"ending": "ending6",  "state": func(): return Global.ending6},
	{"ending": "ending7",  "state": func(): return Global.ending7},
	{"ending": "ending8",  "state": func(): return Global.ending8},
	{"ending": "ending9",  "state": func(): return Global.ending9},
	{"ending": "ending10", "state": func(): return Global.ending10},
	{"ending": "ending11", "state": func(): return Global.ending11},
	{"ending": "ending12", "state": func(): return Global.ending12},
	{"ending": "ending13", "state": func(): return Global.ending13},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Dialogue.dialogue_ready = false
	$Button.hide()
	Global.hide_get_task = true
	Global.from_menu = false
	Global.counter = 0
	Global.counterR = 0
	Global.startChat = false
	Global.place = "Ending"
	Global.character_name = "ending1"
	$Banner.hide()
	$AnimationPlayer.play("default")
	
	if Global.play_ending_one:
		Global.place = "Ending"
		Global.character_name = "ending1"
		$Background.play("default")
		$AnimatedSprite2D.play("default")
		$AnimationPlayer2.play("RESET")
	
	if Global.demon_love or Global.play_ending_two:
		Global.place = "Ending"
		Global.character_name = "ending2"
		$Background.play("ending2")
		$AnimationPlayer2.play("heart")
		
	if Global.demon_marry or Global.play_ending_three:
		Global.place = "Ending"
		Global.character_name = "ending3"
		$Background.play("default")
		$AnimationPlayer2.play("RESET")
		
	if Global.marry_queen or Global.play_ending_four:
		Global.place = "Ending"
		Global.character_name = "ending4"
		$Background.play("ending4")
		$AnimationPlayer2.play("RESET")
	
	if Global.get_out_teacher or Global.play_ending_five:
		Global.place = "Ending"
		Global.character_name = "ending5"
		$Background.play("ending5")
		$AnimationPlayer2.play("RESET")
	
	if Global.get_out_otaku or Global.play_ending_six:
		Global.place = "Ending"
		Global.character_name = "ending6"
		$Background.play("default")
		$AnimationPlayer2.play("RESET")
		
	if Global.food_ending or Global.play_ending_seven:
		Global.place = "Ending"
		Global.character_name = "ending7"
		$Background.play("ending4")
		$AnimationPlayer2.play("RESET")
	
	if Global.police_ending or Global.play_ending_eight:
		Global.place = "Ending"
		Global.character_name = "ending8"
		$Background.play("ending8")
		$AnimationPlayer2.play("RESET")
		
	if Global.princess_angry or Global.play_ending_nine:
		Global.place = "Ending"
		Global.character_name = "ending9"
		$Background.play("ending9")
		$AnimationPlayer2.play("RESET")
		
	if Global.demon_green or Global.play_ending_ten:
		Global.place = "Ending"
		Global.character_name = "ending10"
		$Background.play("ending2")
		$AnimationPlayer2.play("RESET")
	
	if Global.run_otaku or Global.play_ending_eleven:
		Global.place = "Ending"
		Global.character_name = "ending11"
		$Background.play("ending2")
		$AnimationPlayer2.play("RESET")
	
	if Global.demon_npc_died or Global.play_ending_twelve:
		Global.place = "Ending"
		Global.character_name = "ending12"
		$Background.play("ending12")
		$AnimationPlayer2.play("news")
		
	if Global.eat_puffer_donut or Global.play_ending_thirteen:
		Global.place = "Ending"
		Global.character_name = "ending13"
		
		var font
		if Global.lang_eng:
			font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
		if Global.lang_man or Global.lang_jp or Global.lang_sim_man:
			font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
		
		if Global.lang_eng:
			$Banner/Label.text = "If you are struggling or having thoughts of suicide, please call the suicide prevention hotline:012-XXXXXXX."
		if Global.lang_jp:
			$Banner/Label.text = "つらい気持ちを抱えている方は、一人で抱え込まず、自殺予防ホットライン（012-XXXXXXX）までお電話ください。"
		if Global.lang_man:
			$Banner/Label.text = "如果您對生命的意義有所質疑，請撥打預防自殺熱綫電話：012-XXXXXXX，珍愛生命，由您做起。"
		if Global.lang_sim_man:
			$Banner/Label.text = "如果您对生命的意义有所质疑，请拨打预防自杀热线电话：012-XXXXXXX，珍爱生命，由您做起。"
		$Banner/Label.add_theme_font_override("font",font)
		$Background.play("ending12")
		$AnimationPlayer2.play("news")
		
	_update_button()
	var dialogue_node = get_node("Dialogue")
	if dialogue_node:
		dialogue_node.PressFKey()
		
		
func _update_button():
	for item in check:
		if item["ending"] == Global.character_name and item["state"].call():
			show_btn = true
			$Button.show()
		


func _on_button_pressed():
	if not Global.change_scene:
		Global.play_button_back_sound = true
		GlobalCanvasLayer.change_scene("res://MainMenu/ending.tscn","dissolve")



func _input(_event):
	if show_btn:
		if Input.is_action_just_pressed("ui_cancel"):
			_on_button_pressed()
