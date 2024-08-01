class_name RoomGroup
extends Resource

## the start/end of the radius area where this room group will be applied
@export var radiusRange: Vector2i

## An unordered list of rooms available to select from
@export var roomOptions: Array[PackedScene]


## Picks a room from the set room options
func selectRoom() -> PackedScene:
	if (roomOptions == null || roomOptions.size() == 0):
		push_error("Room options cannot be empty.")
		return null
		
	var selectedRoomIndex = randi_range(0, roomOptions.size()-1)
	
	return roomOptions[selectedRoomIndex]
