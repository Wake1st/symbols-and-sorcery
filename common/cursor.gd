extends Sprite2D

const WAND_CURSOR = preload("res://assets/wand_cursor.png")
const HAND_CURSOR = preload("res://assets/hand_cursor.png")


func _process(_delta):
	#	track the mouse movement
	global_position = get_global_mouse_position()


func display_wand(is_equipped:bool):
	#	switch iteraction modes
	if is_equipped:
		texture = WAND_CURSOR
	else:
		texture = HAND_CURSOR
