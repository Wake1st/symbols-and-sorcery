class_name Interactable
extends StaticBody3D

signal activated()

@export_category("Interactable")
@export var activationSpell:Spells.TYPE
@export var meshName:String
@export var is_active:bool = false:
	set(value):
		is_active = value
		_toggle_active(value)

var is_activating:bool = false
var highlight:bool = false:
	set(value):
		highlight = value
		_highlight_mesh(value)


func interact(spell:Spells.TYPE) -> void:
	if spell == activationSpell:
		#	show a change
		is_active = true
		is_activating = true
		
		#	notify the change worked
		activated.emit()


func _toggle_active(_value:bool) -> void:
	pass


func _highlight_mesh(value:bool) -> void:
	get_node(meshName).mesh.material.emission_enabled = value
