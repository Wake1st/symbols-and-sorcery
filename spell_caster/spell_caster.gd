extends SpellBase

const GAME_WORLD:String = "/root/Game/GameViewportContainer/GameViewport"

@onready var timerOn = %TimerOn
@onready var timerOff = %TimerOff
@onready var spellOrb:SpellOrb = %SpellOrb

@export_category("Spell Caster")
@export var spellTime:float = 0.6
@export var emissionMax:float = 12.0

var turning_on:bool = false
var turning_off:bool = false
var is_stable:bool = false
var spellEndpoint:Vector3


func change_spell(spell:Spells.TYPE) -> void:
	spellOrb.change_spell(spell)
	is_stable = spell == Spells.TYPE.LIGHT


func cast(location:Vector3 = Vector3.ZERO) -> bool:
	spellEndpoint = location
	
	if !is_on:
		turning_on = true
		timerOn.start()
		spellOrb.visible = true
		return true
	else:
		turning_off = true
		timerOff.start()
		return false


func _ready():
	timerOn.wait_time = spellTime
	spellOrb.reset(emissionMax)


func _physics_process(_delta):
	if turning_on:
		var progress = 1.0 - timerOn.time_left/spellTime
		spellOrb.update(progress)
		spellOrb.global_position = lerp(global_position,spellEndpoint,progress)
	if turning_off:
		var progress = timerOff.time_left/spellTime
		spellOrb.update(progress)


func _on_timer_on_timeout():
	turning_on = false
	is_on = !is_on
	
	var location = spellOrb.global_position
	remove_child(spellOrb)
	get_node(GAME_WORLD).add_child(spellOrb)
	spellOrb.global_position = location
	
	finished.emit()
	
	#if !is_stable:
	turning_off = true
	timerOff.start()


func _on_timer_off_timeout():
	turning_off = false
	is_on = !is_on
	spellOrb.visible = false
	
	spellOrb.get_parent().remove_child(spellOrb)
	add_child(spellOrb)
	spellOrb.global_position = global_position
	
	finished.emit()
