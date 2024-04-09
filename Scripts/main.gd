extends Node2D

@export var asteroid_scene: Array[PackedScene]

var score: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$AsteroidTimer.start()
	pass


func game_over():
	$AsteroidTimer.stop()
	_quit_game()


func add_points(points):
	score += points
	$HUD.update_score(score)


func _unhandled_key_input(event):
	if(event.is_action_pressed("quit")):
		_quit_game()


func _on_asteroid_timer_timeout():
	# Make an asteroid
	var selected_index = randi_range(0, asteroid_scene.size() - 1)
	var asteroid = asteroid_scene[selected_index].instantiate()
	
	# Retrieve the random location selector (which is bound to the spawn path)
	var asteroid_spawn_location = $AsteroidSpawnPath/AsteroidSpawnLocation
	# Set the location along the path (a ratio baetween 0-1) randomly
	asteroid_spawn_location.progress_ratio = randf()
	asteroid.position = asteroid_spawn_location.position
	
	# Rotate the asteroid
	var direction = asteroid_spawn_location.rotation + PI/2  # point straight in
	direction += randf_range(-PI/4, PI/4)
	asteroid.rotation = direction

	# Set the asteroid velocity
	var velocity = Vector2(randf_range(20,200), randf_range(10,100))
	asteroid.linear_velocity = velocity.rotated(direction)
	
	# Spawn
	add_child(asteroid)


func _quit_game():
	# Propogate a close window request to all memebers
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
