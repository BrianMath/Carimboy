extends Node2D

var jogar    := load("res://sprites/menu/jogar.png")
var sair     := load("res://sprites/menu/sair.png")
var creditos := load("res://sprites/menu/creditos.png")
var mao      := load("res://sprites/menu/mao.png")

@onready var pos_picotado: Vector2 = $picotado.position - (Vector2(400, 300) / 2)
var pos_desenho: Vector2 = Vector2(0, 0)
var tex_desenho = null
var carimbos = []
var nome: String = ""

func _on_tbtn_jogar_pressed() -> void:
	nome = "jogar"
	processar_botao()

func _on_tbtn_sair_pressed() -> void:
	nome = "sair"
	processar_botao()

func _on_tbtn_creditos_pressed() -> void:
	nome = "creditos"
	processar_botao()

func processar_botao() -> void:
	$tbtn_jogar.visible = true
	$tbtn_jogar.disabled = false
	
	$tbtn_sair.visible = true
	$tbtn_sair.disabled = false
	
	$tbtn_creditos.visible = true
	$tbtn_creditos.disabled = false
	
	var node = get_node("tbtn_%s" % nome)
	node.visible = false
	node.disabled = true
	
	Input.set_custom_mouse_cursor(mao, Input.CURSOR_ARROW, Vector2(128, 96))
	
	tex_desenho = get("%s" % nome)

func change_scene() -> void:
	match nome:
		"jogar":
			Input.set_custom_mouse_cursor(null)
			get_tree().change_scene_to_file("res://scenes/mapas/tutorial.tscn")
		
		"creditos":
			Input.set_custom_mouse_cursor(null)
			get_tree().change_scene_to_file("res://scenes/creditos.tscn")
			
		"sair":
			get_tree().quit()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	
	if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Desenha o carimbo na tela
		if tex_desenho != null:
			$Click.play()
			pos_desenho = event.position - (tex_desenho.get_size() / 2)
			carimbos.append([tex_desenho, pos_desenho])
			queue_redraw()
		
		# Se o carimbo foi em cima do picotado, coisa o negócio
		if pos_desenho.distance_to(pos_picotado) <= 100:
			change_scene()

func _draw() -> void:
	if not carimbos.is_empty():
		for carimbo in carimbos:
			draw_texture(carimbo[0], carimbo[1])
