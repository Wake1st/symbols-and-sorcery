extends RoomBase

@onready var navPointDoorW = $NavPointDoorW
@onready var navPointDoorN = $NavPointDoorN

@onready var boilerInteractable = %BoilerInteractable


func setup() -> void:
	#	setup nav points
	navPoints[navPointDoorW.get_instance_id()] = navPointDoorW
	navPoints[navPointDoorN.get_instance_id()] = navPointDoorN
	currentNavId = navPointDoorW.get_instance_id()
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[northDoor] = navPointDoorN
	doorPoints[westDoor] = navPointDoorW
	
	#	setup interactables
	interactables.append(boilerInteractable)
	interactables.append(%BoilerLamp)
	
	#	setup interactable signals
	boilerInteractable.activated.connect(northDoor.unlock)
