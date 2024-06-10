extends Node

@onready var currentRoom = $GameViewportContainer/GameViewport/LightRoom
@onready var playerCamera = %PlayerCamera
@onready var descriptions = %Descriptions
@onready var inventory = %Inventory

var roomNavigator:RoomNavigator


func _ready() -> void:
	#	setup navigation
	roomNavigator = RoomNavigator.new()
	var rooms = roomNavigator.assign_rooms(currentRoom.doors)
	setup_rooms(rooms)
	
	currentRoom.playerCamera = playerCamera
	currentRoom.room_changed.connect(handle_room_change)
	playerCamera.entered_room.connect(handle_entered_room)
	
	#	setup inventory
	currentRoom.item_pickup.connect(inventory.add_item)
	inventory.setup(handle_item_selection)


func setup_rooms(rooms:Dictionary) -> void:
	for node:NavigationNode in rooms.values():
		add_child(node.connectingRoom)
		node.connectingRoom.global_position = currentRoom.global_position + node.door.position + node.connectionPoint


func handle_room_change(door:Door) -> void:
	pass
	#var room:Node3D = roomNavigator.get_room(door.direction)
	#playerCamera.go_to(room.global_position)
	#
	#currentRoom = room
	#roomNavigator.assign_rooms(currentRoom.doors)
	#currentRoom.room_changed.connect(handle_room_change)


func handle_entered_room() -> void:
	print("entered room")


func handle_item_selection(item:Item):
	print(item)


func _on_game_viewport_container_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_game_viewport_container_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
