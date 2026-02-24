extends StaticBody2D

func _ready() -> void:
	var colisao: CollisionPolygon2D = CollisionPolygon2D.new()
	colisao.polygon = $Formato.polygon
	add_child(colisao)
