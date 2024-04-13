extends InteractiveEntity

@export var max_rotation_velocity: int = 5
@export var point_value: int = 1
@export_range(0,1) var drop_item_chance: float = 1
@export var upgrade_pickup_scene: PackedScene

signal destroyed(point_value)


func _ready():
	super._ready()
	angular_velocity = randi_range(-max_rotation_velocity, max_rotation_velocity)


func _on_body_entered(body):
	if (!body.is_in_group("asteroids") && 
		!body.is_in_group("items")):
		body.take_damage()


func take_damage():
	super.take_damage()
	destroyed.emit(point_value)
	if (_should_drop_item()):
		# Can't instantiate scenes from inside a collision event, so we need to defer the init
		call_deferred("_spawn_scene", upgrade_pickup_scene)


func _should_drop_item():
	var rand_num = randf()
	if rand_num < drop_item_chance:
		return true
	return false


func _spawn_scene(scene: PackedScene):
	var instance = scene.instantiate()
	instance.position = position
	instance.rotation = rotation
	instance.linear_velocity = linear_velocity
	
	add_sibling(instance)
