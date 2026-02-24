extends CharacterBody2D

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -500.0

var modo_carimbo: bool = true
var qtd_carimbo: int = 0
var draw_distance: int = 100
var carimbo_scene := preload("res://scenes/carimbos/carimbo1.tscn")
var carimbos: Array
var input_habilitado = true
var carimboys: Array = [
	preload("res://sprites/carimboys/carimboy_azul.png"),
	preload("res://sprites/carimboys/carimboy_amarelo.png"),
	preload("res://sprites/carimboys/carimboy_verde.png"),
	preload("res://sprites/carimboys/carimboy_vermelho.png")
]
var carimboy_atual: int = 0
var mao = preload("res://sprites/menu/mao_pequena.png")

func _ready() -> void:
	get_parent().setup()
	qtd_carimbo = Global.qtd_carimbos
	Input.set_custom_mouse_cursor(mao, Input.CURSOR_ARROW, Vector2(64, 64))

func _on_timeover() -> void:
	input_habilitado = true

func _input(event) -> void:
	if !input_habilitado:
		return
	
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
	
	if event.is_action_pressed("reiniciar"):
		position = Global.pos_inicial
		for c in carimbos:
			c.queue_free()
		carimbos = []
		qtd_carimbo = Global.qtd_carimbos
	
	if !modo_carimbo:
		return
	
	if event.is_action_pressed("carimboy_azul"):
		$PlayerSprite.texture = carimboys[0]
		carimboy_atual = 0
	elif event.is_action_pressed("carimboy_amarelo"):
		$PlayerSprite.texture = carimboys[1]
		carimboy_atual = 1
	elif event.is_action_pressed("carimboy_verde"):
		$PlayerSprite.texture = carimboys[2]
		carimboy_atual = 2
	elif event.is_action_pressed("carimboy_vermelho"):
		$PlayerSprite.texture = carimboys[3]
		carimboy_atual = 3
	
	if event.is_action_pressed("clicar") and qtd_carimbo > 0:
		var mouse_pos = get_global_mouse_position()
		var distance = global_position.distance_to(mouse_pos)
		
		# Adiciona instância do carimbo e reduz quantidade de tinta
		if distance > draw_distance:
			$Click.play()
			var carimbo: StaticBody2D = carimbo_scene.instantiate()
			carimbo.change_color(carimboy_atual)
			carimbos.append(carimbo)
			carimbo.global_position = mouse_pos
			get_parent().add_child(carimbo)
			qtd_carimbo -= 1

func _draw() -> void:
	# Se estiver no modo carimbo aparece o limite onde pode colocar o carimbo
	if modo_carimbo:
		draw_arc(Vector2.ZERO, draw_distance, 0, TAU, 64, Color(1, 1, 1, 0.2), 2)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if !input_habilitado:
		move_and_slide()
		return
	
	# Handle jump.
	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("esquerda", "direita")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
