extends Control


var _is_paused: bool = false


func toggle_paused():
	_is_paused = !_is_paused
	
	if _is_paused:
		show()
	else:
		hide()
	
	get_tree().paused = _is_paused


func _on_resume_button_pressed():
	toggle_paused()


func _on_quit_button_pressed():
	# Propogate a close window request to all memebers
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
