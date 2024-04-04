extends RigidBody2D

@export var engine_power = 300
@export var rotate_speed = 200

@export var bullet: PackedScene

var screen_size;


func _ready():
	screen_size = get_viewport_rect().size


func _integrate_forces(state):
	_push_ship(state)
	_teleport_ship_on_boundaries(state)
	_rotate_ship(state)


func _unhandled_key_input(event):
	if (event.is_action_pressed("shoot")):
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


func _teleport_ship_on_boundaries(state):
	if position.x < 0:
		state.transform.origin.x = screen_size.x
	elif position.x > screen_size.x:
		state.transform.origin.x = 0
	if position.y < 0:
		state.transform.origin.y = screen_size.y
	elif position.y > screen_size.y:
		state.transform.origin.y = 0
		
		
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
