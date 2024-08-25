class_name StaticDirectionControlScheme
extends BaseControlScheme


func move(_state: PhysicsDirectBodyState2D, entity: RigidBody2D):
	entity.apply_central_impulse(Vector2(sin(entity.rotation), -cos(entity.rotation)) * move_speed)


func rotate(state: PhysicsDirectBodyState2D, entity: RigidBody2D):
	entity.rotation = state.linear_velocity.angle() + PI/2
