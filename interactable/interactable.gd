class_name Interactable
extends StaticBody3D

signal activated()


@export_category("Interactable")
@export var activationSpell:Spells.TYPE
@export var meshName:String
@export var is_active:bool = false
@export var activationTime:float = 0.1

var activationTimer:Timer
var is_activating:bool = false
var highlight:bool = false:
	set(value):
		highlight = value
		_highlight_mesh(value)


func _ready():
	activationTimer = Timer.new()
	activationTimer.one_shot = true
	activationTimer.timeout.connect(_on_activation_timer_timeout)
	add_child(activationTimer)
	_toggle_active()


func interact(spell:Spells.TYPE) -> void:
	if spell == activationSpell:
		#	show a change
		is_active = true
		is_activating = true
		activationTimer.start(activationTime)
		_toggle_active()


func _toggle_active() -> void:
	pass


func _highlight_mesh(value:bool) -> void:
	get_node(meshName).mesh.material.emission_enabled = value


func _on_activation_timer_timeout():
	is_activating = false
	
	#	notify the change worked
	activated.emit()
