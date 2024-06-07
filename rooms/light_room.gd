extends Node3D

@onready var wand = %Wand
@onready var light = %Light
@onready var scrollPickup = %ScrollPickup
@onready var scroll = %Scroll


func _ready():
	#	setup spell casting
	wand.cast_light.connect(light.cast)
	light.finished.connect(wand.spell_finished)
	
	#	setup interactive mechanics
	scroll.selected.connect(scrollPickup.pick_up)
	scrollPickup.finished.connect(handle_scroll_pickup)


func handle_scroll_pickup() -> void:
	scrollPickup.remove_child(scroll)
	scroll.queue_free()
	
	#	TODO: give scroll to player
