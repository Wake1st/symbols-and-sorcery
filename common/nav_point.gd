class_name NavPoint
extends Area3D

@onready var mesh:MeshInstance3D = $Mesh

var highlight:bool = false:
	set(value):
		highlight = value
		get_node("Mesh").mesh.material.set_shader_parameter("highlight", value)
