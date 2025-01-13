extends Node2D

# opens the world scene when play button is pressed
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

# quits the game when the quit button is pressed
func _on_quit_pressed() -> void:
	get_tree().quit()
