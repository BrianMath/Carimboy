extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	var prox_level: StringName = "res://scenes/mapas/level%d.tscn" % (Global.level + 1)
	get_tree().call_deferred("change_scene_to_file", prox_level)
