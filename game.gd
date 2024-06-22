extends Node

@onready var navigation = %Navigation

@onready var startRoom:RoomBase = $GameViewportContainer/GameViewport/LightRoom
@onready var player:Player = %Player
@onready var descriptions = %Descriptions
@onready var inventory = %Inventory
@onready var cursor = %Cursor

var currentRoom:RoomBase


func _ready() -> void:
	#	setup current room
	_setup_current_room(startRoom)
	
	#	setup player signals
	player.entered_room.connect(handle_entered_room)
	player.selection_attempted.connect(handle_world_selection)
	player.itemPickup.picked_up_item.connect(inventory.add_item)
	player.wand.equipped_wand.connect(cursor.display_wand)
	
	#	setup inventory signals
	inventory.setup(handle_item_selection)


func _setup_current_room(room:RoomBase) -> void:
	currentRoom = room
	room.setup()
	room.location_changed.connect(handle_location_changed)
	room.room_changed.connect(handle_room_change)
	room.item_selected.connect(handle_item_pickup)


func handle_location_changed(point:NavPoint) -> void:
	player.go_to(point)


func handle_room_change(door:Door) -> void:
	#	get new room
	var connectingRoom:RoomBase = door.get_connecting_room(currentRoom)

	#	deallocate current room data and connections
	currentRoom.location_changed.disconnect(handle_location_changed)
	currentRoom.room_changed.disconnect(handle_room_change)
	currentRoom.item_selected.disconnect(handle_item_pickup)
	
	#	connect new room connections
	_setup_current_room(connectingRoom)
	
	#	navigation to new room
	var point:NavPoint = connectingRoom.get_door_point(door)
	player.go_to(point)


func handle_entered_room() -> void:
	pass
	#	TODO: some description about the room entered


func handle_world_selection(result:Dictionary) -> void:
	currentRoom.check_selection(result)


func handle_item_pickup(item:TokenBase) -> void:
	player.pick_up(item)


func handle_item_selection(item:Token) -> void:
	player.arm_spell(item.spell)


func _on_game_viewport_container_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_game_viewport_container_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
