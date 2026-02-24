extends Camera2D

const ZOOM_SPEED: float = 5.0
signal timeover

func _ready() -> void:
	set_process(false)
	await get_tree().create_timer(2.0).timeout
	timeover.emit()
	set_process(true)

func _process(delta):
	# Interpolate the current zoom towards the target zoom
	zoom = zoom.lerp(Vector2(2, 2), delta * ZOOM_SPEED)
