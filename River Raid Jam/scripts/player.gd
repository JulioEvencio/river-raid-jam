extends CharacterBody2D

const SPEED : int = 50

func _physics_process(_delta : float) -> void:
	move()

func move() -> void:
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
