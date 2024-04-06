extends Control

@export var background : ParallaxLayer
@export var text : Label

func _ready() -> void:
	text.text = "Game Over\n\n\nScore:\n\n" + str(Singleton.score)

func _physics_process(_delta : float) -> void:
	background.motion_offset.x += 1
	background.motion_offset.y += 1

func to_main_menu() -> void:
	Singleton.audio_menu.play()
	get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")

func _on_timer_timeout() -> void:
	Singleton.audio_menu.stop()
	Transition.start(func(): to_main_menu())
