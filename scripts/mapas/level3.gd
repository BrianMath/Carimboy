extends Node2D

func setup():
	Global.pos_inicial = Vector2(51, 346)
	Global.level = 3
	Global.qtd_carimbos = 3
	$HUD.atualizar_numero(Global.qtd_carimbos)


func _on_fim_do_mundo_body_entered(_body: Node2D) -> void:
	$CanvasPersonagem/Personagem.position = Global.pos_inicial
