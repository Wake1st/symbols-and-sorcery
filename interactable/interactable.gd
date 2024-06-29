class_name Interactable
extends StaticBody3D

signal activated()

@export_category("Interactable")
@export var activationSpell:Spells.TYPE


func interact(spell:Spells.TYPE) -> void:
	if spell == activationSpell:
		#	show a change
		print("%s activated by %s" % [name, spell])
		_feedback()
		
		#	notify the change worked
		activated.emit()


func _feedback() -> void:
	pass
