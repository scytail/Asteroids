extends Node2D


@export_group("")
@export var asteroid_scene: Array[PackedScene]

var score: int


func _ready():
	# TODO: In the future, we can fire this on a signal
	$MapGenerator.generateTiles()
	

func game_over():
	_quit_game()


func add_points(points):
	score += points
	$HUD.update_score(score)


func _unhandled_key_input(event):
	if(event.is_action_pressed("quit")):
		_quit_game()


func _unhandled_input(event):
	if OS.is_debug_build():
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				_spawn_asteroid(event.position, 0.0, Vector2())


func _spawn_asteroid(location: Vector2, direction: float, velocity: Vector2):
	# Make an asteroid
	var selected_index = randi_range(0, asteroid_scene.size() - 1)
	var asteroid = asteroid_scene[selected_index].instantiate()
	
	asteroid.position = location
	
	asteroid.rotation = direction
	
	asteroid.linear_velocity = velocity
	
	# Attach the signal
	asteroid.destroyed.connect(add_points.bind())
	
	# Spawn
	add_child(asteroid)


func _quit_game():
	# Propogate a close window request to all memebers
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
