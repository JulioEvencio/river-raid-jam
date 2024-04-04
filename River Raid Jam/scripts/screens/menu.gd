extends Control

@export var background : ParallaxLayer

func _physics_process(_delta : float) -> void:
	background.motion_offset.x += 1
	background.motion_offset.y += 1

func _on_start_pressed():
	Transition.start(func(): get_tree().change_scene_to_file("res://scenes/levels/level.tscn"))

func _on_credits_pressed():
	Transition.start(func(): get_tree().change_scene_to_file("res://scenes/screens/credits.tscn"))

func _on_exit_pressed():
	get_tree().quit()
