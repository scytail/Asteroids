extends InteractiveEntity

@export_group("Player Controls")
@export var engine_power = 300
@export var rotate_speed = 200
@export var bullet_scene: PackedScene

@export_group("Upgrade Modifiers")

var bullet_modifier_strategies: Array[BaseModifierStrategy] = []

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
	
	# Modify bullet
	for modifier in bullet_modifier_strategies:
		modifier.apply_modifier(bullet)
	
	add_sibling(bullet)


func take_damage():
	super.take_damage()
	get_tree().get_current_scene().game_over()
	
	
func apply_upgrade(modifier: BaseModifierStrategy):
	bullet_modifier_strategies.append(modifier)
