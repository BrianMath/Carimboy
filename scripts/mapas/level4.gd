extends Node2D

func setup():
	Global.pos_inicial = Vector2(62, 533)
	Global.level = 4
	Global.qtd_carimbos = 1
	$HUD.atualizar_numero(Global.qtd_carimbos)
