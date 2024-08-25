class_name Bullet
extends Controllable


func _integrate_forces(state):
	super._integrate_forces(state)


func _on_body_entered(body):
	body.take_damage()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
