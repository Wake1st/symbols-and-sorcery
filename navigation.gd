class_name Navigation
extends Node

const DISTANCE_FROM_DOOR:float = 0.8

@export_category("Navigation")
@export var startingNode:RoomBase
@export var connectionNodes:Array[ConnectionNode]

var navigationNodes:Array[NavigationNode]
var currentNode: NavigationNode


func setup() -> void:
	for connection in connectionNodes:
		navigationNodes.append(NavigationNode.new(connection))


static func get_navigation_point(door:Vector3, room:Vector3) -> Vector3:
	return door + DISTANCE_FROM_DOOR * (room - door).normalized()


func get_current_neighbors() -> Array[NavigationNode]:
	var neighbors:Array[NavigationNode] = []
	
	if currentNode.north != null:
		neighbors.append(currentNode.north)
	
	if currentNode.east != null:
		neighbors.append(currentNode.east)
	
	if currentNode.south != null:
		neighbors.append(currentNode.south)
	
	if currentNode.west != null:
		neighbors.append(currentNode.west)
	
	return neighbors
