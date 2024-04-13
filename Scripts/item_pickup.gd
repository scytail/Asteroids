extends InteractiveEntity


@export var upgrade_type: Enums.upgrade_types


func _on_body_entered(body):
	if body.is_in_group("players"):
		body.apply_upgrade(upgrade_type)
		queue_free()
