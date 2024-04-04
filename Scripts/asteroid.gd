extends RigidBody2D

@export var max_rotation_velocity = 5

var screen_size
# Called when the node enters the scene tree for the first time.


func _ready():
	screen_size = get_viewport_rect().size
#	angular_velocity = randi_range(-max_rotation_velocity, max_rotation_velocity)


func _integrate_forces(state):
	_teleport_ship_on_boundaries(state)


func _teleport_ship_on_boundaries(state):
	if position.x < 0:
		state.transform.origin.x = screen_size.x
	elif position.x > screen_size.x:
		state.transform.origin.x = 0
	if position.y < 0:
		state.transform.origin.y = screen_size.y
	elif position.y > screen_size.y:
		state.transform.origin.y = 0
