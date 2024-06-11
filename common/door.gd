class_name Door
extends StaticBody3D

@export_category("Door")
@export var room1:RoomBase
@export var room2:RoomBase


func get_connecting_room(currentRoom:RoomBase) -> RoomBase:
	if currentRoom == room1:
		return room2
	elif currentRoom == room2:
		return room1
	else:
		return null
