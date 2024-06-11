extends Node

@onready var navigation = %Navigation

@onready var currentRoom = $GameViewportContainer/GameViewport/LightRoom
@onready var playerCamera = %PlayerCamera
@onready var descriptions = %Descriptions
@onready var inventory = %Inventory


func _ready() -> void:
	#	setup navigation
	#navigation.setup()
	#setup_rooms(rooms)
	
	currentRoom.playerCamera = playerCamera.camera
	currentRoom.room_changed.connect(handle_room_change)
	playerCamera.entered_room.connect(handle_entered_room)
	
	#	setup inventory
	currentRoom.item_pickup.connect(inventory.add_item)
	inventory.setup(handle_item_selection)


#func setup_rooms(rooms:Dictionary) -> void:
	#for node:NavigationNode in rooms.values():
		#add_child(node.connectingRoom)
		#node.connectingRoom.global_position = currentRoom.global_position + node.door.position + node.connectionPoint


func handle_room_change(door:Door, room:RoomBase) -> void:
	var connectingRoom:RoomBase = door.get_connecting_room(room)
	playerCamera.go_to(connectingRoom.global_position)
	
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
