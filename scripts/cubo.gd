extends Sprite2D

const MIN_X = 1670.0
const MAX_X = 1720.0
const SPD_X = 0.3

const MIN_Y = 290.0
const MAX_Y = 320.0
const SPD_Y = 0.4

const MIN_T = deg_to_rad(-35.0)
const MAX_T = deg_to_rad(0.0)
const SPD_T = 0.5

var f_x = true
var f_y = true
var f_t = true

var t = 0.0

func _process(delta: float) -> void:
	t += delta
	position.x = lerp(MIN_X, MAX_X, (sin(t * SPD_X) + 1.0) / 2.0)
	position.y = lerp(MIN_Y, MAX_Y, (sin(t * SPD_Y) + 1.0) / 2.0)
	rotation  = lerp(MIN_T, MAX_T, (sin(t * SPD_T) + 1.0) / 2.0)
