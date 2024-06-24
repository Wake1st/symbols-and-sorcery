class_name SpellBase
extends Node3D

signal finished

var is_on:bool = false


func cast(_location:Vector3 = Vector3.ZERO) -> void:
	print("ERROR: unhandled method 'cast()' in class 'SpellBase'")
