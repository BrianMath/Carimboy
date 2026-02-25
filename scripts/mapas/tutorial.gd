extends Node2D

func setup() -> void:
	Global.pos_inicial = Vector2(168, 808)
	Global.level = 0
	Global.qtd_carimbos = 4

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$Personagem.position = Global.pos_inicial
