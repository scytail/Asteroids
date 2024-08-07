extends Node

var seedValue: int = -1

func _ready():
	# TODO: in the future, we can probably optionally set this via file or something.
	if (seedValue < 0):
		seedValue = randi()
	
	print_debug("Seed has been set to %s" %seedValue)
	seed(seedValue)
