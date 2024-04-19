extends InteractiveEntity

@export_group("Player Controls")
@export var engine_power = 300
@export var rotate_speed = 200
@export var bullet_scene: PackedScene

@export_group("Upgrade Modifiers")
@export var bullet_scale_increment: float = .1
@export var bullet_scale_limit: Vector2 = Vector2(.1, 3)

var _current_bullet_scale_modifier = 1


func _ready():
	super._ready()
	

func _integrate_forces(state):
	super._integrate_forces(state)
	_push_ship(state)
	_rotate_ship(state)


func _unhandled_key_input(event):
	if (event.is_action_pressed("shoot")):
		_fire_bullet()

	  
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


func _fire_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = $BulletSpawnLocation.global_position
	# Along with pushing itself forward, we want it to also have the inherent velocity 
	# of the ship itself
	bullet.linear_velocity = linear_velocity
	# Start the bullet out pointing in the direction of the ship. It'll handle pointing from there
	bullet.rotation = rotation
	
	# Scaling a rigidbody is apparently a big no-no in godot. Instead, iterate over the children
	# and scale them all manually, while leaving the main node at a standard scale. Kinda jank.
	for child in bullet.get_children():
		if child is Node2D:
			child.scale *= _current_bullet_scale_modifier
			var min_scale = Vector2(bullet_scale_limit.x, bullet_scale_limit.x)
			var max_scale = Vector2(bullet_scale_limit  .y, bullet_scale_limit.y)
			child.scale = child.scale.clamp(min_scale, max_scale)
	
	add_sibling(bullet)


func take_damage():
	super.take_damage()
	get_tree().get_current_scene().game_over()
	
func apply_upgrade(upgrade_type: Enums.upgrade_types):
	match upgrade_type:
		Enums.upgrade_types.BULLET_SIZE:
			_current_bullet_scale_modifier += bullet_scale_increment
