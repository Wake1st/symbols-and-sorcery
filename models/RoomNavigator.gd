class_name RoomNavigator

var rooms:Dictionary = {}


func assign_rooms(nodes:Array[NavigationNode]) -> Dictionary:
	rooms.clear()
	for node in nodes:
		node.connectingRoom = node.connectingScene.instantiate()
		
		var connectingDoor
		match node.direction:
			NavigationNode.DIRECTION.NORTH:
				connectingDoor = node.connectingRoom.navigationNodes[NavigationNode.DIRECTION.SOUTH].door
			NavigationNode.DIRECTION.EAST:
				connectingDoor = node.connectingRoom.navigationNodes[NavigationNode.DIRECTION.WEST].door
			NavigationNode.DIRECTION.SOUTH:
				connectingDoor = node.connectingRoom.navigationNodes[NavigationNode.DIRECTION.NORTH].door
			NavigationNode.DIRECTION.WEST:
				connectingDoor = node.connectingRoom.navigationNodes[NavigationNode.DIRECTION.EAST].door
		
		node.connectionPoint = connectingDoor.position
		
		rooms[node.direction] = node
	return rooms


func get_room(direction:NavigationNode.DIRECTION) -> NavigationNode:
	return rooms[direction]
