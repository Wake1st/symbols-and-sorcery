extends RoomBase

@onready var navPointDoorE = $NavPointDoorE

@onready var pistonInteractable = %PistonInteractable


func setup() -> void:
	#	setup nav points
	navPoints[navPointDoorE.get_instance_id()] = navPointDoorE
	currentNavId = navPointDoorE.get_instance_id()
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[eastDoor] = navPointDoorE
	
	#	setup interactables
	interactables.append(pistonInteractable)
	interactables.append(%PistonLamp)
	
	#	setup interactable signals
	#pistonInteractable.activated.connect(some_external_function?)
