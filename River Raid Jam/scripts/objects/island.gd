extends CharacterBody2D
class_name Island

func _ready() -> void:
	z_index = -10

func _on_area_2d_body_entered(body) -> void:
	if not body is Island:
		queue_free()
