extends Sprite2D


func _process(_delta):
	var target = Vector2(get_global_mouse_position().x, get_global_mouse_position().y)
	look_at(target)
	# image starts pointing up (not to the right), so we need to offset that
	rotate(PI/2)
