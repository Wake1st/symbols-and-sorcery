extends Node3D

signal finished

@onready var timerOn = %TimerOn
@onready var timerOff = %TimerOff
@onready var follower = %Follower
@onready var light = %Light
@onready var lightOrb = %LightOrb

@export_category("Light")
@export var spellTime:float = 1.8
@export var emission_max:float = 12.0

var turning_on:bool = false
var turning_off:bool = false
var is_on:bool = false


func cast() -> void:
	if !is_on:
		turning_on = true
		timerOn.start()
	else:
		turning_off = true
		timerOff.start()


func _ready():
	timerOn.wait_time = spellTime
	
	follower.progress_ratio = 0
	light.light_energy = 0
	lightOrb.mesh.material.emission_energy_multiplier = 0


func _physics_process(_delta):
	if turning_on:
		var progress = 1.0 - timerOn.time_left/spellTime
		follower.progress_ratio = progress
		light.light_energy = progress
		lightOrb.mesh.material.emission_energy_multiplier = emission_max * progress
	if turning_off:
		var progress = timerOff.time_left/spellTime
		light.light_energy = progress
		lightOrb.mesh.material.emission_energy_multiplier = emission_max * progress


func _on_timer_on_timeout():
	turning_on = false
	is_on = !is_on
	finished.emit()


func _on_timer_off_timeout():
	turning_off = false
	is_on = !is_on
	finished.emit()
