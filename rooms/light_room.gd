extends RoomBase

@onready var navigationPoint:NavPoint = $NavigationPoint
@onready var doorLamp = $DoorLamp


func setup():
	#	setup nav point
	currentNavId = navigationPoint.get_instance_id()
	navPoints[currentNavId] = navigationPoint
	navPoints[currentNavId].visible = false


func highlight_object(id:int) -> void:
	print("TODO: highlight object %s in light room" % id)


func _ready() -> void:
	#	setup door points
	doorPoints[northDoor] = navigationPoint
	
	#	setup token
	tokens.append($LightToken)
	
	#	setup interactables
	interactables.append(doorLamp)
	
	#	setup interactable signals
	doorLamp.activated.connect(northDoor.unlock)
