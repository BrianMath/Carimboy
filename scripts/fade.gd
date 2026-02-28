extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	get_tree().paused = false

func fade_out():
	var tween = create_tween()
	tween.tween_method(
		func(v): color_rect.modulate.a = v,
		1.0, 0.0, 5.0
	)
	return tween
