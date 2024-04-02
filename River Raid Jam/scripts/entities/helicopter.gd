extends CharacterBody2D
class_name Enemy

var damage : int = 1

func to_kill():
	queue_free()

func _on_area_attack_body_entered(player : Player) -> void:
	player.take_damage(damage)
