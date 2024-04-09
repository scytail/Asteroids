extends InteractiveEntity

@export var max_rotation_velocity = 5


func _ready():
	super._ready()
	angular_velocity = randi_range(-max_rotation_velocity, max_rotation_velocity)


func _on_body_entered(body):
	if (!body.is_in_group("asteroids")):
		body.take_damage()
