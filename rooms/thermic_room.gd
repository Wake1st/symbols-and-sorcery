extends RoomBase

@onready var navPointFreeze = %NavPointFreeze
@onready var navPointBurn = %NavPointBurn
@onready var navPointDoorS = %NavPointDoorS

var currentNavId:int
var navPoints:Dictionary = {}


func setup(_wand:Wand):
	navPoints[navPointFreeze.get_instance_id()] = navPointFreeze
	navPoints[navPointBurn.get_instance_id()] = navPointBurn
	navPoints[navPointDoorS.get_instance_id()] = navPointDoorS
	currentNavId = navPointDoorS.get_instance_id()


func check_selection(result:Dictionary) -> void:
	var id = result.collider_id
	if id == null:
		return
	
	for point_id in navPoints.keys():
		if point_id != currentNavId && point_id == id:
			navPoints[currentNavId].visible = true
			navPoints[point_id].visible = false
			location_changed.emit(navPoints[point_id].global_position)
			currentNavId = point_id

