extends InteractiveEntity

@export var engine_power = 300
@export var rotate_speed = 200
@export var max_velocity = 1000

@export var bullet_scene: PackedScene
@export var engine_trail_scene: PackedScene

func _ready():
	super._ready()
	

func _integrate_forces(state):
	super._integrate_forces(state)
	_push_ship(state)
	_rotate_ship(state)
	_set_max_speed(state)
	_set_motion_trail(state.linear_velocity)


func _unhandled_key_input(event):
	if (event.is_action_pressed("shoot")):
		var bullet = bullet_scene.instantiate()
		bullet.position = $BulletSpawnLocation.global_position
		bullet.rotation = rotation
		
		add_sibling(bullet)

	  
func _push_ship(_state):
	var impulse_strength = 0
	if Input.is_action_pressed("move_forward"):
		impulse_strength += engine_power
	if Input.is_action_pressed("move_backward"):
		impulse_strength -= engine_power
	
	if impulse_strength != 0:
		apply_central_force(Vector2(sin(rotation), -cos(rotation)) * impulse_strength)


func _rotate_ship(state):
	var rotation_velocity = 0
	if Input.is_action_pressed("rotate_left"):
		rotation_velocity = -1
	if Input.is_action_pressed("rotate_right"):
		rotation_velocity = 1

	if rotation_velocity != 0:
		rotation_velocity *= rotate_speed * state.step
		
		state.angular_velocity = rotation_velocity
	else:
		angular_velocity = 0


func _set_max_speed(state):
	state.linear_velocity.x = clamp(state.linear_velocity.x, -max_velocity, max_velocity)
	state.linear_velocity.y = clamp(state.linear_velocity.y, -max_velocity, max_velocity)


func _set_motion_trail(current_velocity: Vector2):
	var speed = abs(current_velocity.x + current_velocity.y)
	var speed_ratio = speed/(max_velocity*2)
	
	var trail = engine_trail_scene.instantiate()
	trail.position = $TrailSpawnLocation.global_position
	trail.rotation = rotation
	trail.scale = Vector2(speed_ratio*6,speed_ratio*6)
	add_sibling(trail)


func take_damage():
	super.take_damage()
	get_tree().get_current_scene().game_over()
