extends Node



func _input(event):
	if event is InputEventMouseButton && event.is_released():
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			#	cast spell (get coordinates, get spell effect, apply)
			pass
