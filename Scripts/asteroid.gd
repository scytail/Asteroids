extends InteractiveEntity

@export var max_rotation_velocity = 5
@export var point_value = 1


func _ready():
	super._ready()
	angular_velocity = randi_range(-max_rotation_velocity, max_rotation_velocity)


func _on_body_entered(body):
	if (!body.is_in_group("asteroids")):
		body.take_damage()


func take_damage():
	super.take_damage()
	get_tree().get_current_scene().add_points(point_value)
