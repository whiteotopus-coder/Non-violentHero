extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	volume_db = Global.volume
	if Global.play_door_sound:
		$".".stream = load("res://Sound/door_sound.WAV")
		$".".play()  # 播放
		Global.play_door_sound = false

	if Global.play_bed_sound:
		$".".stream = load("res://Sound/bed_sound.MP3") 
		$".".play()  # 播放
		Global.play_bed_sound = false
	
	if Global.play_button_sound:
		$AudioStreamPlayer.stream = load("res://Sound/button.WAV")  
		$AudioStreamPlayer.play()  # 播放
		Global.play_button_sound = false
	
	if Global.play_button_back_sound:
		$".".stream = load("res://Sound/button_back.WAV")
		$".".play()  # 播放
		Global.play_button_back_sound = false
		 
	if Global.play_true_sound:
		$".".stream = load("res://Sound/correct.wav") 
		$".".play()  # 播放
		Global.play_true_sound = false
		
	if Global.play_wrong_sound:
		$".".stream = load("res://Sound/wrong.wav") 
		$".".play()  # 播放
		Global.play_wrong_sound = false
		
	if Global.play_bing_sound:
		$AudioStreamPlayer.stream = load("res://Sound/bing.MP3") 
		$AudioStreamPlayer.play()  # 播放
		Global.play_bing_sound = false
	
	if Global.play_victory_sound:
		$".".stream = load("res://Sound/victory.wav") 
		$".".play()  # 播放
		Global.play_victory_sound = false
		
	if Global.play_lose_sound:
		$".".stream = load("res://Sound/lose.wav") 
		$".".play()  # 播放
		Global.play_lose_sound = false
		
	if Global.play_punch_sound:
		$".".stream = load("res://Sound/punch.MP3") 
		$".".play()  # 播放
		Global.play_punch_sound = false

	if Global.play_pick_chat_sound:
		$AudioStreamPlayer.stream = load("res://Sound/choose_chat.WAV") 
		$AudioStreamPlayer.play()  # 播放
		Global.play_pick_chat_sound = false
