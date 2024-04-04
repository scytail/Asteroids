extends InteractiveEntity

@export var engine_power = 300
@export var rotate_speed = 200

@export var bullet_scene: PackedScene


func _ready():
	super._ready()
	

func _integrate_forces(state):
	super._integrate_forces(state)
	_push_ship(state)
	_rotate_ship(state)


func _unhandled_key_input(event):
	if (event.is_action_pressed("shoot")):
		var bullet = bullet_scene.instantiate()
		bullet.position = $BulletSpawnLocation.global_position
		bullet.rotation = rotation
		
		add_sibling(bullet)
		# TODO: fire a bullet in direction we're facing with a set impulse
		# 		This bullet will emit a signal when it collides, and the
		#		asteroids will link to this signal and destroy themselves
		pass

	
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
