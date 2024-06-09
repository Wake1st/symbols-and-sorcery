extends Node3D

signal room_changed(door:Door)
signal item_pickup(item:Item)

const RAY_LENGTH = 1000
const SCROLL = preload("res://items/scroll.tres")

@onready var wand = %Wand
@onready var light = %Light
@onready var scrollPickup = %ScrollPickup
@onready var scroll = %Scroll
@onready var northDoor:Door = %NorthDoor
@onready var doors:Array[Door] = [northDoor]

var playerCamera:PlayerCamera


func _ready():
	#	setup spell casting
	wand.cast_light.connect(light.cast)
	light.finished.connect(wand.spell_finished)
	
	#	setup interactive mechanics
	scrollPickup.finished.connect(handle_scroll_pickup)


func _physics_process(_delta):
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	
	var origin = playerCamera.project_ray_origin(mousepos)
	var end = origin + playerCamera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	if !result.is_empty():
		if result.collider_id == northDoor.get_instance_id():
			room_changed.emit(northDoor)
		if scroll != null && result.collider_id == scroll.get_instance_id():
			scrollPickup.pick_up()


func handle_scroll_pickup() -> void:
	item_pickup.emit(SCROLL)
	
	scrollPickup.remove_child(scroll)
	scroll.queue_free()
