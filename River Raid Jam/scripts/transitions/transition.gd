extends CanvasLayer

@export var animation : AnimationPlayer

var lambda : Callable

func _ready() -> void:
	animation.play("fade_out")

func start(callable : Callable) -> void:
	lambda = callable
	
	animation.play("fade_in")

func _on_animation_player_animation_finished(anim_name : String) -> void:
	match anim_name:
		"fade_in":
			lambda.call()
			animation.play("fade_out")
