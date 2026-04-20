extends Control

func _on_quit_pressed() -> void :
	get_tree().quit()

func _on_full_toggled(_toggled_on: bool) -> void :
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levelselection.tscn")
