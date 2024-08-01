class_name POIRoomGroup
extends RoomGroup

var spawnTileLocation: Vector2i

## Finds the origin coordinate for the POI to spawn
func generateOriginLocation() -> Vector2:
	var radiusDistance = randi_range(radiusRange.x, radiusRange.y)
	var circleAngle = randf_range(0,2*PI)
	var coords = Vector2(cos(circleAngle), sin(circleAngle))
	return coords * radiusDistance
