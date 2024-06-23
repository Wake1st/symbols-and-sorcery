class_name InventorySlot
extends ColorRect

signal item_selected(item:Token)
signal slot_selected(slot:InventorySlot)

@onready var textureRect = $TextureRect

@export_category("Inventory Slot")
@export var item:Token:
	set(value):
		item = value
		textureRect.texture = value.image


func _on_gui_input(event):
	if event is InputEventMouseButton && (
	event.button_index == MOUSE_BUTTON_LEFT) && (
	event.is_released()):
		item_selected.emit(item)
		slot_selected.emit(self)
