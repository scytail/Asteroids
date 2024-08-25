extends RigidBody2D

@export var modifier_strategy: BaseModifierStrategy

func _on_body_entered(body):
	if body.is_in_group("players"):
		body.apply_upgrade(modifier_strategy)
		queue_free()
