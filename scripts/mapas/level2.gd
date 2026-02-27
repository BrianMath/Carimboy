extends Node2D

func setup():
	Global.pos_inicial = Vector2(215, 930)
	Global.level = 2
	Global.qtd_carimbos = 4
	$HUD.atualizar_numero(Global.qtd_carimbos)
