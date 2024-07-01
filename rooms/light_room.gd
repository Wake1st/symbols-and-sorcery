extends RoomBase

@onready var navigation_point:NavPoint = $NavigationPoint
@onready var doorLamp = $DoorLamp


func setup():
	#	setup nav point
	currentNavId = navigation_point.get_instance_id()
	navPoints[currentNavId] = navigation_point
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[northDoor] = navigation_point
	
	#	setup token
	tokens.append($LightToken)
	
	#	setup interactables
	interactables.append(doorLamp)
	
	#	setup interactable signals
	doorLamp.activated.connect(northDoor.unlock)
