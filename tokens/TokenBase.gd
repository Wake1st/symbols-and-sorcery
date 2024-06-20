class_name TokenBase
extends Node3D

@export_category("Token Base")
@export var token:Token

@onready var staticBody3d = %StaticBody3D


func get_collider_id() -> int:
	return staticBody3d.get_instance_id()
