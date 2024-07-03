class_name Interactable
extends StaticBody3D

signal activated()

@export_category("Interactable")
@export var activationSpell:Spells.TYPE

var highlight:bool = false:
	set(value):
		highlight = value
		_highlight_mesh(value)


func interact(spell:Spells.TYPE) -> void:
	if spell == activationSpell:
		#	show a change
		print("%s activated by %s" % [name, spell])
		_feedback()
		
		#	notify the change worked
		activated.emit()


func _feedback() -> void:
	pass


func _highlight_mesh(value:bool) -> void:
	get_node("Mesh").mesh.material.emission_enabled = value
