class_name PlayerCamera
extends Node3D

signal entered_room()
signal selected_attempted(result:Dictionary)

const RAY_LENGTH = 1000

@export_category("Player Camera")
@export var travel_time:float = 3.2

@onready var camera = $Camera

var is_traveling:bool = false
var tween:Tween


func go_to(coord:Vector3) -> void:
	if !is_traveling:
		is_traveling = true
		
		print("init pos: %s" % global_position)
		tween = create_tween()
		tween.tween_property(self, "global_position", coord, travel_time
		).set_ease(Tween.EASE_IN_OUT
		).set_trans(Tween.TRANS_QUAD)


func _physics_process(_delta):
	if is_traveling:
		is_traveling = tween.is_running()
		
		#	single update for finished traveling
		if !is_traveling:
			entered_room.emit()
	
	if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	
	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	if !result.is_empty():
		selected_attempted.emit(result)
