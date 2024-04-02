extends Node

@export var player : Player
@export var spawn_point : Marker2D
@export var destroy_point : Marker2D

func _process(_delta : float) -> void:
	if player.is_dead():
		get_tree().reload_current_scene()
	else:
		for terrain in get_tree().get_nodes_in_group("terrains"):
			if can_update(terrain.position.y):
				terrain.position.y = player.position.y + spawn_point.position.y

func can_update(y : int) -> bool:
	return y >= player.position.y + destroy_point.position.y
