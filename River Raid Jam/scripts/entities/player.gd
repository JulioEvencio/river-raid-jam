extends CharacterBody2D
class_name  Player

@export var level : Level
@export var animation : AnimationPlayer
@export var audio_helice : AudioStreamPlayer
@export var audio_dead : AudioStreamPlayer

const SPEED : int = 80

var hp : int = 1

func _ready() -> void:
	animation.play("flying")

func _physics_process(_delta : float) -> void:
	if not is_dead():
		to_move()
		to_shoot()

func to_move() -> void:
	var speed_y : int = -50
	
	if Input.is_action_pressed("move_down"):
		speed_y += 20
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
		level.add_bullet()

func is_dead() -> bool:
	return hp <= 0

func take_damage(damage : int) -> void:
	hp -= damage
	
	if is_dead():
		audio_helice.stop()
		audio_dead.play()
		animation.play("explosion")

func _on_animation_player_animation_finished(anim_name : String) -> void:
	match anim_name:
		"explosion":
			level.game_over()

func _on_area_2d_body_entered(_body) -> void:
	take_damage(hp)
