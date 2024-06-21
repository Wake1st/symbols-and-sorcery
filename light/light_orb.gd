class_name LightOrb
extends Node3D

@onready var omniLight = %OmniLight
@onready var lightMesh = %LightMesh

var emission_max:float


func reset(emission:float) -> void:
	emission_max = emission
	omniLight.light_energy = 0
	lightMesh.mesh.material.emission_energy_multiplier = 0


func update(progress:float) -> void:
	omniLight.light_energy = progress
	lightMesh.mesh.material.emission_energy_multiplier = emission_max * progress 
