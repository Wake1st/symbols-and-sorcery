extends Node

@onready var runeHolder = %RuneHolder


func _ready():
	runeHolder.setup(handle_rune_selection)


func handle_rune_selection(runeData:RuneData) -> void:
	print("rune %s selected" % runeData.name)
