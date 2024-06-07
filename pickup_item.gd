extends Node3D

signal finished()

@onready var timer = %Timer
@onready var follower = %Follower

@export_category("Pickup Item")
@export var pickup_time:float = 1.8
@export var item:Node3D

var picking_up:bool = false
var picked_up:bool = false


func pick_up() -> void:
	if !picked_up:
		picking_up = true
		timer.start()


func _ready():
	timer.wait_time = pickup_time
	follower.progress_ratio = 0


func _physics_process(_delta):
	if picking_up:
		var progress = 1.0 - timer.time_left/pickup_time
		follower.progress_ratio = progress
		item.global_position = follower.global_position


func _on_timer_timeout():
	picking_up = false
	picked_up = true
	finished.emit()
