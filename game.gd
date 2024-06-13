extends Node

@onready var navigation = %Navigation

@onready var currentRoom:RoomBase = $GameViewportContainer/GameViewport/LightRoom
@onready var playerCamera = %PlayerCamera
@onready var descriptions = %Descriptions
@onready var inventory = %Inventory
@onready var wand = %Wand
@onready var cursor = %Cursor


func _ready() -> void:
	#navigation.setup()
	#setup_rooms(rooms)
	
	#	setup wand
	wand.equipped_wand.connect(cursor.display_wand)
	
	#	setup current room
	currentRoom.setup(wand)
	currentRoom.room_changed.connect(handle_room_change)
	currentRoom.item_pickup.connect(inventory.add_item)
	
	#	setup camera
	playerCamera.entered_room.connect(handle_entered_room)
	playerCamera.selected_attempted.connect(handle_world_selection)
	
	#	setup inventory
	inventory.setup(handle_item_selection)


#func setup_rooms(rooms:Dictionary) -> void:
	#for node:NavigationNode in rooms.values():
		#add_child(node.connectingRoom)
		#node.connectingRoom.global_position = currentRoom.global_position + node.door.position + node.connectionPoint


func handle_room_change(door:Door) -> void:
	#	navigate to new room
	var connectingRoom:RoomBase = door.get_connecting_room(currentRoom)
	playerCamera.go_to(connectingRoom.global_position)
	
	#	deallocate current room data and connections
	currentRoom.room_changed.disconnect(handle_room_change)
	currentRoom.item_pickup.disconnect(inventory.add_item)
	
	#	connect new room connections
	currentRoom = connectingRoom
	currentRoom.setup(wand)
	currentRoom.room_changed.connect(handle_room_change)
	currentRoom.item_pickup.connect(inventory.add_item)

	#var room:Node3D = roomNavigator.get_room(door.direction)
	#roomNavigator.assign_rooms(currentRoom.doors)
	#currentRoom.room_changed.connect(handle_room_change)


func handle_entered_room() -> void:
	print("entered room")


func handle_world_selection(result:Dictionary) -> void:
	currentRoom.check_selection(result)


func handle_item_selection(item:Item) -> void:
	print(item)


func _on_game_viewport_container_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_game_viewport_container_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
