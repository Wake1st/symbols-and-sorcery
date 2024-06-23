class_name Inventory
extends Control

const INACTIVE_COLOR:Color = Color("#1e5a5e")
const ACTIVE_COLOR:Color = Color("#d1e6f8")

@onready var itemContainer = %ItemContainer

var slotScenes:PackedScene = preload("./inventory_slot.tscn")
var selectionCallable:Callable
var activeContainer:InventorySlot


func setup(selection:Callable) -> void:
	selectionCallable = selection


func add_item(item:Token) -> void:
	var slot:InventorySlot = slotScenes.instantiate()
	
	itemContainer.add_child(slot)
	slot.item = item
	slot.item_selected.connect(selectionCallable)
	slot.slot_selected.connect(handle_slot_selection)


func handle_slot_selection(slot:InventorySlot) -> void:
	activeContainer.color = INACTIVE_COLOR
	activeContainer = slot
	activeContainer.color = ACTIVE_COLOR


func _ready():
	activeContainer = InventorySlot.new()
