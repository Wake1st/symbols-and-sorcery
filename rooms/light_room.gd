extends RoomBase

@onready var light = %Light
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
