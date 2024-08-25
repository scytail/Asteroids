extends Controllable

@export_group("Player Controls")
@export var bullet_scene: PackedScene

@export_group("Upgrade Modifiers")
var bullet_modifier_strategies: Array[BaseModifierStrategy] = []


func _integrate_forces(state):
	super._integrate_forces(state)


func activate_primary():
	super.activate_primary()
	
	var bullet = bullet_scene.instantiate()
	bullet.position = $BulletSpawnLocation.global_position
	# Start the bullet out pointing in the direction of the ship. It'll handle pointing from there
	bullet.rotation = rotation
	
	# Modify bullet
	for modifier in bullet_modifier_strategies:
		modifier.apply_modifier(bullet)
	
	call_deferred("add_sibling", bullet)


func take_damage():
	super.take_damage()
	get_tree().get_current_scene().game_over()
	
	
func apply_upgrade(modifier: BaseModifierStrategy):
	bullet_modifier_strategies.append(modifier)
