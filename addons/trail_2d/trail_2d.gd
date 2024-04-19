extends Line2D

@export_category('Trail')
@export var length : = 10

@onready var parent : Node2D = get_parent()
var offset : = Vector2.ZERO

func _ready() -> void:
	offset = position
	top_level = true
	
	# scale the trail by the parent node's scale
	width *= parent.scale.x
	length *= parent.scale.y

func _physics_process(_delta: float) -> void:
	global_position = Vector2.ZERO

	var point : = parent.global_position + offset
	add_point(point, 0)
	
	if get_point_count() > length:
		remove_point(get_point_count() - 1)

