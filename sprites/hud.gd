extends CanvasLayer

var texturas = []

func _ready() -> void:
	for i in range(7):
		texturas.append(load("res://sprites/numeros/%d.png" % i))
	
	Eventos.carimbou.connect(_on_carimbou)
	

func _on_carimbou(qtd_carimbos):
	atualizar_numero(qtd_carimbos)

func atualizar_numero(qtd_carimbos):
	$Numero.texture = texturas[qtd_carimbos]

func _on_plataforma_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Escada.button_pressed = false
	Eventos.modo_carimbo.emit(toggled_on, 0)
	$Plataforma.release_focus()


func _on_escada_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Plataforma.button_pressed = false
	Eventos.modo_carimbo.emit(toggled_on, 1)
	$Escada.release_focus()
