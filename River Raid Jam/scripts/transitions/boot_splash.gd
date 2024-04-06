extends Control

func to_menu() -> void:
	Singleton.audio_menu.play()
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _on_timer_timeout():
	Transition.start(func(): to_menu())
