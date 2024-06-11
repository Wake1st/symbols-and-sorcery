class_name PlayerCamera
extends Node3D

signal entered_room()

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
		print("trav pos: %s" % global_position)
		is_traveling = tween.is_running()
		
		#	single update for finished traveling
		if !is_traveling:
			entered_room.emit()
