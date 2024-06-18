extends RoomBase

const SCROLL = preload("res://items/scroll.tres")

@onready var light = %Light
@onready var scrollPickup = %ScrollPickup
@onready var scroll = %Scroll
@onready var navigation_point:NavPoint = $NavigationPoint


func setup(wand:Wand):
	#	setup nav point
	currentNavId = navigation_point.get_instance_id()
	navPoints[currentNavId] = navigation_point
	navPoints[currentNavId].visible = false
	
	#	setup door points
	doorPoints[northDoor] = navigation_point
	
	#	setup spell casting
	wand.cast_light.connect(light.cast)
	light.finished.connect(wand.spell_finished)
	
	#	setup interactive mechanics
	scrollPickup.finished.connect(handle_scroll_pickup)


func check_selection(result:Dictionary) -> bool:
	if super.check_selection(result):
		return false
	
	if scroll != null && result.collider_id == scroll.get_instance_id():
		scrollPickup.pick_up()
		return true
	
	return false


func handle_scroll_pickup() -> void:
	item_pickup.emit(SCROLL)
	
	scrollPickup.remove_child(scroll)
	scroll.queue_free()
