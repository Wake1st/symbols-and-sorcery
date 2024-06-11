class_name NavigationNode

var current:RoomBase
var north:RoomBase
var east:RoomBase
var south:RoomBase
var west:RoomBase


func _init(connection:ConnectionNode) -> void:
	current = connection.current.instantiate()
	north = connection.north.instantiate()
	east = connection.east.instantiate()
	south = connection.south.instantiate()
	west = connection.west.instantiate()
