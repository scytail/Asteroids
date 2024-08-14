extends MarginContainer



func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_quit_button_pressed():
	# Propogate a close window request to all memebers
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
