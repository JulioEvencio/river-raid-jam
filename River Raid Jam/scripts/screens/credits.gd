extends Control

@export var background : ParallaxLayer

func _physics_process(_delta : float) -> void:
	background.motion_offset.x += 1
	background.motion_offset.y += 1

func _on_button_pressed():
	Transition.start(func(): get_tree().change_scene_to_file("res://scenes/screens/menu.tscn"))
