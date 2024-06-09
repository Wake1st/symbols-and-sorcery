class_name RoomNavigator

var rooms:Dictionary = {}


func assign_rooms(doors:Array[Door]) -> Dictionary:
	rooms.clear()
	for door in doors:
		rooms[door.direction] = door.connecting_room.instantiate()
	return rooms


func get_room(direction:Door.DIRECTION) -> Node3D:
	return rooms[direction]
