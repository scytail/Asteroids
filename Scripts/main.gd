extends Node2D

@export var asteroid_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: start timer
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func game_over():
	$AsteroidTimer.stop()


func _on_asteroid_timer_timeout():
	# Make an asteroid
	var asteroid = asteroid_scene.instantiate()
	
	# Retrieve the random location selector (which is bound to the spawn path)
	var asteroid_spawn_location = $AsteroidSpawnPath/AsteroidSpawnLocation
	# Set the location along the path (a ratio between 0-1) randomly
	asteroid_spawn_location.progress_ratio = randf()
	
	# Rotate the asteroid
	var direction = asteroid_spawn_location.rotation + PI/2 
	direction += randf_range(-PI/2, PI/2)
	asteroid.rotation = direction

	# Set the asteroid velocity
	var velocity = Vector2(randf_range(10,100), randf_range(10,100))
	asteroid.linear_velocity = velocity.rotated(direction)
	
	# Spawn
	add_child(asteroid)
