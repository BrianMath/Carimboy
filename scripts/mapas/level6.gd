extends Node2D

@onready var fade: CanvasLayer = $Fade

func _ready() -> void:
	print("aaa")
	fade.fade_out()
	print("bbb")
