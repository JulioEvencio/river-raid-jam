extends Node
class_name Level

@export var island_scene : PackedScene
@export var helicopter_scene : PackedScene
@export var bullet_scene : PackedScene
@export var fuel_scene : PackedScene

@export var player : Player
@export var spawn_point : Marker2D
@export var bullet_point : Marker2D
@export var destroy_point : Marker2D
@export var camera : Camera2D

@export var score_label : Label
@export var fuel_label : Label
@export var tutorial_label : Label

func _ready() -> void:
	Singleton.audio_menu.stop()
	Singleton.score = 0
	create_helicopter()
	camera.position = player.position

func _physics_process(_delta : float) -> void:
	score_label.text = str(Singleton.score)
	fuel_label.text = "Fuel: " + str(player.fuel) + "%"
	
	if player.fuel <= 20:
		fuel_label.set_modulate(Color(255, 0, 0))
	else:
		fuel_label.set_modulate(Color(255, 255, 255))
	
	respawn_terrains()
	destroy_bullets()
	destroy_enemies()
	destroy_islands()
	destroy_fuels()
	
	camera.position.y = player.position.y - 50

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
			terrain.position.y -= 384 # terrain height * 2 == 192 * 2

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

func destroy_fuels() -> void:
	for fuel in get_tree().get_nodes_in_group("fuels"):
		if out_destroy_point(fuel.position.y - 100):
			fuel.queue_free()

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

func create_fuel() -> void:
	var fuel = fuel_scene.instantiate()
	fuel.position.x = create_enemy_x()
	fuel.position.y = player.position.y + spawn_point.position.y
	add_child(fuel)

func _on_spawn_helicopter_timeout() -> void:
	create_helicopter()

func _on_tutorial_timer_timeout() -> void:
	tutorial_label.hide()

func _on_spawn_island_timeout() -> void:
	create_island()

func _on_spawn_fuel_timeout() -> void:
	create_fuel()
