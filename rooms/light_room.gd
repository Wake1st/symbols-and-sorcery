extends Node3D

@onready var wand = %Wand
@onready var light = %Light


func _ready():
	wand.cast_light.connect(light.cast)
	light.finished.connect(wand.spell_finished)
