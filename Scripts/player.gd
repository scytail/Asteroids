extends Controllable

@export_group("Player Controls")
@export var bullet_scene: PackedScene

@export_group("Booster Rendering")
@export var booster_velocity_ratio: float = 0.01
@export var booster_max_size: Vector2 = Vector2(0.3, 0.3)
@export var booster_tremble: float = 0.03

@export_group("Upgrade Modifiers")
var bullet_modifier_strategies: Array[BaseModifierStrategy] = []


func _integrate_forces(state):
	super._integrate_forces(state)
	
	var speed = sqrt(state.linear_velocity.x**2 + state.linear_velocity.y**2)
	var scalar = Vector2(speed, speed)/2.0 * booster_velocity_ratio
	
	scalar = scalar.clamp(Vector2(), booster_max_size) - Vector2(randf_range(0, booster_tremble), 0)
	$TrailOriginL/BoosterCircle.scale = scalar
	$TrailOriginR/BoosterCircle.scale = scalar


func activate_primary():
	super.activate_primary()
	
	var bullet = bullet_scene.instantiate()
	bullet.position = $Turret/BulletSpawnLocation.global_position
	# Start the bullet out pointing in the direction of the ship. It'll handle pointing from there
	bullet.rotation = $Turret.global_rotation
	
	# Modify bullet
	for modifier in bullet_modifier_strategies:
		modifier.apply_modifier(bullet)
	
	call_deferred("add_sibling", bullet)


func take_damage():
	super.take_damage()
	get_tree().get_current_scene().game_over()
	
	
func apply_upgrade(modifier: BaseModifierStrategy):
	bullet_modifier_strategies.append(modifier)
