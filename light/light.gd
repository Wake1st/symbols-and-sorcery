extends SpellBase

const GAME_WORLD:String = "/root/Game/GameViewportContainer/GameViewport"

@onready var timerOn = %TimerOn
@onready var timerOff = %TimerOff
@onready var follower = %Follower
@onready var lightOrb:LightOrb = %LightOrb

@export_category("Light")
@export var spellTime:float = 1.8
@export var emission_max:float = 12.0

var turning_on:bool = false
var turning_off:bool = false


func cast() -> void:
	if !is_on:
		turning_on = true
		timerOn.start()
		lightOrb.visible = true
	else:
		turning_off = true
		timerOff.start()


func _ready():
	timerOn.wait_time = spellTime
	
	follower.progress_ratio = 0
	lightOrb.reset(emission_max)


func _physics_process(_delta):
	if turning_on:
		var progress = 1.0 - timerOn.time_left/spellTime
		follower.progress_ratio = progress
		lightOrb.update(progress)
	if turning_off:
		var progress = timerOff.time_left/spellTime
		lightOrb.update(progress)


func _on_timer_on_timeout():
	turning_on = false
	is_on = !is_on
	
	var location = lightOrb.global_position
	follower.remove_child(lightOrb)
	get_node(GAME_WORLD).add_child(lightOrb)
	lightOrb.global_position = location
	
	finished.emit()


func _on_timer_off_timeout():
	turning_off = false
	is_on = !is_on
	follower.progress_ratio = 0.0
	lightOrb.visible = false
	
	lightOrb.get_parent().remove_child(lightOrb)
	follower.add_child(lightOrb)
	lightOrb.global_position = follower.global_position
	
	finished.emit()
