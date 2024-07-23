class_name BoilerInteractable
extends Interactable

const COOLED_ROUGHNESS:float = 0.4
const HEATED_ROUGHNESS:float = 0.2


func _ready() -> void:
	get_node(meshName).mesh.material.emission_enabled = false
	super()


func _toggle_active() -> void:
	if is_active && is_activating:
		get_tree().create_tween().tween_property(
			get_node(meshName).mesh.material,"roughness",HEATED_ROUGHNESS,activationTime
		).set_ease(Tween.EASE_OUT
		).set_trans(Tween.TRANS_QUAD)
	elif is_active:
		get_node(meshName).mesh.material.roughness = HEATED_ROUGHNESS
	else:
		get_node(meshName).mesh.material.roughness = COOLED_ROUGHNESS


func _highlight_mesh(value:bool) -> void:
	get_node(meshName).mesh.material.emission_enabled = value
