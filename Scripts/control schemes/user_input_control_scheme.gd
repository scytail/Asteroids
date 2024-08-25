class_name UserInputControlScheme
extends BaseControlScheme


func rotate(state: PhysicsDirectBodyState2D, _entity: RigidBody2D):
	var rotation_velocity = 0
	if Input.is_action_pressed("rotate_left"):
		rotation_velocity = -1
	if Input.is_action_pressed("rotate_right"):
		rotation_velocity = 1

	if rotation_velocity != 0:
		rotation_velocity *= rotate_speed * state.step
		
		state.angular_velocity = rotation_velocity
	else:
		state.angular_velocity = 0


func move(_state: PhysicsDirectBodyState2D, entity: RigidBody2D):
	var impulse_strength = 0
	if Input.is_action_pressed("move_forward"):
		impulse_strength += move_speed
	if Input.is_action_pressed("move_backward"):
		impulse_strength -= move_speed
	
	if impulse_strength != 0:
		entity.apply_central_force(Vector2(sin(entity.rotation), -cos(entity.rotation)) * impulse_strength)
	

func should_activate_primary(state: PhysicsDirectBodyState2D):
	return Input.is_action_pressed("shoot") && super.should_activate_primary(state)
