class_name Controllable
extends RigidBody2D


@export var control_scheme: BaseControlScheme


func _integrate_forces(state: PhysicsDirectBodyState2D):
	if (control_scheme):
		control_scheme.move(state, self)
		control_scheme.rotate(state, self)
		if (control_scheme.should_activate_primary(state)):
			activate_primary()


func activate_primary():
	pass


func take_damage():
	queue_free()
