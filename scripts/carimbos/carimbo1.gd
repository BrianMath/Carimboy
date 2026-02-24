extends StaticBody2D

var cores: Array = [
	preload("res://sprites/carimbos/carimbo0.png"),
	preload("res://sprites/carimbos/carimbo1.png"),
	preload("res://sprites/carimbos/carimbo2.png"),
	preload("res://sprites/carimbos/carimbo3.png")
]

func change_color(color: int) -> void:
	match color:
		0: $Sprite.texture = cores[0]
		1: $Sprite.texture = cores[1]
		2: $Sprite.texture = cores[2]
		3: $Sprite.texture = cores[3]
		_: $Sprite.texture = cores[0]
