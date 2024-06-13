class_name RoomBase
extends Node3D

signal room_changed(door:Door)
signal item_pickup(item:Item)

@export_category("Room")
@export var wand:Wand
@export var northDoor:Door
@export var eastDoor:Door
@export var southDoor:Door
@export var westDoor:Door


func setup(wand:Wand):
	print("ERROR: unhandled 'setup()' in class RoomBase\n",wand)


func check_selection(result:Dictionary) -> void:
	print("ERROR: Unhandled 'check_selction()' in class RoomBase\n",result)
