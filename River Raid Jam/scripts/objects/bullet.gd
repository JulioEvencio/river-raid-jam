extends CharacterBody2D
class_name Bullet

const SPEED : int = -5

func _physics_process(_delta : float) -> void:
	velocity.y = SPEED
	move_and_collide(Vector2(0, SPEED))

func add_score() -> void:
	if Singleton.score < 9999999999:
		Singleton.score += 1

func _on_area_2d_body_entered(body) -> void:
	if body is Enemy:
		add_score()
		body.to_kill()
	
	if not body is Fuel:
		queue_free()
