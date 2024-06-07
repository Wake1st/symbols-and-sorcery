extends Node3D

signal item_pickup(item:Item)

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
	
	item_pickup.emit("res://items/Scroll.tres")
