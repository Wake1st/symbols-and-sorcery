extends RoomBase

const SCROLL = preload("res://items/scroll.tres")

@onready var light = %Light
@onready var scrollPickup = %ScrollPickup
@onready var scroll = %Scroll


func setup(wand:Wand):
	#	setup spell casting
	wand.cast_light.connect(light.cast)
	light.finished.connect(wand.spell_finished)
	
	#	setup interactive mechanics
	scrollPickup.finished.connect(handle_scroll_pickup)


func check_selection(result:Dictionary) -> void:
	if result.collider_id == northDoor.get_instance_id():
		room_changed.emit(northDoor)
	if scroll != null && result.collider_id == scroll.get_instance_id():
		scrollPickup.pick_up()


func handle_scroll_pickup() -> void:
	item_pickup.emit(SCROLL)
	
	scrollPickup.remove_child(scroll)
	scroll.queue_free()
