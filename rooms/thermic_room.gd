extends RoomBase

@onready var navPointFreeze:NavPoint = %NavPointFreeze
@onready var navPointBurn:NavPoint = %NavPointBurn
@onready var navPointDoorS:NavPoint = %NavPointDoorS


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
	
	#	setup tokens
	tokens.append($FireToken)
	tokens.append($ColdToken)
