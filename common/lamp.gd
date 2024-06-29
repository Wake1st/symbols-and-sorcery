@tool
class_name Lamp
extends Interactable

@onready var onmiLight = $OmniLight3D
@onready var mesh = $Mesh

@export_category("Lamp")
@export var starts_on:bool = false:
	set(value):
		starts_on = value
		is_on = value

var is_on:bool:
	set(value):
		is_on = value
		get_node("OmniLight3D").light_energy = 0.2 if value else 0.0
		#get_node("Mesh").mesh.emission_energy = 1.01


func _init():
	activationSpell = Spells.TYPE.LIGHT


func _feedback() -> void:
	is_on = true
