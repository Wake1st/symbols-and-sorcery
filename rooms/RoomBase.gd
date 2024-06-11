class_name RoomBase
extends Node3D

signal room_changed(door:Door, room:RoomBase)

@export_category("Room")
@export var northDoor:Door
@export var eastDoor:Door
@export var southDoor:Door
@export var westDoor:Door
