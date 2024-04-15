extends Node2D


@export_group("")
@export var asteroid_scene: Array[PackedScene]

@export_group("Debugger Options")
@export var disable_asteroid_spawns: bool = false

var score: int


func _ready():
	if (disable_asteroid_spawns):
		$AsteroidTimer.start()


func game_over():
	$AsteroidTimer.stop()
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


func _on_asteroid_timer_timeout():
	# Retrieve the random location selector (which is bound to the spawn path)
	var asteroid_spawn_location = $AsteroidSpawnPath/AsteroidSpawnLocation
	# Set the location along the path (a ratio baetween 0-1) randomly
	asteroid_spawn_location.progress_ratio = randf()
	var location = asteroid_spawn_location.position
	
	# Rotate the asteroid
	var direction = asteroid_spawn_location.rotation + PI/2  # point straight in
	direction += randf_range(-PI/4, PI/4)

	# Set the asteroid velocity
	var velocity = Vector2(randf_range(20,200), randf_range(10,100))
	velocity = velocity.rotated(direction)
	
	_spawn_asteroid(location, direction, velocity)


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
