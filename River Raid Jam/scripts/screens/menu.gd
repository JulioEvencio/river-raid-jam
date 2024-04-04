extends Control

func _on_start_pressed():
	print("Start")

func _on_credits_pressed():
	print("Credits")

func _on_exit_pressed():
	get_tree().quit()
