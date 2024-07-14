class_name FreezeInteractable
extends Interactable

const FREEZING_MESH = preload("./freezing_mesh.tres")
const WATER_COLOR:Color = Color('#0000b328')
const ICE_COLOR:Color = Color('#87e5ff76')
const FREEZE_TIME:float = 2.2;


func _ready() -> void:
	get_node(meshName).mesh = FREEZING_MESH.duplicate(true)
	_toggle_active(is_active)


func _toggle_active(value:bool) -> void:
	if value && is_activating:
		get_tree().create_tween().tween_property(
			get_node(meshName).mesh.material,"albedo_color",ICE_COLOR,FREEZE_TIME
		).set_ease(Tween.EASE_OUT
		).set_trans(Tween.TRANS_QUAD)
	elif value:
		get_node(meshName).mesh.material.albedo_color = ICE_COLOR
	else:
		get_node(meshName).mesh.material.albedo_color = WATER_COLOR


func _highlight_mesh(value:bool) -> void:
	get_node(meshName).mesh.material.emission_enabled = value
