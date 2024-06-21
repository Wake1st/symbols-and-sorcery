extends RoomBase

@onready var navigation_point:NavPoint = $NavigationPoint


func setup():
	#	setup nav point
	currentNavId = navigation_point.get_instance_id()
	navPoints[currentNavId] = navigation_point
	navPoints[currentNavId].visible = false
	
	#	setup door points
	doorPoints[northDoor] = navigation_point
	
	#	setup token
	tokens.append($LightToken)

