extends Area2D
class_name Bullet

const SPEED : int = -1

func _physics_process(_delta : float) -> void:
	position.y += SPEED

func _on_body_entered(body) -> void:
	if body is Enemy:
		body.to_kill()
	
	queue_free()
