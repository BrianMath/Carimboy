extends Node

var music_player: AudioStreamPlayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.finished.connect(_on_music_finished)

func play_music(id_musica):
	if music_player.stream == null or not music_player.playing:
		music_player.volume_db = -13
		match id_musica:
			0:
				music_player.stream = preload("res://musicas/menu.wav")
			1:
				music_player.stream = preload("res://musicas/passagem_emaj.wav")
			2:
				music_player.stream = preload("res://musicas/ruinas.wav")
		
		music_player.play()

func stop_music():
	music_player.stop()

func _on_music_finished():
	music_player.play()
