extends AudioStreamPlayer


func _process(_delta):
	volume_db = Global.volume_music
	
	if Global.song_playing != "" and Global.file_load_for_song:
		print(Global.song_playing)
		$".".stream = load(str(Global.song_playing))
		$".".play()  # 播放
		Global.file_load_for_song = false
	if Global.song_playing == "" and Global.file_load_for_song:
		$".".stop()  # 播放
		Global.file_load_for_song = false
		
	if Global.play_menu_song:
		if Global.song_playing != "res://BackgroundMusic/song.wav":
			$".".stream = load("res://BackgroundMusic/song.wav")
			Global.song_playing = "res://BackgroundMusic/song.wav"
			$".".play()  # 播放
		Global.play_menu_song = false
	
	if Global.play_battle_song:
		if Global.song_playing != "res://BackgroundMusic/BattlewithBeasts.ogg":
			$".".stream = load("res://BackgroundMusic/BattlewithBeasts.ogg")
			Global.song_playing = "res://BackgroundMusic/BattlewithBeasts.ogg"
			$".".play()  # 播放
		Global.play_battle_song = false
	
	if Global.play_comedy_song:
		if Global.song_playing != "res://BackgroundMusic/GhostAlley.ogg":
			$".".stream = load("res://BackgroundMusic/GhostAlley.ogg")
			Global.song_playing = "res://BackgroundMusic/GhostAlley.ogg"
			$".".play()  # 播放
		Global.play_comedy_song = false
	
	if Global.play_happy_song:
		if Global.song_playing != "res://BackgroundMusic/happy.mp3":
			$".".stream = load("res://BackgroundMusic/happy.mp3")
			Global.song_playing = "res://BackgroundMusic/happy.mp3"
			$".".play()  # 播放
		Global.play_happy_song = false
		
	if Global.play_war_song:
		if Global.song_playing != "res://BackgroundMusic/war.mp3":
			$".".stream = load("res://BackgroundMusic/war.mp3")
			Global.song_playing = "res://BackgroundMusic/war.mp3"
			$".".play()  # 播放
		Global.play_war_song = false
	
	if Global.play_town_song:
		if Global.song_playing != "res://BackgroundMusic/OnTheMove.ogg":
			$".".stream = load("res://BackgroundMusic/OnTheMove.ogg")
			Global.song_playing = "res://BackgroundMusic/OnTheMove.ogg"
			$".".play()  # 播放
		Global.play_town_song = false
		
	if Global.play_indoor_song:
		if Global.song_playing != "res://BackgroundMusic/MerchCity.ogg":
			$".".stream = load("res://BackgroundMusic/MerchCity.ogg")
			Global.song_playing = "res://BackgroundMusic/MerchCity.ogg"
			$".".play()  # 播放
		Global.play_indoor_song = false
		
	if Global.play_school_song:
		if Global.song_playing != "res://BackgroundMusic/BustlingStreets.ogg":
			$".".stream = load("res://BackgroundMusic/BustlingStreets.ogg")
			Global.song_playing = "res://BackgroundMusic/BustlingStreets.ogg"
			$".".play()  # 播放
		Global.play_school_song = false
		
	if Global.play_cave_song:
		if Global.song_playing != "res://BackgroundMusic/SmoothAsGlass.ogg":
			$".".stream = load("res://BackgroundMusic/SmoothAsGlass.ogg")
			Global.song_playing = "res://BackgroundMusic/SmoothAsGlass.ogg"
			$".".play()  # 播放
		Global.play_cave_song = false
		
	if Global.play_no_song:
		Global.song_playing = ""
		$".".stop()  # 播放
		Global.play_no_song = false
