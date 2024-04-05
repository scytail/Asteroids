extends InteractiveEntity

@export var velocity: int = 2000


func _ready():
	super._ready()
	apply_central_impulse(Vector2(sin(rotation), -cos(rotation)) * velocity)


func _check_boundary_collision(state):
	if position.x < 0 || position.x > screen_size.x || position.y < 0 || position.y > screen_size.y:
		queue_free()

func _on_body_entered(body):
	body.take_damage()
