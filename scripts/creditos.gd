extends Node2D

var nome
var voltar     := load("res://sprites/menu/voltar.png")
var mao      := load("res://sprites/menu/mao.png")
var flag = false

var pos_desenho: Vector2 = Vector2(0, 0)
var carimbos = []
@onready var pos_picotado: Vector2 = $picotado.position - (Vector2(400, 300) / 2)

func _on_tbtn_sair_pressed() -> void:
	nome = "voltar"
	processar_botao()

func processar_botao() -> void:
	$tbtn_sair.visible = false
	$tbtn_sair.disabled = true
	
	Input.set_custom_mouse_cursor(mao, Input.CURSOR_ARROW, Vector2(128, 96))
	
	flag = true

func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Desenha o carimbo na tela
		if flag:
			$Click.play()
			pos_desenho = event.position - (voltar.get_size() / 2)
			carimbos.append([voltar, pos_desenho])
			queue_redraw()
		
		# Se o carimbo foi em cima do picotado, coisa o negócio
		if pos_desenho.distance_to(pos_picotado) <= 100:
			change_scene()

func change_scene() -> void:
	Input.set_custom_mouse_cursor(null)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _draw() -> void:
	if not carimbos.is_empty():
		for carimbo in carimbos:
			draw_texture(carimbo[0], carimbo[1])
