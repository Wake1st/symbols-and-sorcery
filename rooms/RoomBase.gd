class_name RoomBase
extends Node3D

signal item_selected(item:TokenBase)
signal location_changed(point:NavPoint)
signal room_changed(door:Door)

@export_category("Room")
@export var northDoor:Door
@export var eastDoor:Door
@export var southDoor:Door
@export var westDoor:Door

var currentNavId:int
var navPoints:Dictionary = {}
var doorPoints:Dictionary = {}
var doorLocks:Array[Interactable] = []
var tokens:Array[TokenBase] = []


func setup():
	print("ERROR: unhandled 'setup()' in class RoomBase")


func get_door_point(door:Door) -> NavPoint:
	var point:NavPoint = doorPoints.get(door)
	
	if point == null:
		print("ERROR: cannot find nav point for door: %s" % door)
	
	return point


func check_selection(result:Dictionary) -> void:
	var id = result.collider_id
	if id == null:
		return
	
	if _check_nav_points(id):
		return
	
	if _check_doors(id):
		return
	
	if _check_tokens(id):
		return


func check_interactables(spell:Spells.TYPE, collider_id:int) -> void:
	for lock in doorLocks:
		if collider_id == lock.get_instance_id():
			lock.interact(spell)


func _check_nav_points(id:int) -> bool:
	if currentNavId == null:
		return false
	
	for point_id in navPoints.keys():
		if point_id != currentNavId && point_id == id:
			navPoints[currentNavId].visible = true
			navPoints[point_id].visible = false
			location_changed.emit(navPoints[point_id])
			currentNavId = point_id
			return true
	return false


func _check_doors(id:int) -> bool:
	for door in doorPoints.keys():
		if id == door.get_instance_id() && door.check_unlocked():
			navPoints[currentNavId].visible = true
			room_changed.emit(door)
			return true
	return false


func _check_tokens(id:int) -> bool:
	for token in tokens:
		if id == token.get_collider_id():
			tokens.erase(token)
			item_selected.emit(token)
			return true
	return false
