class_name Door
extends Area3D

@export_category("Door")
@export var room1:RoomBase
@export var room2:RoomBase
@export var startLocked:bool = true:
	set(value):
		startLocked = value
		locked = value

var locked:bool = true


func unlock() -> void:
	#	do not replay fx if unlocked
	if !locked:
		return
	
	locked = false
	
	#	play fx
	print("door %s -> unlocked" % name)


func check_unlocked() -> bool:
	if locked:
		#	play some vfx, sfx
		print("door %s is locked" % name)
		pass
	
	return !locked


func get_connecting_room(currentRoom:RoomBase) -> RoomBase:
	if currentRoom == room1:
		return room2
	elif currentRoom == room2:
		return room1
	else:
		return null
