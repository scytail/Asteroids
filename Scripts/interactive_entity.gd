extends RigidBody2D

class_name InteractiveEntity

@export var max_speed = 1000

var screen_size;


func _ready():
	screen_size = get_viewport_rect().size


func _integrate_forces(state):
	_check_boundary_collision(state)
	_set_max_speed(state)


func _check_boundary_collision(state):
	if position.x < 0:
		state.transform.origin.x = screen_size.x
	elif position.x > screen_size.x:
		state.transform.origin.x = 0
	if position.y < 0:
		state.transform.origin.y = screen_size.y
	elif position.y > screen_size.y:
		state.transform.origin.y = 0



func _set_max_speed(state):
	state.linear_velocity.x = clamp(state.linear_velocity.x, -max_speed, max_speed)
	state.linear_velocity.y = clamp(state.linear_velocity.y, -max_speed, max_speed)


func take_damage():
	queue_free()
