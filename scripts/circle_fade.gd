extends CanvasLayer

func _ready() -> void:
	Eventos.fim.connect(_on_fim)
	process_mode = Node.PROCESS_MODE_ALWAYS
	$ColorRect.material.set_shader_parameter("_Progress", 1.0)

func _on_fim():
	visible = true
	var tween = create_tween()
	tween.tween_method(
		func(v): $ColorRect.material.set_shader_parameter("_Progress", v),
		1.0, 0.0, 3.0
	)
	tween.tween_callback(func(): 
		$ColorRect.material.set_shader_parameter("_Progress", 1.0)
		get_tree().change_scene_to_file("res://scenes/mapas/level6.tscn")
	)
