class_name NavigationNode
extends Resource

enum DIRECTION { NORTH, EAST, SOUTH, WEST }

@export_category("Navigation Node")
@export var direction:DIRECTION
@export var connectingScene:PackedScene

var door:Door
var connectingRoom:Node3D
var connectionPoint:Vector3
