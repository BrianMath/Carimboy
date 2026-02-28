extends Node2D

func _ready() -> void:
	Musica.play_music(1)

func setup() -> void:
	Global.pos_inicial = Vector2(168, 808)
	Global.level = 0
	Global.qtd_carimbos = 2
	$HUD.atualizar_numero(Global.qtd_carimbos)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$CanvasPersonagem/Personagem.position = Global.pos_inicial
