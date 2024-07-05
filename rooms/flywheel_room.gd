extends RoomBase

@onready var navPointDoorW = $NavPointDoorW
@onready var navPointN = $NavPointN

@onready var tokenLamp = %TokenLamp
@onready var flywheelLamp = %FlywheelLamp
@onready var flywheelInteractable = %FlywheelInteractable


func setup():
	#	setup nav points
	navPoints[navPointDoorW.get_instance_id()] = navPointDoorW
	navPoints[navPointN.get_instance_id()] = navPointN
	currentNavId = navPointDoorW.get_instance_id()
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[westDoor] = navPointDoorW
	
	#	setup token
	tokens.append(%RotationToken)
	
	#	setup interactables
	interactables.append(flywheelInteractable)
	interactables.append(%FlywheelLamp)
	interactables.append(%TokenLamp)
	
	#	setup interactable signals
	#flywheelInteractable.activated.connect(some_external_function?)
