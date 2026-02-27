extends Node2D

func setup():
	Global.pos_inicial = Vector2(100, 780)
	Global.level = 1
	Global.qtd_carimbos = 3
	$HUD.atualizar_numero(Global.qtd_carimbos)
