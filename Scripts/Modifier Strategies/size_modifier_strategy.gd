class_name SizeModifierStrategy
extends BaseModifierStrategy

@export var size_multiplier: float = 1.1
@export var bullet_scale_limit: Vector2 = Vector2(.1, 3)

func apply_modifier(entity: InteractiveEntity):
	# Scaling a rigidbody is apparently a big no-no in godot. Instead, iterate over the children
	# and scale them all manually, while leaving the main node at a standard scale. Kinda jank.
	for child in entity.get_children():
		if child is Node2D:
			child.scale *= size_multiplier
			var min_scale = Vector2(bullet_scale_limit.x, bullet_scale_limit.x)
			var max_scale = Vector2(bullet_scale_limit.y, bullet_scale_limit.y)
			child.scale = child.scale.clamp(min_scale, max_scale)
