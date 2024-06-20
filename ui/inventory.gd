extends Control

@onready var itemContainer = %ItemContainer

var slotScenes:PackedScene = preload("./inventory_slot.tscn")
var selectionCallable:Callable


func setup(selection:Callable) -> void:
	selectionCallable = selection


func add_item(item:Token) -> void:
	var slot:InventorySlot = slotScenes.instantiate()
	
	itemContainer.add_child(slot)
	slot.item = item
	slot.item_selected.connect(selectionCallable)
