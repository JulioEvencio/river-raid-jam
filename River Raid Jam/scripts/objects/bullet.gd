extends Area2D
class_name Bullet

const SPEED : int = -1

func _physics_process(_delta : float) -> void:
	position.y += SPEED

func add_score():
	if Singleton.score < 9999999999:
		Singleton.score += 1

func _on_body_entered(body) -> void:
	if body is Enemy:
		add_score()
		body.to_kill()
	
	queue_free()
