extends RoomBase

@onready var navPointDoorE = $NavPointDoorE
@onready var navPointDoorN = $NavPointDoorN

@onready var balloonInteractable = %BalloonInteractable


func setup() -> void:
	#	setup nav points
	navPoints[navPointDoorE.get_instance_id()] = navPointDoorE
	navPoints[navPointDoorN.get_instance_id()] = navPointDoorN
	currentNavId = navPointDoorE.get_instance_id()
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[northDoor] = navPointDoorN
	doorPoints[eastDoor] = navPointDoorE
	
	#	setup interactables
	interactables.append(balloonInteractable)
	interactables.append(%BalloonLamp)
	interactables.append(%NorthLamp)
	
	#	setup interactable signals
	balloonInteractable.activated.connect(northDoor.unlock)
