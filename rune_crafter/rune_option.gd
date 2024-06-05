class_name RuneOption
extends Button

signal rune_selected(runeData:RuneData)

var runeData: RuneData


func _on_pressed():
	rune_selected.emit(runeData)
