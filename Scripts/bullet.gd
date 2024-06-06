class_name Bullet
extends InteractiveEntity


func _ready():
	super._ready()
	apply_central_impulse(Vector2(sin(rotation), -cos(rotation)) * max_speed)


func _integrate_forces(state):
	# Point the bullet in the direction it's moving
	rotation = state.linear_velocity.angle() + PI/2
	pass


func _check_boundary_collision(_state):
	if position.x < 0 || position.x > screen_size.x || position.y < 0 || position.y > screen_size.y:
		queue_free()


func _on_body_entered(body):
	body.take_damage()
