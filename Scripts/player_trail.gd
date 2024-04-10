extends Sprite2D


func _ready():
	$DespawnTimer.start()


func _on_despawn_timer_timeout():
	queue_free()
