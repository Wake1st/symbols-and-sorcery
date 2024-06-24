class_name SpellOrb
extends Node3D

@onready var omniLight:OmniLight3D = %OmniLight
@onready var lightMesh:MeshInstance3D = %LightMesh

var emission_max:float
var colors:Dictionary = {
	Spells.TYPE.LIGHT: "#cbfa9827",
	Spells.TYPE.VOID: "#0f0f0fe6",
	Spells.TYPE.EXOTHERMIC: "#f3ff170f",
	Spells.TYPE.ENDOTHERMIC: "#bdcaff0f",
	Spells.TYPE.EXOROTATION: "#cbfa9827",
	Spells.TYPE.ENDOROTATION: "#cbfa9827",
	Spells.TYPE.EXOVIBRATION: "#cbfa9827",
	Spells.TYPE.ENDOVIBRATION: "#cbfa9827",
}


func change_spell(spell:Spells.TYPE) -> void:
	var color = Color(colors[spell])
	omniLight.light_color = color
	lightMesh.mesh.material.albedo_color = color
	lightMesh.mesh.material.emission = color


func reset(emission:float) -> void:
	emission_max = emission
	omniLight.light_energy = 0
	lightMesh.mesh.material.emission_energy_multiplier = 0


func update(progress:float) -> void:
	omniLight.light_energy = progress
	lightMesh.mesh.material.emission_energy_multiplier = emission_max * progress 
