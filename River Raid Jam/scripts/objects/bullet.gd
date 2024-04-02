extends Area2D
class_name Bullet

const SPEED : int = -1

func _physics_process(_delta : float) -> void:
	position.y += SPEED

func _on_body_entered(enemy : Enemy) -> void:
	enemy.to_kill()
	queue_free()
