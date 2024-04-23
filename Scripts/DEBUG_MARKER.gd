extends Marker2D


func _draw():
	draw_line(Vector2(200, 0.0), Vector2.ZERO, Color.WHITE, 1.0)
	draw_line(Vector2(-200, 0.0), Vector2.ZERO, Color.WHITE, 1.0)
	draw_line(Vector2(0.0, 200), Vector2.ZERO, Color.WHITE, 1.0)
	draw_line(Vector2(0.0, -200), Vector2.ZERO, Color.WHITE, 1.0)
	
	draw_line(Vector2(150, 150), Vector2.ZERO, Color.RED, 1.0)
	draw_line(Vector2(-150, -150), Vector2.ZERO, Color.RED, 1.0)
	draw_line(Vector2(150, -150), Vector2.ZERO, Color.RED, 1.0)
	draw_line(Vector2(-150, 150), Vector2.ZERO, Color.RED, 1.0)
