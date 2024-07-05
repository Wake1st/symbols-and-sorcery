extends RoomBase

@onready var navPointDoorSE = $NavPointDoorSE
@onready var navPointDoorSW = $NavPointDoorSW
@onready var navPointDoorNE = $NavPointDoorNE
@onready var navPointDoorNW = $NavPointDoorNW
@onready var navPointCenterWest = $NavPointCenterWest
@onready var navPointCenterNorth = $NavPointCenterNorth
@onready var navPointCenterEast = $NavPointCenterEast
@onready var navPointCenterSouth = $NavPointCenterSouth


func setup() -> void:
	#	setup nav points
	navPoints[navPointDoorSE.get_instance_id()] = navPointDoorSE
	navPoints[navPointDoorSW.get_instance_id()] = navPointDoorSW
	navPoints[navPointDoorNE.get_instance_id()] = navPointDoorNE
	navPoints[navPointDoorNW.get_instance_id()] = navPointDoorNW
	navPoints[navPointCenterWest.get_instance_id()] = navPointCenterWest
	navPoints[navPointCenterNorth.get_instance_id()] = navPointCenterNorth
	navPoints[navPointCenterEast.get_instance_id()] = navPointCenterEast
	navPoints[navPointCenterSouth.get_instance_id()] = navPointCenterSouth
	currentNavId = navPointDoorSE.get_instance_id()
	navPoints[currentNavId].visible = false


func _ready() -> void:
	#	setup door points
	doorPoints[southDoor] = navPointDoorSE
	doorPoints[westDoor] = navPointDoorSW
	doorPoints[eastDoor] = navPointDoorNE
	doorPoints[northDoor] = navPointDoorNW
	
	#	setup interactables
	interactables.append(%SELamp)
	interactables.append(%SWLamp)
	interactables.append(%NWLamp)
	interactables.append(%NELamp)
