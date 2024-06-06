extends Sprite2D

const WAND_CURSOR = preload("res://assets/wand_cursor.png")
const HAND_CURSOR = preload("res://assets/hand_cursor.png")


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(_delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_pressed("use_wand"):
		texture = WAND_CURSOR
	else:
		texture = HAND_CURSOR
