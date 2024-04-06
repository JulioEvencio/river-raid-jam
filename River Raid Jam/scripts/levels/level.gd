extends Node
class_name Level

@export var island_scene : PackedScene
@export var helicopter_scene : PackedScene
@export var bullet_scene : PackedScene

@export var player : Player
@export var spawn_point : Marker2D
@export var bullet_point : Marker2D
@export var destroy_point : Marker2D

@export var score_label : Label
@export var tutorial_label : Label

func _ready() -> void:
	Singleton.audio_menu.stop()
	Singleton.score = 0
	create_helicopter()

func _physics_process(_delta : float) -> void:
	score_label.text = str(Singleton.score)
	
	respawn_terrains()
	destroy_bullets()
	destroy_enemies()
	destroy_islands()

func game_over() -> void:
	Transition.start(func(): get_tree().change_scene_to_file("res://scenes/screens/game_over.tscn"))

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
		if out_destroy_point(enemy.position.y - 30):
			enemy.queue_free()

func destroy_islands() -> void:
	for island in get_tree().get_nodes_in_group("islands"):
		if out_destroy_point(island.position.y - 30):
			island.queue_free()

func add_bullet() -> void:
	if get_tree().get_nodes_in_group("bullets").size() < 1:
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

func create_island() -> void:
	var island = island_scene.instantiate()
	island.position.x = create_enemy_x()
	island.position.y = player.position.y + spawn_point.position.y
	add_child(island)

func _on_spawn_helicopter_timeout():
	create_helicopter()

func _on_tutorial_timer_timeout():
	tutorial_label.hide()

func _on_spawn_island_timeout():
	create_island()
