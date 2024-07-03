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
var interactables:Array[Interactable] = []
var tokens:Array[TokenBase] = []

var currentHoverNode:Node3D
var hoverCallables:Array[StringName] = [
	"_highlight_nav_points",
	"_highlight_doors",
	"_highlight_interactables",
	"_highlight_tokens"
]


func setup():
	print("ERROR: unhandled 'setup()' in class RoomBase")


func get_door_point(door:Door) -> NavPoint:
	var point:NavPoint = doorPoints.get(door)
	
	if point == null:
		print("ERROR: cannot find nav point for door: %s" % door)
	
	return point


func highlight_object(id:int) -> void:
	if id == null:
		return
	
	if currentHoverNode != null && id != currentHoverNode.get_instance_id():
		currentHoverNode.highlight = false
	
	var checkedNode:Node3D
	for callable in hoverCallables:
		checkedNode = call(callable,id)
		if checkedNode != null:
			checkedNode.highlight = true
			currentHoverNode = checkedNode
			return
	return

	#
	#
	#checkedNode = _highlight_doors(id)
	#if checkedNode != null:
		#checkedNode.highlight
		#currentHoverNode = checkedNode
		#return
	#
	#checkedNode = _highlight_interactables(id)
	#if checkedNode != null:
		#checkedNode.highlight
		#currentHoverNode = checkedNode
		#return
	#
	#checkedNode = _highlight_tokens(id)
	#if checkedNode != null:
		#checkedNode.highlight
		#currentHoverNode = checkedNode


func _highlight_nav_points(id) -> Node3D:
	if currentNavId == null:
		return null
	
	for point_id in navPoints.keys():
		if point_id != currentNavId && point_id == id:
			return navPoints[point_id]
	return null


func _highlight_doors(id) -> Node3D:
	for door in doorPoints.keys():
		if id == door.get_instance_id():
			return door
	return null


func _highlight_tokens(id:int) -> Node3D:
	for token in tokens:
		if id == token.get_collider_id():
			return token
	return null


func _highlight_interactables(id:int) -> Node3D:
	for interactable in interactables:
		if id == interactable.get_instance_id():
			return interactable
	return null


func check_interactables(spell:Spells.TYPE, collider_id:int) -> void:
	for interactable in interactables:
		if collider_id == interactable.get_instance_id():
			interactable.interact(spell)


func check_selection(result:Dictionary) -> void:
	var id = result.collider_id
	if id == null:
		return
	
	if _check_nav_points(id):
		return
	
	if _check_doors(id):
		return
	
	_check_tokens(id)


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
