extends Node2D

@onready var fade: CanvasLayer = $Fade

func _ready() -> void:
	fade.fade_out()
	await get_tree().create_timer(6.0).timeout
	Musica.stop_music()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
