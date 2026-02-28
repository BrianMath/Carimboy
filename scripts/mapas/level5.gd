extends Node2D


func _ready() -> void:
	Musica.play_music(2)

func setup():
	Global.pos_inicial = Vector2(105, 733)
	Global.level = 5
	Global.qtd_carimbos = 6
	$HUD.atualizar_numero(Global.qtd_carimbos)


func _on_fim_jogo_body_entered(_body: Node2D) -> void:
	get_tree().paused = true
	Eventos.fim.emit()
