extends Node
class_name Level

@export var bullet_scene : PackedScene

@export var player : Player
@export var spawn_point : Marker2D
@export var bullet_point : Marker2D
@export var destroy_point : Marker2D

func _process(_delta : float) -> void:
	if player.is_dead():
		get_tree().reload_current_scene()
	else:
		respawn_terrains()
		destroy_bullets()

func out_spawn_point(y : int) -> bool:
	return y <= player.position.y + spawn_point.position.y

func out_bullet_point(y : int) -> bool:
	return y <= player.position.y + bullet_point.position.y

func out_destroy_point(y : int) -> bool:
	return y >= player.position.y + destroy_point.position.y

func respawn_terrains() -> void:
	for terrain in get_tree().get_nodes_in_group("terrains"):
		if out_destroy_point(terrain.position.y):
			terrain.position.y = player.position.y + spawn_point.position.y

func destroy_bullets() -> void:
	for bullet in get_tree().get_nodes_in_group("bullets"):
		if out_bullet_point(bullet.position.y):
			bullet.queue_free()

func add_bullet() -> void:
	if get_tree().get_nodes_in_group("bullets").size() < 3:
		var bullet = bullet_scene.instantiate()
		bullet.position = player.position
		add_child(bullet)
