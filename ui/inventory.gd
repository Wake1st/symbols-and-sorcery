extends Control

@onready var itemContainer = %ItemContainer

var slotScenes:PackedScene = preload("./inventory_slot.tscn")


func add_item(item:Item) -> void:
	var slot:InventorySlot = slotScenes.instantiate()
	
	if itemContainer.get_child_count() > 0:
		itemContainer.add_spacer(false)
	
	itemContainer.add_child(slot)
	slot.item = item
