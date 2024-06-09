class_name Door
extends StaticBody3D

enum DIRECTION { NORTH, EAST, SOUTH, WEST }

@export_category("Door")
@export var direction:DIRECTION
@export var connecting_room:PackedScene
