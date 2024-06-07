extends Node

@onready var light_room = %LightRoom
@onready var descriptions = %Descriptions
@onready var inventory = %Inventory


func _ready() -> void:
	light_room.item_pickup.connect(inventory.add_item)
	inventory.setup(handle_item_selection)


func handle_item_selection(item:Item):
	print(item)


func _on_game_viewport_container_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_game_viewport_container_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
