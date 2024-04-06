extends CharacterBody2D
class_name Enemy

@export var animation : AnimationPlayer
@export var audio : AudioStreamPlayer

var damage : int = 1

func _ready() -> void:
	animation.play("flying")

func to_kill():
	audio.play()
	animation.play("explosion")

func _on_area_attack_body_entered(player : Player) -> void:
	player.take_damage(damage)

func _on_animation_player_animation_finished(anim_name : String) -> void:
	match anim_name:
		"explosion":
			queue_free()
