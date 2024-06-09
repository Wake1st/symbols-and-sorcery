extends Node3D

signal room_changed(door:Door)

@onready var southDoor:Door = %SouthDoor
@onready var doors:Array[Door] = [southDoor]
