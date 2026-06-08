extends Panel

var typingTween : Tween

var isTyping = false
var doneTyping = false

func _ready():
	
	Global.place = "attack"
	Global.item = Global.current_character
	PressFKey()
			
	var typing_wait_timer = Timer.new()
	typing_wait_timer.wait_time = 0.3 
	typing_wait_timer.one_shot = true
	typing_wait_timer.name = "TypingWaitTimer" 
	add_child(typing_wait_timer)
	
	# 连接计时器的 timeout 信号
	typing_wait_timer.connect("timeout", Callable(self, "_on_typing_wait_done"))


	
func _reset_typing():
	if typingTween:
		typingTween.kill()
		typingTween = null
	$Text.text = ""
	isTyping = false
	doneTyping = false
	Global.counter += 1



func _PrintDialogueText(read_file):
	_reset_typing()
	if read_file != null:
		if Global.counter >= 0 and Global.counter < read_file.size():
			var JSONarray = read_file[Global.counter]				
			if Global.lang_jp:
				var the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
				$Text.add_theme_font_override("font", the_font)
				if "jp_dialogue" in JSONarray:
					# Print dialogue and play animations
					_TypingEffect(JSONarray["jp_dialogue"],_TypingDialogue)			
			if Global.lang_man:
				var the_font = preload("res://Dialogue/DialogueTextFile/Cubic_11.ttf")
				$Text.add_theme_font_override("font", the_font)
				if "man_dialogue" in JSONarray:
					# Print dialogue and play animations
					_TypingEffect(JSONarray["man_dialogue"],_TypingDialogue)		
			if Global.lang_sim_man:
				var the_font = preload("res://Dialogue/DialogueTextFile/fusion-pixel-12px-proportional-zh_hans.otf")
				$Text.add_theme_font_override("font", the_font)
				if "man_sim_dialogue" in JSONarray:
					# Print dialogue and play animations
					_TypingEffect(JSONarray["man_sim_dialogue"],_TypingDialogue)
			if Global.lang_eng:
				var the_font = preload("res://Dialogue/DialogueTextFile/PixelifySans-VariableFont_wght.ttf")
				$Text.add_theme_font_override("font", the_font)
				if "eng_dialogue" in JSONarray:
					# Print dialogue and play animations
					_TypingEffect(JSONarray["eng_dialogue"],_TypingDialogue)
				
			
			
func _TypingDialogue(character):
	$Text.text += character



func _TypingEffect(typing, x):
	isTyping = true
	if get_tree():
		typingTween = get_tree().create_tween()
		$Text.text = ""
		for character in typing:
			var delay = 0.05 
			typingTween.tween_callback(x.bind(character)).set_delay(delay)
		typingTween.tween_callback(Callable(self, "_on_typing_done"))



func _on_typing_done():
	isTyping = false
	doneTyping = true
	# for timer
	$TypingWaitTimer.start()
	

									
func PressFKey():
	if not Global.win_btn_game and not Global.lose_btn_game:
		var read_file = Global._ReadInteractFile()
		if read_file != null:
			var JSONarray = read_file[Global.counter]
			if Global.counter >= 0 and Global.counter < read_file.size():
				_PrintDialogueText(read_file)
				#$AnimationPlayer.play("attack")

		
		
func _PrintAllDialogueText(x):
	if typingTween:
		typingTween.kill() 
	$Text.text = x
	_on_typing_done()
