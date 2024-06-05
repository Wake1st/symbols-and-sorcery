extends Node

@onready var runeHolder = %RuneHolder
@onready var token = %Token
@onready var selectedRune = %SelectedRune

var selectedData:RuneData


func _ready():
	runeHolder.setup(handle_rune_selection)


func handle_rune_selection(runeData:RuneData) -> void:
	selectedRune.texture = runeData.rune_texture
	selectedData = runeData


func _input(event):
	if event is InputEventMouseButton && event.is_released():
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT && selectedData != null:
			var engraving: Sprite2D = Sprite2D.new()
			token.add_child(engraving)
			engraving.name = "Engraving -%s-" % selectedData.name
			engraving.texture = selectedData.engraving_texture
			engraving.global_position = selectedRune.global_position
