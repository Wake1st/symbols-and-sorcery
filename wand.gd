extends Node

signal cast_light

var active_spell:Spells.TYPE = Spells.TYPE.LIGHT
var is_casting:bool = false


func spell_finished() -> void:
	is_casting = false


func _process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT
	) && Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT
	) && active_spell == Spells.TYPE.LIGHT && !is_casting:
		_apply_spell()


func _apply_spell() -> void:
	is_casting = true
	cast_light.emit()
