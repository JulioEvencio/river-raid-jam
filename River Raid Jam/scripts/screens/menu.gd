extends Control

func _on_start_pressed() -> void:
	Transition.start(func(): get_tree().change_scene_to_file("res://scenes/levels/level.tscn"))

func _on_credits_pressed() -> void:
	print("Credits")

func _on_exit_pressed() -> void:
	get_tree().quit()
