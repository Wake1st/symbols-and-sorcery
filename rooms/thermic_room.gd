extends RoomBase

@onready var navPointFreeze:NavPoint = %NavPointFreeze
@onready var navPointBurn:NavPoint = %NavPointBurn
@onready var navPointDoorS:NavPoint = %NavPointDoorS

@onready var freezeInteractable = %FreezeInteractable
@onready var burnInteractable = %BurnInteractable


func setup():
	#	setup nav points
	navPoints[navPointFreeze.get_instance_id()] = navPointFreeze
	navPoints[navPointBurn.get_instance_id()] = navPointBurn
	navPoints[navPointDoorS.get_instance_id()] = navPointDoorS
	currentNavId = navPointDoorS.get_instance_id()
	navPoints[currentNavId].visible = false


func highlight_object(id:int) -> void:
	print("TODO: highlight object %s in thermic room" % id)


func _ready() -> void:
	#	setup door points
	doorPoints[southDoor] = navPointDoorS
	doorPoints[westDoor] = navPointFreeze
	doorPoints[eastDoor] = navPointBurn
	
	#	setup tokens
	tokens.append($FireToken)
	tokens.append($ColdToken)
	
	#	setup interactables
	interactables.append(freezeInteractable)
	interactables.append(burnInteractable)
	interactables.append(%NWLamp)
	interactables.append(%SWLamp)
	interactables.append(%NELamp)
	interactables.append(%SELamp)
	
	#	setup interactable signals
	freezeInteractable.activated.connect(westDoor.unlock)
	burnInteractable.activated.connect(eastDoor.unlock)
