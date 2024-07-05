extends RoomBase

@onready var navPointDoorE = $NavPointDoorE
@onready var navPointWest = $NavPointWest

@onready var pistonInteractable = %PistonInteractable


func setup() -> void:
	#	setup nav points
	navPoints[navPointDoorE.get_instance_id()] = navPointDoorE
	navPoints[navPointWest.get_instance_id()] = navPointWest
	currentNavId = navPointDoorE.get_instance_id()
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[eastDoor] = navPointDoorE
	
	#	setup tokens
	#tokens.append(%DeRotateToken)
	
	#	setup interactables
	interactables.append(pistonInteractable)
	interactables.append(%PistonLamp)
	interactables.append(%TokenLamp)
	
	#	setup interactable signals
	#pistonInteractable.activated.connect(some_external_function?)
