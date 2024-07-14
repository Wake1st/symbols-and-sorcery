@tool
class_name Lamp
extends Interactable

const NORMAL_COLOR:Color = Color("#cbfa98")
const HIGHLIGHT_COLOR:Color = Color("#f1fde6")

@onready var onmiLight = $OmniLight3D
@onready var mesh = $Mesh


func _init():
	activationSpell = Spells.TYPE.LIGHT


func _toggle_active() -> void:
	if is_active && is_activating:
		get_tree().create_tween().tween_property(
			get_node("OmniLight3D"),"light_energy",0.2,activationTime
		).set_ease(Tween.EASE_OUT
		).set_trans(Tween.TRANS_QUAD)
	elif is_active:
		get_node("OmniLight3D").light_energy = 0.2
	else:
		get_node("OmniLight3D").light_energy = 0.0


func _highlight_mesh(value:bool) -> void:
	if value:
		get_node("Mesh").mesh.material.emission = HIGHLIGHT_COLOR
	else:
		get_node("Mesh").mesh.material.emission = NORMAL_COLOR
