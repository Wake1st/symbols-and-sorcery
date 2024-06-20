@tool
class_name ItemPickup
extends Node3D

signal picked_up_item(item:Token)

@onready var timer = %Timer
@onready var follower = %Follower
@onready var path = %Path

@export_category("Item Pickup")
@export var pickup_time:float = 1.8

var item:TokenBase
var picking_up:bool = false
var tween:Tween


func pick_up(token:TokenBase) -> void:
	item = token
	path.curve.set_point_position(
		0,
		get_parent_node_3d().global_basis.inverse() * (
			token.global_position - global_position)
	)
	tween = create_tween()
	tween.tween_property(
		item,"global_basis",global_basis,pickup_time
	).set_ease(Tween.EASE_IN_OUT
	).set_trans(Tween.TRANS_QUAD)
	
	if !picking_up:
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
	picked_up_item.emit(item.token)
	
	item.get_parent().remove_child(item)
	item.queue_free()
