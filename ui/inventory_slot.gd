class_name InventorySlot
extends ColorRect

signal item_selected(item:Item)

@onready var textureRect = $TextureRect

@export_category("Inventory Slot")
@export var item:Item:
	set(value):
		item = value
		textureRect.texture = value.image


func _on_gui_input(event):
	print(event)
