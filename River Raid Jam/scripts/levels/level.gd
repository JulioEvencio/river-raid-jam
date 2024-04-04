extends Node
class_name Level

@export var helicopter_scene : PackedScene
@export var bullet_scene : PackedScene

@export var player : Player
@export var spawn_point : Marker2D
@export var bullet_point : Marker2D
@export var destroy_point : Marker2D

func _ready() -> void:
	create_helicopter()

func _physics_process(_delta : float) -> void:
	respawn_terrains()
	destroy_bullets()
	destroy_enemies()

func game_over() -> void:
	get_tree().reload_current_scene()

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

func destroy_enemies() -> void:
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if out_destroy_point(enemy.position.y):
			enemy.queue_free()

func add_bullet() -> void:
	if get_tree().get_nodes_in_group("bullets").size() < 5:
		var bullet = bullet_scene.instantiate()
		bullet.position = player.position
		add_child(bullet)

func create_enemy_x() -> float:
	return randf_range(88, 168)

func create_helicopter() -> void:
	var helicopter = helicopter_scene.instantiate()
	helicopter.position.x = create_enemy_x()
	helicopter.position.y = player.position.y + spawn_point.position.y
	add_child(helicopter)

func _on_spawn_helicopter_timeout():
	create_helicopter()
