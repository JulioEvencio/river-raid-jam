extends CharacterBody2D
class_name  Player

@export var bullet_scene : PackedScene
@export var level : Level

const SPEED : int = 50

var hp : int = 1

func _physics_process(_delta : float) -> void:
	to_move()
	to_shoot()

func to_move() -> void:
	var speed_y : int = -20
	
	if Input.is_action_pressed("move_down"):
		speed_y = -5
	elif Input.is_action_pressed("move_up"):
		speed_y = -SPEED
	
	velocity.y = speed_y
	
	var direction : float = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func to_shoot() -> void:
	if Input.is_action_just_pressed("to_shoot"):
		level.add_bullet(bullet_scene.instantiate())

func is_dead() -> bool:
	return hp <= 0

func take_damage(damage : int) -> void:
	hp -= damage