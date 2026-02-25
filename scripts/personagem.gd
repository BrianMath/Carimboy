extends CharacterBody2D

const SPEED: float         = 300.0
const CLIMB_SPEED: float   = 300.0
const JUMP_VELOCITY: float = -500.0

var modo_carimbo: bool = true
var qtd_carimbo: int = 0
var draw_distance: int = 100
var carimbo_scene0 := preload("res://scenes/carimbos/carimbo0.tscn")
var carimbo_scene1 := preload("res://scenes/carimbos/carimbo1.tscn")
var carimbos: Array
var carimboys: Array = [
	preload("res://sprites/carimboys/carimboy_azul.png"),
	preload("res://sprites/carimboys/carimboy_amarelo.png"),
	preload("res://sprites/carimboys/carimboy_verde.png"),
	preload("res://sprites/carimboys/carimboy_vermelho.png")
]
var carimboy_atual: int = 0
var mao = preload("res://sprites/menu/mao_pequena.png")
var na_escada: bool = false
var escadas_sobrepostas: int = 0

func _ready() -> void:
	get_parent().setup()
	qtd_carimbo = Global.qtd_carimbos
	Input.set_custom_mouse_cursor(mao, Input.CURSOR_ARROW, Vector2(64, 64))

func _input(event) -> void:
	# Troca entre os modos de jogo
	if event.is_action_pressed("modo_carimbo_bt"):
		modo_carimbo = !modo_carimbo
		# Muda o símbolo do mouse
		if modo_carimbo:
			Input.set_custom_mouse_cursor(
				mao, Input.CURSOR_ARROW, Vector2(64, 64))
		else:
			Input.set_custom_mouse_cursor(null)
		queue_redraw()
		return
	
	# Reseta fase e limpa os carimbos
	if event.is_action_pressed("reiniciar"):
		position = Global.pos_inicial
		for c in carimbos:
			c.queue_free()
		carimbos = []
		qtd_carimbo = Global.qtd_carimbos
	
	if !modo_carimbo:
		return
	
	# Muda a cor do Carimboy
	if event.is_action_pressed("carimbo0"):
		#$PlayerSprite.texture = carimboys[0]
		carimboy_atual = 0
	elif event.is_action_pressed("carimbo1"):
		#$PlayerSprite.texture = carimboys[1]
		carimboy_atual = 1
	#elif event.is_action_pressed("carimboy_verde"):
		#$PlayerSprite.texture = carimboys[2]
		#carimboy_atual = 2
	#elif event.is_action_pressed("carimboy_vermelho"):
		#$PlayerSprite.texture = carimboys[3]
		#carimboy_atual = 3
	
	# Ação de carimbar
	if event.is_action_pressed("clicar") and qtd_carimbo > 0:
		var mouse_pos = get_global_mouse_position()
		var distance = global_position.distance_to(mouse_pos)
		
		# Adiciona instância do carimbo ao array e reduz quantidade de tinta
		if distance > draw_distance:
			$Click.play()
			var carimbo = carimbo_instance()
			carimbos.append(carimbo)
			carimbo.global_position = mouse_pos
			get_parent().add_child(carimbo)
			qtd_carimbo -= 1

func carimbo_instance():
	match carimboy_atual:
		0: return carimbo_scene0.instantiate()
		1: return carimbo_scene1.instantiate()
		2: return carimbo_scene0.instantiate()
		3: return carimbo_scene0.instantiate()

func _draw() -> void:
	# Se estiver no modo carimbo aparece o limite onde pode colocar o carimbo
	if modo_carimbo:
		draw_arc(Vector2.ZERO, draw_distance, 0, TAU, 64, Color(1, 1, 1, 0.2), 2)

func _physics_process(delta: float) -> void:
	var no_chao: bool = is_on_floor()
	var dir_horizontal := Input.get_axis("esquerda", "direita")
	var dir_vertical := Input.get_axis("cima", "baixo")
	
	if no_chao or na_escada:
		$PlayerSprite.animation = "parado"
	
	# A ação de subir e descer só funciona se estiver em contato com a escada
	if na_escada:
		# Enquanto estiver pressionando cima/baixo se movimenta na escada
		if dir_vertical:
			velocity.y = dir_vertical * CLIMB_SPEED
		# Se esiver na escada e parar de pressionar cima/baixo, para na escada
		else:
			velocity.y = move_toward(velocity.y, 0, CLIMB_SPEED)
	# Se não estiver em contato com a escada, a gravidade funciona
	elif not no_chao:
		velocity += get_gravity() * delta
	
	# Só pode pular se não estiver subindo
	if Input.is_action_just_pressed("pular") and (no_chao or na_escada):
		$PlayerSprite.animation = "pulando"
		na_escada = false
		velocity.y = JUMP_VELOCITY
	
	if dir_horizontal:
		velocity.x = dir_horizontal * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("escada"):
		escadas_sobrepostas += 1
		atualizar_estado_escadas()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("escada"):
		escadas_sobrepostas = max(0, escadas_sobrepostas-1)
		atualizar_estado_escadas()

func atualizar_estado_escadas() -> void:
	na_escada = escadas_sobrepostas > 0
