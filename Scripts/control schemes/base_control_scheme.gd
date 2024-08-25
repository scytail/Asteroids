class_name BaseControlScheme
extends Resource


## The linear speed to apply to a Controllable object
@export var move_speed: float = 0.0
## The rotational speed to apply to a Controllable object
@export var rotate_speed: float = 0.0
## The cooldown (in milliseconds) of activating the primary ability
@export var primary_cooldown: float = 0.0

var _last_timestamp_activated_primary: float = -INF


func rotate(_state: PhysicsDirectBodyState2D, _entity: RigidBody2D):
	pass


func move(_state: PhysicsDirectBodyState2D, _entity: RigidBody2D):
	pass
	

func should_activate_primary(_state: PhysicsDirectBodyState2D) -> bool:
	if (Time.get_ticks_msec() - _last_timestamp_activated_primary > primary_cooldown):
		_last_timestamp_activated_primary = Time.get_ticks_msec()
		return true
	return false
