extends ColorRect

@onready var runeContainer = %RuneContainer
@onready var optionScene:PackedScene = preload("res://rune_option.tscn")

@export_category("Rune Holder")
@export var runes:Array[RuneData]

var rune_selection_callable:Callable


func setup(selection_callable:Callable):
	rune_selection_callable = selection_callable
	
	for i in runes.size():
		var rune = runes[i]
		var option: RuneOption = optionScene.instantiate()
		
		option.name = "Rune Option -%s-" % rune.name
		option.runeData = rune
		option.icon = rune.texture
		option.rune_selected.connect(rune_selection_callable)
		option.rune_selected.connect(handle_option_selection)
		runeContainer.add_child(option)


func handle_option_selection(_runeData:RuneData) -> void:
	print("TODO: rune holder option selection")
