class_name RoomBase
extends Node3D

signal item_pickup(item:Item)
signal location_changed(point:Vector3)
signal room_changed(door:Door)

@export_category("Room")
@export var northDoor:Door
@export var eastDoor:Door
@export var southDoor:Door
@export var westDoor:Door

var doorPoints:Dictionary = {}

var currentNavId:int
var navPoints:Dictionary = {}


func setup(wand:Wand):
	print("ERROR: unhandled 'setup()' in class RoomBase\n",wand)


func get_door_point(door:Door) -> NavPoint:
	var point:NavPoint = doorPoints.get(door)
	
	if point == null:
		print("ERROR: cannot find nav point for door: %s" % door)
	
	return point


func check_selection(result:Dictionary) -> bool:
	var id = result.collider_id
	if id == null:
		return false
	
	if _check_nav_points(id):
		return true
	
	if _check_doors(id):
		return true
	
	return false


func _check_nav_points(id:int) -> bool:
	if currentNavId == null:
		return false
	
	for point_id in navPoints.keys():
		if point_id != currentNavId && point_id == id:
			navPoints[currentNavId].visible = true
			navPoints[point_id].visible = false
			location_changed.emit(navPoints[point_id].global_position)
			currentNavId = point_id
			return true
	return false


func _check_doors(id:int) -> bool:
	for door in doorPoints.keys():
		if id == door.get_instance_id():
			navPoints[currentNavId].visible = true
			room_changed.emit(door)
			return true
	return false
