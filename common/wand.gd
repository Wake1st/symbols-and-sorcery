class_name Wand
extends Node

signal cast_light
signal equipped_wand(is_equipped:bool)

var active_spell:Spells.TYPE = Spells.TYPE.LIGHT
var is_equipped:bool = false
var is_casting:bool = false


func spell_finished() -> void:
	is_casting = false


func _physics_process(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT
	) && active_spell == Spells.TYPE.LIGHT && (
	is_equipped && !is_casting):
		_apply_spell()


func _input(_event):
	#	switch iteraction modes
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP) || (
	Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN)):
		is_equipped = !is_equipped
		equipped_wand.emit(is_equipped)


func _apply_spell() -> void:
	is_casting = true
	cast_light.emit()
