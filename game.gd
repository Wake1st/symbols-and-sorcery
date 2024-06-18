extends Node

@onready var navigation = %Navigation

@onready var startRoom:RoomBase = $GameViewportContainer/GameViewport/LightRoom
@onready var playerCamera = %PlayerCamera
@onready var descriptions = %Descriptions
@onready var inventory = %Inventory
@onready var wand = %Wand
@onready var cursor = %Cursor

var currentRoom:RoomBase


func _ready() -> void:
	#	setup wand
	wand.equipped_wand.connect(cursor.display_wand)
	
	#	setup current room
	_setup_current_room(startRoom)
	
	#	setup camera
	playerCamera.entered_room.connect(handle_entered_room)
	playerCamera.selected_attempted.connect(handle_world_selection)
	
	#	setup inventory
	inventory.setup(handle_item_selection)


func _setup_current_room(room:RoomBase) -> void:
	currentRoom = room
	room.setup(wand)
	room.location_changed.connect(handle_location_changed)
	room.room_changed.connect(handle_room_change)
	room.item_pickup.connect(inventory.add_item)


func handle_location_changed(point:NavPoint) -> void:
	playerCamera.go_to(point)


func handle_room_change(door:Door) -> void:
	#	get new room
	var connectingRoom:RoomBase = door.get_connecting_room(currentRoom)

	#	deallocate current room data and connections
	currentRoom.location_changed.disconnect(handle_location_changed)
	currentRoom.room_changed.disconnect(handle_room_change)
	currentRoom.item_pickup.disconnect(inventory.add_item)
	
	#	connect new room connections
	_setup_current_room(connectingRoom)
	
	#	navigation to new room
	var point:NavPoint = connectingRoom.get_door_point(door)
	playerCamera.go_to(point)


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
