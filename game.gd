extends Node

@onready var navigation = %Navigation

@onready var startRoom:RoomBase = $GameViewportContainer/GameViewport/LightRoom
@onready var player:Player = %Player
@onready var naration:Naration = %Naration
@onready var inventory = %Inventory
@onready var cursor = %Cursor

var currentRoom:RoomBase


func _ready() -> void:
	#	setup naration
	Descriptions.load()
	
	#	setup current room
	_setup_current_room(startRoom)
	
	#	setup player signals
	player.entered_room.connect(handle_entered_room)
	player.hovered_over.connect(handle_hover_over)
	player.selection_attempted.connect(handle_world_selection)
	player.spell_cast.connect(handle_spell_cast)
	player.itemPickup.picked_up_item.connect(inventory.add_item)
	player.wand.equipped_wand.connect(cursor.display_wand)
	
	#	setup inventory signals
	inventory.setup(handle_item_selection)
	
	#	post opening description
	handle_entered_room()


func _setup_current_room(room:RoomBase) -> void:
	currentRoom = room
	room.setup()
	room.location_changed.connect(handle_location_changed)
	room.room_changed.connect(handle_room_change)
	room.locked_door_selected.connect(handle_locked_door_selection)
	room.item_selected.connect(handle_item_pickup)
	room.interactable_selected.connect(handle_iteractable_selection)


func handle_location_changed(point:NavPoint) -> void:
	player.go_to(point)


func handle_room_change(door:Door) -> void:
	#	get new room
	var connectingRoom:RoomBase = door.get_connecting_room(currentRoom)
	
	#	deallocate current room data and connections
	currentRoom.location_changed.disconnect(handle_location_changed)
	currentRoom.room_changed.disconnect(handle_room_change)
	currentRoom.locked_door_selected.disconnect(handle_locked_door_selection)
	currentRoom.item_selected.disconnect(handle_item_pickup)
	currentRoom.interactable_selected.disconnect(handle_iteractable_selection)
	
	#	connect new room connections
	_setup_current_room(connectingRoom)
	
	#	navigation to new room
	var point:NavPoint = connectingRoom.get_door_point(door)
	player.go_to(point)


func handle_entered_room() -> void:
	naration.add_text(Descriptions.get_room_text(currentRoom.name))


func handle_hover_over(id:int) -> void:
	currentRoom.highlight_object(id)

 
func handle_world_selection(result:Dictionary) -> void:
	currentRoom.check_selection(result)


func handle_locked_door_selection(door:Door) -> void:
	naration.add_text(Descriptions.get_door_text(currentRoom.name,door.name))


func handle_spell_cast(spell:Spells.TYPE,collider_id:int) -> void:
	currentRoom.check_spell_interactions(spell,collider_id)


func handle_item_pickup(item:TokenBase) -> void:
	player.pick_up(item)
	naration.add_text(Descriptions.get_token_text(item.name))


func handle_iteractable_selection(interactable:Interactable) -> void:
	naration.add_text(Descriptions.get_interactable_text(currentRoom.name,interactable))


func handle_item_selection(item:Token) -> void:
	player.arm_spell(item.spell)


func _on_game_viewport_container_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	player.cursor_in_game = true


func _on_game_viewport_container_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	player.cursor_in_game = false
