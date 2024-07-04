class_name Door
extends Area3D

const LOCKED_VFX_TIME:float = 0.8;
const UNLOCK_VFX_TIME:float = 1.2;
const LOCKED_VFX_COLOR:Color = Color(0.9,0.0,0.3)
const UNLOCK_VFX_COLOR:Color = Color(0.3,0.0,0.5)
const LOCKED_WAV = preload("res://assets/audio/door_locked.wav")
const UNLOCK_WAV = preload("res://assets/audio/door_unlock.wav")

@onready var lock = $Lock
@onready var lockTimer = $Lock/LockTimer
@onready var lockSFX:AudioStreamPlayer3D = $Lock/LockSFX

@export_category("Door")
@export var room1:RoomBase
@export var room2:RoomBase
@export var startLocked:bool = true:
	set(value):
		startLocked = value
		locked = value

var locked:bool = true

var highlight:bool = false:
	set(value):
		highlight = value
		get_node("Mesh").mesh.material.emission_enabled = value


func unlock() -> void:
	#	do not replay fx if unlocked
	if !locked:
		return
	
	locked = false
	
	#	play vfx, sfx
	print("door %s -> unlocked" % name)
	lock.mesh.material.set_shader_parameter("color", UNLOCK_VFX_COLOR)
	lockSFX.stream = UNLOCK_WAV
	lockTimer.start(UNLOCK_WAV.get_length())
	lockSFX.play()


func check_unlocked() -> bool:
	if locked:
		#	play vfx, sfx
		print("door %s is locked" % name)
		highlight = false
		lock.mesh.material.set_shader_parameter("color", LOCKED_VFX_COLOR)
		lockTimer.start(LOCKED_WAV.get_length())
		lockSFX.play()
	
	return !locked


func get_connecting_room(currentRoom:RoomBase) -> RoomBase:
	if currentRoom == room1:
		return room2
	elif currentRoom == room2:
		return room1
	else:
		return null


func _physics_process(_delta):
	if !lockTimer.is_stopped():
		var time_ratio = 1.0 - lockTimer.time_left / lockTimer.wait_time
		lock.mesh.material.set_shader_parameter("hit_time_ratio", time_ratio)
		lock.mesh.material.set_shader_parameter("hit", true)


func _on_lock_timer_timeout():
	lock.mesh.material.set_shader_parameter("hit", false)
