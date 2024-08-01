class_name TileGrid
extends Resource

# The size of a tile in Godot units
@export var tileSize: int = 1024
@export var gridDimensions: Vector2i = Vector2i(1,1)

func calculateGridCenterTile() -> Vector2i:
	#@warning_ignore("integer_division")
	var centerX = floori(gridDimensions.x/2.0)
	#@warning_ignore("integer_division")
	var centerY = floori(gridDimensions.y/2.0)
	return Vector2i(centerX, centerY)

func tileCoordinatesToGodotUnits(tileCoordinates: Vector2i) -> Vector2:
	return tileCoordinates * tileSize
