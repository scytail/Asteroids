extends Node

## The general room options to place in the world
@export var roomGroups: Array[RoomGroup]
## points of interest that should be placed in a more specified location, but only once
@export var POIRoomGroups: Array[POIRoomGroup]
## Control options for the grid to build
@export var grid: TileGrid

func generateTiles():
	# randomize POI locations before we can generate tiles
	_generatePOILocations()
	
	# first pass: general room layout
	for x in range(0, grid.gridDimensions.x):
		for y in range(0, grid.gridDimensions.y):
			var placementTile = Vector2i(x,y)
			
			# find the room to place
			var selectedRoom: PackedScene = _selectPOIRoom(placementTile)
			if (selectedRoom == null):
				selectedRoom = _selectGeneralRoom(placementTile)
				
			if (selectedRoom != null):
				_spawnRoom(selectedRoom, placementTile)

func _selectGeneralRoom(placementTile: Vector2i) -> PackedScene:
	var distanceFromCenter: float = _straightLineDistance(grid.calculateGridCenterTile(), placementTile)
	for roomGroup: RoomGroup in roomGroups:
		if (roomGroup.radiusRange.x <= distanceFromCenter && roomGroup.radiusRange.y > distanceFromCenter):
			return roomGroup.selectRoom()
	return null

func _selectPOIRoom(placementTile: Vector2i) -> PackedScene:
	for roomGroup: POIRoomGroup in POIRoomGroups:
		# spawn tiles for POIs are not offset to orient for the center of the grid, 
		# so we need to do that ourselves
		if roomGroup.spawnTileLocation + grid.calculateGridCenterTile() == placementTile:
			return roomGroup.selectRoom()
	return null

func _spawnRoom(room: PackedScene, topLeftTileCoordinate: Vector2i):
	var roomInstance: Node = room.instantiate()
	roomInstance.position = topLeftTileCoordinate * grid.tileSize
	# TODO: rotate room
	add_sibling(roomInstance)

func _straightLineDistance(point1: Vector2, point2: Vector2) -> float:
	var a = point2.x-point1.x
	var b = point2.y-point1.y
	
	return sqrt((a*a)+(b*b))

func _generatePOILocations():
	for roomGroup: POIRoomGroup in POIRoomGroups:
		roomGroup.spawnTileLocation = roomGroup.generateOriginLocation()
