extends RoomBase

@onready var navPointFreeze:NavPoint = %NavPointFreeze
@onready var navPointBurn:NavPoint = %NavPointBurn
@onready var navPointDoorS:NavPoint = %NavPointDoorS

@onready var fireToken:TokenBase = %FireToken
@onready var coldToken:TokenBase = %ColdToken


func setup(_wand:Wand):
	#	setup nav points
	navPoints[navPointFreeze.get_instance_id()] = navPointFreeze
	navPoints[navPointBurn.get_instance_id()] = navPointBurn
	navPoints[navPointDoorS.get_instance_id()] = navPointDoorS
	currentNavId = navPointDoorS.get_instance_id()
	navPoints[currentNavId].visible = false
	
	#	setup door points
	doorPoints[southDoor] = navPointDoorS
	doorPoints[westDoor] = navPointFreeze
	doorPoints[eastDoor] = navPointBurn


func check_selection(result:Dictionary) -> bool:
	if super.check_selection(result):
		return true
	
	if fireToken != null && result.collider_id == fireToken.get_instance_id():
		#scrollPickup.pick_up()
		return true
	
	if fireToken != null && result.collider_id == fireToken.get_instance_id():
		#scrollPickup.pick_up()
		return true
	
	return false
